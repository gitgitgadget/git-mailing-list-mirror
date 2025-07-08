Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A452F2356D9
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970002; cv=none; b=MF0RPsnVbYDEeJH+quduLKzUv7qGUIHPtQ2ytoRSBujURBnddVSfodEg+sIdUMypwE3dNj8PR5h/npUPFUVyXl625rfPcfK3L92MKv3uC65sqOlEknpzhlKpJjqyS1TpiFODVUyFwfkZvjmGepOsPeC2iBDVXlpVZsKEWllf/xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970002; c=relaxed/simple;
	bh=YvInzDr1/ahIMLvfVO75K57e39j8osi3YAT65Gq/ci4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NSN830BwtilOAlBzS+iw1khpiHNHxen1YuJAXJaWqLpEBJCCFsfJPPNSN5CZQt+THdlE63bNqMi1Yv6t2n3GW2gShyo7Z+8mUtO5aYRqHo4c9PuW49hNnydYHmCUIPAnkNxOQlTYKOC+ixt/+GkfQNgmbp84TJckOjuxqDOVmOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VaOe451P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JUAwP95M; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VaOe451P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JUAwP95M"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A245814003CF
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 06:19:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 08 Jul 2025 06:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1751969999; x=1752056399; bh=L+t+8fHnpW
	AlI0W5CCx6afDCRJ190oentCNg876Vl6Y=; b=VaOe451PVmkeSd/SaxbwrZ7fxx
	m3sr0GWGmOoi1WuwYjUpaygUEEiaptY9wQYsucsmpE6nxO7ZgEyBVl28bQXw3Gaq
	/7xDT1//pdM+GA8MOPRymlRpeG2NHBjyNIALsYCqvXD7cX5WMfV0O/XU/Ihmsopa
	9dGTYNH60p2gBRx9NC9w+gUGCNaTDsCZND4kBXoxivTQhxR5mWewMJRYyW7BhurL
	SouckdHjEtFqDarnXF+p799UxgvJsa7sB+DXBPHxh1uhsJOHyxoSdWyO/uOIlAde
	etuuxqh9q1OII4qC52qrFLDxSrY6o4bRzYJAbeusrSyg5iSNOtxF5RpHIuDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1751969999; x=1752056399; bh=L+t+8fHnpWAlI0W5CCx6afDCRJ19
	0oentCNg876Vl6Y=; b=JUAwP95Mf08r32CjQ/aF5QKJwyWbsCJUAezuRPJvAVJF
	jzzifssCYjyj9JyGGreWNgcIwyfJ3PkvSak70c0ssXOrmefP6NmOuRFcFmSzCUnh
	WZgyHqh+7iASVpbzXuo2yOkMkmt3iv0sx5Bs/UR/1EH4jmibR3T1uAH7X1cOhFYQ
	4eluLZehLR7Hd3sTY5pX2ULVpWuXxwPra//yQ2y22RI0beGt09iwF1Ny2u6tFUy8
	MG5CiR2PEC/92oYcehAAOQHHODcyQJ6g8+5gwbFxlQiwEbuSnBDdNtmO9bw6B7T/
	Yx5fqxIDVvQRkjcDr4zFAoG+t/dC/8vfTIQuLWkwnQ==
X-ME-Sender: <xms:z_BsaOY-NlGVobvL_SQZ2rBxsjAa5N_ypjus_oHD2ZHjc3lpzwwm9g>
    <xme:z_BsaDbXxTy0N1ToVuNxNX0b5BZv7l6RJL0sCERCFZOPsz2K95AWXSVMXwxzKI7Bd
    bxbyJk7uuXxWEWD6g>
X-ME-Received: <xmr:z_BsaCWn1EH91pmGDCCrVIgXrMaQGM0dJrYZ-EFM87GPgnPsqqHYaI6vf-fjP_Ln2tDK5Pr70GtYfGNAtOEt-v3-XJSErdYpK1cBIGc_3kc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkffvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeeigfeitdffffdvvdeuheehjeehheeludduhfehke
    ekgeeggfeuffehveegteejfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:z_BsaC1e9-IUHeR1es5e7zAHNG49CaZY1n_95boCbDcLWJVfAWhvlw>
    <xmx:z_BsaBZ0Fnthedksx0EqiRBdUH5Rqj312ZrvXfQ6k5iEECY17AIY3w>
    <xmx:z_BsaNo6IrzZvBo6GjbmfBF4AntFcHkT-Qn-e-HNXv_wNm4ajGNEoQ>
    <xmx:z_BsaFqK_gAZTBbHDEUwnG7P_Iv1hKjB8aiUvQ58JIWCuS09YyCDsQ>
    <xmx:z_BsaFxoGu5j19Akl0TORZJUohTz5PGY6LTWmsKdIVLploWz237oDoMH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 8 Jul 2025 06:19:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 076d48aa (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 8 Jul 2025 10:19:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Jul 2025 12:19:54 +0200
Subject: [PATCH] refs/files: remove empty parent dirs when ref creation
 fails
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-b4-pks-reffiles-prune-empty-dirs-on-abort-v1-1-3bae02e4f034@pks.im>
X-B4-Tracking: v=1; b=H4sIAMnwbGgC/x2NQQrCMBAAv1L27EIaLKl+RTwkzaZd1CTsVlFK/
 27ocQ4zs4GSMClcuw2EPqxccoP+1MG0+DwTcmwM1tjBODNiOGN9KAqlxE9SrPLOhPSq6w8ji2L
 J6EORFfthct4l6y4hQuvV5vD3eN3u+/4HLferUnsAAAA=
X-Change-ID: 20250708-b4-pks-reffiles-prune-empty-dirs-on-abort-15c7a7f279bd
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When creating a new reference in the "files" backend we first create the
directory hierarchy for that reference, then create the lockfile for
that reference, and finally rename the lockfile into place. When the
transaction gets aborted we prune the lockfile, but we don't clean up
the directory hierarchy that we may have created for the lockfile.

In some egde cases this can lead to lots of empty directories being
cluttered in the ".git/refs" directory that really serve no purpose at
all. We know to prune such empty directories when packing refs, but that
only patches over the issue.

Improve this by removing empty parents when cleaning up still-locked
references in `files_transaction_cleanup()`. This function is also
called when preparing or committing the transaction, so this change also
helps when not explicitly aborting the transaction.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this issue is something we recently discovered in Gitaly. It's nothing
world breaking, but I think it makes sense to try and keep the refdb in
a as-clean-as-possible state anyway.

Thanks!

Patrick
---
 refs/files-backend.c  |  2 ++
 t/t1400-update-ref.sh | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bf6f89b1d19..00128f21832 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2760,6 +2760,8 @@ static void files_transaction_cleanup(struct files_ref_store *refs,
 
 		if (lock) {
 			unlock_ref(lock);
+			try_remove_empty_parents(refs, update->refname,
+						 REMOVE_EMPTY_PARENTS_REF);
 			update->backend_data = NULL;
 		}
 	}
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index e373d9108b6..c9893f65464 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2304,4 +2304,23 @@ test_expect_success 'update-ref should also create reflog for HEAD' '
 	test_cmp expect actual
 '
 
+test_expect_success REFFILES 'empty directories are pruned when aborting a transaction' '
+	test_path_is_missing .git/refs/heads/nested &&
+	git update-ref --stdin <<-EOF &&
+	create refs/heads/nested/something HEAD
+	prepare
+	abort
+	EOF
+	test_path_is_missing .git/refs/heads/nested
+'
+
+test_expect_success REFFILES 'empty directories are pruned when not committing' '
+	test_path_is_missing .git/refs/heads/nested &&
+	git update-ref --stdin <<-EOF &&
+	create refs/heads/nested/something HEAD
+	prepare
+	EOF
+	test_path_is_missing .git/refs/heads/nested
+'
+
 test_done

---
base-commit: 41905d60226a0346b22f0d0d99428c746a5a3b14
change-id: 20250708-b4-pks-reffiles-prune-empty-dirs-on-abort-15c7a7f279bd

