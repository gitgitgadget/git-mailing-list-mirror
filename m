Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BB6C433E0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 04:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82CE664D9C
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 04:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbhCNETj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 23:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbhCNETO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 23:19:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D6FC061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 20:19:14 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id r17so60751460ejy.13
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 20:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKkFuYml70tleo+awS951LGyYISGeDXg9kAsXrp2rTQ=;
        b=pe1ZfQTjIsObjnvH2MiZ3vvM3aM+JWnaOK2ksIQkYiz+X4fVZtyjg3dGbTWnHPryKV
         7wh96BaCdX9e7vlxZjHzlGcS18ZrQhvG0vhtKu4UmA1jAG62sODfpmsKJNtW+rkm7mi3
         aSR0iARSv+WHk0bE9+/7sTkSRC3x1WF1oQejCuN7ajq7SxyH7e3gWjIsft5FrQZl+a6q
         T23HCt55olFJZ18WCV/qsS4dLBgwW8N+yGt6oCoLLFA0x7xQ54MzCtYvul0iRN0K3m4Y
         XneRGbim4geNgyjqDGXRQa7hGQAq3n3IF0cFxMIcgm1cibd5mSgzK3W6tT9a3sPoN8Ch
         261w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKkFuYml70tleo+awS951LGyYISGeDXg9kAsXrp2rTQ=;
        b=aL0p4zkdi/7mMcEpJt66s5IKiGM+ayj53H7whHgyMXIyYNYU074CL+dfWbCxYNlQxP
         5j3SrN+JMwQwEpcbcSoO6LIM5SBJwHkcHkh0nunetpv2DEgEvXsSH8iFedBMYXx0dxEN
         jC90skL4MQJHMQ2XPaq5nRX/NykrJlFtesfX+/iqy0b2SlZBEp4+z61morlv0WGJUBWu
         kEcJHTQgceVWYKwicvYx0vxG1vAN0nTg6/8BZyuQ5rczShql9xhdew6PDEV9RhLhLHOT
         0QsWzJzArIECMXXd8Saryq67fsii96z/z95LOTWvCGV3AgBEy7AGzWC6lfBJuUSZ+9EK
         2EBA==
X-Gm-Message-State: AOAM532qZ+/KM3UZmnhkkJyspTQ2kOXfYRZi+WfaVuMYwrx+U7I490bF
        qWJWf8fHSuZg2J7GPL7oyINOcQgk9k4EjYFX6Rs=
X-Google-Smtp-Source: ABdhPJyG+Eu9WcwI3DB752FVMFiorVcjoGdJExMatkzeOpIyjNjzXr36yqLlF4ajzqRUvKIZWClPbSxB2MlbRFsvoAk=
X-Received: by 2002:a17:906:86c6:: with SMTP id j6mr16303376ejy.197.1615695552889;
 Sat, 13 Mar 2021 20:19:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.901.git.1615446968597.gitgitgadget@gmail.com> <pull.901.v2.git.1615564478029.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v2.git.1615564478029.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 14 Mar 2021 05:19:01 +0100
Message-ID: <CAP8UFD2_SSza-zsoqS_ugQBryiTvm0PqzrJDAuriT2jmjHM-uA@mail.gmail.com>
Subject: Re: [PATCH v2] [GSOC] commit: add trailer command
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 4:59 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> Historically, Git has supported the 'Signed-off-by' commit trailer
> using the '--signoff' and the '-s' option from the command line.
> But users may need to provide richer trailer information from the
> command line such as "Helped-by", "Reported-by", "Mentored-by",

Nit: not sure that "richer" is the proper word here. I would just use
"other" instead.

> Now use `--trailer <token>[(=|:)<value>]` pass the trailers to
> `interpret-trailers` and generate trailers in commit messages.

The subject says "add trailer command" while here you say "use". So
which one is it? Does "--trailer" already exist, and we are just going
to use it? Or will this patch series actually "add" it?

Looking at the existing options and the code of this patch series, the
patch series actually adds the "--trailer" (not "trailer") option, so
"add" or "implement" would be clearer than "use".

So maybe something like the following might be better:

"Now implement a new `--trailer <token>[(=|:)<value>]` option to pass
other trailers to `interpret-trailers` and insert them into commit
messages."

Also something like "--trailer" is usually called an option (or
sometimes a flag), not a command (especially not when the word is not
a verb, and when the new feature isn't a new exclusive mode of
operation). So something like "commit: add --trailer option" might be
a better subject.

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     [GSOC] commit: provides multiple signatures from command line

It looks like this is using the subject of a patch that previously
attempted to add features with a similar purpose. I don't think you
need to put it there, or if you want to refer to it, I think it might
be better to be a bit more explicit, for example like:

"This patch replaces my previous attempt to provide similar features
in a patch called: [GSOC] commit: provides multiple signatures from
command line."

>     Now maintainers or developers can also use commit
>     --trailer="Signed-off-by:commiter<email>" from the command line to
>     provide trailers to commit messages. This solution may be more
>     generalized than v1.

Ok, I agree that it's a good idea to have a good generic solution
first, before having specialized options for specific trailers.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-901%2Fadlternative%2Fcommit-with-multiple-signatures-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-901/adlternative/commit-with-multiple-signatures-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/901
>
> Range-diff vs v1:

If this patch series has very few code and commit messages in common
with a previous attempt at implementing similar features, it might be
better to make it a new patch series rather than a v2. This could
avoid sending range-diffs that are mostly useless.
