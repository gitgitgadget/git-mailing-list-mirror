Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F882199E8B
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439989; cv=none; b=XR0yhYI/kqSkkT6jhLtgs3Ozas80wAegKRi9iYWUdV3gDu1DaKrErXP7oLWfMpKZ4BZECXYhysKDK8F0t3V1MOAEmrwIUPs3mqy7kq0+BiljQUXUUpVemfK8Nx4E+v8LKaIZFm9Q0u3ocf2m554oxUiRRSDuInrpw6ka7zEuLDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439989; c=relaxed/simple;
	bh=5lQTPuOgEuq4PV8KcSG0MApPb61mlWwpCttcFxN48fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWyBIP15AyzgzXxzDati7QNSibT10moI4ixCa/x8aEJPPjMTGQUjchX21Oc6l+vx7kLnyHvy7I+XaI3RWss5mkKqBZn6uYBAyYmcBWfkP0y2mEqTrF42Xs5JaOBZJ4Fzcv4JtitI5Gkf1FWUUuohJyiLoZhdZM85Ejd3HqBSpOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZQXc9H+a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=img4W13Z; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZQXc9H+a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="img4W13Z"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9D33B138032F;
	Wed,  4 Sep 2024 04:53:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Sep 2024 04:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725439986; x=1725526386; bh=9brIQmhJS5
	veVHX7IJogk8m1bXErIl7FRTEcDeb63OU=; b=ZQXc9H+a8f8KtKkqLD5Qq6HzPu
	mXATMWpgBUdpTs05l+ZREnrYzdqmErI+nwXJB1BYWLOvd2PnC2nTPFyYIeguL7cw
	YIK4Rt3gRk4FDnwTnRzIaRN4VPNZtzbJX6mCzcZF729/o3QTOW5hbrna3ne/CSba
	S01Up72XNQJ5mEFZRbGKeTmD3OH1hpEHuCCdJQuEGNJje1v6v2JhOyolA5nsr+SM
	LYayb6s7o2EBJ/8i16tc99V7ivcG30+6FxGNkOJDr1tRFnn3NVHRND3OhcFgAymn
	5IftigfQgL3PL/ZEJ4PM2j9QksOmjq4/ThVLxAwVTPHM5gmdKcrcFd7yga5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725439986; x=1725526386; bh=9brIQmhJS5veVHX7IJogk8m1bXEr
	Il7FRTEcDeb63OU=; b=img4W13Zsa1YMmGAIkE6uuu48K+WmBIC3KNAMElWzcJt
	pNiQwnrxJ3cCZyaE/Zhbb3J7ILIt2cAauGfXpzCU83t5LLsbfuf7Ny7gMVVgNF5R
	lyg1QCbW9t6zmVvr3EBP291VRt1YDTHLCORNPJzO7YQAS8MkELIO/VYhXQg/mSkl
	zkrrcG0vq4eiZi8CJi2g8Z5vFmDTchJ3FYDPR3Fb3lXsbLI+IiiBXn7M2frt4xgv
	O0OMcCHre4SR73KbRj68PIStXmwMtcEC832pRlCRhqqlke9NQhvsPE7Vm7VFSkKS
	b7++38AnvcBDDM2YTZbbSUJDxt3SiKy3Zn0eBEvrwg==
X-ME-Sender: <xms:8h_YZj1BB3yePdyAoaKAiUViJayj7ZsjDV1UrumBIln2QkG6wNJ91w>
    <xme:8h_YZiGx5aXyqJAQ-CzjMDBiYV5_cCEIUSBRMioHOIhieXh0MJ3jf1kpOHz-Eq4ul
    _cndcl4QUFYThVjbQ>
X-ME-Received: <xmr:8h_YZj5pvN_qlylWEGo59xoM2-92BHqJugp4jo4ZgDk18pUZrxQBd1tNaf1hmkgve6erxw-zVAbwU19t1GJHMwgl26bCP7hS-7kIE1MMuCjq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8h_YZo3v0ZcC4s942FX3CxXBV-vFtbgCPpXh0MpqgPb_iko6E2DywQ>
    <xmx:8h_YZmFx25kxRWoJ3YYG6hB5M1al5G984W27D_Zd3lbVHDBj0iYttA>
    <xmx:8h_YZp8In87f1OIjNLtfOv8JeUui1nV1zDLewMa6FIfaTzzi4etSPw>
    <xmx:8h_YZjkXpyLN9PK0kE4jvo8AbqIEOPeZMCGchNG4xbjIsN0yCOm_oA>
    <xmx:8h_YZiBDfk4Jv_dwSgz4rjnVvNCYmZ_MJSG8eE0Vp3BworAjsnS13ofb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 04:53:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 69d8a7fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 08:52:56 +0000 (UTC)
Date: Wed, 4 Sep 2024 10:53:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] t0601: merge tests for auto-packing of refs
Message-ID: <4a59cec205df7c09bc23a1f2609e728f2df5cef8.1725439407.git.ps@pks.im>
References: <cover.1725280479.git.ps@pks.im>
 <cover.1725439407.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725439407.git.ps@pks.im>

We have two tests in t0601 which exercise the same underlying logic,
once via `git pack-refs --auto` and once via `git maintenance run
--auto`. Merge these two tests into one such that it becomes easier to
extend test coverage for both commands at the same time.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0601-reffiles-pack-refs.sh | 36 +++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index 60a544b8ee8..ed9652bb829 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -161,13 +161,6 @@ test_expect_success 'test --exclude takes precedence over --include' '
 	git pack-refs --include "refs/heads/pack*" --exclude "refs/heads/pack*" &&
 	test -f .git/refs/heads/dont_pack5'
 
-test_expect_success '--auto packs and prunes refs as usual' '
-	git branch auto &&
-	test_path_is_file .git/refs/heads/auto &&
-	git pack-refs --auto --all &&
-	test_path_is_missing .git/refs/heads/auto
-'
-
 test_expect_success 'see if up-to-date packed refs are preserved' '
 	git branch q &&
 	git pack-refs --all --prune &&
@@ -367,14 +360,25 @@ test_expect_success 'pack-refs does not drop broken refs during deletion' '
 	test_cmp expect actual
 '
 
-test_expect_success 'maintenance --auto unconditionally packs loose refs' '
-	git update-ref refs/heads/something HEAD &&
-	test_path_is_file .git/refs/heads/something &&
-	git rev-parse refs/heads/something >expect &&
-	git maintenance run --task=pack-refs --auto &&
-	test_path_is_missing .git/refs/heads/something &&
-	git rev-parse refs/heads/something >actual &&
-	test_cmp expect actual
-'
+for command in "git pack-refs --all --auto" "git maintenance run --task=pack-refs --auto"
+do
+	test_expect_success "$command unconditionally packs loose refs" '
+		test_when_finished "rm -rf repo" &&
+		git init repo &&
+		(
+			cd repo &&
+			git config set maintenance.auto false &&
+			test_commit initial &&
+
+			git update-ref refs/heads/something HEAD &&
+			test_path_is_file .git/refs/heads/something &&
+			git rev-parse refs/heads/something >expect &&
+			$command &&
+			test_path_is_missing .git/refs/heads/something &&
+			git rev-parse refs/heads/something >actual &&
+			test_cmp expect actual
+		)
+	'
+done
 
 test_done
-- 
2.46.0.519.g2e7b89e038.dirty

