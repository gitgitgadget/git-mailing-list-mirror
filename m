Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A5835B651
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954130; cv=none; b=Xg2DCJAT11+lp1mAC9Z7MY4PyIMBlCvzaLrDzJq1FuUfpjDupVseXvacqn5ah8o7XZ8dm5phLl+Qf8AqqB9MW4BgZazljVJTMI2POHTcUsknrCcC2VZBJUEuyLY2o0d+ZO/Y9pqwZsAZa5KXvwHLKQHatgrPVN8UkME9rYanO8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954130; c=relaxed/simple;
	bh=cPVvKJGzr/UZf2yYmAjnPqvAd9d+b2yS9v9rerDLXfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GVHQcNalnUImRXv/ovvGEqioigKwWDmv8AX9QFlSt/xaZjtOl6xPKvLUR2432DRYkvY97aI6b/6K2YLo663Mkm87VZsqVhpqQ0l5iCuhFeTbj7H067y5d+L3U13/UuXacEx1TOis6KWPh5Mw/gFNjjvr1aSVw2wq1W8qPZZig78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tZCZR+gf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PnF2UKRQ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tZCZR+gf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PnF2UKRQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4382C1D000A4;
	Thu, 23 Apr 2026 10:22:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 23 Apr 2026 10:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776954127;
	 x=1777040527; bh=OWrTntZPvkwjEBJh0GfkpWctnWGTJEvHt00rAJ6hyGE=; b=
	tZCZR+gfgUIR3FfFZfWQZJLoJ1quEmxt6+UntKMyRA3t1CIqChsl/RsZK7sIY4ys
	G9oWRLKHsn6zi/1cTmv2bdiUMy+S2mWfx//CpmSEKXiKbv78o80hJbdAAjlHyA16
	ZWHA2qrE/3j3lbcW2DDL/ZamMY5BEltnIQjXr5zG/wyfz51egDBtvFz7rZDg7Z9d
	W1i++jXGmbYDUpTw4KHd/Atn0yWrALAm9FhsNsMmjAmLjwgioFb+UUJCh2deoydo
	/3w6krbQDFRvKDTzi1Afgp7qm1ofHuYFCxCL4Y0hoABU8eJ6qaHAuAoIqub/aS5V
	CPyPXIwLgQvoMUiTzPWj+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776954127; x=
	1777040527; bh=OWrTntZPvkwjEBJh0GfkpWctnWGTJEvHt00rAJ6hyGE=; b=P
	nF2UKRQjRs4Mo5JhAQCMzQKr3m1cA8+k+ZU4OscaXnf4gzSnYSdC1C7skm9xBJ2q
	KTVURhuoMjWOPPYNCrfNXTuBUvbuGp3ceP9sao//fSLdTWrwxXNRe8nBJkwiRkMO
	MAwLGO9PJR3DYMRRH12MCgQMkXzrjnIDEnJxhxHbLAhpMeaX34eM3KKeGMHxqEl+
	dN40mjnJrCxWX0afirOdx1siV/B1Yy9dr8ksIbVU9a0POYgprHD0JkiPqqX+Q91V
	QeuuwQn7muihbQVctAgUWHD1G8srasORCuhuq+Ec8dVU45kvzxJBpIWL4ms/aBgv
	s/rsxbtmSoj1GJK4RknAw==
X-ME-Sender: <xms:DyvqaUXnv3AXRxHX5bKB6kg0JYEHEM7h9ZNf5PQd5DqQIi4O0uoRUQ>
    <xme:Dyvqafk2SNjj3MvJTgy6Gi7ONJRnAakfUYwKBZRm-DyuvDkUrZF8brJpzAiUpeZwH
    vhnC4vNI1qGXFa-15Icl2-Saxz3eysIy8XICSs2jLXa8ZHJ7JdPfw>
X-ME-Received: <xmr:DyvqadYrmQHk6M7xIdngVpvstXTWe66mYOj5lAVLkpyFbd99hrL63fS-F-wC1QNroLF45IDtwLVGuw_pBwGOKJ7xcxAcuA47yhuZ9DaNtHSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghtsehmrg
    hlohhnrdguvghvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:DyvqaSP8ASKvKJ4N5u37fjXo0mD3T598VFjJcshT_-bXchHSkFYUzg>
    <xmx:DyvqaaYC5br6iJC-RVF6OFDtDlYzHI32Yersm4Ke6mAcZA9pnXV3MQ>
    <xmx:DyvqaY2SgQeSEVYo2YjdBS2NY6X5Eb_pg2ve7-crn4yIh-5U9TDSHA>
    <xmx:DyvqaYcnvYN4zxl33sVOZx5ybZSouReImXUzl9pD6oBRj_ITgL-9qQ>
    <xmx:DyvqaS1GcWrLXn0I5k7eicAyydF4A4bLw0b6HolVRzm-LC5qrBprYQQW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 10:22:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb9af406 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 23 Apr 2026 14:22:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Apr 2026 16:21:57 +0200
Subject: [PATCH v2 2/3] builtin/history: generalize function to commit
 trees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-b4-pks-history-fixup-v2-2-d7571c6d36eb@pks.im>
References: <20260423-b4-pks-history-fixup-v2-0-d7571c6d36eb@pks.im>
In-Reply-To: <20260423-b4-pks-history-fixup-v2-0-d7571c6d36eb@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, 
 "D. Ben Knoble" <ben.knoble@gmail.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

The function `commit_tree_with_edited_message_ext()` can be used to
commit a tree with a specific list of parents with an edited commit
message. This function is useful outside of editing the commit message
though, as it also performs the plumbing to extract the original commit
message and strip some headers from it.

Refactor the function to receive a flags field that allows the caller to
control whether or not the commit message should be edited, or whether
it should be retained as-is. This will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/history.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 9526938085..549e352c74 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -91,13 +91,18 @@ static int fill_commit_message(struct repository *repo,
 	return 0;
 }
 
-static int commit_tree_with_edited_message_ext(struct repository *repo,
-					       const char *action,
-					       struct commit *commit_with_message,
-					       const struct commit_list *parents,
-					       const struct object_id *old_tree,
-					       const struct object_id *new_tree,
-					       struct commit **out)
+enum commit_tree_flags {
+	COMMIT_TREE_EDIT_MESSAGE = (1 << 0),
+};
+
+static int commit_tree_ext(struct repository *repo,
+			   const char *action,
+			   struct commit *commit_with_message,
+			   const struct commit_list *parents,
+			   const struct object_id *old_tree,
+			   const struct object_id *new_tree,
+			   struct commit **out,
+			   enum commit_tree_flags flags)
 {
 	const char *exclude_gpgsig[] = {
 		/* We reencode the message, so the encoding needs to be stripped. */
@@ -122,10 +127,14 @@ static int commit_tree_with_edited_message_ext(struct repository *repo,
 		original_author = xmemdupz(ptr, len);
 	find_commit_subject(original_message, &original_body);
 
-	ret = fill_commit_message(repo, old_tree, new_tree,
-				  original_body, action, &commit_message);
-	if (ret < 0)
-		goto out;
+	if (flags & COMMIT_TREE_EDIT_MESSAGE) {
+		ret = fill_commit_message(repo, old_tree, new_tree,
+					  original_body, action, &commit_message);
+		if (ret < 0)
+			goto out;
+	} else {
+		strbuf_addstr(&commit_message, original_body);
+	}
 
 	original_extra_headers = read_commit_extra_headers(commit_with_message,
 							   exclude_gpgsig);
@@ -168,8 +177,8 @@ static int commit_tree_with_edited_message(struct repository *repo,
 		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
 	}
 
-	return commit_tree_with_edited_message_ext(repo, action, original, original->parents,
-						   &parent_tree_oid, tree_oid, out);
+	return commit_tree_ext(repo, action, original, original->parents,
+			       &parent_tree_oid, tree_oid, out, COMMIT_TREE_EDIT_MESSAGE);
 }
 
 enum ref_action {
@@ -616,9 +625,8 @@ static int split_commit(struct repository *repo,
 	 * The first commit is constructed from the split-out tree. The base
 	 * that shall be diffed against is the parent of the original commit.
 	 */
-	ret = commit_tree_with_edited_message_ext(repo, "split-out", original,
-						  original->parents, &parent_tree_oid,
-						  &split_tree->object.oid, &first_commit);
+	ret = commit_tree_ext(repo, "split-out", original, original->parents, &parent_tree_oid,
+			      &split_tree->object.oid, &first_commit, COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing first commit"));
 		goto out;
@@ -634,9 +642,8 @@ static int split_commit(struct repository *repo,
 	old_tree_oid = &repo_get_commit_tree(repo, first_commit)->object.oid;
 	new_tree_oid = &repo_get_commit_tree(repo, original)->object.oid;
 
-	ret = commit_tree_with_edited_message_ext(repo, "split-out", original,
-						  parents, old_tree_oid,
-						  new_tree_oid, &second_commit);
+	ret = commit_tree_ext(repo, "split-out", original, parents, old_tree_oid,
+			      new_tree_oid, &second_commit, COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing second commit"));
 		goto out;

-- 
2.54.0.545.g6539524ca2.dirty

