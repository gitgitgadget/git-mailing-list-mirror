Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D46AC433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 19:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD4E224F9
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 19:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbhAYT7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 14:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732315AbhAYT6u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:58:50 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA7FC061574
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:58:10 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 3so16876070ljc.4
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=iLkXK83ERvYcTFpDT41IGOB81b/ikpCpocfVfQLvhfc=;
        b=fzXT3d4E9aITMghneSS7r/KSoRmjaOhFkp2vmJ1NifReHFNaEkXTAkydsSHKiVTJyV
         CsDujdkTksLxnD2ll80GL5Bpqeshh0k4KVnmrpKHfl889p5Ao7GSP4/+2an7CpEFNlP5
         PF2BAJwKfutk1G/SpS0YGh7mIu9RvtpevlwFhjqEOy5wbVD1NSSoLNJWFUmH4i+SscB1
         SYLl92jBHBiwLXDoj3djQYBgyIbHPYZ+wN0dflkTsVR55eMDfAfdog+0LzsL/GADqhuM
         muls8/61b6Lt8BHSGABaxEuhHW/UAYiz4Xsgrx0UNfJXgYYOXf5emOTJ9ZbRcUogCL8H
         teSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iLkXK83ERvYcTFpDT41IGOB81b/ikpCpocfVfQLvhfc=;
        b=oYt8uQ7gCoOY0prG3wx5HTARW3rzkiTI+kaMWyRkeLloKq44wixQjO2j5CFVd+tV39
         vV1Nl6lpOFPXNUayGJFh4I1dl9beOSl8PFvOtWfZqyj/itHke+uzB9XbFy1uLPv+NQ+f
         dDLWeebqLvKR/B0gQYMepzJCTpnxQuauUdCbNV0P7djXpD0gT8qGXD58oczamUYdvmR2
         Z1faPinf+hqtVQ7k+UjDXsrplZD7ZNKqsGiCVoVmr796BJnjbFoylJGrjbYkBenCGFq6
         xUvcNqvAvW46IbRyG29hd0++UQZHSfnwbwMDHPRTE4vMQnv3ZDMkU0EMWhJeIFbjtTyW
         I19w==
X-Gm-Message-State: AOAM533D+n6KG4wVvvp+206VZVzR4c8/u0mg3093uY7O5679f9853Eal
        HkXeuYhP4Hfzxmw3wfyJYHri8cLcka8AUECS84KMeGhETFUW4g==
X-Google-Smtp-Source: ABdhPJwZgWmP6c0PoBhaQ6en8mmFW3Yvnuj1VPXkjTVYAW0fksfkxPqD12jYo1s6wKYoRfeuWR1NcH2hEYUxvELZF0U=
X-Received: by 2002:a2e:b16f:: with SMTP id a15mr963165ljm.459.1611604688227;
 Mon, 25 Jan 2021 11:58:08 -0800 (PST)
MIME-Version: 1.0
From:   Dan Lew <dlew@atlassian.com>
Date:   Mon, 25 Jan 2021 13:57:57 -0600
Message-ID: <CALmLNPQAKzzzAUPhejvcF7SEvq4zGDDqkm6HaVi9pAfB0JjoLQ@mail.gmail.com>
Subject: Bug report: gitk is no longer working on my OSX machine
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
Would love some help, having trouble getting gitk up and running again...

Here's the details from `git bugreport`:

What did you do before the bug happened? (Steps to reproduce your issue)

1. Open any git repository directory in a terminal.
2. Run `gitk`

What did you expect to happen? (Expected behavior)

gitk opens

What happened instead? (Actual behavior)

gitk crashes with the following error message on the command line:

objc[33662]: autorelease pool page 0x7fb1070a3000 corrupted
  magic     0x00000000 0x00000000 0x00000000 0x00000000
  should be 0xa1a1a1a1 0x4f545541 0x454c4552 0x21455341
  pthread   0x10b020dc0
  should be 0x10b020dc0

An error window also pops up saying that "wish quit unexpectedly."

What's different between what you expected and what actually happened?

It shouldn't crash.

Anything else you want to add:

I'm using git/git-gui as installed by brew on OSX>

If I run `gitk` where outside of a git repository, then it opens fine
(and shows the "Cannot find a git repository here" error.

gitk has run fine on this computer for years; I don't know what
suddenly changed to make it stop working.

[System Info]
git version 2.30.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Tue Nov 10 00:10:30
PST 2020; root:xnu-6153.141.10~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.28)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
