Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617871509B4
	for <git@vger.kernel.org>; Tue,  7 May 2024 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077967; cv=none; b=P/AoI0UZHtw+a03f6DAXeu7RovDyT24JvLw/tt5NotIWVXTfVuFP+cxcaRscRMoS8wVUDaVwtuW4VjxYFS4HUsdE/0asibCwwOhu8Mg/9wabsL4qfSzGTnjKo9ctdwfu2VYviIwtM/H0TPK3o3KcIDEyloZqNalH5x6qalTYH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077967; c=relaxed/simple;
	bh=PTy60HnMWHidJ6E6ZBxJZ7wRT2DkZDYpAFoVD6jWczg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5T1r/3QwuiK7JY4fMsJpHI+MH+fczEUOJFATXo++itV2IFyh9L6FrRDySZiandQR0PNd7rmqb/JBQElsxmqz67vzJ/j3OdkPIv6havOqlkXNW/k2eh6sX8MkdP+2vHrb2hKtqiTCudTIXnFqv9uChG+y1EbmDKXD14imQfF4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lLD2uZkI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hxi/HcDC; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lLD2uZkI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hxi/HcDC"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 15D0A1C000A3;
	Tue,  7 May 2024 06:32:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 07 May 2024 06:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715077959; x=1715164359; bh=PTy60HnMWH
	idJ6E6ZBxJZ7wRT2DkZDYpAFoVD6jWczg=; b=lLD2uZkIDSSupjCQgMMpKnTDnk
	uoBTUnKPAVxi6sN5+MQckE0yLP3u+j+ID5d7Qdu9OkPFfab1smD+cx5jBlB7MIb2
	6q1wPQW0dtXfcdrDQuvGoulUDmw6gYE5FrKF0iexWr3b6YJtuRKO7XCqluMMUBDv
	am5RoMxcaf9yYgiUZh1kc7h8Ze1hJDUd/uignrqG/0G7B4zGjDOJSXs+4NwFhElQ
	6d51HHLHcTnszaCAnxER1USoSo6TSstSFyN1ZUX6xgwhVlsv7uYcazQCfWnalOse
	3rcBBPi5OieBIMdt4txrwx63XYyhQSJ8ps29LCnHSX0mf/9NF2599cB5GOFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715077959; x=1715164359; bh=PTy60HnMWHidJ6E6ZBxJZ7wRT2Dk
	ZDYpAFoVD6jWczg=; b=hxi/HcDCvbJz+vNWSNUNLRDwIyjspNiEszL0VC6aa0xs
	2CMjiwQZu07pobCgnEdrDIHpAYlQv+zn/CFVxOiT2zuSjpKpmaEG3AdWOBJWnLhE
	IUnN8MM/mn01ut1Tz/5L+fZCa2AucRJVdceDC9xh4mvVFKUSW6Uiq4U2JSggvqlF
	lVUvp6pNJdwbvwp6NEYkpN1lbROYQqMflNx/RlQ7beNIdljDQ8//7geLk9cvf2/d
	+pA3+QCu0piCgstVWSEM5j5H6O/EbiC2ywQTvDFrt9MSl7/UFBpWbi3EW+//qm75
	PIKZaloqu/A3kUTLJu78ZRQpvmoNGgf0GuMp2545UQ==
X-ME-Sender: <xms:RwM6ZhRbmxx45OE6OB_DPpV2RDblolN5kqZJLPl9nIvfJS_ofjQzxg>
    <xme:RwM6ZqzbX1gIcyN4eDq9MAgMvY3k7T6ixxOjH0itiTkzYY-MLmMwndxvY_jCTBlz0
    4tIMkoSCVEQc0HKJA>
X-ME-Received: <xmr:RwM6Zm1oHWIMef12wJy15RoDPMkvDdmmNog8wL-O9wv0NXN-Nfo6FIBJDU_aekINMyuqs_91QH1Rq2UmkqDaM-LFEhgGeLqkXI87o28m075z51ODDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvkedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:RwM6ZpDQtkHF2a2hedWqT7nvsYo0WIZ-36Itoj5cpxKvAInkbjpuJw>
    <xmx:RwM6ZqjxO5vLSwofmtBeALPG7PdDmJ8S2-wvphHnMLwgKmjDzHmw3w>
    <xmx:RwM6ZtpwaeuMWpW_2Gvc0opF4Cq6IBfISC7kw79A8cCGYue2nim2RA>
    <xmx:RwM6Zlh63n7zUnFUrw2kz1OBVizgIjZfgoxnTBxRFrj3XsoRJS6x3A>
    <xmx:RwM6ZsZcijaHF7VKyjjMZzIirHI0xRK8seqbq_DwvQmvbHhqCMswNzoR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 06:32:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 380f2755 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 10:32:28 +0000 (UTC)
Date: Tue, 7 May 2024 12:32:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/10] refs: root refs can be symbolic refs
Message-ID: <ZjoDQTe8APWgyzll@tanuki>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714479928.git.ps@pks.im>
 <e90b2f8aa98493e9cd3f2c04cb58318780f9f6e5.1714479928.git.ps@pks.im>
 <zmnute2cow2rbrv3cj5cq4roieyzssaxcnorxhorzyp3wfgllt@ubhsw6dpi5js>
 <ZjNJ3j2wSgui_cG8@tanuki>
 <maqra7gbokanvptimdk57gaaitdxdpaxse725odzcvqieqfhbc@sgdmfeuhi5hj>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Gqq7LaEef+1KkamQ"
Content-Disposition: inline
In-Reply-To: <maqra7gbokanvptimdk57gaaitdxdpaxse725odzcvqieqfhbc@sgdmfeuhi5hj>


--Gqq7LaEef+1KkamQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 03:49:25PM -0500, Justin Tobler wrote:
> On 24/05/02 10:07AM, Patrick Steinhardt wrote:
> > On Tue, Apr 30, 2024 at 12:09:57PM -0500, Justin Tobler wrote:
>=20
> > > I'm not quite sure I understand why we are changing the behavior of
> > > `is_headref()` here. Do we no longer want to validate the ref exists =
if
> > > it is symbolic?
> >=20
> > The implementation does not conform to the definition of a "HEAD" ref.
> > Even before this patch series, a "HEAD" ref could either be a symbolic
> > or a regular ref. So to answer the question of "Is this a HEAD ref?" you
> > only need to check whether the ref exists, not whether its target
> > exists.
>=20
> Thanks Patrick! I think this explantion might be good to add to the
> commit message.

I'll restructure this a bit. In fact, we can even get rid of
`is_headref()` completely as it is now covered by `is_root_ref()`, and
there are no callers of `is_headref()`.

> > > In a prior commit, `is_headref()` is commented to mention that we che=
ck
> > > whether the reference exists. Maybe that could use some additional
> > > clarification?
> >=20
> > Which particular commit do you refer to? It's not part of this series,
> > is it?
>=20
> I'm refering to the comment added above `is_headref()` in
> (refs: classify HEAD as a root ref, 2024-04-30):
>=20
> "Check whether the reference is "HEAD" and whether it exists."
>=20
> Maybe I misunderstand its intent though.

Ah, now I get what you're saying. Yeah, this could indeed use a
clarification. I'll add it to `is_root_ref()` though given that
`is_headref()` will go away.

Patrick

--Gqq7LaEef+1KkamQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY6A0AACgkQVbJhu7ck
PpTRXA/9HyafcltPy7XT6C3Ynq3EGmTUvMqL564FTtB7n1P4zUNcrn+/qEgUIuyp
+e3ILBFh3psBRn1okZKzSUoo28cHDnUbWKDl/FV33TjgPlF7WNQXJ8xVZRBsMVRy
kUEIIjJsZ7s1Z2fnwEwlQ0IU1k6SJbqKIqzTXNUKNl8WvW8WApyenkih5lv3LOAf
ZkDASuGS7YLjTk6YpPva+IqfkArgKz5eizeNa0Qwy52BJW4LKnz9j61JRSJciHGp
MjJ1r6gRmgogiAVPXGRVqWwrsoE46Gx1iaZz15Fnl2j1ZiSjj50YndcOBvKwsdy1
86W3qfpNKXt3aUSSCw0y+JjktvnpiQiMewilsuAJddp3x8em+Qxsxw1FKM8LNN3+
3eMYaTX1qZzro1CRk0ntJNGHlP7YQ3eaoJ3i1Izbvckjfw0mFv8o48+BGPj2F812
+8nChEGhDlqstiKmD1Y3XiZo/5b3cNiK2j+HJnhK3HmZa1pSX7/ZYYFI4TCIgTJi
l+rVCJW+zDoxz+mqb3zilFuxgxemsUH/hFGjoC6sI+ndyloD+yukxy6NmnTk3YC8
hmHy9vxWB9TLYs9gwY2AG4t/5Dy5S+/+8Em4FX056cae6fM+y7gYCCXHlPpA5kyz
hjA/fjEfq3JNaQjaAVDR6O2XhIQpbExypCdyxO64AInj2nJpX+w=
=tDiX
-----END PGP SIGNATURE-----

--Gqq7LaEef+1KkamQ--
