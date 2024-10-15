Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307451EBFE6
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992722; cv=none; b=rMLs+sprHFtnpD30MDcAd/uHEofQg698BLB1Y4yUtw9hU3aZ1k0L3hpuI+Wu3jaVQxxVRPqqwg27OAxIjEYEpoSMAJBtgQTZQRzn26P7YPgLTMCbEYuWMj0E5k/CAGg7up4Xaf4ISdJkDXPDm9plThGRJUuuCsTgLSjjA8XqT7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992722; c=relaxed/simple;
	bh=Nqjg2a5IkK6/ZlCxiwMUNx1Yb5gNfNmFkFqUFzpma6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxPL2CZ92pGGmDrVKDJ6NvVIjJkDuGa3qgUbeWdDR4vpydhgmtCC9ogrBet3hpJmKnnWTb2RF+5TR+0+suZLUGq9hH21HxJKg2orcC9LKSk4HCXbI/C9xUfqjSuqPZC256ngjyFMYzBx7ghmORtCM9Z7EovgCZ6VZWk5RFxSQ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CxJ5S1UM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aA8/VN/f; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CxJ5S1UM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aA8/VN/f"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 0AFF111400BA;
	Tue, 15 Oct 2024 07:45:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 15 Oct 2024 07:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728992719; x=1729079119; bh=tyn/Jj7fgo
	8+SLdCu9RDXNInfdUUAuCS0IFtRuJQuo8=; b=CxJ5S1UMUhimpVrilu1A17QeUv
	LrjcVIMl9A7scibbgZDo071wy9ZjJwqcMkY319I/FVLZYLbdbn4mSxb9oyg7nCB+
	YzKfsF/eqZVGgSPC9HNibQ8YHcu44iSc1h+UU0R9KGVb2/x3z2+Wiqc2e0ZecXqO
	D+WzNEyYjAISZ1KTfukb21Vu0geB9eKoZ9CtDNS3OeDDaeGqUcHya19cnFC+HEhI
	MnHIy+oqQBHHeGsiNeHBL+zjXPY9Bh6Of3AJv+HGGiuvdeQe57hU2cu3WWxdO08w
	cfhGsKNZGPITS9121vzbBGr0ATVO6BXTusKG9StAWoSpjXF+M1l4fAYn7TNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728992719; x=1729079119; bh=tyn/Jj7fgo8+SLdCu9RDXNInfdUU
	AuCS0IFtRuJQuo8=; b=aA8/VN/fpSUPUUTYfbgEJaPVV/XrFgwYRHZAa9mzxuKc
	96EPr/TG1S6+LPjQi+bTZmnNe6q/fEyFrZ51LbbRBwv5jplMCr8MlAqXJ2sGGwQN
	CGZ+geX44ocX26Md9LomuoNa/JJYkQgBCdi0VTM9j4u63hxG295v0ujXlEsUDAJ0
	vx5XnsH8pH1mchI6EMxAI/xs2mROiXhZndf0dcqoX9eeJjy1bRrYZQH7SGs7k3jo
	gm1Cgew9lI9f+PkoB9VMHff9PyKnLMTJyNyRyjMTsnRACCuzKn6f42ZLhPoZJflI
	6zmXTNuJnYvFF/y+VKQDKM5XGVsG7tvxVpv6LpBwPA==
X-ME-Sender: <xms:z1UOZ-z4EWX0I-WmFwLVNe-VBDx27cDV4RNleCx6SXB-0QIADWaYQQ>
    <xme:z1UOZ6Qg0ZdUT3hG_lybqk4IUY0Rnf3cA5UE-YdCzf8tKcCuZySkOgkjWXMMmZVMf
    ThK0UQ6oSCf23L1EQ>
X-ME-Received: <xmr:z1UOZwWW7s10tlTqZCQIw6e04G-RCJ517DfPnfVdAIDAsMzAVkVpzv8rQM9mKmkPFpraFjC16bhcB6r302C7Wr8MxP4bBTujQS6W7AWoV6eNsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:z1UOZ0jK3fCP-puGd9c_pdEYaTl46xzvarHJ5cf24vbiYtMDUg8HvA>
    <xmx:z1UOZwCVz_htLS10yEKKtfI3Z-78rBGO3rJXRV14icEZFlEuHKOdHA>
    <xmx:z1UOZ1INJ00f0P19mXebs5qB8QJjmAfTv2KUpARCKsY1dlq0-qau8w>
    <xmx:z1UOZ3DpzcVTVltgcAIeIvI3bqdvjJzIY3Pvy55539l1LLd16ucOrw>
    <xmx:z1UOZzML0fN3doLxyk6BuPISyjb55F1RSClBIdd0Y_ymEYzqENQ67Rj1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 07:45:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f8a863f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 11:44:04 +0000 (UTC)
Date: Tue, 15 Oct 2024 13:45:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 04/10] t/lib-gpg: fix setup of GNUPGHOME in MinGW
Message-ID: <cc94f6fa64805e0bc45fc18445c3e99d2f5ca9ed.1728992306.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1728992306.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728992306.git.ps@pks.im>

In "t/lib-gpg.sh" we set up the "GNUPGHOME" environment variable to
point to a test-specific directory. This is done by using "$PWD/gpghome"
as value, where "$PWD" is the current test's trash directory.

This is broken for MinGW though because "$PWD" will use Windows-style
paths that contain drive letters. What we really want in this context is
a Unix-style path, which we can get by using `$(pwd)` instead. It is
somewhat puzzling that nobody ever hit this issue, but it may easily be
that nobody ever tests on Windows with GnuPG installed, which would make
us skip those tests.

Adapt the code accordingly to fix tests using this library.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-gpg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index add11e88fc0..3845b6ac449 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -6,7 +6,7 @@
 #   executed in an eval'ed subshell that changes the working directory to a
 #   temporary one.
 
-GNUPGHOME="$PWD/gpghome"
+GNUPGHOME="$(pwd)/gpghome"
 export GNUPGHOME
 
 test_lazy_prereq GPG '
-- 
2.47.0.72.gef8ce8f3d4.dirty

