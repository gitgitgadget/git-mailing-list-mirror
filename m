Received: from mail-dl2-f36.google.com (mail-dl2-f36.google.com [74.125.229.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9912B3537FE
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791127160; cv=none; b=QjHYtvimKzHLyzvye6jDcPodcPUr7BmR62mX8cB3GCsZkDk4wZBkR2Y6qVrmFAJEXjwX7gH1ebxpVmElN6hlB8gK3dV1a1Rp3Gl6Un7irAqn+JvIAPfVtr4vE9wMQhDxVju93m8skBQD8zdsT8G1R9iaDd3jsXzANlc+WyrBboA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791127160; c=relaxed/simple;
	bh=W6/niWnNvElWdEofbm0qkS9D4nIAIfpVinXXKyuZIuQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=MAnasMAX7F364OZSj4T8C6PqUAK5DxIsF1WwlbnSoGhJaqeYJcieJKSs58qpXOmfKLNfuPWdZDnhiqvrmx2ehx742G19Sz51HsiRMlwUDm+GVuJMsqyTOzZuMG2WKF+4YkKfAwENYIlSVwhSkLnSdnTWeC/QMQAHOoJD6ontoa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J274+L6I; arc=none smtp.client-ip=74.125.229.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J274+L6I"
Received: by mail-dl2-f36.google.com with SMTP id a92af1059eb24-14373bcc010so744750c88.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791127157; x=1791731957; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i6qo2MJdCL3mtm6WegWTowYllRdGXBYkzyP46JDFxiY=;
        b=J274+L6IIyt/lKD5fsGDAekoGGudDisUbyCnE9UzahMBFqzzbpUBH/Wo5zrABUdO6r
         LhECSMMB3R9yHIc9YbWrcJN3ItZko2wOuU/vGiAP15KvQ8VBR8dk1Tre2Xy3JZ485Bh4
         5bBpjfiPcXss+b1H1v7cV7njprnTMy/QpmApQKJmdK6gKjfhnYdX94AYf1WWqHl8MQ2I
         CU9efDSR+SFJOI3HIvanVEfg/H6IQ2KJejIrZZPbBZAvd16klHBT+0aAfvvgmx90l1hP
         Ie106ONui0T968Upbs4frvniZo7rI8SLJjrvIrnbp1Lio204j1TdMrgCefeRkvd0ra6w
         TvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791127157; x=1791731957;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i6qo2MJdCL3mtm6WegWTowYllRdGXBYkzyP46JDFxiY=;
        b=ePZsRynbVjiuwPLQ1kbfFosSq2YK0jyDRQ7zQN3DfJqQ9xKjJyO3BFm+QwfEyte2kZ
         DSM2PjlnyvDUOvcYPBJD90rfY8Xw3eYnD7EvCyoKpJ4EF6yZUT/ycJHYhBAOQV4hrLq5
         9VLK7wDEn7biiZ3N8UDgpwEhe087jsJ9vrA/ynBS1nzllwJpb2GknLu1mtKH9em9lN8g
         l9BkMQxdTLa7Zqw+6vBidX9C2uhLa//ieVlFq/RBv8HKzK7xr18KL/I7kT0Pw+mG7OrR
         ghxc3z0sdRwXjH2Eajf2TBF9EQ1lHqMdgtKiHPYFx4QefUNTJf5JDh0cAeQMC114IBx1
         kP8w==
X-Gm-Message-State: AFuF++ngsgCUcc8p5809dJEZCfxv2WUsWfNZRc26a6t7SRQWVApG8O4N
	oNYBoHLhh8zyBKQ6cTPa3GSq/IZZ1BOHC4Wqk4MdAomTi51wkGzj7HkFZiLHnA==
X-Gm-Gg: AYBFou3i2cbNu8rd/T7FIaagQJDVUjyVF42myrFdZfVpFafoprnOb0iSI6vfwUA7MRT
	+W2jrypadeQJ6oYlhH+w7K3xz0ZBdfdInln/NVJdcJUrv59Nk4P2ql3YPZBvaSWB9NvkKyx8otG
	Yn14hFmS1cOfvaR+9RWHf4FLyXnL7UqdyRNp0tn9SUcMgqnh7pLGYzSc4TKo9yj+ut4CO2JUbMN
	6PovdMSGsNPptaVNCnqq2X5yFdWMtqibll84yXaKr8jYt72AycCHovPRnQtl51DHpHUG5g/NU+w
	mJgFKARis8GpDIZvkmzxnlGJ2xjLR8nUbz4fEtvWp2HNZMo6Im1Jmm97tLnhT0QaUWDO/GYatqz
	bdTMrjLkbCVgKhHwP2Jvy0R2r1DXreXl9sXg98x88aU0l9Wyd9f8ntjjerAiAST9LlWgN2GzKss
	G2ffsOjeFgebkQ2O7Dh9T3CYaKPi3383iZirHzSt/ma3/Xlfm0gF7nWVb4rLTD1K+0Xa/eR9vzk
	Sw=
X-Received: by 2002:a05:701b:4656:b0:14f:5549:c1ea with SMTP id a92af1059eb24-14f591c8f0dmr9884780c88.1.1791127157218;
        Sun, 04 Oct 2026 08:19:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.235.215])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fcd83fadsm15338760c88.11.2026.10.04.08.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 08:19:16 -0700 (PDT)
Message-Id: <pull.2247.git.1791127155614.gitgitgadget@gmail.com>
From: "Ilia via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Oct 2026 15:19:15 +0000
Subject: [PATCH] fsmonitor: check the untracked cache after a trivial response
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
Cc: Ilia <ki.stfu@gmail.com>,
    Ilia K <ki.stfu@gmail.com>

From: Ilia K <ki.stfu@gmail.com>

When the monitor sends a trivial response ("/"), for example after
the daemon restarted or lost events, refresh_fsmonitor() marks every
index entry dirty, which is saved in the index. For the untracked
cache it only clears the in-memory flag use_fsmonitor. The valid bits
of the cached directories are saved unchanged, although nothing
checks them anymore: valid_cached_dir() does not lstat() a valid
directory while the monitor is trusted.

A command that does not scan for untracked files, like "git add" or
"git checkout", therefore saves the new token next to stale valid
bits, and every later "git status" trusts them. A directory removed
in the meantime keeps its untracked files listed, or, when its own
entry is invalid, makes every run print
```
warning: could not open directory 'sub/': No such file or directory
```
Check every cached directory against its stat data before the cache
is saved next to such a token, as valid_cached_dir() does without a
monitor, and invalidate the ones that changed or disappeared. Doing
this at write time skips commands that do not write the index, and
sparse index writes, which drop the fsmonitor extension anyway.
The cost is one lstat() per cached directory, once per trivial
response.

Signed-off-by: Ilia K <ki.stfu@gmail.com>
---
    fsmonitor: check the untracked cache after a trivial response

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2247%2Fk15tfu%2Funtracked-cache-trivial-response-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2247/k15tfu/untracked-cache-trivial-response-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2247

 dir.c                        | 56 ++++++++++++++++++++++++++++++++++++
 dir.h                        |  7 +++++
 read-cache.c                 | 16 +++++++++++
 t/t7519-status-fsmonitor.sh  | 55 +++++++++++++++++++++++++++++++++++
 t/t7527-builtin-fsmonitor.sh | 44 ++++++++++++++++++++++++++++
 5 files changed, 178 insertions(+)

diff --git a/dir.c b/dir.c
index d896e7be4b..fc41ca9694 100644
--- a/dir.c
+++ b/dir.c
@@ -4053,6 +4053,62 @@ void untracked_cache_invalidate_trimmed_path(struct index_state *istate,
 	}
 }
 
+static int invalidate_stale_dirs(struct untracked_cache *uc,
+				 struct untracked_cache_dir *ucd,
+				 struct index_state *istate,
+				 struct strbuf *path)
+{
+	struct stat st;
+	size_t len = path->len;
+	int nr_invalidated = 0;
+	unsigned int i;
+
+	if (ucd->valid &&
+	    (lstat(path->buf, &st) ||
+	     match_stat_data_racy(istate, &ucd->stat_data, &st))) {
+		invalidate_one_directory(uc, ucd);
+		nr_invalidated++;
+	}
+
+	for (i = 0; i < ucd->dirs_nr; i++) {
+		/* not written to the index, see write_one_dir() */
+		if (!ucd->dirs[i]->recurse)
+			continue;
+		strbuf_addch(path, '/');
+		strbuf_addstr(path, ucd->dirs[i]->name);
+		nr_invalidated += invalidate_stale_dirs(uc, ucd->dirs[i],
+							istate, path);
+		strbuf_setlen(path, len);
+	}
+
+	return nr_invalidated;
+}
+
+int untracked_cache_invalidate_stale_dirs(struct index_state *istate)
+{
+	struct strbuf path = STRBUF_INIT;
+	const char *worktree;
+	int nr_invalidated;
+
+	if (!istate->untracked || !istate->untracked->root)
+		return 0;
+
+	/*
+	 * The index is also read and written by commands that do not
+	 * run in the top-level directory of the worktree.
+	 */
+	worktree = repo_get_work_tree(istate->repo);
+	if (!worktree)
+		return 0;
+
+	strbuf_addstr(&path, worktree);
+	nr_invalidated = invalidate_stale_dirs(istate->untracked,
+					       istate->untracked->root,
+					       istate, &path);
+	strbuf_release(&path);
+	return nr_invalidated;
+}
+
 void untracked_cache_remove_from_index(struct index_state *istate,
 				       const char *path)
 {
diff --git a/dir.h b/dir.h
index 83e0f648a8..7af1562b44 100644
--- a/dir.h
+++ b/dir.h
@@ -604,6 +604,13 @@ void untracked_cache_invalidate_path(struct index_state *, const char *, int saf
 void untracked_cache_invalidate_trimmed_path(struct index_state *,
 					     const char *path,
 					     int safe_path);
+/*
+ * Invalidate every cached directory that no longer exists or whose
+ * stat data no longer matches the working tree. valid_cached_dir()
+ * skips this check while the file system monitor is trusted.
+ * Returns the number of invalidated directories.
+ */
+int untracked_cache_invalidate_stale_dirs(struct index_state *);
 void untracked_cache_remove_from_index(struct index_state *, const char *);
 void untracked_cache_add_to_index(struct index_state *, const char *);
 
diff --git a/read-cache.c b/read-cache.c
index c4cf08a3a3..00c9960c8e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3034,6 +3034,22 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	    istate->untracked) {
 		strbuf_reset(&sb);
 
+		/*
+		 * The monitor could not say what changed (see the trivial
+		 * response in refresh_fsmonitor()), so nothing kept the
+		 * valid bits up to date. Check them before they are saved
+		 * next to the new token, which later commands trust even
+		 * when this command did not look for untracked files.
+		 */
+		if (write_extensions & WRITE_FSMONITOR_EXTENSION &&
+		    istate->fsmonitor_last_update &&
+		    !istate->untracked->use_fsmonitor) {
+			int nr = untracked_cache_invalidate_stale_dirs(istate);
+
+			trace2_data_intmax("index", istate->repo,
+					   "extension/untr/invalidated", nr);
+		}
+
 		write_untracked_extension(&sb, istate->untracked);
 		err = write_index_ext_header(f, eoie_c, CACHE_EXT_UNTRACKED,
 					     sb.len) < 0;
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 93973ed25a..2e1d795a4b 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -336,6 +336,61 @@ do
 	done
 done
 
+# After a trivial response ("/") the monitor cannot vouch for the
+# untracked cache. Even a command that does not look for untracked
+# files must drop the stale entries, or the next "git status" trusts them.
+test_expect_success UNTRACKED_CACHE 'untracked cache is checked after a trivial response' '
+	test_when_finished "rm -rf trivial err" &&
+	git init trivial &&
+	(
+		cd trivial &&
+		mkdir -p dir/sub &&
+		echo tracked >dir/sub/tracked &&
+		git add dir &&
+		git commit -m initial &&
+		git config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-none" &&
+		# Version 1 only, or the hook prints a version complaint
+		# on stderr at every query.
+		git config core.fsmonitorHookVersion 1 &&
+		git config core.untrackedCache true &&
+		# With "normal", invalidating one path also invalidates
+		# its parents, and the stale parent below is never seen.
+		git config status.showUntrackedFiles all &&
+		echo untracked >dir/sub/untracked &&
+		echo "?? dir/sub/untracked" >../expect &&
+		git status --porcelain >../actual &&
+		test_cmp ../expect ../actual &&
+		git status --porcelain >../actual &&
+		test_cmp ../expect ../actual &&
+
+		# The monitor misses the removal of dir/sub. "git add other"
+		# gets the trivial response and does not touch the entries
+		# of dir and dir/sub by itself.
+		rm -r dir/sub &&
+		echo other >other &&
+		git -c core.fsmonitor="$TEST_DIRECTORY/t7519/fsmonitor-all" \
+			add other &&
+		cat >../expect <<-\EOF &&
+		 D dir/sub/tracked
+		A  other
+		EOF
+		git status --porcelain >../actual 2>../err &&
+		test_must_be_empty ../err &&
+		test_cmp ../expect ../actual &&
+
+		# Invalidate the entry of dir/sub. The stale entry of dir then
+		# makes "git status" open the removed directory and warn.
+		git update-index --remove dir/sub/tracked &&
+		cat >../expect <<-\EOF &&
+		D  dir/sub/tracked
+		A  other
+		EOF
+		git status --porcelain >../actual 2>../err &&
+		test_must_be_empty ../err &&
+		test_cmp ../expect ../actual
+	)
+'
+
 # test that splitting the index doesn't interfere
 test_expect_success 'splitting the index results in the same state' '
 	write_integration_script &&
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 86195770e9..46b97ef784 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -1389,4 +1389,48 @@ test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
 	test_grep -q " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
 '
 
+# After a restart the daemon sends a trivial response ("/"), because it
+# cannot know what changed while it was down. Even a command that does
+# not look for untracked files must then drop the stale untracked cache
+# entries, or the next "git status" trusts them.
+test_expect_success UNTRACKED_CACHE 'untracked cache is checked after a trivial response' '
+	test_when_finished "stop_daemon_delete_repo test_trivial" &&
+
+	git init test_trivial &&
+	mkdir -p test_trivial/dir/sub &&
+	echo tracked >test_trivial/dir/sub/tracked &&
+	git -C test_trivial add dir &&
+	git -C test_trivial commit -m initial &&
+	git -C test_trivial config core.fsmonitor true &&
+	git -C test_trivial config core.untrackedCache true &&
+	echo untracked >test_trivial/dir/sub/untracked &&
+
+	# The first status starts the daemon and builds the untracked
+	# cache, the second one trusts it.
+	echo "?? dir/sub/untracked" >expect &&
+	git -C test_trivial status --porcelain >actual &&
+	test_cmp expect actual &&
+	git -C test_trivial status --porcelain >actual &&
+	test_cmp expect actual &&
+
+	# Remove dir/sub while no daemon is running. "git add" then
+	# starts a new daemon, receives its trivial response, and does
+	# not look for untracked files.
+	git -C test_trivial fsmonitor--daemon stop &&
+	rm -r test_trivial/dir/sub &&
+	echo other >test_trivial/other &&
+	GIT_TRACE2_EVENT="$PWD/trace_trivial" \
+		git -C test_trivial add other &&
+	have_t2_data_event fsm_client query/trivial-response <trace_trivial &&
+	git -C test_trivial fsmonitor--daemon status &&
+
+	cat >expect <<-\EOF &&
+	 D dir/sub/tracked
+	A  other
+	EOF
+	git -C test_trivial status --porcelain >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: c46c1e37724f0478939de636ab8ea5a89086d532
-- 
gitgitgadget
