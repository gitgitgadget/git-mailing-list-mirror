Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A2156C52
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334413; cv=none; b=hBJzqklmJfRC57yJqp9/olZv5zKU2rIw1xmQw0J3P+gx/AdYRvWz82eqIjtymI+bsjSR1DzO3Q/Eg0isSbKpiCVtcUZyEm9c7b164Dy7HQ6iGvIcygP5G9rFiQMS2Lh3Tx4gnKslFtURn259UsQbzu7hRLKAESA4EPsrE5h0NxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334413; c=relaxed/simple;
	bh=h9M01ViILJNPcW0FrVOFOtHIVtKjCl9mgFeTTAFdtVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idF8edo7ZLYhiCKi01t2wxLEtaw+K4GGsocfXPqX4lUZxyweZePZfXVlYSAF87qdWb2xjTEmaV0zi2e1J1ZJpBH9cp05P+/cYtkppwr+ST7mu/Pf2sdNaOs95DgyFbiOKjJFROB/o90lU976d00SqEonW4WGjkcI7vWGScWB9Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YDS91c8u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V1pFnAa0; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YDS91c8u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V1pFnAa0"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 6F18B13806DC;
	Mon, 11 Nov 2024 09:13:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 11 Nov 2024 09:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731334409; x=1731420809; bh=dZIYWobXGd
	YzXuFMRFb4S6DFrsVpae+b/0pQx+6yzpM=; b=YDS91c8u51AMR3s9KRtZKo/iju
	UquHJB8TsfZ30wujl+3LRsBRcxGvZmqz1RrwZPviCG2Evks8rE2fDpo+IgqX3eMH
	+THHBSWs/H70rvp/ULW7LYXxitr4jaI9aiOsLtru/m7Ho3tdn2pR1OrO20kiVOxI
	UYODToE6uDMVUsXryaI3MupQ/dsRlPxafARb39q0pt1kceX3s+K7VtuL6IzxSbGt
	aMlt3SEIN7xVTSYSdO5CHricm6UcJaC1ckPzpa2OKScKdLDjga8whMT8CAcHESBb
	4GGTntmOdjfrVQJ8efhD7BotO2w23OMZ84bgex/l4TermlPbz4+UtOJzmvHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731334409; x=1731420809; bh=dZIYWobXGdYzXuFMRFb4S6DFrsVpae+b/0p
	Qx+6yzpM=; b=V1pFnAa0oQ40FWxV5qwda0WY1LNhZsB1ItXK77teL/3yutxDOtx
	kECpoyjg/j8HtfzQ4mosRXXWECOYtKNeDYhyCxGSiU7rwdIDQa6Iq/Ay9pdIwUib
	sLQ+O5eHTsGyg2oG5WACjGEK8QIb4GijGCqXhipZglorvnXy6ezIshmFttK10BjU
	M65e2FPZG47WJ2rNTGElgWf0z03xqJyU4igfE15kWcc3J9tXkHfj0H/Ouec6gt9V
	CQDqLYGyO6e5JsGk7YQP9S8lcii8GBC+wJFf3/v6xHGn6v01Keb51IyJX8K1O8Sz
	YqGZf7IfSTusbAsir7eFJNnUV9OXRsDXdWQ==
X-ME-Sender: <xms:CBEyZ9WLrPOuNU2EWfci_C3fTMQMzzRBjgWXUaWqANZNXy-JoXNsrQ>
    <xme:CBEyZ9kDa6x63oHzXLUXVX_1wYX1HBqc0mXtmoHTi9q_1-iUaiA5CQh9dk7WcpKaV
    xITPP5jLwMahgid-g>
X-ME-Received: <xmr:CBEyZ5bxcUD2FoB7SNfv1ukA-FJ54CpJS0HeUzOGMCbw9SJpcE1YcjlgSJO7I4GLfTCc6vfBf2QTq1lT_O5ojWhHm7QhDetyfuwBGd079RjeXVtr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    eprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghstghhfigrrhht
    iiesghgvnhhtohhordhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhih
    hnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:CBEyZwUNvN6DKfTkpRLMVxU3ZznWGznYt1JBLpWqFIzRlkGyc7S2vw>
    <xmx:CBEyZ3nNo1wI9AH996v5Vln1vwaFZHCDsyL05bnzGf4U9zH6ihFkow>
    <xmx:CBEyZ9fOy3aQ1RRu36jW29pWKyGWl1Rt2GcnXw0mH_RwekjPy_xwtg>
    <xmx:CBEyZxHNbUMAdAiDBS5anpL9y3gnyksP2vFuVmKwQjtP1dlLmkUyFA>
    <xmx:CREyZ1U28a2QroXt-uDTM08IJv5wuI6K0h5IGG3RPgnn-DVubcjuRuC6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 09:13:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f50347b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 14:12:49 +0000 (UTC)
Date: Mon, 11 Nov 2024 15:13:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH v4 05/19] Makefile: use "generate-perl.sh" to massage
 Perl library
Message-ID: <ZzIQ8zENlz-0CZBX@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <eddafe1cf8935fd25d107645168ace3f65e1064c.1729771605.git.ps@pks.im>
 <6a608200-2dd5-4505-9e1d-1e161ae2896c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a608200-2dd5-4505-9e1d-1e161ae2896c@gmail.com>

On Mon, Nov 11, 2024 at 10:53:58AM +0000, Phillip Wood wrote:
> Hi Patrick
> 
> On 24/10/2024 13:39, Patrick Steinhardt wrote:
> > diff --git a/generate-perl.sh b/generate-perl.sh
> > index 12e116b76e5..cb1629857c6 100755
> > --- a/generate-perl.sh
> > +++ b/generate-perl.sh
> > @@ -17,10 +17,20 @@ OUTPUT="$5"
> >   . "$GIT_BUILD_OPTIONS"
> 
> I need to add
> 
> case "$OUTPUT" in
> *.pm)
> 	dir="$(dirname $OUTPUT)"
> 	if ! test -d "$dir"
> 	then
> 		mkdir -p "$dir"
> 	fi
>     ;;
> esac
> 
> to create the output directories when building out of tree using CMake on
> Linux. I'm not sure why it works on Windows without this, or why we don't
> need to create the leading directories when generating clar-decls.h or
> clar.suite as CMake seems to do it for us when it initializes the build
> directory.

Ah, indeed, I can reproduce this when using Makefiles. I'll solve this
via `file(MAKE_DIRECTORY)`.

Patrick
