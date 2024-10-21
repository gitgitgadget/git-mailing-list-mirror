Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01B01E32D6
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502904; cv=none; b=QNdJLtm4o8eYKg+N11fkrQ9f4kPEs07eEN8aGd7Xs7GEYm+IbV6WIY6YPmchR+zC/LM583lcXEp+qbhfuobXIZVOTV9kHDC2CiDOS2fosgewXE3plEBIO1fjCY4iqhIr48YCK7iGpl0oss6cr39fRbeeA7nBQy/3Ek63XNbuGtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502904; c=relaxed/simple;
	bh=r+s9b7ltUxVwbMsWnkg5xwXA8v3ggAoRifCuLqZ7Ju8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWbXCOlIY/RCgmvuj/pXrhoEjapGPc4BgLnAAgOPFo/6dUmu8dYx1gdPlnogDjQWsc0d7Bnx1S3YrW0M7sXc+8R/4zDU59NCaWqkud0iS4Rb71jl1McHBrRznxYH/+2//2z238B5OErDjujqBkIfZRUuJwAM5tfin0KPwc3lK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dodc0BeR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lOO5nrXa; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dodc0BeR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lOO5nrXa"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D9A61114022D;
	Mon, 21 Oct 2024 05:28:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 21 Oct 2024 05:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502901; x=1729589301; bh=VvzSOmwyow
	gBCDSs6/DGkUvJZCffkolLEO2myq3vzMI=; b=dodc0BeR0aszJrhNMF4oPAAMfr
	71lHEhX9WjNb0w6uMJdfFDP5quYDCtAd34Sm7jrVk5+XCJvCe6nreBoP8nX965Gh
	j474/CFl8Q14MIOWF/aQE5FkpSQfTcg07VYGDr5jitJEpvubCnVq+yNlOTjPAIxR
	tFRURpjKJ43RcX8MEGZrlPgDvk2KH1bd4WJxE6PSUFtaVUtiUmWIBsVPS4W5gRML
	TAewzAREAuGEVzbDaoZhmM23bgVfNfgXdUYfhmqSfEzZB7qOg63jMsed5/8amDBI
	iqR6clE8EzojwH+w0jO2mnsYD3LFtx6UJGLiCDZ8ExoDN5VIm3isbFTxVZBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502901; x=1729589301; bh=VvzSOmwyowgBCDSs6/DGkUvJZCff
	kolLEO2myq3vzMI=; b=lOO5nrXad2fUsiZ8ZwKZ0EIckOj7YwFT0Wgl/yf8fYSf
	Db1sKRbtHZAOwyoRon5+qszy3epMxuJ7DbQ7a8/9syuhfRDdMLsBhDyNe8vqNnov
	UTE0BWiPYxGtHRY4lIAahOrDLzJMHmFwxsDWzWELuYsj45FC14Qu+FU5DO730/dE
	We4bKCQZzPrKnpWGPTEDbv+TI4aNu7YZmj1q/8lp0bOnMNT3CSeNiDTzOM72pRpZ
	TfkgkUaACGUvLuT7J2Lpd5xarMqA/1uDH0wGm4h+xh7DgGL1Ig1bKBa/G8eZi7aq
	opW0SaCt4Jhq6r6RP1Gp1DtOnKOBQBmvCkES2+NMcQ==
X-ME-Sender: <xms:tR4WZ4mCkJA7vt87cCE7EoIE9Dd60lRqinta8enq63Cgg1ERxmWTcw>
    <xme:tR4WZ33GEM99e9W8QESDWUNOTM4zaGPU2LFT77SA6F2eDehAbQDrGl_6I8Pfw5Iry
    rQn-Ld-qXfYzjUzTw>
X-ME-Received: <xmr:tR4WZ2opFZU0xx-5kaawcNBWDYV9b_WgTUUsnqYD4IP9FnpMYBGc2sT1dGPENGukmdQt6PufXTK7kYJmWkheXV1aEBBeGaBphdDYFXQVZH5S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgfefueeltdfhfefgteehfffhffegieeukeevteefvefg
    udelgeegueevudfhveeknecuffhomhgrihhnpeguihhffhhophhtrdhnohenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtoh
    honhesihhothgtlhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tR4WZ0lK09sFVeW8TDv8lyzxMS0G3d4mFC8LZkKh87Qt5DOvXM6XmA>
    <xmx:tR4WZ237Q3OH178XtsOifeJ-qJemuKxW7G6iFAfr8ZRcC9P72HOweg>
    <xmx:tR4WZ7uXOPdrxO9GriOT4fiRhaHA3nMiVqeV0b1H4k7oEPWMQR6jGw>
    <xmx:tR4WZyUubJjkRoeOvSkrC_9s3yGRTCqn72AkEqBGZ6SU35CCJnPJWw>
    <xmx:tR4WZ7wZOP36SlhK-l9vgwDmy51MalA0LRnC35_CQQhI6MyMnen3H6d5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:28:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6b97451f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:26:53 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 06/22] diff-lib: fix leaking diffopts in `do_diff_cache()`
Message-ID: <60af98cb2c7752edc7cd5c5fe8173dc5b2522a7b.1729502824.git.ps@pks.im>
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

In `do_diff_cache()` we initialize a new `rev_info` and then overwrite
its `diffopt` with a user-provided set of options. This can leak memory
because `repo_init_revisions()` may end up allocating memory for the
`diffopt` itself depending on the configuration. And as that field is
overwritten we won't ever free that.

Plug the memory leak by releasing the diffopts before we overwrite them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diff-lib.c           | 1 +
 t/t7610-mergetool.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index 6b14b959629..3cf353946f5 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -661,6 +661,7 @@ int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
 
 	repo_init_revisions(opt->repo, &revs, NULL);
 	copy_pathspec(&revs.prune_data, &opt->pathspec);
+	diff_free(&revs.diffopt);
 	revs.diffopt = *opt;
 	revs.diffopt.no_free = 1;
 
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 22b3a85b3e9..5c5e79e9905 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -10,6 +10,7 @@ Testing basic merge tool invocation'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # All the mergetool test work by checking out a temporary branch based
-- 
2.47.0.72.gef8ce8f3d4.dirty

