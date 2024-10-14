Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633F31A2875
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908490; cv=none; b=OwXko0m2kBBXjPfp62hLGUyHEtkhow9jIhJdiAfyaoayNoHENLB64DY1sN+GA5FmAq2STfB/FJy8zZtzcgM4r7ouhsBcxoAk0r6VSVzFHUe1AzoBaOkkH63EqI0M7ijsAKVn4Jv1krmFU3eNyoYkqQFVCrG4lP8juGO1P1iTY9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908490; c=relaxed/simple;
	bh=RtPCJt6jP1jVfoOSn9WB6ielj2PwfYTPLarQuPNy/no=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm51Zum1iUV32eheGlWKyVF2dBKULCuRDS9apOqXe59FxlcPq0VfzM+ojvdlrKR6Sv6A0H6XJvK5kbX1Y2+9e3YYR+3T7OYYnKo98pX9koWQ+pwN/6f7BP/kaUvHVMNpbDa1nhsfLDPjolOXM9dF04Y/qQnVaQcgHHmLzEFaWUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nA5oExh8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lDEh5v5W; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nA5oExh8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lDEh5v5W"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 846391380256
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 14 Oct 2024 08:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728908488; x=1728994888; bh=jrt8NDJO47
	rPxAsOoF3z6yr03MRBQBEoIbTN4/hhDso=; b=nA5oExh8DhvkFBflfrJ+DpXxPg
	gga9XRr/cq0/ulOi8wQbG55LnbG8GnNBCljJ7Ovyr47NX6LFmVynozf5NdJJ2npS
	19odrmyfxX16rmFG+6xvoGqP6csc5oABsfin78KmdvrFGmClHgqKEkV6KSYhzfJo
	kmnSZEmMjeHaCfuIpQP0v320vlPOxvxjwf3h9iqXibNbvYd/9AT72hxDrhHPqhaJ
	RjG4RQkNniyvWgYN8nF15zyQ2QSKlmNdZj4poQBwoL+HeidAk2lNvXN9fYrMthoD
	VBEu1H6HYKQEnPweHC0BPGvMNYZdt5+gOyegeXsFgKfWy41gzxPzr9myc1gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728908488; x=1728994888; bh=jrt8NDJO47rPxAsOoF3z6yr03MRB
	QBEoIbTN4/hhDso=; b=lDEh5v5WAvPbmlL4G/M1azd8XRwcpLaMAe97YI7/DrM3
	HoVMgv8p6VQc2kvqZx006h2gJBxz/mqr/0CXtvGiLQWEggKs3XBUrWHzPBymX3RW
	wanpEIp00gBVlcWSypxxuhHpq0NiOrVHvAdzuRIQYyx1tnUzS1WGZamcb+c+NTwd
	0zjaCRkdb93vgh+qjRQRzaFAdC0j6NpBKwR66no1ODA2rGs5bcbGCoOv+EvV3tuy
	EFGy4YAQKRAEusu6t9wVnI/ehylIbA/HK9WKmBOxpjv85ON7QeK7/AJc/rKH2P/O
	m4WkAtkznMzeVcF6FQ2LpQGc7hJM5zTBjzPIQJh5tQ==
X-ME-Sender: <xms:yAwNZ4iWtXU0nnZpo_ox6iD_v-KfFFkB2V-QTXwu2mg4hvB85KDOqA>
    <xme:yAwNZxBk5UBOiQSTpNqUpaS-uRvWEnHZQO_DDJ1FNbIAlQZ59FuoJJIS3Z6wRy1gk
    VLy5XEhmm9LMel59Q>
X-ME-Received: <xmr:yAwNZwFTss-DsrU01A_hG4kJbTdz0EbxInEFAdSkr_ZSwUMTnC7LrJaPrYl9Y2RRNtaucfGp-wtL_3-EM3ns3GGPn5VdkFKz-0V5OZrtGUqjwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yAwNZ5SpT01fna_5sl6q8aVuH70aqzgIS55JZQcHpp6VjEH4xgX4_w>
    <xmx:yAwNZ1zw-WVWKiXrWYg4aPTXEwQqkVNtKXQot_CF0Dvnut2K8HAooA>
    <xmx:yAwNZ36bFNdes5xYkm8m1JUblRPI2PwbpQcBES8R0NDZ_KyKcrmQnA>
    <xmx:yAwNZyz6PiagQPe5eA2p_EVXojLJ5eHj1808bzuKTSl379lYVA5ldA>
    <xmx:yAwNZ2rTUvueZDnEWHOIFJG30C_7Zbr8a4trXfrhLdCJhKrw3mtaUsCf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f063e4c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 14 Oct 2024 12:20:15 +0000 (UTC)
Date: Mon, 14 Oct 2024 14:21:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/10] t1401: make invocation of tar(1) work with
 Win32-provided one
Message-ID: <d082cd92af36610af24985ef2279c4176b1f182f.1728906490.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728906490.git.ps@pks.im>

Windows nowadays provides a tar(1) binary in "C:\Windows\system32". This
version of tar(1) doesn't seem to handle the case where directory paths
end with a trailing forward slash. And as we do that in t1401 the result
is that the test fails.

Drop the trailing slash. Other tests that use tar(1) work alright, this
is the only instance where it has been failing.
---
 t/t1401-symbolic-ref.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 5c60d6f812d..90af3f955c0 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -16,7 +16,7 @@ reset_to_sane() {
 test_expect_success 'setup' '
 	git symbolic-ref HEAD refs/heads/foo &&
 	test_commit file &&
-	"$TAR" cf .git.tar .git/
+	"$TAR" cf .git.tar .git
 '
 
 test_expect_success 'symbolic-ref read/write roundtrip' '
-- 
2.47.0.dirty

