Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF20219A77
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712204; cv=none; b=kxll9s3Wrm5rlvxbxO/a/5pNuT7fd48JOZHVZAr110raTaJO45ToRnAuw44b/tPXDJbVUdNmzymFRfaVNm6rvVLnB+tACAj5mZ9SNFlzK2zKhxNJdiAf1QP17omHMm6m1bxFTctD6iMN+qc7RRtH54ue8ISY5pFwtyfxd+fO2+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712204; c=relaxed/simple;
	bh=XDea4SM47uZTaxiqD2d0YxjiZWfyu16jFGYVMBrkY5E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rZpSdnsRzyRkPncEBvza5kK1G5gCSFduwz7D4fpXgFtTi3bxjSMUaSoMIJ2bcwRXVWanWlstTdPmRP54YH6OBY23fLOIv6v5pHgd4lscM7Kxx3lVZOtCCwToqz0Uj1A3xsV7UfdGz5BiHDMl2KKU/i+2UBV5nj7qAbMeF1JEcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRHe/udK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRHe/udK"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436345cc17bso15834675e9.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 08:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734712201; x=1735317001; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFfuYDIR0ShN5czL+iyviziWMginciFo9bmJ0X1czjM=;
        b=mRHe/udKT2Skk6uIDAIRr91rJdi6ATdNqqpVvk+D6uiQUGOSZhcnz0gRWdn9Fvqg9w
         g5fHYvsCis8NrbXD/9Ff9nBGWM/QqQrEPO0/Sk79pxn7R2tx5bTdanff/br9kFQytP5z
         mvq2lgSk3uUxvPGR+0Z3Ljn+zMicD1edQDdgrkzkzR11HzaPzNEyesNHbp0hHgMNYnH/
         a57nTCxnRC7DCmrOnPGM8FIQHUHBeUuX53MlMOp6Uryqz+zzo7qT2CiWC8Huh0Sn4RXS
         XjDZ7Y5qzZt9Al6v9VaETsfVdU6lDKYJL3UyaoGqhoI+ZM39oIIJVWZCQESyrwN/Vmem
         PMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734712201; x=1735317001;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFfuYDIR0ShN5czL+iyviziWMginciFo9bmJ0X1czjM=;
        b=NQfEIYa9FFUhQvJBKmFszZBZlmuboczviOUONLLcKthDKmmOixzV+4AqN5cRIGAQOe
         CgBMyyq+s/FBYXfxbyjVG2i1me1s39brbbTZciwOvV+sQy6vcNinrQqsUS5rrz841Fqz
         MvXWddKOyODt7K33RHWidsfpbbky+tpoQ4Nvh/qgjY3XTajs80VVpY/Z4lf6z2g1vdRq
         Okmub+TNqQVMbru4ayXS3+r5XqHqOlUcRAmz2ykjY2M/Ek3RM5uO3rDyWWEJRihwL76N
         Ogy/CiUrSCzKtKxxTGwQrIJu1zzf0go46L7yo5jmUEOoKLimnwZ1nupgbcbY0djPIRGx
         wzpw==
X-Gm-Message-State: AOJu0Yxu3UhuuHPhpuOHEFJ8IEe4E4g/nQK8DN2LM84yLocxvvQc3lIn
	0h6OAwrBAenwO8kGdfef4T54vVevKm2vF6m7vdpRuLz+tZpaDs9YHUJWOA==
X-Gm-Gg: ASbGnct2wksqQ8TZRQebqcFa/FA7LTbxAwIgPYXxdFYo4Ouk+v4YO44LxWdG613byZv
	HwuHpp/SF9kwRTuzxZEX4POFxTY1xkZNqKI6PrLC2k3pPpdxdadJjKCPEbP5ToCcnVz+APLyQuo
	qrT1scZsf/GOxFBULmEdIMoxxpCElihrFyix+GCMjA+oba7cilLHdFnwMJbuw5FchJ13eawmHhR
	RtYK7APQVMF3OprTahKKNSj3iUcttfXZQgcyN9UteiFpcWHFakaoFKXGg==
X-Google-Smtp-Source: AGHT+IHO9Xzf+tq91yeM9FsIke7tzxV3MxCan/cWN/X4nD1v55GXppz8ymL5ACbDvWCD9Xu47QsL3g==
X-Received: by 2002:a05:600c:4f94:b0:434:f871:1b96 with SMTP id 5b1f17b1804b1-43668b7a1dfmr31184995e9.29.1734712200647;
        Fri, 20 Dec 2024 08:30:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364b053e91sm117648615e9.1.2024.12.20.08.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 08:29:59 -0800 (PST)
Message-Id: <1f765409eaf0576de52948ed0a0eb8a5b3493977.1734712194.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
	<pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 16:29:53 +0000
Subject: [PATCH v2 5/5] backfill: assume --sparse when sparse-checkout is
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
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
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
 builtin/backfill.c             |  7 +++++++
 t/t5620-backfill.sh            | 13 ++++++++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
index 4710e2c12e3..9eecc6210c0 100644
--- a/Documentation/git-backfill.txt
+++ b/Documentation/git-backfill.txt
@@ -56,7 +56,8 @@ OPTIONS
 
 --[no-]sparse::
 	Only download objects if they appear at a path that matches the
-	current sparse-checkout.
+	current sparse-checkout. If the sparse-checkout feature is enabled,
+	then `--sparse` is assumed and can be disabled with `--no-sparse`.
 
 SEE ALSO
 --------
diff --git a/builtin/backfill.c b/builtin/backfill.c
index b9f1cc98501..d7c300dbe67 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -1,3 +1,6 @@
+/* We need this macro to access core_apply_sparse_checkout */
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
 #include "git-compat-util.h"
 #include "config.h"
@@ -5,6 +8,7 @@
 #include "repository.h"
 #include "commit.h"
 #include "dir.h"
+#include "environment.h"
 #include "hex.h"
 #include "tree.h"
 #include "tree-walk.h"
@@ -140,5 +144,8 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 
 	repo_config(repo, git_default_config, NULL);
 
+	if (ctx.sparse < 0)
+		ctx.sparse = core_apply_sparse_checkout;
+
 	return do_backfill(&ctx);
 }
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index f87a471c221..3fafcf99b58 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -77,6 +77,12 @@ test_expect_success 'do partial clone 2, backfill min batch size' '
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
@@ -105,7 +111,12 @@ test_expect_success 'backfill --sparse' '
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
