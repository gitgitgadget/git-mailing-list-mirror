Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D399A35CB68
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962412; cv=none; b=FIgq9ZrnNbJpC3/kl9xRWid0FEgifSNNn+O949D22UO5IIOFHryK7TGYHSaVoVIYTS46c4TjB2F8x2E5VuuNoTABtXsGaZ24tnpxu88mr3M09nyPqgqiZW7/rgRO+YJtdOK1LQ/UYU2iKmvDAIjLnO+dlwibSZ2f2DgcaxR/MBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962412; c=relaxed/simple;
	bh=b74aeB4Ur5LmypmwT/bckusarhtP725R+V7w+27hLR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uHfJwPGB5zI8ZnBsvICaZCe2TswImgnZHPiGCHG+Lt2mGK065sjb+oB5gTs55g+Py5WE2ny2pNoBbqU3eEKBVqJTRb8sHecJWgA2ppJm3qIiunsg4mxzrZ7liwCJPexIzdJtJuNifDtK4AeQpWojcwYl5fbs6LzIk19YbpePGnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PLAK4obo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TiibodMq; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PLAK4obo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TiibodMq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 204B31D0018F;
	Fri,  9 Jan 2026 07:40:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 09 Jan 2026 07:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767962409;
	 x=1768048809; bh=PZEHzlBIEkuWSKvhxOA+tZhTWAOtz6RI38d78L36qhw=; b=
	PLAK4obo3QypBcA8pcO0dHbvsfiFa1cMp7DspMdQz8OcmvhaLpKEt2Gdufw2eb9i
	hdm+Ib8oWw25Tc6PjqPuqQvOFbqKKKglf0qVeJ27GbIAKy0/mHs0GPZaiM3VQxlI
	ZuL5H7d8gLlOiSSSjjOYEXQC1c15lspC9NQK78bf2nWwmY7v89Rj8NpMYt4G4p6L
	QQf5XgkV/vge6WdtEf69y2WUDFqhPacHGig6816StJh/z94F+EMzZ4ECoW9L85Fy
	GN/B+1VBJoM9LIj+25OSofhgcdol/uHZrACj6aecIgxdEZJP7x4zWa8HFsG/jqET
	1qyGtGvkgr9kCyLrpFxtww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767962409; x=
	1768048809; bh=PZEHzlBIEkuWSKvhxOA+tZhTWAOtz6RI38d78L36qhw=; b=T
	iibodMqt+rr9A8ZBxeRihGN86uYhy/ZenPjgKtnMR46tnmRHjFv/+P7R18W0fGTB
	BzuwKnjaq17IQWXy7bty6nFUdYdJJsQcDGZYibDp2uFWh8xO3/UnnS21RDJwNK0i
	JJ5pC4aUeg9ArTZ7hHLW0FO5jfy6e9Wuq8nYiyHtV2bEuwOz62vF0lkni4y2TYT1
	W0hlqrwdKRZWKnrDtjE3HE3SeiEmNPBfdFlwYLqixJwwbH57OcdhMY7xz2UdueNL
	pY+cElJHjVkyOCvZBbFdfqVQz/nG3lk4umIsW7qJY+EPxU+8G9zw19mg/xCwNEs6
	PphH3frXi4ZNg5mFtYBlQ==
X-ME-Sender: <xms:KfdgabLLGPy0mv_Fj4qQLtNdEahpXkQFSyS1ZzdD78xIVfeeQEEu0A>
    <xme:KfdgaWmeenO53G6Eu_ZW08-RQosDj9xfrHBcKOw834FHR_caLUw0-_Mo5KA5apToU
    qVOX7u_-AWsb8NiojTDeHyzCVT3omyxoUL8Fb3VMF0gLwh91yjQMQ>
X-ME-Received: <xmr:KfdgaRHR0aBRGxVP5S4NoNfj-8svZrYQG7seNYXqY6TIONggAGqdTdSsOK44F0lIlkJmUAMLfgvjf-JdZBrhdTEyi6mNzLWsDCnvx9K8xQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:KfdgaeHNoV2cOpIDoAb0BngAWM5JFfLyGLGflfzBkOS-92V7qCtlbA>
    <xmx:KfdgaWNKqpCZjyGz5YfJ22LJjHbrcphLmnE-iuaxLI-2RvGxyiwe1A>
    <xmx:KfdgaVEfLA-UXi9Y8aC65SsZHAoX7Ssh-AeFXDNvm1vvCuLrwmG_dg>
    <xmx:KfdgaVMla6RGMnDfKpIOcUpf1VPIuT4-LRWjhuUnsDjOcXLTUy3p4g>
    <xmx:KfdgaUB1cCCk5uSZfZomuN7xslUTuYk9p8Vspt-FbIVYcTFZ1Xj0vZkZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:40:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 26abf4b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:40:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 13:39:42 +0100
Subject: [PATCH 13/17] refs/reftable: fix consistency checks with worktrees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pks-refs-verify-fixes-v1-13-3587dba18294@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
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
2.52.0.542.g9473a8513b.dirty

