Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530529616F
	for <git@vger.kernel.org>; Wed, 14 May 2025 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254812; cv=none; b=gmA5gTVX4O2qsTwMeknbedYkubD7RuqHK3M4i2Wrg+N5zYY6KH1PJRY/XB2ksXQPGJPfNwnrpmDvhjjuAl0jNiLH4G60ERfd6HWiJmaPzrsn2im4oUrJKE2iqDpBtj6zwzmmlGSGdP9T4ntNqtfZz6FBOWYRI4QR2XzmNVI0eI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254812; c=relaxed/simple;
	bh=KY42Ux5RxNcLwCUwLfVXRDrRrrAQPBdFeCnOGD3eAyk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ZlM0avPr1iQ+9X0xHnRe8k/0U8CtzK3KcJevfaEIdPjWYNhU0WCNzX05OYeDHELpqR+udcHuf7vZC4R2BC1lW7NQXnj4N1kQSouV31DX28uM5g65jZadULrWoU2kC7AB4s7rNhbUOS91u/cfxPAIlREctMbUkZB/zZUpXUy1AEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNBSlJHA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNBSlJHA"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-440685d6afcso2585545e9.0
        for <git@vger.kernel.org>; Wed, 14 May 2025 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747254808; x=1747859608; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8WnOrTB/5gMIPAZ95/PQ1wY4v3UeWAE9tvGEQ1Wz4sU=;
        b=aNBSlJHAMpMuhYVLODXNXZepyUsiCtbXuMLeWg68o2PQUSz5zzqJEroQ1nZsUVgRwn
         4mrC1QhUkgCWbuQ0ekgvDbLr6H/EzgRx4OlyD7gJfSzH1pBxWwZAsI1wbRaI7gUzhAX5
         wyL4TVL6ufodCS/7qwsFQLfPnLtMCod8zWW9Lyi0h+3i+Ih9pWtQ2ZSYW4uCbcB4OxZm
         Yc3ORJRcSWSYIz1JhUEuPBxSsD9uq2/a6OR9NKAAtlh+W1YFRvQK+szrD8oUMTStNuom
         aBG4NmYbxNr6/4rwrdnu2W9iVC6oR6pzN3ycaUIqroVdezNTJ7BoDJeYYxpw2SdZLCQM
         istg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747254808; x=1747859608;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WnOrTB/5gMIPAZ95/PQ1wY4v3UeWAE9tvGEQ1Wz4sU=;
        b=nxYhYZ1IIlUS5r7uakRcBBJzc5kO1dSxtlc+BJyYxBTeqo/aXebtVARFBvQpLGjj8p
         9rhfwQZYvioRFY6qUN68kBBMeYkc4eXqC3bKvc6g0cMf0e7xhvUwHgU3RY7uPRz32YHR
         qL+OPaB8BlVvqYaCmVR5vs9karGdoEImE+G/AYnSPO+EgZz1fmXo+IcLJ92Nsbo3ee/y
         ZUKK57lZNnyPtWoexTqgAS5d6LymOqCkK/nHMwfOWrrWgYL7sxVFAZurZRmGExYBb+JM
         Y1ZE76UjwKnj47BZIhSHsrzKGqEpZ0rHMdhMTA7T8U5xFl+cgN6P0gnFpHouOdQdGhvI
         ZrfA==
X-Gm-Message-State: AOJu0Yys7w39zCXpXsId3WdmF5Y32Pw/UhATB5M39Sy+4SroXVjpvyoo
	Pru2WTHhpSMsqv+xGI/2LjNKQfHxaAJfjiryKrFevbBQ/BQxpq/rSVUVwQ==
X-Gm-Gg: ASbGncu+g+HF4+ZYBEBbG8vMJMB0tR8/OHA4enMW35jc/Z32tCRM97Uk/qoC8jSazx6
	CFIVi3+odcF6h5u6F/KCdTtq8muwfurjeYrZTf88ELt0gAQr+1MXJ/JWZNNA8O8/UG6qrMIFmzC
	/r/7E3diL1ImJOGlC26HXQadYj6Gv6HZe408Cq2xEjjHcZQQLjqtRUAHKjfdOOVBDyOE3QlaZgI
	+EPtqERdMGhyO+p7kBlsSvrI45gNW4RdkPEXKz3ywkT1b1YFRaQTCA3bXddT3ebjuvchMtuZiIK
	fuJtpB/4D7OSkBin/vKHc2/sHQ725vhe1UDXgULo5Aw6C3uoLIf+
X-Google-Smtp-Source: AGHT+IFBIDUG/znNDtKoYOSijL9Nd0cL3H8TYg5KodhpfZ0H2Gf06LshKriN2j6nbvvfOIgLbaH+RA==
X-Received: by 2002:a05:600c:154a:b0:441:d437:e3b8 with SMTP id 5b1f17b1804b1-442f2161baamr39340845e9.23.1747254807365;
        Wed, 14 May 2025 13:33:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f8fc4557sm1559675e9.6.2025.05.14.13.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 13:33:26 -0700 (PDT)
Message-Id: <pull.1921.git.1747254806067.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 May 2025 20:33:25 +0000
Subject: [PATCH] replay: replace the_repository with repo parameter passed to
 cmd_replay()
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Replace the_repository everywhere with repo, feed repo from cmd_replay()
to all the other functions in the file that need it, and remove the
UNUSED annotation on repo.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    replay: replace the_repository with repo parameter passed to cmd_replay
    
    The point of this patch is not to remove USE_THE_REPOSITORY_VARIABLE; I
    can't yet because DEFAULT_ABBREV and get_commit_output_encoding() both
    require it and have no current alternatives. However, I still think it's
    worthwhile to stop using the_repository everywhere while ignoring the
    repo parameter explicitly passed in. That looks kinda ugly, and since
    I'm poking around in replay right now, I don't want to push
    the_repository in even more places when we have the appropriate value
    available -- especially since that might make my local work conflict
    should someone else come along and try to clean this up.
    
    --color-words is handy when viewing this patch; it may make it easier to
    see the changes.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1921%2Fnewren%2Freplay-repo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1921/newren/replay-repo-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1921

 builtin/replay.c | 65 ++++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 032c172b65e..225cef08807 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -20,21 +20,22 @@
 #include <oidset.h>
 #include <tree.h>
 
-static const char *short_commit_name(struct commit *commit)
+static const char *short_commit_name(struct repository *repo,
+				     struct commit *commit)
 {
-	return repo_find_unique_abbrev(the_repository, &commit->object.oid,
+	return repo_find_unique_abbrev(repo, &commit->object.oid,
 				       DEFAULT_ABBREV);
 }
 
-static struct commit *peel_committish(const char *name)
+static struct commit *peel_committish(struct repository *repo, const char *name)
 {
 	struct object *obj;
 	struct object_id oid;
 
-	if (repo_get_oid(the_repository, name, &oid))
+	if (repo_get_oid(repo, name, &oid))
 		return NULL;
-	obj = parse_object(the_repository, &oid);
-	return (struct commit *)repo_peel_to_type(the_repository, name, 0, obj,
+	obj = parse_object(repo, &oid);
+	return (struct commit *)repo_peel_to_type(repo, name, 0, obj,
 						  OBJ_COMMIT);
 }
 
@@ -50,7 +51,8 @@ static char *get_author(const char *message)
 	return NULL;
 }
 
-static struct commit *create_commit(struct tree *tree,
+static struct commit *create_commit(struct repository *repo,
+				    struct tree *tree,
 				    struct commit *based_on,
 				    struct commit *parent)
 {
@@ -62,7 +64,7 @@ static struct commit *create_commit(struct tree *tree,
 	struct commit_extra_header *extra = NULL;
 	struct strbuf msg = STRBUF_INIT;
 	const char *out_enc = get_commit_output_encoding();
-	const char *message = repo_logmsg_reencode(the_repository, based_on,
+	const char *message = repo_logmsg_reencode(repo, based_on,
 						   NULL, out_enc);
 	const char *orig_message = NULL;
 	const char *exclude_gpgsig[] = { "gpgsig", NULL };
@@ -79,7 +81,7 @@ static struct commit *create_commit(struct tree *tree,
 		goto out;
 	}
 
-	obj = parse_object(the_repository, &ret);
+	obj = parse_object(repo, &ret);
 
 out:
 	free_commit_extra_headers(extra);
@@ -97,7 +99,8 @@ struct ref_info {
 	int negative_refexprs;
 };
 
-static void get_ref_information(struct rev_cmdline_info *cmd_info,
+static void get_ref_information(struct repository *repo,
+				struct rev_cmdline_info *cmd_info,
 				struct ref_info *ref_info)
 {
 	int i;
@@ -132,14 +135,14 @@ static void get_ref_information(struct rev_cmdline_info *cmd_info,
 
 		if (*refexpr == '^')
 			refexpr++;
-		if (repo_dwim_ref(the_repository, refexpr, strlen(refexpr), &oid, &fullname, 0) != 1)
+		if (repo_dwim_ref(repo, refexpr, strlen(refexpr), &oid, &fullname, 0) != 1)
 			can_uniquely_dwim = 0;
 
 		if (e->flags & BOTTOM) {
 			if (can_uniquely_dwim)
 				strset_add(&ref_info->negative_refs, fullname);
 			if (!ref_info->negative_refexprs)
-				ref_info->onto = lookup_commit_reference_gently(the_repository,
+				ref_info->onto = lookup_commit_reference_gently(repo,
 										&e->item->oid, 1);
 			ref_info->negative_refexprs++;
 		} else {
@@ -152,7 +155,8 @@ static void get_ref_information(struct rev_cmdline_info *cmd_info,
 	}
 }
 
-static void determine_replay_mode(struct rev_cmdline_info *cmd_info,
+static void determine_replay_mode(struct repository *repo,
+				  struct rev_cmdline_info *cmd_info,
 				  const char *onto_name,
 				  char **advance_name,
 				  struct commit **onto,
@@ -160,14 +164,14 @@ static void determine_replay_mode(struct rev_cmdline_info *cmd_info,
 {
 	struct ref_info rinfo;
 
-	get_ref_information(cmd_info, &rinfo);
+	get_ref_information(repo, cmd_info, &rinfo);
 	if (!rinfo.positive_refexprs)
 		die(_("need some commits to replay"));
 
 	die_for_incompatible_opt2(!!onto_name, "--onto",
 				  !!*advance_name, "--advance");
 	if (onto_name) {
-		*onto = peel_committish(onto_name);
+		*onto = peel_committish(repo, onto_name);
 		if (rinfo.positive_refexprs <
 		    strset_get_size(&rinfo.positive_refs))
 			die(_("all positive revisions given must be references"));
@@ -175,8 +179,8 @@ static void determine_replay_mode(struct rev_cmdline_info *cmd_info,
 		struct object_id oid;
 		char *fullname = NULL;
 
-		*onto = peel_committish(*advance_name);
-		if (repo_dwim_ref(the_repository, *advance_name, strlen(*advance_name),
+		*onto = peel_committish(repo, *advance_name);
+		if (repo_dwim_ref(repo, *advance_name, strlen(*advance_name),
 			     &oid, &fullname, 0) == 1) {
 			free(*advance_name);
 			*advance_name = fullname;
@@ -245,7 +249,8 @@ static struct commit *mapped_commit(kh_oid_map_t *replayed_commits,
 	return kh_value(replayed_commits, pos);
 }
 
-static struct commit *pick_regular_commit(struct commit *pickme,
+static struct commit *pick_regular_commit(struct repository *repo,
+					  struct commit *pickme,
 					  kh_oid_map_t *replayed_commits,
 					  struct commit *onto,
 					  struct merge_options *merge_opt,
@@ -257,12 +262,12 @@ static struct commit *pick_regular_commit(struct commit *pickme,
 	base = pickme->parents->item;
 	replayed_base = mapped_commit(replayed_commits, base, onto);
 
-	result->tree = repo_get_commit_tree(the_repository, replayed_base);
-	pickme_tree = repo_get_commit_tree(the_repository, pickme);
-	base_tree = repo_get_commit_tree(the_repository, base);
+	result->tree = repo_get_commit_tree(repo, replayed_base);
+	pickme_tree = repo_get_commit_tree(repo, pickme);
+	base_tree = repo_get_commit_tree(repo, base);
 
-	merge_opt->branch1 = short_commit_name(replayed_base);
-	merge_opt->branch2 = short_commit_name(pickme);
+	merge_opt->branch1 = short_commit_name(repo, replayed_base);
+	merge_opt->branch2 = short_commit_name(repo, pickme);
 	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
 
 	merge_incore_nonrecursive(merge_opt,
@@ -275,13 +280,13 @@ static struct commit *pick_regular_commit(struct commit *pickme,
 	merge_opt->ancestor = NULL;
 	if (!result->clean)
 		return NULL;
-	return create_commit(result->tree, pickme, replayed_base);
+	return create_commit(repo, result->tree, pickme, replayed_base);
 }
 
 int cmd_replay(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repo UNUSED)
+	       struct repository *repo)
 {
 	const char *advance_name_opt = NULL;
 	char *advance_name = NULL;
@@ -329,7 +334,7 @@ int cmd_replay(int argc,
 		    "--advance", "--contained");
 	advance_name = xstrdup_or_null(advance_name_opt);
 
-	repo_init_revisions(the_repository, &revs, prefix);
+	repo_init_revisions(repo, &revs, prefix);
 
 	/*
 	 * Set desired values for rev walking options here. If they
@@ -380,7 +385,7 @@ int cmd_replay(int argc,
 		revs.simplify_history = 0;
 	}
 
-	determine_replay_mode(&revs.cmdline, onto_name, &advance_name,
+	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
 			      &onto, &update_refs);
 
 	if (!onto) /* FIXME: Should handle replaying down to root commit */
@@ -391,7 +396,7 @@ int cmd_replay(int argc,
 		goto cleanup;
 	}
 
-	init_basic_merge_options(&merge_opt, the_repository);
+	init_basic_merge_options(&merge_opt, repo);
 	memset(&result, 0, sizeof(result));
 	merge_opt.show_rename_progress = 0;
 	last_commit = onto;
@@ -406,8 +411,8 @@ int cmd_replay(int argc,
 		if (commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
 
-		last_commit = pick_regular_commit(commit, replayed_commits, onto,
-						  &merge_opt, &result);
+		last_commit = pick_regular_commit(repo, commit, replayed_commits,
+						  onto, &merge_opt, &result);
 		if (!last_commit)
 			break;
 

base-commit: 1a8a4971cc6c179c4dd711f4a7f5d7178f4b3ab7
-- 
gitgitgadget
