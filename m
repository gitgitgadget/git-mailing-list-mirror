Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D935CC433E1
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B51D62076D
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erIgnzJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgGPRPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgGPRPx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 13:15:53 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65B8C061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 10:15:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b30so1816911lfj.12
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 10:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=YWRWI0gnyMxqqO12mbKvokxulgfoqHWBz68mz4tHdbY=;
        b=erIgnzJjCnxvUYRRjcj1HxIlU53zcfKqFh3D3vl2/ZePNXwKlJ57idSlSOY5j5bFNK
         fLg874tA0QEF0nGlCIIDwpg678RcEcq8TfX9SB32pdIwfFd59+x07gVxALpAfquv6lL0
         Dc+qwobX5dGH3/sRzS37ldgFa14pk3GI20rCCLpmpRHQxhAkKHRZ8CMvPAlUdD8oyNol
         6fLFE3JHBGxQtVDkiGJWjkYoM0T6em405K2bJsw3UT/J/EAUhW2Kqw1MSrORWLxv5Z/y
         xLOTzkK1j5PceACmjDxMkEQmWnq9ET9Y9mWJRu8/KJm9MXidRBvj2yGYjO8qQvpkWzZk
         XC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YWRWI0gnyMxqqO12mbKvokxulgfoqHWBz68mz4tHdbY=;
        b=Kxz3ifS3uOuXvPyMttf8DoQYylYb0vgPfvNDvPIk3NaSWrfEDLlrM1nnvh28iW8xew
         07DDEevr4MUVr/QF9krJHMYF1Bk1rR31vMCF1cQaMZWe32B56UQe4IvNr/EEIjPE7W4l
         1k1oMplsDrCjpny6U+V6HJe++fkgP4YyXDENDMOzzaqSwXHXVkD3zD7ouQ9Z+n+3CxVp
         eW0NTPb3BBXQX31/lCM5ZltPWuW799x3YrbNXuR+FiHitOSC2ZXcXQL0ki77S0TeM/3P
         +nzHkTWE/+w+odqLEMOhBgRBSTckHlJMWCYnkF+pp+wpUa08BSrR2odgvcKSd/lA8M2b
         KGJQ==
X-Gm-Message-State: AOAM532tGVfbEABztbeXymfgBDoQZ9o1Dq0imtkXtdcO7URVkDnFIAgM
        EkLgeOVBj1MduFWx76OpZH5yFbp5DomIoskI6YcaQmoz3I9QJw==
X-Google-Smtp-Source: ABdhPJy+P1E96Gboiwdz2aJoqFKLNl3cRc42y6zzdSEF9GHWaBMEd2pHs9/ftNuqnrWNGMM2yBHu9M3tsV95Ai+iJkE=
X-Received: by 2002:ac2:46f0:: with SMTP id q16mr2638850lfo.51.1594919750619;
 Thu, 16 Jul 2020 10:15:50 -0700 (PDT)
MIME-Version: 1.0
From:   Alireza <rezaxm@gmail.com>
Date:   Thu, 16 Jul 2020 21:45:24 +0430
Message-ID: <CAD9n_qh0y84HC6sX1OxXWWv8dDMMA_tPv9zRknePVivQq_rfww@mail.gmail.com>
Subject: Request for adding a "clean" merge strategy for a double-commit merge
 to deal with conflicts separately
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Even though the merge commit's message includes conflicted files by
default, the *resolution* itself is lost, that is, it's hard or
impossible to review how the author *resolved* said conflicts.

The proposal is that an option like `-X clean` would commit a clean
merge and leave out any conflicting hunks in the tree for a follow-up
commit to resolve conflicts.

That would be extremely helpful for a code reviewer to see how a
possibly external contributor has dealt with upstream changes e.g. in
a long-standing branch.

Any comment would be appreciated.

Thanks,
Alireza
