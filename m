Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F5B1B5336
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787440; cv=none; b=s+VbEP47kadXsz0PdHYFF7juP7dRT4RzQ8vebJX7XpvHDeXvVqQHXoL9RJKXsWXL8udwzeLi6yZIYaNdCZpgBW+DPJ4wFI6+LZxbGlRYY1DFH+w0YTWK19Hd6PXhrfuV2vkdixV0aIhZ0C3b06p0+FDD19NjE0Dl7DeTYjRwFlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787440; c=relaxed/simple;
	bh=AHj12aPbiHWS0uT00uKb8x1tEpfNZwM6VzMgIYEBXoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMYDDX+teSkUmbnmKwHqZm5UWqJYbluPp32b3DHm2QJ0BqewsXRuDI5sTsV5fmpEh9F2SJ8Wd/UQeKGFwmO7VKHvrhezhaiDiUzK4B9sSCwb7+NcVffIOxU1hMLAXj1ZAoFx7MkUdUiYyRaJ6qboyq9IGXuwj4SOJid8wjqqbp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PcPIyp5U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nLJ6wwLC; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PcPIyp5U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nLJ6wwLC"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3D18F254018A;
	Tue,  5 Nov 2024 01:17:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 05 Nov 2024 01:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787438; x=1730873838; bh=e+UpPi9o6i
	oJNhf/Hp4D4oNtN6bpU3HATOuD2XSABtg=; b=PcPIyp5U832Pl+LqeWcCNI8MIr
	RML7q7lp5LwAziaRRnEd5GoPjNjgUSyvB8av2TLW4lijIM3S63GJKHzQ8Js62C7s
	zDXkVRdmm4/4A4ApGWzfmbK8H0gT3azQeaLwRrfifuody+wZt6lrD9hDU8LNPd5M
	cqXRUKgCR6ct0yF0HZ/2i+Mqk4RHe90Hkh870ljKF+TmBjk5bExLJ1gqYbhOiXDq
	i+2SPbWCKTxZ1Gd24jGkPPAazuqrPxOC28pjZjkPmk8EjHSRbdMjfYBIQjjuxyFW
	HBnuIoI5xXp2ImbfAfpxvmiAki91RuIC7McIZPk3MCfVyT5NNrFOntHw/YEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787438; x=1730873838; bh=e+UpPi9o6ioJNhf/Hp4D4oNtN6bpU3HATOu
	D2XSABtg=; b=nLJ6wwLCT1W4wgEGcZHUkCs3Z0DPpLUVrG3OTOyCkAWw3Nc2uTX
	PZ6LnHQmjxiiK3z9H6x1E9jEprZkubAJEPLCdR4PPtqAJMf01aqNNhVb77tw3U7i
	69yyIix33cOOUaUtQJ6T42UPUVKeOuQubR1NxlwtgI8oqmpQgueBv345EJ54ODAu
	2INSNHzJemE0TuWSHL50c6cNxwjxpo3Vx9HqtyRyf414QnB8U6Tw6dnSVQMZ48Yu
	XoIJP1cN70eSs1YiFD9JRdd1pHs85M+i68/oW6BxcV3nmke0Ud/RMaYQygu1D1ub
	3DsSz7Sa2gaj4ju2IYQpwGiVeifD31c49dA==
X-ME-Sender: <xms:bbgpZxL3w2o-9_af8NrVMc8k8JxxCjR7gObanAKCkUOsetii8BfEbw>
    <xme:bbgpZ9J6-C2X7LxsqeZmsS41f6qIo95Em4tSqErHWYxKWERfsJyZO0JUZ2QOI6lxr
    7kmIcpaG6KlR_qhSg>
X-ME-Received: <xmr:bbgpZ5tPHR4rzneCYGrK_yS2wRvC3JqBkbSP9JH7GrbYeChHZbmnOKO4YV9TRkivU6jGiP3gpNNQ5mHIiEgzwt3b-3SM3L1nBQFa025T6M0V4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhr
    rdgtohhm
X-ME-Proxy: <xmx:brgpZyaTxzn-nOqrcHSoSfpT9kEZvWSb-3UvjEvt-x7ju_eC1dr0lQ>
    <xmx:brgpZ4aPeb9K9QICNirQ6YME5xKwhE-TtFm2Qr2GVTiEvXEvOmsOow>
    <xmx:brgpZ2AcI8Lpuk_6-GfA8RAfxayupruySmaLHHxIKlbqBE8KRwfPHQ>
    <xmx:brgpZ2bmjg-y94zj0TC3pAAPZAx_GbkWgq0HlL2nT606x5tT4w7Pqw>
    <xmx:brgpZ3x7qbBozim6aYQiy3gF_DrUIlcvjgOOObNWuSG9tf5mQm9gRvHN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:17:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f379c41e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:16:54 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:17:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 09/22] builtin/commit: fix leaking change data contents
Message-ID: <f66fa4e0e25b0696c0b52ebc765a5dff18c8597e.1730786196.git.ps@pks.im>
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
2.47.0.229.g8f8d6eee53.dirty

