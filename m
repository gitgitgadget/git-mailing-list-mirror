Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7AF1B3951
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730790889; cv=none; b=bQSMJzbPcIG2LEK3xgMlKJG/86sbh1ioZjSyeeSbbv9lPpkZFYt+LG8Fme+au8z59/8UZP1ItmpeXdMlXIRJ8a3RNu9Q9A8Fia9w2e6YPBECZnMtUe/TTL+dx6AZAH3YIosBiPg/Q8M1qgP0Plhd5hfATikQi6lCDBaJKUOpSqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730790889; c=relaxed/simple;
	bh=HbhyYelXu06PCXi8CNcZHL0cbZGePCkAk41pSg5nq1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2QT7WokwknJlm412DTQik0yVSIgixvbb/CwztY/o0WO9wGrsxXT18M6QnyWfq7nkuINB2HcI6QuCrvD7xpLRrgryHhAMkc0qooTVy/JloUIMeeT3QmknBiCdHlHX4GuOVLznv6eoQdVsmeGIbOJj/GFyPcVra2t67S5jG76S6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iQfRJmyR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XX0xVlZQ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iQfRJmyR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XX0xVlZQ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2031E11401AF;
	Tue,  5 Nov 2024 02:14:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 05 Nov 2024 02:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730790886; x=1730877286; bh=Ehp9CY2CIY
	BIwuR96FA+z02yvCEtb4PkOZpIcP2rvuU=; b=iQfRJmyRImxU4xORlax9IOlb4z
	Cdo65jzTI1Zn087YajC4AR1USSF8AhqtY5rw+UlOUFr3QNpmrXpvrpOiZFmpFx3d
	XQvTS0amJCzV5efi+sce8R4gfX2RdeXCa8rP1ginDF5sLu85MJGjwfyEbh3b6mbJ
	S5lrYR1/khc3mxw41Epgqhw7+wQ8iSHwJD6TUyX0mo3vGY1mwySOgsKdXcoxZMXW
	rvlZ2/Ea5Stb8O5kPPEHrDcv4R/dXcNbA5XnJL0WeGFIu1+TTRIpE+di07VoEqgS
	8YErl2Kszp1AItQfJkH/eaqvziqtKeW4Sb6e/UjuWyN3a6j64EwRPcWrjJmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730790886; x=1730877286; bh=Ehp9CY2CIYBIwuR96FA+z02yvCEtb4PkOZp
	IcP2rvuU=; b=XX0xVlZQG2OiD3zbRoQzbojHDfU6rFj3ktt822ioXQFpsC3Rfh2
	SfbN4SvQWYZpPGHuAxm9D24ZJQU/Vmz8PTRYD7eC57P0UxBJeyh6dXBV2xwfIIpG
	O7PXSV5HTgwFeuv8RZsSzTEFMPFWdfFbHWWeMegUVnyee81r+zMPvdEPwnygQMw6
	MBul+vcO1ST0dHfwMYX8Pt4y8opDi4FnIWPQTGvoNj9N/TVU48K8l7WTKChjfGvg
	0YfvxXxQ6+Fznb5qBytmCVcDECKDVUeRbJROHzBxRyM2tC+Ts+KbQtiYXevCHTf6
	uWFTF22b0pyy2RzM+fM01Jfm+YUtTm5AWgw==
X-ME-Sender: <xms:5sUpZ3zm6sVs7xe4PiBDxUwbx7aegvG6N76UIeXk09QinxDB8-pwtw>
    <xme:5sUpZ_SmXZrgHxdxqDA2XbSAWXjHBUGv03e9mbLhgu_-U9JRrJ3KrU48lvB-XWZc_
    MAtYSNPJFPSKsn7HA>
X-ME-Received: <xmr:5sUpZxWmL1ZKOP7uv0-Gp3AHUAFPciFQGSjNrPLQF_BhlYAb4MbSJmmiVv1ZwM7FESZ6Y5i65AEvOHohVXAaR5vl4Q2LdStjBFs2p5E0CJq32g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnheptddtjedtie
    ffheejheekfeeiffevtddvffdthfeihfehtdduvdejtdeileduveefnecuffhomhgrihhn
    pehtqdhrvghfthgrsghlvgdqmhgvrhhgvggurdgtfienucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphht
    thhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5sUpZxgBwBd9_khTi11ulv536bDWLoECV_V3MstgN9tPd_ZZkqboDQ>
    <xmx:5sUpZ5DLH6yj0POVImIDrwdhWlfXkgGJD35NjNRYJNQ12oVCsrlhpg>
    <xmx:5sUpZ6KoE-SzpnwPtGml303waynQ6AUJVNu9_a-XAW3hwr9s6XgGhA>
    <xmx:5sUpZ4Dq1SlCHhn6uWubnoHfHP16AnY6LHM12xTx_48ox6issh0fsQ>
    <xmx:5sUpZ8O6Ioiai6Wp7hiCt3HR2ZNZsKy7xkJSg8iI3-tC5wMJR8mHSA9N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 02:14:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1a481a4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 07:14:23 +0000 (UTC)
Date: Tue, 5 Nov 2024 08:14:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/8] reftable/merged: drain priority queue on reseek
Message-ID: <ZynF3Ai9FDVRAYOc@pks.im>
References: <cover.1730732881.git.ps@pks.im>
 <45f397b563fe88524a2063bde8cad31ab9a2ccbb.1730732881.git.ps@pks.im>
 <xmqqv7x2tlnk.fsf@gitster.g>
 <xmqqr07qtlcm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr07qtlcm.fsf@gitster.g>

On Mon, Nov 04, 2024 at 07:23:21PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Did you mean REFTABLE_HASH_SIZE_SHA1 instead?
> 
> Ah, that transition hasn't happened yet on 'master'.  I'll carry the
> semantic conflict resoluion in merge-fix hierarchy then.
> 
> > diff --git i/t/unit-tests/t-reftable-merged.c w/t/unit-tests/t-reftable-merged.c
> > index 620803e0ed..a12bd0e1a3 100644
> > --- i/t/unit-tests/t-reftable-merged.c
> > +++ w/t/unit-tests/t-reftable-merged.c
> > @@ -326,14 +326,14 @@ static void t_merged_seek_multiple_times_without_draining(void)
> >  	check(!err);
> >  	err = reftable_iterator_next_ref(&it, &rec);
> >  	check(!err);
> > -	err = reftable_ref_record_equal(&rec, &r2[0], GIT_SHA1_RAWSZ);
> > +	err = reftable_ref_record_equal(&rec, &r2[0], REFTABLE_HASH_SIZE_SHA1);
> >  	check(err == 1);
> >  
> >  	err = reftable_iterator_seek_ref(&it, "a");
> >  	check(!err);
> >  	err = reftable_iterator_next_ref(&it, &rec);
> >  	check(!err);
> > -	err = reftable_ref_record_equal(&rec, &r1[0], GIT_SHA1_RAWSZ);
> > +	err = reftable_ref_record_equal(&rec, &r1[0], REFTABLE_HASH_SIZE_SHA1);
> >  	check(err == 1);
> >  
> >  	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)

This looks good to me. I guess I may end up resending this topic with a
new merge base in case the other failures are caused by that semantic
merge conflict, too.

Thanks!

Patrick
