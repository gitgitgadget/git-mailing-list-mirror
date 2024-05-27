Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA4A10A01
	for <git@vger.kernel.org>; Mon, 27 May 2024 05:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716787160; cv=none; b=K+yjRaw7vqlRDOFkTePLoLWTksGhmggvFXAhN3jWAZWWzDBaj9Hb3Y6C3fgCEvY1udeRfyEkAkTd2PGb5addJ8mA0iHkGMlMWaokZZOB5F5acietc+AH3QsyPoJHxTYA7fCHB1kohPjmxFliPnnpoVj8B5HIjSvxRddIuxlrmSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716787160; c=relaxed/simple;
	bh=6mbWaLHpuQAAE4wa2/1Spx2snmMybwswoxl0bCWZ5wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mre+xvJCDbNvW9xg0ydhPrSo6LTigFUbl0utRfrJC6BN1CPKdYdKPYAY9gDhZsgyq4Jlcx8SPpS220KN6Weno+jebMVDx6kHeDCBAoEzfAcQlj5LPRpYqyhFXYyMwzLOewuYIU4eGMGUxvv8Ra7IFPn6QDCCZaozDLx7alV9isI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TIMayizG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R2ACzWvl; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TIMayizG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R2ACzWvl"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 1D8411C000A9;
	Mon, 27 May 2024 01:19:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 27 May 2024 01:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716787157; x=1716873557; bh=Iz7jblrtkx
	uBJdsDBqvq2Q3O6Q8hKpR8K5BeSjab0CE=; b=TIMayizGiZz8WWgPttVXSQeBzi
	BMK1+h8X1lpj8eVN5df6d+LZ0Pi5f7LFo74WPpdZFdTFxsDuhTCTPFxD71HytHlH
	BCqhA7Vpm6er6V82AnTSZUjVYH8wovZAD+13RhsenfHxMNnlWIWZLRK0nc4OcWkM
	bgJRkj2Tux9FuxH1O9f5DQy2hUkX15G9QHwX060lgELGd0h5NgGFOJEKqpJznYPB
	BYtYY4dA6GEfjlTY7GvmtGDo4O7OAjRCCzYaBk7MN37Pqbm5izbrg/N4lF5bHZIo
	+e0f7SgaFjKxwYm9hqL7MooCLJMeLlkMoPKhUlaOOq0SMiJzKW6rvRGaMTbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716787157; x=1716873557; bh=Iz7jblrtkxuBJdsDBqvq2Q3O6Q8h
	KpR8K5BeSjab0CE=; b=R2ACzWvlO4iDPiYR6TRw0mayAHXbDuV7W9ZFujGodiRr
	XVaj8uZZjmFy7ZH3FtSUD9IQx9JeWA1nvfDbpex1gEkvOwIVCdBiNJakWy2N65N8
	UieWuSXnTdyzplrOC1WOFzL9yG8SX+vtAycWA15wzDrFsoPII6vhlS+Hnmft06AP
	uye0Zqg874r1wN6yKjYLrjApZ++q8zHClafYoywLV16Ddd2RdNKP97NLrYryLqml
	ujn9pHhGsZJQycJLAgJ9Cyh0MRcz2MjkixVzPhBKI9IJoozGkiO5HPj0h4MhWKxF
	UkViW7AjXe8jfR/i6RoN1jHxZSBoh/pcmwZQcQLZUg==
X-ME-Sender: <xms:1RdUZtItknOBOUBJuUiyo3Qwj1xUhX0GQw1WixTWFlEA3cFqVXtsUA>
    <xme:1RdUZpJK9isGvqtdYhgTD2KplrIl5MLpgOdZWE-j6ZuGJ63hxBZUwhA3tJVc5ctHc
    YzKuzHDwpLrksi0pA>
X-ME-Received: <xmr:1RdUZltE1VBHlz0xr4f1K7oJeikiJYUPxIMuklvDuz8QdGFyHVCqHWegKbCUn8CsYXoh_syWB3Pc9HK-8cGFssB2U0F-MdornuraU9PFBT2-kmAFu1o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejfedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:1RdUZuZI_zhVhgJtnsGuNIvOxy8yoCqLZe-4cLvJgNwIkT4BxHL4VA>
    <xmx:1RdUZkZyfIQAv__srkWuFBA8eIsNIvDogYlaCU55LL96OJ8vBBUt9A>
    <xmx:1RdUZiAoFsWDrXa3e88-lBNv0LGxUIu5ra_7edQNyFvkgPjZKU_bJg>
    <xmx:1RdUZiZnmQK6KrQvIBcObiF1UzSzohX48xMnH2X4HEECWtGZDB3DwQ>
    <xmx:1RdUZjlC7RlOVUAyhpFEvIFI1J8nslkR_Gw7Jovd5Ax8YquX9b0jc3QF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 01:19:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6fa523bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 05:19:05 +0000 (UTC)
Date: Mon, 27 May 2024 07:19:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] format-patch: move range/inter diff at the end of a
 single patch output
Message-ID: <ZlQX0FmIsz2eFgsC@tanuki>
References: <20240523225007.2871766-1-gitster@pobox.com>
 <20240523225007.2871766-3-gitster@pobox.com>
 <ZlB2g5bTuBFz5m5_@tanuki>
 <xmqqo78ukhmk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dSNKthM8FjZGVz5X"
Content-Disposition: inline
In-Reply-To: <xmqqo78ukhmk.fsf@gitster.g>


--dSNKthM8FjZGVz5X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 02:46:43PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Thu, May 23, 2024 at 03:50:07PM -0700, Junio C Hamano wrote:
> > I also think that there's a bug here. The output from the above command
> > is:
> > ...
> >     --- a/blorp
> >     +++ b/blorp
> >     @@ -1 +1 @@
> >     -fnorp
> >     +fleep
> >     Interdiff against v1:
> >       diff --git a/blorp b/blorp
> > ...
> >
> > The diff is before the separator for the signature, and there is no
> > clear delimiter between the actual diff and the interdiff.
>=20
> Earlier Eric expressed concern about writing this out _after_ the
> mail signature mark "-- ", so the output deliberately goes before
> it.  There is no need for any marker after the last line of the
> patch.  "Interdiff against ..." is a clear enough delimiter.
>=20
> FWIW, the parsing of patches has always paid attention to the
> lengths recorded in @@ ... @@ hunk headers, and the parser notices
> where the run of ("diff --git a/... b/..." followed by a patch) ends
> and stops without problems.  On the other hand, if you remove the
> line "+fleep" in the above example and try to feed it to "git
> apply", it would correctly notice that it failed to see the expected
> one line of postimage and complains (because it sees "Interdiff
> against..."  when it expects to see a line that begins with a plus).
>=20
> So, I do not see any problem with the output from this cocde at all.
>=20
> Thanks for careful reading.

The machine can cope alright. But I think that it's way harder to parse
for a human if there is no clear visual delimiter between the diff and
the interdiff. And "Interdiff" isn't quite ideal in my opinion because
it is text, only, and may be quite easy to miss if it follows a long
diff.

The signature mark may not be ideal here as an indicator. Mail readers
may hide signatures, color them differently or other stuff. But I think
there should be some indicator here that visually highlights the fact
that one section is ending and another section is starting. This could
either be a newline, or the triple-dashes as we use in other places.

Patrick

--dSNKthM8FjZGVz5X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUF88ACgkQVbJhu7ck
PpSfIg/9GISHtYaBsnjuACYZFSw+hWsAbJYzpshaPqGxgfaf7WRxnWTbVf2JvWCS
FugtwNK3TXRLUy6htaDIrwmGKes/oDaDaPnUOIq6RcWdT/4IfcXTl92mfrjjLhTR
JPIrXAFdMmULwYxe6y1EfnHT7GkeLhcptobGwp00xSebSLrGRKOxF3sycTj/s6T3
wKel+NW3a8VBmT3kbtFBlwn5OykQgKJr4q99Z7ZGpmj4vN65fpdWWt8Fe7LCXe97
pNzvsuqPNveRt0F+TKOQPe86qntrSdF8tdHXWsiM98H7cRzgAc9qIhB+4Zadtif7
XNOkOatZHFNUNIgGu7FKt2NMVAJ5xLVystmPZz7dI0GVkqCWIt0BCcn9dDIYdtdO
CTwep967uGSNWlnTH0xJARuSLERB0ifMXrPVafDljwdJN2DkYXhMVHWaMSXHGH7K
T6oKszDSbKVnyRSsDYIE0N9MQko4BIQ/fB+2pwvJG/+kig/arMU5E8AiCEMfJ+aC
mfhWWnmRiA7quArJIQZ/7JFhLZsZgtGFWvXkzjUKOzJM4sjb8WcQAVAMegIpFm5B
poQNSqNL9FLuj1VHeWr/beH3ZUzVccVI0HTKS6TWWLJI9Byj2NS78AfYyYZcGemt
fDqse09byEEsR3vgMHJHy8Lfc0ykz9e73lAi78iVeTYAi7uRfyc=
=28wq
-----END PGP SIGNATURE-----

--dSNKthM8FjZGVz5X--
