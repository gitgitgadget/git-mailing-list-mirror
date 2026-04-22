Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BB52D77E9
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853748; cv=none; b=bz39yaAEIanmtREB0xuhz1sd19D97SC/BguCNOGRpqhwGntXLvgZO/agH4Li0pjWJjOrThokodWaKS7xNGBOVe9rBVomX8rkTb7mndq1wY04jnzYLvbkgQTS9jJ79VHB7DrXOo+9Rc7y7jDnPKxB3u58B9+Yv5eZUigydncD1Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853748; c=relaxed/simple;
	bh=cPVvKJGzr/UZf2yYmAjnPqvAd9d+b2yS9v9rerDLXfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AiG2H8BsReesomldFgSEWqmioDnSJvp5Ag5hXP2D3QTSNZrHTMMUXTvXxca7ItyLivIhMBZcicbMMUq1qMVyuAkDanzFVNMWsWajQg/w/MBY8YVCURrCPYN0SanCSH8vs6CRp0bdFioJ+0DFBKtRiP0EkBGJnLc3gXlHZGaATD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r1kH57eS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S52TTTU8; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r1kH57eS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S52TTTU8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8A9121D0025C;
	Wed, 22 Apr 2026 06:29:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 22 Apr 2026 06:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776853746;
	 x=1776940146; bh=OWrTntZPvkwjEBJh0GfkpWctnWGTJEvHt00rAJ6hyGE=; b=
	r1kH57eSpPsv10/UKxy4USChKKxlHUHx73WuNiIpUcv16AuY8FNsMXHDhMKoL6FS
	492ehCgng9oHqg+k8zWH6xRNx7IfgGlh2TwGAHPVHWsoWjZP6Cq6A/mQQKlVYi7e
	FP0Ypz5oP6aoYKmd4oRC6At9lG3771qtNSDi0A4O1EaBA1/1/fTihmjOdlJ+5rwc
	XF164/uaw2u32YspqzXBywdO/NIPJxsf6D9qYeuivmqci1NxoA66m8uckvvwnnSl
	jjYKc594l8E3u46oWwTXe5kmT4SjZT9l5c6w/IG6EsMZZdIDTbWoW6OaCw251kLK
	7YOhD1AHJPDfP3roitG5bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776853746; x=
	1776940146; bh=OWrTntZPvkwjEBJh0GfkpWctnWGTJEvHt00rAJ6hyGE=; b=S
	52TTTU8qeRE80s6O/YQyH5pEDUeYdvdyx6nc2A5VFdSLLP8Zp35CvSMSX97jcZuQ
	m9Qjwv/JCWslHZXGMYCPBBzmBlzYj3XrCVwFgx5ogFXWRqOticgVniTCPmDWaZFf
	VRIyayBx82oEQRBGIY+9x8K/SzX2A5LtLl/Y6jHyI0SATEZLccp+t9z9b60U9V5u
	MTzEjlWhYgsAczTVThmc5CzwLdeTXckStb+dwSlBSlDNPIyGjzrk7rTsjgM2y/QI
	1hZ7ztNNEuwI00lIzJ9xachpbrCUA+bZ8oRx5jJe1/ri5w+OxgXVXdSmFkKgWVYH
	hSN4kYKl57At+QRC30icA==
X-ME-Sender: <xms:8qLoaVyVvmpNIFHtXYQsPQqfHRw8ARYXGWrBiPk8ycWO_m2byKpVOA>
    <xme:8qLoabTfuf736wLprSAi5QCEU-Vq6moc1zLc4d_vSuaLhTQyWsKeJ_wsg_aNpbEse
    WGigOSd16PiQBr7GxNjOaTDB0FFgLcKo2XYWqMmagXqyV7SRLGOVX0>
X-ME-Received: <xmr:8qLoac_tWPqhGe0QDLr9x6X40co9ffCxrC7i4Kdxfx785VSiQsWpa_CCEheQza6oNtbINNfqwL29mBznFLKEc88qedinVTtfkyhFK3ls_QQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8qLoaSqEM2IAirO7pWSRsBRmVhZrJwdSGDO3nuYiMAKM5CI9Y7ZrGA>
    <xmx:8qLoaZl_K0Uf4Bpf2JHhvwXVGRDLKQPdBwCTHoH0nwPiucYXWTNcGQ>
    <xmx:8qLoaZK1zHQqEuhbtm7skouSUvLEBeX7wtmI4iSC2y41qdTGbhNaCg>
    <xmx:8qLoaewtd4A4Wd8HziOleOfdDVzC9zfZ1gOT_0glm2k_VzBGbp5sZQ>
    <xmx:8qLoaRiG9v3QAh6m0_GSW1uFhPtlyHS6EOTi4caZkIJhuk38m1mdTTxA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 06:29:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4cd9ba30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Apr 2026 10:29:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Apr 2026 12:28:58 +0200
Subject: [PATCH 1/2] builtin/history: generalize function to commit trees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-b4-pks-history-fixup-v1-1-48d4484243de@pks.im>
References: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im>
In-Reply-To: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
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

