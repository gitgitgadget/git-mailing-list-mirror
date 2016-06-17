Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0008920179
	for <e@80x24.org>; Fri, 17 Jun 2016 20:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbcFQUYl (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:41 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:35432 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964922AbcFQUYj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:39 -0400
Received: (qmail 2450 invoked from network); 17 Jun 2016 20:24:38 -0000
Received: (qmail 9813 invoked from network); 17 Jun 2016 20:24:38 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:38 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 31/38] i18n: standardise messages
Date:	Fri, 17 Jun 2016 20:21:20 +0000
Message-Id: <1466194887-18236-32-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Standardise messages in order to save translators some work.

Nuances fixed in this commit:
"failed to read %s"
"read of %s failed"

"detach the HEAD at named commit"
"detach HEAD at named commit"

"removing '%s' failed"
"failed to remove '%s'"

"index file corrupt"
"corrupt index file"

"failed to read %s"
"read of %s failed"

"detach the HEAD at named commit"
"detach HEAD at named commit"

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/apply.c    | 6 +++---
 builtin/checkout.c | 6 +++---
 builtin/repack.c   | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c770d7d..a741274 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3226,7 +3226,7 @@ static int load_patch_target(struct strbuf *buf,
 {
 	if (cached || check_index) {
 		if (read_file_or_gitlink(ce, buf))
-			return error(_("read of %s failed"), name);
+			return error(_("failed to read %s"), name);
 	} else if (name) {
 		if (S_ISGITLINK(expected_mode)) {
 			if (ce)
@@ -3237,7 +3237,7 @@ static int load_patch_target(struct strbuf *buf,
 			return error(_("reading from '%s' beyond a symbolic link"), name);
 		} else {
 			if (read_old_data(st, name, buf))
-				return error(_("read of %s failed"), name);
+				return error(_("failed to read %s"), name);
 		}
 	}
 	return 0;
@@ -3282,7 +3282,7 @@ static int load_preimage(struct image *image,
 			free_fragment_list(patch->fragments);
 			patch->fragments = NULL;
 		} else if (status) {
-			return error(_("read of %s failed"), patch->old_name);
+			return error(_("failed to read %s"), patch->old_name);
 		}
 	}
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3398c61..05c7b71 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -276,7 +276,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 
 	hold_locked_index(lock_file, 1);
 	if (read_cache_preload(&opts->pathspec) < 0)
-		return error(_("corrupt index file"));
+		return error(_("index file corrupt"));
 
 	if (opts->source_tree)
 		read_tree_some(opts->source_tree, &opts->pathspec);
@@ -470,7 +470,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 
 	hold_locked_index(lock_file, 1);
 	if (read_cache_preload(NULL) < 0)
-		return error(_("corrupt index file"));
+		return error(_("index file corrupt"));
 
 	resolve_undo_clear();
 	if (opts->force) {
@@ -1138,7 +1138,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and checkout a branch")),
 		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
-		OPT_BOOL(0, "detach", &opts.force_detach, N_("detach the HEAD at named commit")),
+		OPT_BOOL(0, "detach", &opts.force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts.track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts.new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
diff --git a/builtin/repack.c b/builtin/repack.c
index 858db38..0108819 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -378,7 +378,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 					  item->string,
 					  exts[ext].name);
 			if (remove_path(fname))
-				warning(_("removing '%s' failed"), fname);
+				warning(_("failed to remove '%s'"), fname);
 			free(fname);
 		}
 	}
-- 
2.6.6

