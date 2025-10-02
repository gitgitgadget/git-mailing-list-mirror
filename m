Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E4178F58
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 05:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759384049; cv=none; b=ODTsi5IPDYpd5gYh7CN06ARurMsd6Dh0UPB7kXcnYoXCBThOtGHrpXWCxtojLcEVROBOzFFSCfO1/1gF43CGmGATDjaqFxSyKHew/abhiJGSu9smrAVE5f384KpmpYBQG1wpMjTiORRXDTl0CuQanwxcbnkyd4e5hdVLaUl5f5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759384049; c=relaxed/simple;
	bh=w9LmppUQzOlnKkkSTSIWeEelwgz0kzIKdRIRrmHmzJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMpcWAdklOXhgN3+WU1i98Lm1B8ihUMVnG3jQdjlTircMfcPdcFwpQrcbHrENjbECsYTVVtcD3aDUmPMc6a1BnxoovYOL/IVBQbxiKkNPr6ghLbLw0+6NMK+II+aPTNapGG8vK8CxdycmrMXedfjkW6ROptD9xV1p9G4lwvPeBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mANFCEST; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GE14iFpb; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mANFCEST";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GE14iFpb"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A281E1D00124;
	Thu,  2 Oct 2025 01:47:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 02 Oct 2025 01:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759384045; x=1759470445; bh=JuAYBiOOve
	rROYeBRMuTd84bb8SPNaRHF2wqUeCiQ1k=; b=mANFCEST2LCmnRA0FfANdI75wx
	FHe1lp6V3SZ8K6LyDxmvA91IJudCp5PrY3naaeSPlNt4Hl4IcUZNlk96/JWfhIgW
	URhz45yi4b/Q3FnKwl14810CKRaSs8NAaKqhPatJ1IpJjmuCCBfkB2yLKPbmczCy
	Zfe1UpxDEUI6zF7i4VvFUqW2MOYEt4MoP4z1pThsmxIvLDieivuMYGWZ2dG30GbI
	lsYRn0ozCSQgvh101yjyaYXeHTrNcZP+mB4Ksc8gv0571sJR2cfhPjblrzQGGJy5
	OzEQo85lYmzElAX4lrf5SqSpTAweD21ng5V/St/ArQs7GvgScKp1A2v4G6Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759384045; x=1759470445; bh=JuAYBiOOverROYeBRMuTd84bb8SPNaRHF2w
	qUeCiQ1k=; b=GE14iFpbzmdPpOiNEnOIbSD5LYKgOEQlgF0bGYybGRA38oCe2p1
	dP1E11vOq8mfMXfOql3/wuikJjlYweYAIVzuJSNMIvEOY/IhmFk0nj7ap8tZsh1b
	K4K2HU+NISvvg7hQH+WatPaVjho1PhbuEKO5tlFrVsefypr83UQn+Ap62Rl6EXwl
	m0i6E5aFeZHm8ieLKJaZC8mB2PDNiaw0mgZaQdkZp1+gzUbPm8X5UlT79C7qwvXO
	QIcaMLeuQu6V/MWWU9J902sJQjCyeKlEWEK0MIkg/xbtKpPXv+NLsq8h8IqUh2yP
	OPEFbENiP63Z+W3AYHaVn2XadEzyrj18pOg==
X-ME-Sender: <xms:7RHeaLaYnFG_bD7NyNaFs5Q3_nM_eKZGfBt-hAtOidbfDAG8cfzFCg>
    <xme:7RHeaB2Ber5oV0XTbrORo4YaEshKP_7hiJLBn1KydWtK_sMFzvxSdxK3AjL-FplOq
    lPBoNiS6LrFo2xiumdNbHS8EPJMDY-XSfSZ3-LFrAJ5xpV291y0IA>
X-ME-Received: <xmr:7RHeaLUPY4vGVn1L8su_Ky6pMZNdEcoopa_PvVOzG3xOWg2fT_M1jw29bK3IixM6Ve-XzXuXkAWlnYj_Umj3eje9SeUKlqhbgHBuzh0ZWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekhedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgv
    nhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:7RHeaLXR8LJmPqN0WXG8T58oBAR0rp5dCT30FGD0PvnPBRdzALRNQg>
    <xmx:7RHeaKdjL0BECL1REiG2865czXH6Whp1bRGef_hrLneIsB6zO9piAA>
    <xmx:7RHeaEX5OqJIZk-c-sP83d6eSwOraLkCR67Wc_nqjpiIicJxFYxU3g>
    <xmx:7RHeaDcqfx6Wk5prKDYEA0SAJ5rE7gox5rgYXnWOaz32Fqz4rkG4IA>
    <xmx:7RHeaDR98Vd_Rru8XwJSORaE93HaDzS8a1--R61KxqLnbaCXL4aZoGSw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 01:47:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c172dd78 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 05:47:22 +0000 (UTC)
Date: Thu, 2 Oct 2025 07:47:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 2/3] make: delete XDIFF_LIB, add xdiff to LIB_OBJS
Message-ID: <aN4R51_j2ieF-sjy@pks.im>
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
 <28e7fd27b632eeb681e7b9af4de2d18cd327be2a.1759341748.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28e7fd27b632eeb681e7b9af4de2d18cd327be2a.1759341748.git.gitgitgadget@gmail.com>

On Wed, Oct 01, 2025 at 06:02:27PM +0000, Ezekiel Newren via GitGitGadget wrote:
> diff --git a/Makefile b/Makefile
> index e8fad803be..d89ba03286 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1397,8 +1396,7 @@ XDIFF_OBJS += xdiff/xmerge.o
>  XDIFF_OBJS += xdiff/xpatience.o
>  XDIFF_OBJS += xdiff/xprepare.o
>  XDIFF_OBJS += xdiff/xutils.o
> -.PHONY: xdiff-objs
> -xdiff-objs: $(XDIFF_OBJS)

The removal of the `xdiff-objs` target isn't mentioned or justified in
the commit message. I personally don't mind that this target goes away,
as I don't really have a use case for it anyway. But in theory it could
continue to exist. So I'd either retain it, or explain why it goes away.

In case it goes away, is there still a reason to have the separate
XDIFF_OBJS variable? Can't we add these objects to `LIB_OBJS` directly?

Patrick
