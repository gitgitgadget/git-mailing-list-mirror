Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E3278F2E
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237497; cv=none; b=GDsh1EImDYTBTPQkDsq23aEwZTK4r0LXTjhhKF36REsNJgzf+A6SLlYCBolsxulQtMsnQcEAUXmqG/UtUck2hCzPwxSSjQbS4z1Yi/GR5IGvJb4RUsjfRrjxRP8vxJhW8qFEdnR8e4N5XOD2l8o76qzlhqFdeoJtnQuQ33/VGHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237497; c=relaxed/simple;
	bh=m/UL0Fb7gV7NY06dbvote0RX+Mzrv4Ra9jxAlm9Yid0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4lS5IGG6W68I2Ud2CrGMIuvja9pgEvCexvi+QN5nyMGGtMLwc/hN/2PkoWgaDb6G3nIfXe8R2saNd2iZG/SAK+tDc4dNU52khuPmMQvsJhs9j9xT+MiP+WCI/A3fQAGg9WpmkOdnDKZ7WZcjySKAgk3X1UclUnP+pUUA7U+I7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HSmvxwYP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C999vRAq; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HSmvxwYP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C999vRAq"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A32E51D0018E;
	Wed, 11 Mar 2026 09:58:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 11 Mar 2026 09:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773237495; x=1773323895; bh=Z4b3mkwg3i
	nQJ4J7UbS1X04j0uwM3mnmMG1picD0Exk=; b=HSmvxwYPUooz4lwxXAvMiXsTEw
	XSHH5rHsva0Sm3MZwLagCLOvjK0ViEtkgi1ktjHl0rVINLp9eSZnj8HCJ1LjCqU4
	CsuB8G+IeCQWvbapQUYRNeZ2WwWO1jS2OINcjxz3dQ7XdzDzOlSGvnjUgjwvX9fW
	t7U3IvjTIFpU7vdicn4JtRo02YjdxS3C7yjLjhbym1Tzs2s/NGjIUDWreFRtiNHf
	Dd6qFSJFd0aHhYDZjBj/ti2hDr2c8MffM7x4mGdiNErj1yszBNrvAvk9cSV2lXhD
	9xIgf6FtDlSlHQ315QSU1cplEuQtrjPajI21ZLye0b0jSoiqZjyIvkCtFrUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773237495; x=1773323895; bh=Z4b3mkwg3inQJ4J7UbS1X04j0uwM3mnmMG1
	picD0Exk=; b=C999vRAqGO+q92uE4LN9b5GmlGrvJxKDkjzazbaLPriwJ/aCKew
	yD9oXI/YiEn2U8BcAjTpGSR5MvNhqyMJ9fwqxG28hZC/IKxVW5HiBxdlAddNQBiL
	ytutiARLNvD06G7ovePrT7PTGXXFLrVDwJFRlN/dBhwFlwdV15jW3xCeaoId4wzw
	ESIDFBYVvKeE9kK7xL4SalPybMp+zi3AkbKCLn3ME35r4zS78wheAEv9/iPzNe5m
	Xwg52Iutua3O5vueJ0JMb/vrPi8D5TAK7lWo9QPJgWU/1tMNCTGI01ZA+/3TPZBg
	u7XVhPwVTntqOINsWFz3DrAwv/qK94dKPnA==
X-ME-Sender: <xms:93SxaViK-Tfg1D6Tt5hX9IDQInNJhU6oPk4eBkV_yVGSexnYn6RJzg>
    <xme:93SxaaPt8xTXyMTeV5p5-h7t8Lj0AeR5T0uakME0Q0bGZC1y0w0-GbywfeAyQ1aNq
    NDQ1SKYdRGglWYxIkVF-83197reFRJk3behfD8hAdFzqA5RbBLUUw>
X-ME-Received: <xmr:93SxaW7peqfUHbBztCVEPfkeLMJ0OvP4-rhSs_rIU8FlRK-NU7KdNrkD4Un6TL5mIKw0MKmyrCgH_0pSVUC5-zfXrrot2iRq6fpum9KnaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomh
X-ME-Proxy: <xmx:93SxaY21PDyrTPoPiigZ6E-SS6PU-dm9-OPjk0kti3IEhNvkqW3tdw>
    <xmx:93SxaXbmiXKp177tEuPXVYCw9hlKGUmRqHYJQz_W91tVbqdGxnbiyg>
    <xmx:93SxaQDXIU4bHf7T_TLxmWLF1AnCT5Wkh1Wv6OJnEbFGtSqY9Kbjig>
    <xmx:93SxaZ-CZJFUgNw2HZiV6rm_ZHFpGjGgPOMoFvK9-51ksen19PNsyw>
    <xmx:93SxadLkiQfqlo6z0jQtdkKH9uFgYrraHJOkWrgoAY8OcF6Udafs1fIQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 09:58:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7d74aea1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 13:58:13 +0000 (UTC)
Date: Wed, 11 Mar 2026 14:58:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] object-file: extract logic to approximate object
 count
Message-ID: <abF084pB38G5Nyv6@pks.im>
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
 <20260310-b4-pks-odb-source-count-objects-v1-3-109e07d425f4@pks.im>
 <87v7f2lei6.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7f2lei6.fsf@iotcl.com>

On Wed, Mar 11, 2026 at 01:47:13PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > In "builtin/gc.c" we have some logic that checks whether we need to
> > repack objects. This is done by counting the number of objects that we
> > have and checking whether it exceeds a certain threshold. We don't
> > really need an accurate object count though, which is why we only
> > open a single object diretcroy shard and then extrapolate from there.
> 
> s/diretcroy/directory/

Thanks, fixed locally.

> > diff --git a/object-file.c b/object-file.c
> > index a3ff7f586c..da67e3c9ff 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1868,6 +1868,47 @@ int odb_source_loose_for_each_object(struct odb_source *source,
> >  					     NULL, NULL, &data);
> >  }
> >  
> > +int odb_source_loose_approximate_object_count(struct odb_source *source,
> > +					      unsigned long *out)
> > +{
> > +	const unsigned hexsz = source->odb->repo->hash_algo->hexsz - 2;
> > +	unsigned long count = 0;
> > +	struct dirent *ent;
> > +	char *path = NULL;
> > +	DIR *dir = NULL;
> > +	int ret;
> > +
> > +	path = xstrfmt("%s/17", source->path);
> > +
> > +	dir = opendir(path);
> > +	if (!dir) {
> > +		if (errno == ENOENT) {
> > +			*out = 0;
> > +			ret = 0;
> > +			goto out;
> > +		}
> > +
> > +		ret = error_errno("cannot open object shard '%s'", path);
> > +		goto out;
> > +	}
> > +
> > +	while ((ent = readdir(dir)) != NULL) {
> > +		if (strspn(ent->d_name, "0123456789abcdef") != hexsz ||
> > +		    ent->d_name[hexsz] != '\0')
> > +			continue;
> > +		count++;
> > +	}
> > +
> > +	*out = count * 256;
> 
> This makes the number way larger, but I don't think we need to worry
> getting anywhere near ULONG_MAX, because I would expect to have Git
> coming to a grind way before that happens (not to mention filesystems
> would get unhappy about it too).

Yup. Even if `unsigned long` was 32 bits that would be >128 million
loose objects in a single directory. I agree that this is probably going
to make some things in Git unhappy. So we could have overflow checks
here, but I'm not sure it's worth it.

Thanks!

Patrick
