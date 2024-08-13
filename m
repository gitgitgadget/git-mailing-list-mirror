Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33032189BB5
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541535; cv=none; b=uHx1UWg7lG8upVvwn/rcOuYAgJuGJb4AuBCxfKbLYHuyWS+w1Tg7S+L4peFEBSXtoymbZQCBCPhveg5T1pKGcJ+P00MFvcq4aeTrFAskoZRBniaB2aWUv5Dt+D9pdtDWPURU9tw+2Z4/GyTkxFHAjgNAu2hBtGJC/0Hr731VS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541535; c=relaxed/simple;
	bh=1M5HVRtyZz4evMWV31VObitmbOnwVwTNwgWt+z1nXjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fspGd42iv1qr2GNiVO1R+9N1UNjbk16puHdNVl56AWkGECvq96CRhiarJf91N4L1BhMnrHCZXYqC69YOnKVUDaJyXHy4nij++CFC0XmzFovyO7y4+ZgQPxuCczCmGgCJ13aZfkCTiD+JL+4LibkpYK2IFjqQNjdXkOrMpSUvVLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Znttx6ds; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZvPDw0hb; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Znttx6ds";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZvPDw0hb"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3DC6F11518F9;
	Tue, 13 Aug 2024 05:32:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 Aug 2024 05:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541533; x=1723627933; bh=mmi0yNNyJb
	C2zwSx5aG2d1QP9oODEFYukuC7p6GJDJ8=; b=Znttx6dstAJF/eG/jCHsS7jJLK
	JsTc6ixUwSFe1kl9KLT4nAUwlPmLRxkdf4q8+NcnAz0Hi8n8mTRPcxJUCeDbIvNQ
	bumFfjZwxV/YoDvlmoiCCrcYZOWgJlRqSe8bolTfTbzSIBbDsme8EcrEflJwqTbq
	c1TM3DBEzlauqkKTliuaw3xBz/MaOSCWZB5iMTZ+mq1enJsK+oHKH5S46QjQMi9b
	nYPf+RD6sqEr8Z8DPMby7iUYW9T142mF2hG4kz/PLbDMHaGrkgx+AGMYcMFCGjcH
	01JyAPx8Urkv06xoEwM3qckmOXkAs/AXeoIeCJ3gNJKq1nOY++kQKCzjLwyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541533; x=1723627933; bh=mmi0yNNyJbC2zwSx5aG2d1QP9oOD
	EFYukuC7p6GJDJ8=; b=ZvPDw0hbUv4CY9kpHHLPjc7G319Ysk1AAHreoq0FS17L
	wnfKCh6Q1mETCtW/mwOgQ5703XMECW2K+8qvc6UWz5BZQtgF8L7V8+OOs7vJVPA3
	ZHJJep0+PXuMT+HrpYBd1qjsb6VRMj2pgSTaeOgwq76ZlA0Nk/YQ29vY6WD7qgfh
	DQ6TgZe9MjOHj72aS2qVIiz29UQBP8Tp62RqfiOw1Gz6yO9vZPG06ll2t4B4NgIf
	R0zLv3yqoGXPE8Hr90JvLa57ZvKcdMm9ASLLAv5aAOB49+SuZx93dblhymOXMg3j
	S1M7c+lbTTOSnsvCvftbk63EoEthpseSI/rPipT4nA==
X-ME-Sender: <xms:HSi7ZiaFgTUMmI-ycrb_x7xQ-uO2kpeXoG8GRTSuj9VPO7avrEZtgA>
    <xme:HSi7ZlbxwyCeMekY_gfkU061vr17B36nQS52ieLKrBySi5OphhpEXG1-QOrwHihoD
    M6PFpwnWLyncspC_Q>
X-ME-Received: <xmr:HSi7Zs9d6QT99nt9Q9BPjLtOWoJ-WsGFAPwoaptuMSWXTDhaHmOm9XC1uTxY8DKMyj3_HLYdOG_8XiLe3mGj9RFbV9RvCMSubGrKBYrnWd_jCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:HSi7ZkpXXAMuavIa_cIkE2uO4_lejBJ3N1gAlOrWtEtazquHYmNq2Q>
    <xmx:HSi7ZtpqOUUTATMkZQm3Bau0Sp0cMaOlHExNdR7oKORXFo8MOAW2yg>
    <xmx:HSi7ZiT3UB07Oy7heq5cH7n_owXyBLfhBkmRFGnMb0pqPapf751t7g>
    <xmx:HSi7ZtojUbn5Y-OqT-tkzzELvu6FlhR4LaJcMNw3gKf-A8bTd68axA>
    <xmx:HSi7Zud_ktnjg6sRVlXNqB4kjoQnVPaiD2NASoM_w6zhjlohy_sDcXnU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:32:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f0ba96e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:31:55 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:32:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 20/22] builtin/log: fix leak when showing converted blob
 contents
Message-ID: <50dea1c98a207498c5c48e1fb9eb63ad15960e6c.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540931.git.ps@pks.im>

In `show_blob_object()`, we proactively call `textconv_object()`. In
case we have a textconv driver for this blob we will end up showing the
converted contents, otherwise we'll show the un-converted contents of it
instead.

When the object has been converted we never free the buffer containing
the converted contents. Fix this to plug this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/log.c            | 1 +
 t/t4030-diff-textconv.sh | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index ff997a0d0e..1a684b68f2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -707,6 +707,7 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 
 	write_or_die(1, buf, size);
 	object_context_release(&obj_context);
+	free(buf);
 	return 0;
 }
 
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index a39a626664..29f6d610c2 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='diff.*.textconv tests'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 find_diff() {
-- 
2.46.0.46.g406f326d27.dirty

