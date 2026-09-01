Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7037E32937A
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788301486; cv=none; b=K9pYPFdk+zsISzyZ+Q6os16tl3jkxn7PZtBx/cYf+ZfvwsGWm6er+9gUFhJ7TMpxbF72Bs4myR1OQruyWEnwz37wrxmodFNKsWWV6E0LtNo/w6nkgB/aSERxZv//m2Y18Xu/x/aBovpMTkWOTjIIm2p+la4Tvi2+siDp/FyxhKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788301486; c=relaxed/simple;
	bh=lBzQbRl7QedENhn9gB1EplsAfWVcpXTozEUeBTrnX2g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VP2rVIMZNN+kQrLAtTOOw/CKhvSTv8teKli+ty8KB2E3+xu/pTWkSgq1m5GDXcjSKzw8rQVVFh9wYlM6TKc6TGyxeLWEqUCTOhlLfjSNVksgjPufJaxz8g5F/z4jIOC3oAUYyQLLp5BxX/sJ/nVFsL2AMuhg5GoDQa/zvOynOK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCZTD4mr; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCZTD4mr"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-398b3d66515so466330a91.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788301485; x=1788906285; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ufP0gjmllmASKXyqED3/Vtua2tykMN11BiLHvAE5mW4=;
        b=RCZTD4mrR626P8AJrpYEZn5jEenKnE63EHcCNw5GtupVpTYfK1XMP0fVwCtyqz043S
         uvSB/FxG2hRKZY5h51C27rn3au5L/rAYq5akRARMZGpiElkR9f+PlPPTCthBivV4ozV4
         fjtSJaU4qI/kqjXs1B8Ln+EHfiL/eLXlPIKcj8mKvhj1CvEoRx48PWr8Y77wR+vVwy+J
         Wd7EH8QMrnJuJW8rs/LxwuiNCuGoTxiRXurhppEObTzRCL35Nb6vF1U6ZT6u1ad1uAII
         0EjyMmtxmdJZfIMRBgH198fq2x4CQuGN0q+4gI2yoRg1q+3YayLCm5caMBWY63RDTmW3
         XBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788301485; x=1788906285;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ufP0gjmllmASKXyqED3/Vtua2tykMN11BiLHvAE5mW4=;
        b=WoVph19KdFBgk1OVid+ppdkUsCPTSK2BBMUORMKkrC08fhDG5xZkcnxzCfXugND6VL
         UQM3dXDO7dVUragG0wIZkWdKW7T+5MRzg9ByRdQ/Dp6uyEmFnbaZ4ccbR2F8JSlZ0PT9
         75FU731Rc0n6/okH75Rk2k/Ix1dh09ZnssX0h0Eq+JjojVRYkGkFGp8gYxrZRJYxdtsh
         wX1w9gYNxcB/mgzcRafGFWbVYVo2gZLHlXHU8CX4TeAL5h0jV7PWRKJYyoxzpIpIKs/Z
         3sD2HWbZehb+WBp4WzSpYkBPoS2UIvRIO0bJjCS4WwrsIN13BVEgiEq/zSfrB2lIRgEn
         9GZw==
X-Gm-Message-State: AFuF++kw/xYInut0RRw0t7l6jwdwqJFQBs1qfBGeWxugSUMGWn2Nb0DG
	ch28yBzc0Y89u2/sdpzUef1/xh1viei/xOwueUKbNlRs+c63GEI9wC7l9pRzSvnz
X-Gm-Gg: AYBFou0qTd5EpTT7qV9zNZBWBYktJIlVr3Q7GWTOTKWxwQh2HHxaUsmKd6/gMV0NK0V
	0xuAcpvkaw9acUX/HzYHZAn9EctSxtYfR/xywbxTfDGxd7YPwR7Kb23gfj3VdsXTLr3YqaOqudY
	cSxPxA+sQnurx+V8K56ueFh4BHpsTH7A5ZRNRD9YLXBYOh+4W8Ctijl99RWY/TY3rkCPIpkDg3a
	qtPsLT+pWLywTVz3tX7HmTLkhaZcIK3n2hibifpd6vw451jmG6yqhhP06tgU2BG0wnrlqm5kSdB
	zwsSptq3LYWZmfWTCUdNrUJtoeNCqpjg/VjhlTrZ3Db3DDX0jYYXqWTjqY80SrELiXUp/ZysSgH
	bI/zo6jAQ/MfEg3fvEtczQCmi8cv1+BVfCAFHmM67BSTiG/8hZiM+sWiHtM7WrbLK+zA77Z2VI9
	8v+UtA/J8bcvBiVROquci3MWiqOZgsdvnTIEtbIazgplvuSgaq6HfvvgcWF2sU
X-Received: by 2002:a17:90b:520f:b0:398:9c00:29e9 with SMTP id 98e67ed59e1d1-39aee1b72e5mr198297a91.17.1788301484612;
        Tue, 01 Sep 2026 15:24:44 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b7bd00sm905973eec.14.2026.09.01.15.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:24:44 -0700 (PDT)
Message-Id: <bd361679b9144682d664e8cfcf9fc2cbd8511b4d.1788301481.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2389.v4.git.git.1788301481.gitgitgadget@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v4.git.git.1788301481.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Sep 2026 22:24:37 +0000
Subject: [PATCH v4 1/5] commit: clarify FROM_REBASE_PICK and is_from_rebase()
 names
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
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Commit 430b75f7209c (commit: give correct advice for empty commit during
a rebase, 2019-12-06) introduced a FROM_REBASE_PICK enum value and an
is_from_rebase() function.  Those names failed to convey that they were
specifically about hitting a commit that becomes empty when rebasing.
Clarify their names now.

While at it, change `whence == FROM_REBASE_NOW_EMPTY` to use
`is_from_rebase_now_empty(whence)`.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/commit.c | 14 +++++++-------
 sequencer.c      |  2 +-
 wt-status.h      |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 28f6174503..17cc27e53e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -520,7 +520,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 			die(_("cannot do a partial commit during a merge."));
 		else if (is_from_cherry_pick(whence))
 			die(_("cannot do a partial commit during a cherry-pick."));
-		else if (is_from_rebase(whence))
+		else if (is_from_rebase_now_empty(whence))
 			die(_("cannot do a partial commit during a rebase."));
 	}
 
@@ -893,7 +893,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 */
 	else if (whence == FROM_MERGE)
 		hook_arg1 = "merge";
-	else if (is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK) {
+	else if (is_from_cherry_pick(whence) || is_from_rebase_now_empty(whence)) {
 		hook_arg1 = "commit";
 		hook_arg2 = "CHERRY_PICK_HEAD";
 	}
@@ -1086,7 +1086,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (amend)
 			fputs(_(empty_amend_advice), stderr);
 		else if (is_from_cherry_pick(whence) ||
-			 whence == FROM_REBASE_PICK) {
+			 is_from_rebase_now_empty(whence)) {
 			fputs(_(empty_cherry_pick_advice), stderr);
 			if (whence == FROM_CHERRY_PICK_SINGLE)
 				fputs(_(empty_cherry_pick_advice_single), stderr);
@@ -1333,7 +1333,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 			die(_("You are in the middle of a merge -- cannot amend."));
 		else if (is_from_cherry_pick(whence))
 			die(_("You are in the middle of a cherry-pick -- cannot amend."));
-		else if (whence == FROM_REBASE_PICK)
+		else if (is_from_rebase_now_empty(whence))
 			die(_("You are in the middle of a rebase -- cannot amend."));
 	}
 	if (fixup_message && squash_message)
@@ -1353,7 +1353,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (amend && !use_message && !fixup_message)
 		use_message = "HEAD";
 	if (!use_message && !is_from_cherry_pick(whence) &&
-	    !is_from_rebase(whence) && renew_authorship)
+	    !is_from_rebase_now_empty(whence) && renew_authorship)
 		die(_("--reset-author can be used only with -C, -c or --amend."));
 	if (use_message) {
 		use_message_buffer = read_commit_message(use_message);
@@ -1362,7 +1362,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 			author_message_buffer = use_message_buffer;
 		}
 	}
-	if ((is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK) &&
+	if ((is_from_cherry_pick(whence) || is_from_rebase_now_empty(whence)) &&
 	    !renew_authorship) {
 		author_message = "CHERRY_PICK_HEAD";
 		author_message_buffer = read_commit_message(author_message);
@@ -1887,7 +1887,7 @@ int cmd_commit(int argc,
 		if (!reflog_msg)
 			reflog_msg = is_from_cherry_pick(whence)
 					? "commit (cherry-pick)"
-					: is_from_rebase(whence)
+					: is_from_rebase_now_empty(whence)
 					? "commit (rebase)"
 					: "commit";
 		commit_list_insert(current_head, &parents);
diff --git a/sequencer.c b/sequencer.c
index 65afd100d9..d336c309ca 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6956,7 +6956,7 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
 		    !repo_get_oid(r, "REBASE_HEAD", &rebase_head) &&
 		    !repo_get_oid(r, "CHERRY_PICK_HEAD", &cherry_pick_head) &&
 		    oideq(&rebase_head, &cherry_pick_head))
-			*whence = FROM_REBASE_PICK;
+			*whence = FROM_REBASE_NOW_EMPTY;
 		else
 			*whence = FROM_CHERRY_PICK_SINGLE;
 
diff --git a/wt-status.h b/wt-status.h
index e9fe32e98c..2143f50b49 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -41,7 +41,7 @@ enum commit_whence {
 	FROM_MERGE,      /* commit came from merge */
 	FROM_CHERRY_PICK_SINGLE, /* commit came from cherry-pick */
 	FROM_CHERRY_PICK_MULTI, /* commit came from a sequence of cherry-picks */
-	FROM_REBASE_PICK /* commit came from a pick/reword/edit */
+	FROM_REBASE_NOW_EMPTY /* rebase applied a pick that became empty */
 };
 
 static inline int is_from_cherry_pick(enum commit_whence whence)
@@ -50,9 +50,9 @@ static inline int is_from_cherry_pick(enum commit_whence whence)
 		whence == FROM_CHERRY_PICK_MULTI;
 }
 
-static inline int is_from_rebase(enum commit_whence whence)
+static inline int is_from_rebase_now_empty(enum commit_whence whence)
 {
-	return whence == FROM_REBASE_PICK;
+	return whence == FROM_REBASE_NOW_EMPTY;
 }
 
 struct wt_status_change_data {
-- 
gitgitgadget

