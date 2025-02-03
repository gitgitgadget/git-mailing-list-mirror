Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02CF20E010
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602679; cv=none; b=XcTzDVq/hLKGlf0vyO/7f0W/ertzapInIryld00E6xMUcyFwykXTHZLKSBg4pnP2wBQPr8K1MocZMyQWPelt9TaTG3mhVRzXoVOMPd4dgD2m1AhDbYUlhtmbBIabL0rbvp+GfOpDTQljeWwyF0C2lbZWStIXd8UfSkWXBecYn/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602679; c=relaxed/simple;
	bh=sK5r3geJ32RRKyiwX6IU/j98CfcS15SplYsApNVP6jM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pY8AJ7rR8HSoZhLahXAuLuqaIFIqfSVyRNED7oCZm6lbp2p+aolpyMhWgs9tuxcHufbIgn090zKuo4UNa7A1NJhLGCdMZYLqUIWugUJFzoP4u0/qgdfBSmGmt6KFwV0mJsU+R0fHp6gmqUBai7rVxFACLeNcJRzBWu8m9Ksu7hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSidotxP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSidotxP"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso932466566b.2
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 09:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738602675; x=1739207475; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCSRk67UWubQZv8ZkD5P0kmmXo+HTrEOf0+xdgcudkc=;
        b=VSidotxPSaanHgeVWFa3OXPWODSNhmasbYlfTfw0lmqkWyu6SjidawiGVu+M8YlI8x
         J3eZ6KDcnnkMJMOKeiiZpOjPy6VFq74ANOKt9AEj8LL/1z4ZyxXbML0iSwAImcljH+CF
         9WR47fwT7ffUkOXgqLNofYAu9CowSr2c/LLC17eia7rWvK/nn8ZJIICk2gN3jB/pXHB7
         Eg3YC+jRYUVWX4a2Ay8ZnZv5qI0aHwXuQ66fcSETTFLOdyj355eXE8v0RwwTmNwEo7WZ
         4RcJ8OvBK/dn+9lUAmqktz1AQ+H11xAz99+/ADRRFW2NP8tf2shJOZtW8PoFtQDxrLiL
         4DgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738602675; x=1739207475;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCSRk67UWubQZv8ZkD5P0kmmXo+HTrEOf0+xdgcudkc=;
        b=xAxrggWigJtIiSY7+vjzsbYJSKTJ0wtKEuvlkoGz0tCPmJOzJA4mqIym4jKi/DFvGe
         b1PPQivfhVNgM9w9xxO4NKP9RQAX5OQEnBeaCHOwoTzbctDUjpjysnbGNu1WSYyGVw5U
         YNLemSrydSwKtVUMidPG1Eds3oGjera+CXtsO5+jTsjUT7BRa8VWPe4uejKoVPLRjLvt
         LMALsbniKA6aiRhg7pOm60vf8t2LuaA+M0CpgPlrdPlp8EyEdRG9EHf/kPLjfzoQrDYk
         Gqx1dnfdJ6h3I5lsLqmz5jAA7RYjJiVzggawtSkVn2lYbqrDUtcqqcSBrbquA+s+LRuF
         g5lg==
X-Gm-Message-State: AOJu0YxRTsv241FT6UxqKph+DlLT/imnASL2gYWuYG/DazUn1XODD1rh
	kle23iiQN8QHG02vusfq8LVE2RwuHDRCXDlqe5nWZLUXlmesJ8X8IL/Tcw==
X-Gm-Gg: ASbGncumTvhYtnU5LriQXfkUa9/PE4tKU+kBph5zG/IAGc7RUB3wdGZESHgMh5CcK4/
	Yr5uOiV/Xg0BL3WfQtwMHYNT9p+qCt6IdfOysLjwayQnpXN+M2VTAldyNG1jdXdphYyEs2JkN/w
	GdTfkKSq5t6hVkG3BVMgccZydqT0OeiCbXureuq4eToV9lz3oqNUGxyhX7Nqvcqi37oPXUXrRiR
	eiIqjS/+mCoAcvrnrMIEPicqoB2vzLTKHk6d/L/hguxbQjKlbm3a61LAV2c3uYzT0ZpQU8a6ep8
	EyEF1mTEBtffRj/E
X-Google-Smtp-Source: AGHT+IERynYy3Q3g9FTP2VFjxEBR00frOPxT8VraYWKQdpPxO8SlDBFaERhMN52rtEbCxPqEUiIFXg==
X-Received: by 2002:a17:907:9455:b0:ab6:fd25:3c72 with SMTP id a640c23a62f3a-ab6fd253f3amr1926829466b.10.1738602674437;
        Mon, 03 Feb 2025 09:11:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47a7fd9sm782252266b.34.2025.02.03.09.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 09:11:14 -0800 (PST)
Message-Id: <f22cf8b34851a3ba4cd6ab1d31f0835579143c40.1738602667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1820.v3.git.1738602667.gitgitgadget@gmail.com>
References: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
	<pull.1820.v3.git.1738602667.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 03 Feb 2025 17:11:07 +0000
Subject: [PATCH v3 5/5] backfill: assume --sparse when sparse-checkout is
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
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
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
index a28678983e3..95623051f78 100644
--- a/Documentation/git-backfill.txt
+++ b/Documentation/git-backfill.txt
@@ -59,7 +59,8 @@ OPTIONS
 
 `--[no-]sparse`::
 	Only download objects if they appear at a path that matches the
-	current sparse-checkout.
+	current sparse-checkout. If the sparse-checkout feature is enabled,
+	then `--sparse` is assumed and can be disabled with `--no-sparse`.
 
 SEE ALSO
 --------
diff --git a/builtin/backfill.c b/builtin/backfill.c
index d7b997fd6f7..d7ee84692f3 100644
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
@@ -133,6 +137,9 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 
 	repo_config(repo, git_default_config, NULL);
 
+	if (ctx.sparse < 0)
+		ctx.sparse = core_apply_sparse_checkout;
+
 	result = do_backfill(&ctx);
 	backfill_context_clear(&ctx);
 	return result;
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 6b72e9d0e31..58c81556e72 100755
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
 
 test_expect_success 'backfill --sparse without cone mode (positive)' '
-- 
gitgitgadget
