Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8CC1A2389
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758005598; cv=none; b=DTeH4YbcZDc9YjrK1KHv2qJNJRoErZAaCma6Tq3pvg0y3Lyx1Hd4qjqHpAT/I3IzmOgvy5qemgZbHGfcXCgpjh/i2NvknL7j7ATBoV2i7PvZ8as2q2m6/P/8aObxw1fdGw/KBdVRfxC50EgOfAWdbdnwCiyKt1dSTCN/iZW/mLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758005598; c=relaxed/simple;
	bh=wnP7SthlUcJGFgBZXgjk+UyrbBmrXXyvi46+EaBkd0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMw2OTtlHCXT/ylL2E/LNKoPSI+brO8c/tsqBopJMnK1qdEcHMXNzRagf06BymWUlG4yI7WiBpGvrOoIHpJFfdcGUwDvksxlnwydd53MUbYDMAPuw4vIvtoy35s8o95Ge3rDzwXlVSkZevdlYTBGGIc4Ar6ns2TROCMB3cyXTU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FMpkXtYH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JTguY/oR; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FMpkXtYH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JTguY/oR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D8F5F1D0021A;
	Tue, 16 Sep 2025 02:53:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 16 Sep 2025 02:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758005593; x=1758091993; bh=sOOY8eoR2n
	WfO5SKDzXCmoE0xtzuZO9yAAT9W/QGyGY=; b=FMpkXtYHhE2KWtUqlLP41p3m+r
	ev1FsURHO5NP7vBwr83B1jzRVf0fh7lbdj+JcBZs7w8aWvnz/nWu+C4lVyv6j06h
	P98OWz4u/+v5yRNKS51k97CLjD4rOe1U9NSCc4UaGAVHIwtZXUqdS295R4vA35JY
	/FGIHFldtREnQBEeEBBcC8TyHmjk4B89pVVhZl0tN9vQ6dh4YKNFT/YXDFQJLSaj
	Bp4/soKEzNtdiXXlvvgPvyM6PIAweTzaELLzsrnZYRtOMMTSxhNy1vfRdFaP/OC2
	tqy8oaxJe05ZUl8LdzMbe1t77RLFFla9ayWS/FRVNe2Y9pVI+62OoSJ4SP0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758005593; x=1758091993; bh=sOOY8eoR2nWfO5SKDzXCmoE0xtzuZO9yAAT
	9W/QGyGY=; b=JTguY/oR5yyXS3GLPOBLPlBUO0eb5QiH3oOPCNXfBLL0+be4rp+
	ktek9oRyBEQHxp2d3biIrf4ob2n/dC0KP/Hr5t/2iTqZuUxsnrI2LM024Vlz9t5Q
	C2MtCTQbEY1JTcgKSzNmtb3A7hdwpAKKiuf+TvhSvN49rwMfKOhsM4ZU4PKjD9ms
	2NM9k8/T/nypuO7tqwZmCHotmDSiGSi7Q8eFYMCzLxlZwTATdjDcnS5uAS1kiGjG
	ca5Qok7PSG1dLolmgFijN3N3etJAMEwvdFPn94zX+UNqvAzTaI4lehTRAYwQF1Xx
	FnjCTG2Nnu771ozZfjvJh6EeYVsnwS4IMWQ==
X-ME-Sender: <xms:WQnJaOoDWpV8iswl2Lt-XoBKy4Krn7ex7mCKDuNcRjKRRdxgrGJs4w>
    <xme:WQnJaM3c2DJMPd4jpMYtZ7AxGTS5nuzXHMzgW35FmKcOnMEtsGXTYLGPeAZIa0Mm8
    mgAKc-YA6kHXPiUOg>
X-ME-Received: <xmr:WQnJaFB6jPd0iXV2AP_YVC8V3iFF3WtEmk8yy0TuSuDBA8g6_pSigHahtCd9DdZH4bF6yoSDvTndxwAoD5cTrBKZ8fvzNP_IvhJfNUGccgk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefleeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WQnJaMdxOqhWecq9OHEZ-heCqD_FZxAfcb1VC_fCI_GVif5l9ps8Cg>
    <xmx:WQnJaCgnJzbIGQQRy2kdZ3dF_CZg1_3CnIctJ8-M3x1p_JCoGIRjZg>
    <xmx:WQnJaMpOTuA7yAsvFlymu6K8cXhXIr0ocyly7GBX1XuxvciJYlyDGw>
    <xmx:WQnJaKH_KlwjCoXWwEDlX-yqP0PsaOakW3EIEUuV9rPvWBkvYwrUsw>
    <xmx:WQnJaJM8_Zux5KVpD73KFTgya5tmSNTTpjTJXDaAKe7BkJwQojE0GBnY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 02:53:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 022bff29 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 16 Sep 2025 06:53:11 +0000 (UTC)
Date: Tue, 16 Sep 2025 08:53:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #06; Mon, 15)
Message-ID: <aMkJVMbSmeA4cIAy@pks.im>
References: <xmqqtt13frqm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtt13frqm.fsf@gitster.g>

On Mon, Sep 15, 2025 at 12:19:45PM -0700, Junio C Hamano wrote:
> * ps/odb-clean-stale-wrappers (2025-09-12) 2 commits
>  - fixup! odb: drop deprecated wrapper functions
>  - odb: drop deprecated wrapper functions
> 
>  Code clean-up.
> 
>  Breaks build when merged to 'seen'.
>  cf. <20250910153759.GA562601@coredump.intra.peff.net>
>  source: <20250910-b4-pks-odb-drop-wrappers-v1-1-6ed660cb1eec@pks.im>

Shall I send a new revision of this patch series that squashes in the
fixup commit? I wouldn't mind doing that, but it becomes a bit weird to
do so when the original base of the patch doesn't even the issue.

Patrick
