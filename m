Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E280AC77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 13:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjEBN1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 09:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjEBN11 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 09:27:27 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45147618B
        for <git@vger.kernel.org>; Tue,  2 May 2023 06:27:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f315735514so169006895e9.1
        for <git@vger.kernel.org>; Tue, 02 May 2023 06:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683034043; x=1685626043;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGX58JxBwbgHF9ZgDIRcUd3KaquhZ77/Y8Ro2G3hMoc=;
        b=OHfNToByOMVNt7U1hLOHv6rs4SIp3ytL6Ini6J2q38yNcY+TMv6rBwZqEvLeNLduhE
         sEBngSKVBsyl/uaIeQkz2+raHJEHoNARJO04GeXirgbtaCfjoFDFvH0kPKvyaoXk67bP
         ct8JY1BWu4yzZB16T6KIHhimhSPOyyJ41pLhM08d6CvFBdXxysBRRN+T6E26QOBKAYIy
         vpM4nW0d5xrEX/3p4Y0LtG2LaAU1A5XU3+K+o3/OmADMTAhQrJYThg3lBDOsSXMqPuxo
         yjKg7xlxAZMZh+8hUFozEn0iCR4WojwuZz18jjuCnuI87hj2pG1t8y13YxUvmP2Irjtd
         1eXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683034043; x=1685626043;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGX58JxBwbgHF9ZgDIRcUd3KaquhZ77/Y8Ro2G3hMoc=;
        b=FksaSiqd1WjsWogRTVhXrTdSxKE9bOHXhEKRrRdZPLt55ztKnT//FinXhGcJ1432vL
         iSeqR/LoPtNBa/lp8KyLYOGWKnEakHLIuzcNBZLwwSQyBW+VVZOZOc7iQ2nDJQbrl+vW
         dYTrfksxS93lmGXGVetdq4/qmZp1U75BM3y1nGtdjvkyRG28vBtQ7GuyBUm2bfcjGajv
         cyOD/hqigBA8j7RlLIKZIWNt+Rqk4Vn7kPAOZUJui0k9LkQZsfgu6oto+qK49+IYkQib
         IXGq5cEXvIwSzNQxISJjLhZ2C9w7iOoJfWR5oy6HEUSi+6VKaEVhoCHGHPdHoFP0HWJz
         SGAg==
X-Gm-Message-State: AC+VfDxMR0ZkfUpiEYb95hRu+rMD6zstqaLGvfu3dWV86i6dylGfKV56
        Erbwf13Jq/ja6u/H+x9JiCHYhwGxV+s=
X-Google-Smtp-Source: ACHHUZ4n8Jh3ovL/tW0f6dQTllwYNG9RxMlvn834+8SfNLjfAkMnodxQ8MaQ4Zk5wH1NO4SFCy/jaw==
X-Received: by 2002:a05:600c:2281:b0:3f1:72db:454c with SMTP id 1-20020a05600c228100b003f172db454cmr12594830wmf.19.1683034043358;
        Tue, 02 May 2023 06:27:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b003f16932fe7dsm39586281wmq.38.2023.05.02.06.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 06:27:22 -0700 (PDT)
Message-Id: <pull.1526.v2.git.1683034042.gitgitgadget@gmail.com>
In-Reply-To: <pull.1526.git.1682965295.gitgitgadget@gmail.com>
References: <pull.1526.git.1682965295.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 May 2023 13:27:20 +0000
Subject: [PATCH v2 0/2] fsck: verify .bitmap checksums, cleanup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to the recent work on rev-indexes [1], add checks for .bitmap files
to 'git fsck'.

Patch 1 includes the full details for .bitmap files.

Patch 2 includes a cleanup of ds/fsck-pack-revindex that I noticed while
preparing this series.


Updates since v2
================

 * The code for verify_bitmap_file() added checks for a negative file
   descriptor, as well as some other cleanup.
 * The test in t5326 is expanded to include the "both are corrupt" case, as
   well as a reorganization because the test was not confined to an inner
   repo.

Thanks, Stolee

[1]
https://lore.kernel.org/git/pull.1512.git.1681748502.gitgitgadget@gmail.com/

Derrick Stolee (2):
  fsck: verify checksums of all .bitmap files
  fsck: use local repository

 builtin/fsck.c                | 10 +++++---
 pack-bitmap.c                 | 45 +++++++++++++++++++++++++++++++++++
 pack-bitmap.h                 |  2 ++
 t/t5326-multi-pack-bitmaps.sh | 44 ++++++++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+), 3 deletions(-)


base-commit: 48d89b51b3bb8a60580c36731b96a7206ce1e5b9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1526%2Fderrickstolee%2Ffsck-bitmap-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1526/derrickstolee/fsck-bitmap-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1526

Range-diff vs v1:

 1:  d608d2faa86 ! 1:  5d6d6658633 fsck: verify checksums of all .bitmap files
     @@ pack-bitmap.c: int bitmap_is_preferred_refname(struct repository *r, const char
      +	int fd = git_open(name);
      +	int res = 0;
      +
     -+	/* A non-existent file is valid. */
     -+	if (fstat(fd, &st)) {
     -+		close(fd);
     ++	/* It is OK to not have the file. */
     ++	if (fd < 0 || fstat(fd, &st)) {
     ++		if (fd >= 0)
     ++			close(fd);
      +		return 0;
      +	}
      +
     @@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'tagged commits are selected
      +	cp "$packbitmap.bak" "$packbitmap" &&
      +
      +	# fsck works at first
     -+	git fsck &&
     ++	git fsck 2>err &&
     ++	test_must_be_empty err &&
      +
      +	corrupt_file "$packbitmap" &&
      +	test_must_fail git fsck 2>err &&
     @@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'tagged commits are selected
      +	cp "$packbitmap.bak" "$packbitmap" &&
      +	corrupt_file "$midxbitmap" &&
      +	test_must_fail git fsck 2>err &&
     -+	grep "bitmap file '\''$midxbitmap'\'' has invalid checksum" err
     ++	grep "bitmap file '\''$midxbitmap'\'' has invalid checksum" err &&
     ++
     ++	corrupt_file "$packbitmap" &&
     ++	test_must_fail git fsck 2>err &&
     ++	grep "bitmap file '\''$midxbitmap'\'' has invalid checksum" err &&
     ++	grep "bitmap file '\''$packbitmap'\'' has invalid checksum" err
      +'
      +
       test_done
 2:  2162a352a46 = 2:  00789bbc558 fsck: use local repository

-- 
gitgitgadget
