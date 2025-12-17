Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7D0346AFF
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765994056; cv=none; b=sX8XU7vlsBwRlB/55MDVqPMPDfcm9VbcsUuBOY5miJxjA/rCgY4XFNJkRJIXnQPyiYAY6evrOBC9xuXSxInOpxql7LMFs4+mk4c4KHds6SHcKSsZM1EM0sPduPJ4ZVdRLztQ4dVfTXeFr6ropNo8kerRYX/su/RHtun5E1gAHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765994056; c=relaxed/simple;
	bh=k+s6/Mv22f0T45ZZ45vK8ZB9zwjKS+y1A/X+mWt4U3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1ubeFfLwNkxP8bq7wHc1HrJUAFy1qS8ykTgQ0ep6yzFkKrqjGw4B2+Eb+WbFuDaHKxO/U7247jAun0JzLaI6j6hNxCWepAj4LmQoUF1cE7WZ217yy4HAZXRwcpoJRPSKy6SSb1UUI017mUQxQ2j2vJewDm1fZXDdikzq0G3wxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNVmmRiL; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNVmmRiL"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3fa139e5d90so93839fac.3
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 09:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765994054; x=1766598854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVeJqYvZJDVoAgzTj7SMsMCEEqZ6SAk2dsylqML2VeY=;
        b=FNVmmRiL+R85RnWwKzLpAu6Ec9QXqqu04E0P4vbR6qJKF+IMLtIpNQwE4vTrLXeKjE
         +In4NkusFpflR+yzcLkR2znFrciBnjzYyOgjEDlZcEpEcfsMjl1WyGMqs5nyfWL086Sl
         /Ob7QZUraxNfp0m8SCzB9MOXlskU6c9xwuroscfGHHubhragIeX1/bKfk5TE0a1OdREG
         mzpGjUkqUiqa4fcp0mU0EAZNb9DUcs6CCdCk8kPs7BmDqPgCdNCSh8ui2k4p1Y3B42Vz
         pFHjM0SR6g54d4t9Vbset3AFhrXkrajP7hB4WjkVBCyfqt+dT0g6NMep0zSCAk2gJ4MD
         5aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765994054; x=1766598854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fVeJqYvZJDVoAgzTj7SMsMCEEqZ6SAk2dsylqML2VeY=;
        b=LpieK0HShxgXzNNER70Qswei21EqHD/beWtIldxnxx+FePDeEeMfIGMcWQprmHWOD2
         axuLCvZi84otWndH5PsQDs/RxGO4yS5Aowc5C8WkK/rES7LHlbMMn0VvKcPAz+2PvjyZ
         flE/cwYkBls2jitdqq3oCKjMnq/bw8/10AAq+nxXw8SrO8729bNWs2TUG+HeENnV4qkw
         yGUsA9nQD1M7BG1XedMy6z5OEF6/5nHIaZw2ohViSqE6lXtWLAUdYX+MIrP9isxELqex
         iVOO66UZxTCP9Z/+5nAZNYCqcIT66BSuYeKE67nYJzrTxd7tNh50kBIHFfm3rA+q6eJ8
         MUTA==
X-Gm-Message-State: AOJu0YyOOpdAu+vJuLka1eu8hMTMM/Tq8McdNFP5jq4cHBQlTv4ApgyF
	9K2SjYSQ38lQ+0gyGJ8MH9c9evj4dvVlSy6l+VWHWIKarXiOpkspt/xnSuNaiw==
X-Gm-Gg: AY/fxX54j87gRXhaONTOYaMz4kXSTYZPfTvPlshqCkOdCm9WKXi+uxkEtyhzN1kxI0c
	+DRayHs8X3ZYzIfLgFBBJuAUlIx25XciUTopLscVRaYDovCtdakV44Lv0YTDbSJRZK1ZxqljXjP
	hcnw+45D0+Wv9cD21eEZy1vsXblYjyEsvO4BZ3E5E3bu0ItNoTfMcaWLYL55iwU/O0ZsQkGfNUy
	ZUqUUxtiyraosaZelRfyJk5nxTF377wfiHPTrX9catjZ+7gM5Yn03Z+9FB/mrt8EDbnHAMM09La
	Wl8o1C8UxJVdu0jfo6RzK2yfVgwUjhdUOgk9HMOe3EF5ZbTpL27HNiqgTvGaj4IPtBnfLxDsB0V
	Z9Tea/jus4M/jJ8lFT9WONRJnO4Fq4ry/eN8dnL0N/ah0aTSyJeqtQ/+X0JBtv4OljbOAm17RHF
	2WZKQ6+gadaVsHHsU2lRO2cPlM8wYazg==
X-Google-Smtp-Source: AGHT+IEU0Vg80qxrv+cthkuk5Sxbat/PJPQF8V2CLTaYIMBeubGhy+KVZFm7mZa5KviC/hL5/57vxQ==
X-Received: by 2002:a05:6870:400d:b0:3e8:95d2:389d with SMTP id 586e51a60fabf-3f5f8c77597mr8333175fac.43.1765994053651;
        Wed, 17 Dec 2025 09:54:13 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fa17f4b879sm20058fac.14.2025.12.17.09.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 09:54:13 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 7/7] builtin/repo: add object disk size info to structure table
Date: Wed, 17 Dec 2025 11:54:04 -0600
Message-ID: <20251217175404.37963-8-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251217175404.37963-1-jltobler@gmail.com>
References: <20251216173842.3357832-1-jltobler@gmail.com>
 <20251217175404.37963-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to a prior commit, update the table output format for the
git-repo(1) structure command to display the total object disk usage by
object type.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c            | 13 +++++++++++++
 t/t1901-repo-structure.sh | 31 ++++++++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 7ea051f3af..09bc8fccfd 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -324,6 +324,7 @@ static void stats_table_setup_structure(struct stats_table *table,
 	struct ref_stats *refs = &stats->refs;
 	size_t inflated_object_total;
 	size_t object_count_total;
+	size_t disk_object_total;
 	size_t ref_total;
 
 	ref_total = get_total_reference_count(refs);
@@ -358,6 +359,18 @@ static void stats_table_setup_structure(struct stats_table *table,
 			      "    * %s", _("Blobs"));
 	stats_table_size_addf(table, objects->inflated_sizes.tags,
 			      "    * %s", _("Tags"));
+
+	disk_object_total = get_total_object_values(&objects->disk_sizes);
+	stats_table_size_addf(table, disk_object_total,
+			      "  * %s", _("Disk size"));
+	stats_table_size_addf(table, objects->disk_sizes.commits,
+			      "    * %s", _("Commits"));
+	stats_table_size_addf(table, objects->disk_sizes.trees,
+			      "    * %s", _("Trees"));
+	stats_table_size_addf(table, objects->disk_sizes.blobs,
+			      "    * %s", _("Blobs"));
+	stats_table_size_addf(table, objects->disk_sizes.tags,
+			      "    * %s", _("Tags"));
 }
 
 static void stats_table_print_structure(const struct stats_table *table)
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index dd17caad05..435fd979fa 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -5,8 +5,20 @@ test_description='test git repo structure'
 . ./test-lib.sh
 
 object_type_disk_usage() {
-	git rev-list --all --objects --disk-usage --filter=object:type=$1 \
-		--filter-provided-objects
+	disk_usage_opt="--disk-usage"
+
+	if test "$2" = "true"
+	then
+		disk_usage_opt="--disk-usage=human"
+	fi
+
+	if test "$1" = "all"
+	then
+		git rev-list --all --objects $disk_usage_opt
+	else
+		git rev-list --all --objects $disk_usage_opt \
+			--filter=object:type=$1 --filter-provided-objects
+	fi
 }
 
 test_expect_success 'empty repository' '
@@ -35,6 +47,11 @@ test_expect_success 'empty repository' '
 		|     * Trees          |    0 B |
 		|     * Blobs          |    0 B |
 		|     * Tags           |    0 B |
+		|   * Disk size        |    0 B |
+		|     * Commits        |    0 B |
+		|     * Trees          |    0 B |
+		|     * Blobs          |    0 B |
+		|     * Tags           |    0 B |
 		EOF
 
 		git repo structure >out 2>err &&
@@ -58,7 +75,10 @@ test_expect_success SHA1 'repository with references and objects' '
 		# Also creates a commit, tree, and blob.
 		git notes add -m foo &&
 
-		cat >expect <<-\EOF &&
+		# The tags disk size is handled specially due to the
+		# git-rev-list(1) --disk-usage=human option printing the full
+		# "byte/bytes" unit string instead of just "B".
+		cat >expect <<-EOF &&
 		| Repository structure | Value      |
 		| -------------------- | ---------- |
 		| * References         |            |
@@ -79,6 +99,11 @@ test_expect_success SHA1 'repository with references and objects' '
 		|     * Trees          |  15.81 MiB |
 		|     * Blobs          |  11.68 KiB |
 		|     * Tags           |    132 B   |
+		|   * Disk size        | $(object_type_disk_usage all true) |
+		|     * Commits        | $(object_type_disk_usage commit true) |
+		|     * Trees          | $(object_type_disk_usage tree true) |
+		|     * Blobs          |  $(object_type_disk_usage blob true) |
+		|     * Tags           |    $(object_type_disk_usage tag) B   |
 		EOF
 
 		git repo structure >out 2>err &&
-- 
2.52.0.209.ge85ae279b0

