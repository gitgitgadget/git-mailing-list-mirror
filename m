Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A7613AD1
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983994; cv=none; b=cNY9Wr57ISYEpR6UGEFfnml9LOHnKwkBw02ePTJxnLPHAQ1XvF4UgYQisH3qntZqgt7crF6xQcyeSrSD+0PFFQPH/Wm3yn8yU99SszC+nVoxg34H4wklLHKbO4TxaF/m3mNmjyeQ9Vv9Wla3ag5BzvHsg/2WJlZp/LPj1iICzwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983994; c=relaxed/simple;
	bh=xmYY8GDmU0HbvI5YDTsFOnqN/F7pAvI1jgRAzLZnGDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEGkF94UugyECWG9jvrR1jxqzyNeS0w4Q3oXSEEd5cZozStUj9VP6eNoz9jZctWcMrPqC0czB/AaDSxTppJaTTWM6H8ZodF19GDWXRzBVrcRHzGvRzWHAUPBq1x6ykmoMlKTc44CtgVXi5ywpPyl/mdAqv1/hHOR1uxy3qLflFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=joB/iGN6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jL4r/nU+; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="joB/iGN6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jL4r/nU+"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 76D8611400E7;
	Thu, 15 Feb 2024 02:59:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 15 Feb 2024 02:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707983991; x=1708070391; bh=jpQaMuWMQh
	m56HKdX4lFVYltZ1i9sG0boiLzGiVz+YU=; b=joB/iGN6dzb0zsQYzvo8rkLeAs
	2JLiCO7YeVBTKFwbb/gdBprN4q8Li5JXi4cqUhfhCyHrad7z5e1i7tK/zwH5reFQ
	RI6KTPuglh7i6cPL8LzRD2jUVT+N4pzgz6k3ZwXc6SKhVjoDq9NtlUqs/+1xFM13
	fd6QsslfKQ8Guq/CjW959tV+2CEdOJU4Jnh4LQ9NSzFUbertzzTH05IBLa6IEHY6
	PgFpWttZpwnApb/doq91hmjrc9fQ9NXyDB6kpHK5XsetG8BWjHvlMvNO8AG4ZBeG
	SkIuzw0aoE3sLxMfu/sqW/W5fbwxZljxHG1iAQuXcX9Ax10lqqscBX0jkwMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707983991; x=1708070391; bh=jpQaMuWMQhm56HKdX4lFVYltZ1i9
	sG0boiLzGiVz+YU=; b=jL4r/nU+XgjXeLZYXwJZZSTCmGDsEOfcSCMuGvmAcph1
	LEltSdR4DQblLLvfZxzoka5PfAXEuvEVzuSvWqXIUCjaNNlVo0Iv1o9f1fNkKX/L
	IcS3aTn1mAFBcY3wwqDvsSGqplSwsDp+EeWAilrEdViXHhzG3kvwQKHr668XSjgP
	LZuxZkEqpeyUAZyOWTodtQNj6jG/mUqrGakGLBm6tdSIJVy/qpUzQQjChXPZlF3P
	Vmc8V/8Gbz8nVavw5HGU/It83ozUhmErBro37X7Cts7DFQEnIRYdEpNej8AOdHe5
	lTbnGa30ENzN5wP/nmLN15fd6Q/4YbRVCPt5teMfMA==
X-ME-Sender: <xms:d8TNZVS8wUgZePY8KfdVlkMjrDR7Xzm03I-eCEr8Hdn3hFgLLVcYLQ>
    <xme:d8TNZezDFsesOJWS00iVaCCCbGsVjgKs3cxBGHvRehvVz3kNhwrf9YDczh0R3Oc1m
    cuOWBJx7Mz5GN_KUg>
X-ME-Received: <xmr:d8TNZa3Lp3UF95_g_xU2X9G_GeBcdzpKHktzgCH_8QmfgALSpuMBDqs38zTKP5Qk9T7XYUYIxGyl3lwehq0a0_mnhEksqVp4hlJEVlrgk5r8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:d8TNZdCSzufQsbcpmyiwrCbQyM_xtlG4JtZhyatwS58iibHfBOqfaw>
    <xmx:d8TNZegm3z7p6JkYeDxd0DHFb8zL1w3QVYGLxB8GYsig9HvFc2f3pQ>
    <xmx:d8TNZRqdvtDerVxCf-SMP6no0RUvD3fZMkIPCyw33pwUATOfapnO-Q>
    <xmx:d8TNZRspQShmTRW0ucZBdWUnDtH2nbnpRVPsoCg2adf9Q-kgZjOa0Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 02:59:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id add47018 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 07:55:58 +0000 (UTC)
Date: Thu, 15 Feb 2024 08:59:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/7] t1405: remove unneeded cleanup step
Message-ID: <Zc3EdG7K0NqV61rC@tanuki>
References: <cover.1707463221.git.ps@pks.im>
 <25cf00c36f715edc6b4e86001a36a093f4c4b2e0.1707463221.git.ps@pks.im>
 <xmqq4jeatz3n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7+fSUXtKx/HBY7H6"
Content-Disposition: inline
In-Reply-To: <xmqq4jeatz3n.fsf@gitster.g>


--7+fSUXtKx/HBY7H6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 03:17:32PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > In 5e00514745 (t1405: explictly delete reflogs for reftable, 2022-01-31)
> > we have added a test that explicitly deletes the reflog when not using
> > the "files" backend. This was required because back then, the "reftable"
> > backend didn't yet delete reflogs when deleting their corresponding
> > branches, and thus subsequent tests would fail because some unexpected
> > reflogs still exist.
> >
> > The "reftable" backend was eventually changed though so that it behaves
> > the same as the "files" backend and deletes reflogs when deleting refs.
> > This was done to make the "reftable" backend behave like the "files"
> > backend as closely as possible so that it can act as a drop-in
> > replacement.
> >
> > The cleanup-style test is thus not required anymore. Remove it.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/t1405-main-ref-store.sh | 6 ------
> >  1 file changed, 6 deletions(-)
>=20
> Again, makes sense.
>=20
> This is a tangent, but artificial limitations we imposed on reftable
> to be more similar to files backend may be something we would want
> to reconsider once reftable hits mainline and people actively start
> using it.  Not having to lose the reflog only because you removed a
> branch by mistake would be a powerful thing, as it would allow you
> to resurrect the branch as well as its log.  Being able to have a
> branch 'foo', with work related to 'foo' kept inbranches 'foo/arc1'
> 'foo/arc2', etc., would be a very nice organizational tool.
>=20
> But it is a good idea to start limited and later making it looser.
> These two limitations are something all users are already familiar
> with, so it is not as cripplingly bad as it smells anyway.

Yeah, I very much agree with what you say here. We have it in our
backlog to change this behaviour once the initial dust has settled.

Patrick

--7+fSUXtKx/HBY7H6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXNxHMACgkQVbJhu7ck
PpTzcBAAq4z0irK/iWHzQNYc4VghVda6S2poKOCEqSIKpVDRmp5go+sBcpP834i/
5MxX8871dZMR1Vg+CDEqSTLQb3WgcJDtmDqfvKksn9UajhsbbyIgjo7IeCcUe8/m
r88P+o4mBX1QhWj0rNAifn26wcRgpL8bLQSHp9NnI9zIk9qRb92pw7PiOEX+HOns
HDxmApzcoIOqETf7qKLtl+9N1x44hbK1L0Fa63YRzSXba2VhJK48fYKb8f6k8KbC
/K/E2HhNtgTAuoUjac0f9icpQJdCb3BVy13gD8GdniUIp+O1FE2KwQPYcARJVJZd
mmqwfegsSTtHeABOTptH0GhT0XyzCPitF5MJ+CYD6p4tIwjImOxraiwHda8jJUpK
xvtUalXUbzEujapnBmQm3msmqLufIMwrHDuKNyB260tbnIT6+F4aov7+u1b7WyJy
2fG+aiuA80TfRWrmxFqktujrihSwQ1wOO4ghELjrxEsNbCdOcZY5pivLryTizEGt
dYIUqLCYZEAYzWg8F6JuglDY7ViZd01Gmhl7Wem+vKCBvnuUpF4G9By0HTfBayWn
gPHjUi93JcEAOk32ktthqafiKv9p8SCoONT0hBwiU/pSb6Y+f+2HtJTPSFvKv2hx
yQeZIyFsdHkL6Wn9DpSno6rav6Lskv4xCCtyJhIuhbCAMNMGKcM=
=1ubv
-----END PGP SIGNATURE-----

--7+fSUXtKx/HBY7H6--
