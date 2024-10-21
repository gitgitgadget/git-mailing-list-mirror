Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FDB1E3DFD
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502916; cv=none; b=M8S4NjpKJyQGFDU/G4xCbeETt5ScRcSMhExvugv+trmtUcr4jY7ZQ+k7EKFOclJ2Ujfpc5o+D2dNIeVZznQxgbHQr1iHWUJW7nNZpDtzQvi8kCAqajwLKCqBuFMdskzX1EuCY9CosIdOaoBpzN8SPwSTEogSX7QpnIuoxfy8qYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502916; c=relaxed/simple;
	bh=UAKYrUcbROlbaNp+ykPMLh1L83mFuRHVfn24qzLc66M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/216S3iu5YHg70AH6DKD3B7cFGvgxtYTKMF3KNGo/r4DCmjGImpMATwUYcQERVyRp7TJDMyb99CfpAYbL2e0UHVdytdUJvyd8x51wZqp1fw7PSI0Hp2ZtlhwDZF/ukRMSk4v/WNYInuLtaAlmCOmy+kp3lyP+xDlA1brEprAkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z4KOiF8H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nn1ZMPsx; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z4KOiF8H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nn1ZMPsx"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A6BA7114022D;
	Mon, 21 Oct 2024 05:28:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 21 Oct 2024 05:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502913; x=1729589313; bh=YZ+DYH05ae
	/nJ39gNtsyfX3NXOH71MzlD9cKXEaoFdQ=; b=Z4KOiF8HY5nNWLywCCUtOb5OqW
	tRwdM9SJxV752QwGgaDcWnyCkfgN43Hqq2ksx5ChT5N8rUSMcGbhYD7PXyvgD7w0
	2Fltx26Nb5XtXqgIWZaToXsxZEDZZtHaSpPW4c/u7Mx97XrxkXxtU9phjrDh0Qrk
	FdTckSyWvOikWEALwXT25akQuvv+kaSoFg8S6rLpZhhYlx+oAGRJSl8tv8fOhRFN
	h30nxCDt7roJJhp1tt/POzpbsqILxUG/bqi79RJ0fjq8Mkcg4Mg6LvCVDfG8Wk3L
	546VbP8G/CFxg+KFKyu43oTC68TBMrQSmn3l2owL6DQSYsJI9twtn6enKRWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502913; x=1729589313; bh=YZ+DYH05ae/nJ39gNtsyfX3NXOH7
	1MzlD9cKXEaoFdQ=; b=Nn1ZMPsxuijzVHLBPaRZpQ+IkHkqT9wp467JAP7V9jKl
	d1g1cTzkk982wvppE/mRJL5vMMmwwMYCg1dnWJulhDo8y2n5yNH40EGD1f22UWRO
	kKYU3I+qdljOtGLuocP2a1GDiSO2QLeOtC+aoc85uO6kkcqjDhmGLl4xJ1F+m8el
	VoS+UZMqy2bV+ZFpZnwIiVtAzM5qcEV8Dirwossmt5GV9uwLz6lYXW15Kgk3TTX9
	jZhlpWBmziQOtQBCHgrSWcYt23pApbag6xzZQ2r2bM8Ot+ITO58iWannH+EVWoIG
	aRPJDirfQRDXLMUngXYFNPhoAeatR/3thGMnNqJoPw==
X-ME-Sender: <xms:wR4WZ5pTDlJ0D2csx1TiUtlJ8gzsHJ9dW9DtffoKxTZENWBRnTlOEw>
    <xme:wR4WZ7oQJLXDb56Pf5FWSWVXTTlraqf5DmBzt5BGo28wGpXZiX09ALFEmoPuy0uJ5
    tVOtxubpBmmmPejpg>
X-ME-Received: <xmr:wR4WZ2OTOjaU4LiK_TvcieuxchkiDLG6vf8P5sOHJEVCoiPn97M7iVCXIPcVG0IfgbOh0jsn3ZWzK4PzvykS-mn4qyuqSKnP5AL3-rlheX8a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhm
X-ME-Proxy: <xmx:wR4WZ04fg7Ufzyl50KyfVAD1QTAP6VAKtXAYF7Pj-cIwD6HAEia4Yg>
    <xmx:wR4WZ44sINNa4tb2rHkXDrgsfSA71RplK7djTu7_ePuXXZeo1Z6DUw>
    <xmx:wR4WZ8goiYT4FqdUKpBEkjGNx45zxsPnuUbXcrXWQ8z3QNwNaRZdTA>
    <xmx:wR4WZ66eByTb9ioKFNlppkNEYJ0Z7yQrp8V_Nr631NW9sdis6dRdmw>
    <xmx:wR4WZ2nfkkifsnB7sji3D6Y3An9W46-nSPxubYJSdamhsmmnSIYZ9Dad>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:28:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c6ef4b5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:27:05 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 09/22] builtin/commit: fix leaking change data contents
Message-ID: <9f967dfe5d55ca7150bf3e118279388290f7d28c.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

While we free the worktree change data, we never free its contents. Fix
this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit.c                          | 9 ++++++++-
 t/t7500-commit-template-squash-signoff.sh | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8db4e9df0c9..18a55bd1b91 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -728,6 +728,13 @@ static void prepare_amend_commit(struct commit *commit, struct strbuf *sb,
 	repo_unuse_commit_buffer(the_repository, commit, buffer);
 }
 
+static void change_data_free(void *util, const char *str UNUSED)
+{
+	struct wt_status_change_data *d = util;
+	free(d->rename_source);
+	free(d);
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct commit *current_head,
 			     struct wt_status *s,
@@ -991,7 +998,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		s->use_color = 0;
 		committable = run_status(s->fp, index_file, prefix, 1, s);
 		s->use_color = saved_color_setting;
-		string_list_clear(&s->change, 1);
+		string_list_clear_func(&s->change, change_data_free);
 	} else {
 		struct object_id oid;
 		const char *parent = "HEAD";
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 4dca8d97a77..379d3ed3413 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -7,6 +7,7 @@ test_description='git commit
 
 Tests for template, signoff, squash and -F functions.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
-- 
2.47.0.72.gef8ce8f3d4.dirty

