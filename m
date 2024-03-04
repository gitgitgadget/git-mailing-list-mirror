Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C796119
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709534652; cv=none; b=WUqWmXBfnsO4C1TYLzeTJLeflffgOGgpTclVt+gtZFP61iFEaEFDQ74hBDBT9z/unmNnOMGc7DNZI0XQyKuJmg265huft0ahP+axYzeIeV0S++dwkbOVkUD/Xg/WyYokoSL3NLqBhyyiIJBwqK6vPgek/WnuYFQObEAIY69WCuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709534652; c=relaxed/simple;
	bh=S3zuugWWtkJS2ebTNB2ek8v9xlfXrPi4RQ6TdoMsJ+w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1aNiQnoPv35DglK5RiQIz5Se9BnYslHTvr7G/W8b4Eij9W9OQld6qW5x4RqqPpBLfdbWtyoq24wT7ePztzQ1pyC4zh0J7AjTIb7erd7GmUQKYB5ezuxwy8dwXSYybpWBBXbMRP/la9/mrGkyWqeCxFQQXRa+9uUcu+35aou2uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HH+wgIvP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g6u1DsUo; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HH+wgIvP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g6u1DsUo"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 9676C1C000C2;
	Mon,  4 Mar 2024 01:44:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 04 Mar 2024 01:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709534648; x=1709621048; bh=S3zuugWWtk
	JS2ebTNB2ek8v9xlfXrPi4RQ6TdoMsJ+w=; b=HH+wgIvPLV4zWYXGhx74Tl1b7Q
	+wcdcpCwyKWSVBQE1EnC7Q8rfJjKBCc0bDJnITXkSbQDKOGzFmnvqgvdQV+6Tm+O
	72eYXu1znrHIRTsxJPrm8rz1Pqn2vMDTIIkmA3uUht37bRQgSwG0a11RYIgNz9L5
	vWdhSnWJ7KjHYGd8EY9kYdOlnGqTdpe2nHun3PMf6dwQW584ETZut8LefHv1Usw1
	wXBhf581CiJLKwzkthfYgV1BCj1FYBFCBIgttYetrIixO2s3xPN1MsuSxoHjgyTM
	enOl1ixMBYsRl+6/b+OgPNF1B3rBWx5MGbc6p0FErhWgWdzJU2NWHG5Pz4OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709534648; x=1709621048; bh=S3zuugWWtkJS2ebTNB2ek8v9xlfX
	rPi4RQ6TdoMsJ+w=; b=g6u1DsUokdS1dtUrBvp/0HHzw+ogMdFG9B23sgyOnlg6
	m3mR6eJ8ZTzzml/K8nGczdb0AafAlKgf+WnClG42zV7igbuZSIAJJZSicu/AgPCh
	jTTXIMeF+FNBAUCYKQnCoEsY/r1VltcfukpTDw8xBuvzEewEZU/vQz/O/QtNYcNu
	/ebaklt6dXw51qatfPkyXmjiiQ5B7GmD4vldP0jNas577oAs+h/E4a6Y8p4NFmHD
	RWgdm43WIoKZ4ESm8GJS+2rU7Ad8q+MOzaYjpjboWB63BL78Z5fm8fVH8LrrYfgm
	ua5gLzEsEOT4lnOJoJJMCe8B98EfbuwzJKjmmnpd0Q==
X-ME-Sender: <xms:t23lZa2rhkmPy1DzpQ3J8gZrWW1L65uEV7PjF7rheir7CLeyZeCGBA>
    <xme:t23lZdGiBt5LGoEEzNp9VEJMiQVtRJImJ3p2RItmcyOOkTbuRZbYTfeJir3TQ-9q8
    4EXO1sV-KwUWNXnTw>
X-ME-Received: <xmr:t23lZS5xJ81Ct_K5ByRSbX4brQ61ouofghSRrWvdQA6U8ChGJAzjriTFLTMrnq4Kwq9fgtOogCYFqizu53TfAtpnlx-KrEhDwH4jCFdp74AmsNo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdeffedvhfelheehleeghedtveeiieekffduvedvudetfeffjeffjeelleefvefhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:t23lZb3wxUiZ7-3jat2cUcSNJRlrF6XOq_Lhi-6ZO6JIN3P38ffcfg>
    <xmx:t23lZdESEeNF57aX-fU6Fa5EWVJNg9Hy7Nl6A1inpMbVJHHizMSuMQ>
    <xmx:t23lZU9lvxztLQYATfq24_NtBgWkX3jxxFgBdf-jEhyhDJy9Tc3slw>
    <xmx:uG3lZdCFqy9RkoNyFsvPNQVxNcGUn7Ah_V-I1fBbPCwI6eaPH8nJ5kuF0ZE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 01:44:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 154c47cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 06:39:39 +0000 (UTC)
Date: Mon, 4 Mar 2024 07:44:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 1/2] refs/reftable: don't fail empty transactions in repo
 without HEAD
Message-ID: <ZeVtohtcxCCqUSlX@tanuki>
References: <cover.1709041721.git.ps@pks.im>
 <95be968e10bd02c64448786e690bbefe5c082577.1709041721.git.ps@pks.im>
 <xcbwno3x7tzcg77rtfkaqtqcgll32vhx5mlhcvlclew6lkkofu@h5jzvft55uvv>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gVyqacOWpQw0KSWT"
Content-Disposition: inline
In-Reply-To: <xcbwno3x7tzcg77rtfkaqtqcgll32vhx5mlhcvlclew6lkkofu@h5jzvft55uvv>


--gVyqacOWpQw0KSWT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 07:20:42PM -0600, Justin Tobler wrote:
> On 24/02/27 03:27PM, Patrick Steinhardt wrote:
> > Under normal circumstances, it shouldn't ever happen that a repository
> > has no HEAD reference. In fact, git-update-ref(1) would fail any request
> > to delete the HEAD reference, and a newly initialized repository always
> > pre-creates it, too.
> >=20
> > But in the next commit, we are going to change git-clone(1) to partially
> > initialize the refdb just up to the point where remote helpers can find
> > the repository. With that change, we are going to run into a situation
> > where repositories have no refs at all.
> >=20
> > Now there is a very particular edge case in this situation: when
> > preparing an empty ref transacton, we end up returning whatever value
> > `read_ref_without_reload()` returned to the caller. Under normal
> > conditions this would be fine: "HEAD" should usually exist, and thus the
> > function would return `0`. But if "HEAD" doesn't exist, the function
> > returns a positive value which we end up returning to the caller.
>=20
> In what context are reference transactions being created before the
> refdb is fully initialized? Is this in regards to repositories
> initialized with the reftables backend and used during execution of a
> remote-helper? I was originally under the impression that a partially
> initalized refdb would appear as the reffile backend before being fully
> initialized.

The only case where this can happen is during git-clone(1).

Patrick

> > Fix this bug by resetting the return code to `0` and add a test.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
>=20
> -Justin

--gVyqacOWpQw0KSWT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlbbEACgkQVbJhu7ck
PpT1uBAAjF+frz4/iIvmMFr0DNTJs5hCjqSqPjDaeIze0Igd8VJWDrepI1iaSp2Q
cqHi0c9hpQ3LRSTsJmB8PDT5AuGe08os2iR2vo+T5/4d9yTGYePQanUQMk2X/6wK
a7OgoR+m1TSXdKsmWulnwcQ0TtHTAih2mnEvFCjz/tqUC2R1hwtcpHDO187YCcOR
fbh0XqNAj7ibVhR0+nxdTOfIBWDbFVL1b2QD8oFgrigKb8DSMGhlIcG5+H0ksDf5
Fc1R75a7pmyzEP6gBZGcss1LH3vQjVLxtoARJM7jlFLMke3PHTVYlzIgy32sCGfr
iXHLYoz+Rjm1IQ9zrMfDjoWLo0LfdkdM4WQoVkTHcm/21EqEfgq5G1gjnR08Wc+Y
BihWnLcP9NJIijS1I+Ny/Thwqs6T78K6NcEFtWQfFoiywPyJCOvD/QH5bOsQZpJP
nfs0mJKogED3bzjBFyZeI56qMRlEIQoJ23wIqEfsPCaQ2KEBTnYhnLWedwKDGAiZ
QCcPAskJ7DRcG/TXHZ3j4Cza1TKqAgL4q6RwPWltKRANC/0rx4hP7JLyPpZZraoG
z018r8r/kbggL6KnZ6wWJmF1VUfZI0em+fH9fLwk6DMAI4SiYUXRjQvSxoT92Hmw
nGthY1w4PFBFRHyAsHJTgKO7C9rKYwUDxu0yygy5nKi7Jd3H3ZA=
=TDX2
-----END PGP SIGNATURE-----

--gVyqacOWpQw0KSWT--
