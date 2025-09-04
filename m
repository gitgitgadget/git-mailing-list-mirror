Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1812F3627
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989767; cv=none; b=pVQHmw1caw7pRPniSItuHXbejJf1b3GaRlBq96TsLI3S4Ot5DnvsrGi2TFC4VYV4lYCDZVKpTU97FUtR1eT6HQ0flJBEewxSjXIHk4/nZO7dm3CF9iAHoNl4SHpVzwxbp0c87a0MUDZy/13diJL65VktcfaHazJQIXW7nJnKgBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989767; c=relaxed/simple;
	bh=V0f8d+1KevzGusGZ/JPPBkMcMy7Q1moxaHNN4ItKh9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7qpCpkXUyABE5U1s/xiG4CsoGr4KxzXeHEMTWQt4I/lGUs78FK2fq1APvlZfhSoqVuHeWPL0dC7LNIc6OdehcFSpD652UiaL+ZU2YpKIKAQVkmewPm3Ph0L5YjO2n5P17XReJn0z+1/ZIMOxX7dCdiS+LS2edk3HlXPOUG6vcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ilUTwz0v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GwdOKIxS; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ilUTwz0v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GwdOKIxS"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A7DD47A01A6;
	Thu,  4 Sep 2025 08:42:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 04 Sep 2025 08:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756989764; x=1757076164; bh=U6FiBIx4lo
	r1J4VNndmDGdT7e8w0khJaG8BKnEtF8Yc=; b=ilUTwz0vpxah1dLfoXvQQTGGg2
	WeT3t4Fi2kMQ2usuS65AMevfabJbQCyseFHHjyUG4cMdiOXbde9QZii3JObu2C+m
	h8Mc0rtvqTL972cLo4+o1wuGIOV6sk4scPEqnHupuYYknafU7Nl8KEG4EaKnqMb9
	gThA1E1C3FUwUvfYpYlm4ks3VcFx++uuQAP/3Gxmbnv8Pjgtf4P0JMGcpa8ai/+M
	/AMReu3zbj3TMaA2nxaqNlwA/y2SKL9/20oF0anUONFdycqYNT1mCLLIZbFXG5aF
	Mhbk5dzj6zRSWRRY3WdvCifuYeuGI2aUdCj1QVxYoiVod0vvht2493oha5tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756989764; x=1757076164; bh=U6FiBIx4lor1J4VNndmDGdT7e8w0khJaG8B
	KnEtF8Yc=; b=GwdOKIxSNDFeYHPlrsT5E0IAZy/NHOTc/8+RTrJgDBXyUY1g0xW
	E0Y5J4Mz/UDc+Fx77uxqMKhD9GrGvmO9VBvXQEwxdd6tODwHQUHulKTKT0NNMy85
	Ewv0JVIsNVOHqhX8orZFEPyPPg4hTIT+5KVpDXT1AoPrT92BpkKwoE3OZqsnjoUu
	3lxEh9Ij4eUm8fJSDrCRUORwozJCP/dKwkb1Upcod5iVcjA7VxBZRHhLOmB5T5tj
	11Fq8cl64uGV8t+bdgjFLKNuy22iQDHtAt/cEcrWN+Q1NIB/DisJQK51OpqmRJ5I
	n/nQjH/Gx6pRb5/ooNmaRbhLd0AGKdHu2hA==
X-ME-Sender: <xms:RIm5aKZr1nD4Sto0V2SHSSFTv0_FOHKnkwFTBJMzdIKimv2_djqYXQ>
    <xme:RIm5aH8H9U6u_sMWrXTUkLL8eEwUtUvfY7CtXM_aWTTNzEty1pOkuK2XbzE658e8R
    TbGoayyAHPzCpEN-w>
X-ME-Received: <xmr:RIm5aBhZRKevo38F6hL1lerzQozdEl8hZn3SuDehBHHFvje7Dvy5GvMN4uMem-t2lIICIRI3VBPJOMfrcysmHpaGlU_pJNWC9XCvGPj4i622Xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejtddtgeffkedujeejgeduhefghedtgfdtiedule
    eulefgueetheeludegueeuveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:RIm5aPe0hj8katp5YuUt8lGZ9BmLe4G_6Fd9aMXGw3r9u3KgrhU5_g>
    <xmx:RIm5aApFO2f4tSisg-ERDnH_RiSHgjG-9ZG5hULb-NoSfJ6UfuC87Q>
    <xmx:RIm5aMB0Zg0y2nPEPpg1xdNDyR15sqSIg0xKFuTtrUCBye9phTxmPg>
    <xmx:RIm5aFYcsf0CbkTVDIM0ZRfQFN9lV3qv6Kqfi4ZxEAzXsRpVoPaD_Q>
    <xmx:RIm5aOLU_ABZ514eaBq1qNb8OxyQ7FLx47I99aiuvSEuYCVmCKFZG_Gk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 08:42:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 21ed94ac (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 12:42:41 +0000 (UTC)
Date: Thu, 4 Sep 2025 14:42:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/2] upload-pack: don't ACK non-commits repeatedly in
 protocol v2
Message-ID: <aLmJOdxUYiyHpiLA@pks.im>
References: <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-0-4e019af4dddc@pks.im>
 <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-2-4e019af4dddc@pks.im>
 <xmqqtt1ic0ci.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtt1ic0ci.fsf@gitster.g>

On Wed, Sep 03, 2025 at 09:23:25PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/upload-pack.c b/upload-pack.c
> > index 4f26f6afc7..fba3e339e2 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -476,20 +476,21 @@ static void create_pack_file(struct upload_pack_data *pack_data,
> >  
> >  static int do_got_oid(struct upload_pack_data *data, const struct object_id *oid)
> >  {
> > -	int we_knew_they_have = 0;
> >  	struct object *o = parse_object_with_flags(the_repository, oid,
> >  						   PARSE_OBJECT_SKIP_HASH_CHECK |
> >  						   PARSE_OBJECT_DISCARD_TREE);
> >  
> >  	if (!o)
> >  		die("oops (%s)", oid_to_hex(oid));
> > +
> > +	if (o->flags & THEY_HAVE)
> > +		return 0;
> > +	o->flags |= THEY_HAVE;
> > +
> >  	if (o->type == OBJ_COMMIT) {
> >  		struct commit_list *parents;
> >  		struct commit *commit = (struct commit *)o;
> > -		if (o->flags & THEY_HAVE)
> > -			we_knew_they_have = 1;
> > -		else
> > -			o->flags |= THEY_HAVE;
> > +
> 
> OK, so regardless of the type, an object that we already know they
> have do not need to be processed twice, which makes sense?
> 
> For commits, we used to ensure that even if we see a commit that we
> know they have for the second time, instead of returning, we marked
> its immediate parents with THEY_HAVE bit.  We no longer do so.
> 
> Instead, the new code only paints the parents of a commit that we
> haven't painted with THEY_HAVE.  Otherwise we return without doing
> anything.
> 
> I wonder if they are equivalent.  In the original code, when our
> commit A has a parent B, where neither of them we haven't painted,
> we paint A with THEY_HAVE, we paint all parents of A with THEY_HAVE,
> and put A in the have_obj array and return 1.  Then later when we
> feed B to this function, we already know they have B, so we do not
> add it to have_obj array, but otherwise we still paint B's parents
> with THEY_HAVE bit.  In the new code with the same set-up, we paint
> A and B with THEY_HAVE and put A in the have_obj array and return 1.
> When the caller feeds B to this function, we pretty much do nothing
> and return, so B's parent will not be painted, will it?
> 
> I must be misreading the patch, but I do not quite see how.

Oh, I think you're indeed correct. I totally missed that we wouldn't
paint the grandparents anymore with this change. It's quite surprising
that this didn't cause any issues whatsoever. But that might be due to
how clients typically negotiate HAVEs with the remote side: when the
server ACKs an object there is no reason for the client to go deeper, so
they stop advertising any of its parents.

There will be cases where this breaks though. So we should probably move
the return until after we have marked parents, like in the below patch.

Patrick

diff --git a/upload-pack.c b/upload-pack.c
index fba3e339e2..9b9b149068 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -483,10 +483,6 @@ static int do_got_oid(struct upload_pack_data *data, const struct object_id *oid
 	if (!o)
 		die("oops (%s)", oid_to_hex(oid));
 
-	if (o->flags & THEY_HAVE)
-		return 0;
-	o->flags |= THEY_HAVE;
-
 	if (o->type == OBJ_COMMIT) {
 		struct commit_list *parents;
 		struct commit *commit = (struct commit *)o;
@@ -499,6 +495,10 @@ static int do_got_oid(struct upload_pack_data *data, const struct object_id *oid
 			parents->item->object.flags |= THEY_HAVE;
 	}
 
+	if (o->flags & THEY_HAVE)
+		return 0;
+	o->flags |= THEY_HAVE;
+
 	add_object_array(o, NULL, &data->have_obj);
 	return 1;
 }
