Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75D0C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 21:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjBNV4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBNV4B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 16:56:01 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807FA10A
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:56:00 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id 5so19793493qtp.9
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gOpYPjXx+n+XaVzo1GY+3Vhk8iubsJ12qLPGAL6pEg=;
        b=jqYNfUxzwgpWd7bfOrFdywL2wSAKx08w59DnT7DMV10quzEpVOehytaDu0JHpijsQf
         DpE6lV11wQYwLD76KKWlwVntx6wMNNxKJ8bBTjMNW3sRNqqHuuehJd+ekX3IU1e6Aa57
         SPe1LAj1//cbefpvkxNz+44cODz0kT6j6Nk8rt5dwGvGtE+EpRfsEa+6BRq4J6DyCXB/
         ElOTX+Kpw5mUkhaL8WMLbWCUGDlX5FDr07u/9wYXvTxnmZuLgqTOsLxuY5ymU+RqKung
         tSC5pqZD7F0WFigXJ3mWLA/YPVikcth1XmQxIcnT6fv77uVJHogkQBP+UQCLlc7thmVs
         usyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gOpYPjXx+n+XaVzo1GY+3Vhk8iubsJ12qLPGAL6pEg=;
        b=8MFvi6M28mb/K/D3tjEFu55iNMcNOS7Fnf+WRsoUdFmik+D6dUfYeWOHBewfvH1z/C
         y5VQVpUi9DtF/efC4+7KBpsqBjOlrk+bPNSAPAxTTtB57HlyXgu86EUMbVOm5dEbFy3E
         v2NmAa9ahYDErmvtg4nEXkxrhMtqufefprY2MipIsjHvuKy9QyiuQsiXaxRW6YGrIXBr
         v1g5qRNSy5qxfRJIn2JiohlZ7DxmEKHZX8eV3NFS+77u+5fUlclJcIJcd/h0cncfxtRT
         gLgw70wSFYErAmdBZJtcFYFY7d0UMzSPBwOWHtcbQ7WaTdsQNsNlSG9JKMLPLOGwDWZ+
         f3Nw==
X-Gm-Message-State: AO0yUKXTq6R5JZcuoHR8Fq8pMNoo/F3XGR75IMZugB+iQpL0Z3uzehYv
        O9aKPAsrgwD6GE0fK6r3KDoDYQfKjgigdQ==
X-Google-Smtp-Source: AK7set/gc9D7L3GbBMojyUIZtUIpLc6fIUtxL8oAP+qC/GVPslLYvyEi96kvcTf5QnRFK8DGbjdc/Q==
X-Received: by 2002:ac8:5c01:0:b0:3b9:a4be:fc4a with SMTP id i1-20020ac85c01000000b003b9a4befc4amr6833223qti.14.1676411758958;
        Tue, 14 Feb 2023 13:55:58 -0800 (PST)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id e16-20020a05620a015000b0073b399700adsm5536142qkn.3.2023.02.14.13.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 13:55:58 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, gitster@pobox.com
Subject: [PATCH v2] builtin/*: fix error message usage typo
Date:   Tue, 14 Feb 2023 16:54:03 -0500
Message-Id: <20230214215403.1450903-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230214032534.507628-1-cheskaqiqi@gmail.com>
References: <20230214032534.507628-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Documentation/CodingGuidelines says, we shouldn't capitalize the
first word in error message.
Change the capital letter to lowercase letter.

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 builtin/merge-base.c        |  6 +++---
 builtin/remote-fd.c         | 10 ++++-----
 builtin/submodule--helper.c | 42 ++++++++++++++++++-------------------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 6f3941f2a4..d0fc14786e 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -43,10 +43,10 @@ static struct commit *get_commit_reference(const char *arg)
 	struct commit *r;
 
 	if (get_oid(arg, &revkey))
-		die("Not a valid object name %s", arg);
+		die("not a valid object name %s", arg);
 	r = lookup_commit_reference(the_repository, &revkey);
 	if (!r)
-		die("Not a valid commit name %s", arg);
+		die("not a valid commit name %s", arg);
 
 	return r;
 }
@@ -119,7 +119,7 @@ static int handle_fork_point(int argc, const char **argv)
 
 	commitname = (argc == 2) ? argv[1] : "HEAD";
 	if (get_oid(commitname, &oid))
-		die("Not a valid object name: '%s'", commitname);
+		die("not a valid object name: '%s'", commitname);
 
 	derived = lookup_commit_reference(the_repository, &oid);
 
diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
index 91dfe07e06..2ac2d23731 100644
--- a/builtin/remote-fd.c
+++ b/builtin/remote-fd.c
@@ -29,7 +29,7 @@ static void command_loop(int input_fd, int output_fd)
 		size_t i;
 		if (!fgets(buffer, MAXCOMMAND - 1, stdin)) {
 			if (ferror(stdin))
-				die("Input error");
+				die("input error");
 			return;
 		}
 		/* Strip end of line characters. */
@@ -45,10 +45,10 @@ static void command_loop(int input_fd, int output_fd)
 			fflush(stdout);
 			if (bidirectional_transfer_loop(input_fd,
 				output_fd))
-				die("Copying data between file descriptors failed");
+				die("copying data between file descriptors failed");
 			return;
 		} else {
-			die("Bad command: %s", buffer);
+			die("bad command: %s", buffer);
 		}
 	}
 }
@@ -65,7 +65,7 @@ int cmd_remote_fd(int argc, const char **argv, const char *prefix)
 	input_fd = (int)strtoul(argv[2], &end, 10);
 
 	if ((end == argv[2]) || (*end != ',' && *end != '/' && *end))
-		die("Bad URL syntax");
+		die("bad URL syntax");
 
 	if (*end == '/' || !*end) {
 		output_fd = input_fd;
@@ -74,7 +74,7 @@ int cmd_remote_fd(int argc, const char **argv, const char *prefix)
 		output_fd = (int)strtoul(end + 1, &end2, 10);
 
 		if ((end2 == end + 1) || (*end2 != '/' && *end2))
-			die("Bad URL syntax");
+			die("bad URL syntax");
 	}
 
 	command_loop(input_fd, output_fd);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 05f2c9bc98..4515d5005a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -40,7 +40,7 @@ static int repo_get_default_remote(struct repository *repo, char **default_remot
 						      NULL);
 
 	if (!refname)
-		return die_message(_("No such ref: %s"), "HEAD");
+		return die_message(_("no such ref: %s"), "HEAD");
 
 	/* detached HEAD */
 	if (!strcmp(refname, "HEAD")) {
@@ -49,7 +49,7 @@ static int repo_get_default_remote(struct repository *repo, char **default_remot
 	}
 
 	if (!skip_prefix(refname, "refs/heads/", &refname))
-		return die_message(_("Expecting a full ref name, got %s"),
+		return die_message(_("expecting a full ref name, got %s"),
 				   refname);
 
 	strbuf_addf(&sb, "branch.%s.remote", refname);
@@ -299,7 +299,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
 	if (!sub)
-		die(_("No url found for submodule path '%s' in .gitmodules"),
+		die(_("no url found for submodule path '%s' in .gitmodules"),
 			displaypath);
 
 	if (!is_submodule_populated_gently(path, NULL))
@@ -452,7 +452,7 @@ static void init_submodule(const char *path, const char *prefix,
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
 	if (!sub)
-		die(_("No url found for submodule path '%s' in .gitmodules"),
+		die(_("no url found for submodule path '%s' in .gitmodules"),
 			displaypath);
 
 	/*
@@ -475,7 +475,7 @@ static void init_submodule(const char *path, const char *prefix,
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
 	if (git_config_get_string(sb.buf, &url)) {
 		if (!sub->url)
-			die(_("No url found for submodule path '%s' in .gitmodules"),
+			die(_("no url found for submodule path '%s' in .gitmodules"),
 				displaypath);
 
 		url = xstrdup(sub->url);
@@ -490,7 +490,7 @@ static void init_submodule(const char *path, const char *prefix,
 		}
 
 		if (git_config_set_gently(sb.buf, url))
-			die(_("Failed to register url for submodule path '%s'"),
+			die(_("failed to register url for submodule path '%s'"),
 			    displaypath);
 		if (!(flags & OPT_QUIET))
 			fprintf(stderr,
@@ -512,7 +512,7 @@ static void init_submodule(const char *path, const char *prefix,
 		}
 
 		if (git_config_set_gently(sb.buf, upd))
-			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
+			die(_("failed to register update mode for submodule path '%s'"), displaypath);
 	}
 	strbuf_release(&sb);
 	free(displaypath);
@@ -1616,14 +1616,14 @@ static void prepare_possible_alternates(const char *sm_name,
 	else if (!strcmp(error_strategy, "ignore"))
 		sas.error_mode = SUBMODULE_ALTERNATE_ERROR_IGNORE;
 	else
-		die(_("Value '%s' for submodule.alternateErrorStrategy is not recognized"), error_strategy);
+		die(_("value '%s' for submodule.alternateErrorStrategy is not recognized"), error_strategy);
 
 	if (!strcmp(sm_alternate, "superproject"))
 		foreach_alt_odb(add_possible_reference_from_superproject, &sas);
 	else if (!strcmp(sm_alternate, "no"))
 		; /* do nothing */
 	else
-		die(_("Value '%s' for submodule.alternateLocation is not recognized"), sm_alternate);
+		die(_("value '%s' for submodule.alternateLocation is not recognized"), sm_alternate);
 
 	free(sm_alternate);
 	free(error_strategy);
@@ -1825,7 +1825,7 @@ static int determine_submodule_update_strategy(struct repository *r,
 		out->type = update;
 	} else if (!repo_config_get_string_tmp(r, key, &val)) {
 		if (parse_submodule_update_strategy(val, out) < 0) {
-			ret = die_message(_("Invalid update mode '%s' configured for submodule path '%s'"),
+			ret = die_message(_("invalid update mode '%s' configured for submodule path '%s'"),
 					  val, path);
 			goto cleanup;
 		}
@@ -2366,7 +2366,7 @@ static int remote_submodule_branch(const char *path, const char **branch)
 		const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
 
 		if (!refname)
-			return die_message(_("No such ref: %s"), "HEAD");
+			return die_message(_("no such ref: %s"), "HEAD");
 
 		/* detached HEAD */
 		if (!strcmp(refname, "HEAD"))
@@ -2501,7 +2501,7 @@ static int update_submodule(struct update_data *update_data)
 	if (update_data->just_cloned)
 		oidcpy(&update_data->suboid, null_oid());
 	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
-		return die_message(_("Unable to find current revision in submodule path '%s'"),
+		return die_message(_("unable to find current revision in submodule path '%s'"),
 				   update_data->displaypath);
 
 	if (update_data->remote) {
@@ -2523,12 +2523,12 @@ static int update_submodule(struct update_data *update_data)
 		if (!update_data->nofetch) {
 			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
 					      0, NULL))
-				return die_message(_("Unable to fetch in submodule path '%s'"),
+				return die_message(_("unable to fetch in submodule path '%s'"),
 						   update_data->sm_path);
 		}
 
 		if (resolve_gitlink_ref(update_data->sm_path, remote_ref, &update_data->oid))
-			return die_message(_("Unable to find %s revision in submodule path '%s'"),
+			return die_message(_("unable to find %s revision in submodule path '%s'"),
 					   remote_ref, update_data->sm_path);
 
 		free(remote_ref);
@@ -2555,7 +2555,7 @@ static int update_submodule(struct update_data *update_data)
 
 		ret = run_command(&cp);
 		if (ret)
-			die_message(_("Failed to recurse into submodule path '%s'"),
+			die_message(_("failed to recurse into submodule path '%s'"),
 				    update_data->displaypath);
 		return ret;
 	}
@@ -2768,7 +2768,7 @@ static int push_check(int argc, const char **argv, const char *prefix)
 	/* Get the submodule's head ref and determine if it is detached */
 	head = resolve_refdup("HEAD", 0, &head_oid, NULL);
 	if (!head)
-		die(_("Failed to resolve HEAD as a valid ref."));
+		die(_("failed to resolve HEAD as a valid ref."));
 	if (!strcmp(head, "HEAD"))
 		detached_head = 1;
 
@@ -3135,16 +3135,16 @@ static void configure_added_submodule(struct add_data *add_data)
 	strvec_pushl(&add_submod.args, "--", add_data->sm_path, NULL);
 
 	if (run_command(&add_submod))
-		die(_("Failed to add submodule '%s'"), add_data->sm_path);
+		die(_("failed to add submodule '%s'"), add_data->sm_path);
 
 	if (config_submodule_in_gitmodules(add_data->sm_name, "path", add_data->sm_path) ||
 	    config_submodule_in_gitmodules(add_data->sm_name, "url", add_data->repo))
-		die(_("Failed to register submodule '%s'"), add_data->sm_path);
+		die(_("failed to register submodule '%s'"), add_data->sm_path);
 
 	if (add_data->branch) {
 		if (config_submodule_in_gitmodules(add_data->sm_name,
 						   "branch", add_data->branch))
-			die(_("Failed to register submodule '%s'"), add_data->sm_path);
+			die(_("failed to register submodule '%s'"), add_data->sm_path);
 	}
 
 	add_gitmodules.git_cmd = 1;
@@ -3152,7 +3152,7 @@ static void configure_added_submodule(struct add_data *add_data)
 		     "add", "--force", "--", ".gitmodules", NULL);
 
 	if (run_command(&add_gitmodules))
-		die(_("Failed to register submodule '%s'"), add_data->sm_path);
+		die(_("failed to register submodule '%s'"), add_data->sm_path);
 
 	/*
 	 * NEEDSWORK: In a multi-working-tree world this needs to be
@@ -3289,7 +3289,7 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	if (starts_with_dot_dot_slash(add_data.repo) ||
 	    starts_with_dot_slash(add_data.repo)) {
 		if (prefix)
-			die(_("Relative path can only be used from the toplevel "
+			die(_("relative path can only be used from the toplevel "
 			      "of the working tree"));
 
 		/* dereference source url relative to parent's url */
-- 
2.39.0

