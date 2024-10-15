Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47061EF0B6
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992743; cv=none; b=f8RE7hiwETga/8DtcAaFxnsWdHuFPVuJzXJu1dQdWbSZTJVjD5eB3oMoPSN58Ey+hcm3HuTxZnem1JdvoVh3Wuo/0/g8ZGwcsFMctzd5fMoM2CUZC3HFnUxClFH1hvp1kxhQB3Comh6PAVUFT89JeIhBfHXgRE+2N6hUuEY1Fw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992743; c=relaxed/simple;
	bh=l3xYCrq9sa8N1wr7lgRlrBuA0pgklwmFnpVOuzSOvck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ag8EFIxyDnLQmRsek8Oasc1iE0xitVwHySRKm5uFxEYH2nBRWalm13+0NjkMwwtna+tOPS+MfLadQA0runZPQrYxsFZR25qQJn5lq1o0k23EMqwOS1ErLUCM0hkv35Eu16+3Xi0Hfyjm8x5GV6cenP4KCBBaU+CbLj+ilv2CJ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A1NtjUl/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f/Rs3O+O; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A1NtjUl/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f/Rs3O+O"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id E722211400B7;
	Tue, 15 Oct 2024 07:45:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 15 Oct 2024 07:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728992740; x=1729079140; bh=UgXRcLeHVC
	4VVMna5Jzrkg9TsA9+N54tfntKt7NIIDs=; b=A1NtjUl/W9O2DkcJYRkjCHS9It
	Orm8YZf3rzn/R0qxgfQfqoN/GrTA6gu+mykNy3Ge1OhM5HsEns9VIOJ5G87CCvXp
	MuyInSaZP9eVW7fL1dUHyzcYYGOd/y7v4AD7U9RUfTjmznKdEXWa75vyAW1TTLNr
	KJ/pxiqNMlmn8l0Aq6I3pY5065luLXQyAoGolTYvu1Khr8GzeBqJ5WfsGIiNFsaI
	UuvsfWIOFybI8emIMFRAOMzRYj3lpv0y/LDGWLADx/vZR9ZAMW7TFS1E/28H5458
	IN0YpAdEuXUxDd0NQbZtMOsyb3rMgOy0rEihFuKIruy3/cgfXXgvrqg2CZdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728992740; x=1729079140; bh=UgXRcLeHVC4VVMna5Jzrkg9TsA9+
	N54tfntKt7NIIDs=; b=f/Rs3O+O2uZinwrSZMFhwM3ZENzInEEHOBaE0DsV/xiK
	6r4jlvNVXB2DMLyN2woWauV3COLrGsjOz4A3mQBl41JL0rG3TV/b2evUJgq2tWnB
	Z2Hxi47puhq18hTh8E2mFFewf5WaTZs4Dr5FFOxumuOiyo+YeDjACvpQg07rSom0
	mtoYhA+XIaAXKzBangC8QqbSTSmBMBStP1rWnLsx8n4jkgsDNZ2PhB4TPdBj5vZ3
	ykD6aRm9Fyp34DdJOm5tPT6a9/c5Zmg+3fjoL1X5X28kgh3D6Az47bdNg86pFJEs
	zP6iXNdlItMw5ppjmViX4jbdIkY16igS8VbWmSDqZQ==
X-ME-Sender: <xms:5FUOZ5EVN2LKJra9c8hAtGfecwfDuoBwsS9aMsncmSQGFnfCP7ExMQ>
    <xme:5FUOZ-WQdjbiyeoBPkNVU3dQq3FZ_LvQXDjg0_TXMTGZEpy3ENVZmXoOL3AAc_7ZF
    mlKXFH2lkGPhtXTLQ>
X-ME-Received: <xmr:5FUOZ7LHJdeFrv9Z9p2IA5aWp251jckDaKUjd3CgGTcu37-y1NA27NCkpBWVnPc_vxczkZ6NNf9icVH-7kYdOGRK57Rntu-BDupMonRhY3oedg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:5FUOZ_Fee0WzipjI8vWEhcUHSn3Z-OUVhNV8poV6GAFnNiqltRmCCw>
    <xmx:5FUOZ_W2Qy07etoUyXZVRRsJz8SqSX7K3QhgBbznwsOm2-Ek9Ak-jA>
    <xmx:5FUOZ6Og97yohCZ13xqsKBm4Xm-cXrzc2dxfMNmIPRqsMr-zDVHJ8g>
    <xmx:5FUOZ-1oo9LH1bCLdYYePWxYAwENiwptyrSwdUOY-OqswEAmVzKWkQ>
    <xmx:5FUOZ6RX6IInRBmwsH9azPqju8m_0-_ZdRpykW_pWYTRPi1ioB0aUpid>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 07:45:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f9a88d9c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 11:44:25 +0000 (UTC)
Date: Tue, 15 Oct 2024 13:45:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 10/10] http: fix build error on FreeBSD
Message-ID: <9963dc73988864b58e5d45e2c1039395f79fca57.1728992306.git.ps@pks.im>
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

The `result` parameter passed to `http_request_reauth()` may either
point to a `struct strbuf` or a `FILE *`, where the `target` parameter
tells us which of either it actually is. To accommodate for both types
the pointer is a `void *`, which we then pass directly to functions
without doing a cast.

This is fine on most platforms, but it breaks on FreeBSD because
`fileno()` is implemented as a macro that tries to directly access the
`FILE *` structure.

Fix this issue by storing the `FILE *` in a local variable before we
pass it on to other functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 http.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index d59e59f66b1..72973175a85 100644
--- a/http.c
+++ b/http.c
@@ -2290,17 +2290,19 @@ static int http_request_reauth(const char *url,
 		case HTTP_REQUEST_STRBUF:
 			strbuf_reset(result);
 			break;
-		case HTTP_REQUEST_FILE:
-			if (fflush(result)) {
+		case HTTP_REQUEST_FILE: {
+			FILE *f = result;
+			if (fflush(f)) {
 				error_errno("unable to flush a file");
 				return HTTP_START_FAILED;
 			}
-			rewind(result);
-			if (ftruncate(fileno(result), 0) < 0) {
+			rewind(f);
+			if (ftruncate(fileno(f), 0) < 0) {
 				error_errno("unable to truncate a file");
 				return HTTP_START_FAILED;
 			}
 			break;
+		}
 		default:
 			BUG("Unknown http_request target");
 		}
-- 
2.47.0.72.gef8ce8f3d4.dirty

