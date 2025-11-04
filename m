Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB2260583
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270143; cv=none; b=GcVohwgGtknEd34ZYRfC9AhcUEhDZgQJMojUp2y35jx+ChEv8KieGHL1UE7ZgIYZoyhSH11CZmPUoyWY60HjNvj4DHKi2UpzvfxEGWcSNFOHo2DzyQWDsdZeFBKDWIl/iUT1EexNSr+RuHTWNPCsy9twSg+wMjWfeEc3nJMemZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270143; c=relaxed/simple;
	bh=Fw82qrCdNn4ksIdgMfgz4Ky70JiTBLeLcSsrvw7bx9c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yp7AkgR93zfs8ArXojPC5j19O0siNyVabJD/VJvjj8XiCw+/zXmVOpcQBtihVjreDBNeic3A4JCqawbmx2Rn+iPFaiJLwJC2jWwrsKt+FFoIbsNX2DvZf0GCBG8gIJKD6jlf8365xpig/3QlP3DcLmAjOk6jPz6qDIRfQHFM3Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XRmk8Bsl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EjFwJo/2; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XRmk8Bsl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EjFwJo/2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 199F3EC0505;
	Tue,  4 Nov 2025 10:29:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 04 Nov 2025 10:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1762270141; x=1762356541; bh=KXvn7PD4wIHlG3s/tZMj18Koj3AwcLE+
	GVcYA/lhdrg=; b=XRmk8BslQ2vqVUDZ6Y4wF3C1YGhKNBi4Sm/U6fuYcLTvDKlI
	dcqtI32IhsVVax0GablqlurYC20iCfNW2rHfrso6Hb/K6hoJEPpyXHF9SJZ3SSjj
	KtP0E3H+lwPyL9n9V4++bXTXoYlTSpcIYk3kK7UabjIds95kwk85gfGfvJNPhVk0
	8VcNQX493f6HU1tA8ltJeU1NQwZAvApPVyb+HYBEGVT5KM4W+XwmrODxM0Jv6YDK
	yCNOyv1MsUahpEkAop/tLsQj/u79cFtswX5UfTh2f0GBbok5vh6cGNsO8seT+fsQ
	VqdZLRDihAyxMJVIa426phQ6Rpc6Y8xteHYw6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762270141; x=
	1762356541; bh=KXvn7PD4wIHlG3s/tZMj18Koj3AwcLE+GVcYA/lhdrg=; b=E
	jFwJo/2j+h50LMQhUWNcRBLE9ATf3dCmwGHf8ws1B5Str6ppNptdtuxjQqZfwi4X
	Rr0eiMsqlNFXPZ05mO7K3Ah0dB1dviXVRAvxbItsd5aII626gqe1rGjBaYRzMnBk
	gDdGEMuh6SW3Q/K1i4jAB4V6otWcXAo1QD+3l9mrGhvcCS2quGUbKWN3AKudQ+9E
	D8NFjHWfJTK0ObmNl96+MKqauLOkAkmH2RtEuDsLXLU9WMHd7lVQDp5Oc1PJUKJq
	KhUQhOxvskGpIfqxjTfhoqW+rfWIEhlDynK+y2fNZPoRGhQ7jy53a+jFDQzexqYo
	OA77X0xTr/2mJ77Cu1IBg==
X-ME-Sender: <xms:vBsKad3Hdk3IxCpdUzatmqDKqnYWZXgmXNgHXe2XHiydEm6YIYW8jQ>
    <xme:vBsKaaFGc3GuyWj5b4oRM7PxHYpgeYr2nlyTqOMZ1-0fcGoL9TFl85np6BYjowtqd
    x6ZCW-5Q5jazubx4OC3nxcl5R7T4A4C6SF_Gf8rBHaniM8xVL1qDQ>
X-ME-Received: <xmr:vBsKabiuPs61m8q4WVBhMCMRh2Ohc8Zf-UundfkWRs6I1im_1Ky0jumH28-aDX_JG4N0K617gu3o0RqWzpfj_EfdEGYRYCApFuhT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedufeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepledvfedtfedtkeefueevlefgleetieeuff
    ffkefhgfekveehkefhgfetjefhffegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:vBsKaV_9I-uWxCl0CCS66K9PjXCYA4ewAAjlcb7F4Ph7dQYE9HNfIA>
    <xmx:vBsKaSq5UFOlhPEfiFffs_3qRp-NHceIpA26UiOiR6K1HPFt2j6Iew>
    <xmx:vBsKaU9-Crx-cAx9o0cUcb_dQ_5d4Jri_LisiHiCqtd-ye9RTz0-Kw>
    <xmx:vBsKaWV0W0zMk2xRuLbAGCA7-SLnDtPrsGMMG2XjO0iwlfDh_cV0RQ>
    <xmx:vRsKaZMIZmBTv-hNlqXCFZlRNjJ1Owm9-tFiVvAUFFuZgjeY2kFiBUO3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 10:29:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] t7004: do not chdir around in the main process
Date: Tue, 04 Nov 2025 07:28:59 -0800
Message-ID: <xmqqecqdrf44.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From 11f438cea119c52cc0c982f2b859defb37fd8c64 Mon Sep 17 00:00:00 2001
Move down to no-contains subdirectory inside a subshell, just like
the previous step that created and used it does.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I noticed this while writing the --sort=version:tag test and
   failing to find the test vector files I was creating in the test.
   It turns out that the files I expected was inside a subdirectory
   because this test piece chdir'ed down and nobody came back up
   from there.

 t/t7004-tag.sh | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index d1388cfdf4..ce2ff2a28a 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -2293,24 +2293,26 @@ test_expect_success '--contains combined with --no-contains' '
 # don't recurse down to tags for trees or blobs pointed to by *those*
 # commits.
 test_expect_success 'Does --[no-]contains stop at commits? Yes!' '
-	cd no-contains &&
-	blob=$(git rev-parse v0.3:v0.3.t) &&
-	tree=$(git rev-parse v0.3^{tree}) &&
-	git tag tag-blob $blob &&
-	git tag tag-tree $tree &&
-	git tag --contains v0.3 >actual &&
-	cat >expected <<-\EOF &&
-	v0.3
-	v0.4
-	v0.5
-	EOF
-	test_cmp expected actual &&
-	git tag --no-contains v0.3 >actual &&
-	cat >expected <<-\EOF &&
-	v0.1
-	v0.2
-	EOF
-	test_cmp expected actual
+	(
+		cd no-contains &&
+		blob=$(git rev-parse v0.3:v0.3.t) &&
+		tree=$(git rev-parse v0.3^{tree}) &&
+		git tag tag-blob $blob &&
+		git tag tag-tree $tree &&
+		git tag --contains v0.3 >actual &&
+		cat >expected <<-\EOF &&
+		v0.3
+		v0.4
+		v0.5
+		EOF
+		test_cmp expected actual &&
+		git tag --no-contains v0.3 >actual &&
+		cat >expected <<-\EOF &&
+		v0.1
+		v0.2
+		EOF
+		test_cmp expected actual
+	)
 '
 
 test_expect_success 'If tag is created then tag message file is unlinked' '
-- 
2.52.0-rc0

