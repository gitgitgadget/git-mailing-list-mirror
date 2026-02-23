Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159FA365A05
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849266; cv=none; b=uQPPfP+AlYG3oqa/Twz7IfqVqmRh3BUDeelB89FxkW37n03xNSDLUusagxdgpQeyRM3/MKQRDo0SnWLNt0yg1zwWMtACzsieETCx5ngNnvIxmgWVJy1LXve/hx6hMLxzWOmPEwTiEo1v0PYuJNi2+5estmTKEawgGJvUcIPhHDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849266; c=relaxed/simple;
	bh=LJwtXQduj3qDU4rof+wBm6Xv1LD6u9lE2aSpBipnrO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHTUiYngfsBA4TC8q1jNKGJzupoXZJtFuaKUfLNIHSfXXt0JNI0oDpOign3NDwO9cXOCcFJmAwevQkmwSyWl9rp93KEwp6l2td3BiiffSwWBOcENizFzrzrR3zVaqaz6A20f/4lliwxpgizutS1D5TbpPUo9lWdL/E54IOzKkvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kqe77Igf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HlpCHAUA; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kqe77Igf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HlpCHAUA"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 5EA46EC05C1;
	Mon, 23 Feb 2026 07:21:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 23 Feb 2026 07:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771849264; x=1771935664; bh=/7FK97Qb+y
	CS9r1XCssZ0WVbXdHuRbQjC9p7NNC4mf4=; b=kqe77Igf4kQrsHOnE6tZS3/CmQ
	k5AWqzGu4XK8ZL04550Kt7XKpJcLl8/72UonKa3Wtdm0SgpUgJFSC10uXcvaHQWK
	PZ4RruprBsVNOlLqgYywG9YaEXPAjAgOgr7+VOW5dtZyXtjUvolVDwKLj/uy7KDP
	yXY5Ft829JrrCTii4984UJ781ki35PsIPz+HRB4yIHZqIs+oEexnSxVparUZql6+
	cbLbWXbcFY6WCuV/UiH/WpYkgn3jVs+S3I7Pu+IVb+XUL1fb4mqjLD+19r6LAJBZ
	hhkL+pf51kF5r/RLf9sZEEuWWF3G1YBb+Jo5RivHheBwQkhLxIU2MxmxmJ+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771849264; x=1771935664; bh=/7FK97Qb+yCS9r1XCssZ0WVbXdHuRbQjC9p
	7NNC4mf4=; b=HlpCHAUAQHjaurPVPX+oLAGuPKyYtD2Ir55L2gIpdyfii64ir8B
	Ep52n3rg2o/uM7a5h5cFmwDwtZ9DiCF3CqRSm9wBM6c2+EAFIxVwDFz0s2EdRM9L
	DFqEyT0A4z8ERXbETNH1qxy07vb/bRRI3VQkznLJudFVzkagtkB/LYW7L4VZNmhu
	F65PCew2yBUA9x3WxU4EUtIPiRSrmWmfD5qkdGclc6QlJ31Ni2D6yE2mKNv0KGr+
	NZt6Ob/ciM4O63Z2lShjo6pZCwdfoAmzHZaUQZ1TaNqZ/UGJIptp65NaHe9NTzef
	jpbg3x/WYBPiG1rBy8rVTwg6ubfRBPQCObg==
X-ME-Sender: <xms:MEacaRuXz9EHsOvFWiIQkPwjskz2IhsKzC8V6eVZdXDRpmOSECO9kQ>
    <xme:MEacaRdZOPFqzCO-_F3v1Xywgd5HWm7fDZXM5Ty4jo2mlTpMkHQWF9EE0wzzgROQZ
    aX8l_vDsr8VCrsnX505dFPtcMbrpt-Uo58SwNyb12j_x3qMA6Qojg>
X-ME-Received: <xmr:MEacaZymJtbuNsRgcEcVPapegtHg6FVyerBi_YRNVV4UJ-P2RmMKudsQ6sEs5J6oif2OvbUP07IEXhQQovGKKIkmP6z7ka2VRErg4P6HVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdortd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeejtddtgeffkedujeejgeduhefghedtgfdtie
    duleeulefgueetheeludegueeuveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:MEacaXEmFaHVwySdLsGp0ew0YHClB-AKsA-Kabz_pfoQedeZm-LDIQ>
    <xmx:MEacadwZ-LEenjLN_OCWS1C6tv2cQ2FJqP4sV1MXyxBO0PdS5NpPbA>
    <xmx:MEacaYv4RJu08HPffuji95EEVmoISd4JRvf64n9MU4J_vvLahEQnrw>
    <xmx:MEacaa3IuUUI0kHspPWCMe46_5CPThH4e_ZckUn1ixnB3ErHnpkxyg>
    <xmx:MEacaawW-ZG-lfsrWfVQ_yLrGv-xE8EkDtaNMG4Wp1a6oOj5bI4Bvx7p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 07:21:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 361a1375 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 12:21:03 +0000 (UTC)
Date: Mon, 23 Feb 2026 13:21:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] object-file: adapt `stream_object_signature()` to
 take a stream
Message-ID: <aZxGLKycnZcVoXPt@pks.im>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
 <20260223-pks-fsck-fix-v1-2-c29036832b6e@pks.im>
 <20260223104915.GA215364@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223104915.GA215364@coredump.intra.peff.net>

On Mon, Feb 23, 2026 at 05:49:15AM -0500, Jeff King wrote:
> On Mon, Feb 23, 2026 at 10:50:41AM +0100, Patrick Steinhardt wrote:
> 
> > The function `stream_object_signature()` is responsible for verifying
> > whether the given object ID matches the actual hash of the object's
> > contents. In contrast to `check_object_signature()` it does so in a
> > streaming fashion so that we don't have to load the full object into
> > memory.
> 
> Makes sense, and is the first step I expected to see.
> 
> The code looks OK, though a few small comments below.
> 
> > -int stream_object_signature(struct repository *r, const struct object_id *oid)
> > +int stream_object_signature(struct repository *r,
> > +			    struct odb_read_stream *st,
> > +			    const struct object_id *oid)
> >  {
> >  	struct object_id real_oid;
> > -	struct odb_read_stream *st;
> >  	struct git_hash_ctx c;
> >  	char hdr[MAX_HEADER_LEN];
> >  	int hdrlen;
> >  
> > -	st = odb_read_stream_open(r->objects, oid, NULL);
> > -	if (!st)
> > -		return -1;
> > -
> >  	/* Generate the header */
> >  	hdrlen = format_object_header(hdr, sizeof(hdr), st->type, st->size);
> >  
> > @@ -160,7 +157,6 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
> >  		git_hash_update(&c, buf, readlen);
> >  	}
> >  	git_hash_final_oid(&real_oid, &c);
> > -	odb_read_stream_close(st);
> >  	return !oideq(oid, &real_oid) ? -1 : 0;
> >  }
> 
> The minimal change for callers would be to give a wrapper like
> stream_object_signature_from_oid() or similar, that included the
> open/close. But it's not too many lines, and of the two callers, one is
> the caller we are trying to split apart anyway. So inlining these bits
> in the callers makes sense.

Yeah. Had there been more callers then I'd have done that, but as you
noted there's only two, and one of them will need to be open coded
anyway.

> > @@ -330,9 +331,17 @@ struct object *parse_object_with_flags(struct repository *r,
> >  
> >  	if ((!obj || obj->type == OBJ_NONE || obj->type == OBJ_BLOB) &&
> >  	    odb_read_object_info(r->objects, oid, NULL) == OBJ_BLOB) {
> > -		if (!skip_hash && stream_object_signature(r, repl) < 0) {
> > -			error(_("hash mismatch %s"), oid_to_hex(oid));
> > -			return NULL;
> > +		if (!skip_hash) {
> > +			struct odb_read_stream *stream = odb_read_stream_open(r->objects, oid, NULL);
> > +			if (!stream || stream_object_signature(r, stream, repl) < 0) {
> > +				error(_("hash mismatch %s"), oid_to_hex(oid));
> > +				if (stream)
> > +					odb_read_stream_close(stream);
> > +				return NULL;
> > +			}
> > +
> > +			if (stream)
> > +				odb_read_stream_close(stream);
> >  		}
> 
> This final "if (stream)" is a noop; we'd have exited the function
> already if "!stream".
> 
> In the earlier conditional:
> 
>   if (!stream || stream_object_signature(r, stream, repl) < 0)
> 
> we're combining two error checks: opening the stream and actually
> hashing it.

Ah, right.

> That matches the existing code (since it all happened in a
> single function), but should we take this opportunity to give more
> accurate error messages? I.e., to do:
> 
>   if (!stream) {
> 	error(_("unable to open object stream for %s"), oid_to_hex(oid));
> 	return NULL;
>   }
>   if (stream_object_signature(r, stream, repl) < 0) {
> 	error(_("hash mismatch %s"), oid_to_hex(oid));
> 	odb_read_stream_close(stream);
> 	return NULL;
>   }
>   odb_read_stream_close(stream);
> 
> I dunno. It should be quite uncommon to see either of these messages,
> but that is sometimes the moment when details are most important.

Agreed, that feels like a sensible change indeed. Also makes the code
flow easier to follow in my opinion.

> Also, as an aside, I found it curious that we still need to pass the
> repository struct to stream_object_signature(). That's because it needs
> to know the correct hash_algo. I wondered if the stream struct itself
> might know about that, but it doesn't seem to (it doesn't know anything
> about where it came from). So it's unavoidable that we'd need to retain
> it.

Yeah, agreed. I wondered whether we should eventually extend `struct
odb_read_stream` to have a pointer to the owning object source, and in
that case we could've avoided the extra repository parameter. But I
decided it was out of scope for this patch series, also because I don't
want to cause conflicts with other stuff I'm working on in this vicinity
:)

Patrick
