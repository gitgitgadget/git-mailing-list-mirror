Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2F638BF6D
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 04:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773288020; cv=none; b=lnY54jqZnHe5nhVwadMfsGUeHHwZbeG4Dm/TuX9htzFqrgPTvwcztwZ29NvEPhCqb5w3dFutvmB6FOLWAlazdkegUP/zWdIKOzmpLrcv4YGV/K9mZfdHzoSuGy+oasmw3bt9dV/vAQQ3f3A5CEFt17lLRrkgx/AzgqjzPjrDEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773288020; c=relaxed/simple;
	bh=9XghMKEyygfd7qyzUwVgn1EIhb/MAVIPg0FLTbI53Rs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mFMqOLxzdPaoxs0SBsF8ci2J68PsdrHT3U0NOLNsT0OnGBFfhuMd7nrWNiqM/iYgBhaj2atJ51EZW8tAsnS8I2Rg2NUjaCtX5Lbedz0XuNFSYUO8AAzNEkklsQ5FrctaaVrutG9ScErYuLrUVE2AoAxeUMwp2ZpJVdb/inxzRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fO85vK3c; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO85vK3c"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-899f8c33c11so5351616d6.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 21:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773288016; x=1773892816; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScWvQoglu85/BUpPpdOTZyInhOhC+GJiMbK2Ssy9Egw=;
        b=fO85vK3c9ZwgEie536yXUq03SDCKwNT3h0lU3Hn9MQPW7TwvrLQeTa8jQJdK8rgplR
         f5vK0LIsHiQBmvkEP9fvzZbTYvOJBN+/Tf+NzsZsli4vhgO9lKJfRUHvanJGiXfsHiTO
         w9+elyc1h+gdfxdEgfkmlGDorRw8bIxwuku2yEqpEfafn2AUjR8pqOFNvLFtNxLDxVM3
         JasdWJGE4Z2CtUZlp0Q4v+OJk7BStY1HXOUv9S4p0U7kNAa5W2MWhhhkwc0SyzrIWBgX
         YlZsLIjVicd5HOiuflEI6jo0BgdkRepsgLZReAUKBvqmYJtL91r0n/S+rxuxBfihe4V8
         l9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773288016; x=1773892816;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ScWvQoglu85/BUpPpdOTZyInhOhC+GJiMbK2Ssy9Egw=;
        b=Jp05aEdQn/2DGhBP5ReBL/v81Qy+nXRRgVnfdc3bVadLJaFX5lIX6g5q1EBJRut8bO
         ZWgJ8JHJnEHWjDyct1u0mFP/GZ15FXl4UfImfWHpEpTshfoMNbiMuo6q0FqOQjXndzM/
         IM7tYQfwOaH+XsiE+o7Qd1O4+GgSEyoT7Ft9JrH1D8jhuC9GiYj+EQL+icoY74ZF2haT
         WHhCZ62x9CHdjpOEyVJGHo9wV9FRH7vNEWhToGLOO2DGDNz6L2VOoc4bkudgQYRFV++w
         s5MzTinKW6soLR2Na9MUZ2QtjhQbHfr5uFzZx8xaaBG3OAvlxsAN7Zok78rei0SwZWJB
         HU+Q==
X-Gm-Message-State: AOJu0YwJZ2ZH9Rb7hkVabhLYN4/LGLzLNfoq8kRjjY91rpG0GDAC87Vm
	N4EOZ+a6ZIq76cjtTni7c9onJwm6NJ2hd4K38Yo5JNYxlUF9opOwLfHAScgaLg==
X-Gm-Gg: ATEYQzxJhl244c0x5h1Y1KLlusSR1SSqPOs+Px2GcU4yeD2j1s0iXDJouSrN4NQOAqY
	bNl7pTUXANYHSAVD26rrCw2tlDBI4z30+4aVYlWZW6IQ+HLGxeGm5Zw3XMsHqHcv4T0EgB9q+vM
	Crk5f3smmeB0X1sDpYkhWbXi3pX7Z+Ot/vg2Cyq+O1JVlOZQCzPP3Br7twG5PpqiAyQ2jLQP9Pl
	wLK76oIS5dr/TjymGABaeatWTerGO21LgxASkTtcMH40OAU9e+iU9h7Hs/3c5aOc3t9HvT+IXhe
	pJxKpdPkN2yAuezjVBy1gRWyofzv0IyE4dOQre9Kgs4I3WypxtKGhZwxlmWKfxvQbpDK1Wjm4/J
	iiOl8QSbrXxCU2Dd2kXfNoSqY/IVdLZhM9euRBCjaPZty3xBElpj/qNseK3xIJJo57GVsSBlhqA
	kJZcbQcvYhWknr/WM6VXzNhYvt0Z22RA4GZgOs
X-Received: by 2002:a05:6214:21af:b0:897:306d:98b9 with SMTP id 6a1803df08f44-89a669c1155mr74128876d6.11.1773288015698;
        Wed, 11 Mar 2026 21:00:15 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.94.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65d1557esm25997336d6.45.2026.03.11.21.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 21:00:15 -0700 (PDT)
Message-Id: <pull.2233.v6.git.git.1773288013936.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v5.git.git.1773251369.gitgitgadget@gmail.com>
References: <pull.2233.v5.git.git.1773251369.gitgitgadget@gmail.com>
From: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 12 Mar 2026 04:00:13 +0000
Subject: [PATCH v6] unpack-trees: suggesting 'git checkout -m' with its
 repercussions
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
Added updated comment over the already existing function
"setup_unpack_trees_porcelain" with "git checkout -m"
and its repercussions
I have also mentioned the repercussions of using "-m".

Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com
---
    Advice on checkout dirty files
    
    This is my submission for microproject [GSOC]
    
    This patch extends the current message to help users better understand
    risks and alternatives to stashing their changes.
    
    The alternative consists of
    
    > git checkout -m and its repercussions.
    
    This extended message is tied to the existing advice.commitBeforeMerge
    configuration and can be silenced with:
    
    > git config set advice.commitBeforeMerge false
    
    Changes:
    
    > unpack-trees.c: expanded the already existing message.
    > t/t6439-merge-co-error-msgs.sh: update expected output for merge and
    > checkout tests. t/t7406-submodule-update.sh: update expected output
    > for submodule checkout tests.
    
    Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2233%2FArsh123344423%2Fadvice_on_checkout_dirty_files-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2233/Arsh123344423/advice_on_checkout_dirty_files-v6
Pull-Request: https://github.com/git/git/pull/2233

Range-diff vs v5:

 1:  eb5639dbc3 < -:  ---------- advice: add stashBeforeCheckout advice for dirty branch switches
 2:  e88c851701 < -:  ---------- advice: add stashBeforeCheckout advice for dirty branch switches [GSOC]
 3:  1cc22f437e ! 1:  e0ba5fad82 unpack-trees: suggesting 'git checkout -m <branch>' with its repercussions
     @@ Metadata
      Author: Arsh Srivastava <arshsrivastava00@gmail.com>
      
       ## Commit message ##
     -    unpack-trees: suggesting 'git checkout -m <branch>' with its repercussions
     +    unpack-trees: suggesting 'git checkout -m' with its repercussions
      
          This comment is an extention to the already existing stash comment.
     -
     -    After the valuable insights given to me by git maintaniers.
     -    I removed the new function I introduced.
          Added updated comment over the already existing function
     -    "setup_unpack_trees_porcelain" with "git checkout -m <branch>"
     +    "setup_unpack_trees_porcelain" with "git checkout -m"
          and its repercussions
          I have also mentioned the repercussions of using "-m".
      
     -    Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
     -
     - ## Documentation/config/advice.adoc ##
     -@@ Documentation/config/advice.adoc: all advice messages.
     - 		Shown when a sparse index is expanded to a full index, which is likely
     - 		due to an unexpected set of files existing outside of the
     - 		sparse-checkout.
     --	stashBeforeCheckout::
     --		Shown when the user attempts to switch branches but has
     --		local modifications that would be overwritten by the
     --		operation, to suggest using linkgit:git-stash[1] to
     --		save changes before switching.
     - 	statusAheadBehind::
     - 		Shown when linkgit:git-status[1] computes the ahead/behind
     - 		counts for a local ref compared to its remote tracking ref,
     -
     - ## advice.c ##
     -@@ advice.c: static struct {
     - 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
     - 	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
     - 	[ADVICE_SPARSE_INDEX_EXPANDED]			= { "sparseIndexExpanded" },
     --	[ADVICE_STASH_BEFORE_CHECKOUT] = { "stashBeforeCheckout" },
     - 	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning" },
     - 	[ADVICE_STATUS_HINTS]				= { "statusHints" },
     - 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption" },
     -@@ advice.c: void advise_on_moving_dirty_path(struct string_list *pathspec_list)
     - 			    "* Use \"git add --sparse <paths>\" to update the index\n"
     - 			    "* Use \"git sparse-checkout reapply\" to apply the sparsity rules"));
     - }
     --
     --void advise_on_checkout_dirty_files(struct string_list *file_list)
     --{
     --    struct string_list_item *item;
     --
     --    if (!file_list->nr)
     --	return;
     --
     --    fprintf(stderr, _("The following files have local modifications that would\n"
     --		      "be overwritten by switching branches:\n"));
     --    for_each_string_list_item(item, file_list)
     --	fprintf(stderr, "\t%s\n", item->string);
     --
     --    advise_if_enabled(ADVICE_STASH_BEFORE_CHECKOUT,
     --		      _("To carry your local changes over to the new branch, use:\n"
     --			"\n"
     --			"\tgit checkout -m <branch>\n"
     --			));
     --}
     -
     - ## advice.h ##
     -@@ advice.h: enum advice_type {
     - 	ADVICE_SET_UPSTREAM_FAILURE,
     - 	ADVICE_SKIPPED_CHERRY_PICKS,
     - 	ADVICE_SPARSE_INDEX_EXPANDED,
     --	ADVICE_STASH_BEFORE_CHECKOUT,
     - 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
     - 	ADVICE_STATUS_HINTS,
     - 	ADVICE_STATUS_U_OPTION,
     -@@ advice.h: void NORETURN die_ff_impossible(void);
     - void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
     - void detach_advice(const char *new_name);
     - void advise_on_moving_dirty_path(struct string_list *pathspec_list);
     --void advise_on_checkout_dirty_files(struct string_list *file_list);
     - 
     - #endif /* ADVICE_H */
     +    Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com
      
       ## t/t6439-merge-co-error-msgs.sh ##
      @@ t/t6439-merge-co-error-msgs.sh: error: Your local changes to the following files would be overwritten by checkou


 t/t6439-merge-co-error-msgs.sh | 6 ++++++
 t/t7406-submodule-update.sh    | 3 +++
 unpack-trees.c                 | 9 +++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
index 643c9368e0..cf996e0e51 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -77,6 +77,9 @@ error: Your local changes to the following files would be overwritten by checkou
 	rep/one
 	rep/two
 Please commit your changes or stash them before you switch branches.
+Try using 'git checkout -m <branch>' for a quick fix.
+Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.
+Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
 Aborting
 EOF
 
@@ -99,6 +102,9 @@ error: Your local changes to the following files would be overwritten by checkou
 	rep/one
 	rep/two
 Please commit your changes or stash them before you switch branches.
+Try using 'git checkout -m <branch>' for a quick fix.
+Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.
+Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
 Aborting
 EOF
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 3adab12091..2e4cc9b3fe 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -212,6 +212,9 @@ test_expect_success 'submodule update should fail due to local changes' '
 	> error: Your local changes to the following files would be overwritten by checkout:
 	> 	file
 	> Please commit your changes or stash them before you switch branches.
+	> Try using '\''git checkout -m <branch>'\'' for a quick fix.
+	> Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.
+	> Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
 	> Aborting
 	> fatal: Unable to checkout OID in submodule path '\''submodule'\''
 	EOF
diff --git a/unpack-trees.c b/unpack-trees.c
index 998a1e6dc7..9835a82455 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -128,8 +128,13 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
-			  "Please commit your changes or stash them before you switch branches.")
-		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s");
+			  "Please commit your changes or stash them before you switch branches.\n"
+			  "Try using 'git checkout -m <branch>' for a quick fix.\n"
+			  "Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.\n"
+			  "Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone."
+			  )
+		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s"
+				"Please commit your changes or stash them before you switch branches.");
 	else if (!strcmp(cmd, "merge"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("Your local changes to the following files would be overwritten by merge:\n%%s"

base-commit: d181b9354cf85b44455ce3ca9e6af0b9559e0ae2
-- 
gitgitgadget
