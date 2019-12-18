Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0712C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECBE20674
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhSp5NpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfLRT3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:29:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38304 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfLRT3u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 14:29:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so3563595wrh.5
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 11:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J81fg3nqQjCy4e97I+LZg44A6ra7DZclNr1ZLK1IoxE=;
        b=BhSp5NpJsYqD8W9AP0PDgg/GrW0xYyKb1U6TRFe4TayHF0fcD7TVIMu4F9xOoaJTrx
         hsdSPV3Hk/qKR1S3RrAFU/TMg+Ymdr8TAUnDY24FZkV7BOx7IDxNawbktjd4Bf7+cL8O
         v7bunwBLfdCpJV3XsotliQWRiAiY/iM3go+DVi9TR5/GEPlW4ckXc5PlCA/9MTIXmO9F
         8P28RJTE8LA5iy3O9JBc2wK7s3PcNK72pQmh/vHmdUUe6v2nJmrrmlNoXeoO0wG99LgV
         4xmUXsVfNGru5rXpQTyO5EcgPQbaCE9ubK+KDXNQlvFqlHvSqL8w6tnbpY27U9EEytZv
         kktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J81fg3nqQjCy4e97I+LZg44A6ra7DZclNr1ZLK1IoxE=;
        b=ZH/Lgj3G+A5VwM207Ti0w2htOXB5gzlGjxPhMf3eftCGT3d29d2WVhhStP1tFte1dA
         U8sIdm112GtuvPAoJrTyO14sfeflD8r5p6MioGKFeLsrNo1/Vt+CtuawoMh4h0Ur0ZTt
         9jBw9JUy/Hxt2PiL8PO1gkL+/iye6c6yZA7t2WGVh0ZNDMmz/sbgc7JMWf+z2cnszdDM
         dmYgKfTZwAgnki55HeVR1/6OtG+t7Xt9mupACToIXxOSUKUz7p2cD7OmCa3pSTE0D3kC
         9zQgKAT/Z5ssAJ8rs/89IMOsnl166HcCQn6UQwE8QfJeIRAEbD2rNY5SkEBqTKi5qM31
         BMUQ==
X-Gm-Message-State: APjAAAWffF4kEJQcIVyPLDI9L3xZttkndxQHMVeOiK2JpGCy48olm2u8
        RexCLDLjeQI+ETRqnNX48F0M3/NI
X-Google-Smtp-Source: APXvYqzsUDHAeHfV08w6u/8vUKITZPKiDJ5tuxK72qNxYvrpfkWdhZCi9LeRHM2uvgkXIQ6MF6ZiZg==
X-Received: by 2002:a5d:4805:: with SMTP id l5mr4538953wrq.3.1576697388147;
        Wed, 18 Dec 2019 11:29:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k11sm3473297wmc.20.2019.12.18.11.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 11:29:47 -0800 (PST)
Message-Id: <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
References: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Dec 2019 19:29:38 +0000
Subject: [PATCH v4 0/8] Directory traversal bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series documents multiple fill_directory() bugs, and fixes the one that
is new to 2.24.0 coming from en/clean-nested-with-ignored-topic, the rest
having been around in versions of git going back up to a decade. 

Changes since v2 (v3 was sent earlier, but this series is closer to v2):

 * protected access to d_type with a !defined(NO_D_TYPE_IN_DIRENT) and made
   sure to allocate a dirent on the heap with some extra space for d_name
   rather than allocating the dirent on the stack.

Elijah Newren (8):
  t3011: demonstrate directory traversal failures
  Revert "dir.c: make 'git-status --ignored' work within leading
    directories"
  dir: remove stray quote character in comment
  dir: exit before wildcard fall-through if there is no wildcard
  dir: break part of read_directory_recursive() out for reuse
  dir: fix checks on common prefix directory
  dir: synchronize treat_leading_path() and read_directory_recursive()
  dir: consolidate similar code in treat_directory()

 dir.c                                         | 177 +++++++++++----
 ...common-prefixes-and-directory-traversal.sh | 209 ++++++++++++++++++
 t/t7061-wtstatus-ignore.sh                    |   9 +-
 3 files changed, 344 insertions(+), 51 deletions(-)
 create mode 100755 t/t3011-common-prefixes-and-directory-traversal.sh


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-676%2Fnewren%2Fls-files-bug-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-676/newren/ls-files-bug-v4
Pull-Request: https://github.com/git/git/pull/676

Range-diff vs v3:

 1:  61d303d8bd ! 1:  6d659b2302 t3011: demonstrate directory traversal failures
     @@ -14,18 +14,6 @@
          of the en/clean-nested-with-ignored-topic); the other 5 also failed
          under git-2.23.0 and earlier.
      
     -    The old failing tests can be traced down to the common prefix
     -    optimization in dir.c handling paths differently than
     -    read_directory_recursive() and treat_path() would, due to incomplete
     -    duplication of logic into treat_leading_path() and having that
     -    function call treat_one_path() rather than treat_path().  Fixing
     -    that problem would require restructuring treat_path() and its full
     -    call hierarchy to stop taking a dirent; see
     -       https://lore.kernel.org/git/xmqqzhfshsk2.fsf@gitster-ct.c.googlers.com/
     -    and the thread surrounding it for details.
     -
     -    For now, simply document the breakages.
     -
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t3011-common-prefixes-and-directory-traversal.sh
 -:  ---------- > 2:  79f2b56174 Revert "dir.c: make 'git-status --ignored' work within leading directories"
 2:  49b0b628db = 3:  d6f858cab1 dir: remove stray quote character in comment
 3:  47814640e4 = 4:  8d2d98eec3 dir: exit before wildcard fall-through if there is no wildcard
 -:  ---------- > 5:  d2f5623bd7 dir: break part of read_directory_recursive() out for reuse
 -:  ---------- > 6:  1f3978aa46 dir: fix checks on common prefix directory
 -:  ---------- > 7:  542c6e5792 dir: synchronize treat_leading_path() and read_directory_recursive()
 -:  ---------- > 8:  31079dc1cf dir: consolidate similar code in treat_directory()

-- 
gitgitgadget
