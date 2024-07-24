Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35E5208D7
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721798384; cv=none; b=Z+FNkW7fm243/U5GllOfDZ7hEb/tMvxHfUirskaDdC5ECkyUhQA0essgrl5V2WNPf5qU8fya82b4m+WlP4qWfAlZUYmamAOJneSiKrLy7bN3JF7ELCmXZVNTNpXwb2ROgify4VXEYD/0JOn5j0u4JSj3T6VJ/Ys7jia6WMY67wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721798384; c=relaxed/simple;
	bh=yrolpht00tSGacWpIm6U1Arojanmu90JlzR1ws31yJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbxR1El7w0KaiyWT17t4t1XRLcM3EQMa7d6B0EiqTA0oA289kfg7uH0mVI09UiyIpL5m0+czWmqrcwiCAME9HxyRYIbg05wfQ6zypRERTEk6pQ++dGD9i6KxCSCvF3LAOl7uhWolkCcvGxH47JebGwb48sYY9XDQeH0xly/TuyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fttus5Y7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EkKhmYXo; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fttus5Y7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EkKhmYXo"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id BFBB2138080C;
	Wed, 24 Jul 2024 01:19:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 24 Jul 2024 01:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721798380; x=1721884780; bh=sTANbJuovZ
	zgvb928GeBvZI6KebfDnVg1tS+4+tNGn8=; b=Fttus5Y7zBZdL9gKPxcYXaPa0l
	919gs/yu4/uYS0GaMB+HUCo4o9xfqNuRcshVIYV0tEHrtIugzMBNB1ByrzyRFPsZ
	O+q1stcWohz2HhU5N3NDc1+LEmjMZido60f8bpCgHqGCyTRSCoZJnkbT3jJYhR/B
	gEH3pk2W6HJ4wbsOEmCAc2U4TGqyHjuFhRpx03cr6gbvXFKTcdqug/YphHKepnFw
	Wt/v+c0jCbwKDvuJ60NqvJYGeIYgQVPtXxOXTnI7KzAQfaS5XYKEwDzUQEtekOlA
	Yu5Zq/pDI/t52p/UQ0beyNLw0j+5G/kqLZ/tB23W4ymzdcZXLTL1ayMFxCrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721798380; x=1721884780; bh=sTANbJuovZzgvb928GeBvZI6Kebf
	DnVg1tS+4+tNGn8=; b=EkKhmYXozWh0mQjZoOhrwUlzwjqB2PpLekWSyYsfFgqw
	r677Q6GdwAhe/iqBLtBZp+okeNtbTECqLJEgBEhs1VYiTQzNeEJdcK92olR0j/H0
	Ak4+We1VHwiVRpYSMHi/JiEsBBSkWbCBrB1zv/FqovfvCF3wmLOhKFlRcnqItjSI
	BKrz3hqWu2WjGvjkkjE7NZMsqp5wmVi9ke0AJ+n8YMvnz5CnXUAXv+fDpiFGLdth
	NDG7MXxigWki7sPjr8B/+azzuxfNxEIgrg+8IiJzCNMVljkpezebzKuptGLLL2iv
	h+20cOE8IZ0O/4/lBE/jXT6VGenBHchYAX9CwiF2rQ==
X-ME-Sender: <xms:7I6gZhU7fo5B4QJs_wLWq1LRJhFcIVWc-NyTs-IDnIiJmqeYZOoEDQ>
    <xme:7I6gZhkiJgrenzhQ4StHGc3qxnUL-qOIiaLz3cOvl1NIvltqwLMclgN_heAPRQHAx
    tPKHUKaiP5XEONrmA>
X-ME-Received: <xmr:7I6gZtZSS6mNnKwBBDYRQtFFaw779NrvI9RVGJbjvBkIYZ9mvOeuaK3-WSDrhSZBkSq3eclu8gMC5YZlF5XMraWq9eTULJoc_gP5GNqmxAOQNNiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedtgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:7I6gZkX1qfedTxfYAgMj9oBbO1g_z59gWVnkbw9Rz9UyNgMAmK4E6Q>
    <xmx:7I6gZrkwmVPsJZFixYjExaWpEbQEnFamsT5t8jClaiQwiNzP6EltBw>
    <xmx:7I6gZheRchOEt3Fl_4TLpaU15I9JemOHYVGArGc-fg3OwV-mxNv7EA>
    <xmx:7I6gZlEC9FvRCNtYSkpNtNT2Mo3Ya9faNXGnncE2NTp__B68ssoeJQ>
    <xmx:7I6gZpaPdHtRkaY4qoBSB_5zjt33hkTElzA0OvkQQuEpdd2xcbrgDElY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 01:19:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7b123663 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 05:18:23 +0000 (UTC)
Date: Wed, 24 Jul 2024 07:19:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] t: migrate helper/test-urlmatch-normalization to
 unit tests
Message-ID: <ZqCO6JTQqdxD73Wq@tanuki>
References: <20240628125632.45603-1-shyamthakkar001@gmail.com>
 <Zp-3e6VV5bl8dWvR@tanuki>
 <D2XCB5UYIB5B.1L3U95DQSWJ2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p1LEvegEKVdJ4P7t"
Content-Disposition: inline
In-Reply-To: <D2XCB5UYIB5B.1L3U95DQSWJ2@gmail.com>


--p1LEvegEKVdJ4P7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 05:54:33AM +0530, Ghanshyam Thakkar wrote:
> Patrick Steinhardt <ps@pks.im> wrote:
> > On Fri, Jun 28, 2024 at 06:26:24PM +0530, Ghanshyam Thakkar wrote:
> > > +	free(url1_norm);
> > > +	free(url2_norm);
> > > +}
> > > +
> > > +static void check_normalized_url_from_file(const char *file, const c=
har *expect)
> > > +{
> > > +	struct strbuf content =3D STRBUF_INIT, path =3D STRBUF_INIT;
> > > +
> > > +	strbuf_getcwd(&path);
> > > +	strbuf_strip_suffix(&path, "/unit-tests/bin"); /* because 'unit-tes=
ts-test-tool' is run from 'bin' directory */
> >
> > Curious: is this a new requirement or do other tests have the same
> > requirement? I was under the impression that I could execude the
> > resulting unit test binaries from whatever directory I wanted to, but
> > didn't verify.
>=20
> I am not aware of any requirements, but if we want to interact with
> other files like in this case (and where we potentially have to
> interact with a test repository), we'd need to have some requirement
> to construct the path to these data files (and the test repository),
> similar to end-to-end tests where they can be run in only t/
> directory. Do you think calling `setup_git_directory()` and then using
> `the_repository->worktree` to get the root of the worktree of Git source
> and then construct the path relative to that, would be useful? That way
> we can atleast call the binaries from anywhere within the tree.

Instead of using the working directory, you can also use the `__FILE__`
preprocessor macro to access the files relative to the directory of the
original source file. That at least makes it possible to execute the
result from all directories, but still obviously ties us to the location
of the source directory.

Whether that's ultimately much better.. dunno. But I guess this should
at least be discussed in the commit message.

> (P.S. I know we want to avoid using `the_repository`, but I don't know
> any other way yet.)

You can use e.g. "t/helper/test-repository.c" as an example, where we
use `repo_init()` to initialize a local repository variable.

Patrick

--p1LEvegEKVdJ4P7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmagjucACgkQVbJhu7ck
PpRHSg/+Or8dbHv0vWWwjV8elyHEhSXr7/IcShSiyCykog8hEJHBA2gPe/biN4ZI
I/6T+lSszRpIu1Dv0dRxmhROeozmCU47+uZdMG+ENwbM81kw3KS5HfnXUpA4SPQg
GSJMq/HqD9WqML5/c+Lmwfk6GG73CLy1Afd7uADMsN+/pmn6oRLCQ16EdXuYm/pR
etdiTgqnbZY3Q/hx5RZFftyq+HPY7jtHoIpxbF6kwKldHdvYoxe031M+YEFjzNkr
VUSBTzz8rcRxksM3AlLmDsNiMYMo8UlBeuQhj2GFfLSh0xfNsYlQWNv+T+GSXgc4
/HmMHK2gGbFHcTIve4Wm+xgbUWL+lUV99MNNFW0VTdIjXLR/TN3814AGICFrrfFq
PQJHkcfcLAql4anTZEHlQV/eBclDpN0TPCXPaEhpP/Bw8UHGkEPhjIXRvPhrXfZV
HQFmCTNnkU5bU/JPel77wWmUuiDXMLOecOF9IkByw9wZ6UU8CFw89nyqdiozqcYx
dQc4WRI9rWkyTpYyBO1VhnUTkADpi5mmtStivwHxMTwGpIeU3uj3CVldnGD7X+iK
gji/o7cOiirC8Qi8pV4og/dap3P6aZl/YEpDpq16he/Sd2l1qt0FkHeAbALYR8L6
BF8YcChDEhNFzP3a2eDv5DSDoeF4z+4/QMJ8yh6Dyx4aJPeTLQs=
=z9VS
-----END PGP SIGNATURE-----

--p1LEvegEKVdJ4P7t--
