Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A427464F
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596232; cv=none; b=YWqdM0viTbouBjQhUk6rov02MWQUIGKyxbXxa4boynCfzZqu0fTuTECJtR52CQBHTximQRYt+x+9UF1T0/IMjBqu/6whSpI8UiFqAxjnf3IS+yMXfbduQx18wLIsfypd4OD7R724b7fwDVwDaGfStu2zsiD7uOrI9KjWjwYzYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596232; c=relaxed/simple;
	bh=Tm21jxTqrDaqxth/GGggL/VaAbDjuWVFW86GibA+PNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnQ0qLZKzc16t4zviEaozrlMDTHIvWXjKj6IUKD+rFXSrlNSpmJj5riYTy4okulKnuHJuvjIiKpUZaQwAtqTW/lDU4kEewE3A9hgllIagRsngr2/A6BAQQ5YiZYNYCFVyCTAbCB9ZoCUl4YUTY+zRd4uQ3Nt/Dh6+A7dl9AUK9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQOKIwsM; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQOKIwsM"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61bd4e002afso1179443eaf.2
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758596229; x=1759201029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TitLVpfe69fafY2eCYBO7KE4yvSaCCTwFJv7jFAIY9E=;
        b=FQOKIwsMcrmUy9FVEGVtJUqkdHgrCyT8eORk4WZ/uxvPfSPOAJU99l9Qw5zmBIYsBx
         RUlZ/7Tn5RYHvlRA3kYs07WUgaqtPRm6AslGFu+JsARjn0A7ZlTORgiIbKaNX9toSTCd
         /uKpwwJJ7eJynA1qvxSBB6Gi5b17LRaqmPt0onC9xvZEEO1R3pfQStvFVlOssmaHHf5q
         axIK0PVaHI1PXL48veFUZD4Ci8/YzLjMt8t51tDV3a2dxyu5zrMAwr+bX/Vw9f9Qmb2U
         TvgVOcHH/YgqJX9KjUk8ipuJ2uh0WYYbMqGxmxbmzT+xRoC02Y085AxHWRyVNG5KSBix
         Ig3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758596229; x=1759201029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TitLVpfe69fafY2eCYBO7KE4yvSaCCTwFJv7jFAIY9E=;
        b=pf6GHKGGGopQFg5A6X5nnmATBLMbHfIU1rxJDDQKntswdKxmijPWVOjflrvHyi/bnc
         SB/b/tvRe3mf4IgTiU4jje3BPaQs142xySXOIzAL+CRPw0T/ZqoadjswqwWxt7X/ux8g
         CtA+hoBXPZlex4cakgxlgSXXqpS5wCN4cSeNQpF37Y/3lHgc5Z4RC+ZJE/M/mFkaAhbM
         SmxM3k5M3LVC6kV+0BoZAnIM/dujxnakgfKUoxvsS/ECBG3Q2Dw6R3Kgq3qxsq+9Mp1U
         yhIoGtvD5Ve1fIA8pnQRa+CcxIm6YbakZ78Fp4NVc+nfTyGI+lohTwc/YooQxk41POVo
         1yAQ==
X-Gm-Message-State: AOJu0YyRwNFuVJqOybkbqJQXfG1jUZdp7sQJ7za2A7DZVqIfTH73aCi2
	Hn4/y3hOZZCzZ5VsKwHlL9STcNZN10Y2KNa14QkvJy77UWCvaQI6vOuNn4EXDQ==
X-Gm-Gg: ASbGncscJ0aDM4LYEpyThVuTepE0Tb4dV+ol5lwY12io5wx8nIpXcVoQmacxVsj8098
	Zqy0MnA5eSlEef8djQ6ifJm9jHqZx91OD2FATxxXKdKK472bVJ72xcN3WHjN/S7u8q20eFafBiS
	16zEcC3AmBu36HxNqUtitYjEhlSX8mtvPfFtWRANnVyzZp4gi/mUQwHkwDuF1h8V2sVO8HJrnET
	H8TfytqoqIq7b7iSgUeTWKjVtjCX9Tczpg7UAVEmB6tgpHxKB7Z+OYPXsRbBlRSlzovAS9v07Om
	j+/J5DKwY55ryorc/1/FDUHiVhlj+rdJqWDr/nVn2UHMEDC5hypHVJBxmcf9fabceUQmW9SBilG
	vY+L5SddivkwQKi24OVr6vDloKZtv5AA=
X-Google-Smtp-Source: AGHT+IH4c8VBjzuheXmiATTbRpRWV1Ixm63PKGqa7BRrVY1imaC/tMZRbtH/Mxp3pJ/smfL82mJXug==
X-Received: by 2002:a05:6820:60a:b0:623:48a7:d580 with SMTP id 006d021491bc7-63310593968mr630702eaf.1.1758596229295;
        Mon, 22 Sep 2025 19:57:09 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7692936963esm6431664a34.23.2025.09.22.19.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 19:57:08 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 4/4] builtin/repo: add nul format for stats
Date: Mon, 22 Sep 2025 21:57:00 -0500
Message-ID: <20250923025700.3046260-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250923025700.3046260-1-jltobler@gmail.com>
References: <20250923025700.3046260-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the `nul` mode for the --format option. When enabled, the
output is similar to the `keyvalue` mode, but key-values are delimited
by a NUL character instead of a newline. This allows stat values to
support special characters without having to cquote values.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-repo.adoc | 10 ++++---
 builtin/repo.c              | 52 ++++++++++++++++++++-----------------
 t/t1901-repo-stats.sh       | 27 +++++++++++++++++++
 3 files changed, 62 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 7d0341e4f1..57267064ea 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
-git repo stats [--format=(table|keyvalue)]
+git repo stats [--format=(table|keyvalue|nul)]
 
 DESCRIPTION
 -----------
@@ -44,12 +44,12 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
-`stats [--format=(table|keyvalue)]`::
+`stats [--format=(table|keyvalue|nul)]`::
 	Retrieve stats about the current repository. All references and
 	reachable objects in the repository are categorized and counted
 	accordingly.
 +
-The output format can be chosen through the flag `--format`. Two formats are
+The output format can be chosen through the flag `--format`. Three formats are
 supported:
 +
 `table`:::
@@ -61,6 +61,10 @@ supported:
 	Each line of output contains a key-value pair of a repostiory stat. The
 	'=' character is used to delimit between the key and the value.
 
+`nul`:::
+	Similar to 'keyvalue', but uses a NUL character to delimit between
+	key-value pairs instead of a newline.
+
 INFO KEYS
 ---------
 In order to obtain a set of values from `git repo info`, you should provide
diff --git a/builtin/repo.c b/builtin/repo.c
index 4c16a68e4e..37034e6347 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -14,7 +14,7 @@
 
 static const char *const repo_usage[] = {
 	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
-	"git repo stats [--format=(table|keyvalue)]",
+	"git repo stats [--format=(table|keyvalue|nul)]",
 	NULL
 };
 
@@ -291,27 +291,31 @@ static void stats_table_print(struct stats_table *table)
 	strbuf_release(&buf);
 }
 
-static void stats_print(struct stats *stats)
+static void stats_print(struct stats *stats, int nul_delim)
 {
 	struct strbuf buf = STRBUF_INIT;
-
-	strbuf_addf(&buf, "references.branches.count=%" PRIuMAX "\n",
-		    (uintmax_t)stats->refs.branches);
-	strbuf_addf(&buf, "references.tags.count=%" PRIuMAX "\n",
-		    (uintmax_t)stats->refs.tags);
-	strbuf_addf(&buf, "references.remotes.count=%" PRIuMAX "\n",
-		    (uintmax_t)stats->refs.remotes);
-	strbuf_addf(&buf, "references.others.count=%" PRIuMAX "\n",
-		    (uintmax_t)stats->refs.others);
-
-	strbuf_addf(&buf, "objects.commits.count=%" PRIuMAX "\n",
-		    (uintmax_t)stats->objects.commits);
-	strbuf_addf(&buf, "objects.trees.count=%" PRIuMAX "\n",
-		    (uintmax_t)stats->objects.trees);
-	strbuf_addf(&buf, "objects.blobs.count=%" PRIuMAX "\n",
-		    (uintmax_t)stats->objects.blobs);
-	strbuf_addf(&buf, "objects.tags.count=%" PRIuMAX "\n",
-		    (uintmax_t)stats->objects.tags);
+	char delim = '\n';
+
+	if (nul_delim)
+		delim = '\0';
+
+	strbuf_addf(&buf, "references.branches.count=%" PRIuMAX "%c",
+		    (uintmax_t)stats->refs.branches, delim);
+	strbuf_addf(&buf, "references.tags.count=%" PRIuMAX "%c",
+		    (uintmax_t)stats->refs.tags, delim);
+	strbuf_addf(&buf, "references.remotes.count=%" PRIuMAX "%c",
+		    (uintmax_t)stats->refs.remotes, delim);
+	strbuf_addf(&buf, "references.others.count=%" PRIuMAX "%c",
+		    (uintmax_t)stats->refs.others, delim);
+
+	strbuf_addf(&buf, "objects.commits.count=%" PRIuMAX "%c",
+		    (uintmax_t)stats->objects.commits, delim);
+	strbuf_addf(&buf, "objects.trees.count=%" PRIuMAX "%c",
+		    (uintmax_t)stats->objects.trees, delim);
+	strbuf_addf(&buf, "objects.blobs.count=%" PRIuMAX "%c",
+		    (uintmax_t)stats->objects.blobs, delim);
+	strbuf_addf(&buf, "objects.tags.count=%" PRIuMAX "%c",
+		    (uintmax_t)stats->objects.tags, delim);
 
 	fwrite(buf.buf, sizeof(char), buf.len, stdout);
 	strbuf_release(&buf);
@@ -408,9 +412,6 @@ static int repo_stats(int argc, const char **argv, const char *prefix,
 	struct rev_info revs;
 
 	parse_options(argc, argv, prefix, options, repo_usage, 0);
-	if (format == FORMAT_NUL_TERMINATED)
-		die(_("nul format not yet supported"));
-
 	repo_init_revisions(repo, &revs, prefix);
 	filter.name_patterns = ref_patterns.v;
 	filter_refs(&refs, &filter, FILTER_REFS_REGULAR);
@@ -424,7 +425,10 @@ static int repo_stats(int argc, const char **argv, const char *prefix,
 		stats_table_print(&table);
 		break;
 	case FORMAT_KEYVALUE:
-		stats_print(&stats);
+		stats_print(&stats, 0);
+		break;
+	case FORMAT_NUL_TERMINATED:
+		stats_print(&stats, 1);
 		break;
 	default:
 		BUG("not a valid output format: %d", format);
diff --git a/t/t1901-repo-stats.sh b/t/t1901-repo-stats.sh
index 5bc6d9d5c4..061b2fbbc1 100755
--- a/t/t1901-repo-stats.sh
+++ b/t/t1901-repo-stats.sh
@@ -127,4 +127,31 @@ test_expect_success 'repository stats with keyvalue format' '
 	)
 '
 
+test_expect_success 'repository stats with nul format' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 42 &&
+		git tag -a foo -m bar &&
+		git repo stats --format=nul >out 2>err &&
+
+		cat >expect <<-EOF &&
+		references.branches.count=1
+		references.tags.count=1
+		references.remotes.count=0
+		references.others.count=0
+		objects.commits.count=42
+		objects.trees.count=42
+		objects.blobs.count=42
+		objects.tags.count=1
+		EOF
+
+		tr "\n" "\0" <expect >expect_null &&
+
+		test_cmp expect_null out &&
+		test_line_count = 0 err
+	)
+'
+
 test_done
-- 
2.51.0.193.g4975ec3473b

