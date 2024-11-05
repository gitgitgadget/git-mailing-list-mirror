Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700841F754A
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787429; cv=none; b=Skl4mbO98IBi5/uNeqnF6F12PXy+m7ugBvf158lau0wcVaY5hfugeuvGzwRJbgFHL5WS7mIxbrjCV/bO2cUIMKIeMGs4GD9RwLl3HDlQm1DOlnXamTmHEkk1UGLn9sFgUutZU6bUuv4PqHgzir1yiMZeFoGAAIEdE1NHmpf5tEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787429; c=relaxed/simple;
	bh=kneY1QSORzARx5Ng/w+RbzYBwGdX4fkj937wxi39PqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcgLY/7L0uSyuZlfXEY9LdRrkSgrc9nI73ZGW1XQ3Kp4vuB+D1OlNSxRSUAXN8HUOsbkMgU3tX6BMxoIsKpy3E01KU10RlJmn29HiRSUc1Kx0UapoBmRZF7sJEm+7v6pNntLjqh2cdJPat8WtiUfi4ic/bzF3Nv0o02218wBv38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OT25LXCq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nSwywtWN; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OT25LXCq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nSwywtWN"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 6F5061140162;
	Tue,  5 Nov 2024 01:17:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 05 Nov 2024 01:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787426; x=1730873826; bh=5jJ1K5EsbA
	HNvVPvIVNIaiiBV/BkQeW1zHmtuZxF8H0=; b=OT25LXCqBTzGXy13FDmb/YfLiW
	hHrTK6YZ1kCuHhxe1vmDyhcuSs7w3PeQHtDQvg0ltXHVCyMBVC6Dku3DziZXFl7+
	m84KMJaxX2xuEO+R6OpRBZCkBkKx1EJcLSyvZv8s46FVANU3z4qVbrdA+MeL/pCj
	UQUNTJxYWjgItRZWDoas2GCKQnEneN43Nk0gUeNzhYtNOaBkq5T37/RxIZLY5qFC
	PwNG09rkxeNphyA4gFbocVBC7YR7w4BbUjswFqlgOI32kkXKn/TE2UiRSTRq+Tp7
	bgFkDjJ8RuTH3Tcdq7QK+pxmo4Wb7aH2eATuSNxQpAfrXXIdAk0Mj009Ej4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787426; x=1730873826; bh=5jJ1K5EsbAHNvVPvIVNIaiiBV/BkQeW1zHm
	tuZxF8H0=; b=nSwywtWNTZUVzOUyUmlwpfrj0liYPzDQFIYw1t9PuKV5J0deJfR
	f6iK2Kq2sRD1l/r4bneJ1JJhXAYfthpCjKqzizyF4zS7AvAkH3Hr+mHSQjYIp727
	DWnCELbp4qAe3V5lryLkl2wc7M3+TAB/kL2+qpR2UGdcSCNA3r4tHgXxRPj3iyRM
	IFGWwo/II41LBXs32xKUa2zsSc1WnIB7Xhto3cJVNrULOq3tojBW55hQc4SNUSFa
	NXs82V6h+KuxwM0ptH1nb8+jdgeWEjjwyqNz0IW/xs8dM8cY47D5qDzqbeHK+O1L
	x4apJs30Z0O1wljOE3sUVVA4iayBQ4w2ogg==
X-ME-Sender: <xms:YrgpZ2-ON7WrTkwvBeSiF_4JEaxyn-h6WuqSf-OFiiMzuMSrllJSaQ>
    <xme:YrgpZ2t76eqRtRJLjVGvh3s1vAK-2QxD6i5PJy-oZrhxmyyKlk2qFUewgojBM9JWh
    6uT465_kj_ebty8Fg>
X-ME-Received: <xmr:YrgpZ8AGUFLCKOP5TPIIcf6mASlRfKWSNe0fZ_Adtiy_Rs1GRuFkY4LaJ2rthfpBVQ47ciZDCDu1QusJUBVdnjJvyiTLi-DHfHGQkwQSkyrk1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohho
    nhesihhothgtlhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhr
    rdgtohhm
X-ME-Proxy: <xmx:YrgpZ-fLBvBI1U_JANTlWitWk9OQLd2uyFLt8Q-SIzyWmPuUOly3dA>
    <xmx:YrgpZ7MfTtXiUTitKzt4vHblkX5XCjlr8XO_EK--X8CJbfvHDPGGHg>
    <xmx:YrgpZ4ntqPbcuumvZmHibPxtw54XoHoS5apzNEsKKFaIQOMtXHuKtg>
    <xmx:YrgpZ9vKPwY1lUPSBrJQ_XMiBQ2I9bUJv7klNVZAwuPwioNckoOUmw>
    <xmx:YrgpZ20oGJPB3McZxrGDLJ-M0kCVL74nj8eZ6698713i-pdm1SphHmEB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:17:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5b5f4c55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:16:43 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:16:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 05/22] revision: fix leaking bloom filters
Message-ID: <aeb8a19d28d28e0eb1a80b0969eff7621f381a9c.1730786196.git.ps@pks.im>
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

The memory allocated by `prepare_to_use_bloom_filter()` is not released
by `release_revisions()`, causing a memory leak. Plug it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c           | 5 +++++
 t/t4216-log-bloom.sh | 1 +
 2 files changed, 6 insertions(+)

diff --git a/revision.c b/revision.c
index f5f5b84f2b0..8df75b82249 100644
--- a/revision.c
+++ b/revision.c
@@ -3227,6 +3227,11 @@ void release_revisions(struct rev_info *revs)
 	clear_decoration(&revs->treesame, free);
 	line_log_free(revs);
 	oidset_clear(&revs->missing_commits);
+
+	for (int i = 0; i < revs->bloom_keys_nr; i++)
+		clear_bloom_key(&revs->bloom_keys[i]);
+	FREE_AND_NULL(revs->bloom_keys);
+	revs->bloom_keys_nr = 0;
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 3f163dc3969..8d22338f6aa 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -4,6 +4,7 @@ test_description='git log for a path with Bloom filters'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-chunk.sh
 
-- 
2.47.0.229.g8f8d6eee53.dirty

