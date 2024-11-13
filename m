Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E3230996
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731481597; cv=none; b=fVS6HI8kho+9EBc/XnBGj5J/atyeVzFg+F6KJjJn7nDeMx7LDCFzeu5g2RgUIMrtKRDm1vPhVJxcqsTZA0UT3j9KFlTqXyjvp/ojQRR9SLejGjfaqQr2Uv1k3pOjld+cH7WKi5orVCE3gB3UgXC18oAKjhZpda6JgxWymEfAdBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731481597; c=relaxed/simple;
	bh=CodND3pYHl/k3jCIlIBN4bcDNF7j9J1WS92b872eUdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhPnh1mjYdRbO1WHLeLfACtnrxeKTcnKsw/meebnaPmMagIOyOn+cE23mfCXF+bVcsd8Uj5G/SfSZA+fRmKLm5Mq3k/HfW5sG0lsi8Qf0DUospJrsN/LGdfOoSdkmPA942INqPxuKvoKbHhKm2az+Abnoj8kfsonW6E5LotYZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XuccTIp8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UVte6z7z; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XuccTIp8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UVte6z7z"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 862C61140192;
	Wed, 13 Nov 2024 02:06:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 13 Nov 2024 02:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731481593; x=1731567993; bh=uxUqlco9M5
	e77gdJTnbHEosZQ+LpQJBDCe8SVLbL2rg=; b=XuccTIp8UapOsAnJzfKUTJ8yfD
	USl+y7DwVK8QWZDE3i3fIccLZJ4P3uk5gdfO5WWTEOFnSAij+CnAgc5OMmQAtrUM
	NWDx8aUK0F7YWm+tcQb0vHQCKKMiFzXyBfxIJmU0mvl9Pt8rh9xN+EnDtS7ZhgVZ
	I1ONJXwHiRS+tUFr67VcXU3fN9K0aEnPutmRahnfJYV4g1mvIO4gwC6F+uVbAKqQ
	P4x+X7eer8Apc1NTkIFmUlkMxIXSkqtcNnBaBSRXwUhDiM2s9xNk0JlpI9x9lztt
	hUP4ztkqdQWSLpqvuAY3nQ1ekMJRCJYvyTJ4XDV6b7r7HS0IkDhU0Omul6FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731481593; x=1731567993; bh=uxUqlco9M5e77gdJTnbHEosZQ+LpQJBDCe8
	SVLbL2rg=; b=UVte6z7zB5I49qNrW03urs4hvHiAfoNXweUdL8TUq95YvRXeLEi
	bDcmk2/tra8evQ+vtNO7tEz8pr3HVagujOsjivm4PuAN3Gd/n4CMzuu7WqP/n90c
	HoNLyrTFfPKM5gHo33JTH64z3DTIbBEgu329+1pXXSN9BRKwzt0xczSwha654Ymb
	gl+fs7cavrF3a943J2C3GEWAjNvkyCZorcCr4wSgOGEXL8yLh3f2m1pb+fk+Kx8Y
	bcl1QtXgvrj3aTPXJtk3pwXZGESx51kwKdvC/NAyivE4Ztv/m68tUcTn80lie0Gs
	TPYUvioJD0Y2JvcPjypH+/4rOKS4SYY6Idw==
X-ME-Sender: <xms:-U80Z2oazb1N6vRUFPU2R9CTWM10q2Cqi_biV4h4SVma3jetsNiKJQ>
    <xme:-U80Z0qXvaN9bExDOTicIaps9yZBP8e3QmbF2n3jaVZY-oQIUXQTWxZ3XO2S-5f4A
    JszcZGacdT18MTEVw>
X-ME-Received: <xmr:-U80Z7M-PqnjBxUgIDFhJTMUe0oJDPgFVNByGPJPkUVpMcnS9oNWsutbTBgt-ixHjHeXPTnQZrp1T7TUzRAiMV5apyZ5MbKHdMX8admHSug4DKU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudelucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfurfetoffk
    rfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgg
    gtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhgu
    thcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedtleeijefgledutedtff
    dtffetledtudeilefggeejheduffetieelffeiteffgfenucffohhmrghinhepvggtlhhi
    phhsvgdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-U80Z17wvEcSTjcQlMTjznba3inFMcv_wuZEjripo7SB4C_qhMwo6A>
    <xmx:-U80Z16QUqLssUvsNXK9T74ZPIISi9BqWumkXByyeSstpqC_fPDQHA>
    <xmx:-U80Z1iIamaC5GPmYSrlJ151fh-D996iV8Vn24XOHk12GhUHVzor4A>
    <xmx:-U80Z_6umMW20gBZSbfQnzRqiGw6qj_N8DSFoBxLGOoyD7VgqZPC4g>
    <xmx:-U80Z1ELsDAb9bHNVu4e7i3dryrTLFCTLB9tvkCWMmWndM73OWoqoFnr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 02:06:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a15b615d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Nov 2024 07:05:52 +0000 (UTC)
Date: Wed, 13 Nov 2024 08:06:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: update to jgit 7
Message-ID: <ZzRP7cR6S6YCWIze@pks.im>
References: <xmqqmsi3262e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmsi3262e.fsf@gitster.g>

On Wed, Nov 13, 2024 at 11:58:17AM +0900, Junio C Hamano wrote:
> The version of jgit we use for CI has been 6.8.0 for the last few
> releases; try to update it to newer jgit 7.0.0, which is advertised
> at https://www.eclipse.org/jgit/download/ page.
> 
> Note that this new URL seems to fail to download (together with the
> URL for the older 6.8.0, which is causing CI failures) right now.

Seems like all of the downloads result in a 403 now. I was digging a bit
through the mailing list archives (jgit-dev, eclipse-mirrors) and
couldn't find any hint as to what is going on there.

Other downloads, like Eclipse for example, work alright. I was trying to
piggy back on how the URL looks like there, but without any success. I
also couldn't find any mirrors that have the fil. So either we just wait
a bit and hope that Eclipse will fix this, or disable the download of
JGit for now to unbreak CI.

Patrick
