Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75841A2656
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140571; cv=none; b=UdGM07j7wGrmdXJdbnNGh08gmFPlUA6Y0DESl8FhQifhTGpBsHnTqyeUjh+I6th8KJOHSOE1eSvROpft2xYPAqp7YD4DWftbNinq00tDyoGctSO8QVq10OpiqtNtx8Ri5jBQnPE82ol88GroTeAvcdBNSXHiVMEvCQx/qbDlLqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140571; c=relaxed/simple;
	bh=1dhdBD7YylxoN3p/VWG8gZBOveydwmo4VGMZF0G8OZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meZoiOacrdq+sAPGvlhE3f3B+r6a/920VKfGB5rI3r4IZihlhXreayljS8cUe08a515Wd0msqsb6a6rLkmEcbOVNMz+0kGBQUdRNnJNZL4aL9KgiL0KMeQeFZv54uYmahAGWxhEvgU0w+6Vqm7/tONVwFPVXkLvHkkzm7qSZFQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EpGYFq/2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KWi3s0gO; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EpGYFq/2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KWi3s0gO"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E260811405E4;
	Thu, 12 Sep 2024 07:29:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 12 Sep 2024 07:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726140568; x=1726226968; bh=3DzHcWjV14
	DGevbGHDMhbO+LEojUNp1+BIUwiWdj2n4=; b=EpGYFq/2pYjkiMGTld1+iU/3YH
	EiQPgDpcYswnFLuLAOBlD/PkYO0Xzrz3oaMa0GnoSAvS7J4vjiE/VdJ3NClcCHNH
	zdpeoYoC2w1+gqYX9vzybTmLw96BPjfzwSyXKHjzlu2yX4/dJ3Zx7CpiwWZw1mqD
	xNtTA3DKFL0K8DrTsi3Apd9TbH6ErFhmpVu2c5p1tK/pQ2Gq/aR2L8XM7inxYH8E
	9v5MpsrUYx6oHbV9lRUeMP3796mkWLqOUGaOFzvAQKvovujUd6pNw2Peh7yFvwhv
	fmw5b332nri/oG/L3ImtXU4wx4ZfuwnZiCVj1R5vtVK1Ak6HSPkwHxtWOMUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726140568; x=1726226968; bh=3DzHcWjV14DGevbGHDMhbO+LEojU
	Np1+BIUwiWdj2n4=; b=KWi3s0gOn5/fsvN8f3c+XuY9lPmT0DLmb2rPCcWVxKEI
	jvlmeWRlDN3/rSu7fzJKc0qFMsndX0qvjjkUFI0VQIQqKoufrVlTOCzq23W0lPP7
	BV13SOHIf9bNS08Ndp2G5FGdkwNXW2T5FBAR3HdBHmAm/G/lBMC858XD4Ynypbw+
	TUy2d/PHup4rfZVJO+dQQLFaiLlWWLTkdKQfmhus4QvwB+UsTC7KIYGKD6+sCzg5
	8+e074CCPwbAvapRj2FyPdbyHobMLONqs0gQKhvqdoadrfHJuhbwAYZ8SfTaLm5o
	sWmvuuq7mioQd8rdeW0CJrYGI1hX+w9DN3BDnUeg2Q==
X-ME-Sender: <xms:mNDiZrRIaRWylbNmbwug9Ls6PSoJrMjrOHLGyJ9Jm7ooHqOWojy7Mg>
    <xme:mNDiZszICxvmIE6Oc33bbT36kIOUpXvsLSqlikGOFndzGro7SM9XFKpiUfXTy9pgQ
    ZN2Bjqmq8faSroyfw>
X-ME-Received: <xmr:mNDiZg0f3BXZ-M_KQioBi22ICDJNgV2VWf4xn6dC6Lv75xND6JfG6fwEg8EaAkUP-j-LuieMUaICYzHLX_olgccw6iSSCnteH5Z0AN7X3z9B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggrlhhv
    ihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:mNDiZrBSfj3gIeymZyra4lnplAbWLN1tHZxx-_-MLAvvqKNDWFZ06w>
    <xmx:mNDiZkgZl8NOco56UPpR50xunCGPZ_X_Ahe-Ca5dSSgdMVc33pG4qQ>
    <xmx:mNDiZvoPU0dZASm3yTiblLIVn8afPdwO5HYn_4aysQx8ASnJ2znSmQ>
    <xmx:mNDiZvj6zfdQnexgSkGMrqTSBimKhRYt3A1Wc3lkec4AnWrtVJ-2fg>
    <xmx:mNDiZuZEdPgHH9HJ_dw2an5t53c2BPBgVudHLZdsgOxrjNqQ5ZKqkJ9L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:29:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id edc33836 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:29:18 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:29:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 02/21] environment: make `get_git_common_dir()` accept a
 repository
Message-ID: <2964cfc77901bac58bda4614befa604f16bfec90.1726139990.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1726139990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726139990.git.ps@pks.im>

The `get_git_common_dir()` function retrieves the path to the common
directory for `the_repository`. Make it accept a `struct repository`
such that it can work on arbitrary repositories and make it part of the
repository subsystem. This reduces our reliance on `the_repository` and
clarifies scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c    | 2 +-
 builtin/gc.c        | 2 +-
 builtin/rev-parse.c | 3 ++-
 builtin/worktree.c  | 4 ++--
 config.c            | 2 +-
 environment.c       | 7 -------
 environment.h       | 1 -
 repository.c        | 7 +++++++
 repository.h        | 1 +
 setup.c             | 2 +-
 submodule.c         | 2 +-
 trace.c             | 2 +-
 worktree.c          | 8 ++++----
 13 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index c10697a2efb..34a371414e8 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -807,7 +807,7 @@ static void location_options_init(struct config_location_options *opts,
 	else
 		opts->options.respect_includes = opts->respect_includes_opt;
 	if (startup_info->have_repository) {
-		opts->options.commondir = get_git_common_dir();
+		opts->options.commondir = repo_get_common_dir(the_repository);
 		opts->options.git_dir = repo_get_git_dir(the_repository);
 	}
 }
diff --git a/builtin/gc.c b/builtin/gc.c
index 427faf1cfe1..0f3d74f8bd0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2132,7 +2132,7 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 	get_schedule_cmd(&cmd, NULL);
 
 	strbuf_addf(&tfilename, "%s/schedule_%s_XXXXXX",
-		    get_git_common_dir(), frequency);
+		    repo_get_common_dir(the_repository), frequency);
 	tfile = xmks_tempfile(tfilename.buf);
 	strbuf_release(&tfilename);
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 4285dc34a7b..cd85fe57bb0 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -19,6 +19,7 @@
 #include "path.h"
 #include "diff.h"
 #include "read-cache-ll.h"
+#include "repository.h"
 #include "revision.h"
 #include "setup.h"
 #include "split-index.h"
@@ -1042,7 +1043,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--git-common-dir")) {
-				print_path(get_git_common_dir(), prefix, format, DEFAULT_RELATIVE_IF_SHARED);
+				print_path(repo_get_common_dir(the_repository), prefix, format, DEFAULT_RELATIVE_IF_SHARED);
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 41e7f6a3271..645b548bf3b 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -219,7 +219,7 @@ static void prune_worktrees(void)
 	}
 	closedir(dir);
 
-	strbuf_add_absolute_path(&main_path, get_git_common_dir());
+	strbuf_add_absolute_path(&main_path, repo_get_common_dir(the_repository));
 	/* massage main worktree absolute path to match 'gitdir' content */
 	strbuf_strip_suffix(&main_path, "/.");
 	string_list_append_nodup(&kept, strbuf_detach(&main_path, NULL));
@@ -492,7 +492,7 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
 	strbuf_realpath(&realpath, sb_git.buf, 1);
 	write_file(sb.buf, "%s", realpath.buf);
-	strbuf_realpath(&realpath, get_git_common_dir(), 1);
+	strbuf_realpath(&realpath, repo_get_common_dir(the_repository), 1);
 	write_file(sb_git.buf, "gitdir: %s/worktrees/%s",
 		   realpath.buf, name);
 	strbuf_reset(&sb);
diff --git a/config.c b/config.c
index 1733ba85dcd..0b87f0f9050 100644
--- a/config.c
+++ b/config.c
@@ -2213,7 +2213,7 @@ void read_early_config(config_fn_t cb, void *data)
 	opts.respect_includes = 1;
 
 	if (have_git_dir()) {
-		opts.commondir = get_git_common_dir();
+		opts.commondir = repo_get_common_dir(the_repository);
 		opts.git_dir = repo_get_git_dir(the_repository);
 	/*
 	 * When setup_git_directory() was not yet asked to discover the
diff --git a/environment.c b/environment.c
index 040b1ff1ba8..7c4a142ca25 100644
--- a/environment.c
+++ b/environment.c
@@ -228,13 +228,6 @@ int have_git_dir(void)
 		|| the_repository->gitdir;
 }
 
-const char *get_git_common_dir(void)
-{
-	if (!the_repository->commondir)
-		BUG("git environment hasn't been setup");
-	return the_repository->commondir;
-}
-
 const char *get_git_namespace(void)
 {
 	if (!git_namespace)
diff --git a/environment.h b/environment.h
index 06d37d5c82b..d778614158f 100644
--- a/environment.h
+++ b/environment.h
@@ -106,7 +106,6 @@ int have_git_dir(void);
 extern int is_bare_repository_cfg;
 int is_bare_repository(void);
 extern char *git_work_tree_cfg;
-const char *get_git_common_dir(void);
 const char *get_object_directory(void);
 char *get_index_file(void);
 char *get_graft_file(struct repository *r);
diff --git a/repository.c b/repository.c
index 31afc62551e..c8dcba1997a 100644
--- a/repository.c
+++ b/repository.c
@@ -98,6 +98,13 @@ const char *repo_get_git_dir(struct repository *repo)
 	return repo->gitdir;
 }
 
+const char *repo_get_common_dir(struct repository *repo)
+{
+	if (!repo->commondir)
+		BUG("repository hasn't been set up");
+	return repo->commondir;
+}
+
 static void repo_set_commondir(struct repository *repo,
 			       const char *commondir)
 {
diff --git a/repository.h b/repository.h
index cf2172c0aa5..404435ad029 100644
--- a/repository.h
+++ b/repository.h
@@ -207,6 +207,7 @@ extern struct repository *the_repository;
 #endif
 
 const char *repo_get_git_dir(struct repository *repo);
+const char *repo_get_common_dir(struct repository *repo);
 
 /*
  * Define a custom repository layout. Any field can be NULL, which
diff --git a/setup.c b/setup.c
index 4a9c60922e7..fe4a5dfc43b 100644
--- a/setup.c
+++ b/setup.c
@@ -2068,7 +2068,7 @@ static void copy_templates(const char *option_template)
 		goto close_free_return;
 	}
 
-	strbuf_addstr(&path, get_git_common_dir());
+	strbuf_addstr(&path, repo_get_common_dir(the_repository));
 	strbuf_complete(&path, '/');
 	copy_templates_1(&path, &template_path, dir);
 close_free_return:
diff --git a/submodule.c b/submodule.c
index 97516b0fec1..c7d164a31ab 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2462,7 +2462,7 @@ void absorb_git_dir_into_superproject(const char *path,
 	} else {
 		/* Is it already absorbed into the superprojects git dir? */
 		char *real_sub_git_dir = real_pathdup(sub_git_dir, 1);
-		char *real_common_git_dir = real_pathdup(get_git_common_dir(), 1);
+		char *real_common_git_dir = real_pathdup(repo_get_common_dir(the_repository), 1);
 
 		if (!starts_with(real_sub_git_dir, real_common_git_dir))
 			relocate_single_git_dir_into_superproject(path, super_prefix);
diff --git a/trace.c b/trace.c
index 32c5cda7afd..e6728c301f3 100644
--- a/trace.c
+++ b/trace.c
@@ -315,7 +315,7 @@ void trace_repo_setup(void)
 		prefix = "(null)";
 
 	trace_printf_key(&trace_setup_key, "setup: git_dir: %s\n", quote_crnl(repo_get_git_dir(the_repository)));
-	trace_printf_key(&trace_setup_key, "setup: git_common_dir: %s\n", quote_crnl(get_git_common_dir()));
+	trace_printf_key(&trace_setup_key, "setup: git_common_dir: %s\n", quote_crnl(repo_get_common_dir(the_repository)));
 	trace_printf_key(&trace_setup_key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
 	trace_printf_key(&trace_setup_key, "setup: cwd: %s\n", quote_crnl(cwd));
 	trace_printf_key(&trace_setup_key, "setup: prefix: %s\n", quote_crnl(prefix));
diff --git a/worktree.c b/worktree.c
index 11335c5d9a3..0f032ccedff 100644
--- a/worktree.c
+++ b/worktree.c
@@ -72,7 +72,7 @@ static struct worktree *get_main_worktree(int skip_reading_head)
 	struct worktree *worktree = NULL;
 	struct strbuf worktree_path = STRBUF_INIT;
 
-	strbuf_add_real_path(&worktree_path, get_git_common_dir());
+	strbuf_add_real_path(&worktree_path, repo_get_common_dir(the_repository));
 	strbuf_strip_suffix(&worktree_path, "/.git");
 
 	CALLOC_ARRAY(worktree, 1);
@@ -143,7 +143,7 @@ static struct worktree **get_worktrees_internal(int skip_reading_head)
 
 	list[counter++] = get_main_worktree(skip_reading_head);
 
-	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
+	strbuf_addf(&path, "%s/worktrees", repo_get_common_dir(the_repository));
 	dir = opendir(path.buf);
 	strbuf_release(&path);
 	if (dir) {
@@ -173,7 +173,7 @@ const char *get_worktree_git_dir(const struct worktree *wt)
 	if (!wt)
 		return repo_get_git_dir(the_repository);
 	else if (!wt->id)
-		return get_git_common_dir();
+		return repo_get_common_dir(the_repository);
 	else
 		return git_common_path("worktrees/%s", wt->id);
 }
@@ -626,7 +626,7 @@ static int is_main_worktree_path(const char *path)
 
 	strbuf_add_real_path(&target, path);
 	strbuf_strip_suffix(&target, "/.git");
-	strbuf_add_real_path(&maindir, get_git_common_dir());
+	strbuf_add_real_path(&maindir, repo_get_common_dir(the_repository));
 	strbuf_strip_suffix(&maindir, "/.git");
 	cmp = fspathcmp(maindir.buf, target.buf);
 
-- 
2.46.0.551.gc5ee8f2d1c.dirty

