Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10E516D9AA
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008957; cv=none; b=Frz4YOfinJufCZe8OFVg33z/hHavo9PLP6pvYlFoQBBc+UL/Ntc2rNmNDUAViJoE9d6sjTGSPHEj/+Dne5QwcK1+qOK6lg6VqplCWsuG4YXK5JKAnHuUIlBUJqqELCrGgkv6Rgro1I7mv/C7mKxitI+hCAr3YV3HwnO0Rj/q1Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008957; c=relaxed/simple;
	bh=OFczgdoBIXESlGKY7PWCG5l0tetMiDiuu2fBUczJH2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIeaZyKquFPNkaT/EROzE1lDttgHxgMxBRdzCkb2LVUsuKNnBHpUfogw4lHCpRn247bzGnKcb9/Lu53PPXtXpTWbNtjmtGsPHSy0abzVLpeMv+04C7jBA4Ww6OcoYLeWOnWdCF7bS7oQkJKhjNGy86p2D3gQMSshuOwUGE+0OJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ga5AQx8+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DdGU0Xjy; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ga5AQx8+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DdGU0Xjy"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id D6AFA138024B;
	Fri, 30 Aug 2024 05:09:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 30 Aug 2024 05:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725008954; x=1725095354; bh=oG844HO9UJ
	SVp5oIsWv/vVhlRm9aUef9v9PvV/sovB4=; b=Ga5AQx8+DDi+huuaiUqc9Lxno2
	XJwi23ZRyeuqC/i3Fc8yXaPBbtrACTg4QyNRDIhwAfeFgeO7jGQIOJ51xKLrfZME
	eHgf2xKL4vhG/TAcgKaC8/oGEQnVKkrc7fCbb2gWQXnP1zSMwd16Vpc1nc6vSiJ9
	3llIhVhdqOkhXO6DKtuaCc6kgvOZVGSyBwAQKMIIZ+xkoN4wT0ueluOfwXApZwDs
	qoc1IYOmhwdUBNgjm5JNCwjwujy3jaoTjlKcIbOWdWCqPlHbDOgM37cu90QX9jv1
	psm2aPdUQ6n0YbPCmwZytL2eWN3U3llMC+vzo8VUJg2lCS7IO0ZNSQvY6eeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725008954; x=1725095354; bh=oG844HO9UJSVp5oIsWv/vVhlRm9a
	Uef9v9PvV/sovB4=; b=DdGU0XjyiH9ag8O1Jz54JN3FCFomFSKgoKR2eP5rfWqF
	pFB7vYLyhD47nAjBrGAVxPHoPywCETQ6H0j74tNNKJhGxuae/Aam8wWGCUggYZib
	XkNQWptBVOWPJcGHsGZXBBSji2x2IXNs5sDduqhGyDJEbLkMX+ZZPvojKZsdogrU
	vp90nKRrxTURzgUab0JVbs0U49ZRV0Ror/UYoln2uglIECxmr1va2K46w+lLb0lJ
	zy/0APvwjkNqZbBV3x0rxWDRNgJMZUqQ2KhNZssivWUHqQmLuyGQb1hD987lilLN
	PuvtCU7UJUs3ntXc+t5fQiaEiYw3rRoNzcfE2qmwww==
X-ME-Sender: <xms:OozRZgkNjBtO-pE9B3MFVsl2lnHyReorjZNRi7XNs-qUpMEihMwfYQ>
    <xme:OozRZv2-magQO5BDaUeJloiqfQTWgsVJMq_XlaimWEUfmSn9bKM-thenMESt_SKDc
    bbqdGFJDXUSyN8DBg>
X-ME-Received: <xmr:OozRZur3qVldSQKug1PsN5pQMzzlZ6BsstHFk_tfA8jH9tBURQB9tXtiuchi5AkJKuJLYHM9jHC1lOCK_RNI-ukPNS37jD4-hpbV7uBLwLtlCogvNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhooh
    hglhgvrdgtohhm
X-ME-Proxy: <xmx:OozRZsk2tp7g_72eTa8Ghwzq4jinjsyOowiLN_SuDVNzPQWfxTaeEg>
    <xmx:OozRZu2tXVT3wuthSv_HZqGxCiQgfT0cGff21md88fBLg1g9OV6ZyA>
    <xmx:OozRZjuYiHObQamy907Wl-xl6o6q0XhaV_EkTWEBNWRG3Axn8DrMWA>
    <xmx:OozRZqVk79x-A5010T-EpPcPdeuTeSJ28M7Aw9s_Zc1YTiWtGyGncQ>
    <xmx:OozRZhQDKYaRIhXtkdoTfXxj9trDx_0TozOjin4KbMrqsnkRsYgId7P0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:09:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 71f27b12 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:09:02 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:09:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/21] environment: make `get_git_work_tree()` accept a
 repository
Message-ID: <22e9dcb28a981eaa1a37a8b41e8d061347ed6c2e.1725008898.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725008897.git.ps@pks.im>

The `get_git_work_tree()` function retrieves the path of the work tree
of `the_repository`. Make it accept a `struct repository` such that it
can work on arbitrary repositories and make it part of the repository
subsystem. This reduces our reliance on `the_repository` and clarifies
scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c             |  2 +-
 builtin/difftool.c          |  4 ++--
 builtin/fsmonitor--daemon.c |  4 ++--
 builtin/init-db.c           |  4 ++--
 builtin/reset.c             |  5 +++--
 builtin/rev-parse.c         |  4 ++--
 builtin/stash.c             |  2 +-
 builtin/submodule--helper.c |  2 +-
 builtin/update-index.c      |  2 +-
 dir.c                       |  3 ++-
 environment.c               |  7 +------
 environment.h               |  1 -
 fsmonitor.c                 |  3 ++-
 pathspec.c                  |  2 +-
 repository.c                |  5 +++++
 repository.h                |  1 +
 setup.c                     | 16 ++++++++--------
 trace.c                     |  3 +--
 18 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 35e975fb132..1ffdda50904 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1081,7 +1081,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			path = add_prefix(prefix, argv[1]);
 			argv[1] = argv[2];
 		} else {	/* (2a) */
-			if (argc == 2 && is_a_rev(argv[1]) && !get_git_work_tree())
+			if (argc == 2 && is_a_rev(argv[1]) && !repo_get_work_tree(the_repository))
 				die("missing <path> to blame");
 			path = add_prefix(prefix, argv[argc - 1]);
 		}
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 8c59411e6e0..7f2cbd797ad 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -378,7 +378,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	struct hashmap wt_modified, tmp_modified;
 	int indices_loaded = 0;
 
-	workdir = get_git_work_tree();
+	workdir = repo_get_work_tree(the_repository);
 
 	/* Setup temp directories */
 	tmp = getenv("TMPDIR");
@@ -739,7 +739,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	if (!no_index){
 		setup_work_tree();
 		setenv(GIT_DIR_ENVIRONMENT, absolute_path(repo_get_git_dir(the_repository)), 1);
-		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
+		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(repo_get_work_tree(the_repository)), 1);
 	} else if (dir_diff)
 		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
 
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index c54e736716a..25451d999e9 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -2,7 +2,6 @@
 #include "abspath.h"
 #include "config.h"
 #include "dir.h"
-#include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "fsmonitor-ll.h"
@@ -1291,7 +1290,8 @@ static int fsmonitor_run_daemon(void)
 
 	/* Prepare to (recursively) watch the <worktree-root> directory. */
 	strbuf_init(&state.path_worktree_watch, 0);
-	strbuf_addstr(&state.path_worktree_watch, absolute_path(get_git_work_tree()));
+	strbuf_addstr(&state.path_worktree_watch,
+		      absolute_path(repo_get_work_tree(the_repository)));
 	state.nr_paths_watching = 1;
 
 	strbuf_init(&state.alias.alias, 0);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 582dcf20f86..fb04962dcea 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -231,9 +231,9 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			set_git_work_tree(work_tree);
 		else
 			set_git_work_tree(git_work_tree_cfg);
-		if (access(get_git_work_tree(), X_OK))
+		if (access(repo_get_work_tree(the_repository), X_OK))
 			die_errno (_("Cannot access work tree '%s'"),
-				   get_git_work_tree());
+				   repo_get_work_tree(the_repository));
 	}
 	else {
 		if (real_git_dir)
diff --git a/builtin/reset.c b/builtin/reset.c
index 5f941fb3a29..86b2f07d660 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -26,6 +26,7 @@
 #include "object-name.h"
 #include "parse-options.h"
 #include "path.h"
+#include "repository.h"
 #include "unpack-trees.h"
 #include "cache-tree.h"
 #include "setup.h"
@@ -441,7 +442,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	else
 		trace2_cmd_mode(reset_type_names[reset_type]);
 
-	if (reset_type != SOFT && (reset_type != MIXED || get_git_work_tree()))
+	if (reset_type != SOFT && (reset_type != MIXED || repo_get_work_tree(the_repository)))
 		setup_work_tree();
 
 	if (reset_type == MIXED && is_bare_repository())
@@ -474,7 +475,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				goto cleanup;
 			}
 			the_repository->index->updated_skipworktree = 1;
-			if (!no_refresh && get_git_work_tree()) {
+			if (!no_refresh && repo_get_work_tree(the_repository)) {
 				uint64_t t_begin, t_delta_in_ms;
 
 				t_begin = getnanotime();
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index cd85fe57bb0..a5108266daf 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -967,7 +967,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--show-toplevel")) {
-				const char *work_tree = get_git_work_tree();
+				const char *work_tree = repo_get_work_tree(the_repository);
 				if (work_tree)
 					print_path(work_tree, prefix, format, DEFAULT_UNMODIFIED);
 				else
@@ -992,7 +992,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				const char *pfx = prefix;
 				if (!is_inside_work_tree()) {
 					const char *work_tree =
-						get_git_work_tree();
+						repo_get_work_tree(the_repository);
 					if (work_tree)
 						printf("%s\n", work_tree);
 					continue;
diff --git a/builtin/stash.c b/builtin/stash.c
index f2ec9549a47..354641b3f10 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -641,7 +641,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		cp.git_cmd = 1;
 		cp.dir = prefix;
 		strvec_pushf(&cp.env, GIT_WORK_TREE_ENVIRONMENT"=%s",
-			     absolute_path(get_git_work_tree()));
+			     absolute_path(repo_get_work_tree(the_repository)));
 		strvec_pushf(&cp.env, GIT_DIR_ENVIRONMENT"=%s",
 			     absolute_path(repo_get_git_dir(the_repository)));
 		strvec_push(&cp.args, "status");
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 85fb23dee84..865b454d693 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1709,7 +1709,7 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 		exit(128);
 
 	if (!is_absolute_path(clone_data->path))
-		clone_data_path = to_free = xstrfmt("%s/%s", get_git_work_tree(),
+		clone_data_path = to_free = xstrfmt("%s/%s", repo_get_work_tree(the_repository),
 						    clone_data->path);
 
 	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 86c5d40e400..8baa2256194 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1194,7 +1194,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				  "remove or change it, if you really want to "
 				  "enable the untracked cache"));
 		add_untracked_cache(the_repository->index);
-		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
+		report(_("Untracked cache enabled for '%s'"), repo_get_work_tree(the_repository));
 		break;
 	default:
 		BUG("bad untracked_cache value: %d", untracked_cache);
diff --git a/dir.c b/dir.c
index 5a23376bdae..c43b5e30813 100644
--- a/dir.c
+++ b/dir.c
@@ -20,6 +20,7 @@
 #include "object-store-ll.h"
 #include "path.h"
 #include "refs.h"
+#include "repository.h"
 #include "wildmatch.h"
 #include "pathspec.h"
 #include "utf8.h"
@@ -2838,7 +2839,7 @@ static const char *get_ident_string(void)
 		return sb.buf;
 	if (uname(&uts) < 0)
 		die_errno(_("failed to get kernel name and information"));
-	strbuf_addf(&sb, "Location %s, system %s", get_git_work_tree(),
+	strbuf_addf(&sb, "Location %s, system %s", repo_get_work_tree(the_repository),
 		    uts.sysname);
 	return sb.buf;
 }
diff --git a/environment.c b/environment.c
index 371f01a705d..4d0637b3822 100644
--- a/environment.c
+++ b/environment.c
@@ -219,7 +219,7 @@ void setup_git_env(const char *git_dir)
 int is_bare_repository(void)
 {
 	/* if core.bare is not 'false', let's see if there is a work tree */
-	return is_bare_repository_cfg && !get_git_work_tree();
+	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
 }
 
 int have_git_dir(void)
@@ -268,11 +268,6 @@ void set_git_work_tree(const char *new_work_tree)
 	repo_set_worktree(the_repository, new_work_tree);
 }
 
-const char *get_git_work_tree(void)
-{
-	return the_repository->worktree;
-}
-
 int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
 {
 	int fd;
diff --git a/environment.h b/environment.h
index d12c48481b6..52e1803aba6 100644
--- a/environment.h
+++ b/environment.h
@@ -108,7 +108,6 @@ extern char *git_work_tree_cfg;
 void set_git_dir(const char *path, int make_realpath);
 const char *get_git_namespace(void);
 const char *strip_namespace(const char *namespaced_ref);
-const char *get_git_work_tree(void);
 void set_git_work_tree(const char *tree);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
diff --git a/fsmonitor.c b/fsmonitor.c
index 28130f748f7..237ca59d004 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -8,6 +8,7 @@
 #include "fsmonitor.h"
 #include "fsmonitor-ipc.h"
 #include "name-hash.h"
+#include "repository.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "trace2.h"
@@ -169,7 +170,7 @@ static int query_fsmonitor_hook(struct repository *r,
 	strvec_pushf(&cp.args, "%d", version);
 	strvec_pushf(&cp.args, "%s", last_update);
 	cp.use_shell = 1;
-	cp.dir = get_git_work_tree();
+	cp.dir = repo_get_work_tree(the_repository);
 
 	trace2_region_enter("fsm_hook", "query", NULL);
 
diff --git a/pathspec.c b/pathspec.c
index 416fe1e3dcc..0fc6f84a6e6 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -495,7 +495,7 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 			if (!have_git_dir())
 				die(_("'%s' is outside the directory tree"),
 				    copyfrom);
-			hint_path = get_git_work_tree();
+			hint_path = repo_get_work_tree(the_repository);
 			if (!hint_path)
 				hint_path = repo_get_git_dir(the_repository);
 			die(_("%s: '%s' is outside repository at '%s'"), elt,
diff --git a/repository.c b/repository.c
index cdefcb4002d..92238da3d9e 100644
--- a/repository.c
+++ b/repository.c
@@ -126,6 +126,11 @@ const char *repo_get_graft_file(struct repository *repo)
 	return repo->graft_file;
 }
 
+const char *repo_get_work_tree(struct repository *repo)
+{
+	return repo->worktree;
+}
+
 static void repo_set_commondir(struct repository *repo,
 			       const char *commondir)
 {
diff --git a/repository.h b/repository.h
index ad0f984b444..c603e969ae7 100644
--- a/repository.h
+++ b/repository.h
@@ -211,6 +211,7 @@ const char *repo_get_common_dir(struct repository *repo);
 const char *repo_get_object_directory(struct repository *repo);
 const char *repo_get_index_file(struct repository *repo);
 const char *repo_get_graft_file(struct repository *repo);
+const char *repo_get_work_tree(struct repository *repo);
 
 /*
  * Define a custom repository layout. Any field can be NULL, which
diff --git a/setup.c b/setup.c
index 1ebcab625fe..1bfec288ab6 100644
--- a/setup.c
+++ b/setup.c
@@ -51,7 +51,7 @@ static int abspath_part_inside_repo(char *path)
 	size_t wtlen;
 	char *path0;
 	int off;
-	const char *work_tree = precompose_string_if_needed(get_git_work_tree());
+	const char *work_tree = precompose_string_if_needed(repo_get_work_tree(the_repository));
 	struct strbuf realpath = STRBUF_INIT;
 
 	if (!work_tree)
@@ -147,7 +147,7 @@ char *prefix_path(const char *prefix, int len, const char *path)
 {
 	char *r = prefix_path_gently(prefix, len, NULL, path);
 	if (!r) {
-		const char *hint_path = get_git_work_tree();
+		const char *hint_path = repo_get_work_tree(the_repository);
 		if (!hint_path)
 			hint_path = repo_get_git_dir(the_repository);
 		die(_("'%s' is outside repository at '%s'"), path,
@@ -475,7 +475,7 @@ int is_inside_git_dir(void)
 int is_inside_work_tree(void)
 {
 	if (inside_work_tree < 0)
-		inside_work_tree = is_inside_dir(get_git_work_tree());
+		inside_work_tree = is_inside_dir(repo_get_work_tree(the_repository));
 	return inside_work_tree;
 }
 
@@ -490,7 +490,7 @@ void setup_work_tree(void)
 	if (work_tree_config_is_bogus)
 		die(_("unable to set up work tree using invalid config"));
 
-	work_tree = get_git_work_tree();
+	work_tree = repo_get_work_tree(the_repository);
 	if (!work_tree || chdir_notify(work_tree))
 		die(_("this operation must be run in a work tree"));
 
@@ -547,7 +547,7 @@ static void setup_original_cwd(void)
 	 * Get our worktree; we only protect the current working directory
 	 * if it's in the worktree.
 	 */
-	worktree = get_git_work_tree();
+	worktree = repo_get_work_tree(the_repository);
 	if (!worktree)
 		goto no_prevention_needed;
 
@@ -1062,9 +1062,9 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 		set_git_work_tree(".");
 
 	/* set_git_work_tree() must have been called by now */
-	worktree = get_git_work_tree();
+	worktree = repo_get_work_tree(the_repository);
 
-	/* both get_git_work_tree() and cwd are already normalized */
+	/* both repo_get_work_tree() and cwd are already normalized */
 	if (!strcmp(cwd->buf, worktree)) { /* cwd == worktree */
 		set_git_dir(gitdirenv, 0);
 		free(gitfile);
@@ -2192,7 +2192,7 @@ static int create_default_files(const char *template_path,
 	char *path;
 	int reinit;
 	int filemode;
-	const char *work_tree = get_git_work_tree();
+	const char *work_tree = repo_get_work_tree(the_repository);
 
 	/*
 	 * First copy the templates -- we might have the default
diff --git a/trace.c b/trace.c
index e6728c301f3..d8c43773ae8 100644
--- a/trace.c
+++ b/trace.c
@@ -25,7 +25,6 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "environment.h"
 #include "repository.h"
 #include "quote.h"
 #include "setup.h"
@@ -308,7 +307,7 @@ void trace_repo_setup(void)
 
 	cwd = xgetcwd();
 
-	if (!(git_work_tree = get_git_work_tree()))
+	if (!(git_work_tree = repo_get_work_tree(the_repository)))
 		git_work_tree = "(null)";
 
 	if (!startup_info->prefix)
-- 
2.46.0.421.g159f2d50e7.dirty

