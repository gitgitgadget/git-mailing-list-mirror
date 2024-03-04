Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A0A11CB3
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709534663; cv=none; b=C3GPnNzx7mz2fFMrnprbcdt+0L911ho50MGv5Al973ppGbX3bshRp4vCKDiHHPHcvYBz+3UPTk7yty4GJqgRuu1XrAWneOBD8x+BjcKS5JQDrrkI/r1m6xfUiLUEkGOCBMLDcjpVH2+e0F76bxCbVtiRYw9ovgV1bgznCHL2Tj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709534663; c=relaxed/simple;
	bh=lvbr4zVYprtMxFsgRrhVh3P/182hqHZImgfCRnVElg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3o+v8KyaDoBuJewEDCbpL3Qiy0Ff6Dx22qEG+3XXfosJoLDdzDdZaglG1xihxlQrEtrGh24GnmFOgn2jWjHA64cTkmcxPsk3mu7I6xHCglHwPsZYAHPt0JdLk0wXxmq0IFYOGF4duFoci6SUb33awbHzKxn2ueuRtrmgHGDePc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hDe7PHkV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S3kF4afB; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hDe7PHkV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S3kF4afB"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 2962F1C000C1;
	Mon,  4 Mar 2024 01:44:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 04 Mar 2024 01:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709534660; x=1709621060; bh=KIRs8IgLt4
	N2xn693mRc2gZB0cLtBybNTWBDdmMjuy8=; b=hDe7PHkV+An4wui31DxCjie+zi
	pUTDCJLCI6ZUosNhVgNkPpB0rSYoTAaO/zLzpBwXFLRX6fDyUaiU0oxKYeiM1a3b
	4EN8dYJbh8clfdfQInXOCGOIa0zzKeKR4Bs/p8liWhLUv8vDilh/eiwgKUeXOxKg
	WPxzSlkEpo8oaXMnbIjLwgOpcjrRoppVdbbaEFrVPbsl0+VhhrvcWKAyjXDxX/a1
	K3pUwKVEhtlwq1gANu1jc0qV9G+OhJrxBYg7uhUNkU8BcVVrC285It1iPd0Eimns
	w4SoTf/mNW5rNND3910JV7ITsBVygRKV3umld+cJ2pql3pksNQJdH+1kCSxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709534660; x=1709621060; bh=KIRs8IgLt4N2xn693mRc2gZB0cLt
	BybNTWBDdmMjuy8=; b=S3kF4afBLpd8N5u9BOcuvbs73B0gOzgBdK5id3bGQoDj
	j2QWgZsyOuffr2hgb98VRFiaH5u6/aTHqD0l5oLgqgzUiNjJPZIUuLd6HPSfElWz
	tEv11gnhk2+ddmeGdNnbjDRrpqB811KC0xXqo72eq17I3XO3uovN3VJihaD5S7iN
	WhPxVUi8oAeZKHguE/K9Pt6/Z0NfwCxX/OVqFvSATT9epxTLdMU0gUAyxQy6xieV
	1QPaqZcBrrZxGWXCLOp7eNCY7aTXLylDg2nkfy+MCBUqkfsKDe4HCR2kgMAh1d4z
	R/3tz385hi0VOIta8LJfDhevi+3jSVYiO2rp+s7VHQ==
X-ME-Sender: <xms:xG3lZUwwyyh6bVlgC26tmec_u077ROqDwsc45W0IedheCV43y0dOFg>
    <xme:xG3lZYT07aFTFJTkkR8kHdhQydVHraacAr5-1wS7EWTjM0NQEYpdWRGpmfLiArasc
    Cwb8_41sjUENpQe3g>
X-ME-Received: <xmr:xG3lZWUMEJXlwtrOosqLvYxBLpgaa2sqrB8i0IjsMns-HsbdCOXIpGbPg7IKFfrTq8AwoWjrAaU_byrPZ_2zFYwKawK3Cm1OJUGim8JOKUHZsHs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:xG3lZShx9ypliqH7wfTzTZ0iKZGJtOwntgPN36-hnLnw8crSyTdTHw>
    <xmx:xG3lZWDiKNjyhovlrcsSpxggf3JRbkHkOaaexu9B0ctxpFQCSRMXwQ>
    <xmx:xG3lZTI_MTbXnkLGoECSaPCL_yc2kmZsCOA_92pnI4Oae5i8QvjoPg>
    <xmx:xG3lZROZe6isED736phHOsyagijBtgFODRDidFZorx4doC-E56g3t4O2iWQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 01:44:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 45119eb8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 06:39:55 +0000 (UTC)
Date: Mon, 4 Mar 2024 07:44:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 0/2] builtin/clone: allow remote helpers to detect repo
Message-ID: <ZeVtwjr9ovUa6-8z@tanuki>
References: <cover.1709041721.git.ps@pks.im>
 <xmqqcyshr5em.fsf@gitster.g>
 <xmqqh6htpp6k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gh5Jqhil0gCfMvpL"
Content-Disposition: inline
In-Reply-To: <xmqqh6htpp6k.fsf@gitster.g>


--gh5Jqhil0gCfMvpL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 01:33:55PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> Hi,
> >>
> >> this patch series addresses a regression reported by Mike in Git v2.44
> >> where remote helpers cannot access the Git repository anymore when
> >> running git-clone(1).
> >> ...
> >>  builtin/clone.c            | 46 ++++++++++++++++++++++++++++++++++++++
> >>  refs/reftable-backend.c    |  1 +
> >
> > Sorry, but this confuses me.  Was a regression really in v2.44.0,
> > where refs/reftable-backend.c did not even exist?  If so why does a
> > fix for it need to touch that file?
> >
> > Thanks.
>=20
> I guess [2/2] alone is the fix to be applied directly on top of v2.44.0
> and eventually be merged to 'maint' to become v2.44.1 release, while
> [1/2] is necessary to adjust reftable backend when such a fix is
> merged to more recent codebase that already has the reftable
> backend?

Yes, exactly! Sorry, should've explained this more thoroughly.

Patrick

--gh5Jqhil0gCfMvpL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlbcEACgkQVbJhu7ck
PpReARAAj5RNaOGHcq8gNjgxLnWaKTzfKDaVWdLYiQfFJhKg1aB9Q88naQaWHs/0
UGj8DXhAcAQtVDWkKJDz9A5YEFZoLlLWBQcyGpJ4ZAxwByzpCJvFBDAp9QCayaMm
N2R32S+T1eSqwOwVJDfyo8wiIh5pKuuewdCCOCqLVPoVPob7VWR4xsR5k79HgAX/
ZK1rwR+YsRTr3+M7o8paPbPzaLFOSvP77NC93Z/1DwFPrMX3oB6ECIHvhxTzZpxl
divK4rjOR0nWNKEn2CVnP1VQTm8ac7GvowviThuAcyYFSIxg2Q5ZM4wVwxl/G7S2
sCQqRfZaRUEk7a2LYtpLGNO0ZuDFh4zwiM6VGw/sctBzfvndrdE0IIF07y+nnulV
u7dnHXIo+/w1/ktc5a9uW70FitxYUTQ7WzU6Gnei69LB/1kZgum78u02dBpGTLAT
zqjp4k3TXL9Azxpfa3JCVunX2dVi36J+FAnL7f855/J/OOHR/b0MGCVEcNCLnF6V
1t4r6j5kxB4B+ErQgFkfHlISExtx/vX9pxB2BUAgN2Y3fqr7E1LkMqqN6aiZDdXU
kx2lACgYuIXSdc3mxEBZXFJqeEA62E9RzvHMTlksfwggh1xzbN4t+RaJdnwaIPy+
xldivlzXWRl76EY5+s1YcAm8eIo03B8j1muQUI9ofArPIxYsyL4=
=0Dhm
-----END PGP SIGNATURE-----

--gh5Jqhil0gCfMvpL--
