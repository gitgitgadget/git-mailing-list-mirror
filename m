Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605792C15B1
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765524804; cv=none; b=P4I8XF5igVqyEHHqRXTcq5+WYjrlMo+XJU7Jw5bMwAnvkpSa00n2E+U8mtSbfcVsfFxa6Zc4NvK/nfj6U0KKs8GYqoBGCuuBLQAIYa6v0cShBme/g81x+eAsaZWz/3kuPwBxDWkl0Q+aT1QQ38tbx6L7KeU9Q3O4PUDcPXqFAw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765524804; c=relaxed/simple;
	bh=Fq7+Ua6dA1DvpN54xDVv2Lqckq0qiZJ4dzHmQGgnZFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEFpD0RSuGC8UwufmlWygE3mQ6Uk5RlH8R87hWEXd0grz5tzqKlpfeQakZzNe2aeIgwxHF4kxJhUOvLMvNjYs0QJDwxCNl9Wy/ty3McUk7Hpzu8NQWCOoQp6sUN2COh1FPrHwNe94pwPvzs/WQ0nu0Vi8Sxt5MH6EEkL47Dx27c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YZLL+rR8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DEUnGcB3; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YZLL+rR8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DEUnGcB3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5AE5A1D000C7;
	Fri, 12 Dec 2025 02:33:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 12 Dec 2025 02:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765524800; x=1765611200; bh=wkE8umuRrL
	ESg23pbJmw/qNySqk0FUx4YyWg/n6vH9g=; b=YZLL+rR8twuHeNC/HO552KCJ75
	sbdYre0iudaaFqfH/cEkt2FRuSK+SVDswrPUilCqPM6aChrTi5fSgVwaUXOY7lEC
	mmHpHstp/ji/2zK7Yl5G46+dxIr+mdR6TU0DSjiNxMhrTP661ZCH4p/VEZtnGTJa
	lK5QOJNeIDuoW/T97yHB5z9azgh+J2uyRxGHCSuOACed5u9RqWGXyUT27Wb6R3Tm
	1jvIzkCs6kE38LovSI/LO5uwN38zp6rHn9jWX5MHggf3vlUGe9ckFOgyVr+2zQD3
	lCV5s26je2GDjXkbUzhvSn9zNLLkaHGXBsdz5z9VvVPmF0aT7QFZOZqtOpLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765524800; x=1765611200; bh=wkE8umuRrLESg23pbJmw/qNySqk0FUx4YyW
	g/n6vH9g=; b=DEUnGcB3HfSioYg5DA4oBj51o8Nao9qr/VdK8iVv7yyPqWh9jyY
	igALUuCVLQKUtszQlrIwQ+FShDlnGysIotNznOOFwg7fEXF3E3ae/VfheevqshFO
	I95GXRjOKX9X4sAFTbDh6eBFfNHncFPOYfjP6OrvttSc8eVl8L+OOrUkxZnd78lX
	mvQ7Py3EiE5KCjM9kF1YFgPG+E/LeNbOio0n5DNI1l38JzNR0AHkMTGvqd3rDfu4
	4TLnBDSI4R+/SrmDDgsM1obqmqamyWzBFUgeMqMhNF6unxTjBVm9bTB3RlUPNj7Y
	nSuanenEkRao+cmC6Nj+4crkNNIl+SrV4EA==
X-ME-Sender: <xms:P8U7aV485Orpxp6_ff-FB4iclDxRA22mzamaz-1rDqfg89DLrbi0cg>
    <xme:P8U7aZ7oQJ9ezhCyW4GYTMVwA41UBIze8t_TcBdN_sNfcDxZdtyCwxboQtELfjtBU
    B5HqvMDNUnMK5d55juWrKADrJxwa7Bv5iWiSei_0y4WMvgcevHB>
X-ME-Received: <xmr:P8U7aRcNMwNLm7mFrGGYT-EtC2HW7p2pZQ0ILWVSTes-PE8JXmOO03xPE2JPFeK29UpFGg1X3wBRYyQULyFJK7BZTgljDIw6A0R2kkLTuYE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:P8U7adBK0xbQF00dEHY1s3uhWbKafjvKvC4f0WH3ikCjWUdUQ6P8CA>
    <xmx:P8U7aU_wLpISOt9gD2to-oSIeSN2cxmT88_1i5Pxl_7_Rj1ju_8d5w>
    <xmx:P8U7aYKZTcOqFiWzKoagB4hbP78F7YR3Nbib4qcpqwoJUCROtI6moQ>
    <xmx:P8U7adg7uKcHoGgUApB3AVokCeMzzZwVIBrl7Nv1y1G9f1Annv310g>
    <xmx:QMU7aQ_WyS0mTnbjRh7ick9xSt9T-PcOA9vKVy4FAvGOyOFmTljFgChs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 02:33:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 76ef490e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Dec 2025 07:33:17 +0000 (UTC)
Date: Fri, 12 Dec 2025 08:33:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] builtin/repack: avoid rewriting up-to-date MIDX
Message-ID: <aTvFOlhtPHgWQC5L@pks.im>
References: <20251208-pks-skip-noop-rewrite-v1-0-430d52dba9f0@pks.im>
 <20251210-pks-skip-noop-rewrite-v2-0-f813a9e44f28@pks.im>
 <xmqqsedhe78q.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsedhe78q.fsf@gitster.g>

On Thu, Dec 11, 2025 at 05:46:13PM +0900, Junio C Hamano wrote:
> This and Taylor's incremental part 3.2 have a slight conflict in
> that this topic factors away the logic to compute if we need
> recomputing MIDX while the other one tweaks with yet another flag.
> 
> My tentative resolution in 'seen' looks like the attached.  Sanity
> checking is very much appreciated.
> 
> Thanks.
> 
> diff --cc midx-write.c
> index ce459b02c3,f2dbacef4c..66c125ccb0
> --- a/midx-write.c
> +++ b/midx-write.c
> @@@ -1014,73 -1131,30 +1131,89 @@@ static void clear_midx_files(struct odb
>   	strbuf_release(&buf);
>   }
>   
>  +static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_context *ctx)
>  +{
>  +	struct strset packs = STRSET_INIT;
>  +	struct strbuf buf = STRBUF_INIT;
>  +	bool needed = true;
>  +
>  +	/*
>  +	 * Ignore incremental updates for now. The assumption is that any
>  +	 * incremental update would be either empty (in which case we will bail
>  +	 * out later) or it would actually cover at least one new pack.
>  +	 */
> - 	if (ctx->incremental)
> ++	if (ctx->incremental || ctx->compact)
>  +		goto out;

So this here is essentially the change you had to port over, which looks
about right to me. The comment is becoming somewhat stale due to the
change, but I don't think that's much of an issue for now.

Thanks!

Patrick
