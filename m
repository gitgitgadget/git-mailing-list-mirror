Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF04C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996CC61251
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhJUWWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 18:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhJUWWG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 18:22:06 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3D8C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 15:19:49 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f5so1521686pgc.12
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 15:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=W7VH4YaDlOOVwR0xKwelm8P5oHnRn53W8DgREabwk0k=;
        b=TZss/1PYMmAQVqGKwmgu0xXKvvwTdELrupKRqm9fz7CSMRZvWxYdNISpZ8Qa799xzM
         zg9iDCY380P97baTdUzIFwT3k2RtFXv26gGcYO26tSUtKQ28kVA4EieIAP9GD25uymZL
         7gZ2eEeA442jhltWjAjvvBCkr1Wkl1jErNMRLUSBc+wzVYVMTbxNqDKcBiDxLL0bxLyM
         lvQO+zvddOH7DuEKGF6stLPNgM3w4GpRUCqG6kR5+tONyHtwkIlnNlCQ8seifnwco7Xy
         dIsPSNfHT6/5Un9MkQ77oNVrVzGa3wZ3FvnoMPq5yC0bDUwR8+3FUwoLaWmdYUbchOlZ
         szlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=W7VH4YaDlOOVwR0xKwelm8P5oHnRn53W8DgREabwk0k=;
        b=o6nEAZLdc6H6WOOoxlp2svidt33LRZoDp/qYbQDc6yQEm33uE86mZrk7+p8WVEY/ak
         KdsUoE+BtwmVNinxG4HNY+zYjdSGhej9dbij/WpePvAt7wZPYo6RXL2Yn0hP3KgisjEw
         F7UIu2Wki141TsqhEn9Pm5c00Mj6ggC8vBupu88eIRuIL7kUDCtzDOca+Bt7YFClIdNC
         uFnaqRcu0y5szXczoX68UeT1U5chBd8WMi4yzCVLTdW9frB/+E270f5A0MekxLITIAYV
         Fnls0L2SsBnjdaxx58Ng2np/iF0BoOz75DTniDcK0ARG8weWAYWtE54l6CAqh6c0BpqB
         DR+g==
X-Gm-Message-State: AOAM532xfqVp3N0WaoXBdiqA8K7hnlgwJwXXQ+17QHOCwP5fO2WtN7Bm
        9x7/671z8ilamtnwgun2ihusI1cS6c+UM1fe6EGoads+2OI=
X-Google-Smtp-Source: ABdhPJwgUJBrdOCIb7HhFDDhZlfpy+ihI77q83DAolRai/CfvSkw2k262Smjd4yxDfYxLuQUEbM5cYSeJnkgc0j4r2c=
X-Received: by 2002:a05:6a00:14d3:b0:474:2444:510c with SMTP id
 w19-20020a056a0014d300b004742444510cmr4589537pfu.13.1634854789137; Thu, 21
 Oct 2021 15:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <CACYzLDcFjwaJkgVUemD_KqkoGhV_5OYrECddDuxa-o5FpZ6XMA@mail.gmail.com>
In-Reply-To: <CACYzLDcFjwaJkgVUemD_KqkoGhV_5OYrECddDuxa-o5FpZ6XMA@mail.gmail.com>
From:   Timothy Eccleston <timothy.perisho.eccleston@gmail.com>
Date:   Thu, 21 Oct 2021 15:19:38 -0700
Message-ID: <CACYzLDcO4OATYYZ6AtJnJTKS9EKUKNRJY5_Rb=y62gWFFwoDhg@mail.gmail.com>
Subject: Re: Unified workflow for `git add/checkout --patch`?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I really like both these features:
- git add -p
- git checkout -p

My typical workflow
I like to use them after a long and complex coding sessions where I
want to double-check my work, making edits and adding sets of patches
into sequential commits to keep related changes together topically.

In the process of using git add -p to grab some patches, I may notice
other patches I don't want (especially after I've used the "e" command
in `git add -p` to edit a patch - I usually want to drop the
remaining, unstaged version of the patch right then). But, instead, I
have to go through git add -p and then git checkout -p and likely back
and forth several times, each time skipping through all the same
undecided or postponed patches I am waiting on for later.

Note: I recently discovered the "j" and "J" subcommands which are
useful to postpone decisions on certain patches, but only if I
restrict myself to just git add or git checkout. If I want to do both,
I still have to cycle back through from the top each time. I suppose I
could use stash -p to really hide patches I'm saving for later, but I
still have to exit my workflow and start another command, requiring
multiple passes. OTOH, a unified git add/checkout/stash --patch would
be amazing!

My request
It would be really nice if there were a unified command workflow where
I could add or checkout patches or even partial patches (after editing
a patch in git add), on a case by case basis in a single pass.

Does anyone know a way to do this or do you think it's worth making a
new feature in git to handle it?

Thanks!
Tim
