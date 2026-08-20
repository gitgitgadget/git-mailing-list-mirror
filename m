Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772F147042F
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235769; cv=none; b=KvXrnvCrCf5v9kxxPFefPTVbT3G+EFqnJ7I91uZlv3CA9WAHxAxx+saBUfMm8nPuHQ4Dp3uSQynAY1V0fN3/yafMioY2Qh5TJ9peZBU+72VvANo5hrVG2+lanLd1e51WbeYwy0x9/zoJMn/7Kqr6vw0M6bCimeaM1vSqcnMx4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235769; c=relaxed/simple;
	bh=WW1lG7fndt5BG/Hkaa0rC+8ZdtHaxcvsbjmkgZ1+u1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTrQwVSPFcTUy0EA7YxMWz3KcDAgkZY3/F62Fx/po7WAojFyUd7pCVwV8o1ZKC80hmtXCW5yOLtH0hFE4TlW0BN7YAz56q3ynkAvHtT3zdmhshzQUoZFqlhDj0Bhmh+DWChKL0E18p86uv1RYnOz/n9lqcAVt4HvIqloGyACLXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R/m4e7G0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OR6wllvO; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R/m4e7G0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OR6wllvO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B4C04EC023F;
	Thu, 20 Aug 2026 10:22:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 20 Aug 2026 10:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787235764; x=1787322164; bh=ZacxLo1VMA
	1T162nDrEWFgAM3cfuwcwdONoeGHupUfc=; b=R/m4e7G0knaQxAKbdOXG0FpAnc
	lBTMeqqoRPffCLe6/ROi9m0hCSs8/WvkJMhKpwnE1fdoL2MeatAp0jEn7UtYzzQn
	zkz8OtjcUXSBDV+4VDgIRYRGscCnRBoexXkDEyu3d+BvKOZ2pEz3+JaLJgid4pF1
	xymUAgQqSAOiOTt/gn3d1Pyzbzp/4/Rf4G/BYVWL4UgZByEjSn7eV8cmgshpHur9
	fYcbCM+8fI6+5UiteQTyyKnKWBGdAZZ+73hJW2j1OZ1y2lVFEU2cZukZSo9WCPhC
	SVYTozGZXxdzJCBv/UTOFQSoe5xsRGz4YPaPVDQSrSp7JXFMSaG5CWxAyVsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787235764; x=1787322164; bh=ZacxLo1VMA1T162nDrEWFgAM3cfuwcwdONo
	eGHupUfc=; b=OR6wllvOj3eTgjUSqM9Vd6i95jFn4Jpw90F9nb2JhnN9HuVsXSn
	6ILogRt+/P8Yyg6tqdeMO6PtVr1UqYJv0tJ4YM9qCxgXnhEe2eANKnh4NnPoA0WN
	jttzDOIUq3o8a1Wjh3c1jJ1VEeZ/d9SIEeVb/mu5xGTqR20DQv/1XCP4SPBiZkS+
	BDUxV93/xP4ShCbALXOCh3T9xMutnqel7Q+vuZWtjKr22WoTHUhSgu+CsWTrlurR
	NKajImVHrlKfWsDxSolHICwMNUkon39qAtt5yuNimLlozgZM3RmfhQea8AAEuxrH
	smSSPZZbApf7aOgkIfvIbMs47whugpensCg==
X-ME-Sender: <xms:tA2Hasx2Lb3RCfk9sUlTRM7hL7LHy1eNlZXm8vnLShu1HU5l9rHcGA>
    <xme:tA2HanvU-IImpyUvScDbSJqoiHh8v5gTy6tYw79zL8WiVlzgRjifDX4P_yXXm9zU0
    18BAVZCELYrB-iinMdf94mCuAb2J-J2w4DhEbf5ynXZqOgb4vuzVw>
X-ME-Received: <xmr:tA2HarsCuxIwnH2q6sGUslvYkdhIbmdiFkxBcsANQ_iaZaFcSllyHOh9zbXSH4U8kAtCTm_WWP41XorsJB52HmHE-WG1k-lGebr3RkSfUQ>
X-ME-Proxy-Cause: dmFkZTGF93IlkDmzRCxJn0k0fIuvALPcvyxxT9PLG+UPYEeutKjLsl83d/LFQblsOU8o9o
    aI0+yoi1i2z1JN2tIkCfVZMuuAiVIS+25zWgp97ZzBmwt2GFvYA4UHB5qUUp2wqP3Z8ExU
    6/bSeEbR5tBBJXmhgIrGIr3vgnTV+jMzYq0IparnCOY9cjbqCvoYxQ10Eqxp/wCs3QvuSU
    mxDQMpZlTglXXmW54TNBRws7SRqqoHZZFUpdiURDNIdPh48OSbmqeXCu+6GDbpV5kMQyjU
    I7ljbCGpG0tAzEGEtAnmjno4zHPkLy8YQTxeSgmbuKyx0STnCqi1oUy64HJr79XRUiI/oz
    plYj25D7hrD15SNHQiSOT2mWZJk47ZVIYv5ftO8qpEMN26Fp1VdVwmDGVwiJk2RRODLwNL
    HuXpuJ8i61BrJC6Jgw2xiL8kHYu/RDyHrymRIB9AGrMeA3N/Pgw+JMlTOZqrldJtx19jFs
    zi4pTGrZSNQz+E2ebJAwUmpnQ0kAgaP2qerbyVSRL1A3dfEBixvqj7tSto6DoNsZqvkVD0
    c18X68tRgjS/QzJL0x99uBOeVS8UIrNbNKyidVKRllKBBcQeiBelFHD6ULBNmuBlmyWujg
    Oxpb0M1OUao1wWzDxlF8CZUeCdcS7Vkt9v6tMrlcbU3MmRc703UsXikRN8Xg
X-ME-Proxy: <xmx:tA2HakOvQpUeu1Ts7wLaD8UPWSd_vTZ-x-132cjeWvAVWbTEJOdp2A>
    <xmx:tA2Hah1NAI3AkqHBo_TJY1yJ9W1B_WtlZ4IpicYyum1MqEK1SNLAaQ>
    <xmx:tA2HaoNktpUhO_oFSx4NWI-PluYXQnPkGdrncT89uzxTCeOaPWJM7w>
    <xmx:tA2Hap2HjU3Bjzv0HfI5YslflEhI-KCnedCbLE7OvUhWbLDEK2Zj2w>
    <xmx:tA2HanvGc70EQK77RnENiDUqyQmWK8LNyLR9QctoPNKR9D5Z8Z141qBG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 10:22:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ea596ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 14:22:43 +0000 (UTC)
Date: Thu, 20 Aug 2026 16:22:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] odb/source: let callers discern missing and
 corrupt objects
Message-ID: <aocNsR60-8W2A-fy@pks.im>
References: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
 <20260819-pks-odb-generic-corrupt-objects-v2-3-a984e3a0ad6f@pks.im>
 <CAOLa=ZSSzR+qKh4Do-F7xZQMO-pE+t4N8qM5hsbfM4Uh7i3d1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSSzR+qKh4Do-F7xZQMO-pE+t4N8qM5hsbfM4Uh7i3d1A@mail.gmail.com>

On Thu, Aug 20, 2026 at 08:56:50AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb/source-files.c b/odb/source-files.c
> > index a28aa5042d..e88fd1d399 100644
> > --- a/odb/source-files.c
> > +++ b/odb/source-files.c
> > @@ -65,12 +65,26 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
> >  							      enum object_info_flags flags)
> >  {
> >  	struct odb_source_files *files = odb_source_files_downcast(source);
> > +	enum odb_read_status ret_packed, ret_loose;
> >
> > -	if (!odb_source_read_object_info(&files->packed->base, oid, oi, flags) ||
> > -	    !odb_source_read_object_info(&files->loose->base, oid, oi, flags))
> > +	ret_packed = odb_source_read_object_info(&files->packed->base, oid, oi, flags);
> > +	if (!ret_packed)
> >  		return 0;
> >
> 
> Nit: Similar to my previous comment, wouldn't it be nicer to do
> 
>      if (ret_packed == ODB_READ_OK)
>         return 0;

As mentioned in the preceding commit, I think it would be somewhat
pointless and only make the code more verbose without much of a purpose.

> > -	return -1;
> > +	ret_loose = odb_source_read_object_info(&files->loose->base, oid, oi, flags);
> > +	if (!ret_loose)
> > +		return 0;
> > +
> > +	/*
> > +	 * Reading the packed object may have failed even though the object
> > +	 * exists, for example because it is corrupt. Report this failure to
> > +	 * the caller in case neither of the sources was able to read the
> > +	 * object, and prefer the error of the packed source in case both
> > +	 * reads have failed.
> > +	 */
> > +	if (ret_packed != ODB_READ_NOT_FOUND)
> > +		return ret_packed;
> > +	return ret_loose;
> >  }
> >
> 
> So if we already found the source we return early and only come here for
> errors. What I don't understand is why we filter out ODB_READ_NOT_FOUND
> for packed. Wouldn't that leave us with
> 
>     ret_packed => ODB_READ_ERROR
>     ret_loose  => ODB_READ_ERROR or ODB_READ_NOT_FOUND
> 
> Doesn't this come down to preferring to propagate ODB_READ_NOT_FOUND over
> ODB_READ_ERROR and now packed error over loose?

So here we know that we didn't find the object. So there's four cases:

  - The object was not found in either, and we'll return
    ODB_READ_NOT_FOUND.

  - The object was not found in the "packed" source but was found in the
    "loose" source. So we'd have `ret_packed == ODB_READ_NOT_FOUND` and
    `ret_loose` at any other error code. And consequently this block:

        if (ret_packed != ODB_READ_NOT_FOUND)
            return ret_packed;

    Would not trigger as `ret_packed` _is_ ODB_READ_NOT_FOUND. Hence, we
    favor the error from `ret_loose`, which contains our corruption
    error.

  - The reverse case, where the object exists in the "packed" backend
    but is corrupt. In that case `ret_packed != ODB_READ_NOT_FOUND`
    evaluates true, and we bubble up that error.

  - Both sources have a corrupt object. If so, we simply favor the
    packed error because we have to pick one.

I think you've simply misread the condition, as we do exactly the
reverse.

Patrick
