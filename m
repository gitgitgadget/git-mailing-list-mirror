Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF634844D
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208612; cv=none; b=l8bQBedf1HVbbflwqvxin0gE+AJ67U7PGYJxYRQQXYQ40EU81iVOd0zCtksrZGxYX2paiEO82bOkpDINAMdhrCGdUs9UbpRG6jWVarX7fwAn9xJU5NDqWVg5Y4S0ljE+QyxGooceAUDbt5S9uroHUu1UfM7QPv1fyHhUkJQeePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208612; c=relaxed/simple;
	bh=Z8drvfnhSUjWSfpLYuNJBNqI8T7ieyCdLvB5SP+jdqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kuL+fTHl4EsT8vyxil9ZxSXDAdAD5IE/XIw+1A+3SnFnl8+EAV3q1E9cjkppzBtfT3MIIpd01S1sNqRwPXRJh+GRYNJPD75IMJStm8uMqtYBbSavf3lmJfCRkV04XSfDPRVc77f2SvyOXJEZ4hh5JBgBvEqvhFuBm/ZDAjc4WOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QgaMGkky; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xic1qAXG; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QgaMGkky";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xic1qAXG"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C32547A0040;
	Mon, 12 Jan 2026 04:03:30 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 12 Jan 2026 04:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208610;
	 x=1768295010; bh=2NqUK0a9zS6HNpOS4I708mVR9RoNNNBnuI0qxUZsiEQ=; b=
	QgaMGkkyU/2jWuldcATzpfkt0fKGNKN7DLrDiuD9sGgEQh1KZn15Wzgpm89IQE8n
	QUvR0J7lQOtoQCnJHWE8wCywmMBTuNz5fQGLcc07+yl2Hnh/KvKs11E/xaYlTBvt
	gXHLy2u+/DvbK3vMra6RbOVwFMP6f252TUJ7K9X6Xf3CmtbEdVdJ4attD21RKE5n
	9TR3nWSbV7KG45NC0XxIcD+6uqVsOhmHOKa19E25aD0HblCRVLQNyVx/89i1uoj/
	nsoU+hPOcMljNBcBxoTU80dC7Ad4PLLTVxL27Vb6kqrAW8Gl+Z85SDXiub94tfyh
	DfdfLw0lh8+W+RL5G8BGyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208610; x=
	1768295010; bh=2NqUK0a9zS6HNpOS4I708mVR9RoNNNBnuI0qxUZsiEQ=; b=x
	ic1qAXGxf9clKLZwV0g3mGmBmFE0cyMIr7BCR2Scqxc2qa02vZpH9Se5LDzaq/kX
	5MfiXfUDEtO2ZXEHGTs7TdcaGiuA1wQUq/5KodrcSSqo0Rab6MfDOopN1rcyde31
	mU53cZJ+40pZP6r57zGvvbI7TrUckqtY1tU6pqVHw7uGlWz+0BlGk1ZF9SQT4D//
	QZcZFDOrFo7qtdhEbbt+lCF8HI3ANt+1GaAj0qRevDfWjQblpPhIHDpiVi6aJaIG
	u1YJUSALqFm4rCWPtOefk3jB9sXXJuBhc2s8aKpGfPhITdhOy6rPs3ELYqQcfiP8
	ygdrWa0l0/rWcVSoVmRAw==
X-ME-Sender: <xms:4rhkaVuzh27mcX_1uYPpI8sNitu8HFknnE1uAcNC3pZ9FPNjjk5eRQ>
    <xme:4rhkaV4Xoe4srmBUT80zpH_5dObEsu56lYOFAhm-qenadEw9zje5nlHOuDjgX5PUs
    T-foh-Sj6YaPKeMwE0khE2VRGjAwJ1qCtIoqjdESRaAJUIlnAQQ>
X-ME-Received: <xmr:4rhkaWJvu5gMsKu47SNQKjq2ZHRiZKLiFTJemuNRuFbSEX4KO6KtRmAIniZ7IMjRDKROzvZXvF1QOTNXra7BXJwVnX5cPQX0OoE2mRpoBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjih
    grlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:4rhkaV78AgEX1e3psXjCIc4arLomSrrHHCsv6M0QkmmrVeDLxbveew>
    <xmx:4rhkaZxjC7IEe6OPF9auKfTgT4QqtT1aC6cEw7CnJw8a_Tpljpq2vA>
    <xmx:4rhkaZYSuTBe-KPgGmz1IpkIOrCkzT__dgE71mIW1TMQkiL5_lH8kQ>
    <xmx:4rhkabS3mqlitgL8FZkJMbqlubVapCD8oWJGsy8SuZ1iwKlp2XEXqw>
    <xmx:4rhkaYW1uomEBVyLdyctWIyIwu3tfEgbgYKnznCIEZEajiop8w0e9sUc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:03:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9485d61b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:03:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:03:02 +0100
Subject: [PATCH v2 13/17] refs/reftable: fix consistency checks with
 worktrees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pks-refs-verify-fixes-v2-13-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The ref consistency checks are driven via `cmd_refs_verify()`. That
function loops through all worktrees (including the main worktree) and
then checks the ref store for each of them individually. It follows that
the backend is expected to only verify refs that belong to the specified
worktree.

While the "files" backend handles this correctly, the "reftable" backend
doesn't. In fact, it completely ignores the passed worktree and instead
verifies refs of _all_ worktrees. The consequence is that we'll end up
every ref store N times, where N is the number of worktrees.

Or rather, that would be the case if we actually iterated through the
worktree reftable stacks correctly. But we use `strmap_for_each_entry()`
to iterate through the stacks, but the map is in fact not even properly
populated. So instead of checking stacks N^2 times, we actually only end
up checking the reftable stack of the main worktree.

Fix this bug by only verifying the stack of the passed-in worktree and
constructing the backends via `backend_for_worktree()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c  | 29 ++++++++++++++---------------
 t/t0614-reftable-fsck.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index dda961a32b..6361b27015 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -26,6 +26,7 @@
 #include "../setup.h"
 #include "../strmap.h"
 #include "../trace2.h"
+#include "../worktree.h"
 #include "../write-or-die.h"
 #include "refs-internal.h"
 
@@ -2762,25 +2763,23 @@ static int reftable_fsck_error_handler(struct reftable_fsck_info *info,
 }
 
 static int reftable_be_fsck(struct ref_store *ref_store, struct fsck_options *o,
-			    struct worktree *wt UNUSED)
+			    struct worktree *wt)
 {
-	struct reftable_ref_store *refs;
-	struct strmap_entry *entry;
-	struct hashmap_iter iter;
-	int ret = 0;
-
-	refs = reftable_be_downcast(ref_store, REF_STORE_READ, "fsck");
-
-	ret |= reftable_fsck_check(refs->main_backend.stack, reftable_fsck_error_handler,
-				   reftable_fsck_verbose_handler, o);
+	struct reftable_ref_store *refs =
+		reftable_be_downcast(ref_store, REF_STORE_READ, "fsck");
+	struct reftable_backend *backend;
 
-	strmap_for_each_entry(&refs->worktree_backends, &iter, entry) {
-		struct reftable_backend *b = (struct reftable_backend *)entry->value;
-		ret |= reftable_fsck_check(b->stack, reftable_fsck_error_handler,
-					   reftable_fsck_verbose_handler, o);
+	if (is_main_worktree(wt)) {
+		backend = &refs->main_backend;
+	} else {
+		int ret = backend_for_worktree(&backend, refs, wt->id);
+		if (ret < 0)
+			return error(_("reftable stack for worktree '%s' is broken"),
+				     wt->id);
 	}
 
-	return ret;
+	return reftable_fsck_check(backend->stack, reftable_fsck_error_handler,
+				   reftable_fsck_verbose_handler, o);
 }
 
 struct ref_storage_be refs_be_reftable = {
diff --git a/t/t0614-reftable-fsck.sh b/t/t0614-reftable-fsck.sh
index 677eb9143c..4757eb5931 100755
--- a/t/t0614-reftable-fsck.sh
+++ b/t/t0614-reftable-fsck.sh
@@ -55,4 +55,36 @@ for TABLE_NAME in "foo-bar-e4d12d59.ref" \
 	'
 done
 
+test_expect_success 'worktree stacks can be verified' '
+	test_when_finished "rm -rf repo worktree" &&
+	git init repo &&
+	test_commit -C repo initial &&
+	git -C repo worktree add ../worktree &&
+
+	git -C worktree refs verify 2>err &&
+	test_must_be_empty err &&
+
+	REFTABLE_DIR=$(git -C worktree rev-parse --git-dir)/reftable &&
+	EXISTING_TABLE=$(head -n1 "$REFTABLE_DIR/tables.list") &&
+	mv "$REFTABLE_DIR/$EXISTING_TABLE" "$REFTABLE_DIR/broken.ref" &&
+
+	for d in repo worktree
+	do
+		echo "broken.ref" >"$REFTABLE_DIR/tables.list" &&
+		git -C "$d" refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: broken.ref: badReftableTableName: invalid reftable table name
+		EOF
+		test_cmp expect err &&
+
+		echo garbage >"$REFTABLE_DIR/tables.list" &&
+		test_must_fail git -C "$d" refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: reftable stack for worktree ${SQ}worktree${SQ} is broken
+		EOF
+		test_cmp expect err || return 1
+
+	done
+'
+
 test_done

-- 
2.52.0.590.g1f87b77810.dirty

