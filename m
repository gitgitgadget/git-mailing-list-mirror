Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B891D1738
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066389; cv=none; b=EM3Uqm8FFQzokWPcSKL65y/tIJy50hL/CXNzsAV/6jYHl4nvayzhSC/MKm/HTx2agpxLFNQJ7GB+lvQUOSPEXDuGdzEBEw7/g4Oe+6xqMTAPHdlY12DflN+DsAa8UgauAyeAM56z7Ul4hdakdu2mQbBglsa9kYaCY+sJvvhOdrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066389; c=relaxed/simple;
	bh=6wCUDR2uWwl4w7N5YG2d3RdZ2ut+HDil49fwgmEGuoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7AH1jrO3Bt7ZAwRmCKt1b4ciILMBzcHg1IIlOhZwb71WZVmORNrh4UVH2EeXhzvXEhvujzFLZmSkY4ySGefeD/KA8vrhj+FFKU8ImGIzoXKT0ZLeijSE3a2z13JEybyuJAY3ooGvsrlWCxg+43Eo8wnXAze5vgMwbSSONm3au0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EafSycnN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kWQI1x26; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EafSycnN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kWQI1x26"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E2D351140149;
	Wed, 16 Oct 2024 04:13:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 16 Oct 2024 04:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729066386; x=1729152786; bh=jLJmF5/uZk
	1UixwX0/0kRWJ9Rhewqx2nglz2///Euug=; b=EafSycnNwnnoYZD+0Q28i5OpKA
	Cbfszq3ixgJKPNF25GyEyR/OmVp2pBLpKz5/GLP/sUwWuldIlwj6UKA59EWPWT1r
	6xaq1bFLGJRyY0Lv3Be8IF330aHMGC1P/QS9avO75wqGA82Dik+LMvA9RZ7F0vyR
	vYSMK59iYoZo6sDJ28NIUKKyk+fhZH0NRPfjJHol1e8TBSyweCabpjKtg17HXJxO
	L5H26yZ4eZxg2QsegTwmLZ4Fezg7IiyJUjQ+cYB9MFhTeBacgeAfdJ+6U5VgoK5/
	qurry7Te42HaVH3aljdp14ZL2Clc3eB+DsOFaRihALONChJmIiXW4pFT+L6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729066386; x=1729152786; bh=jLJmF5/uZk1UixwX0/0kRWJ9Rhew
	qx2nglz2///Euug=; b=kWQI1x26v/eNOoa7gHUhkijyPDPV9QPgsvt6AWuL7J+F
	gMqVREa3YgrP5oqFs6KZOdXwFTjIEAD/1RNn3U0ThrPcCuZ66Eh18iV5HpI+q7Nn
	XFjSUOb9/TVjizmzPLHg3hciGidZA9FxB5PeQbF+h7fB2FeUjFO5KOGDK244nVb2
	+5Dg1DxDtTasIdQHD/GFy7M6gxv36+07evQctN+30edSuV4HgVu0eZxX03cuGQO2
	qyFgdvK5nHbGIMcjLZ0lH78cHy08RIIWZK1f0e0q/j+Fi04bQpyF0DWq8r8zJfLm
	nG9O9Jd+jLfIN1LutB0oSruhXF02AOR5JcO4fmTJyw==
X-ME-Sender: <xms:knUPZ45O8kb7WPXBxBKxJBBydaqQDoLj44c8IO5r-d6hdL5T1bAjCg>
    <xme:knUPZ54inb5VR_ZtmIBCDJDjmtfZ9I33ra8En7YGT-ykrGTUbQRCgIIQiQLDgmpZm
    MAeKvD_6zwfNUSxnw>
X-ME-Received: <xmr:knUPZ3cJCjsjSclu94XRN3oHbmXudEh5RHVpFGTx4UzNgxk5d1kasbyJ5saXNWgupeh-HpXpZ0376Kc79KJXHNpRGazEGwHKM8L-O251FI64-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:knUPZ9JdXlhz6u0zA8xwLW5MUV-th_1nlLZx7jOc2CVH_etQScHn_g>
    <xmx:knUPZ8JiVD6ols0nmzXvLBn2yD1aY7Q2RMcmbhoubUli5zL7SEEHIg>
    <xmx:knUPZ-z0ZiKLLN_kv4khQFkAOJu7UtdOlBTjvX-UriBnBRROxUFm4Q>
    <xmx:knUPZwLiDwppDrKCpxcWFby7nipLJf22zqKnc-Iudz0V-cWIuHS_OA>
    <xmx:knUPZw2MKEFcXxQHZWUq2pp1JFLv3-LqM1btnffsXLN3isuU7IhDZqx2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 04:13:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 718215c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Oct 2024 08:11:49 +0000 (UTC)
Date: Wed, 16 Oct 2024 10:13:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 05/10] t1401: make invocation of tar(1) work with
 Win32-provided one
Message-ID: <df2fb1b96076569ec020e67b488e01a3ae4394e1.1729060405.git.ps@pks.im>
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

Windows nowadays provides a tar(1) binary in "C:\Windows\system32". This
version of tar(1) doesn't seem to handle the case where directory paths
end with a trailing forward slash. And as we do that in t1401 the result
is that the test fails.

Drop the trailing slash. Other tests that use tar(1) work alright, this
is the only instance where it has been failing.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
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
2.47.0.72.gef8ce8f3d4.dirty

