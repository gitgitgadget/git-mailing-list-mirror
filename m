Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EC03B182
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920678; cv=none; b=N44UItZcxh3XSVZlnky2mJvlP/krwHaRqL6hB7TG4BRCj5VJLOypl8TlgCOfq3ML0f1wxH0XpOxGAlsLvNg3mj5Xm0nA7ve2AFyz+4+OA/BpEKXYgSptOfGNKl3d1CG+XE5pDdhBldksJAuC13gWH3p4A9TUHrIwdtBojHHPjU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920678; c=relaxed/simple;
	bh=Or9Y9bW0bog+rH+/nI10aMNnsr3zMsNmEZLKoL7gQ+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUaEMvUprwRpqFYYg3Zeg6O0A4SCV5yprl0VgAXPapsHHr5wkpnSyOVRkjIIpTPAl4pNtWnIbPDqpL9X63we1XmWtzQGWB8PzSmTxRzWUnSpnVCR5CmueN0zPGVmEGoqRoxAu9EcNmgcOVXsPkTTbX8VH2cHaKlTL2OuJPLmqBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DGrPGmjF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bvdTpwNO; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DGrPGmjF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bvdTpwNO"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 3012F3200A54;
	Mon, 22 Jan 2024 05:51:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 22 Jan 2024 05:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705920675; x=1706007075; bh=UYNP0dg2J0
	ixdaOM2c/UqRoQMuzrdTjyiMFME3EvAw4=; b=DGrPGmjFBwSFidfLFLpd5B2oXs
	VSsNCNk8RQgAnQd5aDr2rKl9SqDaLKiXl+bxlCAllKVbMcd8TuVS3Gnnud1lGPKD
	uOv+ZgNLxJp+H76NCOCifGe0rknO6q80RfkYTdoUUz8F8vLHn8tbUrlG9gCXTfSv
	XgL67fz7MfVMi5bbTUuKDtuSK6iBDDOpePmXwT1wZrQdpZ1XsPBH5fAjCjZp0l6r
	gVL35DAxdDEKk6kSiatVTuqPKqsTIq2qnSxZGzKSHTzkOm4NG13MSD9kOamCdlIG
	cr+YonnawNR2KTOXClekzJ4R2HavaUIWh5f3IQzJ5rcO5aJNKSFhUIQt6SLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705920675; x=1706007075; bh=UYNP0dg2J0ixdaOM2c/UqRoQMuzr
	dTjyiMFME3EvAw4=; b=bvdTpwNO6Er6v7v9wEaPxYm60bfW6fbUcyzZqgLLsVMq
	QMt9jlBVM+CNslZRHw4SjeylqM6DPyqREwRmgk4wDNeLintk0Gvd/Ntpywa5GeUs
	Evcl/ScjNjnnbascHXCqnh6i8l7L/pJtYTjTSPlVcvTvm34syZfR0SH/ERTzk/q5
	cLm7qu6ejD8Dg1MCjILml6/62bc0b/Duj/IdBU4W379T8mFx7UCZcoRkgaupkg6m
	7sWsnmfA64Z1J9IZJkTP3rpBJTPAnGOi+ubtyL5tWERNkZ3GJzXNi1QQjtohp7IY
	hv4aj/YyR9xiwvC+gpKDUEOaEldE4XSnQqKtPX39mA==
X-ME-Sender: <xms:o0iuZYjfMMDileRgSJX3Kl0oWY1p7Z0Km10mWmyceQRDyZ8IryctOA>
    <xme:o0iuZRB5-QY-xhIh0jDbK40zBZbxBi5SMq2Z0-04SyFq773UT93WD-ukNFGElu2N4
    XuwjODwtIwszusQeA>
X-ME-Received: <xmr:o0iuZQFEHY0CFl09wUbbD-BqKI_J7N6ne4_REC6d2V2z2L0E21A0zc1DAHR6ClwK-ByCntejISMQ9Sffu0cFKtB49mA-b1wR9ll1APoHGFCqwME>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:o0iuZZRGXjQojigAw3q0zWSCU1z78JEGtnYYpT7MQiRFOfiZPDlW3Q>
    <xmx:o0iuZVzJQKRi3P-sWj2G2FWtwTx2iYPWBIZdRlT9ErrgjkDpCXhX3g>
    <xmx:o0iuZX4ANQ7oPFgB1oWchb-ZnqPsRrVoP36MhVmmmyemGtklrTrWqQ>
    <xmx:o0iuZTaAdPlaSwC7k-vE_3CO5OZGfa3qfjGM2PnNk26_1Bb0UODBGA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 05:51:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d16a7b1f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jan 2024 10:48:11 +0000 (UTC)
Date: Mon, 22 Jan 2024 11:51:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/7] sequencer: introduce functions to handle autostashes
 via refs
Message-ID: <Za5IoEjs0q7cf354@tanuki>
References: <cover.1705659748.git.ps@pks.im>
 <abcf1f5cf428072d19639dc4209e0c1554f3eb53.1705659748.git.ps@pks.im>
 <xmqqbk9hjdai.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O3yKeh2Sfa2LN2rP"
Content-Disposition: inline
In-Reply-To: <xmqqbk9hjdai.fsf@gitster.g>


--O3yKeh2Sfa2LN2rP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 12:09:25PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > We're about to convert the MERGE_AUTOSTASH ref to become non-special,
> > using the refs API instead of direct filesystem access to both read and
> > write the ref. The current interfaces to write autostashes is entirely
> > path-based though, so we need to extend them to also support writes via
> > the refs API instead.
> >
> > Ideally, we would be able to fully replace the old set of path-based
> > interfaces. But the sequencer will continue to write state into
> > "rebase-merge/autostash". This path is not considered to be a ref at all
> > and will thus stay is-is for now, which requires us to keep both path-
>=20
> "is-is"???

Oops, "as-is" :)

> > and refs-based interfaces to handle autostashes.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  sequencer.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++----
> >  sequencer.h |  3 +++
> >  2 files changed, 64 insertions(+), 5 deletions(-)
>=20
> The conversion (rather, the introduction to allow refs API to be
> used to access them) look correct, but offhand I do not know what
> the implication of leaving the file based interface would be.

We have said in past discussions that the sequencer state should remain
self contained, and that requires us to keep the files-based interface.
Refactoring it would likely be a larger undertaking, as we have also
said that refs must either have pseudo-ref syntax or start with "refs/".

The sequencer with its "rebase-merge/autostash" files doesn't conform to
either of those requirements, so we would also have to rename those
reflike files. I doubt that this is really worth it, so I would keep
those around as internal implementation details of how the sequencer
works. These refs are not supposed to be accessed by the user in the
first place, and we do not document their existence to the best of my
knowledge. Also, `git rev-parse rebase-merge/autostash` would fail.

So overall I think it's fine to leave this internal sequencer state as
self-contained as it is.

Patrick

--O3yKeh2Sfa2LN2rP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWuSJ8ACgkQVbJhu7ck
PpTMrg//WpChi9TIPM3TebNN5jNanB12elQKifsyDbYPTWvvlqaGITXGDoRIeTpd
k5b0YesvDPtr8fkL/S/kQnuyatdj9FqTQ1qcvEVmM7Onzf+gAh4nLsFRhbUb91xi
gIeDDvrbfXfgTVduESJ1Ynmqy4Hf91xN10DQoJ+KNvyWvujjjTadKAKhc5GOFsm3
oLA3XFDHJuJXRK5g0BMhbAlvbH1ZX7rEHym8uhx1zSM6GL1/4d4eTujdKQZGwJDQ
ITSiVTKbmZ0uPUkBW6WpDto3IE/OurFgiQOwY+8H3r5erlmk/G0B3BY6djPO+cJX
7GQKZh15PPorp1FDEW8pFo7x8GJNJ4frl3Tm3O7KWUNTVKke1qzRj2INULc/ootT
qQpfiKvmTED40uR0hSzocnWrnjIqWaO6CyISpHLDIUq+Vs3JV1YAHHsg8iJBHNuM
e24esd8nZZvSDVxaAKcILPDTwCzFHNcUh2a63BUrWgfeuqqGebtftqdY251AHGvU
2UabVRQHBIJ+scHajw1zSOnvD+oju6AhUeTIlPlRwRcrccIZgX8PNeLhLPBDbdTZ
yfsNpHeCffUrvoORBwPeVWanVOL/LvurgDjk1MLAnH0FKkpYt7odbYPjKSD9iLaZ
w2IBnZgUv9uuD8Q6sYkpxKrtJ6nvLbuMRA10CNOFrIR+2kmQCoE=
=oceF
-----END PGP SIGNATURE-----

--O3yKeh2Sfa2LN2rP--
