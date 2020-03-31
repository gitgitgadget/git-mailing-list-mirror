Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D53C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 22:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B8720714
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 22:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7oeo5Ey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbgCaWyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:54:25 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:42100 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgCaWyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 18:54:25 -0400
Received: by mail-vk1-f193.google.com with SMTP id e20so6178432vke.9
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 15:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ttOUKBFYoLuVZDYCcCOIy8JOSTNJl+3xgvAuNXPxVjI=;
        b=s7oeo5EyLMlNDYdZ09Z3Yg5uw3jUPF2zLYVi3hJsttBUNH7QHAp7SyWUeQbx1HkxEG
         pxS65BymYAAkhz5aOy8E5jVNBGxfwOjL7H+lGcLvJ4/bwvgMefe3P5IAOAHr8Dhq80cS
         PcaPJlDR4QAcZqIhldJIte0ifUs9et/CMbVw+akEEvev44WFvCGpXRHqyPwKSes7QxmQ
         2jYu7SQSwRXTdvF4VGERDTVpN15Tv71A7jf9ZV81AtJXd4xnEy5iHjQl8TDojYaeV7my
         tWDcREKSe9ztfnE7Czq210esWGL7nVjVHpVsBVETxE93fPIBOKOWwjhEnZshhrVO4xYS
         6OPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ttOUKBFYoLuVZDYCcCOIy8JOSTNJl+3xgvAuNXPxVjI=;
        b=VKq6/W41bV70wrVxdSWEnigLRR/KIq41ClvgbfXJxZnQyVecAcNLaGfSSVbXHm1Mwk
         DxOsb9rQB8abqYq6cEyHEjoz+q+DeBHMvgWzue0XK6Ap7a28QQ/YKYfOB6XICD1r1YXI
         WeWIIxOGj2mNF9L4hrbROl5TBoA/KVac/AMClChOA3pDOobYqXmYfSYsj/7zIxbFB2sQ
         9uWi/my7GfdZmiQDhTgiKQJ1r5f1Yah77wzZVAy8TDSGBUflYOkKN+x0ILQLMllY2Pnf
         cmMLkIYgYHKcEvwLQhmkZ+PZFGP5F6OhJ+TpYv79uMiYrcz2zS2Ka4RLtZ+taArOXmAZ
         hkDA==
X-Gm-Message-State: AGi0PuZ3RDhTYGToPQWHfi5zZbXFSBXy4Y4knBIcog1vW4j/mvqyzJPp
        pmF0LfoE+HJk8Fq2WVplvOozR9KkXncU0kR7oxM=
X-Google-Smtp-Source: APiQypL3G8BBfmFDg3kwsgbACKiGNCadq8LG/zVeZ9NB7Hkqjb3sZ0Ia229fHa9A1e5lnK5upY8j5Rt5Zhrm39VbD7M=
X-Received: by 2002:a1f:2706:: with SMTP id n6mr14226894vkn.88.1585695263535;
 Tue, 31 Mar 2020 15:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAMP44s2XuXrgBztke50YgnZ1SQh6gvR6cdLz064xDDK3+s2CSA@mail.gmail.com>
 <CAMP44s1oKq3hf+dRyQjc+yOs3xesq5qn5UaJJ_0i-KYrXCeodg@mail.gmail.com> <CABPp-BG6QQV5aMbrUhB+mCU_fErwLY5uYHzi6DKV5jkPd1p8DA@mail.gmail.com>
In-Reply-To: <CABPp-BG6QQV5aMbrUhB+mCU_fErwLY5uYHzi6DKV5jkPd1p8DA@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 31 Mar 2020 16:54:12 -0600
Message-ID: <CAMP44s2FT07h1rGffP59U_8663Y1SM+dJ4mMaU7k2MjHmeTJFg@mail.gmail.com>
Subject: Re: Regression in git ls-files, or bug in completion?
To:     Elijah Newren <newren@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 28, 2020 at 11:22 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Sat, Mar 28, 2020 at 6:25 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > On Sun, Mar 22, 2020 at 5:39 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> >
> > > I noticed a possible regression caused by commit b9670c1f5e (dir: fix
> > > checks on common prefix directory).
> >
> > > Before it was "empty", now it is "./".
> >
> > I guess you don't care about this regression.
>
> Sorry for being slow to get back to you; it wasn't that I didn't care
> (I marked the message as important to return to) but that I was
> focused on 2.26 regressions and other fixes I've been promising for
> months.  I'm working on a fix for this 2.25 regression, but note that
> it's going to depend on this series:
> https://lore.kernel.org/git/pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com/

I see. Please let me know when you have something ready to test.

-- 
Felipe Contreras
