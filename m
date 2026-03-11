Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B760C26B2D3
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237672; cv=none; b=dwUF2/PFCdzfyf9X5OXGXsVWEIrAhEyLsBwUMhH1af/whg/sk5gwoO38zFV0M5UpIps5z1mYvhr/OmDeXFwNK59krKIoJrXnzWkFLNqYkEEw2Uca8FYRZin+ZSlzGUOCZJ0Dk1YRfX3Vroe85NnwTwQSy83Npzy14lrIfc19h44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237672; c=relaxed/simple;
	bh=ed/hgkR4qBFuZaQ//7JyLZB8S0hKpMzgsJTI4sIVKkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpaGH++j0WQhxSNOcO42WZC/g64Dmm80BbUUmOvDME3Rhb6SBmV04U3/O30HmekM0hrZwMCy/KXZp7+LtLER1fltnOqPVmmH7DTIFqnzodBT3DhPcVYoeSp2IJxK7drFA4Ai+jNdYrARiT70i+fYNZbtwjZrwRnCrc++3NkMj+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P3eSqWwZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e1aIZEs6; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P3eSqWwZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e1aIZEs6"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 01C237A019A;
	Wed, 11 Mar 2026 10:01:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 11 Mar 2026 10:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773237670; x=1773324070; bh=FHh/uBo8xM
	vStJHUPKLxLN+BhUe4dNTc9VhODNsMZfY=; b=P3eSqWwZJkl+WUFBw7ZHsBC6J/
	AF5eyD94nAu2bMJnqu+7LkhJNanE4hiAum0bo5l9zKuxZtQ0vyXD8iEL6PFAOlo2
	94tBCVTTekMSCzEDrExlXw62DMlvJIxLOiUgkn5T3/JZU+JN7DF30PN/tqRMw7RS
	BkfdMtoIVtJARmJLZZM4aSxn99XjMdulQfnLf/AMygkRxsxjjlNDRjXfV3NQj1Px
	wi9ioEsfWOiXDSmkFs80jMas3DZ+3oaWAI9IwUduAOKAJ8GuG4ormoB+syCzTTWD
	om7sQVHjWmETEuCdFLXT7+xYW+8iTq/e5HPA6lRAy+Vl4aOel5sxxYlo0G3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773237670; x=1773324070; bh=FHh/uBo8xMvStJHUPKLxLN+BhUe4dNTc9Vh
	ODNsMZfY=; b=e1aIZEs6kz5FgOXAo23nv9cUjP8lncrhYi60Kl3k1q5But9Hx2a
	gAOvfvxfmvAYUMIR5qtvmErB1YDArfjigh54S3YuXpfwbS91imF7Wn173vxAlCaR
	4BNLhMrhDW2CJfS1Srxg8t2X6pT3sIPL1gYjfYpKlUfEKjcG6piHCaB864sezPP1
	XXHC0UxQfkoQP3rOuZlgLIjaSGcBl3GqrUh2CPawo3/xWmLlY9/ZRkblCC6vanC/
	LrThcyifLWKrSS2cHOhyAe2VnQl33wNQNChyQkaV5UZ4SDkjVs1pSKpRnrXPY48T
	CLKYklvp/Gr1AwDhG2Cs2vV/IRcJhIAMx8w==
X-ME-Sender: <xms:pnWxaYNHKZUfHIIlc2d_ET28TAOliOc-Y0OFObFthTEUNgEV5QcKDg>
    <xme:pnWxaU_EKvg8Ud56u_DA7cj3AtuBA2-R80wAGrLAXByB2Xiz5uz-pca_ALmYHGGVb
    V9biygc7BCKc0LA9AeQ9IwqgV1gk9bTpw4p97tQu6v_pp-GkUGLnkE>
X-ME-Received: <xmr:pnWxac6FscWKwNXI63jPpKbg4_NjJ-O75nvIwrmcjBvv4kUGpOUhUtJz4FBEgmmdUYoCAkLTLxYsvB3kyUlp5G9uVUot7rfiods3ysO0Wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pnWxab1Vj9DghMS7_zOhHImMoxI7bogPo8AsaVQUcVWPyO9vMczkHQ>
    <xmx:pnWxaTDNEW7SUY0uOcKeSIx-FH9aacL5Wwd2N_nZuXcc9bQ5RWG3FQ>
    <xmx:pnWxad1oxUHuYSUy0OVv5TkGB3JCQrqzOsKsHGVaPEjiHCLI_deLLQ>
    <xmx:pnWxadvmlIpJAfJ_evd__blqVMitl8gTqjgC5i7G7hdJpuNZ6NSQWw>
    <xmx:pnWxaTlT_5uoJDz_iZpNbWjxODkVpHe7YY-4qerNv34qkxvnOQkpE1zy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 10:01:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fcb5cad3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 14:01:08 +0000 (UTC)
Date: Wed, 11 Mar 2026 15:01:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] object-file: generalize counting objects
Message-ID: <abF1opEays8LQYbr@pks.im>
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
 <20260310-b4-pks-odb-source-count-objects-v1-4-109e07d425f4@pks.im>
 <87pl5albfz.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pl5albfz.fsf@iotcl.com>

On Wed, Mar 11, 2026 at 02:53:20PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/object-file.c b/object-file.c
> > index da67e3c9ff..d35cec201f 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1868,40 +1868,56 @@ int odb_source_loose_for_each_object(struct odb_source *source,
> >  					     NULL, NULL, &data);
> >  }
> >  
> > -int odb_source_loose_approximate_object_count(struct odb_source *source,
> > -					      unsigned long *out)
> > +static int count_loose_object(const struct object_id *oid UNUSED,
> > +			      struct object_info *oi UNUSED,
> > +			      void *payload)
> > +{
> > +	unsigned long *count = payload;
> > +	(*count)++;
> > +	return 0;
> > +}
> > +
> > +int odb_source_loose_count_objects(struct odb_source *source,
> > +				   enum odb_count_objects_flags flags,
> > +				   unsigned long *out)
> >  {
> >  	const unsigned hexsz = source->odb->repo->hash_algo->hexsz - 2;
> > -	unsigned long count = 0;
> > -	struct dirent *ent;
> >  	char *path = NULL;
> >  	DIR *dir = NULL;
> >  	int ret;
> >  
> > -	path = xstrfmt("%s/17", source->path);
> > +	if (flags & ODB_COUNT_OBJECTS_APPROXIMATE) {
> > +		unsigned long count = 0;
> > +		struct dirent *ent;
> >  
> > -	dir = opendir(path);
> > -	if (!dir) {
> > -		if (errno == ENOENT) {
> > -			*out = 0;
> > -			ret = 0;
> > +		path = xstrfmt("%s/17", source->path);
> > +
> > +		dir = opendir(path);
> > +		if (!dir) {
> > +			if (errno == ENOENT) {
> > +				*out = 0;
> > +				ret = 0;
> > +				goto out;
> > +			}
> > +
> > +			ret = error_errno("cannot open object shard '%s'", path);
> >  			goto out;
> >  		}
> >  
> > -		ret = error_errno("cannot open object shard '%s'", path);
> > -		goto out;
> > -	}
> > +		while ((ent = readdir(dir)) != NULL) {
> > +			if (strspn(ent->d_name, "0123456789abcdef") != hexsz ||
> > +			    ent->d_name[hexsz] != '\0')
> > +				continue;
> > +			count++;
> > +		}
> >  
> > -	while ((ent = readdir(dir)) != NULL) {
> > -		if (strspn(ent->d_name, "0123456789abcdef") != hexsz ||
> > -		    ent->d_name[hexsz] != '\0')
> > -			continue;
> > -		count++;
> > +		*out = count * 256;
> > +		ret = 0;
> > +	} else {
> > +		ret = odb_source_loose_for_each_object(source, NULL, count_loose_object,
> > +						       out, 0);
> 
> Isn't `*out` uninitialized here? Should we add `*out = 0;` before this
> line?

Oh, indeed. Will fix, thanks!

Patrick
