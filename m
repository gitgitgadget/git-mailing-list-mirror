Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020EC1D1738
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066392; cv=none; b=B+YySwZ/s1ZrbsNKeFs/hxbtGnflHXYMrI9Z3IwyBMeFyPdouM/JZGi8bN2Zca9EazZIFpFs7p+JzR0cQEEXQKniNKivsdltJk2or91eebXGslHxN0Wkb1ReBNWbJPGAuOFTgUcnWHlCy6GcPLPPQIqHIWQyEnHK/7O59HgGEfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066392; c=relaxed/simple;
	bh=Jy5H8rd/HsHj6nvgVLd3dUgL5Y3/moeUXfdhK3b1uEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sR1zOgg7+fpz47UaFphc+u0B1REwUo8Zc4eT95F9fu5FyFmQ4wMxXHFPWnKJhgMkfXDS/GaDTw5NtyvTj8H7pwOZxOux7B/4EYuxWJlwkpV7cU1DiP+nLurtAtitHF5bBQP6AfxIIjl3XL/RbBRwX+hEte6/U/01YsglwzvGX5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NsPH2Sgw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oq2JP6Zo; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NsPH2Sgw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oq2JP6Zo"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2B6571140149;
	Wed, 16 Oct 2024 04:13:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 16 Oct 2024 04:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729066390; x=1729152790; bh=+Pe2v1qzcY
	1ZGDdQ+1cWhvEwUASL9kaRlE/RiwKSBV8=; b=NsPH2SgwM1IADbI89KBwwa1P8t
	FJw2lNURtiHxu1+rOZ8axsmM5if+k4SRExoJ+LvW1QqegnGjSwoWGtYEwqMyCsjt
	RvNV0AFIEbZewmY2tFHB93QUF8pqliZ1NL/Cs1gFDKI4qV9XmcTTuTbaPTBUpIzn
	CoEQ29ofn3OG2o0vlf8V+QesAu617p9P+ie1mZq0gRbtIT5CWyyGd54KujyKrK3p
	zTfpy6sqDspvzq4sJhjzqyahQIaFip1XL2EsoiG1LnNh1Y0pDc+yOxhBUNEtlnQz
	nzL5sW01cenmdbxwnD0p6cUWVlLyeDcpw5Zs3TAat819toKzOKY2gimxXDNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729066390; x=1729152790; bh=+Pe2v1qzcY1ZGDdQ+1cWhvEwUASL
	9kaRlE/RiwKSBV8=; b=oq2JP6ZoZJwbiJUTlHbMOuM6Pb2eOBnZZTITzoT2wUpj
	xXdsGHhnaMf7JGGwm/OWY2Kvr9iWqti1/T1dd5udbjPrpwTDJIpcy0PMHXXiqVKY
	i1bLqDFxkMTGM4Fp8UwqzAH1pZTMym7cHMw5zMKkCe1DdOMaTSTZXHhCh2PgRftc
	Lu2KZIW3bNHkLhGJ8qgQGZ73MympZ6IlkTOT44aXpth+ngOnJl1z9zxtbPRJoe67
	+Z7xYLEDcQcN73lFp+9kVBxlCwZmmXYW17JHXefnm7ZUOlpAS/EGmCa/vEBfLVQS
	Rs6PhhX2FnN/YneJMfzpuDfZUV/aNIyvMr/xRK9Qvg==
X-ME-Sender: <xms:lnUPZ-dpss85YnOfMZypmWFqzR5fgWHr54N3Rn-1kFgkrZQWH4FiOA>
    <xme:lnUPZ4O9BvVz7bSWj8E0mdvlO55Hjehy4piSjd4xW3EPZTwTE9NaJ71degZu0S7vJ
    -YQeHoGoJlMRchYxA>
X-ME-Received: <xmr:lnUPZ_i6Rqh_99TSbvdbFSTg_LIwxzesM9kP3cchnhxPcCe8jGVsCshDhImnNBNpkxJwNWzDsBNIUjdHiCJhv7Rb4kBa1BjvViAjn4d7iExh7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:lnUPZ7_Xm-Nk8GLJA3L1ZCIQUiIhPZx2xqW_nvmyTWqfcOYaWNhIhg>
    <xmx:lnUPZ6s6iK9ysxf-n-na_D1G855sN4gyL5p-2eHa3AL4pexuUUotgw>
    <xmx:lnUPZyE5QQJPqBZmEynKzuhXN6sbFGlZQUbNMkOkykVFgFKdyzcyug>
    <xmx:lnUPZ5OKIkpLH3PWTSU0KnnLJHEax9bWmC-a31H0ZWqBzf80HAInSQ>
    <xmx:lnUPZ-JBUXNJwc5cXREhYCY-qdTRm4nfw5lV2AeS2bx99ePMrJpdKNVQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 04:13:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 21a3060d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Oct 2024 08:11:52 +0000 (UTC)
Date: Wed, 16 Oct 2024 10:13:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 06/10] t3404: work around platform-specific behaviour on
 macOS 10.15
Message-ID: <29fffa5d86b5efef9647eade7c3fda4d6d6e6ddd.1729060405.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1729060405.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729060405.git.ps@pks.im>

Two of our tests in t3404 use indented HERE docs where leading tabs on
some of the lines are actually relevant. The tabs do get removed though,
and we try to fix this up by using sed(1) to replace leading tabs in the
actual output, as well. But macOS 10.15 uses an oldish version of sed(1)
that has BSD lineage, which does not understand "\t", and thus we fail
to strip those leading tabs and fail the test.

Address this issue by using `q_to_tab` such that we do not have to strip
leading tabs from the actual output.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t3404-rebase-interactive.sh | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f171af3061d..7ce75237803 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1917,18 +1917,17 @@ test_expect_success '--update-refs updates refs correctly' '
 	test_cmp_rev HEAD~1 refs/heads/third &&
 	test_cmp_rev HEAD refs/heads/no-conflict-branch &&
 
-	cat >expect <<-\EOF &&
+	q_to_tab >expect <<-\EOF &&
 	Successfully rebased and updated refs/heads/update-refs.
 	Updated the following refs with --update-refs:
-		refs/heads/first
-		refs/heads/no-conflict-branch
-		refs/heads/second
-		refs/heads/third
+	Qrefs/heads/first
+	Qrefs/heads/no-conflict-branch
+	Qrefs/heads/second
+	Qrefs/heads/third
 	EOF
 
 	# Clear "Rebasing (X/Y)" progress lines and drop leading tabs.
-	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
-		<err >err.trimmed &&
+	sed "s/Rebasing.*Successfully/Successfully/g" <err >err.trimmed &&
 	test_cmp expect err.trimmed
 '
 
@@ -2178,19 +2177,18 @@ test_expect_success '--update-refs: check failed ref update' '
 	test_must_fail git rebase --continue 2>err &&
 	grep "update_ref failed for ref '\''refs/heads/second'\''" err &&
 
-	cat >expect <<-\EOF &&
+	q_to_tab >expect <<-\EOF &&
 	Updated the following refs with --update-refs:
-		refs/heads/first
-		refs/heads/no-conflict-branch
-		refs/heads/third
+	Qrefs/heads/first
+	Qrefs/heads/no-conflict-branch
+	Qrefs/heads/third
 	Failed to update the following refs with --update-refs:
-		refs/heads/second
+	Qrefs/heads/second
 	EOF
 
 	# Clear "Rebasing (X/Y)" progress lines and drop leading tabs.
 	tail -n 6 err >err.last &&
-	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
-		<err.last >err.trimmed &&
+	sed "s/Rebasing.*Successfully/Successfully/g" <err.last >err.trimmed &&
 	test_cmp expect err.trimmed
 '
 
-- 
2.47.0.72.gef8ce8f3d4.dirty

