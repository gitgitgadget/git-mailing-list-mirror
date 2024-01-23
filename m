Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6D75D720
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008608; cv=none; b=aC8ur0+HAuVRRowztXhH9U/fD0QjaeAmkTFSIxg/w78/v34b1LmEcEGaZwvQCekqJRYAcDowWXsrwfwvh+D9njqHRA5Af3S9YUxmYtL3dE4FdtCeXfOVqFdZtMGzaBWaZL2x67smKcJLDQXjhiPekLMUlvAZnU/ZlkZkHNQeYiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008608; c=relaxed/simple;
	bh=pC3VIV4h9LyI6y+R9ukVXZZX51pUGYPgFFgfepkOfrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFCMHH6u3ap9aUIOUAKLx+A6XiX9QdiXIfNiMLuw6xda1EkOXfBRhHfaDUDbwIFzimFsfglyOY6cEzzhVeE4RLzbvdKgmBTJalqELH7s10Q/1lNx+k1dtLV+2+TrT0+nLunnIAfe6a9vC8BKaCnlsgn3APhD9gie7FiWSz9KGjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rmM1emRu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LdE/VB/9; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rmM1emRu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LdE/VB/9"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 408273200A4F;
	Tue, 23 Jan 2024 06:16:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 23 Jan 2024 06:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706008604; x=1706095004; bh=O1uAmdP5T5
	nLzXR+rVjLjT5/aa67RQLARzbhb+QLmis=; b=rmM1emRuayjCY18R752Xg70tk7
	RFDObx8veJEKbcx0g2clw2CvoCOvGPLbLtlffHmPE65SHvl2Y1ojfC2B7kaXZ2wE
	RLSH/E8zXLrytBw9HbQ4gA/yaDuXKlLT/hg9m7rkYkGoKxo3N6v8iB2WXFmYebUo
	npoE+01JJy/FwN/wAr+II6yd7zP6dgIDHRhLcw90NezOiFzqd1BpRzncgGyyXlIQ
	kS66l49n15k9nXdFyCyhRPcfpLJ+2zgD+MrWfKnyfsxwut/MuG1mukPtv8/5tDMt
	xa4ecUyjUSFt1h0tHXh3wmH21TgOu8Ztu8cVkfJwlf1anxHFuvW2jfHsBnhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706008604; x=1706095004; bh=O1uAmdP5T5nLzXR+rVjLjT5/aa67
	RQLARzbhb+QLmis=; b=LdE/VB/9gibkX6UNDcFVeXqZKIoPmdxSXiPa/IQpPJIM
	FRo281JVNmyQ6POkHMX/4UD+Dwjb/YOZqvkReIX/r1p+dkvP0CSrIoo7iY1BXx4N
	udtumr8sp470gneDa+H6GvlxrzcQkDJl3Z5gJvIFeYGhKldEv10Uramm8z1GB+JG
	t4mRbyBuwx8C4yKmbVjBCBqUygZxKDlqbt8NDlwozu1V6B3nfrfokmXaZh7soZaM
	QYBgNOwT36Ylw3+Ob1Gq4bWWR+qhtAB6s3/x+HyQLlCpHtu9//afyiNke5zJOeBN
	eH4fSlGz4tgb44W5HFjovP6s5QlIOYFzBfTIynm3+g==
X-ME-Sender: <xms:HKCvZa-8yyfx1pRbIzHrahkT30d2n9tg50k9ymxNIDhsJ05pAg_eMw>
    <xme:HKCvZausjvjgmaUkT8C_CToQFtyssdkdaPrVimiEZgNG1bFZpAtXYagyX9UyaSg4M
    czI1ZcWw6lEWPTABA>
X-ME-Received: <xmr:HKCvZQB_5XK25AdoD-dFXShOJO2cXK84NscIsnFpUJuhj3oiIwXvVnei2sS6x_PZsX7-OPcd9Nr8BYlb0lr--RaSyyQzc3B33bH_S5SWE2i1YQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekkedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:HKCvZSd_tHQ9Dx-U3NjImxc96SwQmV4w38lq2FuEQpic76m12cMWXQ>
    <xmx:HKCvZfPxTiHq6s40HJfqMNxCFJE766TQQ7lq251NL2JA9pY0FcxOdQ>
    <xmx:HKCvZcny52KQJ5Kk0P4zLFqv3LLd-whXkWSGFR0FKm4Gf7Fapmk0_Q>
    <xmx:HKCvZYYqXfWXUk6s66Y_ltBPp4wPiB-GiYfg0OfTpHdg9gcaBaAaRw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 06:16:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9fe4b34e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Jan 2024 11:13:37 +0000 (UTC)
Date: Tue, 23 Jan 2024 12:16:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/5] refs: make `is_pseudoref_syntax()` stricter
Message-ID: <Za-gF_Hp_lXViGWw@tanuki>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240119142705.139374-3-karthik.188@gmail.com>
 <ee977173-bc6d-48f6-9bc8-e1d84fe3d95d@gmail.com>
 <xmqqplxtrucm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YT4BbyKb2Sk03Ndk"
Content-Disposition: inline
In-Reply-To: <xmqqplxtrucm.fsf@gitster.g>


--YT4BbyKb2Sk03Ndk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 12:22:49PM -0800, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> > The list of hard coded exceptions also looks quite short, I
> > can see MERGE_AUTOSTASH and BISECT_START are missing and there are
> > probably others I've not thought of.
>=20
> I agree that it is something we need to fix.

I've taken a deeper look at BISECT_START because I previously missed it
in my conversion to make special refs become normal pseudo refs. But as
it turns out, BISECT_START is not a ref at all.

Depending on how you execute git-bisect(1), it will either contain the
object ID of the detached HEAD or the branch you're starting the bisect
=66rom. This information is used to switch back to that state when you
abort the bisect. So far this sounds like a proper ref indeed. But in
case you're starting from a branch it will not be a symref that points
to this branch, but it will just contain the branch name. This is not a
valid format that could be read as a loose ref, and thus this file is
not a proper ref at all (except that sometimes it behaves like one when
starting from a detached HEAD).

My first hunch was to convert it so that it indeed always is a proper
ref. But thinking about it a bit more I'm less convinced that this is
sensible as it is deeply tied to the behaviour of git-bisect(1) and only
represents its internal state. I thus came to the conclusion that it is
more similar to the sequencer state that we have in ".git/rebase-merge"
and ".git/rebase-apply" than anything else.

So if we wanted to rectify this, I think the most sensible way to
address this would be to introduce a new ".git/bisect-state" directory
that contains all of git-bisect(1)'s state:

    - BISECT_TERMS -> bisect-state/terms
    - BISECT_LOG -> bisect-state/log
    - BISECT_START -> bisect-state/start
    - BISECT_RUN -> bisect-state/run
    - BISECT_FIRST_PARENT -> bisect-state/first-parent
    - BISECT_ANCESTORS_OK -> bisect-state/ancestors-ok

I think this would make for a much cleaner solution overall as things
are neatly contained. Cleaning up after a bisect would thus only require
a delete of ".git/bisect-state/" and we're done.

Of course, this would be a backwards-incompatible change. We could
transition to that newer schema by having newer Git versions recognize
both ways to store the state, but only ever write the new schema. But
I'm not sure whether it would ultimately be worth it.

Patrick

--YT4BbyKb2Sk03Ndk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWvoBYACgkQVbJhu7ck
PpR2Aw/9HTb6u0wcpE1oL1F0L/+pW75zMVyV1pytvO6NsS32IdinqfoWjVV8dpwY
urg241Ozg4ZBhP8sfgx3XgjWI1tAt8d8fdf1UhjLg13arHFtCgcE2d+JjUqMjz52
BjX7cUXf3FoOIPIgWqNaMbR5ByItiHJeH8duV3fUKcdvGUdRAheY0+5k3c+8NNb5
dagM/mPPMEvQ0SS15LtlVdc4BFkK3nkRQSMaSFmQTOODr8h/oYflcHYa5hnzWXt4
y4xdeuz+1zhG1G6u0YrWl1WDuxz9wVizeqHr5JLHq3bSt1eUgW0vzVMVW+MooWrW
RMprFnaodh726wdi2Qe5Tc/nmcAVOTy7tMk9unnr2yChvrKgHutZ+wPCD3du4NjE
ebrue90PaYZ3QqBObp5m2nJTXjDZtJwUKbMP38B0fNs1z7RBVJzGoUKsUSzDm56P
2wBO4YQOt1yEW6XpqIpfDGl5fDjKrMvdIq0Y27wOn2QOM4QzgPJp17o+BC9kYaGd
q5muueHzuxndRxm38vwjQA1aB5vhBSVf5X7evC+CdFTrF5flwpOOT1et6xxZS2Po
uvISXmG05m7G17hl2p/1YwoTBLCt0WLXCPjpmRGoSFVGYwYKkgsMm81cHUXhy5o5
kaRYP7qg4jD4qJneXJw3BMnMmxB/DMltFIKRAsCubv8dzDuouGI=
=y/tN
-----END PGP SIGNATURE-----

--YT4BbyKb2Sk03Ndk--
