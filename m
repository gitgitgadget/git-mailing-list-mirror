Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C71C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 17:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2223C206F6
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 17:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI86UUAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgC1RW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 13:22:59 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36684 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1RW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 13:22:59 -0400
Received: by mail-oi1-f196.google.com with SMTP id k18so11814654oib.3
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4nunH0M822Qc1S5w8nZL6AHbQlWTVdf8Yh9iBX6ZOg4=;
        b=mI86UUAeilugl4lxV0Izc1Xl1EtWOum00KAnZmF0cktwCzt/Fc6moOnuwuAhoKj5Iu
         K3VKL2omnpfc7ZmIms3QunU3pxnwCXh3q9IQusqVKon+kHQ6p7zfwE+Qlec67WlncCmW
         GQZnfy0aMM/OrTEc2yjrXKgTQrJKYw2R9OKB2AnC/1frexHxpdAuOlkB1MadlrE5u72+
         151rXAy7DHGjyfG96btLayLqh0TTXNGbTvLaNyBLKYV4jqbSmhpaGriC6J4z4vvo2oDT
         /F5+XRtcrIZK7DFBYbWec2f/6DqP7A4BswOkfjnpuPVBhUm5rXfk3sHKrJTVRrNgRef2
         sHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nunH0M822Qc1S5w8nZL6AHbQlWTVdf8Yh9iBX6ZOg4=;
        b=DsPN4MKHCcjMcYgoYYFWYft7ipr09iNXpOB/WPcuow1NsY8GPqbPQTSPPkaM6LHhnW
         RYcpr8LQMDMC/wUBdaOoqteeM6SX5sWAVcRO/P9zbo7v2GPlpD7vppun86xs0TFboTeB
         ZHXwF0BNfvn+anh6tuilWOFN+LRc4S4T0onD2JMfWLhUewQNeGZ8yHxf9YZsHqikFx3v
         dL6Y+P0tQLgm1g7YU6ztNEriUOV2yOFdFAgq5jp/GMsfHk9TpcNfdzah6n8bOhKpoIBb
         14SJvhPPozcndkwCnpI6bOavatMv/eqiVsuDzNobZdRTCHRho2N3/qN6WvtqdxeybOuq
         t/8A==
X-Gm-Message-State: ANhLgQ3ePSuDLMXVwFe/JqOcbWw8wfTCGnvbazgjMK2lvNjv3siZv+74
        pl30p7Bew2afsLxDiwr526nf6DYLs1nctgF2kueb9Mq9yAo=
X-Google-Smtp-Source: ADFU+vt6MbvJGb8F435PnLiRMtGhFYe3al8NHa5cZJLf2+t2Pnro3eBcQZQKB+2JAC7yqsx3WKGQkdY/mWeYTkyoPX8=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr2952179oig.39.1585416178346;
 Sat, 28 Mar 2020 10:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAMP44s2XuXrgBztke50YgnZ1SQh6gvR6cdLz064xDDK3+s2CSA@mail.gmail.com>
 <CAMP44s1oKq3hf+dRyQjc+yOs3xesq5qn5UaJJ_0i-KYrXCeodg@mail.gmail.com>
In-Reply-To: <CAMP44s1oKq3hf+dRyQjc+yOs3xesq5qn5UaJJ_0i-KYrXCeodg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 28 Mar 2020 10:22:47 -0700
Message-ID: <CABPp-BG6QQV5aMbrUhB+mCU_fErwLY5uYHzi6DKV5jkPd1p8DA@mail.gmail.com>
Subject: Re: Regression in git ls-files, or bug in completion?
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 28, 2020 at 6:25 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Sun, Mar 22, 2020 at 5:39 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>
> > I noticed a possible regression caused by commit b9670c1f5e (dir: fix
> > checks on common prefix directory).
>
> > Before it was "empty", now it is "./".
>
> I guess you don't care about this regression.

Sorry for being slow to get back to you; it wasn't that I didn't care
(I marked the message as important to return to) but that I was
focused on 2.26 regressions and other fixes I've been promising for
months.  I'm working on a fix for this 2.25 regression, but note that
it's going to depend on this series:
https://lore.kernel.org/git/pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com/
