Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E3420629D
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515649; cv=none; b=T4XKyg6kuI0B1ICjs25m8BmOXz3vuAm/tLJWmSsXzOEWwdHaoeNTY2Wx6rGrALGKHF+w25Ilbdln7MnZixCehXjQ5X+mFBnUp5ItxJr4zciUMsLIcX5z4djqmJURKtq9dAx8/ptWeFOL9msOYpQbfnsYTbLaM5L3NLWdAcsMZbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515649; c=relaxed/simple;
	bh=q7ZJc3iGSP97NJo9FllWl6znf9mlzRLIe4OEFiGLZ3c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GiVHjTwNQWCa8E/eakmJqzgWVVedav+d7sLhSvbIcgtd8L3yd1VEmvQJFecRiZKi3+ZgSxkZCQtMV9LSNxuXFbeS5SJyfu3P2X+1ZuDllK+smV+YcBicJq4cZ9f0zZon4jeFxXydyUN+8Sp4yxcnLKG+qJlqCTKcZvsNHRcIK6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfM0avD6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfM0avD6"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385df53e559so1772322f8f.3
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 12:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733515645; x=1734120445; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4xq6m0dL9A6jirougDJcrIaz9gJ0fzkOJrZvv6Ffoo=;
        b=bfM0avD6V2Dplz2LOrQj6h5NfGAjJEf9lwZJvNlLII+HVyhQY/0dyXnBhs9M4Y4GiZ
         ouhQRtAZCZY3POhbeasvisQLwIKYcgqmm5LOZ8WqCNfq6pn7c50NP+GYn0CxaqXBDzZw
         5yVKQTCzglPdGxTclxhp7R1TuDqEJ13Nn4JaE6tE60GngIA65GaHFAGXJIe1uqoZArAA
         whgw+wa6vJ3o7uOpqTkEr5OHhgJUeGaMINVJmFQo1owemUbf7aQ0YnBaysPc8n4XDKrI
         bjWhLdtb+kVCRdaoFp9/C6e3RRAudtfi8S0DQMQI+KcYYKJRggFf9ey/FAwMJbPH21/2
         s5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733515645; x=1734120445;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4xq6m0dL9A6jirougDJcrIaz9gJ0fzkOJrZvv6Ffoo=;
        b=H5I/Cc7jZwNhn4gOO4CaCuFM4xcmWxMsAsP5RjeXSKJ/I7nv+g6wPDZC0Cs06kOjaI
         MfLkh4TNjy3Fe6VObDZDU7eOz08XpbBO8ljIwkUoHoJdyWEWT54PqYWJPvHfBY1iCRWr
         XhMCyBaWWsxVgP56RAKs8lwPbaczvnWEwxMaGFF5nHe/AuGSupuMXqKtXTBpI/PCz63A
         t6EUwmOY+KhWgzsUbuIo9QKEDXrS9X6cFHtTd9i1xFZOsPrJ5yZrHRKNeebMgmhGlO3D
         XsFc/4PJdpUohbI6t0PTLqybDTFcatGBGzUx44l/uvPCLVO0q6YBKKxYeHb3Sw0LWbxk
         vQlQ==
X-Gm-Message-State: AOJu0YxZyxdnerBmb8cZS/up9pp9ZTUA00vOYkljDXvLNd5RNA6n9y1D
	DOSS6cb2+aVpsomeXeRAScSJg+39L69nXt9rlB9XmD61X6/BXpkvK/lfaQ==
X-Gm-Gg: ASbGncvD94E7mi2J102UA+ggEWbbT0hfgQrrvhfsbwkNbzBI2WqdsHkmGohMpatYjK4
	8VI10S5AgvF9no1mNFsHnGlOPVI6mZZcgU0zgSgGGEx4YDiMAevAoQRttPjgSrAy3i0U2gAADfv
	ZDERohECj9rqY57F+9Ou3IhjKQco02LNpirZ6XouBmh3ySX190/PXqDh+okA/1tUWsopS8qkNwf
	ph6SsJLvxM/ppEcjxYha/kwGamx4OSyCiaR+aujGmf2A33nYEM=
X-Google-Smtp-Source: AGHT+IEPiHFw5rfwZD1dw3J6eugCD33tzMT6bfcFxt/BJH9SHNH97KPulkdngGhglahrH43VNObYyg==
X-Received: by 2002:a05:6000:184d:b0:385:f89a:402e with SMTP id ffacd0b85a97d-3862b34e4cdmr2738191f8f.14.1733515645369;
        Fri, 06 Dec 2024 12:07:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f59cc26sm5237038f8f.38.2024.12.06.12.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 12:07:24 -0800 (PST)
Message-Id: <35a7e4ec4d376ae57bf181b74f26ff67e1b1ac69.1733515638.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Dec 2024 20:07:18 +0000
Subject: [PATCH 5/5] backfill: assume --sparse when sparse-checkout is enabled
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
index cdee87e38af..225764f17e8 100644
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
@@ -136,5 +140,8 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 
 	repo_config(repo, git_default_config, NULL);
 
+	if (ctx.sparse < 0)
+		ctx.sparse = core_apply_sparse_checkout;
+
 	return do_backfill(&ctx);
 }
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index c2acd1339bd..eecf03d5199 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -77,6 +77,12 @@ test_expect_success 'do partial clone 2, backfill batch size' '
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
