Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F86C388F9
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3465206D4
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKShK2GK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787108AbgJZRC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:02:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40287 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1774323AbgJZRBt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 13:01:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id k18so13213919wmj.5
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 10:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VMzss3rPuAcwqu3t0/FlSxd/pHjPtb2aliGZDXXlfnI=;
        b=rKShK2GKyepsoFn4MDwxfGIyBoTEhJrVGIF52SO7UBnXNWZQdL29pV+05TSRXkhy34
         YDTre2PdjjnbJXmczWPg2qY1Uxy8rIX+iUxtI3KLtHi5GyzLphjMYv7/3qVTuiuOgkRm
         8+Sl/GmeV89lF2/Vhs18NCYZq8HvMXs4Pu3/ZuK6r41KixibTN2DbwY0Byb8DBKPcfLk
         3zbHjwlsHa8WaOg00BNC50j48rjbcLuWBERmREkLzRo5i2eGsMiQ6qHJmlXzIs6KPMlX
         bABSBb9lWc3p9MwwAQLLmcPjIzUWfcMMa0MYkh5rjMqGDXUecMzME2SwN2LFNjB+hELj
         cZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VMzss3rPuAcwqu3t0/FlSxd/pHjPtb2aliGZDXXlfnI=;
        b=hC2eyMgNrJ2BofVOEaDr+p1QnO89D39FUUQYou2zUaV+LWvVnqQXHJIcd+/Ogl2+3Q
         FgkoG5eXxDCq86r4UUYVAx2CR2qlahmRnskeJM25WIq3l769SOlLS0x9nI+/Qf9H7pCb
         +WesWWLJHOu5ZpUV93B0DmU5M26tsZhTVMrtKjyAO1XIjDRyZ6WfGEKlMjs5B+l4/i+9
         wW22MysD94kUfGeCBCPGzGvHJy5zMna1phFCLx9xJHd6a2t/eq/wyNkmllp8m7Ry4XkF
         4KsmNkG8gYtZcLAYJioBF1/ICIyzgSL0J+D2WWYXKrZ+tanQyJzGm8kC2wkNZ0qa6/NH
         3tlQ==
X-Gm-Message-State: AOAM531d080kxFxxzNUaGWa0OqadVLqu97KR91b6lDc0AuFvtji9m9XN
        aAtVABdDqUipwCmGui1IZ8B+rW7u/Sg=
X-Google-Smtp-Source: ABdhPJyc0lBAIkvR7AuXdE+Cv9ad2J3U72j890UACc6P5+LHFR7r0dYCJ1VUbzUvuH/U4Q+64MTaUw==
X-Received: by 2002:a7b:cc89:: with SMTP id p9mr17615196wma.4.1603731705959;
        Mon, 26 Oct 2020 10:01:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y10sm23830990wrq.73.2020.10.26.10.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:01:45 -0700 (PDT)
Message-Id: <pull.769.v2.git.1603731704.gitgitgadget@gmail.com>
In-Reply-To: <pull.769.git.1603468885.gitgitgadget@gmail.com>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 17:01:35 +0000
Subject: [PATCH v2 0/9] Support both merge backends in the testsuite, via environment variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series builds on top of en/dir-rename-tests. It can be applied
independent of my "new merge-ort" API series I submitted a couple days
ago[1], but this series uses the same environment variable as patch 4 of
that series.

As promised, here is a series that makes the testsuite changes needed to
simultaneously support both merge backends, keyed off a
GIT_TEST_MERGE_ALGORITHM environment variable setting.

NOTE: The tests do not yet pass with GIT_TEST_MERGE_ALGORITHM=ort, because I
haven't submitted the implementation of the merge-ort functions -- yet. I
figured they are useful as a high level overview of the differences in
behavior between the two backends, and thus am providing these before the
implementation.

Changes since v1:

 * Minor tweak to test_expect_merge_algorithm() suggested by Junio
 * Updated a test for portability
 * I had meant to leave the final patch, patch 9, out of the submission.
   But, since I submitted it, update it to match my local version of that
   test with one additional thing checked in the result.

[1] 
https://lore.kernel.org/git/pull.895.git.git.1603286555.gitgitgadget@gmail.com/

Elijah Newren (9):
  t/: new helper for tests that pass with ort but fail with recursive
  merge tests: expect improved directory/file conflict handling in ort
  t6416: correct expectation for rename/rename(1to2) + directory/file
  t6404, t6423: expect improved rename/delete handling in ort backend
  t6423: expect improved conflict markers labels in the ort backend
  merge tests: expect slight differences in output for recursive vs. ort
  t6423, t6436: note improved ort handling with dirty files
  t6423: note improved ort handling with untracked files
  t6423: add more details about direct resolution of directories

 t/lib-merge.sh                         |  13 +
 t/t6400-merge-df.sh                    |  14 +-
 t/t6402-merge-rename.sh                | 122 ++++-
 t/t6404-recursive-merge.sh             |  14 +-
 t/t6416-recursive-corner-cases.sh      | 200 ++++---
 t/t6422-merge-rename-corner-cases.sh   |  37 +-
 t/t6423-merge-rename-directories.sh    | 706 +++++++++++++++----------
 t/t6426-merge-skip-unneeded-updates.sh |   3 +-
 t/t6430-merge-recursive.sh             |   3 +-
 t/t6436-merge-overwrite.sh             |  18 +-
 t/t6437-submodule-merge.sh             |  25 +-
 t/t7602-merge-octopus-many.sh          |   6 +
 t/t7610-mergetool.sh                   |  32 +-
 13 files changed, 807 insertions(+), 386 deletions(-)
 create mode 100644 t/lib-merge.sh


base-commit: c64432aacda9054459ce550eca95929897c301bd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-769%2Fnewren%2Ftests-support-both-merge-backends-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-769/newren/tests-support-both-merge-backends-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/769

Range-diff vs v1:

  1:  a8d4825a32 !  1:  f5d3295262 t/: new helper for tests that pass with ort but fail with recursive
     @@ t/lib-merge.sh (new)
      +# Helper functions used by merge tests.
      +
      +test_expect_merge_algorithm () {
     -+	status_for_recursive=$1
     -+	shift
     -+	status_for_ort=$1
     -+	shift
     ++	status_for_recursive=$1 status_for_ort=$2
     ++	shift 2
      +
      +	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
      +	then
  2:  9394d526f1 =  2:  f27f12e8e5 merge tests: expect improved directory/file conflict handling in ort
  3:  1eae84b787 =  3:  38919982c4 t6416: correct expectation for rename/rename(1to2) + directory/file
  4:  554feb2aa7 =  4:  6e47fa19f8 t6404, t6423: expect improved rename/delete handling in ort backend
  5:  5bead7fa0d =  5:  e8a7d6ac81 t6423: expect improved conflict markers labels in the ort backend
  6:  2aa44c1f13 !  6:  4f32450b08 merge tests: expect slight differences in output for recursive vs. ort
     @@ t/t7602-merge-octopus-many.sh: Merge made by the 'recursive' strategy.
       test_expect_success 'merge reduces irrelevant remote heads' '
      +	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
      +	then
     -+		sed -i'' s/recursive/ort/ expected
     ++		mv expected expected.tmp &&
     ++		sed s/recursive/ort/ expected.tmp >expected &&
     ++		rm expected.tmp
      +	fi &&
       	GIT_MERGE_VERBOSITY=0 git merge c4 c5 >actual &&
       	test_i18ncmp expected actual
  7:  9d46cc1ef3 =  7:  c5350fd0ae t6423, t6436: note improved ort handling with dirty files
  8:  436577106e =  8:  6fd224247d t6423: note improved ort handling with untracked files
  9:  2659d1cb98 !  9:  6e308768ff t6423: add more details about direct resolution of directories
     @@ t/t6423-merge-rename-directories.sh: test_expect_merge_algorithm failure success
      +		test_cmp expect actual &&
      +
      +		grep region_enter.*collect_merge_info trace.output >collect &&
     -+		test_line_count = 4 collect
     ++		test_line_count = 4 collect &&
     ++		grep region_enter.*process_entries$ trace.output >process &&
     ++		test_line_count = 2 process
       	)
       '
       

-- 
gitgitgadget
