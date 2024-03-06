Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E5B7FBAF
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709726433; cv=none; b=cxMNyAWeNhdQ7XdwfB6D6yTTZxS5KBUmwFEkfFYtsBgKyUeRNgvSI7QXKQW/gaEPuM5Z9l17wnARm9O1ZvgFAOU4b4sHIb1ce42wPPNAbx6l92Ym0L2e3XlYHUB9p2h1mHNsOGMkJHKIx0rPJA0Ab071so+MpTfW8Y4p+IY9n4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709726433; c=relaxed/simple;
	bh=MKT62SMAxZ6162saF42WNZdPyOSzbCfjUS0FoXWuwtY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJOR2BksH74X/jeSuosxqx76xyKJY7INjSakhpRbBo2W2I/YrM9jvbPsBSAvl4ZSDTWrmM95g5eaQO1jqy7wKoawuFTD8bKKBeG/fB7mulWh/suPNBeTz8k2LsXxa7yw2gBs7rpL7LFG5Fiv61fspzK6NC4wbL0s6dwvh1hZWHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eDJI/EB/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UaPF8ARb; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eDJI/EB/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UaPF8ARb"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id E04C718000B3
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 07:00:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 06 Mar 2024 07:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709726430; x=1709812830; bh=1RAwVWYHsN
	LpJ65MZ7A6SQwaIFcIh6MPlYIn2YHcqQI=; b=eDJI/EB/tlsKuAf6utYHstYjBM
	yVyh7uLYSE/LaQH81cN8AOPy1Ap6jopJLunvGwXsQclZlhKpFnAITE3K5R/7qE7d
	rTjV6avpR4VikeVlSrwWOL9e87amOSMgoWy0qXlgXcQhSGJOaDh+P+BO1gaoNt1j
	dF7NvpYvs0U46jvriIAQjzJ0owonEShwXJBNpTR/EXeqgtYhDjq6QXEW1IAXN3bu
	OHYOABWkJnQIfHRhf781qWEWoq5wwbu8caC34AKkNAyAxFaSXTdBN3ltfdOFTojX
	c7+Abj289dXTpZkxE1CS/VsMoOQSHvpqySrSlKTkHLogPprW+/SxlPKSR1eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709726430; x=1709812830; bh=1RAwVWYHsNLpJ65MZ7A6SQwaIFcI
	h6MPlYIn2YHcqQI=; b=UaPF8ARbaFKolu3xKIUpofNyn62n/PElEosCjp0F/iCB
	fRYarB5X2RQHMyWid54h1XitPWjgGAKzFrGI3cPuH4VwUOYG5oUi9HMbA0Hfh4/r
	8NpGVgrJp4aqj0X05dCnq/xQjrYBw9kDoM157ITqpxwhs5LSzHEKPPX799d444Je
	zMrTX41VTPp6s2eYEOu+dSsaN4IwtdwFIdoj6H7mZT0nsaXb/75LB+Qedd/QtLFq
	XJJWHv9oCzdGPbp1Dx3vxf0sOcsc9C3JUx8mP1JCvUuVA2+d3UlkJnXAxDcv0tgr
	fzbkBb04wTPoKoYEepmrVbHTTuKqjXdd7nSTtGO6ZQ==
X-ME-Sender: <xms:3lroZajcz0nHKEQpHRSjB6Zka9q_zL8kLzHwFtFj-n9CkQWl8nkGwg>
    <xme:3lroZbD_lZDxonf8GpCdMCrZmsqkIaIz3jX7GOKRGVbqm8QxSLooKLsjDEP_TFI5Q
    -6KuqqkkcE6mf6A3w>
X-ME-Received: <xmr:3lroZSFWNqFNJ9C3sRdlBk7mqrmOCb0O-EtFv-GktLvyw_Xq6DFKCyv9MznQlAwOxqYe2qDM8ueNXX8miz7kaKW7IELs9ped8DVjJJMP3BCJGLAgvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:3lroZTS-077m0ZrdH3-4P_jDp9npSoWnl7y_VEAqmKWzdfbsI_WRbQ>
    <xmx:3lroZXx4PimxsQK4WEepk9r_D8cmdeXPv2LSRY5-XDNsItbob7BOLQ>
    <xmx:3lroZR5RD8tyDoqUOdDzQjZPJGdDnBEZaPY1uF_krQUmd2n0xHNzaA>
    <xmx:3lroZQrcSAGCYLJWmRQWj49B43VnX96QjbIHwYW8d4c5NV3gQR3d4YXt598>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Mar 2024 07:00:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d91f3984 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Mar 2024 11:56:00 +0000 (UTC)
Date: Wed, 6 Mar 2024 13:00:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 1/4] lockfile: report when rollback fails
Message-ID: <Zeha21vz6EJD8cnk@tanuki>
References: <cover.1709549619.git.ps@pks.im>
 <1acaa9ca1a53e3d8e875fed7ce961d0b5426688f.1709549619.git.ps@pks.im>
 <lyarkcrkcb7ww542lc6y7t534yxnpahvrwephottvcbhr5dkn2@wwd5wk5bzlw7>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+aKLwfj/uUTavPKj"
Content-Disposition: inline
In-Reply-To: <lyarkcrkcb7ww542lc6y7t534yxnpahvrwephottvcbhr5dkn2@wwd5wk5bzlw7>


--+aKLwfj/uUTavPKj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 04:09:07PM -0600, Justin Tobler wrote:
> On 24/03/04 12:10PM, Patrick Steinhardt wrote:
> > We do not report to the caller when rolling back a lockfile fails, which
> > will be needed by the reftable compaction logic in a subsequent commit.
> > It also cannot really report on all errors because the function calls
> > `delete_tempfile()`, which doesn't return an error either.
> >=20
> > Refactor the code so that both `delete_tempfile()` and
> > `rollback_lock_file()` return an error code.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  lockfile.h |  4 ++--
> >  tempfile.c | 21 +++++++++++++--------
> >  tempfile.h |  2 +-
> >  3 files changed, 16 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/lockfile.h b/lockfile.h
> > index 90af4e66b2..4ed570d3f7 100644
> > --- a/lockfile.h
> > +++ b/lockfile.h
> > @@ -323,9 +323,9 @@ static inline int commit_lock_file_to(struct lock_f=
ile *lk, const char *path)
> >   * for a `lock_file` object that has already been committed or rolled
> >   * back.
> >   */
> > -static inline void rollback_lock_file(struct lock_file *lk)
> > +static inline int rollback_lock_file(struct lock_file *lk)
> >  {
> > -	delete_tempfile(&lk->tempfile);
> > +	return delete_tempfile(&lk->tempfile);
> >  }
>=20
> question: For a lockfile that is already committed or rolled back, is
> the underlying tempfile still active? I'm trying to figure out if it
> possible for an error to be returned in this scenerio. If not, it might
> be nice to clarify in the comment above that, in addition to being a
> NOOP, no error is returned.

No, it's not. I thought that it being a no-op should be clear enough,
but on the other hand it doesn't hurt either to clarify even further.

I'll refrain from sending a v2 only to add this comment as there haven't
been any other things that need to be addressed yet.

Patrick

--+aKLwfj/uUTavPKj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoWtoACgkQVbJhu7ck
PpQyyA//c0NhpOJVJh+Wc02TAM8PlF64U6UATKj/r52qCUbm0KETmFzfBPBxgP/T
8Z+29MT8RULjoaVDh8GGxK5Pym+mb4vmSDYwGjV6yXHTat1xVw56p8Mg7GjX3+XD
MwAr1rx5UheRpoksLjG7AIidPalfcOiiJDU/swqlAncR4ydqfNhlt+U6ZzWtU3f7
I9uy7dXVpbpZQTVyRRqRQTQsQEgtwy6Zy2vk5SXy+7xY8aT+rha4ChPTsLNTCUi5
e0DtafdcvTI5Fj8wGWlMnHKZMP7yfM5Z6CXO1qOY5Ru1nqNSkV/CGdwBCYAeyemK
fjwBEonBbjOSV8E1zOCDG4Fk6ad4j9yOMc5Vuo7WdFAa3+r7CXWONTTscm9hVn0f
oXJjpIFL2bztDrm9AIToEzDVECY/6FRnJQO4N5rO9CzCxx1s7ASIO8oYlnV29Fi7
CgdtVCbSweO2GMk4nA6VyEUQMgdTMnaGH7dtUmL6C8+In7DdRERb4sTYiCnljW68
5M8f7BEC4pmWPNC1ymdBbH7Q3mEGA7w+lHmPPdhsMo8wgiltAmT3iPv+suniM6hM
MoKk6cDmeKJ6mifkqx37eg2Pq27FCwFVFqyPvlgy9DztO0l1AyKantv43shT4j3J
H3Ks1MTjbo+WmnxNT2r+IKv1qv2fFXPR9wT7pKQ15yHFLby1YvA=
=IGev
-----END PGP SIGNATURE-----

--+aKLwfj/uUTavPKj--
