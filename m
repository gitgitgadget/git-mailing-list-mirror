Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0E916EB7C
	for <git@vger.kernel.org>; Mon,  5 May 2025 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746428171; cv=none; b=BvEwiHTuewfhk+cL4Ol2b1ydSUfExXuIpPJnpjzI3GkqxHuCGc3Dr8cUGKOHH8xGWUDmsCmAbPC2HKDI/m05JIkYSdVak5rRtXkOpWwRPh0IFN7rmSQjG6hWaG+Bz/2TyEiIRghT3c1tXE2UOQCMJ3cO2Ne92RE6nzOdInYyW9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746428171; c=relaxed/simple;
	bh=y0hOKnDRP/krKSzdSoygBxcSmP+9RbUDqJG0fcqLPYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcy7v842gz/trI0S8tyjfu1VrBjo0/8QhYFVCuHT5ZgT3xbHa71IIbpHIycZR9+TX6a2Fe8uVgkG1HcdYivYYZiA+M86YjEB9b/NzuOiN0CEHJENGEbF0+TpbPxv21DrRFrP40SRrBojfW2CV+kB9yBjU2uNrhl7mZC/NWl0/is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RJOW0fFh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hxx2YtC4; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RJOW0fFh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hxx2YtC4"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 71C3D25401B5;
	Mon,  5 May 2025 02:56:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 05 May 2025 02:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746428168; x=1746514568; bh=Jlv622kl91
	Tpd4UwhmkKFQhbga/w+rR2Vc8xiIuJi2A=; b=RJOW0fFhSa6qCWLs68gw1rtAmh
	aSiavqa4yIAglylbqrIT0N44ABkKUwnhmx0sj3FrV9mn16nlx9hPqkyiNgwzv+tM
	ESrothdCPizfNCguw/xGc0+x0awGlSyFfDn3nngZien7K4h1NhRr9OEBYDfFSQir
	qyccJoJn6Mlvpa371cnfD51utaPy+r8EQ9nlMT48XTbiJsjpXipzu3dQ5hsD5l/L
	xLBixLgYI/uXOmM+lfAxnsVuBYm6mfuwGeCPt3pYSByE7/awwzBCRyQixOabwHdu
	WrGKbmzSufVXUBqDMyBrmUCzXkdgJiOgMosqsV7z1B6BpbsjlX0J3/G2NgOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746428168; x=1746514568; bh=Jlv622kl91Tpd4UwhmkKFQhbga/w+rR2Vc8
	xiIuJi2A=; b=Hxx2YtC4iUFNI/QXH47CKGuz4okRYy4gdqLrOpVlQkpOGimrzpd
	FzCIX+/R5bu2OzskcsGSiyikMFTUVbBppLxkfhnqnENBVjbZ4Ung+SfonTG0LRpe
	EyurP1W9V9xNMaIKgXztAk+NMKzncN8Uqk9/z33LUy+tDiWBN4LtAcRrr3GmWB6H
	m7K3GPuqkhrUMwg4MjnzBOl43l0hUYL8DpZOgDyss5mFi1bA9J75mGQFUCyEiaST
	mQu+B4c3B/DkhDYI+OelwE/L0yIxjLhxOA3UTtvcA+LuwXi7jmajTwnW/OTsTmOP
	g+tMMlUzzC/OFY3MamJOPPNMvFaaCBqUU3g==
X-ME-Sender: <xms:CGEYaNgEDsDOj9iCTOBxxkcXGd_-dYdNSQ94kzAGeKwXHfdnw9xorg>
    <xme:CGEYaCA8aG0n4EF38IWVn0pBppZYUOKbgSG_mToZe-kcrRLKEXD2rO_ccJGJC_hKj
    Plm6V12L2QAOLqsVQ>
X-ME-Received: <xmr:CGEYaNGxRmC7yzH44aB4KWHydpbKRROKIXTaZ8g7afazsMgH9IcPzKTq-VyuaZDiqCx6-HeE6uWtwEhPV--3MqiTlhuLm2iIwDj7XJWabRPwGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:CGEYaCToavFN9S5mLUVST-8Wh7gbHTsJ4miNdDyomghiUohBUNAyhA>
    <xmx:CGEYaKzziEzwmRvIciTmA9ziO1uhD3E2XB_mECAtRM940HvKoCCRgA>
    <xmx:CGEYaI7ksuxhGjBw_9GJ3Tk6Got4mcH2WjMFli2LGRIeW_mITqjqUg>
    <xmx:CGEYaPx1CMs_i2dcs7A3UVEK7ecpy9P6jmEI8oquV7nJXZvrdiJ-rg>
    <xmx:CGEYaBhrXleFSDvbGsTZ6cQGz56RuneNHDnstS0_S8qW05XXIH-IdDSH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 02:56:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9d352d2e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 06:56:06 +0000 (UTC)
Date: Mon, 5 May 2025 08:56:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 4/6] whatchanged: require --i-still-use-this
Message-ID: <aBhhAZJYXAhBVw61@pks.im>
References: <20250501225958.2947677-1-gitster@pobox.com>
 <20250503005814.3030099-1-gitster@pobox.com>
 <20250503005814.3030099-5-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503005814.3030099-5-gitster@pobox.com>

On Fri, May 02, 2025 at 05:58:12PM -0700, Junio C Hamano wrote:
> The documentation of "git whatchanged" is pretty explicit that this
> has retained for historical reasons to help those whose fingers

I feel like there's a word missing here. Maybe "that this command has
been retained"?

> cannot be retrained.  Let's see if they still are finding it hard to
> type "git log --raw" instead of "git whatchanged" by marking the
> command as "nominated for removal", and require "--i-still-use-this"
> on the command line.  Adjust the tests so that the option is passed
> when we invoke the command.  In addition, we test that the command
> fails when "--i-still-use-this" is not given.
> 
> While at it, update the documentation page to use the new [synopsis]
> facility to mark-up the SYNOPSIS part.

This while-at-it change feels a bit funny given that we don't touch the
docs at all, but I don't mind it too much.

Patrick
