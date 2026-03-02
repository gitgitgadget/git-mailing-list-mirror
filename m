Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C941E1A33
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453612; cv=none; b=Cfeu0tsizSRmSFwmYhuLFRij5n1w5AyWL0QcRDqrfLqAd2Qqn0Z/haE50TBuVlEKUh13OTIzKnHP0MZ70bVqQsLzAVjOe3T5KnZYZcLvZYv3pXAICtfioRCbddvY4fKyk1IOnj+kb5J7uKQb3I1ZZGyLfvBCSJOxlsBgWBERjG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453612; c=relaxed/simple;
	bh=sJP23UHAC2km9JbbaYGx+Q+TuuOp9BhjS2v8VV7yH04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HR6TeExdCfjYzsgvk+cwwtNhZBRnTXBMUDJm5MKNXWIT8YToI3y4OIQJVrqgHKY9tH3AfF4gFzQY253PBwwsY3bEwnws+RnWuZfXOKtn1rsU4jp6/LtbVIwVQL0CtGWL5JssPUm16mpwge/Y95m9I9ODd6UE0UN1cNYz0pWifMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XjaZwRBn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5hEjlMdh; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XjaZwRBn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5hEjlMdh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 12A7B7A015B;
	Mon,  2 Mar 2026 07:13:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 02 Mar 2026 07:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772453610;
	 x=1772540010; bh=POYcZxDnh5WONFILBv7VanBb+Nz85VgInh7S052kvDE=; b=
	XjaZwRBnhbJLdtA3nOHwmO9uMUhxFGONooX1+LkUUGS4eYpvX2gUfmNbvWckuCN0
	2SLruA391c+iK1Ja8CRaK33zkoashloFPcs/DOlzVyJNhLWPb0Ur69899SBH58wd
	TXuaSe9EfQG0kCujtUrwGjfPnO5ql1eaHyLDguTSw4TSxjRaPk+mOYT+jUUkHlJs
	tQlD1o1fKrHwkpK8rddfGXOQ4riivmiHk7mKIy6uAWed5W0Bi+ImRnw8b8vTBf5W
	hbZ79mV5QrCTytZzCx1gabJ5Z/2URt+QXJsGLsUzuIz1kKb+QVVgZPa2s0mU9eRc
	p2C2mRkMFI3HmSLX9B+1yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772453610; x=
	1772540010; bh=POYcZxDnh5WONFILBv7VanBb+Nz85VgInh7S052kvDE=; b=5
	hEjlMdhbR+N/8bCg5lttyNb5GKBm0aXJC8pL7+FTuAxIffeFQx7LRtcLjKtjyWPu
	qHHBgnpadBRLLs3MhYcryywR/y9Is0io3+81u+ZSlpiMMZ9jxVr7X7vdcp36scQS
	0Jrd8MgZZRru069gey+t28A0qK16vdtZzUWDX9fl5wl7mxwOXea1+8LpeCusaUBv
	s9N0MpGoiOnIcRUrjd+mok9dYLHUF+5UzIwM02wHrapYc6l9nGaBivb+UvSUxUBC
	Ja9BlbLCVeUhj9TRlqBldh1IFT9B4U7FTf+4Ni71pQvgTv7fiO3Vd0vbMXzryKTz
	3Q/TCEScjH1goE5fMD0Mw==
X-ME-Sender: <xms:6n6laVwlMDmjPLcIrKVBrS6ceT--dFG3omCgCTxlBG_nUL1xWB0_zg>
    <xme:6n6labQvdKxlxt-UzF5Ztja8uoLDngDw_XdEjWJ2dRm97Ao1LTfYXZe0jdGAEzFsl
    OwO_6EI17E62miA1W1koeFlzLvN2bC9IJNt4jvClizR1Jgl7k3O0yk>
X-ME-Received: <xmr:6n6lac_9jBZhGHU7d_tr0WMJeFTzCdddzw3HDoy_u0SIUAqc2A0AWl6U1gU3PLPXpQxP4x4-MLVc83685iBHbK_5UgmEn3iabt0iYb9Niw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6n6laSpUvuqK774hKzXL2QADCthci5eA_9hFgPtX-XPif4mqxU5s1A>
    <xmx:6n6laZkPJt-QJ2nHQKoLGRK7ZJ4fkkJ-B1e3Ve401dD10TtEpQvGLg>
    <xmx:6n6laZIF3OG_MxP65mKYOSskQI3U89iyH682WRumxgsEU_RxBydO0A>
    <xmx:6n6laew93HEsCaUfbxbKO8MiZMfCDj5xA7iV0soqrTrV_QJP1eP6dA>
    <xmx:6n6laRgWAT183NXOEwfcFkeOW84z3eKVrRoShHcrZYRA98aM0mPVNBsJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 07:13:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10939eba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Mar 2026 12:13:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Mar 2026 13:13:11 +0100
Subject: [PATCH 7/8] builtin/history: split out extended function to create
 commits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-pks-history-split-v1-7-444fc987a324@pks.im>
References: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
In-Reply-To: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.3

In the next commit we're about to introduce a new command that splits up
a commit into two. Most of the logic will be shared with rewording
commits, except that we also need to have control over the parents and
the old/new trees.

Extract a new function `commit_tree_with_edited_message_ext()` to
prepare for this commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/history.c | 67 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 1cf6c668cf..80726ce14b 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -83,10 +83,13 @@ static int fill_commit_message(struct repository *repo,
 	return 0;
 }
 
-static int commit_tree_with_edited_message(struct repository *repo,
-					   const char *action,
-					   struct commit *original,
-					   struct commit **out)
+static int commit_tree_with_edited_message_ext(struct repository *repo,
+					       const char *action,
+					       struct commit *commit_with_message,
+					       const struct commit_list *parents,
+					       const struct object_id *old_tree,
+					       const struct object_id *new_tree,
+					       struct commit **out)
 {
 	const char *exclude_gpgsig[] = {
 		/* We reencode the message, so the encoding needs to be stripped. */
@@ -100,44 +103,27 @@ static int commit_tree_with_edited_message(struct repository *repo,
 	struct commit_extra_header *original_extra_headers = NULL;
 	struct strbuf commit_message = STRBUF_INIT;
 	struct object_id rewritten_commit_oid;
-	struct object_id original_tree_oid;
-	struct object_id parent_tree_oid;
 	char *original_author = NULL;
-	struct commit *parent;
 	size_t len;
 	int ret;
 
-	original_tree_oid = repo_get_commit_tree(repo, original)->object.oid;
-
-	parent = original->parents ? original->parents->item : NULL;
-	if (parent) {
-		if (repo_parse_commit(repo, parent)) {
-			ret = error(_("unable to parse parent commit %s"),
-				    oid_to_hex(&parent->object.oid));
-			goto out;
-		}
-
-		parent_tree_oid = repo_get_commit_tree(repo, parent)->object.oid;
-	} else {
-		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
-	}
-
 	/* We retain authorship of the original commit. */
-	original_message = repo_logmsg_reencode(repo, original, NULL, NULL);
+	original_message = repo_logmsg_reencode(repo, commit_with_message, NULL, NULL);
 	ptr = find_commit_header(original_message, "author", &len);
 	if (ptr)
 		original_author = xmemdupz(ptr, len);
 	find_commit_subject(original_message, &original_body);
 
-	ret = fill_commit_message(repo, &parent_tree_oid, &original_tree_oid,
+	ret = fill_commit_message(repo, old_tree, new_tree,
 				  original_body, action, &commit_message);
 	if (ret < 0)
 		goto out;
 
-	original_extra_headers = read_commit_extra_headers(original, exclude_gpgsig);
+	original_extra_headers = read_commit_extra_headers(commit_with_message,
+							   exclude_gpgsig);
 
-	ret = commit_tree_extended(commit_message.buf, commit_message.len, &original_tree_oid,
-				   original->parents, &rewritten_commit_oid, original_author,
+	ret = commit_tree_extended(commit_message.buf, commit_message.len, new_tree,
+				   parents, &rewritten_commit_oid, original_author,
 				   NULL, NULL, original_extra_headers);
 	if (ret < 0)
 		goto out;
@@ -151,6 +137,33 @@ static int commit_tree_with_edited_message(struct repository *repo,
 	return ret;
 }
 
+static int commit_tree_with_edited_message(struct repository *repo,
+					   const char *action,
+					   struct commit *original,
+					   struct commit **out)
+{
+	struct object_id parent_tree_oid;
+	const struct object_id *tree_oid;
+	struct commit *parent;
+
+	tree_oid = &repo_get_commit_tree(repo, original)->object.oid;
+
+	parent = original->parents ? original->parents->item : NULL;
+	if (parent) {
+		if (repo_parse_commit(repo, parent)) {
+			return error(_("unable to parse parent commit %s"),
+				     oid_to_hex(&parent->object.oid));
+		}
+
+		parent_tree_oid = repo_get_commit_tree(repo, parent)->object.oid;
+	} else {
+		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
+	}
+
+	return commit_tree_with_edited_message_ext(repo, action, original, original->parents,
+						   &parent_tree_oid, tree_oid, out);
+}
+
 enum ref_action {
 	REF_ACTION_DEFAULT,
 	REF_ACTION_BRANCHES,

-- 
2.53.0.697.g625c4fb2da.dirty

