Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF403D16E9
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183434; cv=none; b=cCFNAu++qdoSrrwDCcDx3PX/wePxw07wSzyRVHMzhxwsV4cfJ3RETUQJRYqIQ1ovAgNZMpHVDOv3eroaNg13UqaUDSLYeYuOGo00xE1YUpHwPDwpbJlHKMIgBcycYlcd3qpOXdBZxffLTsmP5pb3ymGRlGdqBXPVUfYuUKL2U1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183434; c=relaxed/simple;
	bh=Hahb7cxUrdioM/YjDjDBHBuEzzgS/AIjkh7+ck5DDg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VWGH7sO0DT1nIRZ3n2AQPThjnl18adYvC6FpNPSYNXoCArDhuECD+XOrvVMzWHefM068n+HxoB33NiM68bY8bm4wAmdNVXjftW2DulwmCWUqFY1tHkzVZB9jsUEkTyssgbOoFDLgZUEb11HHQZ48h8QlQlZ3yPNnd5IozF9ybi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HId7mxAZ; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HId7mxAZ"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a2ffee6so551503b6e.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790183430; x=1790788230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=knX321pnocR3ZF8YCVgJED3AlmmeYiRF7c9MUS3ZL1U=;
        b=HId7mxAZBP0lWDyzly9rVPL4CJcLBjHF2OxrljJWbFEmFJwoOLnW25bQY1PxSenwPE
         YHEIRfSJzm5vi7DL6/wIAA0otCxeYUzh2X/3d6tCAimJxswfVrm8pQawhajIKs84Ow6z
         NWx8OwW5SW2mziqQ5wj74TK0oYh/mlSjlv4BgCDghr7YPa/wXmePpVbClTme18FbnKHW
         y/45G4Jpt3nwAfdnPjfmYonr1pPNcujfVWBep5aKsBoJAzrpQmTwXxKnsPV1olcYcbjz
         xtLfTRI1vAONHyyQjYWmIcK6cKJhPHQifNkdyBvd70DSkcZZtdADtyXzTs1MC4FydJU6
         Zj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790183430; x=1790788230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=knX321pnocR3ZF8YCVgJED3AlmmeYiRF7c9MUS3ZL1U=;
        b=vmKgFPoEsMdrc95ZvTiY68D3aIKzH9cHoV3sVV+kr+UXN0sWBGx0FE/M8GjNRlTS6l
         fN1JaD2EslZygWRtVUVr33xYo7ORhFmZ4q316k4aiVJTGQCDEUHkvDsq+qgudTkOYfFw
         J7AmtPo6vxU6MwIDfC7rUUm2FAI7QRdv0OTtqRR61O95WO3MiV736rrNqxp7rox+sY7x
         YcbgVsROfxUbSLasDCty+elMN9cB3KsNZrjSZYotVdXO4iP1QmZxrA638Lzr3fjPnV2y
         ueoudidCcbtCnBnylT+GrDlOSNdvE/xNMsSg9rlD0BBLYWrfcODvc/BSfDx6exryCCrP
         ft0Q==
X-Gm-Message-State: AFuF++kxDy9e0snNAK01cXTaqE8wZquuBBe4IKpxZGOQOASNsaa00NdL
	6N5nGzw7bpcHdgW5DWCPY2lwgE9aXHjqgW96+ggzONdrgpApnpYU4M/P
X-Gm-Gg: AYBFou1YvVix8UiprK8sQmPVWpXSXeUPWE3YzxQ32LUxP/4LicrAs+EC6nC2TSLtWzJ
	9eZp77yIw+D0MrdL1ct+BcfB2uurTyhow8Wd0wlutwUvKdIhIbjzFjeIGkESuw//cTlW9Rb/kEY
	d6f+aCilbV18ymmwBAHsmgoXFEjQ4K9R0ptYxYmUECnre9J2VRU9tpd1e0AzITTBbXV23c606zJ
	7gpEmzR88RU8cvYbQ2bUKCWN3TIy8KfqD2gmrAsuBJcBAs/moMkbhjtF1EBa9lrdt5QbaTljgjP
	Y0b3xaPy+WBftll0TKu8kXzJ1IH4UKR+BLMlp4z3Cq4+Knt8Kuawu/B+E+CVFjogSroK7TSOczK
	wUMBsy0W4PuhneVDz3MylBzUNXYrvf55wV7nXj+ojgFByJbh+5gkOgMcrAfO8s29iTdqhdOLtEk
	YYADtWt9WtLod9OIrv6FU+U3G9AUemJ4BIkPxlT48sOeaqUM5wJYinCoPHt4tzL07skFPEauKgY
	si77L13j1MnpRsN+Az54mgF30RO8byEEO2UFlVN3cwMXH/u8muRsIBlR56eB+rmZTs/lS4gnDfA
	aPhcTx3ghovwFdiQHHOE4+2AnjlUdSv8Q92QBd1rJQPi2W+DDUcNxqamApmueNcLpdGmCViuggL
	jbjm7GLNnmG2GjTgwnuUGpxSPlImGquwNoBsNwHd7HoZzTf+eytnWJs6JBgM=
X-Received: by 2002:a05:6808:228a:b0:4b9:e5fa:8a11 with SMTP id 5614622812f47-4d5b9626216mr3038411b6e.22.1790183430272;
        Wed, 23 Sep 2026 10:10:30 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-816049b7b15sm3470670a34.24.2026.09.23.10.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:10:29 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 23 Sep 2026 13:10:09 -0400
Subject: [PATCH 2/2] ls-files: reuse cached untracked listings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-ls-files-untracked-cache-v1-2-08db4cc1efdb@gmail.com>
References: <20260923-ls-files-untracked-cache-v1-0-08db4cc1efdb@gmail.com>
In-Reply-To: <20260923-ls-files-untracked-cache-v1-0-08db4cc1efdb@gmail.com>
To: git@vger.kernel.org
Cc: Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>, 
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev

ls-files --cached --others --exclude-standard with a wildcard pathspec
walks the working tree on every invocation, even when status has already
cached its untracked directories.

Attach the existing untracked cache before loading standard excludes.
For whole-tree wildcard queries without a fixed prefix, read complete
cached listings and filter their results afterward. Preserve traversal
filtering for attribute and exclude pathspecs, which can reject a parent
directory independently of its children.

A normal status cache collapses untracked directories and may stop after
finding their first file. Rescan those entries while retaining complete
listings. Opt in from ls-files, which does not write the index, so the
saved status cache and its configured mode remain intact.

On a synthetic tree with 100,000 tracked files in 5,000 directories and
a few untracked files, five hyperfine runs after one warmup of the
pyproject.toml query average 361 ms before and 50 ms after with a normal
status cache. Directory opens fall from 5,058 to seven. A tree with 50,000
untracked files averages 659 ms before and 339 ms after over five
alternating runs; that case still expands the collapsed untracked
directories. Without an existing cache, traversal is unchanged.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 builtin/ls-files.c                | 11 +++++--
 dir.c                             | 62 +++++++++++++++++++++++++++++++++++++--
 dir.h                             |  2 ++
 t/perf/p3010-ls-files.sh          | 15 ++++++++++
 t/t7063-status-untracked-cache.sh | 60 +++++++++++++++++++++++++++++++++++++
 5 files changed, 144 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b044520f9e..da1804acf3 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -681,11 +681,16 @@ int cmd_ls_files(int argc,
 	if (repo_read_index(repo) < 0)
 		die("index file corrupt");
 
+	dir.untracked = repo->index->untracked;
+	dir.untracked_cache_expand = 1;
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
-	pl = add_pattern_list(&dir, EXC_CMDL, "--exclude option");
-	for (i = 0; i < exclude_list.nr; i++) {
-		add_pattern(exclude_list.items[i].string, "", 0, pl, --exclude_args);
+	if (!show_others || dir.flags || !dir.exclude_per_dir || with_tree)
+		dir.untracked = NULL;
+	if (exclude_list.nr) {
+		pl = add_pattern_list(&dir, EXC_CMDL, "--exclude option");
+		for (i = 0; i < exclude_list.nr; i++)
+			add_pattern(exclude_list.items[i].string, "", 0, pl, --exclude_args);
 	}
 
 	if (format && (show_stage || show_others || show_killed ||
diff --git a/dir.c b/dir.c
index 037780e556..eccd24e318 100644
--- a/dir.c
+++ b/dir.c
@@ -2974,6 +2974,27 @@ void remove_untracked_cache(struct index_state *istate)
 	}
 }
 
+static void expand_untracked_cache(struct untracked_cache *uc,
+				   struct untracked_cache_dir *dir)
+{
+	if (!dir)
+		return;
+	/* Re-read partial scans and listings containing collapsed directories. */
+	if (dir->check_only) {
+		invalidate_directory(uc, dir);
+		dir->check_only = 0;
+	} else {
+		for (size_t i = 0; i < dir->untracked_nr; i++) {
+			if (ends_with(dir->untracked[i], "/")) {
+				invalidate_directory(uc, dir);
+				break;
+			}
+		}
+	}
+	for (size_t i = 0; i < dir->dirs_nr; i++)
+		expand_untracked_cache(uc, dir->dirs[i]);
+}
+
 static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
 						      int base_len,
 						      const struct pathspec *pathspec,
@@ -3033,6 +3054,12 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 		return NULL;
 	}
 
+	/* Keep complete directory listings when expanding a normal-mode cache. */
+	if (dir->untracked_cache_expand && !dir->flags && dir->untracked->dir_flags == (DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES)) {
+		expand_untracked_cache(dir->untracked, dir->untracked->root);
+		dir->untracked->dir_flags = 0;
+	}
+
 	/*
 	 * If the untracked structure we received does not have the same flags
 	 * as requested in this run, we're going to need to either discard the
@@ -3141,6 +3168,16 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		   const char *path, int len, const struct pathspec *pathspec)
 {
 	struct untracked_cache_dir *untracked;
+	const struct pathspec *walk_pathspec = pathspec;
+	/* Attribute and exclude pathspecs can prune a directory by its own name. */
+	int filter = dir->untracked_cache_expand && dir->untracked &&
+		     !len && !dir->flags && pathspec && pathspec->nr &&
+		     !(pathspec->magic & (PATHSPEC_ATTR | PATHSPEC_EXCLUDE));
+
+	/* Keep the usual pruning for queries with a fixed prefix. */
+	for (int i = 0; filter && i < pathspec->nr; i++)
+		if (pathspec->items[i].nowildcard_len)
+			filter = 0;
 
 	trace2_region_enter("dir", "read_directory", istate->repo);
 	dir->internal.visited_paths = 0;
@@ -3151,15 +3188,34 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		return dir->nr;
 	}
 
-	untracked = validate_untracked_cache(dir, len, pathspec, istate);
+	untracked = validate_untracked_cache(dir, len,
+					     filter ? NULL : pathspec, istate);
 	if (!untracked)
 		/*
 		 * make sure untracked cache code path is disabled,
 		 * e.g. prep_exclude()
 		 */
 		dir->untracked = NULL;
-	if (!len || treat_leading_path(dir, istate, path, len, pathspec))
-		read_directory_recursive(dir, istate, path, len, untracked, 0, 0, pathspec);
+	else if (filter)
+		walk_pathspec = NULL;
+	if (!len || treat_leading_path(dir, istate, path, len, walk_pathspec))
+		read_directory_recursive(dir, istate, path, len, untracked, 0, 0,
+					 walk_pathspec);
+	if (filter && untracked) {
+		int dst = 0;
+
+		/* Cache complete listings; apply the query only to the results. */
+		for (int i = 0; i < dir->nr; i++) {
+			struct dir_entry *ent = dir->entries[i];
+
+			if (match_pathspec(istate, pathspec, ent->name, ent->len,
+					   0, NULL, 0))
+				dir->entries[dst++] = dir->entries[i];
+			else
+				free(dir->entries[i]);
+		}
+		dir->nr = dst;
+	}
 	QSORT(dir->entries, dir->nr, cmp_dir_entry);
 	QSORT(dir->ignored, dir->ignored_nr, cmp_dir_entry);
 
diff --git a/dir.h b/dir.h
index 83e0f648a8..3403816271 100644
--- a/dir.h
+++ b/dir.h
@@ -296,6 +296,8 @@ struct dir_struct {
 
 	/* Enable/update untracked file cache if set */
 	struct untracked_cache *untracked;
+	/* Allow expanding a normal-mode cache without saving it to the index. */
+	unsigned int untracked_cache_expand:1;
 
 	/**
 	 * Deprecated: ls-files is the only allowed caller; all other callers
diff --git a/t/perf/p3010-ls-files.sh b/t/perf/p3010-ls-files.sh
index ae14449432..59eaea000b 100755
--- a/t/perf/p3010-ls-files.sh
+++ b/t/perf/p3010-ls-files.sh
@@ -28,4 +28,19 @@ test_perf 'ls-files --modified with pathspec' '
 		-- "$pathspec" >/dev/null
 '
 
+test_perf 'ls-files --others with pathspec and no untracked cache' '
+	git -c core.fsmonitor=false -c core.untrackedCache=false \
+		ls-files --cached --others --exclude-standard -- "$pathspec" >/dev/null
+'
+
+test_expect_success 'populate the untracked cache' '
+	git config core.untrackedCache true &&
+	git -c core.fsmonitor=false status --porcelain >/dev/null
+'
+
+test_perf 'ls-files --others with pathspec and untracked cache' '
+	git -c core.fsmonitor=false ls-files --cached --others \
+		--exclude-standard -- "$pathspec" >/dev/null
+'
+
 test_done
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 10d4850077..ccfc354dad 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -991,4 +991,64 @@ test_expect_success 'empty repo (no index) and core.untrackedCache' '
 	git -C emptyrepo -c core.untrackedCache=true write-tree
 '
 
+test_expect_success 'ls-files expands cached directories and filters wildcard results' '
+	test_create_repo ls-files-cache &&
+	(
+		cd ls-files-cache &&
+		git config core.untrackedCache true &&
+		mkdir tracked untracked empty ignored-only &&
+		touch tracked/pyproject.toml untracked/pyproject.toml &&
+		touch untracked/other ignored-only/file &&
+		echo ignored-only/file >.gitignore &&
+		echo "*.toml selected" >.gitattributes &&
+		git add .gitignore .gitattributes tracked &&
+		git init nested.git &&
+		test-tool chmtime =-300 . tracked untracked empty ignored-only &&
+		for mode in normal all
+		do
+			# Normal mode rescans the root and three partial directories.
+			case "$mode" in
+			normal) opened=4 ;;
+			all) opened=0 ;;
+			esac &&
+			git config status.showUntrackedFiles "$mode" &&
+			git status --porcelain >/dev/null &&
+			cp .git/index ../saved-index &&
+			: >"$TRASH_DIRECTORY/ls-files.trace" &&
+			GIT_TRACE2_PERF="$TRASH_DIRECTORY/ls-files.trace" \
+				git ls-files --cached --others --exclude-standard -z \
+				-- "**/pyproject.toml" >../actual &&
+			printf "%s\0" untracked/pyproject.toml tracked/pyproject.toml \
+				>../expect &&
+			test_cmp ../expect ../actual &&
+			test_cmp_bin ../saved-index .git/index &&
+			test_grep "read_directo.*opendir:$opened\$" \
+				"$TRASH_DIRECTORY/ls-files.trace" &&
+			test_grep "read_directo.*gitignore-invalidation:0\$" \
+				"$TRASH_DIRECTORY/ls-files.trace" || return 1
+			for pathspec in "*.git/" ":(glob)**/*.toml" \
+				":(exclude)untracked/" ":(attr:selected)**/*.toml" \
+				"tracked/pyproject.toml"
+			do
+				GIT_DISABLE_UNTRACKED_CACHE=1 git ls-files --others \
+					--exclude-standard -- "$pathspec" >../expect &&
+				git ls-files --others --exclude-standard \
+					-- "$pathspec" >../actual &&
+				test_cmp ../expect ../actual || return 1
+			done || return 1
+		done
+	)
+'
+
+test_expect_success 'ls-files revalidates cached files and ignore rules' '
+	(
+		cd ls-files-cache &&
+		echo untracked/ >>.gitignore &&
+		touch tracked/new.toml empty/new.toml &&
+		git ls-files --others --exclude-standard -- "**/*.toml" >../actual &&
+		printf "%s\n" empty/new.toml tracked/new.toml >../expect &&
+		test_cmp ../expect ../actual
+	)
+'
+
 test_done

-- 
2.56.0.rc0.807.ga0c0929ce1.frankengit

