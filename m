Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145502D1931
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219043; cv=none; b=uCkRBbulksd1XPZqDx1dOdV2x91RHx7nJ7ViMf5rtydHJilL7jMpCezRkYz17KWi7R8scFt5PnaiCyBDxGz+IkyXSmFkx23WyHJ82iuSOoESw6/gKVQL3jXeyvSLMDWJTdH97i4GEIh+GT1hcrLAfCYIfiTEKaqIVrL/xozX21U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219043; c=relaxed/simple;
	bh=1Q9QDPySnoDEXNMDKssCU0Ysl6VP+5tyl/677SdFbyI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fszjPY8VUgBice8JTHHApoOSwdEmpksq9NFnlRPqBeiSIJl3GuCxtVHU4NbFJWNdEnonYlDs6f2s8lBFOHxF9XZsD0tAVn8sEhprFqPpxx0j6Ir4JaEjagxUAypzVfzdb/bxKa1eRvcrmtWWoq5KhKlu8sydjl3LaFqkjCeikjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONw+8JI4; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONw+8JI4"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cd8dbf4f2eso299617785a.2
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 01:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773219035; x=1773823835; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5p0YTkg0hPYjsmf/Yfv09YyWROxh7f/xsWDrRO9p2xA=;
        b=ONw+8JI4vn6DzvaHQaPjnH0YBMQgZiWbT9X9uokQMnRs2rL5IwVuSeJqiIP+hUst3y
         zu9YXDbeoRAS+cOu7ZZj6a14rVrpG/x3otDr+eaa+a2O4K6Fsb/z2wpGwMdPOPkIKAmW
         YE0+D18gwjHBtmzbDNKObZYvawU4R9SGA3Z9KgQbJ3SjM3c8hkZvl1hjy5Py7Ll4eRAc
         01/4rufo5c8Fx7Ug35wHEEvFI9Gdezo2qk0/Oh1n+gIX+r/grbkQ3T3zkNS/EBWN01ID
         oIpSNnvcpLtvIf8axW7dqXz8tC8N6L5h7VKAiOq0vilufi5YimBxwq9PIiZHYAnNzi1P
         qk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773219035; x=1773823835;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5p0YTkg0hPYjsmf/Yfv09YyWROxh7f/xsWDrRO9p2xA=;
        b=Jd2GdhU/YYjL7hY9kRb33Oci9JOadzljisl0xbnXwLHEpEJg0uAMRt+yLriY8+6Liu
         ityRKPyGc4N175EEXo9R3vepg574fkfn4kCFV82kjlr/2hHrTsHe5XizFITKSt/epl/j
         3hE4lChLF4EH215BjEsc4LzakO1IoXTTkn2JaWqw2Nx0QpchhUUgJIfhJ2CZRaWRk6/D
         6B67IbGF6gFb4CHiWQAoWAr5kwGgM4RqHJDLi6Pp6BslbP8A6nH+IGX+8mnpjOiMVe8L
         8uYOImliZzVsMvOnM43LYn/9DTvdoCY7Cy8pi8T2CwyCesJ8DhW7/rjkc9bdZORlk2AZ
         6RhA==
X-Gm-Message-State: AOJu0YztcAteNMc/Gj5mLpF+qxmkZ1q4OwA9V+TaTIJFG2eTvJ3QebxQ
	3xE5UX0SGja6j25tCgKsaAjOMMsK/Ji8RsH73ruaNnr/Qm876g9e3bDwRaRj+JzB
X-Gm-Gg: ATEYQzy+TQBJxmL/nfQOUnBL9bIUYddJDunMUk7B+/Ve/xMA5V3suTARiPnnvZrPdfy
	rHrB/SBHSv0tkJ5If8S5mxP3ET7hvFoProVfBTSu4BaO7d9Dy9YVb/7h79WgkfU2Ljh9Hk1cfPI
	BjQXvAMFhNAKy1b5BOZrewbJc4QSu870Mw17kzaNsB1yTKy/maz8bc5TGXqvemPr1ZKGgCjDWTd
	pyLYFi4NFhfVIq+Fl3wYNCx+M9x0lyuonAOfwUXrNBTYmBz+vwkitQgtmbC33UnYX/Sl4NiqNjs
	mhvuk82kJML1TCvUxuruYeEqpIcM+RYyh4i7sgWuaF4W14ORpyPNWk9fB0oIN7h71dxEWK1Ltvs
	8myxZ5xUTHg/7rRrgr6C7p8+v2sBmyNcMOSs+EDiVhPjMd9FRKmnFF7Mx23bBL+ZQr98xxzwTCv
	gbmOKRY0WiheBXVTVRlPXguhE=
X-Received: by 2002:a05:620a:1a17:b0:8b2:f35c:16df with SMTP id af79cd13be357-8cda1afc42fmr222665585a.79.1773219035222;
        Wed, 11 Mar 2026 01:50:35 -0700 (PDT)
Received: from [127.0.0.1] ([40.81.42.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fe19d3sm93875385a.19.2026.03.11.01.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:50:34 -0700 (PDT)
Message-Id: <4237b9667d40e2bf3ad71d953a06eec2aa70aa1b.1773219028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
References: <pull.2233.v3.git.git.1773149337.gitgitgadget@gmail.com>
	<pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
From: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Mar 2026 08:50:26 +0000
Subject: [PATCH v4 3/5] unpack-trees: suggesting 'git checkout -m <branch>'
 with its repercussions
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
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>

From: Arsh Srivastava <arshsrivastava00@gmail.com>

This comment is an extention to the already existing stash comment.

After the valuable insights given to me by git maintaniers.
I removed the new function I introduced.
Added updated comment over the already existing function
"setup_unpack_trees_porcelain" with "git checkout -m <branch>"
and its repercussions
I have also mentioned the repercussions of using "-m".

Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
---
 Documentation/config/advice.adoc |  5 -----
 advice.c                         | 20 --------------------
 advice.h                         |  2 --
 unpack-trees.c                   | 13 +++++++++++--
 4 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 8752e05636..257db58918 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -126,11 +126,6 @@ all advice messages.
 		Shown when a sparse index is expanded to a full index, which is likely
 		due to an unexpected set of files existing outside of the
 		sparse-checkout.
-	stashBeforeCheckout::
-		Shown when the user attempts to switch branches but has
-		local modifications that would be overwritten by the
-		operation, to suggest using linkgit:git-stash[1] to
-		save changes before switching.
 	statusAheadBehind::
 		Shown when linkgit:git-status[1] computes the ahead/behind
 		counts for a local ref compared to its remote tracking ref,
diff --git a/advice.c b/advice.c
index ba290d3760..0018501b7b 100644
--- a/advice.c
+++ b/advice.c
@@ -81,7 +81,6 @@ static struct {
 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
 	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
 	[ADVICE_SPARSE_INDEX_EXPANDED]			= { "sparseIndexExpanded" },
-	[ADVICE_STASH_BEFORE_CHECKOUT] = { "stashBeforeCheckout" },
 	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning" },
 	[ADVICE_STATUS_HINTS]				= { "statusHints" },
 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption" },
@@ -313,22 +312,3 @@ void advise_on_moving_dirty_path(struct string_list *pathspec_list)
 			    "* Use \"git add --sparse <paths>\" to update the index\n"
 			    "* Use \"git sparse-checkout reapply\" to apply the sparsity rules"));
 }
-
-void advise_on_checkout_dirty_files(struct string_list *file_list)
-{
-    struct string_list_item *item;
-
-    if (!file_list->nr)
-	return;
-
-    fprintf(stderr, _("The following files have local modifications that would\n"
-		      "be overwritten by switching branches:\n"));
-    for_each_string_list_item(item, file_list)
-	fprintf(stderr, "\t%s\n", item->string);
-
-    advise_if_enabled(ADVICE_STASH_BEFORE_CHECKOUT,
-		      _("To carry your local changes over to the new branch, use:\n"
-			"\n"
-			"\tgit checkout -m <branch>\n"
-			));
-}
diff --git a/advice.h b/advice.h
index c035b5d8e3..8def280688 100644
--- a/advice.h
+++ b/advice.h
@@ -48,7 +48,6 @@ enum advice_type {
 	ADVICE_SET_UPSTREAM_FAILURE,
 	ADVICE_SKIPPED_CHERRY_PICKS,
 	ADVICE_SPARSE_INDEX_EXPANDED,
-	ADVICE_STASH_BEFORE_CHECKOUT,
 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
 	ADVICE_STATUS_HINTS,
 	ADVICE_STATUS_U_OPTION,
@@ -84,6 +83,5 @@ void NORETURN die_ff_impossible(void);
 void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
 void detach_advice(const char *new_name);
 void advise_on_moving_dirty_path(struct string_list *pathspec_list);
-void advise_on_checkout_dirty_files(struct string_list *file_list);
 
 #endif /* ADVICE_H */
diff --git a/unpack-trees.c b/unpack-trees.c
index 998a1e6dc7..9449ee8203 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -128,8 +128,17 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
-			  "Please commit your changes or stash them before you switch branches.")
-		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s");
+			  "Please commit your changes or stash them before you switch branches.\n"
+			  "Try using 'git checkout -m <branch>' for a quick fix. \n"
+			  "Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.\n"
+			  "Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone."
+			  )
+		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s"
+				"Please commit your changes or stash them before you switch branches.\n"
+			  "Try using 'git checkout -m <branch>' for a quick fix.\n"
+			  "Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.\n"
+			  "Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone."
+			  );
 	else if (!strcmp(cmd, "merge"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("Your local changes to the following files would be overwritten by merge:\n%%s"
-- 
gitgitgadget

