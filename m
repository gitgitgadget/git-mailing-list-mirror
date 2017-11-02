Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB2720450
	for <e@80x24.org>; Thu,  2 Nov 2017 10:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755146AbdKBKrP (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 06:47:15 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:47273 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbdKBKrO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 06:47:14 -0400
Received: by mail-pg0-f43.google.com with SMTP id r25so4722060pgn.4
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 03:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fdceUNcMpY1WDEyHhxa3z5EWJ9iRcvQfAKy2g4DNsyA=;
        b=SNOILgIIRGTmVBBKaSjyi/J3lM3u6oio8pSJ4SSiAr/GpHvakMeIk2lJnR338QJBIN
         +6PWbSBwruIvOi5fKqG1CWe2i5uhU7U+tdXthOAeci74XnY9SJQkhRD89c2nlgdVUWbo
         YF4/Ajxx9fts3xG/TJg9fA+hB5eOjaurHLI5QVTwTRxe+JsLUEefeP5PYKNmBzG/iIeM
         i2kmxyFUJMKS8PtJ4VT5VE0R7VBlwWT9GD6CaM3KMd1QUIiAk9GmrbDmh3gLC4RPziqW
         P0yLtC00wlhr9jm1jBD0f/gvmcEcKLzhaSsSyCf28KzMKJbKkMmY2Hd5eVzyvCMX9woz
         s5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fdceUNcMpY1WDEyHhxa3z5EWJ9iRcvQfAKy2g4DNsyA=;
        b=cvAXVpK4LfX7NzduLaK9nESMmoaAiTAtaHjjRp7n7XjhAH/ZvQgE+adMyBchaHMqzC
         AFSPKqzvjdPUuA1Xby6M6aGS9dRsZBXWlCj5nQynW+Zkwq0+2eFnbXtnKkwRK1OVt+Fi
         TgDo7cSiNMcHsDs6rdQtxXYUKNFTAHnsY0DCYDWO2wnapyVKejXkCPRsgSsZGItvk/5Y
         qW263J8lbtnaMEYuzYfL7EnH6YqN/lqxkk6iY3YotV1VuAhRKi367w8Se7SwAPg6MsXt
         qO5VrdUbm7odkgdatA44sh5Key9/w+Nfd37p9iKj3pUwXBY6qOx8DdIf2lDxHhJAy6LB
         zq1w==
X-Gm-Message-State: AMCzsaW4t6RJQL86S9ii1ZLpqwMa6HNwtWJMowHh9W0WoLWcHxOdUZ3J
        vF+1IPOF4fVdTsqkyfKgKaQcqJF1CIATECSZoPQ=
X-Google-Smtp-Source: ABhQp+TPeeanfwYVPDzdlhWoDdwmm6Mk9Bv6seQeNrAeFFLwANidXVoGqTC4e6KVzoohLEN3x4JJj4LNQHyalifu2LQ=
X-Received: by 10.84.136.135 with SMTP id 7mr2822403pll.392.1509619633842;
 Thu, 02 Nov 2017 03:47:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.177.141 with HTTP; Thu, 2 Nov 2017 03:47:13 -0700 (PDT)
In-Reply-To: <xmqqr2thqnzw.fsf@gitster.mtv.corp.google.com>
References: <4795556016c25e4a78241362547c5468877f808d.1509557518.git.martin.agren@gmail.com>
 <xmqqr2thqnzw.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 2 Nov 2017 11:47:13 +0100
Message-ID: <CAN0heSoBeG_8zLwS-71_ZVBF-HsVGKY1W1QiTSQ_ybwWCPauog@mail.gmail.com>
Subject: Re: [PATCH 1/3] bisect: fix memory leak and document `find_bisection()`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2 November 2017 at 05:54, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> `find_bisection()` rebuilds the commit list it is given by reversing it
>> and skipping uninteresting commits. The uninteresting list entries are
>> leaked. Free them to fix the leak.
>>
>> While we're here and understand what's going on, document the function.
>> In particular, make sure to document that the original list should not
>> be examined by the caller.
>
> Good.  Thanks.
>
> I notice that this has only two callers and both of them do
>
>         revs.commits =3D find_bisection(revs.commits, ...);
>
> I wonder if updating its calling convention to
>
>         (void) find_bisection(&revs.commits, ...);
>
> makes sense.  This is obviously outside the scope of this patch.

I think it would. I considered it briefly but punted, though I don't
really understand why now. In hindsight, it would have saved me some
work, since I wouldn't have had to carefully document that the original
list mustn't be examined. I'll let this simmer for a few days in case
other comments turn up, then do a v2 with a preparatory patch that
switches the calling convention as you suggested.

Thanks.
