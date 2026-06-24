Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5DF27603C
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338107; cv=none; b=SJ31uLrxBoUXZD27GDXjIR4JHGyJXgmd4YfvjzCbxK7FBkqT0UsIUfD0zLe9GcJH8czC39phV8ZrKVhwP2MKYLktY/+bRQjYTRqajrErHa8JEsFLo50ollh8Ad7mJTBaIWRN9WJDM7WfFU1ZhvZqEATW1cz70uGBmBIk55IJVdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338107; c=relaxed/simple;
	bh=v42sOHU+NPEhjIkOG/WgYyh8KYHUdpVLrZrg5hNdK2A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rDGEUEvLkeTZyEcvTFdfp9VRRppVdX+2ISF5Z4j4ShWKOAbv6XWiCCS+CsP0vDI+F1G2ITjNaQXb+JpJiDk0julzLjF4m6uO2gW2GSGWbphNHqLra1kP8wJelp68vGWKjkmEdFUZn26PtZng/YgGXYLiL6KXqGd0JXhFvGRuwVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzo24JQ8; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzo24JQ8"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-91588056619so96606285a.2
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338105; x=1782942905; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2733pf3f6XCQItOqhNRXBLMf6hYjl0Tg3jbpsScbzec=;
        b=mzo24JQ8nzwExNaTwL74+cjVtI7FDChzdWByXVKC8WRBUhCHLs3S+XBT4ixxN6MgoZ
         kxKiDLOqVbmbYNH0N4CuEGLradjzqYYLJv3bmKxhQAhRCBybgejw46xw3T6ptcs5p43Z
         itno7yPnaZ8/UETUz929FKM1s+nLBFGKktTOKdhUDFKlyFq8kPqazmCqiOhI0ybEZOf9
         AxtxeDdn726ZB/QFMi88A7+el9SG4tpj4pXdLpnSXS2epQAIew4mtTWj7pLfV8uk+JZw
         lND9bUrw8bXBYijLrenOYs/w391RFQDj++LXV8Kvjn5JoeRko+mLR8xTViT6Gb1pO6NG
         /4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338105; x=1782942905;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2733pf3f6XCQItOqhNRXBLMf6hYjl0Tg3jbpsScbzec=;
        b=EaqNtsswz9JPDSgZ9Zhxg980HUEbC1F6C52nKrBZEznBy1lj5BLNzz9bQULmb7LIPa
         lMW5GdamLfsGeib9SbEWv5rhGCZxCB1SgdD218dDNJr4mskRMsPRb/pvuzGnXmt7QrCt
         lW/Flj0206bm/fYi8NHGfVd67Xljr8ThDNxtXzkABfO1xqbvuqmTw8lv1W4ImpeAr1e8
         XF0tjsllkLhUXo+DmwTGfGi0WFpHcWg7RS66717j020Gv6BrPkg+rnHdYZcTCxVcvGxh
         R2AnetA/IGZpoDqX3NROGqy2gVq4B+M1Y4arrAEFnL4T7zlg9dWbjZEkTB/xpc5mMPgV
         9f7w==
X-Gm-Message-State: AOJu0Yw+m2m4HaZ5rr1rMG4HtM8DH5kjuye7FLRpUpriNaJmPeigeAQj
	5FUYbliV1L7mOIbxpTOWtQcWlpP0CVLWf6Xwdb6lrAuhPFv++IB8y9h5pqIwF7nD
X-Gm-Gg: AfdE7ck7BhGAYvVReijUAl2TiTxnzSIDBY76EWxkPENS6EqxcZui6MIjSftrB/JXNX0
	E4cvLfMfp/H71YbHoRJkUr/A1CH3FCtJOL8Ht4xP6LmU83mSHmkBCswl7/AI9+XIAIoYGYqq0qB
	9mqoNt1Cv+eh+d0Qr8cni+zpUUoXKhX52h+hGKivLjiyGX2JyXN7+rk/TWOwmJOEJ6OsQq3ZuLr
	mPKybuB+4dVuwEFQpnNO+dYafK1HdH57peJ6ElRbvSCPlohfoR1qTrQbCIPqW4DRsxnmdwnizQ2
	zTGZ9gc4/MKjwAMZ5pOvb3AY1PMSjcJOstKILm8G9Fbuwet9on9ooOyf9FAb048v/tKv7mp+aoI
	pLBxUBjgQBmCgUXyLFWJcoTKICdgpVqfV0yQ/9D4Z1RNl9UXPD7ob1loqC0Uke5Mpnhk3G0jHE7
	73xu5sNpbbsgtQGGM=
X-Received: by 2002:a05:620a:198f:b0:922:f2c6:b79a with SMTP id af79cd13be357-92784413f0dmr832558585a.48.1782338105320;
        Wed, 24 Jun 2026 14:55:05 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.191.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fd391651sm657252985a.10.2026.06.24.14.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:55:04 -0700 (PDT)
Message-Id: <a97ffab1e65ad59b07377a45a16d5c870361b8ad.1782338102.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
	<pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 21:55:00 +0000
Subject: [PATCH v5 2/4] history: give commit_tree_ext a message template
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
index f95f26e684..305bde3102 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -101,6 +101,7 @@ enum commit_tree_flags {
 static int commit_tree_ext(struct repository *repo,
 			   const char *action,
 			   struct commit *commit_with_message,
+			   const char *message_template,
 			   const struct commit_list *parents,
 			   const struct object_id *old_tree,
 			   const struct object_id *new_tree,
@@ -130,13 +131,16 @@ static int commit_tree_ext(struct repository *repo,
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
@@ -189,7 +193,7 @@ static int commit_tree_with_edited_message(struct repository *repo,
 	if (first_parent_tree_oid(repo, original, &parent_tree_oid) < 0)
 		return -1;
 
-	return commit_tree_ext(repo, action, original, original->parents,
+	return commit_tree_ext(repo, action, original, NULL, original->parents,
 			       &parent_tree_oid, tree_oid, out, COMMIT_TREE_EDIT_MESSAGE);
 }
 
@@ -644,7 +648,7 @@ static int cmd_history_fixup(int argc,
 		goto out;
 
 	if (!skip_commit) {
-		ret = commit_tree_ext(repo, "fixup", original, original->parents,
+		ret = commit_tree_ext(repo, "fixup", original, NULL, original->parents,
 				      &original_tree->object.oid, &merge_result.tree->object.oid,
 				      &rewritten, flags);
 		if (ret < 0) {
@@ -855,7 +859,7 @@ static int split_commit(struct repository *repo,
 	 * The first commit is constructed from the split-out tree. The base
 	 * that shall be diffed against is the parent of the original commit.
 	 */
-	ret = commit_tree_ext(repo, "split-out", original, original->parents, &parent_tree_oid,
+	ret = commit_tree_ext(repo, "split-out", original, NULL, original->parents, &parent_tree_oid,
 			      &split_tree->object.oid, &first_commit, COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing first commit"));
@@ -872,7 +876,7 @@ static int split_commit(struct repository *repo,
 	old_tree_oid = &repo_get_commit_tree(repo, first_commit)->object.oid;
 	new_tree_oid = &repo_get_commit_tree(repo, original)->object.oid;
 
-	ret = commit_tree_ext(repo, "split-out", original, parents, old_tree_oid,
+	ret = commit_tree_ext(repo, "split-out", original, NULL, parents, old_tree_oid,
 			      new_tree_oid, &second_commit, COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing second commit"));
-- 
gitgitgadget

