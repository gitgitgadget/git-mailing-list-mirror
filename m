Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ABB7CF1F
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130301; cv=none; b=NGt4Rpiw13tpQDzZ+k1iugXgXHKrevK/+RD3JI/M6p9y7FjDmXlecOoNIbSU/fYVbuuOFfMekN36cj4gQ+6SQckzjlGZ80PomcqmmY6ZFeDt/HuMJGhNDZkSGwDntdBCXwQ1VMj/oRmviLVXubkMPIwcuVyA2SF/Eh60tOydsYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130301; c=relaxed/simple;
	bh=tGtsJofvSvhZ0ZVew0HDFJNUUpQMeJusNyNhaUODxHU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tIhL4oVml5Aaez9aUv/IGLuzDcqHCwRs+s2fO2SrM6zjo+DVAZkkMMBSe5OGs+3uUeG8/RNN/Xt/vsdMbVO+ZHfT027KF8V4P8m/7vbF1MDBhsYpRW5sGhlafWV+60WG/Di6iPadg1/WNa5jQS+42TvYO17x758K4+k36kd4shY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt74/t5/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt74/t5/"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52bc274f438so2024478e87.0
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130298; x=1718735098; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idJZ59EWsSrU43wYm3Pcom/btKl7U/TKe7C44QSShX4=;
        b=gt74/t5/QzfZuSTbPWh/+DPxSi5/mLbyGrqkCNCdXqRvtFziGf8c/fk+KT0BEaddRf
         T/NmRFYWckUS05BxwcHdMA4oEtt7gn/BqXOkPAOzqfOABrrsidOvcoUzUT6ZeAXRfwtX
         JbFdU1A3mGJPaYkpgHtXEhsjvbmq+0woQdsxkCfkjGxSxozjmbTkdyRMSy71EPjVZ9z8
         jHj9R60S/dmfuPqOzP45pAN+mzG9oVJ4PUUz8TQ735lcpsBBG6tP7f3fGvm9PdjL/1pa
         cTgHP7b8P5IyaYgIQB4YX4ZJ+rgV7CtFJa4VAW5lVMonDIIGPJkBhS+VU/HGi92ptyUh
         c7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130298; x=1718735098;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idJZ59EWsSrU43wYm3Pcom/btKl7U/TKe7C44QSShX4=;
        b=VUzb+gk5osh7QSqtKuxhYDos/Gs/7GuM3NookihWHEaIj1k5jXuKdPRxJSmgKNfD2a
         TNIAXLZdLWA77iBlPWefoziHT3Xb0OD8t2o3LoN1p/azkxHeoJ5SDqFKWPGTuQMWXeJ0
         RiSF0ofmVGN0JUrCSmU/DhrntsBCPih51YDiHV9PkyTxahsfC6to4zfr7huLWlTrENDN
         OcyXZF8nP/5MxGkg/v+N4z0+63AjRT81ppAzh4h9OiohkWJ3mkkSR36RCjRYEReWdPSt
         Q2xrBhXVtg0aXiKqaDmhMCBewVKVN2xmWDqq1uXdep2oB8eanbk7KQhBYEIgWp9p3p4D
         ci8w==
X-Gm-Message-State: AOJu0YyyDKDbHkR6jLtFa5SfHwy5dIon4NPr7YkqebZEEVVFPlcnXrxo
	GtX46EStijotF1ryqnZj/hVWGc9tjna1LrI9RZYfsE3t+1dZcdXDoMH37A==
X-Google-Smtp-Source: AGHT+IFc0DgOSoee+P/sXQUaiUI8qcGB/XTjo0BYQQqPIqM9AEV4Psf5gy+T49f9qpGXrlSWGmZ2gA==
X-Received: by 2002:a05:6512:3a8b:b0:52c:8a21:b2a9 with SMTP id 2adb3069b0e04-52c8a21b9e5mr5495461e87.58.1718130297857;
        Tue, 11 Jun 2024 11:24:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158148f66sm225962355e9.32.2024.06.11.11.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:24:57 -0700 (PDT)
Message-Id: <4f9f77e693cfc4fbe72a2ae739bc7e236a3b82d3.1718130288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 18:24:41 +0000
Subject: [PATCH 09/16] mktree: validate paths more carefully
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
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Use 'verify_path' to validate the paths provided as tree entries, ensuring
we do not create entries with paths not allowed in trees (e.g., .git). Also,
remove trailing slashes on directories before validating, allowing users to
provide 'folder-name/' as the path for a tree object entry.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/mktree.c  | 20 +++++++++++++++++---
 t/t1010-mktree.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 48019448c1f..29e9dc6ce69 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -8,6 +8,7 @@
 #include "hex.h"
 #include "index-info.h"
 #include "quote.h"
+#include "read-cache-ll.h"
 #include "strbuf.h"
 #include "tree.h"
 #include "parse-options.h"
@@ -49,10 +50,23 @@ static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
 {
 	struct tree_entry *ent;
 	size_t len = strlen(path);
-	if (!literally && strchr(path, '/'))
-		die("path %s contains slash", path);
 
-	FLEX_ALLOC_MEM(ent, name, path, len);
+	if (literally) {
+		FLEX_ALLOC_MEM(ent, name, path, len);
+	} else {
+		/* Normalize and validate entry path */
+		if (S_ISDIR(mode)) {
+			while(len > 0 && is_dir_sep(path[len - 1]))
+				len--;
+		}
+		FLEX_ALLOC_MEM(ent, name, path, len);
+
+		if (!verify_path(ent->name, mode))
+			die(_("invalid path '%s'"), path);
+		if (strchr(ent->name, '/'))
+			die("path %s contains slash", path);
+	}
+
 	ent->mode = mode;
 	ent->len = len;
 	oidcpy(&ent->oid, oid);
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index e0687cb529f..e0263cb2bf8 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -173,4 +173,37 @@ test_expect_success '--literally can create invalid trees' '
 	grep "not properly sorted" err
 '
 
+test_expect_success 'mktree validates path' '
+	tree_oid="$(cat tree)" &&
+	blob_oid="$(git rev-parse $tree_oid:a/one)" &&
+	head_oid="$(git rev-parse HEAD)" &&
+
+	# Valid: tree with or without trailing slash, blob without trailing slash
+	{
+		printf "040000 tree $tree_oid\tfolder1/\n" &&
+		printf "040000 tree $tree_oid\tfolder2\n" &&
+		printf "100644 blob $blob_oid\tfile.txt\n"
+	} | git mktree >actual &&
+
+	# Invalid: blob with trailing slash
+	printf "100644 blob $blob_oid\ttest/" |
+	test_must_fail git mktree 2>err &&
+	grep "invalid path ${SQ}test/${SQ}" err &&
+
+	# Invalid: dotdot
+	printf "040000 tree $tree_oid\t../" |
+	test_must_fail git mktree 2>err &&
+	grep "invalid path ${SQ}../${SQ}" err &&
+
+	# Invalid: dot
+	printf "040000 tree $tree_oid\t." |
+	test_must_fail git mktree 2>err &&
+	grep "invalid path ${SQ}.${SQ}" err &&
+
+	# Invalid: .git
+	printf "040000 tree $tree_oid\t.git/" |
+	test_must_fail git mktree 2>err &&
+	grep "invalid path ${SQ}.git/${SQ}" err
+'
+
 test_done
-- 
gitgitgadget

