Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5437C61DA4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 16:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjBDQRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 11:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDQRB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 11:17:01 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBC311EBA
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 08:16:59 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso7988881wmp.3
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 08:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=No8Af1Qam+yX9U3MWBM1PJV5Ep4m9F0cv0bwblhE3+Q=;
        b=JuHyaVyvRDyTRml3UR8E1cS+V+6ahBZhwdbOjAU4VQRTPIHR3Mdsp9Zzo9didZTkDh
         nLmsFyPb1g01pqzDd4W3WJ5VdCBBowN5h39TLXwY7GRSeTZTdCuZaA2rpDvS7kp4BaSd
         WvDbwrG6ebd6TZn6RRM/LpeL2epcXUZo3EYbpmd85yoE/uy7AXhLhblkERGospVaH3oE
         8TwugqQoiGmPgWhZj8gLqUuSJPhOL9scZwFPw7ZY2TG9PJbDFowlnCNL2fX6Bx9iaIht
         e83OFvZG30LDLBroH3s+p5vnWEyukSXLCyfDGSyaCZRFFl8v9ZOJyEoljplcf941wZoa
         3hNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=No8Af1Qam+yX9U3MWBM1PJV5Ep4m9F0cv0bwblhE3+Q=;
        b=a5zQXwTpEAz4bdTjE1HZL/MGMrgk6AFHL/BcsfFuFu9yjQAQ0nKPEjDrXo/U9D4QMY
         JMiT6TpRUv1PfnG4ovkDu37QGChx5Cxoex/9oBJU2aKVXEshR8TSXxXruJXfy3s4GMdB
         JUxGd0X50XSmR/5KQF1GZuBvihgDRHPA1IAWf7oCflE+7jvPKivf0estgBh4VmmRDdtG
         LJNkj7+IDJwjXP3rCfqmXPiFUuXnIAeTZBHDrIHEhUXVP6Y09GWb2Pi1wMMu8Lqeog9S
         HvjFXSBfwApZPRD/0Fpkhr1vDS9Ncw1LxZ5fHWma4UVb/KAtiYitq5nw8xNGKnotivfQ
         mFDg==
X-Gm-Message-State: AO0yUKUe9LVE9FtLuAfehaoByxKFIyQL4Bd2A92MY3P59u4zFjxAIlfu
        wsrgxvPU1fsIhW6MhzdvxRLZMdAK6/E=
X-Google-Smtp-Source: AK7set+lfxK8URXbXO4C1erATKlWWjiLkYhk3uoXx82JWFJGgArSewqAWGYbSzS8ob4jLFv1SbSBcQ==
X-Received: by 2002:a7b:ca5a:0:b0:3de:db64:a56f with SMTP id m26-20020a7bca5a000000b003dedb64a56fmr15789201wml.13.1675527417877;
        Sat, 04 Feb 2023 08:16:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p30-20020a1c545e000000b003de2fc8214esm6241990wmi.20.2023.02.04.08.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 08:16:57 -0800 (PST)
Message-Id: <pull.1458.v3.git.1675527416.gitgitgadget@gmail.com>
In-Reply-To: <pull.1458.v2.git.1674149666.gitgitgadget@gmail.com>
References: <pull.1458.v2.git.1674149666.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Feb 2023 16:16:54 +0000
Subject: [PATCH v3 0/2] ls-files: add %(skipworktree) atom to format option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a %(skipworktree) atom git ls-files --format to indicate whether the
file in the index match the sparse specification.

v1: add %(skipworktree) atom to git ls-files format option. v2:

 1. no longer mentioned git ls-files -t.
 2. change %(skipworktree) output from "true"/"false" to "1"/"".
 3. fix the sparse-checkout docs link. v3:
 4. fixed numbering of paragraphs in documentation by using ".".
 5. revised little test style.

ZheNing Hu (2):
  docs: fix sparse-checkout docs link
  ls-files: add %(skipworktree) atom to format option

 Documentation/Makefile                      |  1 +
 Documentation/git-ls-files.txt              |  4 ++
 Documentation/technical/sparse-checkout.txt | 55 +++++++++++++--------
 builtin/ls-files.c                          |  3 ++
 t/t3013-ls-files-format.sh                  | 16 ++++++
 5 files changed, 59 insertions(+), 20 deletions(-)


base-commit: a7caae2729742fc80147bca1c02ae848cb55921a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1458%2Fadlternative%2Fzh%2Fls-file-format-skipworktree-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1458/adlternative/zh/ls-file-format-skipworktree-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1458

Range-diff vs v2:

 1:  cde4827da13 ! 1:  3bdd3ceb16c docs: fix sparse-checkout docs link
     @@ Documentation/technical/sparse-checkout.txt: operate full-tree.
       
      -0. Behavior A is not well supported in Git.  (Behavior B didn't used to
      -   be either, but was the easier of the two to implement.)
     -+Behavior A is not well supported in Git.  (Behavior B didn't used to
     ++. Behavior A is not well supported in Git.  (Behavior B didn't used to
      +be either, but was the easier of the two to implement.)
       
     - 1. am and apply:
     +-1. am and apply:
     ++. am and apply:
       
     +    apply, without `--index` or `--cached`, relies on files being present
     +    in the working copy, and also writes to them unconditionally.  As
      @@ Documentation/technical/sparse-checkout.txt: been working on it.
     +    files and then complain that those vivified files would be
     +    overwritten by merge.
     + 
     +-2. reset --hard:
     ++. reset --hard:
     + 
     +    reset --hard provides confusing error message (works correctly, but
     +    misleads the user into believing it didn't):
     +@@ Documentation/technical/sparse-checkout.txt: been working on it.
     +     `git reset --hard` DID remove addme from the index and the working tree, contrary
     +     to the error message, but in line with how reset --hard should behave.
     + 
     +-3. read-tree
     ++. read-tree
     + 
     +    `read-tree` doesn't apply the 'SKIP_WORKTREE' bit to *any* of the
     +    entries it reads into the index, resulting in all your files suddenly
     +    appearing to be "deleted".
     + 
     +-4. Checkout, restore:
     ++. Checkout, restore:
     + 
     +    These command do not handle path & revision arguments appropriately:
     + 
     +@@ Documentation/technical/sparse-checkout.txt: been working on it.
     +     S tracked
     +     H tracked-but-maybe-skipped
     + 
     +-5. checkout and restore --staged, continued:
     ++. checkout and restore --staged, continued:
     + 
     +    These commands do not correctly scope operations to the sparse
     +    specification, and make it worse by not setting important SKIP_WORKTREE
     +@@ Documentation/technical/sparse-checkout.txt: been working on it.
     +    the sparse specification, but then it will be important to set the
     +    SKIP_WORKTREE bits appropriately.
     + 
     +-6. Performance issues; see:
     ++. Performance issues; see:
           https://lore.kernel.org/git/CABPp-BEkJQoKZsQGCYioyga_uoDQ6iBeW+FKr8JhyuuTMK1RDw@mail.gmail.com/
       
       
 2:  9ebd6b77a69 ! 2:  15e77743f7f ls-files: add %(skipworktree) atom to format option
     @@ Documentation/git-ls-files.txt: eolattr::
       path::
       	The pathname of the file which is recorded in the index.
      +skipworktree::
     -+	If the file in the index marked with SKIP_WORKTREE bit.
     -+	It means the file do not match the sparse specification.
     ++	Whether the file in the index has the SKIP_WORKTREE bit set.
      +	See link:technical/sparse-checkout.txt[sparse-checkout]
      +	for more information.
       
     @@ t/t3013-ls-files-format.sh: test_expect_success 'git ls-files --format with --de
      +	git add dir1 dir2 &&
      +	git commit -m skipworktree &&
      +	git sparse-checkout set dir1 &&
     -+	git ls-files --format="%(path)%(skipworktree)" >actual &&
     ++	git ls-files --format="%(skipworktree) %(path)" "dir*" >actual &&
      +	cat >expect <<-\EOF &&
     -+	dir1/file1.txt
     -+	dir2/file2.txt1
     -+	o1.txt
     -+	o2.txt
     -+	o3.txt
     -+	o4.txt
     -+	o5.txt
     -+	o6.txt
     -+	o7.txt
     ++	 dir1/file1.txt
     ++	1 dir2/file2.txt
      +	EOF
      +	test_cmp expect actual
      +'

-- 
gitgitgadget
