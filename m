Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20461364933
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269246; cv=none; b=FztiQSZaDo1kg2hjFXp2p9LotJp8aaVPSH+alQWrFSAbAGtWWN/knNYiDuzj6UB2y83PO2aaiIr9b4147lnI9GwxAvsDw5opa4tYul/GQpUaUeNnUnxZD3UEBPM8mbeTz/Olj6gM6GWIpscwjlJvGc0OUmI8lB8h4ws274Try90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269246; c=relaxed/simple;
	bh=cPVvKJGzr/UZf2yYmAjnPqvAd9d+b2yS9v9rerDLXfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kCkupUTXDOZvvIG3xps1YdlmXD4wI1zODHYCvFlX0UxcBkmkJlarRVpcMkrp+AIid7hEtW2ALGxuFOBa81VlwV/ufH6HFQenyvrNZZ2ej5gJ1Z67200CApGnGlHRTi33ijl2E+WaHKndmHoGJmvevTt33PIo0PDwDMJ5QCROAAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RARGmlhc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CseIC+D8; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RARGmlhc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CseIC+D8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 518EEEC14D2;
	Mon, 27 Apr 2026 01:54:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 27 Apr 2026 01:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777269244;
	 x=1777355644; bh=OWrTntZPvkwjEBJh0GfkpWctnWGTJEvHt00rAJ6hyGE=; b=
	RARGmlhcLqSEb9Er4YqKzIVZ2nedmIP+wyWe7cuzUUPB4s32J5p6EVrzxB3T9Kh4
	6Bejo9VTPJGhx1Gt7bxPb4WWl3E9swuadAQelRjRdipSj0bdrhuEW9+HNPEbQQGb
	USqChWVeFuTCLJl6EcTeIKFb9szogKcLxMsv5KPs79Adutqt4tmqhHyfyeAvXow0
	UBOoTdzRmXQCcGfuwz1mn+9+pr4hPbYnUFldtLwa38a5cIOxY4Fg8LHiBGmXIsW6
	U6J+EIMwB2NmXrOxc6T6K032xNNedgOUZrA42lVcG26kXXscF3dC2yatJxVqoNXy
	3KFxo5pY7DxJKmO9mn/QsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777269244; x=
	1777355644; bh=OWrTntZPvkwjEBJh0GfkpWctnWGTJEvHt00rAJ6hyGE=; b=C
	seIC+D87+/dbNJuoBIgi+lZbaHVT0WIfG5qidVWN2+w+GzWCrM3C6Kgvqeq0KKUG
	PEU9y9GosoE0Qhsiy4WVMFUJ/JiUdR1/dwbLXCzP2Q/GrmLUAb+idDjXC904jZKe
	84KDVE4ApnNu0J7OyxL3srE9QY93m9HDrBB03gWKU++nC4rh2PS6wjDbVHCoHWek
	sBpsvnhW7JuvXwCPeMIqvNHChHJ3v6wjTGdpLsy/bbhgw3+G0Aq2zfbvUROSaVPN
	6SfNIhoeYddeSzEORFOpvq/trsm2ymm4ytBjZxnNzamp2AYU9f62jSuqTrcqrXUw
	HIE2nMIhukc9PY/j3DTvQ==
X-ME-Sender: <xms:_Pnuaa-FS886oP3_DkOzzDZp0sHHTiDHlcZ1mTVubPk2YLJTeBKitg>
    <xme:_PnuaRvmxX-woDHGUeyX4SPoExLbK5pPPY5U01nXKB6igjv3O36_dl4v24Xm1F6ZM
    LO00Y7YVHSi0SsAfGdaRM3Zx2s47FMXYU2NPnm1T1IRRnu4A3aaRwg>
X-ME-Received: <xmr:_PnuaVBJzSycD4LhEkrIaJfxgDZ01QDk_WUPh-JhduS4kSUuO3AvNP1dLHlDaTbsszN0IX39QO8qtjUdHSk_l4TB4k2FP2GfAOuR7ygptw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_PnuaRUlJlIN44l4OWvbq5ER-18wW1ozg9uQWQsFHjSZEGQlefj1uA>
    <xmx:_PnuabDdK1JsowKfpLDdg8BbECxWcXmU4D-thbi_axGAi40_AZ0mIQ>
    <xmx:_Pnuac_Rr7IVr852YWhrtO2pge2b-k53FObJMTyJs7pMYU5udi7xQQ>
    <xmx:_PnuaaFiG4BbBOkmeVExeYZSRec4Sn2EmsWF4u73BQE108t4jsujeg>
    <xmx:_PnuaXcSXel8zIs8GWkcQgYqOLp6m08vihzzODw7UwyFe1oKLjPAWjR_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 01:54:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8eb4c5c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Apr 2026 05:54:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Apr 2026 07:53:52 +0200
Subject: [PATCH v3 2/3] builtin/history: generalize function to commit
 trees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-b4-pks-history-fixup-v3-2-cb908f06264b@pks.im>
References: <20260427-b4-pks-history-fixup-v3-0-cb908f06264b@pks.im>
In-Reply-To: <20260427-b4-pks-history-fixup-v3-0-cb908f06264b@pks.im>
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

