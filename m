Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8D7C47083
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 11:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E489B6142E
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 11:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhFDLj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 07:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFDLj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 07:39:57 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71037C06174A
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 04:38:01 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id f12so11163026ljp.2
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 04:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gPeMtLArIZJ1AQX0ZKMHYm6+kaNnnS5eOAKyyxcg5So=;
        b=OvRlhaKxvtcYwth0HMk/4jXhygwE3Ls3c8SW27PZ46qaKWIPyTBqPBsWBAgI4N7rM4
         4pxnMP4D9CJK7scFk4Yt9CaDriv57WbFoed3tM1CeMPiLua5vprYLcT6nYJLKC4rQ1fX
         qAL3bSp0GnxRxkDqAn4SGsok5ryFp4dN5tXmb8PcHMoNXkO48zyeVPPTtSDVzgo3AoZw
         ocieLr7SHSnDgv7hLO+WBisnLlD7rPzwF8AxfYQdtpxTPtBnIfEDC3r9Ognvr30yn0aH
         cxunDY46RTK29+MWBbF1jVoETvopXfedBLUOE/aVuRnsJHNXvKGBFcKLs6+KzugaZX7w
         HBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPeMtLArIZJ1AQX0ZKMHYm6+kaNnnS5eOAKyyxcg5So=;
        b=WMUyUlum5qlj26NamjB0EHRe3qW3fpt2cS0VMUh7Jc1x2HinsehBdPCTMYZOEiFFkS
         ERHnQWstJw9qPxmevBfH4VLPov++Vj0b70JPUXstUxpMvckmv32yYtYRBVzqi9UevSPl
         NbM8A4GUpIEoCjmgA5NBZM2i947bhrimjJ0VRmjuPxdKaZlXCvg3Emoo7Qxc5GVhZk68
         IjE4GNrvZfzhaiyj5Q5DZun0ebEDXiXULUppS0z4DKmIq7WaAifbsyhwxJeHMJqKq2ud
         drnMHTl7sC6gOKatH4fkEfAdmQB82UHEVyoiqXprerJfS/m13UquWxhoFKpKVb8zwNN7
         BGTA==
X-Gm-Message-State: AOAM532SYWmgt02JJkD4oh8sjo3KyBl5ATCQCteDqaT4X2Agwc0UABSO
        xaSndLAsM09kjV77FX/7MP8UA0PqQCKT/36wH5A=
X-Google-Smtp-Source: ABdhPJxhQtQhyeeSKG9V6uorg03mDD7br7Yr/lvdX/3RptPF/8p85ukdyboOnGpNYR0mvqocsxdsy5hHuUxpmPB0Ki4=
X-Received: by 2002:a2e:390a:: with SMTP id g10mr3179964lja.80.1622806678548;
 Fri, 04 Jun 2021 04:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210528081224.69163-1-raykar.ath@gmail.com> <20210602131259.50350-1-raykar.ath@gmail.com>
In-Reply-To: <20210602131259.50350-1-raykar.ath@gmail.com>
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
Date:   Fri, 4 Jun 2021 17:07:46 +0530
Message-ID: <CAP6+3T1hN5mvWBe9-hziw=XGOugJ3ah=LVEDwOM5XY2uiZPkOQ@mail.gmail.com>
Subject: Re: [PATCH v2] [GSoC] submodule--helper: introduce add-clone subcommand
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva!

On Wed, Jun 2, 2021 at 6:43 PM Atharva Raykar <raykar.ath@gmail.com> wrote:
>
> Let's add a new "add-clone" subcommand to `git submodule--helper` with
> the goal of converting part of the shell code in git-submodule.sh
> related to `git submodule add` into C code. This new subcommand clones
> the repository that is to be added, and checks out to the appropriate
> branch.
>
> This is meant to be a faithful conversion that leaves the behaviour of
> 'submodule add' unchanged. The only minor change is that if a submodule name has
> been supplied with a name that clashes with a local submodule, the message shown
> to the user ("A git directory for 'foo' is found locally...") is prepended with
> "error" for clarity.

It would be better if commit messages are limited to 72 columns
(characters) per line.
Though you can obviously write longer lines on the list no problem.

> This is part of a series of changes that will result in all of 'submodule add'
> being converted to C.
>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> Based-on-patch-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>


I and others before me used to sign off the previous authors using
'Signed-off-by:'. This trailer
has not been used yet so I am not sure if it should be used though I
prefer this over the former.
Maybe Christian could comment here?

> This is part of a series of changes that will result in all of 'submodule add'
> being converted to C, which is a more familiar language for Git developers, and
> paves the way to improve performance and portability.
>
> I have made this patch based on Shourya's patch[1]. I have decided to send the
> changes in smaller, more reviewable parts. The add-clone subcommand of
> submodule--helper is an intermediate change, while I work on translating all of
> the code.
>
> Another subcommand called 'add-config' will also be added in a separate patch
> that handles the configuration on adding the module.
>
> After those two changes look good enough, I will be converting whatever is left
> of 'git submodule add' in the git-submodule.sh past the flag parsing into C code
> by having one helper subcommand called 'git submodule--helper add' that will
> incorporate the functionality of the other two helpers, as well. In that patch,
> the 'add-clone' and 'add-config' subcommands will be removed from the commands
> array, as they will be called from within the C code itself.

Seems like a good approach! BTW, if this "extra" message is a bit long
like the one above, then
you can put it in a cover letter instead. If people really want to
read this extra information
they will read it in a cover letter as well.

Just supply the '--cover-letter' option when executing the 'git
format-patch' command.

> Changes since v1:
>  * Fixed typos, and made commit message more explicit
>  * Fixed incorrect usage string
>  * Some style changes were made

To save yourself the trouble of sieving the "top" or "noteworthy" changes from
the new version, you could instead just print the 'range-diff' between
the two versions.

You can do:
'git range-diff b1~n1..b1 b2~n2..b2'

Where:

- 'b1' is the first branch; 'n1' is the number of top commits you are
taking from 'b1' for
  comparison.

- 'b2' is the second branch; 'n2' is the number of top commits you are
taking from 'b2' for
  comparison.

It will print a very detailed output showing what differences were
there commit-wise
amongst the two branches. This can be put at the end of the cover
letter. Though, this
isn't necessary if your way seems better to you.

BTW, it would be helpful if you could send mails addressed to me on my
other email <periperidip@gmail.com>.
