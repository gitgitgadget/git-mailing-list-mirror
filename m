Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B211E5B83
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926229; cv=none; b=tkNbwqHTbJCSd2bNZ1ZFTtSpq+x5rOJrRuLZTsh0Fp8ZsyPExpZzKMB7RHZdK7GSTTzcgF0p9/kOBXoXurZcpj8vFt8m8R9cVvSEM5vk3mFhqsUsNx5kdULWLLlMQyJxECd9TFAFUqQcDaZSgymMWPCsJDBOPh+ypVZQcWq9Im0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926229; c=relaxed/simple;
	bh=gC9bGrnoxRh3xJq8vVwblIC0dmhxPSsTUYu6K9EksOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ncl/rUM7ZU1krcrhAsa8z11+8DdcFH4Vhz0Atk+zB+6OF9TbAbBTxxoKDVIihqcfIRBRRDSclyAOPNVijDlLg6QGQNx6bmy4EBeqtUCJwImcF07I5lPPSymeIsmbsPFYNBOuYQHJiiKFdtaKJymut02Q8srB80o17IP+oJJVA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FlbdTACX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SJ6JPYiA; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FlbdTACX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SJ6JPYiA"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id B1123138016D;
	Fri,  7 Feb 2025 06:03:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 07 Feb 2025 06:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738926226;
	 x=1739012626; bh=PtZ675bexJbw7XP7ZUuRVQoKqNiFs7NF4CJGpEhMbnk=; b=
	FlbdTACX9e1tmj4IXe63RCniPTfyBuocWNVlLgH11nEYRO14i7ymbaasaK+2IefZ
	Gmsk8ddRKg7ZDQ/6Tk1qK8tAEkp+WHCLazB2TPSN50qCMIR/yfkrro7pDvI0LfzJ
	aURPMY3Dxy+ilYTPp+DG+rhg2WctrA9Br7c80vj/mH7mwLOYpzAbTqOYd7X+ZfTg
	OqVLoBSCUcVNyR+zK/qoTYnk705DIU2dp/9cJQB32SVKzoAlVoHtA4xQQpPyY+hh
	/wq4r9lr3hquetpcIcoq9dttWAPuPQQhT21MPbDAywdkepL+B/ry616ulITkfcqc
	Hn8Ama7i7TyXvDvOWDZErw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738926226; x=
	1739012626; bh=PtZ675bexJbw7XP7ZUuRVQoKqNiFs7NF4CJGpEhMbnk=; b=S
	J6JPYiAeS3ipzKFMebvhao5Fl7JYJRF3KY8s1fjZQVPBg8FZKcwZ1eLVYbWCWzTq
	2AlZh3gfpJ+mTCkPgPAX9wn68MHD59IsE8yIjSIzCmiAIUx2cGRQADH+06PMUh60
	J+rW5TCcH0D4d8cfP7vlvQp9j8vE0Rn5vKBqeinySewd9/OcAnZWd77Pvsd/5J93
	aKdITUXXllgdvZPVAJlg0nKb5Bl35J2a9nyOrxwQIG8Fn4VRthHjVWLhnWam0G6C
	HTYc3EFe76rYfs7jfB4FXzi2upqEWLPsJlkhmBMU3h5daEMQdVtxP9pRPAgcUxCK
	0GZF36e8woE10zgfv+QDg==
X-ME-Sender: <xms:kuilZ6N1tW4jbgGkzOI2q4RSxXXQUjWdRB4rl-RIoEbCYDC1O4SWWQ>
    <xme:kuilZ4-kLT9PK8DJSRSHcbwsiULmPug91szd7N2wqjofiXMphVBKvidyXIGQkwMPW
    FHmvB2QPcXF1Ees8Q>
X-ME-Received: <xmr:kuilZxTje5X0Nvg18_vmM08yCqAHGyCx0M8ETbZHoJpJiEnbMCIydMZ3fHhYjqY9FLn1UHEsP4IOk6ayY3POgUd-QNuF6HVsO2WwiYjbgsWaUfhz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:kuilZ6sTF-cI9IqilVhCcTyEgCryYUABgrMtdJtZDrLK3vD5AClj8g>
    <xmx:kuilZyfGZsjI0Kfv8oUFvpjlyuvhVewql1S4ebFylmQzsOz7bEPKvw>
    <xmx:kuilZ-0EpKh2inUNP7fYIVj4NXqPADBsY1-n9ZpNoj_7UBwZbVUTdA>
    <xmx:kuilZ2-YXK2tf4ycrrDOAjx6FyuCtRMkF9hEV0jNqXTDzGekrWhJag>
    <xmx:kuilZy47HWsyPE7GMkKtv-UZoCRoYzxw9AKjmildtL6pxpRD0mfAabHa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:03:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c15b3897 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:03:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:03:41 +0100
Subject: [PATCH v2 16/16] path: adjust last remaining users of
 `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-b4-pks-path-drop-the-repository-v2-16-13cad3c11b8a@pks.im>
References: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
In-Reply-To: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>
X-Mailer: b4 0.14.2

With the preceding refactorings we now only have a couple of implicit
users of `the_repository` left in the "path" subsystem, all of which
depend on global state via `calc_shared_perm()`. Make the dependency on
`the_repository` explicit by passing the repo as a parameter instead and
adjust callers accordingly.

Note that this change bubbles up into a couple of subsystems that were
previously declared as free from `the_repository`. Instead of marking
all of them as `the_repository`-dependent again, we instead use the
repository that is available in the calling context. There are three
exceptions though with "copy.c", "pack-write.c" and "tempfile.c".
Adjusting these would require us to adapt callsites all over the place,
so this is left for a future iteration.

Mark "path.c" as free from `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c         |  2 +-
 commit-graph.c          |  2 +-
 copy.c                  |  4 +++-
 loose.c                 |  2 +-
 midx-write.c            |  2 +-
 object-file.c           |  8 ++++----
 pack-bitmap-write.c     |  2 +-
 pack-write.c            | 10 ++++++----
 path.c                  | 25 ++++++++++++-------------
 path.h                  |  6 +++---
 read-cache.c            |  2 +-
 refs/files-backend.c    | 10 +++++-----
 refs/reftable-backend.c | 10 +++++-----
 server-info.c           |  2 +-
 setup.c                 | 12 ++++++------
 tempfile.c              |  4 +++-
 tmp-objdir.c            | 17 ++++++++++-------
 17 files changed, 64 insertions(+), 56 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5ae6ee9db9..23eeb782aa 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1220,7 +1220,7 @@ int cmd_clone(int argc,
 
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "%s/refs", git_dir);
-	safe_create_dir(buf.buf, 1);
+	safe_create_dir(the_repository, buf.buf, 1);
 
 	/*
 	 * additional config can be injected with -c, make sure it's included
diff --git a/commit-graph.c b/commit-graph.c
index 2a2999a6b8..1021ccb983 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2084,7 +2084,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			return -1;
 		}
 
-		if (adjust_shared_perm(get_tempfile_path(graph_layer))) {
+		if (adjust_shared_perm(the_repository, get_tempfile_path(graph_layer))) {
 			error(_("unable to adjust shared permissions for '%s'"),
 			      get_tempfile_path(graph_layer));
 			return -1;
diff --git a/copy.c b/copy.c
index d9d2092012..b668209b6c 100644
--- a/copy.c
+++ b/copy.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "copy.h"
 #include "path.h"
@@ -57,7 +59,7 @@ int copy_file(const char *dst, const char *src, int mode)
 	if (close(fdo) != 0)
 		return error_errno("%s: close error", dst);
 
-	if (!status && adjust_shared_perm(dst))
+	if (!status && adjust_shared_perm(the_repository, dst))
 		return -1;
 
 	return status;
diff --git a/loose.c b/loose.c
index 51ef490f93..bb602aaa36 100644
--- a/loose.c
+++ b/loose.c
@@ -190,7 +190,7 @@ static int write_one_object(struct repository *repo, const struct object_id *oid
 		goto errout;
 	if (close(fd))
 		goto errout;
-	adjust_shared_perm(path.buf);
+	adjust_shared_perm(repo, path.buf);
 	rollback_lock_file(&lock);
 	strbuf_release(&buf);
 	strbuf_release(&path);
diff --git a/midx-write.c b/midx-write.c
index 61b59d557d..48d6558253 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1336,7 +1336,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			return -1;
 		}
 
-		if (adjust_shared_perm(get_tempfile_path(incr))) {
+		if (adjust_shared_perm(r, get_tempfile_path(incr))) {
 			error(_("unable to adjust shared permissions for '%s'"),
 			      get_tempfile_path(incr));
 			return -1;
diff --git a/object-file.c b/object-file.c
index dc9fcaf3e9..5d782417e3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -388,7 +388,7 @@ int mkdir_in_gitdir(const char *path)
 		}
 		strbuf_release(&sb);
 	}
-	return adjust_shared_perm(path);
+	return adjust_shared_perm(the_repository, path);
 }
 
 static enum scld_error safe_create_leading_directories_1(char *path, int share)
@@ -437,7 +437,7 @@ static enum scld_error safe_create_leading_directories_1(char *path, int share)
 				ret = SCLD_VANISHED;
 			else
 				ret = SCLD_FAILED;
-		} else if (share && adjust_shared_perm(path)) {
+		} else if (share && adjust_shared_perm(the_repository, path)) {
 			ret = SCLD_PERMS;
 		}
 		*slash = slash_character;
@@ -2105,7 +2105,7 @@ int finalize_object_file_flags(const char *tmpfile, const char *filename,
 	}
 
 out:
-	if (adjust_shared_perm(filename))
+	if (adjust_shared_perm(the_repository, filename))
 		return error(_("unable to set permission to '%s'"), filename);
 	return 0;
 }
@@ -2181,7 +2181,7 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 		strbuf_add(tmp, filename, dirlen - 1);
 		if (mkdir(tmp->buf, 0777) && errno != EEXIST)
 			return -1;
-		if (adjust_shared_perm(tmp->buf))
+		if (adjust_shared_perm(the_repository, tmp->buf))
 			return -1;
 
 		/* Try again */
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index a06a1f35c6..34e86d4994 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1072,7 +1072,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
 			  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 
-	if (adjust_shared_perm(tmp_file.buf))
+	if (adjust_shared_perm(the_repository, tmp_file.buf))
 		die_errno("unable to make temporary bitmap file readable");
 
 	if (rename(tmp_file.buf, filename))
diff --git a/pack-write.c b/pack-write.c
index a2faeb1895..c3f4e66f02 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
@@ -287,7 +289,7 @@ char *write_rev_file_order(const struct git_hash_algo *hash_algo,
 	write_rev_index_positions(f, pack_order, nr_objects);
 	write_rev_trailer(hash_algo, f, hash);
 
-	if (adjust_shared_perm(path) < 0)
+	if (adjust_shared_perm(the_repository, path) < 0)
 		die(_("failed to make %s readable"), path);
 
 	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
@@ -350,7 +352,7 @@ static char *write_mtimes_file(const struct git_hash_algo *hash_algo,
 	write_mtimes_objects(f, to_pack, objects, nr_objects);
 	write_mtimes_trailer(hash_algo, f, hash);
 
-	if (adjust_shared_perm(mtimes_name) < 0)
+	if (adjust_shared_perm(the_repository, mtimes_name) < 0)
 		die(_("failed to make %s readable"), mtimes_name);
 
 	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
@@ -565,12 +567,12 @@ void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
 	char *rev_tmp_name = NULL;
 	char *mtimes_tmp_name = NULL;
 
-	if (adjust_shared_perm(pack_tmp_name))
+	if (adjust_shared_perm(the_repository, pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
 
 	*idx_tmp_name = (char *)write_idx_file(hash_algo, NULL, written_list,
 					       nr_written, pack_idx_opts, hash);
-	if (adjust_shared_perm(*idx_tmp_name))
+	if (adjust_shared_perm(the_repository, *idx_tmp_name))
 		die_errno("unable to make temporary index file readable");
 
 	rev_tmp_name = write_rev_file(hash_algo, NULL, written_list, nr_written,
diff --git a/path.c b/path.c
index a2f402baec..910756c8b3 100644
--- a/path.c
+++ b/path.c
@@ -2,8 +2,6 @@
  * Utilities for paths and pathnames
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
@@ -840,21 +838,22 @@ const char *enter_repo(const char *path, unsigned flags)
 	return NULL;
 }
 
-int calc_shared_perm(int mode)
+int calc_shared_perm(struct repository *repo,
+		     int mode)
 {
 	int tweak;
 
-	if (repo_settings_get_shared_repository(the_repository) < 0)
-		tweak = -repo_settings_get_shared_repository(the_repository);
+	if (repo_settings_get_shared_repository(repo) < 0)
+		tweak = -repo_settings_get_shared_repository(repo);
 	else
-		tweak = repo_settings_get_shared_repository(the_repository);
+		tweak = repo_settings_get_shared_repository(repo);
 
 	if (!(mode & S_IWUSR))
 		tweak &= ~0222;
 	if (mode & S_IXUSR)
 		/* Copy read bits to execute bits */
 		tweak |= (tweak & 0444) >> 2;
-	if (repo_settings_get_shared_repository(the_repository) < 0)
+	if (repo_settings_get_shared_repository(repo) < 0)
 		mode = (mode & ~0777) | tweak;
 	else
 		mode |= tweak;
@@ -862,17 +861,17 @@ int calc_shared_perm(int mode)
 	return mode;
 }
 
-
-int adjust_shared_perm(const char *path)
+int adjust_shared_perm(struct repository *repo,
+		       const char *path)
 {
 	int old_mode, new_mode;
 
-	if (!repo_settings_get_shared_repository(the_repository))
+	if (!repo_settings_get_shared_repository(repo))
 		return 0;
 	if (get_st_mode_bits(path, &old_mode) < 0)
 		return -1;
 
-	new_mode = calc_shared_perm(old_mode);
+	new_mode = calc_shared_perm(repo, old_mode);
 	if (S_ISDIR(old_mode)) {
 		/* Copy read bits to execute bits */
 		new_mode |= (new_mode & 0444) >> 2;
@@ -891,7 +890,7 @@ int adjust_shared_perm(const char *path)
 	return 0;
 }
 
-void safe_create_dir(const char *dir, int share)
+void safe_create_dir(struct repository *repo, const char *dir, int share)
 {
 	if (mkdir(dir, 0777) < 0) {
 		if (errno != EEXIST) {
@@ -899,7 +898,7 @@ void safe_create_dir(const char *dir, int share)
 			exit(1);
 		}
 	}
-	else if (share && adjust_shared_perm(dir))
+	else if (share && adjust_shared_perm(repo, dir))
 		die(_("Could not make %s writable by group"), dir);
 }
 
diff --git a/path.h b/path.h
index 373404dd9d..65fe968a13 100644
--- a/path.h
+++ b/path.h
@@ -141,8 +141,8 @@ const char *git_path_shallow(struct repository *r);
 
 int ends_with_path_components(const char *path, const char *components);
 
-int calc_shared_perm(int mode);
-int adjust_shared_perm(const char *path);
+int calc_shared_perm(struct repository *repo, int mode);
+int adjust_shared_perm(struct repository *repo, const char *path);
 
 char *interpolate_path(const char *path, int real_home);
 
@@ -219,7 +219,7 @@ char *xdg_cache_home(const char *filename);
  * directories under $GIT_DIR.  Don't use it for working tree
  * directories.
  */
-void safe_create_dir(const char *dir, int share);
+void safe_create_dir(struct repository *repo, const char *dir, int share);
 
 # ifdef USE_THE_REPOSITORY_VARIABLE
 #  include "strbuf.h"
diff --git a/read-cache.c b/read-cache.c
index 66ad0015a7..900738e7a8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3290,7 +3290,7 @@ static int write_shared_index(struct index_state *istate,
 
 	if (ret)
 		return ret;
-	ret = adjust_shared_perm(get_tempfile_path(*temp));
+	ret = adjust_shared_perm(the_repository, get_tempfile_path(*temp));
 	if (ret) {
 		error(_("cannot fix permission bits on '%s'"), get_tempfile_path(*temp));
 		return ret;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 29f08dced4..6c6e67dc1c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1831,7 +1831,7 @@ static int log_ref_setup(struct files_ref_store *refs,
 	}
 
 	if (*logfd >= 0)
-		adjust_shared_perm(logfile);
+		adjust_shared_perm(the_repository, logfile);
 
 	free(logfile);
 	return 0;
@@ -3488,8 +3488,8 @@ static int files_ref_store_create_on_disk(struct ref_store *ref_store,
 	 *   they do not understand the reference format extension.
 	 */
 	strbuf_addf(&sb, "%s/refs", ref_store->gitdir);
-	safe_create_dir(sb.buf, 1);
-	adjust_shared_perm(sb.buf);
+	safe_create_dir(the_repository, sb.buf, 1);
+	adjust_shared_perm(the_repository, sb.buf);
 
 	/*
 	 * There is no need to create directories for common refs when creating
@@ -3501,11 +3501,11 @@ static int files_ref_store_create_on_disk(struct ref_store *ref_store,
 		 */
 		strbuf_reset(&sb);
 		files_ref_path(refs, &sb, "refs/heads");
-		safe_create_dir(sb.buf, 1);
+		safe_create_dir(the_repository, sb.buf, 1);
 
 		strbuf_reset(&sb);
 		files_ref_path(refs, &sb, "refs/tags");
-		safe_create_dir(sb.buf, 1);
+		safe_create_dir(the_repository, sb.buf, 1);
 	}
 
 	strbuf_release(&sb);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index d39a14c5a4..9c54e2c173 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -380,7 +380,7 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	default:
 		BUG("unknown hash algorithm %d", repo->hash_algo->format_id);
 	}
-	refs->write_options.default_permissions = calc_shared_perm(0666 & ~mask);
+	refs->write_options.default_permissions = calc_shared_perm(the_repository, 0666 & ~mask);
 	refs->write_options.disable_auto_compact =
 		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
 	refs->write_options.lock_timeout_ms = 100;
@@ -470,21 +470,21 @@ static int reftable_be_create_on_disk(struct ref_store *ref_store,
 	struct strbuf sb = STRBUF_INIT;
 
 	strbuf_addf(&sb, "%s/reftable", refs->base.gitdir);
-	safe_create_dir(sb.buf, 1);
+	safe_create_dir(the_repository, sb.buf, 1);
 	strbuf_reset(&sb);
 
 	strbuf_addf(&sb, "%s/HEAD", refs->base.gitdir);
 	write_file(sb.buf, "ref: refs/heads/.invalid");
-	adjust_shared_perm(sb.buf);
+	adjust_shared_perm(the_repository, sb.buf);
 	strbuf_reset(&sb);
 
 	strbuf_addf(&sb, "%s/refs", refs->base.gitdir);
-	safe_create_dir(sb.buf, 1);
+	safe_create_dir(the_repository, sb.buf, 1);
 	strbuf_reset(&sb);
 
 	strbuf_addf(&sb, "%s/refs/heads", refs->base.gitdir);
 	write_file(sb.buf, "this repository uses the reftable format");
-	adjust_shared_perm(sb.buf);
+	adjust_shared_perm(the_repository, sb.buf);
 
 	strbuf_release(&sb);
 	return 0;
diff --git a/server-info.c b/server-info.c
index 31c3fdc118..1ca0e00d51 100644
--- a/server-info.c
+++ b/server-info.c
@@ -125,7 +125,7 @@ static int update_info_file(struct repository *r, char *path,
 	uic.cur_fp = NULL;
 
 	if (uic_is_stale(&uic)) {
-		if (adjust_shared_perm(get_tempfile_path(f)) < 0)
+		if (adjust_shared_perm(r, get_tempfile_path(f)) < 0)
 			goto out;
 		if (rename_tempfile(&f, path) < 0)
 			goto out;
diff --git a/setup.c b/setup.c
index aa65b93f53..71a3d66f05 100644
--- a/setup.c
+++ b/setup.c
@@ -2088,7 +2088,7 @@ static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
 	 * with the way the namespace under .git/ is organized, should
 	 * be really carefully chosen.
 	 */
-	safe_create_dir(path->buf, 1);
+	safe_create_dir(the_repository, path->buf, 1);
 	while ((de = readdir(dir)) != NULL) {
 		struct stat st_git, st_template;
 		int exists = 0;
@@ -2352,7 +2352,7 @@ static int create_default_files(const char *template_path,
 	 * shared-repository settings, we would need to fix them up.
 	 */
 	if (repo_settings_get_shared_repository(the_repository)) {
-		adjust_shared_perm(repo_get_git_dir(the_repository));
+		adjust_shared_perm(the_repository, repo_get_git_dir(the_repository));
 	}
 
 	initialize_repository_version(fmt->hash_algo, fmt->ref_storage_format, reinit);
@@ -2413,15 +2413,15 @@ static void create_object_directory(void)
 	strbuf_addstr(&path, repo_get_object_directory(the_repository));
 	baselen = path.len;
 
-	safe_create_dir(path.buf, 1);
+	safe_create_dir(the_repository, path.buf, 1);
 
 	strbuf_setlen(&path, baselen);
 	strbuf_addstr(&path, "/pack");
-	safe_create_dir(path.buf, 1);
+	safe_create_dir(the_repository, path.buf, 1);
 
 	strbuf_setlen(&path, baselen);
 	strbuf_addstr(&path, "/info");
-	safe_create_dir(path.buf, 1);
+	safe_create_dir(the_repository, path.buf, 1);
 
 	strbuf_release(&path);
 }
@@ -2588,7 +2588,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 */
 	git_config(platform_core_config, NULL);
 
-	safe_create_dir(git_dir, 0);
+	safe_create_dir(the_repository, git_dir, 0);
 
 	reinit = create_default_files(template_dir, original_git_dir,
 				      &repo_fmt, init_shared_repository);
diff --git a/tempfile.c b/tempfile.c
index ed88cf8431..82dfa3d82f 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -42,6 +42,8 @@
  * file created by its parent.
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "path.h"
@@ -148,7 +150,7 @@ struct tempfile *create_tempfile_mode(const char *path, int mode)
 		return NULL;
 	}
 	activate_tempfile(tempfile);
-	if (adjust_shared_perm(tempfile->filename.buf)) {
+	if (adjust_shared_perm(the_repository, tempfile->filename.buf)) {
 		int save_errno = errno;
 		error("cannot fix permission bits on %s", tempfile->filename.buf);
 		delete_tempfile(&tempfile);
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 0ea078a5c5..31d16a4c2c 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -207,10 +207,12 @@ static int read_dir_paths(struct string_list *out, const char *path)
 	return 0;
 }
 
-static int migrate_paths(struct strbuf *src, struct strbuf *dst,
+static int migrate_paths(struct tmp_objdir *t,
+			 struct strbuf *src, struct strbuf *dst,
 			 enum finalize_object_file_flags flags);
 
-static int migrate_one(struct strbuf *src, struct strbuf *dst,
+static int migrate_one(struct tmp_objdir *t,
+		       struct strbuf *src, struct strbuf *dst,
 		       enum finalize_object_file_flags flags)
 {
 	struct stat st;
@@ -219,11 +221,11 @@ static int migrate_one(struct strbuf *src, struct strbuf *dst,
 		return -1;
 	if (S_ISDIR(st.st_mode)) {
 		if (!mkdir(dst->buf, 0777)) {
-			if (adjust_shared_perm(dst->buf))
+			if (adjust_shared_perm(t->repo, dst->buf))
 				return -1;
 		} else if (errno != EEXIST)
 			return -1;
-		return migrate_paths(src, dst, flags);
+		return migrate_paths(t, src, dst, flags);
 	}
 	return finalize_object_file_flags(src->buf, dst->buf, flags);
 }
@@ -233,7 +235,8 @@ static int is_loose_object_shard(const char *name)
 	return strlen(name) == 2 && isxdigit(name[0]) && isxdigit(name[1]);
 }
 
-static int migrate_paths(struct strbuf *src, struct strbuf *dst,
+static int migrate_paths(struct tmp_objdir *t,
+			 struct strbuf *src, struct strbuf *dst,
 			 enum finalize_object_file_flags flags)
 {
 	size_t src_len = src->len, dst_len = dst->len;
@@ -255,7 +258,7 @@ static int migrate_paths(struct strbuf *src, struct strbuf *dst,
 		if (is_loose_object_shard(name))
 			flags_copy |= FOF_SKIP_COLLISION_CHECK;
 
-		ret |= migrate_one(src, dst, flags_copy);
+		ret |= migrate_one(t, src, dst, flags_copy);
 
 		strbuf_setlen(src, src_len);
 		strbuf_setlen(dst, dst_len);
@@ -283,7 +286,7 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 	strbuf_addbuf(&src, &t->path);
 	strbuf_addstr(&dst, repo_get_object_directory(t->repo));
 
-	ret = migrate_paths(&src, &dst, 0);
+	ret = migrate_paths(t, &src, &dst, 0);
 
 	strbuf_release(&src);
 	strbuf_release(&dst);

-- 
2.48.1.538.gc4cfc42d60.dirty

