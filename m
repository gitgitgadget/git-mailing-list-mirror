Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C9E3ED11B
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684561; cv=none; b=rPNZiUU8MS1OFqrlZuQssDAutmmun8MuJaYbVvOV3WfDzaz0x+pLQMnFrNWaKScEnFIINB50JCu1Z7P4NFiTCFat/M957Qw9/BUXgPUsgWzmU+7WuvM2SLSOtAczIKSyFaEzEM00mFp5RjK1Pv6ckYV+fNsLRpC/QW7qcO6Jy+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684561; c=relaxed/simple;
	bh=8VJg8lAe2MIV28Hf+GDEmJEBn3u30jaC2AKmRAdIihw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bufPrSsGbLVRPtMHxLSJO0oz3LU1ioszYu2itSPzFNq89XxQ3xdTNOHPk+uaNpHmzqHUh1jMOyFvkw7aIMwioiaBUAdJ3L/dtD7GR8snWg/XXOZJrGN8s270062lv9Mgmy4pFEtW3ytsWlok5xktsUqUDs4IgSROIVQSEgplOCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G881e50s; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G881e50s"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304cf518c9dso2865916eec.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 11:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684559; x=1781289359; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xi7Fb8YTCFLpLi1vqm7/yCKLvkf+AHiU5BHYWq/To1o=;
        b=G881e50sCmh5nD4GteXHMfEaUr4chCDd2sCZo4vMqk4fj6cpgnLngS4kxlLe+PVn+c
         oSMIUlCesLa+hdD0n0ccSgROltxYGFQlnNH61IUcLAErUpbJofAvBO8eajQuWWn3yxuX
         lNWIzuK1cOTinPRi4MAyDoGJh7ybGNQAVI2YhATAx9JMV1jMcxPMi5FDsxPpb9x6HlRJ
         y/ilWo31wphYhc3Ve3tuCMs8Hkm98oXe3wEOWs19WCabTtYmAG6trh55DTOrKptp5rjw
         Jjcr3hDXrgbQDISb20lQLnBSfaf2jWvrEAfmCCBHn+qTD+5Okj377x12NfHqpFZvO8oO
         34bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684559; x=1781289359;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xi7Fb8YTCFLpLi1vqm7/yCKLvkf+AHiU5BHYWq/To1o=;
        b=GL2hwNw6DqwDhrdyUkOFnrhq0ZJAAG6emUp1mEurXn6LLkegWOhjirT42ZA4DuxsUr
         jEt6tnnVLJ2FPbWRlcrEctmsiSJWRo3Im6DouXEDBRa1+wUwOmbH8uGxs5rb2hjeyD++
         CIlnMXwxsao6jBaymRPBpUGE58tqGOW3yaIJCgHHKKf5LV4cAIrbVnetN1zI37fqnE4v
         rvydLaLWqbYWyHG3lRIlHFA41ysR7NG8v/y5AiBGj3zHDNP6SjqRFHb9nzOHW60xJX6J
         JAYau+fmEgAXHKyNrKAMZ9f2zYE37MtMNBKemng6NS7I4mOK861VAb7dIdK1fNzlDr6m
         pXUQ==
X-Gm-Message-State: AOJu0YzRU1bxRcJEyfHQ8zZD7Kk2Qxd+68JT2Wqe2srwy3k8PbCR2Qnv
	eOg15ZWQwK9d4drqxpPVy1LNws/4w3tfuq39hCPAhO+2GnR63OBIjH2g1OZ3d1xs
X-Gm-Gg: Acq92OFMkVNEI0kGwsPR8lUlv5m3kMf3+u8vaVo0zjVZyU3AZE8rd3kCtzk86y/l7PC
	iWR64FipG0R2feSlZG/npaHv1oJPV6QhoHOGk/sgt+lDQ4F3cmblNZUgMrfaFIX0PWKvWL+SNC8
	oML4cgb/5tjszGLgyekRIMfprveadFnGd+zfSBvH86sAi4+Jpl/4OxzRRYLDM8jqD8keWB6/xRT
	asHfDM8aol5Y+/Rj3cqS8/uepzNcTEUNWAGbKVFFeiwMN2AZVWVKxrTDwaSpfUuTQ1yFb77c+Zx
	r0diK3h69owEWQwA2N1t0O/i1UONeOKq94aUjnOr+PcWqTugN+kordh+n83mfyWiQzsnE7aZ3gQ
	CP+s6K2KrBx7qIaDMYHz7RGMXMtjZ7nW6yJzE4B0o9Icx0Xh+odSN8ChoBZOBCLRzReEUCHMO6j
	lrOPlG/pfJm1CEcDUwbiIE59v1IXCS6n4XQ5k=
X-Received: by 2002:a05:7300:6424:b0:2ea:e93a:ff9b with SMTP id 5a478bee46e88-3077af06a45mr2269517eec.13.1780684559117;
        Fri, 05 Jun 2026 11:35:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.53.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df3b234sm11107261eec.23.2026.06.05.11.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:35:58 -0700 (PDT)
Message-Id: <5ee7643d3a585154f1b2c92fd1bd8edc7dfa5774.1780684553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
References: <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
	<pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Jun 2026 18:35:50 +0000
Subject: [PATCH v13 3/6] branch: prepare delete_branches for a bulk caller
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Teach delete_branches() two new modes for the upcoming
--prune-merged: one that asks only whether a branch is merged into
its upstream, without falling back to HEAD when there is no
upstream, and one that rehearses the deletions without removing any
ref. Existing callers keep their current behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 19d6147e71..9568bb8445 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -168,10 +168,13 @@ static int branch_merged(int kind, const char *name,
 	 * upstream, if any, otherwise with HEAD", we should just
 	 * return the result of the repo_in_merge_bases() above without
 	 * any of the following code, but during the transition period,
-	 * a gentle reminder is in order.
+	 * a gentle reminder is in order.  Callers that opt out of the
+	 * HEAD fallback by passing head_rev=NULL are not interested in
+	 * the reminder either: they have already established that the
+	 * branch has an upstream, so HEAD is irrelevant to the decision.
 	 */
-	if (head_rev != reference_rev) {
-		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
+	if (head_rev && head_rev != reference_rev) {
+		int expect = repo_in_merge_bases(the_repository, rev, head_rev);
 		if (expect < 0)
 			exit(128);
 		if (expect == merged)
@@ -193,6 +196,8 @@ enum delete_branch_flags {
 	DELETE_BRANCH_FORCE = (1 << 0),
 	DELETE_BRANCH_QUIET = (1 << 1),
 	DELETE_BRANCH_WARN_ONLY = (1 << 2),
+	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
+	DELETE_BRANCH_DRY_RUN = (1 << 4),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -242,6 +247,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	int remote_branch = 0;
 	int force = flags & DELETE_BRANCH_FORCE;
 	int quiet = flags & DELETE_BRANCH_QUIET;
+	int dry_run = flags & DELETE_BRANCH_DRY_RUN;
+	int no_head_fallback = flags & DELETE_BRANCH_NO_HEAD_FALLBACK;
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
@@ -267,7 +274,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	}
 	branch_name_pos = strcspn(fmt, "%");
 
-	if (!force)
+	if (!force && !no_head_fallback)
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
@@ -338,13 +345,20 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		free(target);
 	}
 
-	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
+	if (!dry_run &&
+	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
 		ret = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
 		char *describe_ref = item->util;
 		char *name = item->string;
-		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
+		if (dry_run) {
+			if (!quiet)
+				printf(remote_branch
+					? _("Would delete remote-tracking branch %s (was %s).\n")
+					: _("Would delete branch %s (was %s).\n"),
+					name + branch_name_pos, describe_ref);
+		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
 			char *refname = name + branch_name_pos;
 			if (!quiet)
 				printf(remote_branch
-- 
gitgitgadget

