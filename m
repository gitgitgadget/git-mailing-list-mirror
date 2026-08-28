Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C183E022C
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 07:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903093; cv=none; b=JNCVFSB99kA5FvvWk/oApw/VLknvf3c6ujG0bJXAJzTWDHsrM1XDe6moNmfJDePE/eNJB+DDcgNwtxDc3bRkejNUCKuqe7YLsq4flFsv4xM/PnfmyILwuHkCp6LVPy4Ygv1x8ZbVCV+jn9gUQC0bPQLi5L4q05sW8innzippnv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903093; c=relaxed/simple;
	bh=C++dvrkfpqdLUbZblzYW8hnwQQVw933A/TVnx8PP+tY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tWbSSxVBeUPTq+5tKF67vChiifPywSzzQYERA6Yb7J7zPoEvoGdVnNwPJvdl2Dhx5juaXfnCU4mK60ujfWwA/HFl3mi7HIj0FSFK3u+JRz8bkVaaplQlWjQtLEnZzK9uPTcOvz0wpB097U2eBGyMm87/iPSa4CxwsZiKyx+N2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGW4lCC4; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGW4lCC4"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4a456e44e01so751229b6e.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2026 00:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787903090; x=1788507890; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5az9diHVuM9bqD9oSRfw4W7i6mXaWPqfXCIxBJt+Twc=;
        b=RGW4lCC4TW6T1lJRvSmWcB/0vnMFwtwOYeBnK/WFg0nA1aFU4GOd0No7anGo0FxEhS
         ZgAwpj1VAdZlhCMpwrYlCkB3lnhALmUjMQe8GZc9Uojv+WSJOo+yGWW2pO2ceIPGyhSd
         JE16ntPRjNYY7L7fi90BSFID7XU2xmCdO3Ek1tp/yrYsLcf4MusBakZ3j5QcaTJ6e7gZ
         x1wWfyGayoOe4VXP6KIfTiHtoxnqOU5LIpKg2HgH5v2Qoh7GSK9wwKTLbGoe8P86dQfY
         y8su33ULAL4qx3cT6E5fgM/hf07pcfHVbco+7XdO6SH4qDmWP6ERMSwQFUv2gOpsIk19
         sC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787903090; x=1788507890;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5az9diHVuM9bqD9oSRfw4W7i6mXaWPqfXCIxBJt+Twc=;
        b=Ls3K3T35zds4/A1o6kZRTZJyQShbNLYveOztzmRO4pYkvZ7A/7vfpQONprxBlHsmTM
         AY+AoxZ5TpVB83/eOyYRjDvACPtYjgFovwaTUB/ns9531GlpL9xyweM4azpQ0rOjm+0x
         92UdnMrjBrNyLuAMjbesPoU8XRk6uB1Dp4QIxA5cQ4i6J/EjPxC/lzu254RKnJte7NK4
         ve8W9AslgIss+oKyYOqjqTuFi4Ry0AO0uOXuXrvEh5hKWj48Mx9n2X9vskV1AXSAnk0Z
         5zehH5lDrmfKlmHnUUKKIIjenSEI5A5MhY/Z7VBqNa596UWYsFM21jO3loAdrOKuz48E
         FW/Q==
X-Gm-Message-State: AFuF++nvVIGvhZQPgUOx3VsF7X8tqItErRdBdXh0ZZGhHzCU1YW9OblD
	AJw9NACxUBs5F/UHBgs22abAg8kK6hVfRhGsXJHsJanXfSy9YqEtsu4Ee7mI/Gw3
X-Gm-Gg: AR+sD132jH6Yz5zSW+x5f5VXLYeNc/14CNEt4nwpGwlyxJpfDz8G1pZszfzPHzai6QH
	ba7m7A+aXKpMQ9Cscwwdd1SFc1xqDTwrSVOAJE24CH71RFR0E2rFQNPmTSKX0PSanSFaB/4xO+L
	Ytv7OBtCmoxqtqlSLPiMnQo226NuCL+Z97t7Ci8ybMP0mJ09/sEvemV5M9pXJ20r7T0ruI9G8t7
	jZYyw7ND3/R5cbZaFyxWVLj/IkEJs1BLvjCDwk4ic23CEPZDsFoGfg37muO8A/A0sD/SeD24WQo
	of8Xf9hiv+i1GmIBUz3lvEVaya3cHbyFygipfrsl4C5tKKcLZC9HTrPvYfNaUI2zXGAYKujV7W2
	2wyS4xAmyl48/VJZvJSkRxgAORi7i7cOY6RdRb29hjPSXW6cHNTfdkop2t0v5L3Wcyz3EZrIUzP
	e5BBaeJ83DDWlXJTXnI5TJJ0XFNQfnEQKfVIfly40mNSlDFOxJtI06HTDPOV3Do2I=
X-Received: by 2002:a05:6820:3095:b0:6b1:65ad:3181 with SMTP id 006d021491bc7-6b1c66d53ffmr4485126eaf.16.1787903090215;
        Fri, 28 Aug 2026 00:44:50 -0700 (PDT)
Received: from [127.0.0.1] ([172.202.78.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1ce122df5sm952533eaf.5.2026.08.28.00.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 00:44:49 -0700 (PDT)
Message-Id: <7e198a20fa47f0d5b2c50ffc7046bdfc792b62af.1787903085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2389.v3.git.git.1787903085.gitgitgadget@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v3.git.git.1787903085.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Aug 2026 07:44:41 +0000
Subject: [PATCH v3 1/5] commit: clarify FROM_REBASE_PICK and is_from_rebase()
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

While at it, change `whence == FROM_REBASE_EMPTY` to use
`is_from_rebase_empty(whence)`.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/commit.c | 14 +++++++-------
 sequencer.c      |  2 +-
 wt-status.h      |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 28f6174503..569e31fb60 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -520,7 +520,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 			die(_("cannot do a partial commit during a merge."));
 		else if (is_from_cherry_pick(whence))
 			die(_("cannot do a partial commit during a cherry-pick."));
-		else if (is_from_rebase(whence))
+		else if (is_from_rebase_empty(whence))
 			die(_("cannot do a partial commit during a rebase."));
 	}
 
@@ -893,7 +893,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 */
 	else if (whence == FROM_MERGE)
 		hook_arg1 = "merge";
-	else if (is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK) {
+	else if (is_from_cherry_pick(whence) || is_from_rebase_empty(whence)) {
 		hook_arg1 = "commit";
 		hook_arg2 = "CHERRY_PICK_HEAD";
 	}
@@ -1086,7 +1086,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (amend)
 			fputs(_(empty_amend_advice), stderr);
 		else if (is_from_cherry_pick(whence) ||
-			 whence == FROM_REBASE_PICK) {
+			 is_from_rebase_empty(whence)) {
 			fputs(_(empty_cherry_pick_advice), stderr);
 			if (whence == FROM_CHERRY_PICK_SINGLE)
 				fputs(_(empty_cherry_pick_advice_single), stderr);
@@ -1333,7 +1333,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 			die(_("You are in the middle of a merge -- cannot amend."));
 		else if (is_from_cherry_pick(whence))
 			die(_("You are in the middle of a cherry-pick -- cannot amend."));
-		else if (whence == FROM_REBASE_PICK)
+		else if (is_from_rebase_empty(whence))
 			die(_("You are in the middle of a rebase -- cannot amend."));
 	}
 	if (fixup_message && squash_message)
@@ -1353,7 +1353,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (amend && !use_message && !fixup_message)
 		use_message = "HEAD";
 	if (!use_message && !is_from_cherry_pick(whence) &&
-	    !is_from_rebase(whence) && renew_authorship)
+	    !is_from_rebase_empty(whence) && renew_authorship)
 		die(_("--reset-author can be used only with -C, -c or --amend."));
 	if (use_message) {
 		use_message_buffer = read_commit_message(use_message);
@@ -1362,7 +1362,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 			author_message_buffer = use_message_buffer;
 		}
 	}
-	if ((is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK) &&
+	if ((is_from_cherry_pick(whence) || is_from_rebase_empty(whence)) &&
 	    !renew_authorship) {
 		author_message = "CHERRY_PICK_HEAD";
 		author_message_buffer = read_commit_message(author_message);
@@ -1887,7 +1887,7 @@ int cmd_commit(int argc,
 		if (!reflog_msg)
 			reflog_msg = is_from_cherry_pick(whence)
 					? "commit (cherry-pick)"
-					: is_from_rebase(whence)
+					: is_from_rebase_empty(whence)
 					? "commit (rebase)"
 					: "commit";
 		commit_list_insert(current_head, &parents);
diff --git a/sequencer.c b/sequencer.c
index 65afd100d9..0ea730a8dc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6956,7 +6956,7 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
 		    !repo_get_oid(r, "REBASE_HEAD", &rebase_head) &&
 		    !repo_get_oid(r, "CHERRY_PICK_HEAD", &cherry_pick_head) &&
 		    oideq(&rebase_head, &cherry_pick_head))
-			*whence = FROM_REBASE_PICK;
+			*whence = FROM_REBASE_EMPTY;
 		else
 			*whence = FROM_CHERRY_PICK_SINGLE;
 
diff --git a/wt-status.h b/wt-status.h
index e9fe32e98c..9588097dbe 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -41,7 +41,7 @@ enum commit_whence {
 	FROM_MERGE,      /* commit came from merge */
 	FROM_CHERRY_PICK_SINGLE, /* commit came from cherry-pick */
 	FROM_CHERRY_PICK_MULTI, /* commit came from a sequence of cherry-picks */
-	FROM_REBASE_PICK /* commit came from a pick/reword/edit */
+	FROM_REBASE_EMPTY /* rebase applied a pick that became empty */
 };
 
 static inline int is_from_cherry_pick(enum commit_whence whence)
@@ -50,9 +50,9 @@ static inline int is_from_cherry_pick(enum commit_whence whence)
 		whence == FROM_CHERRY_PICK_MULTI;
 }
 
-static inline int is_from_rebase(enum commit_whence whence)
+static inline int is_from_rebase_empty(enum commit_whence whence)
 {
-	return whence == FROM_REBASE_PICK;
+	return whence == FROM_REBASE_EMPTY;
 }
 
 struct wt_status_change_data {
-- 
gitgitgadget

