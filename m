Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D154235063
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772717031; cv=none; b=h9nm9CpMZTHJGQHGmSg0LWcSQeWj1uf+r7BZqCHP3rocZtFnTHKKFpLUPDJ6nvJQVe79WigkizZqUaIK+zTyLY8X7/LiMGbjxhBmcSjiDWSnPIT4yGXdpSFfjHhDMiosGCIaONffh5D5RNsUahNIAYDYIDuOUrfUtmpXlA+h3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772717031; c=relaxed/simple;
	bh=zTcjz20MYP0b7fS/ywkbB2K4W6EtOxDm3/8bzsnIvrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIC0QwKjTHFLZfLPSrQDJjIl0BxewCEvlRmNlgaSDbScm7sziZKRJlERdlET+EjLQ9f0we4XJA3aihd2IrTgUkfRNf1CreUPOYgkzlKGGE+ALeXAw5TMsbtZqWlGBuo0CM0rm0bV4BojWy4Zy2ysHVwsipDF8Ophc51H8eEiWeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hhigJ8XV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BkW5SSZa; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hhigJ8XV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BkW5SSZa"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DDA781D0027F;
	Thu,  5 Mar 2026 08:23:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 05 Mar 2026 08:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772717029; x=1772803429; bh=WrOOFs0AAA
	KV08ebs8Wx0hrmGVlG+CJCrCD5V6qZTCY=; b=hhigJ8XVgyA0r6bc3oDzxhMtiB
	NYOMKjnkZzoSloOgEbHKQS6JdsqejLlOoHyysXQX1o/qDBxPxecImVdBleE/HGb0
	uBfKIXrMXnvw9JmSWT3dUmS0m8vWIug6r3c/wwYC96Xh275h3Xo9rpt3yIxyazy+
	7N3IW1dvumomb0Waty4v0HjXVpmwY9iB46rDojpgkSVIEbmw9Fc/waw3eaIaRHbh
	ngyhYwx10OMj+/HdkJwXa15/hbK+3pSCO99MF+UIHPzSoup/4D374ev/dG/NwBCy
	nFOsQGR0Cr12QqyzDhCdl2gwmJedGFi/HwMnW1DiLlfTReYkxQ51TO24gPCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772717029; x=1772803429; bh=WrOOFs0AAAKV08ebs8Wx0hrmGVlG+CJCrCD
	5V6qZTCY=; b=BkW5SSZamvXWFG7yt79EiReB3skwGyzS9ibksIzZoWhzkywUI5W
	kLVInpUrZj/rb5bjEYLIW2j7cAWFMBGykXrtXp733oOQy6EHDb8e81Gcd0oFRPG6
	NhJWnkkHFzu5noXM2DU2KDh4x9rA37kmXk8ctvsD7fSXuskka0ems5/fUmiIasrg
	3oJiOi4WS4mbzKtcM91DSkY8k3fX4yO1AjB34dIyVc4t+IjW0GMQ6VDUlP1TxZ5r
	4SWfUSmXXHyhGyKoZDHfOLyQkd4W82vy1szT2YcyWwEZXrudQxf+g/HXsVYtxYDI
	y7RBIuQkaclDQ1uUDI06QNMEho5RrwLgvYw==
X-ME-Sender: <xms:5YOpaf95MBPLtUb1AU6uMEGLgzmAz9De8hTGSmtSoTg4jEmp3JGmDw>
    <xme:5YOpaRur5ioW9y3qjeMdZz4Zuvax4BJz0LRA9g1tqR3urB8bjAywkT8wlmKGACdnI
    1rM0D7YBxhdwIyVs60hhDuwe88XpkqahzudOF8UZ2bnBKZ8Yd9Gng>
X-ME-Received: <xmr:5YOpaaoSHt1oAf2qKOgx7TTh9N4-CyQef53n_HymPTBDjvc7yssF0vkp5ZCDXeL0vmEqN7-GWYMShYtNmZHODDTgk3mbcvcEEfAQTyo7d695>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeigeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:5YOpaWn3JPPeGk2Kup_9B6bXyx58QJTCb2EisWaJwtRPBGExeC4O8w>
    <xmx:5YOpaWwrmMmr2ifFprnE79_T6ZbTYTlpgMuuRIKu9H8V-KXOiZ8D4Q>
    <xmx:5YOpaWlw9dlBczz-h_w4DQqf7nv5E_oaQsf4GPhaieHFifUDmNLV9w>
    <xmx:5YOpaXfl39p9Sq_TdjFdtfC82mng02NJjS47K7EoGz0Iu2vf17HyLQ>
    <xmx:5YOpaeu8tgpL8ICaAY9QjQFemcw_d4iLernxlwRU5Gn4-VwCahJrlqJ5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 08:23:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d09908d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 13:23:48 +0000 (UTC)
Date: Thu, 5 Mar 2026 14:23:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/17] odb/source: make `close()` function pluggable
Message-ID: <aamD4j6xTbt5EJ1M@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-8-253bac1db598@pks.im>
 <CAOLa=ZRucajqkGeiHM8fvSm2WJFStoBARSC9MH2W02Qw8-7JyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRucajqkGeiHM8fvSm2WJFStoBARSC9MH2W02Qw8-7JyA@mail.gmail.com>

On Thu, Mar 05, 2026 at 10:58:32AM +0000, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/odb/source.h b/odb/source.h
> > index 2f8132f9e1..7af4900ab4 100644
> > --- a/odb/source.h
> > +++ b/odb/source.h
> > @@ -59,6 +59,14 @@ struct odb_source {
> >  	 */
> >  	void (*free)(struct odb_source *source);
> >
> > +	/*
> > +	 * This callback is expected to close any open resources, like for
> > +	 * example file descriptors or connections. The source is expected to
> > +	 * still be usable after it has been closed. Closed resources may need
> > +	 * to be reopened in that case.
> > +	 */
> 
> Nit: here we say 'may' need to be reopened...
> 
> > +	void (*close)(struct odb_source *source);
> > +
> >  	/*
> >  	 * This callback is expected to clear underlying caches of the object
> >  	 * database source. The function is called when the repository has for
> > @@ -104,6 +112,16 @@ void odb_source_free(struct odb_source *source);
> >   */
> >  void odb_source_release(struct odb_source *source);
> >
> > +/*
> > + * Close the object database source without releasing he underlying data. The
> > + * source can still be used going forward, but it first needs to be reopened.
> > + * This can be useful to reduce resource usage.
> > + */
> 
> Here, we're more explicit that it does need to be reopened. I like the
> latter better, this way, sources which don't need to be re-opened can
> simply do a no-op. But this makes the expectation on the user side more clear.

I consider the first comment to be catered towards the developer of a
backend, whereas the second comment is catered towards the user of these
interfaces. So I'm intentionally being a bit more lose on the first one
as we cannot assume how exactly the backend is implemented, and whteher
it even needs to open anything. For the end user though they should
treat this as if we were always reopening.

Patrick
