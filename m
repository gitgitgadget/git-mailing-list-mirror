Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA7FC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 22:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiCBW2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 17:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiCBW2L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 17:28:11 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29F963BF
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 14:27:26 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r10-20020a1c440a000000b00386f2897400so453634wma.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 14:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=eYzpzrP/68TiRV80A4vhgdDYfvp1aKOE9c4Azo+7/Yo=;
        b=HOpYdq5ckK4EUT26BvF4VzJvGxAhLk+tUcyO8v01gTQaqvZMfz/JB1bkRgNIwBGOf1
         W9/gmcybQqWQcxhZhGenhnXasDusSKV31JLmKjp5uAU9bGStrNwr8bU48XCb78J9iAa2
         Lbi+yoasHRzkHBSoZ6fDJ7tkqZjnacPHCqyIRkCsXAR3wx6uziNQYq5efgCR16Xk57LG
         KfF19yBHSYJK1J0xWfFlBCuZW/ED+cbY1gbriVtXBF4Vvs//6pGTOge2hmL+GIwGPxBx
         bc4CfvKzUuB826oCBeFSy7HdWM0RrqnpP1oTKbwdHa52FTill87hPIwTvGhk40sdstVO
         FWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=eYzpzrP/68TiRV80A4vhgdDYfvp1aKOE9c4Azo+7/Yo=;
        b=5Oj5mKT8LE8n5Mso7jTge6XheJxMucJ11eNNLPeIaNznN14SNhXSHZpdRMFa7x/RWS
         HTyil24dueWRho4wzzCUXEXTbkuJmklQDWBKaDUqaYVNBomBDUOE4JF+aoE24h1U1wCE
         9Yag21S+zkEiU40Ob2OtFLNWsPY4BCh7ZeWFtk5flsAEjix4+U1xZrKOQKw2DHrxlbBs
         EHFMM2U5J9XFtxQph5pidlkD8MyHkG6Vw+ptiUFzOU9JkskMj7jHV/F/6x/kAsPgAU2f
         2Pks9XYOVktFfWYAVGZgMrUuCqg2Ea645nurT/j1vWx2Jbs2UFsrEdCF8CbYseMqh9+k
         05hQ==
X-Gm-Message-State: AOAM532aEx0v69aOqLmVINFu2o75bw51BtqjKUql9tqgqdobwBzvoyi/
        aK98Yv2ebk/nlLEl/JwUKLkwDzyvX5M=
X-Google-Smtp-Source: ABdhPJyLii36GS2R8drF3oGHZqLmeK8ufKMWCV87KK4pj/iEBDA5/iSiLTjFF54miirlLIBd463/aQ==
X-Received: by 2002:a05:600c:210e:b0:385:d649:b4ca with SMTP id u14-20020a05600c210e00b00385d649b4camr1531303wml.114.1646260045019;
        Wed, 02 Mar 2022 14:27:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0037bdfa1665asm9207802wmj.18.2022.03.02.14.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 14:27:24 -0800 (PST)
Message-Id: <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com>
In-Reply-To: <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
References: <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Mar 2022 22:27:21 +0000
Subject: [PATCH v4 0/3] libify reflog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In [1], there was a discussion around a bug report of stash not recovering
in the middle of the process when killed with ctl-c. It turned out to not be
a bug we need to fix. However, out of that discussion came the idea of
libifying reflog. This can stand alone as a code improvement.

stash.c currently shells out to call reflog to delete reflogs. Libify reflog
delete and call it from both builtin/reflog.c and builtin/stash.c.

This patch has three parts:

 * add missing test coverage for git stash delete
 * libify reflog's delete functionality and move some of the helpers into a
   reflog.c library and call reflog_delete from builtin/reflog.c
 * call reflog_delete from builtin/stash.c

Updates since v3:

 * refactored test to have a smaller diff

Updates since v2:

 * removed unnecessary includes
 * adjusted wrapping/whitespace in reflog.h
 * adjusted test to be isolated from other tests since currently tests for
   stash depend on each other. There was some discussion around this and
   even a possibility to refactor the tests. However, it would have been a
   larger effort than is worth for this series, so instead I just made one
   of the tests I added be isolated from the others.

Updates since v1:

 * added missing test coverage
 * squashed 1/3 and 2/3 together
 * moved enum into reflog.c
 * updated object.h's flag allocation mapping

 1. https://lore.kernel.org/git/220126.86h79qe692.gmgdl@evledraar.gmail.com/

John Cai (3):
  stash: add tests to ensure reflog --rewrite --updatref behavior
  reflog: libify delete reflog function and helpers
  stash: call reflog_delete() in reflog.c

 Makefile         |   1 +
 builtin/reflog.c | 455 +----------------------------------------------
 builtin/stash.c  |  18 +-
 object.h         |   2 +-
 reflog.c         | 432 ++++++++++++++++++++++++++++++++++++++++++++
 reflog.h         |  43 +++++
 t/t3903-stash.sh |  43 ++++-
 7 files changed, 527 insertions(+), 467 deletions(-)
 create mode 100644 reflog.c
 create mode 100644 reflog.h


base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1218%2Fjohn-cai%2Fjc-libify-reflog-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1218/john-cai/jc-libify-reflog-v4
Pull-Request: https://github.com/git/git/pull/1218

Range-diff vs v3:

 1:  33299825fc4 ! 1:  08bb8d3a9b9 stash: add tests to ensure reflog --rewrite --updatref behavior
     @@ t/t3903-stash.sh: diff_cmp () {
       }
       
      -test_expect_success 'stash some dirty working directory' '
     --	echo 1 >file &&
     --	git add file &&
     --	echo unrelated >other-file &&
     --	git add other-file &&
      +setup_stash() {
     -+	repo_dir=$1
     -+	if test -z $repo_dir; then
     -+		repo_dir="."
     -+	fi
     -+
     -+	echo 1 >$repo_dir/file &&
     -+	git -C $repo_dir add file &&
     -+	echo unrelated >$repo_dir/other-file &&
     -+	git -C $repo_dir add other-file &&
     - 	test_tick &&
     --	git commit -m initial &&
     --	echo 2 >file &&
     -+	git -C $repo_dir commit -m initial &&
     -+	echo 2 >$repo_dir/file &&
     + 	echo 1 >file &&
       	git add file &&
     --	echo 3 >file &&
     -+	echo 3 >$repo_dir/file &&
     - 	test_tick &&
     --	git stash &&
     --	git diff-files --quiet &&
     --	git diff-index --cached --quiet HEAD
     -+	git -C $repo_dir stash &&
     -+	git -C $repo_dir diff-files --quiet &&
     -+	git -C $repo_dir diff-index --cached --quiet HEAD
     + 	echo unrelated >other-file &&
     +@@ t/t3903-stash.sh: test_expect_success 'stash some dirty working directory' '
     + 	git stash &&
     + 	git diff-files --quiet &&
     + 	git diff-index --cached --quiet HEAD
      +}
      +
      +test_expect_success 'stash some dirty working directory' '
     @@ t/t3903-stash.sh: test_expect_success 'drop middle stash by index' '
      +
      +test_expect_success REFFILES 'drop stash reflog updates refs/stash with rewrite' '
      +	git init repo &&
     -+	setup_stash repo &&
     ++	(
     ++		cd repo &&
     ++		setup_stash
     ++	) &&
      +	echo 9 >repo/file &&
      +
      +	old_oid="$(git -C repo rev-parse stash@{0})" &&
 2:  33adfee4ca6 = 2:  50471c2ee6f reflog: libify delete reflog function and helpers
 3:  b17d8e5d43a = 3:  cb32d9bfe60 stash: call reflog_delete() in reflog.c

-- 
gitgitgadget
