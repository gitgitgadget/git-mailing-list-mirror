Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B81FE0EE
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787483; cv=none; b=qXe6IEP4RtsZn9Qnmtw2r5ts+F4cDw5YUE2JnBccEp98AtXfVKCCg7SM3houRVqfpaijwQfQ2IhlcOd5HZB/RbmeHCuu7+ssi+59aOhPpuVhvUbKwb3rLj2Ps/QTML33WfEuU+3kxIXLf3TjOaZ58HDxNS/bw2/lowGzfrgN1ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787483; c=relaxed/simple;
	bh=nzBCfE0uQtHPTfedz8g0girMrHWUDV8clALDP9Ln6XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePHM/ITG2QecUmLKP1yRsRSIu0jCfsavPHvY/qz4XoOSiJD4GLZ7R8mI6+YW9J8Yb6+cXcTp4h/gg7grSu6h+acIlCOrqsb0u6stuSpqrKz4KqbpjbIPNMdDFTwfijbdDqm2Ie/FpscW9+1xqXtVVjuWnP2GMHxYI+UFKe+34IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=01+lWVXa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PULjGNIT; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="01+lWVXa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PULjGNIT"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id BD2F511401BD;
	Tue,  5 Nov 2024 01:18:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 05 Nov 2024 01:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787480; x=1730873880; bh=HHoBFb33Wz
	5ywAmLAnRYaKiXTsJlEqx2TZ0vQR3gKg4=; b=01+lWVXaKNHIRXnQd/4afx2bMl
	6MC1WCQhJpaY5ziagvUaEKsY74fH9/YXI8R4Rzhu37eoBuOwafSoCmPsyAqXKUDd
	GMcFT2cXfKQMF3HUlQ7ThO/qQhCINPX+FKMjvb20ljuLT3K7Jqs6T5CKD3om2jyy
	OFZALH0X0bXBfgEDZ/+xnwfuWFLO1A4+cf7E1oo4H8RgHuxAboTuAj6IsUH7jjnB
	TaYNSsNe5y+3HMiGLVGO61OMRSz6drCTng5NDiStZKkkzV3CKUAYjiJA7wHeuUqx
	pNNAUq/cQdK0VUFvalXu2/ZAzJTcwLcyxT34Ml538fgfalU2oW3aMFayTnrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787480; x=1730873880; bh=HHoBFb33Wz5ywAmLAnRYaKiXTsJlEqx2TZ0
	vQR3gKg4=; b=PULjGNITNL46ze8/IhrVU083ECmHxzuKMXAnlAm6bddAG3hpTPw
	1X1EhYZxOQ+H8zNGfn/8E2b5JrxILtYCk8mvb1VQETbyoXQ5jXkNY7nPNkQtJPqu
	4ssh2Vz6iSQ/iEBosQ6H9+dBBYW0B9TzsjX3TLcI/F1+XKEFMkSC2Px0bLWFiptt
	QwP7T2WyfwYtDt/d5zeY46NomEEU3ko/YvbCdkvCDrACQnaPHCvKAEqmWffPY8G1
	gyoQ8GncmWLPT+IAP7BcKDU751ZOE+xATRM7qKkXTEKteQ0Wn199AOxgl+0y/UjC
	p6fcYQ8lKtrgTBA3bk+fnKqEHAFdWTB/9bA==
X-ME-Sender: <xms:mLgpZ53xy_2xqCyZVB-58C_gtO1uUb4uNMQfhuWqLTIU5d1I2Jswcw>
    <xme:mLgpZwEKm3UBjODhCOIMkqTBblkUGO7FbqO_pFY6WM_EObM9XzAicr4Oqzrj2WtFr
    9W8QX00Nqk-ZntFgw>
X-ME-Received: <xmr:mLgpZ56ATGxxDu_h2yK0VDsu1nFR0vqThghNmB_30B2i3EPq7RoFlqPK24G6lpk1kuFlqVPpRWC5rfsghMSMOQOxK7vax5k0zZPRj9P6c9Mxjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:mLgpZ20jrLKg6SvcvdOFT_KlN5xaLxI5gqRzyVLx6rQQY-57p2TE8Q>
    <xmx:mLgpZ8HH3iWg3jxmMe99Vm1UhryT5LmeNHdThxDinGmIwOJWO5BUYg>
    <xmx:mLgpZ38PJUx1kXFFRuTQgR0QsCfoykeXWH02fLGNWMDhgRYiDyY0Qg>
    <xmx:mLgpZ5lEZZXeSa5ZTw6491zjB0RU2CN2F0SwXZx_z9YkkvdXxSmMHw>
    <xmx:mLgpZxPJKqGVtr7IvQf6BxB-McDAdArG6tGL0tQ2riuSGp7kuIZd-slx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:17:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5caf40be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:17:37 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:17:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 21/22] builtin/merge: release output buffer after
 performing merge
Message-ID: <0ff65c1213b7034c35d80796800d29de5ee74b52.1730786196.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730786195.git.ps@pks.im>

The `obuf` member of `struct merge_options` is used to buffer output in
some cases. In order to not discard its allocated memory we only release
its contents in `merge_finalize()` when we're not currently recursing
into a subtree.

This results in some situations where we seemingly do not release the
buffer reliably. We thus have calls to `strbuf_release()` for this
buffer scattered across the codebase. But we're missing one callsite in
git-merge(1), which causes a memory leak.

We should ideally refactor this interface so that callers don't have to
know about any such internals. But for now, paper over the issue by
adding one more `strbuf_release()` call.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/merge.c                          | 1 +
 t/t6424-merge-unrelated-index-changes.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 84d0f3604bc..51038eaca84 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -754,6 +754,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			clean = merge_recursive(&o, head, remoteheads->item,
 						reversed, &result);
 		free_commit_list(reversed);
+		strbuf_release(&o.obuf);
 
 		if (clean < 0) {
 			rollback_lock_file(&lock);
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index 7677c5f08d0..a7ea8acb845 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -2,6 +2,7 @@
 
 test_description="merges with unrelated index changes"
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Testcase for some simple merges
-- 
2.47.0.229.g8f8d6eee53.dirty

