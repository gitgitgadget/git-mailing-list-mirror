Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0EE2C190
	for <git@vger.kernel.org>; Thu,  2 May 2024 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637291; cv=none; b=Uc4DkHRSkQShhIomKLnT9TSksntfSEAovMj0nJy9Nb3RJ0oEDdCOYHw4Riw6zS1rMKPztP5BHSCf5Xg7KujiPzGEu+9wh7R6NSGCY2hS3PzwNgsQQD1EwcLhz8naja4f0h8ZwUXrfwA9K8nLmMQMRSdwu5mQzNCaIr9V2a5RV9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637291; c=relaxed/simple;
	bh=9v7AqlvQXU1zFR6PQt3yMChaWCrcjU6VGALiBBOcRZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqWA7E4v1CEzzsgChvf9IUyNmcYFbTaYo68lW4an6Z0J/jmhIaIOAogPuJARmsuVqWX6IBMv5Cm5fdAy1PbJJlmV3GjqvsjxdBg8pZVVHCv9DiGuGETFZ4ynkJpe35IlgE5hI1wxB+OIx6JiBPgjr8fmCBs1HekfTBrEH5Y7LM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VufNnAqt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L/1pPU2i; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VufNnAqt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L/1pPU2i"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 809A713805A7;
	Thu,  2 May 2024 04:08:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 02 May 2024 04:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714637288; x=1714723688; bh=/VZazOkeem
	9z0Xz/YwPcFhJRnut2xR5kasM7TiT2+9s=; b=VufNnAqtfiHQinyptYiRd0Bkz6
	fZS/Wsg7884VT23WxFeLqUV/c762kJB5Gy3Um14dFyi4yTff/Cd6qBoFPWAdZlXK
	JlDOTVBQAy9CIexmvsuhGMUXyzDTWuuu8ReoEURU387wkF1y2Y6kxF/EQb5THZ4T
	yu28qc7rmctsHsAnLIruQvO+DSpdjkChqqIhvg9t0sw0INSiFk4A34wqLUh9XsrX
	n8Sl/Eql5UgZvn9On9hB27xO8C5Zq8Abrb12dzAKxkPNxtn7WiqcE2wmSdbkmxYG
	x8IrmqFUYWKoeOe/oHjb1AEVUg+RWZFwSAC6T0iEf6A4dJh+S0EGzGUnxqcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714637288; x=1714723688; bh=/VZazOkeem9z0Xz/YwPcFhJRnut2
	xR5kasM7TiT2+9s=; b=L/1pPU2i9aunh3K4n+6Tt6KN6YCKHG5X5IS2XeN4FhP1
	5eYs++VZwpli7sPYmIPCQVaghyozpTfCkc0qqJGngqMeocs3Zf4SyHlHtKqY17OH
	aJbI+gmG1LAzsq2aqSbRwBr/PBRgk+k/GLgW4sSLtCR9FX/Dl0Q5cVdIffAKdzvX
	5PZ1n+MYWyoMA2hcohq/KnJlCx/rDDUBfrG1EsTV1c5lc0Wo4CzglumYsfrn5lDT
	adgefRiifxuwsnHehtfZHpUDgA8xkfXgH47J74XKe0nyScuceNAcafr2R6nsUc+J
	VN9AB9eD81jnqqB4CosKNuMPBC7bUh1S3f36uHuVpg==
X-ME-Sender: <xms:6EkzZi8Q-9KkgUzhJnwHJdGu99F3ZwI5PgxiEG09svdzuR_aJ5Gsjw>
    <xme:6EkzZis6ulqe3B9GSpQaFn6MYIAIbUpP4QwOArdrymTiprVU4tBz5BdCBUTieq7s5
    AKCL7tZjqD666f4nw>
X-ME-Received: <xmr:6EkzZoC-kdIqhY-64z7EZcYySzUdDek2IIG6Y-zK2NK98P4XNh_FKeUrNeV_W4lNVw_ByyhxyA73vDSa0uXLqqRnAB75g32DOAFQAPjYbRsQ8oY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:6EkzZqeIGHwL2MrP85OAFYadudKGTALnZZFrwDO2OASz50vL9_9vZA>
    <xmx:6EkzZnP9b-kCG1J5SPMojBnTYieS36lH17lgBA0Wq-ge6CpZrTXw0Q>
    <xmx:6EkzZknYTuMIwHREmDRT45XHeJIELnd9uUPFkl2p7TB5QJeiq7YOHw>
    <xmx:6EkzZps-zcKrX-E4seRS-nSqqA2FH2eRYBul04hwNX4GpCHuTqmBOQ>
    <xmx:6EkzZjDfmCjFCHR1w0LkRQlxWMw1I83HZu02HUCezpGTU6wcFk-w0s9w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 04:08:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 26c7bd65 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 08:07:41 +0000 (UTC)
Date: Thu, 2 May 2024 10:08:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 09/10] ref-filter: properly distinuish pseudo and root
 refs
Message-ID: <ZjNJ5EPMYxLi1QR0@tanuki>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714479928.git.ps@pks.im>
 <95d7547b2e8c5305e76888f7dc0a41d2b9e2f558.1714479928.git.ps@pks.im>
 <CAOLa=ZQY5rdUqcy0yTB0haduf9EK7KVLeoAYLyaST4fMn6UyFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uUO5UJWmdgj1bmos"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQY5rdUqcy0yTB0haduf9EK7KVLeoAYLyaST4fMn6UyFw@mail.gmail.com>


--uUO5UJWmdgj1bmos
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 06:11:05AM -0700, Karthik Nayak wrote:
> In the subject: s/distinuish/distinguish
>=20
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > The ref-filter interfaces currently define root refs as either a
> > detached HEAD or a pseudo ref. Pseudo refs aren't root refs though, so
> > let's properly distinguish those ref types.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/for-each-ref.c |  2 +-
> >  ref-filter.c           | 16 +++++++++-------
> >  ref-filter.h           |  4 ++--
> >  refs.c                 | 18 +-----------------
> >  refs.h                 | 18 ++++++++++++++++++
> >  5 files changed, 31 insertions(+), 27 deletions(-)
> >
> > diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> > index 919282e12a..5517a4a1c0 100644
> > --- a/builtin/for-each-ref.c
> > +++ b/builtin/for-each-ref.c
> > @@ -98,7 +98,7 @@ int cmd_for_each_ref(int argc, const char **argv, con=
st char *prefix)
> >  	}
> >
> >  	if (include_root_refs)
> > -		flags |=3D FILTER_REFS_ROOT_REFS;
> > +		flags |=3D FILTER_REFS_ROOT_REFS | FILTER_REFS_DETACHED_HEAD;
>=20
> The only issue I see with this patch is that it makes me think that HEAD
> is not a root ref anymore. I get that this is the best way to define the
> directives because otherwise you'd need a new flag something like
> `FILTER_REFS_ROOT_REFS_WITHOUT_HEAD` and `FILTER_REFS_ROOT_REFS` would
> be the summation of that and the HEAD flag.
>=20
> Apart from this, the patch looks good.

Well, it is a root ref, but we treat it differently in the ref-filter
interface because it's rendered differently than any other root ref.
Furthermore, the ref-filter interfaces allow you to _only_ list the HEAD
ref, which is another reason why it's singled out.

Renaming this to FILTER_REFS_ROOT_REFS_WITHOUT_HEAD ould be quite
misleading, too, because we have the following snippet:

@@ -2794,11 +2796,11 @@ static struct ref_array_item *apply_ref_filter(cons=
t char *refname, const struct
        /*
         * Generally HEAD refs are printed with special description denotin=
g a rebase,
         * detached state and so forth. This is useful when only printing t=
he HEAD ref
         * But when it is being printed along with other root refs, it make=
s sense to
         * keep the formatting consistent. So we mask the type to act like =
a root ref.
         */
        if (filter->kind & FILTER_REFS_ROOT_REFS && kind =3D=3D FILTER_REFS=
_DETACHED_HEAD)
                kind =3D FILTER_REFS_ROOT_REFS;
        else if (!(kind & filter->kind))
                return NULL;

If we named this FILTER_REFS_ROOT_REFS_WITHOUT_HEAD then the above code
would be even more surprising.

So yeah, it's a bit weird, but I think it's more sensible to retain the
code as proposed.

Patrick

--uUO5UJWmdgj1bmos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzSeMACgkQVbJhu7ck
PpTdxBAAgv5jGPexCn8C/e1ds8smgom4Ae3eh+ey/rjsyvG5GgsBd5oXYvUsfY2b
1DLL1cHzk8Z+83GfVoDOOZQJK+BIlIxoLOoUv24bI1iPqU/hDdkYbW9pQmpSbarp
KrfZmJnfDxQ7sgkuMl5pw+8AMisJwNzwD/d/c9SmyVsY2bN0vK4NoH+8p8BqgWP7
lqt0gPawnSI0ZSwKO34kiQDVCyJxkWLdg3iCmOUViOfgI9QE/pud9bBgNLVhkorC
7+Hgamdas8ojNQurt3UADFwDFbjNT8Bt7eMMURg8MZI2s14AHegny+6ePqN3HSeo
9tEdWPmk0hgnmrxMbjJdKlm4LRlDJV8tEkafAhfSDDMEQDl3m+1ehoVjInoZbzwU
Kw9Jb0RVRrzhymXJSRz4Zbdl1F/sKKcE47/H2u0qZPLLRD5lvwGzb7r0uFjndeE4
S9/vesuNDKbCeCf5JxvMIFTHpWstxdzqmKn207slbf4J2NPpxPbHINvlHnZW+E1e
8bUJFNmRj7AWTE6DBaapE3BTlm2ov57uri8yYI5D+huBJwxKFCEd5JRZg2U7Xo3r
YgBfu5PGt+bZS+crKUqohyDu4zomlH5WVr+57g8suDWQ8bWaNS7qde7b5dXGjVqH
CM5btPEezyvJggNh39itFxGfNI/OXHRulzXNE+4deZ/acvxoHFA=
=8CEF
-----END PGP SIGNATURE-----

--uUO5UJWmdgj1bmos--
