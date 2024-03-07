Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC64812BF3C
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709816327; cv=none; b=MQUb9YEUM6LYegw9tnt/MdUxV3wvUi3y3DYR+0N0SS1gHCkzrfSZ1xSXs86r5FfCIetHCr5MpXSVhzNs6ZQT3Dejc3Qd1Yx6hkbdgU14ZZxRgzWt5OhfF96zqjvLuUO7C/FzlVgstwM38e+JX/MULAZgAiHOIVMtFpRAeesw1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709816327; c=relaxed/simple;
	bh=5U/1PhGD8KSe9ZzdrnD371JOPYfHbWQs+08qgixqSXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ja2JMRoK+MnI6BJ0X4zlvv7sOsoyAI+SMrRXi0C0wfiX8VZqC1ME2XzBEDusk74/nULooMjDRu4/fJANuVipjUhemXvDnmWEYJ/K274WMi2/yiSHCXdkslK1LsAkP0YBpUjEHE15JBr899EKTRJYE3xgX0C5k1rvrQAVgVsQOsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q+xk7SRp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KyCySRxj; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q+xk7SRp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KyCySRxj"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 53C5A1C000AC;
	Thu,  7 Mar 2024 07:58:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 07 Mar 2024 07:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709816322; x=1709902722; bh=Fm7aOQAfMR
	vs7UDPTJiRq+7wf2i7GtwfZUDayn1o35A=; b=q+xk7SRpvfFRcCzr3rPBRmV9pZ
	ibqKLbq1HVYiIjRPB/Ps7yKrmJXzLEnKg509eFd0x8PD/kMAz7u712vAoVuDRERh
	8Jgy8gvdiP+9esKza+LeS1MD89SX+weUNi88dhLAzd/fFt4fh/2pXQIyVpMQGwUq
	luiVY+1SCNglMdiCn1TeJTydew8wHILZOCZSYbj/HSm/VaagF5lH2yW4UOFWNrbh
	wqXLV4nb709bEjNg02GYX6SP3SEdmS9zFb/x6AuksvHNIlYfGKUgwqv4qJVcLU/K
	8PGKUplS04fAJSg8hb+gc6EV/lpT6PLDcwbE/pYOzDQQc1lrF6GEtQywPxDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709816322; x=1709902722; bh=Fm7aOQAfMRvs7UDPTJiRq+7wf2i7
	GtwfZUDayn1o35A=; b=KyCySRxjQEW8xG4um1FYC0NElOq8QgNFrQRWE8lCBSXv
	6i33vnrrqI9WUtS0kW8eH2h5R7A+kzk+jVZ7b53kiuCbIwFQfmpY9Vl66/pL9/U7
	gzeuhPCHZkS8N/86l4okLYXEE3MXi8fQ38txKViCeM58kPpAaR9KRHe5l2wN7Y0Z
	eeI834W9Oo2gOt6S27gvCDAl57k+6Z/GVvVarToAOzAPzAxbeGf84VYHiFgJopnI
	3fADb6tru/SuV3UT0w5VVx3VMGz6NehJCcr88PYd834YG2nJgG3f9lvjttMaMCix
	g28FqqFFgOC8CYHPKtYyF3mdsTP50/cbc5RDIHWujQ==
X-ME-Sender: <xms:ArrpZTIA6GtfHcH1Bf7QA6oTko1JYc2vllvewM6BUZ_NpOaC0duGyg>
    <xme:ArrpZXIdAzR5Q_D3QhFiSb5EBjjDBQq3xof9ivkiHxmKs00_fWcKJnaAcYuxRmJYY
    N_E3hfq6MU52c90lA>
X-ME-Received: <xmr:ArrpZbtNQOrhBB309I67gZ8Bn1AzApAnmsiij02rbW39hjxnREEJrP73F3N9627GcnezLvyFQ3v8fXvYm5VYFUPBCm2yXxpd08EKzFqEyfieTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:ArrpZcaGfpprmiCUay8dj9_ntsJZP9Kf4VU2n3RulKLmiQKR-6w2PQ>
    <xmx:ArrpZaYKwaOxkVK5p44FVkKy6C-V3HjcqYDsBbrJbiWkudFMEevtHA>
    <xmx:ArrpZQBJsW6UYFE_Vb7WTMjgOA_6gYqHz-A2m_5cXOYqp-_xiBXlfw>
    <xmx:ArrpZZmGSGI0Gjok7Ocs9v7l8Er-u6iTKZvIaV05-6JSfmb0MlM91-i9W_A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 07:58:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3e8b1cda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Mar 2024 12:54:08 +0000 (UTC)
Date: Thu, 7 Mar 2024 13:58:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] reftable/stack: register compacted tables as
 tempfiles
Message-ID: <Zem5_Z171kzCkRK5@tanuki>
References: <cover.1709549619.git.ps@pks.im>
 <b952d54a05e1c0cf47371f78e3901cfb2119e246.1709549619.git.ps@pks.im>
 <87sf12fc7z.fsf@to1.studio>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+w8xIONdy2wxAKah"
Content-Disposition: inline
In-Reply-To: <87sf12fc7z.fsf@to1.studio>


--+w8xIONdy2wxAKah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 01:38:56PM +0100, Toon claes wrote:
> > diff --git a/reftable/stack.c b/reftable/stack.c
> > index 977336b7d5..40129da16c 100644
> > --- a/reftable/stack.c
> > +++ b/reftable/stack.c
> > @@ -827,51 +827,57 @@ uint64_t reftable_stack_next_update_index(struct =
reftable_stack *st)
> > =20
> >  static int stack_compact_locked(struct reftable_stack *st,
> >  				size_t first, size_t last,
> > -				struct strbuf *temp_tab,
> > -				struct reftable_log_expiry_config *config)
> > +				struct reftable_log_expiry_config *config,
> > +				struct tempfile **temp_table_out)
> >  {
> >  	struct strbuf next_name =3D STRBUF_INIT;
> > -	int tab_fd =3D -1;
> > +	struct strbuf table_path =3D STRBUF_INIT;
> >  	struct reftable_writer *wr =3D NULL;
> > +	struct tempfile *temp_table;
> > +	int temp_table_fd;
>=20
> Just one small nit, if you don't mind? In PATCH 2/4 you use
> `struct tempfile *tab_file` and `int tab_fd`. I would like to see
> consistency and use similar names. Personally I don't like table being
> shortened to "tab", and I think you feel the same as you've renamed the
> parameter from this function.

Yeah, I'm always a proponent of descriptive, unabbreviated names and
would thus rather want to use "temp_table" or something like that. But
in 2/4 I decided to stick with "tab_file" because there is a bunch of
already existing variables in that function which are called similar --
"temp_tab_file_name", "tab_file_name" and "tab_fd". But renaming all of
them to ensure function-level consistency would create a lot of churn.

I'll thus instead rename variables over here to their abbreviated
versions.

Patrick

--+w8xIONdy2wxAKah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXpufwACgkQVbJhu7ck
PpTq0g//VpodCcU2gtkpVJEtSGEQjISxKhOGIRzbot9ZWVCgmE5h5OnlKCz087W8
eSBsrN7tXfFeNN710jEXgRPUMgOG+Ru4Bs8Xe783FenefS93PavIkTh3YgaasG75
WiD3W0btpdI+UMxXvRQPZEuwXw8NQjjGz/kgZw+BBitzjUoZwtltzyVl9/OoihLW
76c/4bjUMvyUvG0cDaPfuwX/wxJMpdNBGPR8NQ46yWtXMeFN9U8zRoM7j7ZREj7s
2kLQ2V732yZI+Zg6kd/Wzv88LZuBgWiyW1DE69wBGNPXit+SSf9tzG+g7/mtmMtb
Oy4rLo6IxsgPLjkQRdUDNpSLMtNH0CHcOJPIt4iX/jlERVZ7c0aFXAJ6BRODKHkj
CC5rGvkTa+9+EYJxIq1BZyXnzthzHFInLfZlbURxwfTSgkVNOHVZLeQvXfXmMFb1
xDRzWNiaWXh1yt6bz0fHJupgxIzbhmQ3p+T+VqW3mZMcASmCyjAleLDOG+yg0d41
N0SOry6JQE3St++b25O9PVqtsB9w+UqYDABRBH7V9tBg2Zx/tVvfBu31JCzWaOFu
0hWRk9PBO89XxywlWxQQTc6EO3YZIlIO6K/hTqzBYG8fHftwifOfOCdD+hICxLj5
/Qm4pouBr/+z4jzAe+RLsj7pMCBITwpTSk7GErc8YeGp2b766FM=
=OIE+
-----END PGP SIGNATURE-----

--+w8xIONdy2wxAKah--
