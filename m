Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5273C4361B
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 01:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC8B2336F
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 01:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405160AbgLLBJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 20:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgLLBJY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 20:09:24 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6EAC0613CF
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 17:08:43 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id g185so10175561wmf.3
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 17:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wf62gXgvqGsPxvgFE3TVxUqzMy+mP5FWm0U4lPXYPjU=;
        b=L+0ea99FsT3HujEoSyOQS+Rur/ItMnI75BSk8oxUB+JYRHjg9HcrfbrMcPiVlmAtwl
         ikgHxO3R1j4gR+IIUTaGXHA1fd/k14E0IuBP+Oru3gBf/QdzomR4tS3/C4r0k82gg+KY
         WCyineuxogBFILc4vEBUeswxdrXsp7dAEp/sZnl1XaRSSEHyy1duQcVCCahzw0KRaE7+
         7VRZ8UF7f2MLiPQ2ekUgLSxGjfqmq7DY/STl2+5pdG1tohtgzvxgWQ53jg4Fs4OuEABf
         PKvOSdMdcZsi+ldO0qKR8GVdCd3kl9VCnzWA81ODDHNnLoNiRL/gOqy/Kyv8R//PxcH2
         TftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wf62gXgvqGsPxvgFE3TVxUqzMy+mP5FWm0U4lPXYPjU=;
        b=ll2ispLXd3Hiu5ByHxCvaFNEBa+4ZZGk9gHYysg3TVsY7aNcBiwaQwdPBin+vDVmaw
         qgV/D3Ps202JWYdDUPcofUyJmIi+YEXfHesVYPS2wahhFx256CNlkEPuV00d+gNs4pjo
         dTu0+eRucrG3KDxYf1bhPxmqXGyoe7eTrAh2XnfnVubK7wvZNFwY3xN1xpE7mq1aZrKt
         QlqBVR8ppw+aPqH1cjNx9u1uAuoIpUGKGAHr/C/6SPKGpA6p7qr8EmD7Gtmx7gHXDtSq
         bORxiSP1T11/cSIjOD/wqltI3yk3KB7vTTzEkMZynA1OE4Wdhu3AuJHSmZmqp+UWxQrv
         fWww==
X-Gm-Message-State: AOAM531kmAIq8u0EQJ4rVY8fbdrvtWswzD+iNszNesw4b3AnwnYoVPx5
        W8g+bc5WHQB2qoYinrm+tjR8ddzy1QP8ONmemUw=
X-Google-Smtp-Source: ABdhPJxSp92rCsdUY2k7J5nO0cI92U1BELJBjVBKpLBIn/LoDzaqRNXNMiTqfYPsH2/fVRxyDBgiPkAphJHMnszb3ag=
X-Received: by 2002:a05:600c:210e:: with SMTP id u14mr16427480wml.48.1607735322459;
 Fri, 11 Dec 2020 17:08:42 -0800 (PST)
MIME-Version: 1.0
References: <20201125020931.248427-1-alexhenrie24@gmail.com>
 <20201125020931.248427-2-alexhenrie24@gmail.com> <xmqqmtyviq9e.fsf@gitster.c.googlers.com>
 <CAMMLpeQA7VW_C4yw_8n6j_SCoGr8k4VUOUaEp98UxUAMR6-MVw@mail.gmail.com>
In-Reply-To: <CAMMLpeQA7VW_C4yw_8n6j_SCoGr8k4VUOUaEp98UxUAMR6-MVw@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 11 Dec 2020 19:08:31 -0600
Message-ID: <CAMP44s299UcdutpkSZsKFiwxUfj7n4SXTHw7A8rAWPS6iDJacg@mail.gmail.com>
Subject: Re: [RFC 2/2] pull: default pull.ff to "only" when pull.rebase is not
 set either
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        "Raymond E. Pasco" <ray@ameretat.dev>, Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 11, 2020 at 2:38 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> On Wed, Dec 2, 2020 at 7:21 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > So, the idea is that we currently return NULL when pull.ff is set,
> > but now we also check "pull.rebase" etc. and give "--ff-only" when
> > we did not choose --[no-]rebase and lack the configuration.  So the
> > default (i.e. when pull.ff and pull.rebase are not set) would be as
> > if the user said
> >
> >         git pull --ff-only --no-rebase
> >
> > I am not seeing what problem this tries to solve, exactly, though.
> >
> > I would have expected that for those who did not choose between
> > merge and rebase (either with the pull.rebase configuration or from
> > the command line --[no-]rebase option) the command would behave as
> > if --ff-only is given, regardless of how pull.ff configuration is
> > set.  That way, those who are unconfigured will just follow along
> > what happens at the upstream, until they have their own development,
> > at which point "--ff-only" can no longer be satisfied and their
> > "pull" would fail until they choose how to consolidate their work
> > with the upstream.
>
> My goal was to make `git pull` without arguments and without any
> configuration set (the most common case) reject non-fast-forwards,

This is what we all want, in my opinion.

> and not add any new config variables

But we need first to give users the ability to test this new mode with
a configuration variable.

It's how we get there that we disagree.

> In my opinion it's fine that setting pull.ff
> would change the behavior of `git pull` without arguments; I don't
> think that that would be bad behavior.

No, it's not bad behavior. But we need to warn our users that this
change is coming first, and how to try it out.

That's what I think.

Cheers.

-- 
Felipe Contreras
