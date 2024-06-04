Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242BF144D1E
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503324; cv=none; b=a8efB31s2XnoeOxM+2RY2fAfcs5UfepWRwvDsehv7ALixwXAJNPJmjz1o2IdQ81bqaZ+i+gqKN4BuT22IzvxkwkH9gI38qm8r8HdopjOeW63XiJ+OA+I4qcAFktaUxtSDcOwGlyayqzlzqpEdT/O/40zvhHPJMiyTPQN2jB3KCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503324; c=relaxed/simple;
	bh=Y9HGO/e+pHRhuUK7CSthIixkQCVLKohV9bdwIStlW/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JR4yNWsM0s2v1+oi7WcRjVqhYEE3DPAhQs7k2Y8ob8fYfyPbKpxjgZ/JA132iOGj3Ed6c0yDsOxyyLIk651m4ml5QDJdrG/Y3L5G1LFf1NYj3wMIwunS/FwxmsKx5iEhbn8dyFb/bFeTokNrI/AMMmlGTSLNiXKVhd/p402Om2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mjnWDcVR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xy1OvDsp; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mjnWDcVR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xy1OvDsp"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3F0B11380144;
	Tue,  4 Jun 2024 08:15:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 04 Jun 2024 08:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717503322; x=1717589722; bh=Y9HGO/e+pH
	RhuUK7CSthIixkQCVLKohV9bdwIStlW/o=; b=mjnWDcVR3bWWSxAWu3LsoYwf2b
	To2G1HmjEv3hSsUriIN+N7zkk13LnDLnU6m0LCVqy0OO54u0qFWwClb729YvTzX8
	zQ46bv5d/1iuJkSS/QziqmyY0zb4gJUj5MqgrPZhftjd8oR84RU5Wmepe2I0b+uD
	yu1XtU5g9+dxrUMU7T+L4Ly0o655U3b+MJkP+4SjkJOPT6pHhO0HdKO7Y7kc0Vgk
	aQ5MuQzFrQTvDAFkg4G+gRRWnwNE/+7llnviJDlXo+yH3YM00cMtkv51C17boM+a
	oS5u5rdIQBkqOyFJP33qQrPS/BUWlS6bh6qUFSGuVXMlLl85yoFmWOfPqbeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717503322; x=1717589722; bh=Y9HGO/e+pHRhuUK7CSthIixkQCVL
	KohV9bdwIStlW/o=; b=Xy1OvDspilHpyeQK00ImAReh00NJsLzmAOZhIvdzhheh
	DbBKLJE+d0gUsJddLjT2figJ06GjHZdgfzpSFXfqX/RVHqh+Ljnbg5krAPwSQClB
	ksPmcXVs06r2ieIQ1AELv/lQ29ecFN1bzQQELRFVSOCzk6DHdxGrWNmRc18lb1hd
	K18sIMQjKridY5gGlgDruCChVnc3ceIarqFRp7hvB3UOBIGihAjy1cOMHG3T3KpD
	AryUqjWPkBoiEemlcx7q9uqUyFLrAiWhYvcLVYP7u2zvldML7kFFGo3lLKNhfGio
	36Vl+u+LCNJaoJ7wzdxYHaB1NfQO1QtaSGqd/7/+EA==
X-ME-Sender: <xms:WgVfZucLYYP9AacByjJYCccn0hZRB3Q2wOCc8z_f6E2a5seZUapRow>
    <xme:WgVfZoO37bNBRmzKY2FhaS7TosIZeFcKY5GSTq9q91hPuWPAS_Vnt7oq-HJeIatfp
    YEceJxT7A7ybx5Xnw>
X-ME-Received: <xmr:WgVfZvgsO-16hUqBeSui-CHspAaCCWTLlgUqmJH0zmcWoQIoJs-LNfRGikXG4xaw0Apfyd6iRWiCRLAtwCcjSKhIviO6i4lSRzj1tJO_pJCPXBCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:WgVfZr9hHPYY3CgPa6k1hA4VJtGhB12xS40x34S5Gq4d_PKxzT9WNg>
    <xmx:WgVfZqv8PkSqexxe53EMx4Puu6EjOLUhMLF-ZbfdGGR5hHRO3hISeQ>
    <xmx:WgVfZiHTXV5iOT6BnR2gxZ5Olv5iD4RgcK2Nix043qojkwajoVx_Wg>
    <xmx:WgVfZpMcrCz8MtrySakRdWaj9jk1977iCwtS4FMpp4oqBQ3ux-f-pA>
    <xmx:WgVfZuIbp1jeXCofmrWBfYt4HLAqBMwJ8JnfptZ2DcM9boYF--JlCskl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:15:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id aa9a55ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:14:54 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:15:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/13] leak fixes for sparse-checkout code
Message-ID: <Zl8FVhWLuhruIovE@ncase>
References: <20240531112433.GA428583@coredump.intra.peff.net>
 <20240604100814.GA1304520@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZuS7E9iGdIHb9+Of"
Content-Disposition: inline
In-Reply-To: <20240604100814.GA1304520@coredump.intra.peff.net>


--ZuS7E9iGdIHb9+Of
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 06:08:14AM -0400, Jeff King wrote:
> On Fri, May 31, 2024 at 07:24:34AM -0400, Jeff King wrote:
>=20
> > So Patrick nerd-sniped me by asking if my earlier leakfix for git-mv was
> > triggered by the test suite. It was, in t7002, but that wasn't enough to
> > make the script leak-free. So I figured, how hard could it be to go all
> > the way?
> >=20
> > Well. It only took a few patches (1-5), but in the process I stumbled on
> > a rather tricky interface oddity of add_pattern(), which caused some
> > other leaks. The interface is fixed in patch 6, and the matching leak
> > goes away in patch 7. Of course, I wanted to make sure it was tested, so
> > after poking around I found that t1091 triggered it.
> >=20
> > But as you might guess, that didn't make t1091 leak-free. And I couldn't
> > bear leaving it on a cliffhanger like that, so patches 8-13 fix the rest
> > of the issues triggered by that script.
> >=20
> > And along the way we managed to make t1090 and t3602 leak-free, too
> > (actually in patch 2, but I didn't notice until the whole thing was
> > done).
> >=20
> > These should apply on top of jk/leakfixes, since the leak-freeness of
> > t7002 depends on the fix there.
>=20
> Here's a v2 with a few minor updates, based on review from Patrick. The
> restoration of "old_pl" in patch 9 is now done unconditionally (it
> doesn't matter in practice due to a bunch of subtle things, but it's the
> less surprising and more defensive choice). And a small style update in
> patch 13.

Thanks, the range-diff looks as expected.

Patrick

--ZuS7E9iGdIHb9+Of
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfBVUACgkQVbJhu7ck
PpRgHw/+PfO4uJIqbyJKes22SEk8ZcBHFAsjMDDAX7JwG9JrWplsSxrtgUdFgeJh
RW4WIo/qbYDANNBBq+kSE6yjC2wDy2KhPRofDCdKvW9br/D6IiJOfmDE0JkSjqHP
BoTkmlosIIHkZLHOmqDE9WVgKI+Wc1WSGW2nio6F8/ZSXXsRj36KLgYmluApKUEb
DaVcl8WjpVFvkW1bI7iIxwrcY4F/3UL2mJlMh5WxiDOTx35CZpg6GncKoJ0V4+66
Ybre/jRFqHsks7M7mVME6uEdviPXrfSMknVO1IvIujnlLgMdSk5Lt6DL2WIPWSaa
A/jj6Ay+pc78Equ1FBOES9WPzvPvrpYWGKDvrdPkPYEiEGm9voHtiHc8/I8hGaGy
Xqi6q/ZTkhQBSEkrQkq5F66lFIgzQxnTINmjuEV6mzuq8O/KIP7jJOumtHjA96mi
fbvpwCWehQODik7HJwuRMae6r+oxNfGMyaQGadlgFvufqEzujPCfSLmxhyPEfkvr
BW0KLB/z2FYxyMbXDDRdjU0Y5i/7NuQxcSHj9ClYHO09Oiwygnxy+E+9DLkqtS9f
YzfLxGCzzTHtqPHA0x2vLxHRE0C+rj7mVeTQ8OmiSauzx5LHUAV0aKdfM+xP5d6C
GsxHOVEMQzrSTnvLaAmiW+6SPYaXAbE/8ELVogjJHjMbHkdMoGU=
=NCsw
-----END PGP SIGNATURE-----

--ZuS7E9iGdIHb9+Of--
