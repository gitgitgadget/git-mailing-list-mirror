Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DA22EB856
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049025; cv=none; b=QEsWgQ/b2XMPapPf0NUV/tIPV8Chj6aSniRuwgfZfGFMwtAlnaof2lUp84GMu5cu6PThe8tuumSiS8D6cp3RewJjpjFlKqdTUJv/slSAV/sj+P6jXjJ1D0AkPOlaQsWBn9zgvrt2Ff6ami2h5aD6CkxAIatUUV0WKY+OwtrRp3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049025; c=relaxed/simple;
	bh=vzDLQNfNXt7zhb216xfkpRIqdrcvyBPEdEfQiWC3Cqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRxobdYzl0WSrz4e6rYlUqGgY4IbkhNqveJA3h4JYlSKtqao6puzyHDAcDsr/vWGN9RixNlh0nJOoyY7oYziQpjrd8Oye6ugst6k+5ZHNKzSIlJimDD08alDzuj28Mit16oVSVfnyJ3mckt8UL1WhlQ60K1kjpeeq/A7hpLh3zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l37OvLK2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YtOx2IDT; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l37OvLK2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YtOx2IDT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 79E667A01DA;
	Thu, 18 Dec 2025 04:10:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 18 Dec 2025 04:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766049022; x=1766135422; bh=7a5V2Ot3sD
	RwNCGymUU2gOjP1G5moOMUPIrXjjFUovc=; b=l37OvLK2h40lzwjJP1QXKJzmI6
	eSKLranv4pAXrNPJ4BBfwl1dsrYGQHQie6qO4dvyhlNvOXFzvVZQ+J4P8lW5p3ZP
	NA2wNfb7W87UBMVEvvwT/4nfSHoqPdEf7/oPnsCQaIykT8gvQXFRdO5bLFH7/KhO
	PBHQXMhGJZ90KFL/TJvqGWqsYaUOZBP7dq9ZaIAr2zMHgi3IErw5nY9AJYosSZW6
	ZH4YSXGdA42Ubzca2wUAGaW2AIjy9Is0R8mZjhAnYvPOoPRgGFHIOcBwsXEEZvPH
	6nahER+e46oxtNpxwqRokAjEzdZmHx60Y9FMNfjTqaIcvI2ti8evV4jDZogQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766049022; x=1766135422; bh=7a5V2Ot3sDRwNCGymUU2gOjP1G5moOMUPIr
	XjjFUovc=; b=YtOx2IDTvyJAG6VaikGWt7PB5uO14XJNJBO3MkMiCTJ0iaYGbP3
	ui0H8XUT/J1beiRLFP25bdhpm91iRveiSERJIEx/tKZchZl3wfo5vAb/XHxSNQhx
	oMu0FJiJ71RLzm79dklEJ/QWJDuckuR7Nwz/1Joqu+39IkSbGHMffywjPC+rY/KU
	LhSKeaywiU2DjxIyAEZqRtZSG+617OiPQlALEsG4/2+HuBHGoQ3IA2AEGqkbDzSA
	jJ2hNddKWQp0YxzL1+ABrEK1Q39COCgaoDUpD7YTmdiGSOO64+B6O+QhVX9WXH7B
	Q2yxZ5GNMPvDBApQY+AfsImYt8YZX0GSPNQ==
X-ME-Sender: <xms:_sRDaV1o2EYdnI5p8kgFBb9lg6zSv5JLKF7FCUka5P8JP10fp1UK9g>
    <xme:_sRDaTj1dSXPdmDpu2AY-q7emW9gm23tTmrKIhm4d_KPKG96q1SHMAeFxE3g_5qM3
    vFjYPEgumtNHgRanPL4SYQJJlWmjyypCCWsxoiFLIPAZHBwwa725w>
X-ME-Received: <xmr:_sRDaTTBp8H6Ph-gmWTKWB7QvBbCJoLGzennzzo32EWaJazwE9dtBjo8oFNFXG2-HxQp3ui7jGCvRYJ0jjUH8A-9PS9B-TH9EsdPeuyvtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeghedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghplhgrthhtnh
    gvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:_sRDach-vEgKUnimtMNa14JTrx_w4ffKnrZki78HsmOKbZPlDp8z1g>
    <xmx:_sRDab4m6wwQESDODDWhHb2RBkJQrQY798oHZ6na4M9IkF4CIOB5IQ>
    <xmx:_sRDaRC0p0pKtVi7gISQlMfygXcZkQe5M313S4CMfLmwWol-U_g-JQ>
    <xmx:_sRDaaYUwcHcc9Jjx8ER3YwmJN7qntM6wJ_H81dJtReVVrunfF8wyg>
    <xmx:_sRDacKy4dgAjbkkAcPL97u8mY-EWW6IjXLwZSBsuBulLx02y32PX4ct>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 04:10:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b70d6579 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 09:10:19 +0000 (UTC)
Date: Thu, 18 Dec 2025 10:10:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Aaron Plattner <aplattner@nvidia.com>
Subject: Re: [PATCH 2/8] packfile: always declare object info to be OI_PACKED
Message-ID: <aUPE-H6mQQwlOQ1Z@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
 <20251218-b4-pks-odb-read-object-info-improvements-v1-2-81c8368492be@pks.im>
 <xmqqh5toxnhk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh5toxnhk.fsf@gitster.g>

On Thu, Dec 18, 2025 at 04:23:03PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > When reading object info via a packfile we yield one of two types:
> >
> >   - The object can either be OI_PACKED, which is what a caller would
> >     typically expect.
> >
> >   - Or it can be OI_DBCACHED if it is stored in the delta base cache.
> >
> > The latter really is an implementation detail though, and callers
> > typically don't care at all about the difference. Furthermore, the
> > information whether or not it is part of the delta base cache can
> > already be derived via the `is_delta` field, so the fact that we discern
> > between OI_PACKED and OI_DBCACHED only further complicates the
> > interface.
> 
> If this were "and no existing callers check at all", it would be
> trivial to decide for this change.  In fact you do say that but in a
> weaker form just below.
> 
> > Drop the OI_DBCACHED enum completely. There don't seem to be any callers
> > that care about the distinction.
> 
> "git grep OI_DBCACHED" shows only a single hit, which is what you
> are getting rid of in this patch, but I cannot claim that we did a
> sufficient audit, as this change will break code paths that check if
> they got OI_PACKED and do something differently (or if what they got
> is different from OI_PACKED, for that matter).

That's a fair complaint. I'll adapt the commit message to include the
investigation.

Thanks!

Patrick
