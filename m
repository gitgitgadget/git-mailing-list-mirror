Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180D46A332
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935346; cv=none; b=UPpRrQgDNIGqyBv3X0m75U+E835v8SBVy3jiG3J7W9eXsRWbmaz+Z0L9frh+Rq5H5G4TDCfnUtgzGsmjEXfgs/p28ZD8HNV7DbJUgNQpvesAwNNm91ZR6cxVWPiUvIRKTRsgrFwyGSMn18TF09OLA9me2iRqC/Blmk55Ix2qe0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935346; c=relaxed/simple;
	bh=+6bdnFUJ/2pDVt2eVytKz9FfIJNlxUgODrxummiYGj8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fHOBWA6ZB5Pub6EWUiuxv2bDWAzEoWTgCKxX1HDCNDL1MjhybNQB3i2S6IGQa+eh58rsLyBfmbqW6Vdnw1C9HRnCHMNo+Ya+E4mAPjrV9J6uVzvom3L6Y/BMvnIyb0EsXY34ILUtTONT7IR8aFA9/ImFJ/wC7rrQPFCXMk765B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7JWl2xf; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7JWl2xf"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f760f7e25bso21846861fa.2
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935343; x=1726540143; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4Jm4HohjZ/FsBXKVZyLjP/yNbs/nNpnfyVh79DmCrI=;
        b=R7JWl2xfHRcGu/nWxIT4hUyWaf+/2xzskQxLafWTUJBQ+2oSVK7YruS1IuPVK62M8w
         Da7KGQs5UzdRpfmYzrUjvw2obMxs1g7Vx4h/CDe2LjvhNSIk7a5Ri1vOUOId6wU0m88w
         JBbAmKhIBtOKALkVv4NsH+TIP8AGalir57MbbJ2KJrl+5tweKYAyv0dcOA7oaODAQfBo
         Wml4jfTNatXGaBf0INJeuWQOqznxDqhW+jaNlYZKoSsgGjnLviEGev19pEmBonCnbC9N
         8pswhdZezOe9qduO31P30yQ5WW2MpQB50RBXoGWN1oiLVHSQheO2+oLeur8ten9Wa5b/
         JWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935343; x=1726540143;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4Jm4HohjZ/FsBXKVZyLjP/yNbs/nNpnfyVh79DmCrI=;
        b=ZCQWrV0qZihUveyi+y69hQLpuMnqKpRqm9sWGksERIXyFCh6BFVNStW+hbQgq9YxKV
         u4GCOxCP/ODeYW1R678QESON3K5zZYjsqi0jd8UbSwnXtCMgVI5OwjElK/9y9PRXU5u+
         nu/47Q1+/Y7t/7lGjA+ksPDk+lXNQSIkNiFluANIENK1f+Ut8cIcbZKGWizbLowKjF5E
         O/PnebP3ZSMORgnXFjtiwJQT4UOKJo07HwhcLVj7R4jPoYzl2sFA9OH7lR1b5SzAC8cb
         ipoL4WT8PdfYGfaWlvXNeKcaWqofHOzqRVBpVAmtXuJ/m0A8L6byz/VDj0AyPyyIIipn
         SyFg==
X-Gm-Message-State: AOJu0YxaCVBhHlYxj4XhuaF7yPNibBJjNUJTCrHi5rqumBLb2Ol6WToS
	aM/ufuTGjzLq5HGqKll29CkCZx8sPtsA+gnGr35/035LVLTWwIYODCp+wg==
X-Google-Smtp-Source: AGHT+IG0OW2B5xIfhqRp50g7M5z3yCG/sFq3cy7wlKLHvaP/Sf4CLWeh/gmHhgUji9tCksoKAuspgA==
X-Received: by 2002:a2e:be1b:0:b0:2f5:1fa7:ac7d with SMTP id 38308e7fff4ca-2f752495fdbmr69359371fa.37.1725935342537;
        Mon, 09 Sep 2024 19:29:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8cdf7sm3665548a12.92.2024.09.09.19.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:02 -0700 (PDT)
Message-Id: <aa34653de3b7bc501cb40d8bded3ddaff20f37ae.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:31 +0000
Subject: [PATCH 06/30] backfill: assume --sparse when sparse-checkout is
 enabled
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

The previous change introduced the '--[no-]sparse' option for the 'git
backfill' command, but did not assume it as enabled by default. However,
this is likely the behavior that users will most often want to happen.
Without this default, users with a small sparse-checkout may be confused
when 'git backfill' downloads every version of every object in the full
history.

However, this is left as a separate change so this decision can be reviewed
independently of the value of the '--[no-]sparse' option.

Add a test of adding the '--sparse' option to a repo without sparse-checkout
to make it clear that supplying it without a sparse-checkout is an error.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-backfill.txt |  3 ++-
 builtin/backfill.c             |  4 ++++
 t/t5620-backfill.sh            | 13 ++++++++++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
index ecf2ac428ce..066ec6b161a 100644
--- a/Documentation/git-backfill.txt
+++ b/Documentation/git-backfill.txt
@@ -48,7 +48,8 @@ OPTIONS
 
 --[no-]sparse::
 	Only download objects if they appear at a path that matches the
-	current sparse-checkout.
+	current sparse-checkout. If the sparse-checkout feature is enabled,
+	then `--sparse` is assumed and can be disabled with `--no-sparse`.
 
 SEE ALSO
 --------
diff --git a/builtin/backfill.c b/builtin/backfill.c
index de75471cf44..82a18e58a41 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -5,6 +5,7 @@
 #include "repository.h"
 #include "commit.h"
 #include "dir.h"
+#include "environment.h"
 #include "hex.h"
 #include "tree.h"
 #include "tree-walk.h"
@@ -133,5 +134,8 @@ int cmd_backfill(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
+	if (ctx.sparse < 0)
+		ctx.sparse = core_apply_sparse_checkout;
+
 	return do_backfill(&ctx);
 }
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index c7bb27b72c1..1fa2e90f8cf 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -80,6 +80,12 @@ test_expect_success 'do partial clone 2, backfill batch size' '
 	test_line_count = 0 revs2
 '
 
+test_expect_success 'backfill --sparse without sparse-checkout fails' '
+	git init not-sparse &&
+	test_must_fail git -C not-sparse backfill --sparse 2>err &&
+	grep "problem loading sparse-checkout" err
+'
+
 test_expect_success 'backfill --sparse' '
 	git clone --sparse --filter=blob:none		\
 		--single-branch --branch=main 		\
@@ -108,7 +114,12 @@ test_expect_success 'backfill --sparse' '
 	test_trace2_data promisor fetch_count 8 <sparse-trace2 &&
 	test_trace2_data path-walk paths 15 <sparse-trace2 &&
 	git -C backfill3 rev-list --quiet --objects --missing=print HEAD >missing &&
-	test_line_count = 24 missing
+	test_line_count = 24 missing &&
+
+	# Disabling the --sparse option (on by default) will download everything
+	git -C backfill3 backfill --no-sparse &&
+	git -C backfill3 rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 0 missing
 '
 
 test_expect_success 'backfill --sparse without cone mode' '
-- 
gitgitgadget

