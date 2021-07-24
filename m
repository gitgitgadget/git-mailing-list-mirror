Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385ADC4338F
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 21:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11F2760E90
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 21:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhGXUnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jul 2021 16:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGXUnA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jul 2021 16:43:00 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C23AC061575
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 14:23:31 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h10so6312226edv.8
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 14:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=dGwhyRZFqw/ZM5BwQ9PSNSMFSuXMdn3pc1nF4oFyvlc=;
        b=Q4L6rrUirPSVmECB5UWIY1F/vCWzobxVFvWt1lNeLO2jfCpmire8Y7Mg0dtCJVZZxQ
         d8fXbmqcnrQ3aZIuRQLyWzPHOlSd+U48WbhQzs6askhBWBUri3gm3U7HRrGPRNNGfzh4
         06IGdMK0HwUQwa8qKOp2ZxPiF4lhBWWe3ZbYioJ2fMs4UkEWsqMEa6x9x+9EW0DF0Ssv
         bTfT65cUUifVcKpzrYMkrAYIHGvBFbacGQ3dQKRocdvvRSFplRcpHkPBn9m6tuLuaBFa
         rPfghdjm+ZLA275KBo5PYaCBmyRX0OLh7UIyD7Fs53PEJYNCb4qD+ClIl1iwOfc2X63j
         bzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=dGwhyRZFqw/ZM5BwQ9PSNSMFSuXMdn3pc1nF4oFyvlc=;
        b=OariK0GHSbRbqsWH14OiAXYs32qk4BTJCdOr0Do9kYzy1qB0uaej0lzwjsJHcinyY+
         ruBOOWlCX3n4WZCqepr8tK5zQXK9jDPkAFUxi8kahh33cae5fZIT618x/mJR4aKMLyAa
         4IkRQfaaRx5usrwov0Vv3lJKNqmhXIvJhyzOUHOVvfOUiHWDRBqD455132kXoE4Im40V
         MLFPOrX9/dsQ9VtE2Jc5GMbWCIXKohxxI2DjTGs3oTw/SohIpgTZMI/4NMwld2aZSOu5
         EweHrhsEaLlilKm/vc1FzFaCUHXj8Hy1iDk87V/VnnftLhxl65i0JlFk25k1qS/I+l0S
         gFUA==
X-Gm-Message-State: AOAM530ES/phV606HwBbfC2RR+0FZSaidvGwfvJpbgpulZ+WsfYUeQ21
        ydtuVCfEQCfz43iUbkMdNIf7p/9NoC0=
X-Google-Smtp-Source: ABdhPJxwChVCjyyhpIY4lfg1B9GbUuNkLaVl8OC2OqBtljp2TwdqGAOT9g/xh0EYTfmBLy5tkjEDzA==
X-Received: by 2002:aa7:c801:: with SMTP id a1mr13120063edt.293.1627161809861;
        Sat, 24 Jul 2021 14:23:29 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p18sm16570935edu.8.2021.07.24.14.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 14:23:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Subject: Re: [GSOC] How to improve the performance of git cat-file --batch
Date:   Sat, 24 Jul 2021 23:20:46 +0200
References: <CAOLTT8RR3nvtXotqhSO8xPCzGQpGUA8dnNgraAjREZ6uLf4n4w@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAOLTT8RR3nvtXotqhSO8xPCzGQpGUA8dnNgraAjREZ6uLf4n4w@mail.gmail.com>
Message-ID: <87im0zs8wn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 24 2021, ZheNing Hu wrote:

> After reusing ref-filter logic for cat-file --batch, the function of
> cat-file --batch has been enhanced,
> but the performance of cat-file is severely degraded. So we need a
> better solution to solve it.
> its last version is here:
> https://lore.kernel.org/git/pull.993.v2.git.1626363626.gitgitgadget@gmail.com/
>
> Use google doc to show some of my recent ideas:
> https://docs.google.com/document/d/1hyM-ecMd8C_TJ3OsOn46nMr8ZxCUxeK7HKj-bRkq3sk/edit?usp=sharing
>
> Anyone is welcome to comment and suggest better solutions!

Having looked at that Google Doc it seems to just discuss "Plan A", or
there some multi-doc magic and there's a "Plan B", or...? I'm not very
familiar with Google Docs.

Anyway, I'd encourage you to just send this as an E-Mail to the mailing
list.

Having skimmed it I'm a bit confused about this in reference to
performance generally. I haven't looked into the case you're discussing,
but as I noted in
https://lore.kernel.org/git/87im1p6x34.fsf@evledraar.gmail.com/ the
profiling clearly shows that the main problem is that you've added
object lookups we skipped before.

I think any plan to improve performance should start with a perf test,
see which of your patches have performance regressions, if some don't
and are otherwise OK perhaps those can go in earlier.

Then we'll have the smallest possible set of changes that's correct, but
introduces performance regressions, and can look at what those are doing
to slow things down...
