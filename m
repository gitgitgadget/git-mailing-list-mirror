Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50664170ED6
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357829; cv=none; b=UQXgD7ACmy+gvAYk93vM6kqOmxIs6hjetgVgCfio+1DteeL6Rd0x/KE+3m9WAqYCcTVJS5s7RBrNv0Ehg0b1tC6D3gmw9FUrJBOM0Z+FXcMvMUn7Zab2XPZDQKqwMXuJf3i8ryCQZI2Ol0htQczj0FKTDb8NDqz4XtGFVBrXaoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357829; c=relaxed/simple;
	bh=YzPXrN57CCnT14ct3hZ4zOjaZMl59KYObL5of6bnN9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8RPQRly1soqhO+F0lcFRggtD1p/nR2L1mv/NzKI0iEc9QQa7Iw2iEmI0NCYWjl3eOuMbjJr8WOmBchIPmy6xXPLyRcfCgXhctWXzqzQyn765oFE7jTTESbs6k2Vp8TNzepW+M9iy2kxsGu08pK0U4BG9x+nzI1Ln2YjKe81PWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WTSYJSQY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d8JUEBcu; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WTSYJSQY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d8JUEBcu"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 353455C0060;
	Mon, 25 Mar 2024 05:10:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 25 Mar 2024 05:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711357826; x=1711444226; bh=XWOvPFkzSi
	odUip/56te65D4xIDaiDl1S6UDs9Uk2Aw=; b=WTSYJSQYpkrn4JbMhDG9wCQ9Ef
	x/UFPy0F8H9yGeTDCrFvc4XIacnR3ptFC1Z+xZfOEfVdkHnRhIclKQ9IJ20SueLB
	ls9Fr5j/8Q3KMjop31DH6mKN4gxhyLZ1Nu9lVRPQTcJCtPJfpD0yE/UN9iIJImmg
	g55q9DTph1kN4ZOlRacNHIPRsklWDV7xTUSpqmOo+srY8xxP83CmKSIhbXAeUOka
	2iBp9ekDpE2v5Hqsy53zLXqrzU8UXlkzRzhOOWfz+tqn4tL7lV148WNSIYAb7Wcw
	ycOhMYUUnsaYD5Vgyyn5qyL02JZ+MJnlZwH+MZeLPmoBXp6FwCWBpyF93b0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711357826; x=1711444226; bh=XWOvPFkzSiodUip/56te65D4xIDa
	iDl1S6UDs9Uk2Aw=; b=d8JUEBcup45PQBnKEMBaIQHZsfEKn6+tzh1hWEyoGJGT
	+U15hXmV6cJMWowzLl1MxFrqhM1NqOqktxbH8CR3J1F6rqtEtjx6NN/1qpxsFpA7
	dC0tgBIwaAuGEm9unMQbh2i9nbEJ3L+02OeHZ50UX2Y4vL9CuDn7vtBSj7EBYMXz
	arZZ0v3n8AqhwmfD/Ua2Iu+UTFS8+PQ8BSFsvh3/yScyZl7Ve/oI6wfFdqPol0aG
	/jtcLfjl1l0tnMH4s7XasbQrzJXmrN2kucDd3dmIwc7TUAnqaXPpLivNe/uG66cM
	sPeBtxcjOXTzjSjebskwYznkVp9V+1qbnqJAaFly/A==
X-ME-Sender: <xms:gj8BZoktOjwVo5s0MKHQsinA44MFg1ksxb4riwX0CrcsZBQPvIb4lQ>
    <xme:gj8BZn2V8Pl0Y2pI38c271rHqfpnTbe0oktHauV1VMZo6SyqqwvlFsHoKeNCgOc9d
    02JPg4HM_3-QybiVQ>
X-ME-Received: <xmr:gj8BZmpMWr6-RXCPvNteCbRAwUKtp-cqbm8JPm_G8q3S1hQmZdsyMNa1R2a7U-WaK4TGIbJSrzYOEfcLysEOo-qFGWZgu_0fM5Q0xUIVeNpBGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:gj8BZkkxtc9epXu5i-mBDr-HPW_x8V6wE1cSzn1EPK40SGjxdZpsHQ>
    <xmx:gj8BZm1W_TOBPt6qrn0XXBUVKZzC_vUgo-LTDRYsrAIqEgNrJKEthg>
    <xmx:gj8BZrtW5nHbwRQ1xAMJ1NJdccrv-1pO9i5nrX8USO5PCwmfYIMJXw>
    <xmx:gj8BZiWBAALgIhweBSf7Xjy5Wv5ZJqnGB9kLtB5Nctn_UUI8sqeFAg>
    <xmx:gj8BZry4PlKp0KURD3Kv0maL86p3UKNGj3xNVJgYuVFbXukUobXbGg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 05:10:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d0e6b5d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 09:10:13 +0000 (UTC)
Date: Mon, 25 Mar 2024 10:10:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 00/15] refs: introduce `--auto` to pack refs as needed
Message-ID: <ZgE_fJpufp463Bp7@tanuki>
References: <cover.1710706118.git.ps@pks.im>
 <CAOLa=ZTgJj=moQC2Ve40KzSinmNGFwTSx_RcKaiCEQArcg8NoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bWlIxu/wHwXFmcRG"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTgJj=moQC2Ve40KzSinmNGFwTSx_RcKaiCEQArcg8NoQ@mail.gmail.com>


--bWlIxu/wHwXFmcRG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 12:30:58PM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > The `PACK_REFS_AUTO` flag is exposed via a new `git pack-refs --auto`
> > flag. It is wired up in both `git gc --auto` and `git maintenance run
> > --auto`.
> >
>=20
> Wondering if this is also exposed as a config option.

It's not, no, and I don't quite think it would make sense. We don't
expose the current `git gc --auto` flag as config option, either. While
we have "gc.auto", it doesn't configure whether or not the `--auto` flag
is set, but rather configures the boundary at which objects would be
repacked.

In hindsight that config option is too narrowly focussed on objects
while pretending to be quite general. It would've been great if this was
called "gc.autoLooseObjectLimit" or something similar instead to not
cause confusion and to be more easily extendable in the future.

I can certainly see that we might eventually want to have ref backend
specific configuration here. For the "files" backend this could be be
the number of loose refs that are allowed to exist before repacking,
whereas for the "reftable" backend this could be the geometric factor.
But I'll leave that for a future series.

> > The series is structured as follows:
> >
> >     - Patches 1 - 5: Bugfixes and improvements for the reftable-specific
> >       compaction code. These are issues that I've found while working on
> >       this series.
> >
> >     - Patches 6 - 8: Refactorings to drop the `PACK_REFS_ALL` flag,
> >       which isn't actually used by the ref backends anymore and confused
> >       me multiple times.
> >
> >     - Patches 9 - 15: Handling of `PACK_REFS_ALL` in git-pack-refs(1),
> >       git-gc(1) and git-maintenance(1).
> >
>=20
> I'm assuming this means `PACK_REFS_AUTO` in the last sentence.

Ah, yes.

Patrick

--bWlIxu/wHwXFmcRG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBP3wACgkQVbJhu7ck
PpSH0g//alrKf55LnR5a/0838pw9QwoKyT9ejasHSiRPt7tfSXT/s7zQA6q9N21a
Gl8m+XvJqfET+VXyABH4mS4GSI4yt7nkqL2mCNE+AcO2ZJzjEYyUjrIvTeq4pWOz
JTMai75IjTXZ5TmiFyEGJXIQ5UnN2jeRuxzzofbvfpFc5B+YUW1aABLwqBnMmJPx
/zZ2u2bSEXDdud9AXqjkGECGJUCezvvjhgb+0uRAWEWMKaN79jq04/+xEI25w2/T
/k6Xx1NCPPASlqGKbYZAWkDT+3F54B3OgMjHmvBK80qB5Tx1UYBzcUlSHDaOe8Dm
e+wsJhRpBlFMbmRtAeqvzRuTMfBS4RN4yd7jRBD+I7l+zWkPxJUL56lGkStQAjwy
ID9K4FSWSt4XlmY2P+qxBvV9Ay+m75IdHR6goO74D/zDM1Gf/uFP6+zUSTIAyDpy
kZA4BuNAp5mOO/pFQEXyTJDj+r6APs3WAmnTjkRKYG0IxwTyO5UXDAFpdbD9ut3q
3174Adt/rI7MIxRKrmOOScqZQxW1A4Pjd9n6ZI63+O0cq4+O8rRisa815HA3nQpI
d8uf78EsM2DP4F6HPtdFWdDFOZ+9WJwiapT4DT+l7gRocCzDfv0tosYFm005KeT4
vHeVixefWSGbVBCAUjXwYoQytRokhIdcCRpjSh2311piAgtlQA0=
=ha2b
-----END PGP SIGNATURE-----

--bWlIxu/wHwXFmcRG--
