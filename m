Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A56822A1E1
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772717036; cv=none; b=AQPUHny4EgxnxQe6nYpWXfxlCd9rtTpktBDRmDQjx2Adn9Sntig5fJQ5K3k3XCeXWXtAilZ0rWXmLgdroOgRt3tItawLEHXY+nCV+Q/NFnfhH/8E7jJlvGKhkx0BLFP7He0BQKrj4HGOUdAKaG+BItprU/7Xil47zPz6S6Qt6Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772717036; c=relaxed/simple;
	bh=6VUw0AYtQhRsQ5/rpbOX94O8hLSCTIlviMC4jTE7D0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hftR1eXSrBIAuyEdNsB6q8t14J3HZE68oysR4bPS9G2fvYwpdAL2o3wqmuiuBQgtDnFWBXrAan+B+LJ4O9YDkiZJOqGqDQ9AviIyZ2i4kwjqIBm8iUwgUKNqVVQsZtN/04YAkcLhv7BnElxhUpcfAWy1JL56zKCAbT9om9hQc6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TefLU9DU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rH9zBNSb; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TefLU9DU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rH9zBNSb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id EE16E1D0027B;
	Thu,  5 Mar 2026 08:23:54 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Mar 2026 08:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772717034; x=1772803434; bh=cpOz24j+vg
	BCMHgJ1702DWbltY6t59fxJ2OYOjFbysI=; b=TefLU9DUQyiVtt3Mzwp6ARMsYY
	fDFnD6YuGuuHCuxeM2ua5eekxiloAC4ZmPnLAtcrn9TzZJGH30Z9rKmazxP4Mw1t
	Ie1xB7KccYqmt7muApgIYFIhuGKI9N5rnFe9hT6E7kMaO4ASTZIT5FGItmijE2ds
	KAGBC3D2uvo1qlYuGlSoPnf4rkhguu4eABdzJJ8/DTBHLD/y0EmE4g3UV1GHShPz
	WXpCHbVjalgkQHeND+tYCriy5JcACxsQeQqBVZoxuX/zSCBRxY+bvJ52nbKo2IVT
	DN0IYmjALha3QVUK32QlQjM3Clllqib+0iwOZXoog1oIikozZVOnu72+vnvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772717034; x=1772803434; bh=cpOz24j+vgBCMHgJ1702DWbltY6t59fxJ2O
	YOjFbysI=; b=rH9zBNSbKdI9COh1lbe56E4+zRDDrwoBBzhSb44Gr3A/ha+fggd
	YL726pPB4IC/aipRQTK6Y7zCeu316pSRkZ99LtrihPbQZ5Ny0IGaTfzXxon/Ge61
	98AXjnhZf4Ys3movqtIuNUdYCNH377UC5nSQq1ImiWZbhgHkYGMbTnLK73vopwHg
	ONZRHQkRQsxxBAKO7WxfCERlq7RA8wKISSQVPYT9MkQmFQd81zdAks0etxOZhDFp
	tyJyDysKu/5CjsPqnZx1XoYPVadLosGK8EilEixYyM0Abf2Zls7fctBU8Pkjd42k
	CD4+L8RFosoxO0rHKQ4xZ9SeBKSh9BKqXkA==
X-ME-Sender: <xms:6oOpaRW8TVqMmfJNyTdklRNUjBN-NkCBDLIebD-NVvPxZkx488lDlA>
    <xme:6oOpaXmSA7x4hlmcXE-ah9fcqXzfOAA2f5_dtDkEICGTj4PQwChVDFIP5iGcPpIPn
    lQzsAAzeeKvVkNBYPvlJaaiBA0G81T8ZCc3P-ZZs8pnPHXg3LY>
X-ME-Received: <xmr:6oOpabAJ82wGsxlmR4qTGWiflcFgGJShlEN2BQoRSExywpfdoDwYYWcjgZmrld1uxzWrXVSE_4Ah5CoA4vYm4BoQWw4o8FA8LVPZ1vMNUTxS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeigeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6oOpafeISXQVSUusb9uJ6Frs1zic2XNpIyR9XJyoBHztcKlp1HIuEA>
    <xmx:6oOpaeK41_M2u_IRW8d2wctyJ6PcGzfE4toAMZyVhMZPXjqBCqEF7A>
    <xmx:6oOpaaev5KzP16XSmhFrcMSDjnXaiHG913QIYe6LbxlVi9WdVZyRLQ>
    <xmx:6oOpad2Gt66vWzaSfOjHm0IE2G59Ri3zRbF8KUGVfhvXngKd_29IiQ>
    <xmx:6oOpaWGwD26EsJO64YcFPD3K-zSpZ7w-9knWNjdl52gTa7EYs3_uCoAr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 08:23:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab76195d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 13:23:53 +0000 (UTC)
Date: Thu, 5 Mar 2026 14:23:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/17] odb/source: make `read_object_stream()` function
 pluggable
Message-ID: <aamD55QFCCdMQ5Tr@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-10-253bac1db598@pks.im>
 <CAOLa=ZT256atEES+7-8q9tDPzW5h=L-ApWuHF1udUVFQ9QrCFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT256atEES+7-8q9tDPzW5h=L-ApWuHF1udUVFQ9QrCFA@mail.gmail.com>

On Thu, Mar 05, 2026 at 11:13:24AM +0000, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb/source-files.c b/odb/source-files.c
> > index f2969a1214..b50a1f5492 100644
> > --- a/odb/source-files.c
> > +++ b/odb/source-files.c
> > @@ -55,6 +55,17 @@ static int odb_source_files_read_object_info(struct odb_source *source,
> >  	return -1;
> >  }
> >
> > +static int odb_source_files_read_object_stream(struct odb_read_stream **out,
> > +					       struct odb_source *source,
> > +					       const struct object_id *oid)
> > +{
> > +	struct odb_source_files *files = odb_source_files_downcast(source);
> > +	if (!packfile_store_read_object_stream(out, files->packed, oid) ||
> > +	    !odb_source_loose_read_object_stream(out, source, oid))
> > +		return 0;
> > +	return -1;
> 
> Same issue here regarding loss of error code propagation.

That's fair, but we didn't propagate the exact error code beforehand,
either. Furthermore, it's not even specified what different error codes
would mean, so returning `-1` seems good enough to me. It would also
mean that we only ever propagate error codes from reading loose objects,
not from the packfiles, which would be leaking an implementation detail.

So overall I think this is okay as-is, but let me know in case you
disagree.

Patrick
