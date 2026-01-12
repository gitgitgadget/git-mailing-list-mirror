Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D66C33F365
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 08:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205889; cv=none; b=o1y/iuXXvR9yAUBZDdu8mLMrmCUEydIIx2N/VEOYpk15f8XyB57pdZsg6PvQh+SWhraB+v2DQ2VeIEk1tUwnmleWRsSNX0ee26m4k5gV4JI24g/zZofsrv5FSu8FXdPIeuitVb3LG7oghAmtNypOM1+JaKtBqGGVV4Db7f6IQZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205889; c=relaxed/simple;
	bh=hyQu49+zrsuJDLBk3vTLq7ZRCB7zV1fxQc/YRVG1uqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D22VRETXRJI8B6zLB4pu4QHMooeXO60N4NuhvHFZSfPvcD8+wQI4raaVrZHS3xMDq9/omb5J+5SV0OHd5aOQjnP1t/TyTGX0D9b97Lz0E0+Pf+/qOYPlLWRyyFNp9mGXt1jmdQMVDHGNnjX+wqPGEIhbnRLXEocw9fjfTuCNaEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dinSzHCK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kDSDkx4y; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dinSzHCK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kDSDkx4y"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9B28F1D000C0;
	Mon, 12 Jan 2026 03:18:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 12 Jan 2026 03:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768205885; x=1768292285; bh=smtI0tmGgx
	A6JyXicRGE+0m7+R8XbTkjoznicZjTKe4=; b=dinSzHCK5DKhCH+LKzJv5+WrzS
	Glx+IELsM68hfIFASTv/r2/fPRxPnA9K6hFrqsSJpZAY/kbhSg/7fDKK9b9twcgz
	RsB3ZdumW2ymlUVANG+lydpV7qPCzWkAJE9hzpKnQWxEFpBa9sDCGfEAbeEu33rK
	zaF3TlYMQslIFOFn6peTcA5Z6LaZWMl9Rs7MywS1Sy6yAJXIgfhhwyIjvxCgaPoD
	l6Y+NEK1oDAykQ8PfXCtClHhrG0w9cpvHfMPGX7AxmY15YWrXpkTmtQ0qQIm+FZW
	TurzIaR7TDPTzlIeVjfcv7AbY6H7kz0LJQBlqTkw83tCSRUu1jQZUyannlhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768205885; x=1768292285; bh=smtI0tmGgxA6JyXicRGE+0m7+R8XbTkjozn
	icZjTKe4=; b=kDSDkx4ycaI9liCRZaYzRYMUzk282HApy2S62Z5ik+aimZTthDK
	n3zRC2GTTVSJhhoUiZyQpHrS4imfcADwS0AXLb7OelQR/Xkfkl2IFv2x9tVVMsm+
	lRT+46LvD7fWOuy8xanchAVrPiFgSfug3upL8lxNG6eAVRBwW2nIBSUUn23+7US2
	A0z5CpcoyClaWfgYLdzxrsmYbW5R61I5o7pL2YAugNDIsZuWSSogTMQBRzWb2EyK
	VydVfq+xqv7bWs6bD3fRIXrTZaPlsndRJAnQ3j5z/oW6An7U8Ac9CIx9r4rnYuVo
	zGFDVeUmL36/WlZVqcejPgU0ObrsZTA5Hvg==
X-ME-Sender: <xms:Pa5kaaVWSprwx9f_krfQANJY6iHoHANBShi286FKiDr4bM4_V0c47g>
    <xme:Pa5kaeAZbSPF3YFURMwERuru7WAFRnHx-2Z8BRhzg5jz2UBgMzU4YVent8EVwg_BF
    tltuUFCOsZMvZxFVVWK9p3xiADKKJ_zlmtntNxmBQa1pPWRJ9_x0Q>
X-ME-Received: <xmr:Pa5kabxMsWl8-Kpji1mM6q2lxk4ZdQpVilsXulu8VI6_SRR-eHKEMEm0QeSnBbXDxQLqYcnfEbqz2HiIJtxWRpZC5f74jptt9F4Ra4I4nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeileehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirg
    hluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:Pa5kabAXiflBGe2yllxfCcUM6hzUiijQPbQ_4ymrcBBh2C5IzFLGmg>
    <xmx:Pa5kaYaxSEtpz23zpeZa5va5IPGU59Zbjk64XL9M_SM83cfHfhcFIQ>
    <xmx:Pa5kaTh7i0MKo0GZ6bfYppUTotwRHTSIGQ-ErsxjDQSUeNoj94FINA>
    <xmx:Pa5kaa7QiqgEo54yjsxv2FsnImv0NoHRGKjLk1Wv8d4Gq_FXNODdyw>
    <xmx:Pa5kaSeQMwHUaBhjfE-NdruWwMt83Fb84epV2-ijlnmCO5Ol7KRO-bXl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 03:18:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e98e32f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 08:18:04 +0000 (UTC)
Date: Mon, 12 Jan 2026 09:18:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 16/17] builtin/fsck: move generic HEAD check into
 `refs_fsck()`
Message-ID: <aWSuObEsFaxi1NAf@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
 <20260109-pks-refs-verify-fixes-v1-16-3587dba18294@pks.im>
 <aWJUm-hrPquegbdf@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWJUm-hrPquegbdf@ArchLinux>

On Sat, Jan 10, 2026 at 09:31:07PM +0800, shejialuo wrote:
> On Fri, Jan 09, 2026 at 01:39:45PM +0100, Patrick Steinhardt wrote:
> > diff --git a/refs.c b/refs.c
> > index c3528862c6..a772d371cd 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -334,8 +334,18 @@ int refs_fsck_ref(struct ref_store *refs UNUSED, struct fsck_options *o,
> >  
> >  int refs_fsck_symref(struct ref_store *refs UNUSED, struct fsck_options *o,
> >  		     struct fsck_ref_report *report,
> > -		     const char *refname UNUSED, const char *target)
> > +		     const char *refname, const char *target)
> >  {
> > +	const char *stripped_refname;
> > +
> > +	parse_worktree_ref(refname, NULL, NULL, &stripped_refname);
> > +
> > +	if (!strcmp(stripped_refname, "HEAD") &&
> > +	    !starts_with(target, "refs/heads/") &&
> 
> We would first check whether the current ref is `HEAD`. And I am
> wondering whether we have some common APIs. And I find the similar logic
> in `reglog.c::is_head` like the following shows:
> 
>     static int is_head(const char *refname)
>     {
>             const char *stripped_refname;
>             parse_worktree_ref(refname, NULL, NULL, &stripped_refname);
>             return !strcmp(stripped_refname, "HEAD");
>     }
> 
> I think we might just extract this common logic to avoid introducing
> repetition.

Hm. We could, but I'm a tiny bit worried about just calling it
`is_head()`. It might be surprising to some callers that there isn't
only one "HEAD", but that this would also recognize worktree HEADs. If
somebody just goes like "I wanna know whether I've got HEAD" they might
not think about that at all.

So given that the complexity is comparatively low I'd prefer to keep
this as-is for now. On the other hand, if you've got some proposal for
how to make this interface not confusing I'm very open to that :)

Thanks!

Patrick
