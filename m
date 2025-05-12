Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB284C80
	for <git@vger.kernel.org>; Mon, 12 May 2025 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060878; cv=none; b=UdXDJiLce458gUIYyXE/SIquzgiG4Y9kzBxfpRHm+DN7NhVx7mt5ZkYPqsovJMsur0AuATGnQ8hG0IM3W6OztU98hVEch2Frji5LzQpA6KXUI6y6Eb2LdPOfLEi4OOSyDlDaAYX9gcJyovn2r9fr3wPS4CFB6Q59nkWl0ShPGrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060878; c=relaxed/simple;
	bh=taP2ow3UQk+itiZUmo9hn0jU6aTal52J4WbXeJySJ0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRfGxKROheZLESYqb6dBEVHLMF9iUtabc5GIQMYUeTFzxLJcNkwFnMqQ8c/cXQ51Ei/0mdM02q7Q07rhg76uuO6FGqDsKmw3nNp3f+cAot433E1fMk5sLsfenuTkz17G+3NydreaW6NhuQMinnYVwdf63OKmS+ypPiab3/+P3+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KB+r+kWD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=imD+FKyX; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KB+r+kWD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="imD+FKyX"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 03B1D1140087;
	Mon, 12 May 2025 10:41:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 12 May 2025 10:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747060875; x=1747147275; bh=KQyf0075ad
	W2EacuYEfoZMf2m5zVHLirYDQgdSou7i8=; b=KB+r+kWD7HJInAnMA2X5Fm+zwk
	tunMnqx8O8+OfH6eQtMDs0pzaIqZopw0nfdOgat1qC5dntZ/n0QYp2oaReq8ZTms
	CjGWq7cuRBaaaP068NPqb52l2PRa03e2ZA66zT+r6sYJpnzITVefbIjLlfv5VwoH
	3oCWlzZiwNUTz26MQC3ojxeY9HZwFPK8EO7w1DW5AfbUw7ceZwahNXejPekPTwIO
	z8WdcMRR0D/91VTIDabrdawzo62Uqua/GXBO2BDjofcJtmYel3h8oNJ/IBGkgui3
	zzlyvVnehRmYJJHjBXf9iOmfIrW3l2NYawWFlfpi+InqiCp/dEcn7OWoP4HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747060875; x=1747147275; bh=KQyf0075adW2EacuYEfoZMf2m5zVHLirYDQ
	gdSou7i8=; b=imD+FKyXl01ulke0Vg5a6pX/YIGsbu43x1O1VHVAYrVkL/apuvy
	BPEqxvRSztGX8CZyjZrf57+trfgV21kNhql1weDEM8cPBTlALoDv0IwFNn3GybiP
	dJGU1BgxLCK72Gw/MEp09qSZvl2DeiI5KWAybg7U0mNZZeMuTgpLjCyRGCMM8rtG
	ievN+rOgmR3zFOP9dU0LKXgIyx10FyPUJFIP5kK0HzFV+zC34IfgbgVbfjtK4NuB
	uPCg2RuFvkJDcIPeblB4R3yXjab/E2gsBiW+efxtAgGBUMXBLHNwRdqMRiqYIGuM
	P/N55ZSPzg/BjaEmJZgvq31of8xzw69YMgg==
X-ME-Sender: <xms:iwgiaBUYdh4VH7snKrSVAMH1dU2EvHZLFvCqFggQpDpYpgY0xFwyEA>
    <xme:iwgiaBk7PcNaI4RAY1PeDXUgGXe1t-2W-51AOdIrI8qx3CCa4w8HMgio-7srO6vQL
    g29-4aClsbUmJ_gPg>
X-ME-Received: <xmr:iwgiaNb3lkQkk2kGM3RdB-ffry1MB0CHsNZs5SoOrBta_V5x82GaXjqrKIJdbbPZZiQIfEK0H5qnh_0brzQVvDaEotaabcRpINaQcR5E4mE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdduheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrg
    hilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iwgiaEU2HSkLwtFL2v1BEmv8rirM6WhClZ5sXcRTwFM5QthFBDJ-tA>
    <xmx:iwgiaLndEdoDC7EQ9GXhGebLasNgoObcbkhtbM4k1UKXYFEIBYa6Fw>
    <xmx:iwgiaBc6QjxnRry0Bl4tSxesJCFEqkN3DCaWSV4tG7nnQ4azhCAKLw>
    <xmx:iwgiaFH3NBrHiEOz-QjhHX4lSE-9dmbgvKF-CXy6ifCY4pDMtQyDtw>
    <xmx:iwgiaB-Wu5HqTVqIrAkyvgTZ7DCcK9YlUvIjNRawFnFNh_HF_qp5FbEk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 10:41:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7dddd9e0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 14:41:13 +0000 (UTC)
Date: Mon, 12 May 2025 16:41:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] packed-backend: extract snapshot allocation in
 `load_contents`
Message-ID: <aCIIiMGSF51-qUua@pks.im>
References: <aCCtQDnWII-knmEc@ArchLinux>
 <aCCtzm2bDRSTgEO-@ArchLinux>
 <aCGzLxcXlcQLtorC@pks.im>
 <aCHO2dqWM2m6xt9m@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCHO2dqWM2m6xt9m@ArchLinux>

On Mon, May 12, 2025 at 06:35:05PM +0800, shejialuo wrote:
> On Mon, May 12, 2025 at 10:37:03AM +0200, Patrick Steinhardt wrote:
> > On Sun, May 11, 2025 at 10:01:50PM +0800, shejialuo wrote:
> > > "load_contents" would choose which way to load the content of the
> > > "packed-refs". However, we cannot directly use this function when
> > > checking the consistency due to we don't want to open the file. And we
> > > also need to reuse the logic to avoid causing repetition.
> > > 
> > > Let's create a new helper function "allocate_snapshot_buffer" to extract
> > > the snapshot allocation logic in "load_contents" and update the
> > > "load_contents" to align with the behavior.
> > > 
> > > Suggested-by: Jeff King <peff@peff.net>
> > > Suggested-by: Patrick Steinhardt <ps@pks.im>
> > 
> > Huh. Are you sure I suggested this? :) I cannot remember at least.
> > 
> 
> Because you explain me a lot how Gitlab handles and Peff tells me how
> Github handles, I add both of you.

I think that would've made sense for the last step where you introduce
the adapted logic. But the intermediate steps have all been designed by
yourself without my help :)

Anyway, I don't mind this, I just found it to be funny.

Patrick
