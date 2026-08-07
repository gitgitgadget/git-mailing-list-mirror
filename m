Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABD83515DB
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088383; cv=none; b=hCUY2slsvWaZakZkQXPODoh8nIdvFzxFKX7Sjmo2hhIbBLUI/FWBwjR8NeD9Mag1WW6d3v5YuBw441jxSZ0dGnQ0Pwifld16mTGCnjoG0PImAT4aM7L2IIxCu6gETcUhR9rZAs49dYjHSoAr1v6Q3O+4m4iAurL6UIP4TvoXUs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088383; c=relaxed/simple;
	bh=JLqLd4QAn9i4cbVaSGvUxckIOW20Au3aQL0U8AwW60k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NsEyJ6u+Uq/OGsMdiX+gPtGuhgcxzIN2ci5twPbX0pl6Ko5wVNeDRtmm53j6m7H9rMPB8fXqiOmtUwsMT1Rod0zOLcJO+WIgc7wNCNQlgfDI556Jx3XfRqUXJDElMueiO67yB4F0gOaOkI0mGV7JjwULhQXGPWXaEnGBx58+ZG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0wgFEaa; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0wgFEaa"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so1402269a91.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 00:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786088382; x=1786693182; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ByEroyPtTy3WqN+TltI3JrifcVuRbRk8Hukl+6HHzqk=;
        b=p0wgFEaaocjIkIauseWMu8qMzItgHcmBFJSCB6Y0SirRwC7IRiI9Usuis+Y86cRIpf
         iGeMSB+fr/Inx8JC+NLUOUqgxL0iXjpesTONJKbFfBMd58F3z+5pW3v9+aTvviyOkpjv
         clys6rQT3ELojRMndooP36OriucGs4akzj3eB7VNgM0VBXYW6YAzKpAsfvdeiJu5oZbx
         sTk6t6Gl5pqwiN8IdJLqv7lmTenxed0QaTWtAWWON4wkCCjWQ5R60d/bBBk0MAP/llEW
         SMch7VNWe3yRjAjwku2mEVgu4AlFQ3dWALgEzEOrdYHGjhXbT92hXKWPk12NfeAiN8DF
         JEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786088382; x=1786693182;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ByEroyPtTy3WqN+TltI3JrifcVuRbRk8Hukl+6HHzqk=;
        b=EAuf5/uXg5lKJj7nGMg2RJIsBIEPQK/ty2NXCDlfz6mMNr2rM3mxAhSIks5vPG4PqU
         S1REPzETIyPdLpBHaIu1GKpjZTAsHyHeri8xJVVBL6FlOiJJ6xORIrNGYI3oeSa+eiV7
         E98VXNuL+c80MESjdFqNcoiho4/9/+TI5AbvYwcOeKotWLOIAWq8TcoSe1xLadL8QZ38
         /LEquYBw5SfVLpswxhDq3G4JIbyihJIgoMX4c+1NpgJbjPJ272DtRJl0tMsPropuZvad
         GVBxLJIywcpY44Kk50nLHuwvnUJ3xRNVjOUOBTquVCHAVhUrMGZEBIDMSPDO1JxkgSZM
         yKLg==
X-Gm-Message-State: AOJu0YxCEO2XZBrq2E92tBZd1tQGlRyM6paY3SXCJaeaBMD5Sdw9HkO2
	Rxmlg+DJk9LSlNC7k+Aanzv3lqbrpQaTgxFAM624NBarWMIJ1tNZsxNF4/dqYbjz
X-Gm-Gg: AR+sD12u5DLWLHXeyCXYtABXDTUJhOAPwXXxtumSrflMFStDJg4KcNs1icFtPdjJpqS
	Dxld/s7NrDUm2ZnvotmGXOHLqX2ScVyxaZTqlhZOUwTr3YfrhU1UgHc3mIryyVUflrF8iEc3Q3U
	njjm7YKQdRGRQ1CyRecpHJF6G7whs9mHjZr5uSNZ4Sd1RFroI296fOyl3EtwlC3kSYAvG5ya8S5
	u+8MG34gYSUUBOrUktpeoJ4khLRZoSyGr+i5nDFidncbexrCPElYw8wYVX/pIKYuviJtrG1vGjS
	r0u4VsPwYpLJqEvtYxdsRq8AUVpjxmWTSz6tbND0y2As7EFODnMEb8kk6g2q2T0fvOZkEKLCsaX
	fpHdVRttRoHXtWP7Nr9XAGf+Z4g+wLRRUDQiM+kobcwwcrSr+17OujcZnQbojD0jpDl13KhGX8l
	KmDz9+QNIGHb0f8fYNZZPfUzsFaJFzvaCJJ0xfNJK51a9qSnCYDwHYxfqp6OJH8aKK
X-Received: by 2002:a17:90b:4f8e:b0:38e:b3fd:d584 with SMTP id 98e67ed59e1d1-390897e0a43mr4429922a91.15.1786088381675;
        Fri, 07 Aug 2026 00:39:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.82.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b370b145sm671739a91.2.2026.08.07.00.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 00:39:40 -0700 (PDT)
Message-Id: <dbbf66ba02e3e4741d48c7f276a10496510f0f7a.1786088371.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 07 Aug 2026 07:39:28 +0000
Subject: [PATCH v13 5/8] history: validate squash revision ranges
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Walk the selected commits in topological order from oldest to newest and
mark each one as it is seen. Every parent after the oldest commit must
already be selected or also be a parent of the oldest commit. This
accepts merges contained by the range while rejecting a merge arm that
entered it from elsewhere.

Track the remaining graph tips during the same walk and require exactly
one. Also reject empty and single-commit ranges and any selection that
reaches a root commit. These checks identify the oldest commit whose
parents will be preserved and the single tip whose tree will be used by
the rewrite.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/history.c         | 119 ++++++++++++++++++++++++++++++++++----
 object.h                  |   1 +
 t/meson.build             |   1 +
 t/t3455-history-squash.sh |  65 +++++++++++++++++++++
 4 files changed, 174 insertions(+), 12 deletions(-)
 create mode 100755 t/t3455-history-squash.sh

diff --git a/builtin/history.c b/builtin/history.c
index 4f5a7a46ce..6541a397e8 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1006,6 +1006,9 @@ out:
 	return ret;
 }
 
+#define SQUASH_SEEN (1u << 11)
+#define SQUASH_TIP (1u << 12)
+
 static int setup_squash_revisions(struct repository *repo,
 				  int argc, const char **argv,
 				  struct rev_info *revs)
@@ -1052,6 +1055,104 @@ static int setup_squash_revisions(struct repository *repo,
 	return error(_("not a '<base>..<tip>' revision range"));
 }
 
+/*
+ * Resolve a revision range into its oldest commit and single tip. Every
+ * parent after the oldest commit must either be selected or also be a parent
+ * of the oldest commit.
+ */
+static int resolve_squash_range(struct repository *repo,
+				int argc, const char **argv,
+				struct commit **oldest_out,
+				struct commit **tip_out)
+{
+	struct rev_info revs;
+	struct commit *commit, *oldest = NULL, *tip = NULL;
+	int ret, tip_count = 0;
+	bool walk_started = false;
+
+	ret = setup_squash_revisions(repo, argc, argv, &revs);
+	if (ret < 0)
+		goto out;
+
+	if (prepare_revision_walk(&revs) < 0) {
+		ret = error(_("error preparing revisions"));
+		goto out;
+	}
+	walk_started = true;
+	while ((commit = get_revision(&revs))) {
+		struct commit_list *p;
+
+		if (!commit->parents) {
+			ret = error(_("cannot squash down to root commit"));
+			goto out;
+		}
+		for (p = commit->parents; oldest && p; p = p->next) {
+			struct commit_list *q;
+			struct object *o;
+			bool seen;
+
+			if (repo_parse_commit(repo, p->item)) {
+				ret = error(_("cannot parse commit"));
+				goto out;
+			}
+			o = &p->item->object;
+			seen = o->flags & SQUASH_SEEN;
+			/*
+			 * Allow parents that match the parents of the
+			 * squashed commit.
+			 */
+			for (q = oldest->parents; !seen && q; q = q->next)
+				if (p->item == q->item)
+					seen = true;
+			if (!seen) {
+				ret = error(_("parent %s of commit %s is "
+					      "outside the revision range"),
+					    repo_find_unique_abbrev(repo, &o->oid,
+								    DEFAULT_ABBREV),
+					    repo_find_unique_abbrev(repo,
+								    &commit->object.oid,
+								    DEFAULT_ABBREV));
+				goto out;
+			}
+			if (o->flags & SQUASH_TIP) {
+				tip_count--;
+				o->flags &= ~SQUASH_TIP;
+			}
+		}
+		if (!oldest)
+			oldest = commit;
+		tip = commit;
+		tip->object.flags |= SQUASH_SEEN | SQUASH_TIP;
+		tip_count++;
+	}
+
+	if (!tip_count) {
+		ret = error(_("the revision range is empty"));
+		goto out;
+	} else if (tip_count != 1) {
+		ret = error(_("the revision range contains more than one tip "
+			      "commit"));
+		goto out;
+	} else if (oldest == tip) {
+		ret = error(_("the revision range holds a single commit; "
+			      "nothing to squash"));
+		goto out;
+	} else if (!oldest->parents) {
+		BUG("an in-range commit must have a parent");
+	}
+
+	*oldest_out = oldest;
+	*tip_out = tip;
+	ret = 0;
+
+out:
+	clear_object_flags(repo, SQUASH_SEEN | SQUASH_TIP);
+	if (walk_started)
+		reset_revision_walk();
+	release_revisions(&revs);
+	return ret;
+}
+
 static int cmd_history_squash(int argc,
 			      const char **argv,
 			      const char *prefix,
@@ -1074,26 +1175,20 @@ static int cmd_history_squash(int argc,
 			 N_("edit the commit message")),
 		OPT_END(),
 	};
-	struct rev_info revs = { 0 };
+	struct commit *oldest, *tip;
 	int ret;
 
 	argc = parse_options(argc, argv, prefix, options, usage,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
-	if (argc < 2) {
-		ret = error(_("command expects a revision range"));
-		goto out;
-	}
+	if (argc < 2)
+		return error(_("command expects a revision range"));
 	repo_config(repo, git_default_config, NULL);
 
-	ret = setup_squash_revisions(repo, argc, argv, &revs);
+	ret = resolve_squash_range(repo, argc, argv, &oldest, &tip);
 	if (ret < 0)
-		goto out;
-
-	ret = error(_("squashing commits is not implemented yet"));
+		return ret;
 
-out:
-	release_revisions(&revs);
-	return ret;
+	return error(_("squashing commits is not implemented yet"));
 }
 
 static int update_worktree(struct repository *repo,
diff --git a/object.h b/object.h
index 8fb03ff90a..dcf30156ca 100644
--- a/object.h
+++ b/object.h
@@ -74,6 +74,7 @@ void object_array_init(struct object_array *array);
  * bisect.c:                                        16
  * bundle.c:                                        16
  * http-push.c:                          11-----14
+ * builtin/history.c:                    1112
  * commit-graph.c:                                15
  * commit-reach.c:                                  16-------20
  * builtin/last-modified.c:                         1617
diff --git a/t/meson.build b/t/meson.build
index a25f37d2f5..78b8ea54ad 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -406,6 +406,7 @@ integration_tests = [
   't3452-history-split.sh',
   't3453-history-fixup.sh',
   't3454-history-drop.sh',
+  't3455-history-squash.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
new file mode 100755
index 0000000000..df92aa4f6c
--- /dev/null
+++ b/t/t3455-history-squash.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+
+test_description='tests for git-history squash subcommand'
+
+. ./test-lib.sh
+
+test_expect_success 'setup linear history' '
+	test_commit base file a start &&
+	test_commit one file b &&
+	test_commit two file c &&
+	test_commit three file d
+'
+
+test_expect_success 'errors on missing range argument' '
+	test_must_fail git history squash 2>err &&
+	test_grep "expects a revision range" err
+'
+
+test_expect_success 'errors on an empty range' '
+	test_must_fail git history squash HEAD..HEAD 2>err &&
+	test_grep "the revision range is empty" err
+'
+
+test_expect_success 'errors on a single revision that is not a range' '
+	test_must_fail git history squash HEAD 2>err &&
+	test_grep "not a .*range" err &&
+	test_must_fail git history squash HEAD~1 2>err &&
+	test_grep "not a .*range" err
+'
+
+test_expect_success 'errors on a range holding a single commit' '
+	test_must_fail git history squash "HEAD^!" 2>err &&
+	test_grep "single commit; nothing to squash" err
+'
+
+test_expect_success 'rejects a root commit' '
+	oid=$(git commit-tree -m root three^{tree}) &&
+	test_must_fail git history squash \
+		--ancestry-path=start "$oid..three" 2>err &&
+	test_grep "cannot squash down to root commit" err
+'
+
+test_expect_success 'rejects multiple tips' '
+	oid=$(git commit-tree -m tip -p start^0 three^{tree}) &&
+	test_must_fail git history squash ^start "$oid" three~1 2>err &&
+	test_grep "revision range contains more than one tip" err
+'
+
+test_expect_success 'rejects a merge parent outside the range' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b outside-parent &&
+	test_commit --no-tag outside-parent outside x &&
+	git checkout "$main" &&
+	test_commit --no-tag outside-main file b &&
+	base=$(git rev-parse HEAD) &&
+	test_commit --no-tag outside-mid file c &&
+	git merge --no-ff -m "merge outside-parent" outside-parent &&
+	git branch -D outside-parent &&
+
+	test_must_fail git history squash "$base.." 2>err &&
+	test_grep "parent .* of commit .* is outside the revision range" err
+'
+
+test_done
-- 
gitgitgadget

