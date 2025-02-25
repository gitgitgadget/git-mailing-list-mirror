Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6F25B672
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469200; cv=none; b=nktToL3S3kf3FbhmLK3v3vXtWRmhJ+HGMQ4ybzPtYkBEBpXiLUqKwVHJ7ofcE9Ad/EHKaz88ohmo1gsp8y3aHqZrYRgtwjtM6/QUOBXqetBhbYOb7IZJa+l3DhkXyfFPdDiVesa7qe/RmnUT5B1YmPOjBxjNcENlb7GNZsGlp30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469200; c=relaxed/simple;
	bh=IHZfy5+HrXJ62WMdwpPdOYg0tIl2/YrPUd2jZwuBqmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCOXfFG2n7DwXNzHcyI9vQgPjJ56yiid6bQmotANFq9XSGR86RCMrNPTsiVxRFwd9BgzGHYrncFrR5B2gwaFI3q1OXLFefwT7p7IUTtigQV5stCA7MV5Pws22e3/0LjihX0ucMMXQ93+c/Qt7tdUUDuvzleRQo/mc+Z9L2xL/34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U7rMmMT+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6j3tJ1Vu; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U7rMmMT+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6j3tJ1Vu"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B40E32540135;
	Tue, 25 Feb 2025 02:39:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 25 Feb 2025 02:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740469197; x=1740555597; bh=8kpd+pvn/O
	y0UpYaubmHBr0O5XwfCa/Y07WXJ9ZEeZQ=; b=U7rMmMT+pHKPTBlViVxCGX4MLZ
	sLpt4PAz2w+u0/ZNfjuwAXBpKI3v7a+0WUOc4cOfEU7rczszjSC7Siur0Jmpipiy
	80Q2W80+w14mECIJL984VluAhDO4z78q+g8W49mp2Hx6Mp5lUse5URJWCWxyhv9w
	nJS6nX+fsS64b9QyDYhdUnrd91ziaKlcoiA31L00TmR71CO6IS1BMYwfHQX9GYuU
	TrOuM+j82tVTK50Lcisw9tcfLrE6RmO4gDcKSBGKigpC+vU+yFKywvquX8jFr1oE
	iRiCLDnagQHcVxILjrF9iFvIbYM4X1d7pBdsU2FgB5sHKNWdjaROIgo2YFwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740469197; x=1740555597; bh=8kpd+pvn/Oy0UpYaubmHBr0O5XwfCa/Y07W
	XJ9ZEeZQ=; b=6j3tJ1VuARGpVLryc/Fmy87V/uHj8C9rIF/Zmtrrp9wbT3fi5U8
	ZF8cCBhVXFsVRdNo+jrR5JphSjPr5C0S50soHtcu0F1G7SentFN1cJqK0YRip7oG
	Qrj1QoWcYBq+9eZt9IDvvXVRuPqwXxDhtyIjU/lBBd2kOlAZ7UDf/tZkBLttdZLC
	kS4skusNTQtZ5up8vTKWoVMv0u63370O7chU1gG/JnxEXZ4wu4p3uQaD/EzZtnOA
	V4oq2F+NkvwIFQzTC63dp0RAmxIR247ADxIGpivAj0Amk1JjHzSM0wfITYyuN36Z
	mrwqoVQQUY/yRKEvcLfxtFrJWLqxXZcKPPA==
X-ME-Sender: <xms:zXO9ZzrwJCz-j7dCNnj8fi1d0hKG4_D56jn3XPuNDzDgcOJgsMGoaA>
    <xme:zXO9Z9qA_AT1UIhnT7S557UL4X3wWvaLn31kAM4y9T2boXI_vSBuPB_Czk8_UQBoa
    DK3PrTGOYgEnAaQIA>
X-ME-Received: <xmr:zXO9ZwMRn8eHZHhk4jzrwhCgdyNvRX_M4QcENCjZtjkSRxpCgVin5YuUJ6gH9rAxRCHHEeNdf4R0n9VoZyterNhJ9kUF8c2Upht5xQuOQeWlpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrd
    horhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zXO9Z25cqnULGPEzG5tPu2DtE3PjvSv3Q_uSndeJWPq79cQ9tCmXzQ>
    <xmx:zXO9Zy7zP_412V-lHWRjNayDtOSPis_i_cBuGrsR09hTIdTeVvRMOg>
    <xmx:zXO9Z-h6BEnI4DBUH789u9bG9-QafNNIwgIDzsQ0C-BeaPaZJKBJiw>
    <xmx:zXO9Z05W0g30E24eEl7MTrdt7ZeVZ6PK0CVp2oDZ7d9QhRB-uAbQfA>
    <xmx:zXO9Z5b1T1LsuME9VyncMPcReU_UG_RaYgLtCLgesxYR30qmJoxvgwDT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 02:39:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e66dfd12 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 07:39:55 +0000 (UTC)
Date: Tue, 25 Feb 2025 08:39:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 14/16] refs/iterator: implement seeking for
 `packed-ref` iterators
Message-ID: <Z71zyrai9f9dPZRK@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <20250219-pks-update-ref-optimization-v2-14-e696e7220b22@pks.im>
 <Z7yLrKVxCF5qb7gP@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7yLrKVxCF5qb7gP@ArchLinux>

On Mon, Feb 24, 2025 at 11:09:32PM +0800, shejialuo wrote:
> On Wed, Feb 19, 2025 at 02:23:41PM +0100, Patrick Steinhardt wrote:
> > Implement seeking of `packed-ref` iterators. The implementation is again
> > straight forward, except that we cannot continue to use the prefix
> > iterator as we would otherwise not be able to reseek the iterator
> > anymore in case one first asks for an empty and then for a non-empty
> > prefix. Instead, we open-code the logic to in `advance()`.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  refs/packed-backend.c | 62 +++++++++++++++++++++++++++++++++------------------
> >  1 file changed, 40 insertions(+), 22 deletions(-)
> > 
> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index 38a1956d1a8..71a38acfedc 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -951,12 +954,41 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
> >  					    &iter->oid, iter->flags))
> >  			continue;
> >  
> > +		while (prefix && *prefix) {
> > +			if (*refname < *prefix)
> > +				BUG("packed-refs backend yielded reference preceding its prefix");
> > +			else if (*refname > *prefix)
> > +				return ITER_DONE;
> > +			prefix++;
> > +			refname++;
> > +		}
> 
> Although I cannot understand the code, I want to ask a question here, we
> we need to do this in `advance`? Should we check this for
> `packed_ref_iterator_seek` or in the `next_record` function?
> 
> Before we introduce `seek`, we don't need this logic. I somehow think we
> should do this in `packed_ref_iterator_seek`.

We cannot do this in `packed_ref_iterator_seek()` because we need to do
it for every single record that we yield from the iterator. We _could_
do it in `next_record()`, but that function is rather complex already
and really only cares about yielding the next record. On the other hand,
`advance()` already knows to skip certain entries, so putting the logic
in there to also handle termination feels like a natural fit to me.

> > @@ -1130,19 +1155,12 @@ static struct ref_iterator *packed_ref_iterator_begin(
> >  
> >  	iter->snapshot = snapshot;
> >  	acquire_snapshot(snapshot);
> > -
> > -	iter->pos = start;
> > -	iter->eof = snapshot->eof;
> >  	strbuf_init(&iter->refname_buf, 0);
> > -
> >  	iter->base.oid = &iter->oid;
> > -
> >  	iter->repo = ref_store->repo;
> >  	iter->flags = flags;
> >  
> > -	if (prefix && *prefix)
> > -		/* Stop iteration after we've gone *past* prefix: */
> > -		ref_iterator = prefix_ref_iterator_begin(ref_iterator, prefix, 0);
> > +	packed_ref_iterator_seek(&iter->base, prefix);
> 
> Why don't we check the return value here? Actually, in the previous
> patch, `cache_ref_iterator_seek` will always return 0, but you still
> check. I have thought that you just want to be more defensive.

Yeah, let's have the check over here, as well.

Patrick
