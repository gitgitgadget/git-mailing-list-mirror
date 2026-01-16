Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123C213A3ED
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557747; cv=none; b=UocqtBd596RMK7UGss9w/uTQHTYvLhGu587o6ITBR8pEi4ay5ppX20dwIEvx3x4kKyNLtVLUilAybScNVGKfg45gpGyzWoXheB1wDmg19pZTqoLJllfislq5tmS135u9zgw68ikXNah/e4VJMPAk2mXRPFyvL6LoJoYZcLnV8o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557747; c=relaxed/simple;
	bh=Z6SlV4Sp54f8JvFBx3AxXDN/F+GUz7yH2+mvyHGN5ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVAh05g5/nACC2Ol2y6SgfHumVZUNjQJqrz0KGRGcYukmIhAb4vJO5gax9j8ZoOTLubUqn1YVkMPDrN64iw4+7VLawtEXTGaB6mZTB64gKdRWMdWO2LR89m0x+hP91oXC2woIeAMcXf8udVOtEG6BivLXBVx+rzM4mki22sdnjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VAhhFmbb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=do9r2r0M; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VAhhFmbb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="do9r2r0M"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 215CC1D000BB;
	Fri, 16 Jan 2026 05:02:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 16 Jan 2026 05:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768557743;
	 x=1768644143; bh=w7WYl3bxRBmSvPIyBxZ99mhuW2iUwnD4a/qv5AiJJ7Q=; b=
	VAhhFmbbzMAItIZoRHR/OTQjDWL4LMuaolCvd2rsFVRrAQXfCN7BZV8Iz/ddzyaj
	tc0dhEJ3Smm9SF2xuHDmOgsw+eBaz/oxAX6IwM0L5h7nPYem053A7vpnKB5cC8kN
	1SXWK7ihVLcQ5n5hmM2Y0yyvIOtHWx8ZvL52ZDaLiQwX7VcHgLHqk6nMogQz+R7e
	DspgRe9oPzv/NcrAhtwJIRkHWViW8IXsLfaaMMk8+FC1ev+a99IHDXaEcvzK8RvO
	7G6mvkUYmL9bvqbC8NUylyht1Rb6jZuwxhvwV4JaGVcCIQDyh+n+qqOp0ycv0GKK
	/kVGWuaJdb0rX57h5OjHAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768557743; x=
	1768644143; bh=w7WYl3bxRBmSvPIyBxZ99mhuW2iUwnD4a/qv5AiJJ7Q=; b=d
	o9r2r0MgYCDEpR04expEdYtkBceU2FfreeMmzQ7zIN+LE8/5PJvXbDmThe5FaHZt
	T9MyLAsAeoPItuItRMSHPQeyRFMpe2bGM37Sdc8/+cfkxyIct+LHTqRRaCebJcbY
	IUn9ZgVS12Opwr0HJ5R3Tx2nbXiX0UtbapPc7MVbuOLinPCHlDnGsAQ3i9yh9yiq
	UGJte2mCF7vP0+2D5J4EknnZYHj8OcWWxDwlEkhUk/W4VoiV0t4by4DXw4jQaQEP
	eGi4n1AA/AzTqfXMO1IAIKzQJqA6Fj2loeHQxNtOtnnLkGVVUS+WFlbP30yi1iZr
	N3huTPRn22XoapeAybHlg==
X-ME-Sender: <xms:rwxqacDQxOalJDRr5dTRG8lIUvWIl0uJYo6K8VY58I66tBo6vrAiZA>
    <xme:rwxqaV9ZK7gIAVsDo1tP_CC_SYW-qx2knAHjdu2Pa5bAP4N7w5iQ026FYXb45acPf
    Fw9fRYlxXZTVrEP6o0l84KxWei9MGXdp9DIHnac24qH8RJisVmigw>
X-ME-Received: <xmr:rwxqac9v0labJmRi63VmxcivoHXMzMsKB3opY7emZdopN2to06ezdoz-Jm6rPdK_Q2A0bbV3Qc-X4weMeqMEaUV06n67BtOuIwL-1LBT9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    eplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:rwxqaccYrIXWJHAmRF0qxPK_cDSIgNtnvNpqLyKuSpYMJVCm14JbZA>
    <xmx:rwxqaVHSXlzto6vdCWeYPV_AQoyzoksvm0Nu0ezV55UZsn8PgTHIJA>
    <xmx:rwxqaafTkbCaL8iCNjzjG9whKGgMgpLnmgS7RYS6q1CDQQeODi3wmw>
    <xmx:rwxqafExBpA6RovxXYXQ_rJz7fIuhr78vr2Pu3Mg_5rHEfpO81o7yw>
    <xmx:rwxqaYn0xg29FQvfsk3hb-gEQs_uVg15y01ifsvcL1V10Ae6yc6gWFMP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 05:02:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5543ce91 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Jan 2026 10:02:21 +0000 (UTC)
Date: Fri, 16 Jan 2026 11:02:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/10] cocci: remove obsolete the_repository rules
Message-ID: <aWoMqfTmrOU8UMhm@pks.im>
References: <20260109213021.2546-1-l.s.r@web.de>
 <cd6e8f5a-baaa-4c4d-9d2d-576d4b6a9a5e@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd6e8f5a-baaa-4c4d-9d2d-576d4b6a9a5e@web.de>

On Thu, Jan 15, 2026 at 11:01:25PM +0100, René Scharfe wrote:
> 035c7de9e9e (cocci: apply the "revision.h" part of
> "the_repository.pending", 2023-03-28) removed the last of the repo-less
> functions and macros mentioned in the_repository.cocci at the time.  No
> stragglers appeared since then.  Remove the applied rules now that they
> have outlived their usefulness.
> 
> Also add a reminder to eventually remove the just added rules for
> tree.h.

All of the removals look good to me, and I verified that we indeed don't
have these functions anymore. Thanks!

Patrick
