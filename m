Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAADE3AE712
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270515; cv=none; b=WeaWRVfIsWzu8yT6lu6ZNbUEKy6PUF0QmwCMh+bRN5PUV/OQARV7o86mRvLZWe1kzsQvVKohwKHqMvCfl/O96AOxdMEESeQ73RjBoOQKhZ2o1eutg3dXjrzQ4Ur5rU7wtUEgab1uS8vWIYHWMBD7DKlVpFP9S22M+G23oSVhojQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270515; c=relaxed/simple;
	bh=wH910I73tn46h3UILSvtCWGZaVJBp94o8CZN+EgyJgU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GhFJBqazDQWdpaDulHvUmmzDu3crCF9QvnkuWhn2adPHllhpoxaotq8veJmdITtevdYUajaB7cyEi7Qcleq2ROnkfs1fFk4R9gnhvObSQtYyr/2cuj5/lnDYanZMgCCTJLDkbqq2JD0pGUwmgADbu2APMjszW7iGMTjwMyTDgQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwI5EXz6; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwI5EXz6"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6d290b10a35so96361eaf.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 00:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791270512; x=1791875312; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EUQyxjjgJTl2s46AUeMUSXgTUdXjwyrj2U2OomSHeug=;
        b=iwI5EXz6Gka64uU66qp/sznJzQtQfwy+jPIrvOqrzU4w3RRzIIWg0nABM5NlkvzZG1
         pChXKFIXEI0OPhx55LJGCCGcS2jrjc9clNvwAiUSgNWyvHnuz/1C3iDXGJmXK4DcVwmu
         1Teb04sh0O7OWfe/94yzqq0efTNVerln9VblBVVer4moHj9QxGphGN0Zi77nxBLhGxtl
         oegQojhnsmrHuxoi2XtZxYEtbydHcguobyHQMu+ryeIZo48mpuMDHbGNi3R0GFfPugin
         kahCEscDuzVdEfUYNEtqcWM3Z4Zpi1FrzsEmZVHNk+beYf40NzY0dwIlyLNnUEh+pkkN
         ohQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791270512; x=1791875312;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EUQyxjjgJTl2s46AUeMUSXgTUdXjwyrj2U2OomSHeug=;
        b=jztKYAHcmmBpTdpLauAF+qPhDDrt4yA31Z8s30Oxp1CxyKO+gZU/oR4TqwKIuE13Ji
         twIc2jE8NwWgy/927Fs5060oA1Uwj9C4xmwPWHQxBiDdOJqVdsirI279FC9nQRo79Exc
         tovdrXipWjCKwUtcuoYvkXXpijYozYNyHtPzRqHsQo1SpzjOP9DlhRQlFJygBPjYrrYA
         P6PlLnmCvekcpoc3+DOf2rb/K6qKtvfgb6tXs6wcuJRO6S+mEE4jJZNgc+k+I8xUjQ3C
         PxIuElqaq6XTtCOZO6st1Y2t55QlJrla4xB6iwjPX4+XG4vBrwFL8apO5kr+IN7xtnnT
         sUvg==
X-Gm-Message-State: AFuF++nTMeufyAn63w2GCmgf+SKYdgUr6HaCAmW4UZGKmy4nCwXYQn6G
	k5+ZwLV2nTMJC0/UAZxj8ZHuyNRiB24j8/8VQQn6YVAhGGvSIgmDUrWa6IbL2JEa
X-Gm-Gg: AYBFou05LSqzOlR3t/wlWZSiRGw82OXKLDnuMCPa6u/pwDHdif/HyaLj5XePPrhAZs5
	8F0h3k06UthWECk7fyrmqdSVLmpoWOmsSPhNYeYkonjoyao4Rqa6XgYotk/g7b0FtGrRgY7LqJW
	SGHya5GZXXw8R7oZs81DJ7NRCN66R0LPbMldcZDZYN7/oeJTm7aoik7LM8qAH57S0iw3bzu9nOv
	/bNcfBN8WsdZkBXLZxyF40ACR0xN1RaeJ1el+5pimGmEiyhxHx3sbeYiOv+1Z7dxH3h43t+OnZU
	b2bZuMvmbq+ppLOJo5nTzh2YUokEKgKTggJLl2fcJjknpMRzwIKSY7xXhXlbbpq/YbaUi7Z9GT4
	9TiQ1uNvCwyZiDHGZV9iVUULQXvsege/U6qur/f8hLOhivrfCOZgA0w+6UJBaDT8YKQMIl+9OQf
	lkIfC+m9kkGi185BOR70qfdeVXceHCPkU6MIGwgKvKqdE+6zC31tdjLKAWoje0d1lLp0Y4dfc21
	5LH+zBmhzU93Q==
X-Received: by 2002:a4a:e90a:0:b0:6d7:9e0f:3336 with SMTP id 006d021491bc7-6e5510657c2mr294657eaf.1.1791270512398;
        Tue, 06 Oct 2026 00:08:32 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.187.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49e16f00b5asm12197895fac.14.2026.10.06.00.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 00:08:30 -0700 (PDT)
Message-Id: <dc0efefa0ef02a04f211cf7e24a8b6855f36e12f.1791270504.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2437.git.git.1791270504.gitgitgadget@gmail.com>
References: <pull.2437.git.git.1791270504.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 07:08:20 +0000
Subject: [PATCH 2/6] status: say when the push branch was rebased cleanly
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

After rebasing pushed work onto a newer upstream without changing it,
"git status" reports the commits outside the upstream on both sides,
as if the branch and its push branch held different work.

When those commits carry the same changes on both sides, say that the
branch was rebased cleanly:

  Your branch and 'origin/topic' have diverged,
  and have 51 and 1 different commits each (rebased cleanly on 'upstream/main').

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c                 | 49 ++++++++++++++++++++++++++++++++--------
 t/t6040-tracking-info.sh | 30 ++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 10 deletions(-)

diff --git a/remote.c b/remote.c
index cbe79275f7..89d142cc7e 100644
--- a/remote.c
+++ b/remote.c
@@ -2248,7 +2248,7 @@ int resolve_remote_symref(struct ref *ref, struct ref *list)
 
 static int stat_branch_pair(const char *branch_name, const char *base,
 			     const char *exclude,
-			     int *num_ours, int *num_theirs,
+			     int *num_ours, int *num_theirs, int *num_same,
 			     enum ahead_behind_flags abf)
 {
 	struct object_id oid;
@@ -2278,6 +2278,8 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 	}
 
 	*num_theirs = *num_ours = 0;
+	if (num_same)
+		*num_same = 0;
 
 	/* are we the same? */
 	if (theirs == ours)
@@ -2290,6 +2292,8 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 	/* Run "rev-list --left-right ours...theirs" internally... */
 	strvec_push(&argv, ""); /* ignored */
 	strvec_push(&argv, "--left-right");
+	if (num_same)
+		strvec_push(&argv, "--cherry-mark");
 	strvec_pushf(&argv, "%s...%s",
 		     oid_to_hex(&ours->object.oid),
 		     oid_to_hex(&theirs->object.oid));
@@ -2311,6 +2315,8 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 			(*num_ours)++;
 		else
 			(*num_theirs)++;
+		if (num_same && (c->object.flags & PATCHSAME))
+			(*num_same)++;
 	}
 
 	/* clear object flags smudged by the above traversal */
@@ -2358,22 +2364,31 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 		return -1;
 
 	return stat_branch_pair(branch->refname, base, NULL,
-				num_ours, num_theirs, abf);
+				num_ours, num_theirs, NULL, abf);
 }
 
 /*
  * Count the commits that differ between branch_name and base but are not
  * in upstream. Return false when they cannot be counted or upstream
- * accounts for none of the ours and theirs commits.
+ * accounts for none of the ours and theirs commits. Otherwise set
+ * *same_changes when the remaining commits carry the same changes on
+ * both sides.
  */
 static bool stat_outside_upstream(const char *branch_name, const char *base,
 				  const char *upstream, int ours, int theirs,
-				  int *ours_unmerged, int *theirs_unmerged)
+				  int *ours_unmerged, int *theirs_unmerged,
+				  bool *same_changes)
 {
+	int same;
+
 	if (stat_branch_pair(branch_name, base, upstream, ours_unmerged,
-			     theirs_unmerged, AHEAD_BEHIND_FULL) < 0)
+			     theirs_unmerged, &same, AHEAD_BEHIND_FULL) < 0)
+		return false;
+	if (*ours_unmerged == ours && *theirs_unmerged == theirs)
 		return false;
-	return *ours_unmerged != ours || *theirs_unmerged != theirs;
+	*same_changes = *ours_unmerged &&
+		same == *ours_unmerged + *theirs_unmerged;
+	return true;
 }
 
 static char *resolve_compare_branch(struct branch *branch, const char *name)
@@ -2407,6 +2422,7 @@ static void format_branch_comparison(struct strbuf *sb,
 				     const char *push_branch_name,
 				     const char *upstream_name,
 				     int ours_unmerged, int theirs_unmerged,
+				     bool same_changes,
 				     enum ahead_behind_flags abf,
 				     unsigned flags)
 {
@@ -2452,7 +2468,17 @@ static void format_branch_comparison(struct strbuf *sb,
 					_("  (use \"git pull\" to update your local branch)\n"));
 		}
 	} else {
-		if (upstream_name)
+		if (same_changes)
+			strbuf_addf(sb,
+				Q_("Your branch and '%s' have diverged,\n"
+				       "and have %d and %d different commit each "
+				       "(rebased cleanly on '%s').\n",
+				   "Your branch and '%s' have diverged,\n"
+				       "and have %d and %d different commits each "
+				       "(rebased cleanly on '%s').\n",
+				   ours + theirs),
+				branch_name, ours, theirs, upstream_name);
+		else if (upstream_name)
 			strbuf_addf(sb,
 				Q_("Your branch and '%s' have diverged,\n"
 				       "and have %d and %d different commit each "
@@ -2519,6 +2545,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		char *upstream_name = NULL;
 		int ours, theirs, cmp;
 		int ours_unmerged = 0, theirs_unmerged = 0;
+		bool same_changes = false;
 		int is_upstream, is_push;
 		unsigned flags = 0;
 		const char *push_remote_name = NULL;
@@ -2544,12 +2571,13 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			is_push = 1;
 
 		cmp = stat_branch_pair(branch->refname, full_ref, NULL,
-				       &ours, &theirs, abf);
+				       &ours, &theirs, NULL, abf);
 
 		if (cmp > 0 && ours && theirs && upstream_ref && !is_upstream &&
 		    stat_outside_upstream(branch->refname, full_ref,
 					  upstream_ref, ours, theirs,
-					  &ours_unmerged, &theirs_unmerged))
+					  &ours_unmerged, &theirs_unmerged,
+					  &same_changes))
 			upstream_name = refs_shorten_unambiguous_ref(
 				get_main_ref_store(the_repository),
 				upstream_ref, 0);
@@ -2596,7 +2624,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		format_branch_comparison(sb, !cmp, ours, theirs, short_ref,
 					 push_remote_name, push_branch_name,
 					 upstream_name, ours_unmerged,
-					 theirs_unmerged, abf, flags);
+					 theirs_unmerged, same_changes,
+					 abf, flags);
 		reported = 1;
 
 		free(full_ref);
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index f8df16a5de..2ebc3573da 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -778,4 +778,34 @@ test_expect_success 'status.compareBranches counts push divergence outside upstr
 	test_cmp expect actual
 '
 
+test_expect_success 'status.compareBranches after a clean rebase of the push branch' '
+	test_config -C test push.default current &&
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	(
+		cd test &&
+		git checkout -b feature19 origin/main &&
+		advance work19 &&
+		git push
+	) &&
+	git checkout main &&
+	advance main19a &&
+	advance main19b &&
+	git checkout - &&
+	(
+		cd test &&
+		git pull --rebase &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature19
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+
+	Your branch and ${SQ}origin/feature19${SQ} have diverged,
+	and have 3 and 1 different commits each (rebased cleanly on ${SQ}origin/main${SQ}).
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

