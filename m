Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8CC198845
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328328; cv=none; b=kwoihbI+KKVmHJ6ShNGLq6LQ+K4l2VwqJYpEVv5rQG1pSeNcg3m5ESsSBmy5RrWKNek5Jp7an/YlrVyFEBDpRBC3H6NxvoJEGvqmvN9y0PCE7/5JPlBIhXkd/k86Fdd/rriQYkp4ddJhpF7Ib4gEmBMVflgUwXfWPFQbWihZbcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328328; c=relaxed/simple;
	bh=BP4KLwNSLNipWKzvGfSdvxGweByUO9/VgGTv2Ot5a7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip51fm5x1qQkKFE1e5/PHtvmDzy5Rp731KkJlYX34ueLXPGcEa7NsUKPzHMgjFNQT5k0yEslyED3wvkAnDQmA3XoXR68aFZYKbpPCHaS+rKELHCeaou56Y6mir4V7N+ZckgPqEZbgDLU57AwStCCcdqb3vbgshYz2GmkqpfvmwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cCBXokR3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T2KDlTKK; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cCBXokR3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T2KDlTKK"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id ECEDE1140521;
	Tue, 30 Jul 2024 04:32:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 30 Jul 2024 04:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722328324; x=1722414724; bh=NMYY6UDSgA
	MGrjOHCZNi5ebYgrcuSPE6uVaFTNbUuQg=; b=cCBXokR344/BSybCQWPyAVUAYH
	MfoDHwuTmWrkfKYgjEi1dyn4W9x44zr4SmuU21lEDsM9bEjeK63B5/g79bFPmwk1
	MTO+4VA4pBbP5Rm84Gv2F/m1Gi8f92kMR0DLq9za8GHkf3z0TuphGOxe5gzIBGcD
	L05iJmLqBQUcLredAyYSMLUNdP+k/P6bXsFRkKMVDJd3RDG40w0BD8koYktngAM0
	Xz61Ay3XzUCQg7AeAl1iyLOo4QXzkFNi0Jkr4FqukBUn72YaI070J9FbLbpEfBFT
	/UmM5vCg7eBqMPgUv23TrIs/1PhcHFhxTC4VSaQSXJ/o0qxBhnOlJjcB6Iig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722328324; x=1722414724; bh=NMYY6UDSgAMGrjOHCZNi5ebYgrcu
	SPE6uVaFTNbUuQg=; b=T2KDlTKKTP58iBhD/+l64pCLs+gUZIipsaCglJfkBdYN
	H91UJB8AZTznfYOV+PtwxqQmeBMzApydJoI9Ceh7ggOYtWKazjjucj3Ry0bux/9Y
	LSZGlwNP7uA+QXCiKo06LmD+o6D7nkXnTUEKuUGAwNw73QR3sMRes7BsBcC0zqfL
	7PdJzNlo5I0+fev5HI2NAQCiGihacEBw8eSTDYRnhxT7AZbzYohxjG/0uktDWVqE
	V0xtOfTN4/SAi59i1fxAF8v5srS74e57cASvJqtX+UW/8lPAE5x5JQOaWPmuhFku
	i03uR+Z57y0hexgavER+XrpeltRaFp58Npn761W+Fg==
X-ME-Sender: <xms:BKWoZgiW7BFjjeBl7lZcTIFiOGrtLbjZXLaGtmj7gRSmgNkYGZzPkQ>
    <xme:BKWoZpAt3bdRO4Er6UJLyN3ZahNbFc5h0r_ZfFqbj0fWQ0K5v_sPBKCuUXD0TgrPT
    Xrys77qNg1PIkepIQ>
X-ME-Received: <xmr:BKWoZoEePNiLIm6IrR5vD0e6mrNqZ2AgXq8LT90nKZ6Dic5TStEpuVfRPGD2XqcAV7JD_OduZcyV2o8h4pKPLzKM8eaY7vLY5PqJrFOCDzB4JXs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:BKWoZhRP0FZj2V_8Mvdr8wtNSn3Ri8zM27DBEkn1fulGZYPMTCi4Iw>
    <xmx:BKWoZtxncZjCVSK9yDhjU2pu09aCmxyRVsoaPT1SE6N5wjv6NsKKGg>
    <xmx:BKWoZv58T9MEHN9cRt1dSWGVul0KKpfNAAHoEJhnsAxRjT9dI9Bf1w>
    <xmx:BKWoZqz96VPV3oS4zgErxmqwg3s8FGWfrFCcVahybXlpMoQ_iuIjiQ>
    <xmx:BKWoZkmNSw1WUx_f2CA8gElUldyMv7cCUdSMq8EBtUf90DfqqffBA74z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 04:32:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5868bdca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 08:30:34 +0000 (UTC)
Date: Tue, 30 Jul 2024 10:31:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 00/10] ref consistency check infra setup
Message-ID: <Zqik_yal_hPTlotg@tanuki>
References: <ZpuCg1GL1YE_sJBP@ArchLinux>
 <ZqeXrPROpEg_pRS2@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="76E3ts60H0mFB92p"
Content-Disposition: inline
In-Reply-To: <ZqeXrPROpEg_pRS2@ArchLinux>


--76E3ts60H0mFB92p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 09:22:52PM +0800, shejialuo wrote:
> Hi All:
>=20
> This version mainly focuses on the problem about how should we provide
> extensibility for reporting the problem of refs. In patch v10, Junio
> asked a question here:
>=20
> > The error reporting function for refs consistency check was still
> > about reporting a problem for a single ref.  I am wondering how
> > consistency violations that are not about a single ref should be
> > handled.  For example, if refs/packed-backend.c:packed_fsck() finds
> > that the file is not sorted properly or has some unparseable garbage
> > in it, it is not something you can report as "refs/heads/main is
> > broken", but those who are interested in seeing the "reference
> > database consistency" verified, it is very much what they want the
> > tool to notice.  How would detection of such a breakage that is not
> > attributed to a single ref fit in this "ref consistency check
> > infrastructure" that was introduced by [05/10]?
>=20
> Actually, I think that the original parameter "checked_ref_name" is a
> bad name which makes the reader think that "we only handle refs". And
> this is my fault for this design. However, I misunderstood the Junio's
> word and made things complicated.
>=20
> The patch v11 and v12 wants to solve a problem that we should provide
> extensibility for reporting refs problem. However, these two versions
> still made things complicated. After an offline meeting with Patrick and
> Karthik, we design the following simple flat data structure:
>=20
>   struct fsck_refs_info {
>       const char *path;
>   };
>=20
> It is simple and provides extensibility.

I've got a bunch of comments, mostly because I've been out for quite a
while and thus didn't follow the progression of this series. But don't
let yourself be discouraged by the volume, I quite like the shape of
this patch series and think that it is very close to what we actually
want to have.

I'd say that this series is likely to become ready soonish.

Thanks!

Patrick

--76E3ts60H0mFB92p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaopP4ACgkQVbJhu7ck
PpRlcw//XolRaF6oRzixtQ6NCxoVHk7XkFk39sXvxZjKQILBMEqiklA1powP2BHm
yxf57XwlnIkPyVOe5T5xvRrfLhOG6eK7pe6cq4Eb8FTHCJM2zrJZoasgs7qRf1/y
SNq4kvHvSxv17v3pBsWu9cpvcO5vonmJKGFfPvRJh8B9VcBKeSHlTHHpyXiSLDyH
zT848J++c4E3hxIEBxLGbi4gcyhX6smFj//D29PtM7nO+ZVGHuGx1jl2i/xtZvqZ
5ZEEA2z+rJbiCNOJbOH5GSEfXcbURXd6pKrH7p8DASXM0L4kAykrDr5IUvehEQKR
I5we1MhjHGhauXBvOFrkJxinPYT6roJ1Pa2wz1GRxss0Hb2iNqa+5DzSy3zlHQIh
CCzkcr6OgMMWKQfnDj2mAIeCfGnKbxHMczNPzUcodpLfEPCzCkJz2Eh7mCmAinOd
ocJLFCZE+PG1EYLobkv30HYIEItDJzFRdDuFnWfUJhYi0XRXm2zxt6QqHDObui2T
dKbEJlO4PBrZATVgdblWmUtN+E4H+Eyo4mCuqyH/0CBT3Rt02fsH4Q8NpSk8MZZd
pziTZNb7+a7JP7xh7Op+veTQY1pDxNVge6vlNVjGa/bnnGpvUxQ9tcLDS7h93DAY
qcxBxl8DOpq8Qsp9KiEBkxh4M+4GmqyHXinwl+ME//TWplX0/bg=
=Zj0o
-----END PGP SIGNATURE-----

--76E3ts60H0mFB92p--
