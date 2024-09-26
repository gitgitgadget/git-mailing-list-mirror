Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA24717DFFA
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351185; cv=none; b=EmU7K+bWaXf3iD/eqIqpfvR8RdsCqmTDW+soA1QCGAJs+/jZ39TrRC9ez+Q0LsNcQHydhkfqCX/GXlWSGtvXRA8N7sNcgoGmnymSuDKcx3YB0kjO1PAB8j+wW/qMmvLNAhbdi51Qde+nFZIRnflicqTj7k7HIFSZQjEQ0gpuvoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351185; c=relaxed/simple;
	bh=c0gLBYicabY24G8XEXHPL4fSlX1bzMv/kl44c2dJ2yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dex5pFtzpO0z+RqMUWOq3OyOA73Z2PrXGFKSHoXDnzlV4VRRcqLldh1d7OCU3FS9SJHENKe+XrpalxaEFN13qs3niWRp/YLj581flDvQNQdLp0HzR0/zVkMre3MRyq6VZQQH801/3hFgGPByWgdpdhTM8YysJaJhPm2+wG2fi08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZNrfWheQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OObAVtMG; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZNrfWheQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OObAVtMG"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B8506138067D;
	Thu, 26 Sep 2024 07:46:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 26 Sep 2024 07:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351182; x=1727437582; bh=i5CpnXiF8L
	Gggi3liHGf2ZjAZJLvB2W5QmTro5BDBvM=; b=ZNrfWheQFJwzSCKvdwMoz2kX+X
	2sBnNkLshATxnpbzUvmdseZcOIDEgdSiY2ELjYE1REoP6rxCNHUERazcXu1BQcDh
	w8I3jpIsRVlx0Ed85MchQsd6D4UsScCQO1Ptt70lElvoA19OIujz/zz52LQdmpGq
	t3UVSQqrpFWbrToAqfe1+pw3ce0N6P8qC6VKDEedX0Kxcv1xcMKCXoHTKoUjhKnM
	yU1AMugLPDqY3rmJnUqTE+Fho1CXZ13bT8Xyzs15x97vC5JNk3lzBIonDUYwbgeF
	tV/pADDPjR/BgrUpHapFXCN6uyXXTgnoLF37eevp4+EMGLC5/p9+KYiPiCNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351182; x=1727437582; bh=i5CpnXiF8LGggi3liHGf2ZjAZJLv
	B2W5QmTro5BDBvM=; b=OObAVtMG1kIDncplgts+bx7MUpboU82uFK/OScAfKXHi
	E/OVnQ648Z1wzXttiYrcmfplT0PkUQswJinFqN9al/KfuQ7h/Iyo9CvJgGgUhkAm
	Qgp6CnY7FlQ/nEpnCvCjfIqfdboSt4+i9eiu1P4v8xprz/GfINECbKqxPAWexxip
	Z4s1eMUa7bII71MkInmwGwx+EMD4OzHGSt2pRRxJ6Oa7x2NL+zICMfHXx16m28ji
	bW0dIixXO3Y76oLcTK6W7bOibHSM20xhZ9LnKIqDONsWFXE62dscuFcyIsEko+T3
	9bLCVxv6KUcPG3I1dJ9JHJ1C0Ka2/7RqaKx2SxJBbg==
X-ME-Sender: <xms:jkn1Zm0RjXV-pbaXMVa9iUzr25C9zzCKZ8FUNv6nvVeoSz8zSjFgOw>
    <xme:jkn1ZpF1KqlLf1qDz8zApN0G04TIvm1LUzTscADi635eCNLcMAG2yIGLe_MPSvV8l
    1S3iajKLkDjVLBfvw>
X-ME-Received: <xmr:jkn1Zu6swEPPmgYMWhXmQXr6kNyOEuy1qeYY785QarsvIcbnFVM8QvZdr5rmAkwTWOKkderxVu9yt7JhHZzWC69irCfNYgZbj0HY3vqr_xpFow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jkn1Zn3hsgiR2aaADymGW7EFBXtdK6RRr3yUjJjphSI22RTKYbhHGg>
    <xmx:jkn1ZpEUQOxBysykUOr_D6kK_tcHTTNTxZjUnvUzH4KgQIJYe5eEPg>
    <xmx:jkn1Zg-kVV5k5Ua1EjFmrxt5m-HI_Zi0etcNlZRsoD3mHEu4ZZ3ydw>
    <xmx:jkn1ZunlTc7HKv6PtWVz_LwX8KnEBpFtTyqO6D3ln_RJz4tWtRUeVA>
    <xmx:jkn1ZpDcwkZwjqTCG2IipfmuERqR71rGYoLoDST2SqBYx21DQqK1b-wM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3c693832 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:45:44 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/23] t/helper: fix leaking subrepo in nested submodule
 config helper
Message-ID: <96bd7f01d5d1800a0d0520c0d790cc524e8b4c8c.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

In the "submodule-nested-repo-config" helper we create a submodule
repository and print its configuration. We do not clear the repo,
causing a memory leak. Plug it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-submodule-nested-repo-config.c | 2 +-
 t/t7411-submodule-config.sh                  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
index 6ca069ce63..6dce957153 100644
--- a/t/helper/test-submodule-nested-repo-config.c
+++ b/t/helper/test-submodule-nested-repo-config.c
@@ -29,6 +29,6 @@ int cmd__submodule_nested_repo_config(int argc, const char **argv)
 	print_config_from_gitmodules(&subrepo, argv[2]);
 
 	submodule_free(the_repository);
-
+	repo_clear(&subrepo);
 	return 0;
 }
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 31271f8e0a..af0de496e0 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -10,6 +10,7 @@ from the database and from the worktree works.
 '
 
 TEST_NO_CREATE_REPO=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.46.2.852.g229c0bf0e5.dirty

