Received: from mail-oi2-f42.google.com (mail-oi2-f42.google.com [74.125.231.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF0415F32
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202445; cv=none; b=J3X6UMmZhhgqsiiw8TNw9j86Zuy1Zmwfz7+5djW4b1J/fZ5XgjzTPgD3bH347dMgN7KzUQihXQUfGX/lQ9A2jKNTyaIoknsREGOgqMo7HyJWfjd+2tAUjV70NDJiknR/jyI6iIjK/vr1fJNgbR2haikwfZ7jKgUX3bACfyPYGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202445; c=relaxed/simple;
	bh=3UxIRGaSPD7YjXy0istXND18uD8AL98I3O5VaqhHkvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pUcksnkAfU0f3zYM6A1/oJaCio/ArpkEEmFKpc6x/8IV9X46viK1MwlVl1+GM44cLSSDmxlA2rmmcoqysrD91wHPVawXKvagIWZZhJZQ6wWbJc8dtTl1pt/aT3Y60fBLbq6+3miaKnAGS7P4EDTuNDIirXv9W7IHMWCFZtthTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRVudnPD; arc=none smtp.client-ip=74.125.231.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRVudnPD"
Received: by mail-oi2-f42.google.com with SMTP id 46e09a7af769-8175f76732eso217880a34.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 15:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202442; x=1790807242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tlEG5Gn+NgScsKyVfO89Ie4St+PeHzNOflIArwgV3So=;
        b=SRVudnPDWqmst2KQWEaiCYT2JTAknIKBwsicZ/rktb1gfUetjzcmIxB++Hq96Oy6Fo
         kRsdAdRamGhzRS7clHMRNrS3oTUmAqVgh7Ipl4bxhRDkc5N0xe+RVrWW+o6s9sPtHFxR
         SdpLF+YP8rIPW4ouI8PvpGDjrxkhrAI9Na9HaRgdnrF75STGXrasfYmLMXVS9a30EfEz
         BZyU3fB5CVVa0nsmyHCzdSeGk6oLEHhRuQK3nuujFHaxrhqpF2JrsK6s53JzCXK9QJbc
         dBIbVm0O+WyCbz5L85vFsAi8KPzjP7oSgf8li1+7qjOsprfuSbxR8y+cWlKc5Nk1KcfI
         RNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202442; x=1790807242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tlEG5Gn+NgScsKyVfO89Ie4St+PeHzNOflIArwgV3So=;
        b=t51bv8sWZvMBu892DRR9cb+0TexVH1WsNp7C7JwLtmExoLRYy4slDMOBz5fF7dsf81
         XoEQbiim3iGrF0lIcw1exHIUpPbbc3SAVnWW0hSVPNlchsJId6ovsEOz/hp3YgAgaqjh
         GEsBIYKCvVOT04mNkPgwS21mbdoVopPfi1HuHKjZNZmO1B3xGjbqaGommVi9AJ8BQ5n0
         lvGRBiYVYe82yGoDvwGZaMf4NBRUZKeQsoK6CD79qmnN/0EIOsJjwOWROUJghoM7pJkE
         ZEuDLbS5sQXTWkntLepu6ej/aezGo8291oxaca3fWnKG/ngYCb8iFkmWdXrjzidbAwsE
         G7Vw==
X-Gm-Message-State: AFuF++lK429HJWk0eYNn8p5RaohysPKQkXGTnePW0/kpgQPUcFSou0GV
	gYOKW2Uy4Y3g2Y5DgLKPLs0LIQDmgH1rIh63ZgNt86rDOh9BquemA8JE
X-Gm-Gg: AYBFou0Jqk1XgZaZ3zWxoa7dhY7gixPL1drgxVGDcB5SNlVzfG/EK+5mHlv7rgslzdR
	MhDM3o99bc4+RhOpX+i0Dsd8uc9woDiEcUwLZNbS9mKowEdKalFLbqoNGpAzotfM61NOhpx0/an
	0CEq7tunoavZIGUau/rrwylsXDtBt5H2wR3FlxbsAKma4mrGOnk3S5FHPbTur6ONxj5MklWtOWJ
	zXI1YztHFEA/Ku8BG6URGBiu6DO4d5l+QS6imsU5f0sM5ZkxjNc1IiD9VoM++hmM5H+0mG7BGJv
	FQ2QD1H0z+r8vFA/WPoIjP6Tbkmld4P6gkkWEpJDQKLhqwP26dMbXVV9QgK+HOXMw/cadOjDSp0
	azjtUFGl/MMTJoh7VSqKug/2ue2PLdijpqynBqLJgjYt+Xm1KjfCdhzWRyiIP2K3Q2z+wdw1Zw6
	vn+sJmEo6W+C5yaVlxhsf3PGyW7K/0iJWiyQUIcDiD1L5wrdO0kIEQs0sf+Di7XGFIA//aiAoh0
	z9UWptzO2ryZTrQNRmKVDydohDDlUiqj9152mCUjSuxPrv2+sRqopegZJjNLOxYn8AufPQkLmeC
	K5tjzpBMPq/bJ6uyz+C9Le3tpsHiuvF4+H0ccSAwNO2LRybpEaP5pgDOSytW7SwJwRQ84TiSiSP
	tmf4rVumaHU8R8K6zG2HBSntlvf0pIb4TUW1yh8OgJjANUnkAYsrHzQx0UrCNGwwo1IEBJ/c=
X-Received: by 2002:a05:6830:638b:b0:806:1e7:4167 with SMTP id 46e09a7af769-8178327bb2fmr711785a34.13.1790202441869;
        Wed, 23 Sep 2026 15:27:21 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81603ad0f20sm4727670a34.9.2026.09.23.15.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:27:20 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 23 Sep 2026 18:27:00 -0400
Subject: [PATCH v2 3/3] ls-files: use and update the untracked cache
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-ls-files-untracked-cache-v2-3-d7ee33476eb8@gmail.com>
References: <20260923-ls-files-untracked-cache-v2-0-d7ee33476eb8@gmail.com>
In-Reply-To: <20260923-ls-files-untracked-cache-v2-0-d7ee33476eb8@gmail.com>
To: git@vger.kernel.org
Cc: Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>, 
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1790202426; l=16548;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=3UxIRGaSPD7YjXy0istXND18uD8AL98I3O5VaqhHkvU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPnKLVVKkalszxsnCKMJyt6E44s4yht+e8Lkb40NYfqD9ozPZ7GWFzEVdlTWk8X1cnYYWuJCrZ7
 V0HjSyKtSvQ8=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Repeated 'git ls-files --cached --others --exclude-standard' calls scan
the working tree even when 'git status' has populated an untracked cache.
Reuse those listings and write pending untracked cache and fsmonitor
updates back to the index when optional locking is enabled, so later
commands can reuse the work.

Parse options before reading the index so eligible calls can take the
optional lock first. With index.skipHash, the index checksum cannot be
used to detect concurrent index changes. Record the object IDs of the
standard exclude files before assigning dir->untracked, so the exclude
options can be processed in the same order before reading the index.

A pathspec prefix can prune the in-memory index, and --with-tree can add
entries to it. Do not write the index in those cases. Respect
--no-optional-locks and continue without writing when the index lock is
busy.

Assisted-by: LLM
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Documentation/git-ls-files.adoc    |  4 ++
 builtin/ls-files.c                 | 40 +++++++++++++---
 dir.c                              | 28 +++++------
 t/perf/p3010-ls-files.sh           | 15 ++++++
 t/t3001-ls-files-others-exclude.sh | 20 ++++++++
 t/t7063-status-untracked-cache.sh  | 97 ++++++++++++++++++++++++++++++++++++++
 t/t7519-status-fsmonitor.sh        | 44 +++++++++++++++++
 7 files changed, 227 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-ls-files.adoc b/Documentation/git-ls-files.adoc
index 2b175388e1..11323b4ba9 100644
--- a/Documentation/git-ls-files.adoc
+++ b/Documentation/git-ls-files.adoc
@@ -127,6 +127,10 @@ OPTIONS
 --exclude-standard::
 	Add the standard Git exclusions: .git/info/exclude, .gitignore
 	in each directory, and the user's global exclusion file.
++
+With `--others`, an enabled untracked cache can be updated in the index
+after a complete traversal. Use `--no-optional-locks` (see linkgit:git[1])
+to disable this optional index update.
 
 --error-unmatch::
 	If any <file> does not appear in the index, treat this as an
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b044520f9e..e74ffa344d 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -15,6 +15,7 @@
 #include "quote.h"
 #include "dir.h"
 #include "gettext.h"
+#include "lockfile.h"
 #include "object-name.h"
 #include "strbuf.h"
 #include "parse-options.h"
@@ -597,6 +598,8 @@ int cmd_ls_files(int argc,
 	struct dir_struct dir = DIR_INIT;
 	struct pattern_list *pl;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
+	struct lock_file index_lock = LOCK_INIT;
+	int index_fd = -1;
 	struct option builtin_ls_files_options[] = {
 		/* Think twice before adding "--nul" synonym to this */
 		OPT_SET_INT('z', NULL, &line_terminator,
@@ -678,14 +681,13 @@ int cmd_ls_files(int argc,
 		prefix_len = strlen(prefix);
 	repo_config(repo, git_default_config, NULL);
 
-	if (repo_read_index(repo) < 0)
-		die("index file corrupt");
-
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
-	pl = add_pattern_list(&dir, EXC_CMDL, "--exclude option");
-	for (i = 0; i < exclude_list.nr; i++) {
-		add_pattern(exclude_list.items[i].string, "", 0, pl, --exclude_args);
+	/* Even an empty command-line exclude list would disable the cache. */
+	if (exclude_list.nr) {
+		pl = add_pattern_list(&dir, EXC_CMDL, "--exclude option");
+		for (i = 0; i < exclude_list.nr; i++)
+			add_pattern(exclude_list.items[i].string, "", 0, pl, --exclude_args);
 	}
 
 	if (format && (show_stage || show_others || show_killed ||
@@ -747,6 +749,25 @@ int cmd_ls_files(int argc,
 		max_prefix = common_prefix(&pathspec);
 	max_prefix_len = get_common_prefix_len(max_prefix);
 
+	/*
+	 * Do not save an index pruned by a pathspec or changed by --with-tree.
+	 * With index.skipHash, the checksum cannot detect concurrent index
+	 * changes. Lock the index before reading it.
+	 */
+	if (show_others && !dir.flags && dir.exclude_per_dir &&
+	    !max_prefix && !with_tree && use_optional_locks() &&
+	    !dir.internal.unmanaged_exclude_files && !exclude_list.nr &&
+	    repo->settings.core_untracked_cache != UNTRACKED_CACHE_REMOVE)
+		index_fd = repo_hold_locked_index(repo, &index_lock, 0);
+	if (repo_read_index(repo) < 0)
+		die("index file corrupt");
+	if (show_others && !dir.flags && dir.exclude_per_dir && !with_tree)
+		dir.untracked = repo->index->untracked;
+	if (index_fd >= 0 && !dir.untracked) {
+		rollback_lock_file(&index_lock);
+		index_fd = -1;
+	}
+
 	prune_index(repo->index, max_prefix, max_prefix_len);
 
 	/* Treat unmatching pathspec elements as errors */
@@ -784,6 +805,13 @@ int cmd_ls_files(int argc,
 		ret = 1;
 	}
 
+	if (index_fd >= 0) {
+		if (!ret && dir.untracked)
+			repo_update_index_if_able(repo, &index_lock);
+		else
+			rollback_lock_file(&index_lock);
+	}
+
 	string_list_clear(&exclude_list, 0);
 	dir_clear(&dir);
 	free(max_prefix);
diff --git a/dir.c b/dir.c
index 425fe2af67..949f06c8f7 100644
--- a/dir.c
+++ b/dir.c
@@ -1209,7 +1209,8 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 		close(fd);
 		if (oid_stat) {
 			int pos;
-			if (oid_stat->valid &&
+			/* Racy stat checks need the index timestamp. */
+			if (istate && oid_stat->valid &&
 			    !match_stat_data_racy(istate, &oid_stat->stat, &st))
 				; /* no content change, oid_stat->oid still good */
 			else if (istate &&
@@ -1321,18 +1322,15 @@ struct pattern_list *add_pattern_list(struct dir_struct *dir,
 }
 
 /*
- * Used to set up core.excludesfile and .git/info/exclude lists.
+ * Only the standard exclude files have object IDs saved in the untracked
+ * cache. Other files have no oid_stat and must disable use of the cache.
  */
 static void add_patterns_from_file_1(struct dir_struct *dir, const char *fname,
 				     struct oid_stat *oid_stat)
 {
 	struct pattern_list *pl;
-	/*
-	 * catch setup_standard_excludes() that's called before
-	 * dir->untracked is assigned. That function behaves
-	 * differently when dir->untracked is non-NULL.
-	 */
-	if (!dir->untracked)
+
+	if (!oid_stat)
 		dir->internal.unmanaged_exclude_files++;
 	pl = add_pattern_list(dir, EXC_FILE, fname);
 	if (add_patterns(fname, "", 0, pl, NULL, 0, oid_stat) < 0)
@@ -1341,7 +1339,6 @@ static void add_patterns_from_file_1(struct dir_struct *dir, const char *fname,
 
 void add_patterns_from_file(struct dir_struct *dir, const char *fname)
 {
-	dir->internal.unmanaged_exclude_files++; /* see validate_untracked_cache() */
 	add_patterns_from_file_1(dir, fname, NULL);
 }
 
@@ -3009,10 +3006,7 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 
 	/*
 	 * We only support $GIT_COMMON_DIR/info/exclude and core.excludesfile
-	 * as the global ignore rule files. Any other additions
-	 * (e.g. from command line) invalidate the cache. This
-	 * condition also catches running setup_standard_excludes()
-	 * before setting dir->untracked!
+	 * as the global ignore rule files. Other exclude files bypass the cache.
 	 */
 	if (dir->internal.unmanaged_exclude_files)
 		return NULL;
@@ -3511,17 +3505,21 @@ void setup_standard_excludes(struct dir_struct *dir)
 
 	dir->exclude_per_dir = ".gitignore";
 
+	/*
+	 * Option parsing may precede reading the index. Record the object IDs
+	 * even before the untracked cache is available for validation.
+	 */
 	/* core.excludesfile defaulting to $XDG_CONFIG_HOME/git/ignore */
 	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
 		add_patterns_from_file_1(dir, excludes_file,
-					 dir->untracked ? &dir->internal.ss_excludes_file : NULL);
+					 &dir->internal.ss_excludes_file);
 
 	/* per repository user preference */
 	if (startup_info->have_repository) {
 		const char *path = git_path_info_exclude();
 		if (!access_or_warn(path, R_OK, 0))
 			add_patterns_from_file_1(dir, path,
-						 dir->untracked ? &dir->internal.ss_info_exclude : NULL);
+						 &dir->internal.ss_info_exclude);
 	}
 }
 
diff --git a/t/perf/p3010-ls-files.sh b/t/perf/p3010-ls-files.sh
index ae14449432..bdf398906f 100755
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
+test_expect_success 'populate the untracked cache with ls-files' '
+	git config core.untrackedCache true &&
+	git -c core.fsmonitor=false ls-files --others --exclude-standard >/dev/null
+'
+
+test_perf 'ls-files --others with pathspec and untracked cache' '
+	git -c core.fsmonitor=false ls-files --cached --others \
+		--exclude-standard -- "$pathspec" >/dev/null
+'
+
 test_done
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 29a0a25b30..5ca80932ac 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -306,4 +306,24 @@ test_expect_success 'ls-files with "**" patterns and no slashes' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'ls-files preserves repeated and ordered exclude options' '
+	test_create_repo exclude-options &&
+	(
+		cd exclude-options &&
+		touch keep info-hidden global-hidden &&
+		echo info-hidden >.git/info/exclude &&
+		echo global-hidden >.git/global-ignore &&
+		git config core.excludesFile .git/global-ignore &&
+		echo "!info-hidden" >.git/custom-ignore &&
+		echo keep >../expect &&
+		git ls-files --others --exclude-from=.git/custom-ignore \
+			--exclude-standard --exclude-standard >../actual &&
+		test_cmp ../expect ../actual &&
+		git ls-files --others --exclude-standard \
+			--exclude-from=.git/custom-ignore >../actual &&
+		printf "%s\n" info-hidden keep >../expect &&
+		test_cmp ../expect ../actual
+	)
+'
+
 test_done
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 2efbb93b71..70eed91dd7 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -1016,6 +1016,9 @@ test_expect_success 'untracked cache handles nested repository changes' '
 		echo "?? nested/" >../expect &&
 		test_cmp ../expect ../actual &&
 		rm -rf nested/.git &&
+		git ls-files --others --exclude-standard >../actual &&
+		echo nested/file >../expect &&
+		test_cmp ../expect ../actual &&
 		git status -uall --porcelain >../actual &&
 		echo "?? nested/file" >../expect &&
 		test_cmp ../expect ../actual &&
@@ -1048,4 +1051,98 @@ test_expect_success 'filtered status retains complete untracked listings' '
 	)
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
+		git status -unormal --porcelain >/dev/null &&
+		# Complete the partial listing, then reuse it without opening directories.
+		for opened in 1 0
+		do
+			: >"$TRASH_DIRECTORY/ls-files.trace" &&
+			GIT_TRACE2_PERF="$TRASH_DIRECTORY/ls-files.trace" \
+				git ls-files --cached --others --exclude-standard -z \
+				-- "**/pyproject.toml" >../actual &&
+			printf "%s\0" untracked/pyproject.toml tracked/pyproject.toml \
+				>../expect &&
+			test_cmp ../expect ../actual &&
+			test_grep "read_directo.*opendir:$opened\$" \
+				"$TRASH_DIRECTORY/ls-files.trace" &&
+			test_grep "read_directo.*gitignore-invalidation:0\$" \
+				"$TRASH_DIRECTORY/ls-files.trace" || return 1
+		done &&
+		for pathspec in "*.git/" ":(glob)**/*.toml" \
+			":(exclude)untracked/" ":(attr:selected)**/*.toml"
+		do
+			GIT_DISABLE_UNTRACKED_CACHE=1 git ls-files --others \
+				--exclude-standard -- "$pathspec" >../expect &&
+			git ls-files --others --exclude-standard \
+				-- "$pathspec" >../actual &&
+			test_cmp ../expect ../actual || return 1
+		done
+	)
+'
+
+test_expect_success 'ls-files cache is reused after status -unormal' '
+	test_create_repo persistent-cache &&
+	(
+		cd persistent-cache &&
+		mkdir tracked untracked &&
+		touch tracked/a tracked/b untracked/a untracked/b &&
+		git add tracked &&
+		git commit -m initial &&
+		git config core.untrackedCache true &&
+		test-tool chmtime =-300 . tracked untracked &&
+		git ls-files --others --exclude-standard >../actual &&
+		printf "%s\n" untracked/a untracked/b >../expect &&
+		test_cmp ../expect ../actual &&
+		git status --porcelain >../actual &&
+		echo "?? untracked/" >../status-expect &&
+		test_cmp ../status-expect ../actual &&
+		GIT_TRACE2_PERF="$TRASH_DIRECTORY/persistent.trace" \
+			git ls-files --others --exclude-standard >../actual &&
+		test_cmp ../expect ../actual &&
+		test_grep "read_directo.*opendir:0\$" "$TRASH_DIRECTORY/persistent.trace"
+	)
+'
+
+test_expect_success 'ls-files respects optional locks and a busy index lock' '
+	test_when_finished "rm -f persistent-cache/.git/index.lock" &&
+	(
+		cd persistent-cache &&
+		touch untracked/new &&
+		cp .git/index ../saved-index &&
+		git --no-optional-locks ls-files --others --exclude-standard >../actual &&
+		test_cmp_bin ../saved-index .git/index &&
+		printf "%s\n" untracked/a untracked/b untracked/new >../expect &&
+		test_cmp ../expect ../actual &&
+		touch .git/index.lock &&
+		git ls-files --others --exclude-standard >../actual &&
+		test_cmp ../expect ../actual &&
+		test_cmp_bin ../saved-index .git/index
+	)
+'
+
+test_expect_success 'ls-files does not write the index with a pathspec prefix or --with-tree' '
+	(
+		cd persistent-cache &&
+		cp .git/index ../saved-index &&
+		git ls-files --cached --others --exclude-standard -- tracked/a >../actual &&
+		test_cmp_bin ../saved-index .git/index &&
+		git rm --cached tracked/b &&
+		cp .git/index ../saved-index &&
+		git ls-files --cached --others --exclude-standard --with-tree=HEAD >../actual &&
+		test_cmp_bin ../saved-index .git/index
+	)
+'
+
 test_done
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 93973ed25a..8feca101ab 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -477,4 +477,48 @@ test_expect_success 'status succeeds with sparse index' '
 	)
 '
 
+test_expect_success UNTRACKED_CACHE 'ls-files saves the fsmonitor token with index.skipHash' '
+	test_create_repo ls-files-fsmonitor &&
+	(
+		# index.skipHash gives shared indexes a null OID, so they cannot
+		# be reloaded.
+		sane_unset GIT_TEST_SPLIT_INDEX &&
+		cd ls-files-fsmonitor &&
+		touch tracked &&
+		git add tracked &&
+		git commit -m initial &&
+		git config core.untrackedCache true &&
+		git config index.skipHash true &&
+		git config core.fsmonitor .git/hooks/fsmonitor-test &&
+		test_hook --setup fsmonitor-test <<-\EOF &&
+		printf "initial-token\0/\0"
+		EOF
+		mkdir untracked &&
+		touch untracked/first &&
+		git status --porcelain >/dev/null &&
+		test_hook --clobber fsmonitor-test <<-\EOF &&
+		test -f .git/index.lock || exit 1
+		printf "%s\n" "$2" >.git/query-token
+		printf "next-token\0"
+		if test "$2" != next-token
+		then
+			printf "untracked/second\0"
+		fi
+		EOF
+		touch untracked/second &&
+		git ls-files --others --exclude-standard >../actual &&
+		printf "%s\n" untracked/first untracked/second >../expect &&
+		test_cmp ../expect ../actual &&
+		echo initial-token >../token-expect &&
+		test_cmp ../token-expect .git/query-token &&
+		GIT_TRACE2_PERF="$TRASH_DIRECTORY/ls-files-fsmonitor.trace" \
+			git ls-files --others --exclude-standard >../actual &&
+		test_cmp ../expect ../actual &&
+		echo next-token >../token-expect &&
+		test_cmp ../token-expect .git/query-token &&
+		test_grep "read_directo.*opendir:0\$" \
+			"$TRASH_DIRECTORY/ls-files-fsmonitor.trace"
+	)
+'
+
 test_done

-- 
2.56.0.rc0.807.ga0c0929ce1.frankengit

