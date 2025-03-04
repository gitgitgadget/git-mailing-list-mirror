Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69431FF7B0
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088341; cv=none; b=n7AaTVaI2H+abz+lrH2eKPZN/DcRDdDFMOfthFCwoQ33GwDecx7VksljkT8Dbufoujf0qFezR+v57AE/vUT/ANoUzjhzIuV90iXpfp1Y+dGfwQx3ek7KJBHNYHqhkunOevxEPMpQHRpRWqq/CGAJ0Xfxt9Pni9WhP9N2c5kThfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088341; c=relaxed/simple;
	bh=xcc01UBO2lezyw+mn75M1hX941cn90JrnM2W6qkJxs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJQw1Lupnpaw1BGCrPd14RciIZCEOUtfJMHNBu0rYYfW0sTb9NQMTxUeOcuU8v5xhCvOEKP38DjZUFfBA7Ny5WblyBdwl8iPmgjCVOFoJJkMPSiPW9wL2Blhc7/ZnRoEjcHo5hajF/yFPGb9Q2WfizTIA9+Tfz8WR1d0fOnws0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vw4amekc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ob+hHfew; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vw4amekc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ob+hHfew"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id EB672138274A;
	Tue,  4 Mar 2025 06:38:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 04 Mar 2025 06:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741088338; x=1741174738; bh=3YoPPkT3yw
	t8xJ6ferOSbGHr2dryE/zBEniICth4JDc=; b=Vw4amekcdPiHcK3/68DVwABp/O
	eeYcXZOqzxTBN2EzZT6vZRwxi96jJ0OhdUPV4uKnS2OMugFtkjlw+roulL596qaW
	+v/anQBx/j7mnn8fCuFiRz74kpQt1Sg1EnL6M7C6ieiVx43m7PdlZConL19oSmdN
	a0xhrlQxA4GOcmlehpC3XFD+r8EyAQ7hyZs7iOjdaZllJXrAph8Qv3f4/BHz+YtF
	Z+4TRZo16x7E/jDHDFbRvcHIbQqAwU8WBwCGhVzAM/YRS6Jx0wjg6GC3D/r7M26m
	zsLX/QKFTzYq59Y92hcikUlq7molF5UVZPgoxxYZ86Crm75BLwhDR2Os9jEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741088338; x=1741174738; bh=3YoPPkT3ywt8xJ6ferOSbGHr2dryE/zBEni
	ICth4JDc=; b=ob+hHfewOyP9Btnll+Ynq64gkipJqAd0hHV4jF9c0JUZrAbAX5e
	hRQTXlcWU42hfP7bvIGUu7vEjfR8inJZNTCwWBt3ogKs7KFUtEmdXikf9l2uipxa
	7Ec6Ty0EOwufe/guFVTqyFFsnSdtrEyecT8jRdy7IMLcmmvW1Opa4MS4OSrHpS0D
	DKMb+OfRND2SrvdkaMAnarGz/jLypyLSo85HfX7EMgloB6xDW+cQ98cww1dTkGuc
	HJbvf5qql7ITZmnKdvRPCyorHybBQGokQF+6THg91hiJjwyrllThlsjCmjVPaWsr
	GT1ghru8Lbmitup5kpVArFvyOr7cHKHvF4g==
X-ME-Sender: <xms:UubGZzi6zrMUIv2ZDR5ReqJrnY9rfx9Mw3WueHV7agTcAN9TUmnExQ>
    <xme:UubGZwC26c1lJkLYiBLxq0ygmnqE_3nWhuX1IAqRIq0aPNR5s0j9DRZwmDYHuGmjS
    Ki-ScZMksnGQo6szw>
X-ME-Received: <xmr:UubGZzHWZmX092MuabckrP3EQKd27RdcgfU5SdUQpl0qshUIsDgke2z5IxU61_uASDLzZ6cxaFnYvueJ7Z8R7rWBgpZGDyW6QdSaFaYPd_4FvGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdduleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhr
    rghkkeektdeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:UubGZwSlSMne3MCPYXW9Q43HVq-a9RThz7xv_DwMypmDIe_z30XZTw>
    <xmx:UubGZwyfI8wDRF_Vygggx9_Wf-RweAAzPAaDPpCwvX0osI7RymtfCg>
    <xmx:UubGZ24cBnTO6i2HvG_lXOnkWvvxzT5rva6PrqAEFhyq3hvlIOo8BQ>
    <xmx:UubGZ1yAKvDuIP7GFkQeIjHLGu4j35V5J7hCQL3RlX7nD0vy5rBZUw>
    <xmx:UubGZ6s-cWEVaI_yfvUcCA7hY7ECyGAkkTs4MRRm6LRiNVly4J9793vk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 06:38:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 15bd26cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Mar 2025 11:38:55 +0000 (UTC)
Date: Tue, 4 Mar 2025 12:38:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: SURA <surak8806@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org
Subject: Re: The transfer.hideRefs of the upload-pack process does not work
 properly
Message-ID: <Z8bmSj_Ds7ePpzBM@pks.im>
References: <CAD6AYr-ZC32VNfUfMB63H-rQRfTdV=VQfBm67i2mG+6GDCNxkQ@mail.gmail.com>
 <Z8D/aiqN5e/aRSn7@nand.local>
 <CAD6AYr84KuBb5N-LVBQo-6Gq2Ms3JKQCk0gyO8i=N8gp3whe_Q@mail.gmail.com>
 <20250304075113.GD1283943@coredump.intra.peff.net>
 <20250304075146.GA1297781@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304075146.GA1297781@coredump.intra.peff.net>

On Tue, Mar 04, 2025 at 02:51:46AM -0500, Jeff King wrote:
> On Tue, Mar 04, 2025 at 02:51:14AM -0500, Jeff King wrote:
> 
> > From your reproduction, it looks like the issue is that for loose refs,
> > asking for_each_ref() to exclude "refs/heads/foo" will not yield
> > "refs/heads/foo/bar", but will yield "refs/heads/foo-bar".
> > 
> > And that was true for packed-refs, too, before 59c35fac54
> > (refs/packed-backend.c: implement jump lists to avoid excluded
> > pattern(s), 2023-07-10). After that, packed-refs exclude both.
> 
> Oh, and of course it would be interesting to know how reftables behave
> here, too, as I think they recently learned about exclusions.

Well, we have tests that explicitly verify that prefixes cause us to
exclude such refs in t1419, "overlapping exclude regions". So the
reftable backend is bug-compatible :)

Guess we'll need something similar to the following:

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 7e90e13f745..45462f2ce6d 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -594,6 +594,16 @@ static int should_exclude_current_ref(struct reftable_ref_iterator *iter)
 		if (cmp < 0)
 			return 0;
 
+		/*
+		 * The exclude pattern needs to either match exactly, or, if it
+		 * is a prefix of the given reference, it must be a containing
+		 * directory.
+		 */
+		if (iter->ref.refname[iter->exclude_patterns_strlen] &&
+		    pattern[iter->exclude_patterns_strlen - 1] != '/' &&
+		    iter->ref.refname[iter->exclude_patterns_strlen] != '/')
+			return 0;
+
 		/*
 		 * The reference shares a prefix with the exclude pattern and
 		 * shall thus be omitted. We skip all references that match the

Patrick
