Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6795316F8EB
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504732; cv=none; b=s5l+bUJGiT9oISE9l8plSx03Wxwnp+GwKPs6fakiiStrePRLYf7SnIClUTcnUofM09KiHBUlRHxqip19Apnsyn2BtLTj2T6Bj/EEgfwrNV4hrT9Nw+jJlTtgZ64kJK22rNAhWemqexF+BmNfiOjLhH1NtdKKNePsDicHdVQwySQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504732; c=relaxed/simple;
	bh=jBpDga6LOxVnOaj//a/BzicqaOF26BToT4uzzE4M6KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQ2yhLk067IxbObgcI0iblKCK9V/OKSBtr+2TJltr8Nz97Y2x1e4JBb871QqsZgkpZRjIWT5qnpKDcoURkDAQV05hRBMQ9vQdfkyOA5aQFngqlbyu3Nw3Y8r+2Hhv6npZR44ADLXj43sr81yuoF8zFb/2yU7ZHmkgvu9nI10QtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E+9qUMTL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nGNVX1Ri; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E+9qUMTL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nGNVX1Ri"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8CDED1387A85;
	Thu,  1 Aug 2024 05:32:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 01 Aug 2024 05:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722504728; x=1722591128; bh=jBpDga6LOx
	VnOaj//a/BzicqaOF26BToT4uzzE4M6KY=; b=E+9qUMTLk7dCFSQRRtI+OZxyFk
	HvXNLRDuK9AzBcRGL7QygVfZJZEv72ShuBkooQinOXODUn9e+9InGhTJnF66qiJ5
	4bchar2RJgRbhu34WDjZArPpsLh0FftlAW/018gKBHG9CVPwpdAHgQdBqj/V7tk9
	ZpSWyZqyo+i/uVvMWZezq0Huhq1lI9hohNhD8OmWwkB9Ny0FP0xbwqJNk1mZymeF
	hl28nffdE2gS/C+kbFstpUmyGOVvH0w/ZUEf0UiNOS1cDpPB2Lh2ElgibP786+T7
	wP/JMB3SDRANYR3MFwgL7c44Hh/y4g+AHZwpEup8WnUzAajIeDumDijZA/rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722504728; x=1722591128; bh=jBpDga6LOxVnOaj//a/BzicqaOF2
	6BToT4uzzE4M6KY=; b=nGNVX1Ri0vDOn1KwTuNZbsJNqt8IH3wW2j3xnZB/WFJ5
	m6qgcMpfHi59xqwkhV9iKerWsDOSPsz9bDQ+wxGrVd3pOWblWqCLNpSe98CoY1bf
	PJmohjnjkx3jMVas+eYpPYrkbKa9var0MdGd4T+oW76NOKfJhzLkr42mjv8/Tq9i
	JtIYtbUuKPT62rDoPPSyvunYb0ea89hyOXmxPR/F4PQxWBodTZYD1cQarLYiOp9C
	UReCkzXBtlBm3GgM1BI02eCWHrIBf2oDeKiBDnGCmt46hY6T06HLkdROlOwaQSL3
	Z5wImgeC75/2ZQmzcuthwLZXUdZpBeanOhNFiGe13w==
X-ME-Sender: <xms:GFarZmI55GBIRbpMry8xF49iquVafNeOUFi3AFJ02nvpKdm040sToQ>
    <xme:GFarZuKWCHfphjKQE10ye8Sp7Ux-bTOw_Blx32vfaz79q1rsiDpPO3SHQ2q5NHJpg
    w2CEQ_BLkd_gi96FQ>
X-ME-Received: <xmr:GFarZmui73E1l6aVajtDSiwuTbZtxfYVZl33pBi1Bc6fHOnbkCVJOdYKaFr15r2Zf7fBDaT4cE_WDfgYcTLPgxb0FA18oByJqOn-CSnFcHbrJME>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:GFarZra1e5gW7ozGZ9hcl_Cg4SxgpGiXYS8qUyIAgGnK41uG77XvbA>
    <xmx:GFarZtam-aV3xoSkrcx1kbeiBDOBQfxAii1Jr7JidWNWQ7sKQY5q1A>
    <xmx:GFarZnDpXtll-t55p84y8WrPmD5RN4cmtW_8b6HZdojiwXv3NJxdOw>
    <xmx:GFarZjaWAZnc4Sk8Yo2pCsAiB6bBx6vMDucITSW9cQsJxZ26hhlArQ>
    <xmx:GFarZiO7Os6GD4cLHxiVAWFG86mnLpqStezWEIsjWYF6ds4pj5zOL2iL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 05:32:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5337a1a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 09:30:35 +0000 (UTC)
Date: Thu, 1 Aug 2024 11:32:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 1/3] t: import the clar unit testing framework
Message-ID: <ZqtWFNSkzTBL0qrx@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <b3db953e88ece99b441993c9248223cc0ecc6be8.1722415748.git.ps@pks.im>
 <463oz7j4btei57brq42zlnsydguu74n2n22rhdq7iwjk4y2bei@6r32nghurrmr>
 <xmqqv80l1hgs.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d4XR8XoqQD9OS9hJ"
Content-Disposition: inline
In-Reply-To: <xmqqv80l1hgs.fsf@gitster.g>


--d4XR8XoqQD9OS9hJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 12:36:51PM -0700, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
>=20
> > On 2024.07.31 11:04, Patrick Steinhardt wrote:
> >> Import the clar unit testing framework at commit faa8419 (Merge pull
> >> request #93 from clar-test/ethomson/fixtures, 2023-12-14). The framewo=
rk
> >> will be wired up in subsequent commits.
> >
> > Rather than forking our own copy of clar, could we just add it as a
> > submodule instead?
>=20
> I doubt that forking was Patrick's intention to begin with.
> Convenience is.

Indeed. If we decide to adopt it I'd like to carry any required changes
upstream.

> It certainly is a possibility to bind it as a submodule, but it
> would be easier for everybody to futz with and experiment, at least
> while it is in its RFC phase.

I'm not too fond of using submodules, but I'm also not strictly against
using them. I'll do whatever works best for folks here and adapt
accordingly.

Patrick

--d4XR8XoqQD9OS9hJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarVhMACgkQVbJhu7ck
PpQPFQ/8CJ0hRo0bOjkozwzJ4pw/ft8nEECt+1j/rXXRO5umo9I/Tl2MBXO8tWBx
I9txFOCy2p1BggyAJ5sT72nEcHBm85QNdBbQxLgs/jcZ3GPG66M0A5ulFkOIN/Kv
THLZ727hL0eFsqwKHmObf6ota3hoAUWdJ42B1H49r+ioHePI3UWiaBemImxnBKi5
grZdaBbFEIKXOSt2vaJ9VEv3OcVt7EjBstTLX46ez6bmti8jsEDvlvWZEQ4G6f28
PM0XnlZcEdZdOjhwWIXnnw5Pf2EZRSKivX26JH0Lj5DDUx3GRqEYnCE2bq48GZfE
oIOyaId+fnK7D38oAFNO7dmxnvyfUbiarbvBXQ8W1WBJaxW2CaqKFI2tEssR3yt7
Th4QCvItPOrjLDhR7yM4JatoamZMTBqCNFkpLP85ExNMxt803D+t07Yd3qZmjMUH
7vY2SgHaR0Bk2DwyOymKm03vWLO6zwjm71y8IpuSfbKuWfZ7ALvenOhphG/DAVPX
ACpAty/rcVp6k6AHsfdMOZCqWfyeZ57qAHusjPB5qbo5AhPVUzMn+Dbo8e1mpmKi
DgQeWG68EAfWpLlDxbM819t5G0C1Dcc/qSSJ6w/mifleMXmEwxYIufcNXv2z5N/o
iiIcRnWByrQxzSLC9DUbSqopIhwqiGAWTxlpy+gPhmiyrrc41HM=
=OiDt
-----END PGP SIGNATURE-----

--d4XR8XoqQD9OS9hJ--
