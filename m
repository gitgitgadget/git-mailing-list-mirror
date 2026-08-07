Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630243DBD4E
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088378; cv=none; b=TDcMYhyFjpdYKyMmamwkcJKa4y9YYEWf4Y6rmFUORutCihk+rK0LVw+s1R4zj/8RrpiF6WOF2qLBd/T3bfqYwKw6GFxQERmWwntUwDa68cpwVztOV5G/zockN5nWoGxeoHdIXSiAKxQIJkb9FwhWoFUGczleG4UForNaV3w/Hus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088378; c=relaxed/simple;
	bh=Qlw5ArwqpUvv+GwBilOYc/NbsKYNhuo0w1wlRcFsLzc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=J6HK3eXKAx6bquD1XuItt+zJ/3j9iH2pBGEa81eLzt4ygP3e/xYEYSRUTkvNgcBuU31q3LPHjMyav+3Qye60UxKFkdvQDdKMPw4/lK64vWoarALVtgzAOfSs1VO/v7hLzC7Y09hQkQMA7DcT/BqWqe5WMGgmWt1F/Jyhy1uYh/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMtA8Z8j; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMtA8Z8j"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so1402245a91.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 00:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786088377; x=1786693177; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1MANe9lQPFH+VlE97G8EHUib2wUcQHWWgKSk5STbLHg=;
        b=pMtA8Z8jJWYQqFxIRVvBzTrPNcHCI/I+qinQ1qpPmuZrhQonMWu5IHiDZ4BqcM2CxJ
         61rP+y1CcQ/xsQbnqiPqE6MaPkhs7Ya54yMS950kEB7cmK5f1Q/ZDcrrI1EzmNsg063V
         7w9yv/7lheTCZx4TVcx/aoPCYTaVVB9GlV41FrjkNidnvrdBpyDWoUrwiu9PxhcNT5Hu
         LrN5cq2DSOdih3np926N6ZWzcTCZuOqgfzz4bIwTfonyMxob7QIFScCx8i5VC78qm31H
         kuPob7OKdEmxVuYLPNJ+eLcd5f5TOgI9Lzt86rAgeQ+EA5ONk9Nhd5vlbl0+QGhMsrk9
         NO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786088377; x=1786693177;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MANe9lQPFH+VlE97G8EHUib2wUcQHWWgKSk5STbLHg=;
        b=OKSHx/sN//0ERi99iboC8oA+nLA8zmYC6dzJL+8eqgL2pLVVvUdT7zqKOmdSIWUzBt
         1sD9D9VG5guz1TUa5jtz/xPgOTvA0eXeYkhB63TOGyUIVUIJijPuSbQeWk6vMEL/v2nA
         1AL5zIoP6s2SinurCya+hHL3ohH+uQGpjWf9fqjkxHADlMZDytOhde+xAbygKgJcpEc0
         2qCE4T3+pP4GacpI54YNC3ujG7BFCN4Rv2zi9qTh4gl/9+s39KvJb/FEqpDFWEaGx4ay
         GAKgfC1ihfxno3t0Pevef3m37CpN/c4NcJMKmH03penPT6BCVJPGJWeQogXmz+Suooif
         LuCA==
X-Gm-Message-State: AOJu0YznCNhvGQxwNYKwrc4mbQ8lCn5uMYNjVphCVrC4TjGGsyc30sRN
	/lzgCznwUyYHAi8e9sYfEG8rIsd5sUlbCHYaWiQuMwsHcna9QFbQKV7ZrfAcDllA
X-Gm-Gg: AR+sD11/P8rBsGBGAUYfKdsvGuunMrvpKYTD26RdxiZr8ux8WQvsvjxxB8shfmuXeez
	Btgjefv8o/uHeVjMilpLMIxvxSrFVCO/WwFdByvQ0EmkiO3YF6a/mpufnyUYaSxKdtoR+A/mrN9
	UwUomcALbcShyuEkYitbGECKJACltdxe1/Ggab22CwQ7IWy/kSINRARou0AeItLlB1QLJbpjSfa
	8iOljGaQJOLLLHNRdQK44VtUETHmkmrsDCBv0rjlw36SfoiUHarsU9jhqMLm6Vf9Z+5sZoGRfIq
	khzxuyx7+9vDM43lreXfvLn4cl+6sdFT1JaUPHzS2a7jwGYnGJrH19Id5zBHmPc47V7Nod/OfHb
	XhtWshFXw2dq7B72ihPm/BZAGHeZufLIpg/l4BAHB4AB7R09cdeFjVpHZPXD9SfhlYxD3ZaxCmt
	MR/lVaqfx4f/Vb3yPQ6KpvHfOq22vCGLwoR7qUmKz4dao50sdVm477mFkQcWUxwp4D
X-Received: by 2002:a17:90b:448d:b0:390:b3c5:e2c9 with SMTP id 98e67ed59e1d1-390b3c5e3e8mr974535a91.17.1786088376722;
        Fri, 07 Aug 2026 00:39:36 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.82.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085f2b2fdsm3850151a91.12.2026.08.07.00.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 00:39:35 -0700 (PDT)
Message-Id: <965074f9e88738353dfe496a9ce3b704584b6ae6.1786088371.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 07 Aug 2026 07:39:25 +0000
Subject: [PATCH v13 2/8] history: give commit_tree_ext a message template
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

commit_tree_ext() reuses the message of the commit it is handed. A
caller that folds several commits together wants to seed the message
from more than that single commit, so add an optional message_template
parameter. When NULL, the behavior is unchanged.

Pass NULL from the existing fixup and split callers.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/history.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index c22715d848..a60e8dbcd0 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -108,6 +108,7 @@ enum commit_tree_flags {
 static int commit_tree_ext(struct repository *repo,
 			   const char *action,
 			   struct commit *commit_with_message,
+			   const char *message_template,
 			   const struct commit_list *parents,
 			   const struct object_id *old_tree,
 			   const struct object_id *new_tree,
@@ -137,13 +138,16 @@ static int commit_tree_ext(struct repository *repo,
 		original_author = xmemdupz(ptr, len);
 	find_commit_subject(original_message, &original_body);
 
+	if (!message_template)
+		message_template = original_body;
+
 	if (flags & COMMIT_TREE_EDIT_MESSAGE) {
 		ret = fill_commit_message(repo, old_tree, new_tree,
-					  original_body, action, &commit_message);
+					  message_template, action, &commit_message);
 		if (ret < 0)
 			goto out;
 	} else {
-		strbuf_addstr(&commit_message, original_body);
+		strbuf_addstr(&commit_message, message_template);
 	}
 
 	original_extra_headers = read_commit_extra_headers(commit_with_message,
@@ -196,7 +200,7 @@ static int commit_tree_with_edited_message(struct repository *repo,
 	if (first_parent_tree_oid(repo, original, &parent_tree_oid) < 0)
 		return -1;
 
-	return commit_tree_ext(repo, action, original, original->parents,
+	return commit_tree_ext(repo, action, original, NULL, original->parents,
 			       &parent_tree_oid, tree_oid, out, COMMIT_TREE_EDIT_MESSAGE);
 }
 
@@ -675,7 +679,7 @@ static int cmd_history_fixup(int argc,
 		goto out;
 
 	if (!skip_commit) {
-		ret = commit_tree_ext(repo, "fixup", original, original->parents,
+		ret = commit_tree_ext(repo, "fixup", original, NULL, original->parents,
 				      &original_tree->object.oid, &merge_result.tree->object.oid,
 				      &rewritten, flags);
 		if (ret < 0) {
@@ -886,7 +890,7 @@ static int split_commit(struct repository *repo,
 	 * The first commit is constructed from the split-out tree. The base
 	 * that shall be diffed against is the parent of the original commit.
 	 */
-	ret = commit_tree_ext(repo, "split-out", original, original->parents, &parent_tree_oid,
+	ret = commit_tree_ext(repo, "split-out", original, NULL, original->parents, &parent_tree_oid,
 			      &split_tree->object.oid, &first_commit, COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing first commit"));
@@ -903,7 +907,7 @@ static int split_commit(struct repository *repo,
 	old_tree_oid = &repo_get_commit_tree(repo, first_commit)->object.oid;
 	new_tree_oid = &repo_get_commit_tree(repo, original)->object.oid;
 
-	ret = commit_tree_ext(repo, "split-out", original, parents, old_tree_oid,
+	ret = commit_tree_ext(repo, "split-out", original, NULL, parents, old_tree_oid,
 			      new_tree_oid, &second_commit, COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing second commit"));
-- 
gitgitgadget

