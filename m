Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54478441D
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459416; cv=none; b=iVgNcSYA2uS89iaYhK+SPa5sCMcCp28+mu1nmGeR/WwCfkIudRlTrAE72DJriShX1Cuc4BE/Pe5rt8VLlwQs/bdAI8mqHE5rcWlp6SzoalzZB0Ii1dG3ragF9t+JHJjvYNo/19kwKLCKxF3YOnVSrtGeMUi6EFwZz4RXe8ZQM+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459416; c=relaxed/simple;
	bh=EJGdIb7omUt9kgra8Ee23U3EAyqoWxG49bjPnv1sRk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjRXCfLFT8o+r9nz4/y7g79m4O03D5RZuiKjTorieEDWFPcVaAzSP5GO5GWR2I0QMb70RldlNaHnTJTnZuGDpr7Myq6sRRjBksdHiuV2Sn0Jhh7QUwra7tZGxUDyqEKuXiAuT7ISmJ5H2viR0CkctcCT7ZKzh1XMxbfrPB66IWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B6GpnORq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R9ZVaaIF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B6GpnORq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R9ZVaaIF"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 773A4138023A;
	Wed,  4 Sep 2024 10:16:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 04 Sep 2024 10:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725459414; x=1725545814; bh=3GndLS5mz5
	7cEW51CQOBiUOKXGgXGaFyw739zLIO3L0=; b=B6GpnORqZ1BNS72BWEZPJdAOsE
	fJ6fP7TR+aguXRCLUZjx4Jw/pMqytUYM7Gq/ZGtjUXrGxf3kWEjBnnnc8ydri6jh
	tl6jzpnnh9abliH/Hc49Uj37bgLqityitoFDkfwEcfn0X06qKlKt2oqHDtZuniuQ
	wGcza7NcMLslWh9K0RFtC41TOUDBRlKsfZiKhjZJ04W9dD7GMi8iCvPFKXN/BEOZ
	F6UJyN3N+7fP60jpMin+A6hyYwsWJfS8/61gDNOIoJ7GQQVOu6Xixk34Gl1mxmd8
	clLoiYJEPVIe5JN+peVUrypxAVINvrDny5taLS/HexP9Sxa7csosZQFDX7TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725459414; x=1725545814; bh=3GndLS5mz57cEW51CQOBiUOKXGgX
	GaFyw739zLIO3L0=; b=R9ZVaaIF+jljU+Vym+GBIVTUNliTCkB2AamcS8vhDvO6
	rkdS6cFWb9pwDGMY9Ph1vaDCR2vuSgN322HfTeP7N72pv1fD7/+J/AP3joTmg63v
	sqqMMP/RZe/nbqgozCMr5mM4FXi2OnlZcoTkvYSUgjP+lDYpQUdetJ9KMKgX02+y
	7eskBY93l2GjgnJPkVmY2R0eBHQkBx60fvFeYRdh1qi6ivvYWwAX1TSP1XAIx5V5
	PiBw5gx8qLYYOfpnxufAwQSJfNWIDXshfVTIMkMQ98AUo1DFed8Z4SndKFVvfZv3
	0M8TXTTNIy1PRFiDzdYckmLIPqUUrQFrVh0W2YP7Yw==
X-ME-Sender: <xms:1mvYZgv-VLKkl0CA0JJr7n8d7sg9onLE17W6bVH5126HMb9pVoNQjw>
    <xme:1mvYZtcoiE6eVB1hxoBbZ7rlBXZj87cv7smXM9-MuLBcgQkPg5gQmiVGnLK5xL7ON
    u8v4SH9PQRnob6tPA>
X-ME-Received: <xmr:1mvYZrzlPtSl_gciMTwqc9-PkfsdCjlZccixE3DHMHkl-AlFw1y77xF0gFxOUYsZfYF2tqNGuWpnJwhTkFIEw3RU8ZvMk6gb-EL4-LwDp7JZzXo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsth
    gvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhpvggtthhrrghlsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhm
    rdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthht
    oheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdr
    tghomh
X-ME-Proxy: <xmx:1mvYZjMlYvcfIi7hlVirzHtHk-PoAv7vEDD2hUpGueHutZOlOf0qlA>
    <xmx:1mvYZg9tfUP-WBo_ar0mbs6wwj_PXEG1s7aym5KOqUmAJhDQnwxQrg>
    <xmx:1mvYZrWFHXm627dwicL_OuXok7FP15afO7B4hyqAvhNSdubVwukunw>
    <xmx:1mvYZpcdLMM6bjq1UFfpOdwtVSUe9g_HWgioWgpfNxlvg6-lu0GRUg>
    <xmx:1mvYZrb4ZqwGJSWZV76Ysz_vgOoQX9kJric_KGrFXckGf3qtE3Onr1oA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 10:16:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f1d93865 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 14:16:43 +0000 (UTC)
Date: Wed, 4 Sep 2024 16:16:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 03/14] t/clar: fix compatibility with NonStop
Message-ID: <f24401f0a87059f4ff0c15ca0cfae4a899299b44.1725459142.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725459142.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725459142.git.ps@pks.im>

The NonStop platform does not have `mkdtemp()` available, which we rely
on in `build_sandbox_path()`. Fix this issue by using `mktemp()` and
`mkdir()` instead on this platform.

This has been cherry-picked from the upstream pull request at [1].

[1]: https://github.com/clar-test/clar/pull/96

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/clar/sandbox.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/unit-tests/clar/clar/sandbox.h b/t/unit-tests/clar/clar/sandbox.h
index 7c177f35258..e25057b7c49 100644
--- a/t/unit-tests/clar/clar/sandbox.h
+++ b/t/unit-tests/clar/clar/sandbox.h
@@ -120,6 +120,12 @@ static int build_sandbox_path(void)
 	if (_mktemp(_clar_path) == NULL)
 		return -1;
 
+	if (mkdir(_clar_path, 0700) != 0)
+		return -1;
+#elif defined(__TANDEM)
+	if (mktemp(_clar_path) == NULL)
+		return -1;
+
 	if (mkdir(_clar_path, 0700) != 0)
 		return -1;
 #elif defined(_WIN32)
-- 
2.46.0.519.g2e7b89e038.dirty

