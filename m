Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC15023EAAF
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767785252; cv=none; b=gRBAYo/fZeQWQ5JsYB++YXJbSqb+vgqsRXotmXY9WcERICqIYkEX7/7anlbBgV77+vncX3B0Ck4gilj+pptEUWBAvr5pn7TPNZUHyz3C9Kh+JmYxd+33mg/nbC+mWteH3MItfAowPYkL3EYQqzb5Qnb4htZ2uOJmMjk+iUXKdFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767785252; c=relaxed/simple;
	bh=yNsn8Hi4k15XoJIPpGM5gX0hRoUpeFJ/ZQ9KqZdWvLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ki0plekKBrg3KQHXWDqJei/Uc3f82xSmMAHFq0hTEZRB9ka+N06zao2SGAyk/9LMx0oSGV+UYh5NSqBEHAXE9GLGCsL8SVZ8eN7HJZqDbJHb3jtUqIGWeO1FnREL/13dgSVgTQx0luTN54w2LL9YwEMsnxAKOXxKZ8l95Rk0QDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZuOVDOfy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vnlr1C9r; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZuOVDOfy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vnlr1C9r"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F6C7EC0258;
	Wed,  7 Jan 2026 06:27:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 07 Jan 2026 06:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767785250; x=1767871650; bh=sbGMQOT1eJ
	PBE1CNoGg4MEpp9YqD8UzLf0xfp7di4mg=; b=ZuOVDOfyueyZRZg5ZaaTwyJuow
	4eoa3x77h+aSr7ZLim/Q1uQYdXTjUtvSh3bWhyKNhKqmCz2fOKTbFjVaiNfmkdYP
	5D8XxWy7dhZn7PPZQJO1AH7KNFkWbLFqHlCqM9BlJjjg0wgg9OJJ6jxQiCoPMj4q
	Sk7Sco3Fh8uZ9hNbPB+fxO50xhD7B88jvxgMhFf3qtDXQvyiaae2KChg+M739v6/
	pnyrD674VR914BJ9WV1rVuae5geL2lVWDZOeeHzc+Tdjchdn4+8Z6RMvhaybL1pH
	fG6PfHyklCdX2vytfADrGrZ7J5HpSTv1ePYCvqns6MQXmHnXM4bUTA99K00g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767785250; x=1767871650; bh=sbGMQOT1eJPBE1CNoGg4MEpp9YqD8UzLf0x
	fp7di4mg=; b=vnlr1C9rnNpY6nvybM38NvZKoHvNRDwk0rqO6fa5bH/RVP//G0c
	P5Y2n8hVEI544Mql4hxOVjQdm3TUxdTv+GRJULC1HOqqKTeWOe9C/0VIQk5LsWjt
	02Oyf9npOZQuU423cTZhOoHUZEW54GLglz7MLRMtkPfEycTKwKBaKxiz6rOSwxY4
	2NnSNiEfvjw4otVLFPL3doVff1Yl+VVZ11+CeK1NLLbMOnTo/UuyJ8liRFQBGeRr
	tY/hucW6e+sWzMcRTMKxvRnALb/I7G6VGnhIBALkOSaco82q7N9aSrJ06vyIsLJu
	SbdDurYen1l3xC+kMA0t1gZsBl11+p9JS6g==
X-ME-Sender: <xms:IUNeaQ0lRhMJetnAXSpYpOPI3NyC_iuakNDcu4std-vGlI-E7cwzgA>
    <xme:IUNeaey1lJ-f5YH9w-CQ7brzVFMO1K-7Cz171YptuuLSYIHwwAp4oUQn-JZ2uR2mY
    Ewz6elnpq8L8v-pRmzD3FNL-DKTPiCGxD78bt-5q5GDkWpIayI89A>
X-ME-Received: <xmr:IUNeaSvYFjR_BX4aYGYXncgOtc3BKFKZ_47C3s0uyDhcRqOTUypXNkImw4-UuQaoiM11VbF5Q3EKP9AjaReYUY5ZvLUjEH6klzbutY9zhTE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgt
    phhtthhopegrphhlrghtthhnvghrsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:IUNeaQwcgilX6-avTojMeFbQDty_760A0SwRBz3QX4Xzg88M926kJA>
    <xmx:IUNeaVCIHjs3JFDNIBaac-Y_NCctOBK0R3pV7IsktcwUsZnngU4Nig>
    <xmx:IUNeaecIaDMta9fQzZRoXlyjmFhtjTA9WN6NruyrkZQzi9pi1Th1MQ>
    <xmx:IUNeafnKR_Dobs71XO06CJjSZ033UQXGAB1zxOl4winAfLZI8G7Akw>
    <xmx:IkNeaT3dYqPnyE-dsUwJaEI23O2kpSaXKhsMpuCuC_Beab7sgewOv2hE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 06:27:28 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e47f5dae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 11:27:26 +0000 (UTC)
Date: Wed, 7 Jan 2026 12:27:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Aaron Plattner <aplattner@nvidia.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v3 1/7] object-file: always set OI_LOOSE when reading
 object info
Message-ID: <aV5DHI04KBs4GJn-@pks.im>
References: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
 <20260106-b4-pks-odb-read-object-info-improvements-v3-1-b5e02fae1fb0@pks.im>
 <CAOLa=ZSNmi_Lzb=3EdWks=mMOPvfijT2659y4YtxWnUKVUOXaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSNmi_Lzb=3EdWks=mMOPvfijT2659y4YtxWnUKVUOXaA@mail.gmail.com>

On Wed, Jan 07, 2026 at 12:50:45AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/object-file.c b/object-file.c
> > index 6280e42f34..d566df427a 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -439,12 +439,23 @@ int odb_source_loose_read_object_info(struct odb_source *source,
> >  	 */
> >  	if (!oi || (!oi->typep && !oi->sizep && !oi->contentp)) {
> >  		struct stat st;
> > -		if ((!oi || !oi->disk_sizep) && (flags & OBJECT_INFO_QUICK))
> > -			return quick_has_loose(source->loose, oid) ? 0 : -1;
> > +
> > +		if ((!oi || !oi->disk_sizep) && (flags & OBJECT_INFO_QUICK)) {
> > +			status = quick_has_loose(source->loose, oid) ? 0 : -1;
> > +			if (!status && oi)
> > +				oi->whence = OI_LOOSE;
> > +			return status;
> > +		}
> > +
> >  		if (stat_loose_object(source->loose, oid, &st, &path) < 0)
> >  			return -1;
> > -		if (oi && oi->disk_sizep)
> > -			*oi->disk_sizep = st.st_size;
> > +
> > +		if (oi) {
> > +			if (oi->disk_sizep)
> > +				*oi->disk_sizep = st.st_size;
> > +			oi->whence = OI_LOOSE;
> > +		}
> > +
> >  		return 0;
> >  	}
> >
> 
> The change looks good. I'm wary of early returns independently doing the
> cleanup, wonder if it'd be better to do `status = ...; goto cleanup`
> instead.

I share that sentiment, and I was in fact having a look at what it would
take to have a single exit path in this function. I eventually discarded
the work though because it required a bunch of changes to really make
this whole function more readable than it currently is.

But now that you're the second one thinking this I'll probably bite the
bullet and just do it.

Thanks!

Patrick
