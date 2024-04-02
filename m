Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF15C17BBB
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 05:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712036407; cv=none; b=PZbwODh+73zj+Xqlc62XnvW0Wd1lx/acav6Z3qZf3sXob/UbTmeERjG5IlegRDGyUbvwHnuhwys3+js9ha8KcMpLTRNBukNrSdzc1eSlTldDdz+0LdMJ/e1A8TgZwSKXMX4J3Mxc6Ymi0RYenEJ4HHUbWBCssWsMg1zDR1FQkIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712036407; c=relaxed/simple;
	bh=1p1Bn9HvVoiByFgcDdfJWchO0DlYKr9NkOUXgAEWdfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nsq0YIf7rQIxxT1HtRilB0hTo3ycaXGrT7ab3UioIN1eGiv4How1rvayRaCmkpxZUBlgEkpeUacM1Dvbh23kp8+07Xq4ROQOB/JIXGiyR6khLQ8p0w5OTvP66Ab5YHRo4weVVkO/s4BxiJ/y5xhaW7km1a6SxhjNt0A1AOjMzh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pHHqXRjE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OaZwMI5N; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pHHqXRjE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OaZwMI5N"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id B2EE513800CD;
	Tue,  2 Apr 2024 01:40:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 02 Apr 2024 01:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712036403; x=1712122803; bh=Z+gzss4Tmj
	wD6gXMZT1dEoEW3UqpT0AKyPdwr0f+mfE=; b=pHHqXRjEasF6NVPLSaDP/ZKm4g
	Go2ccwIG0IgAFS8SrSZ3gerRgp7/sBb5nMkAXML0kAXC8tyq+KOdl22CqoLkpE74
	kgYfGGM9VO1ENk8FTDLgvMI3LQQyxdCVY63W4DA6yvedDtCpwjnRmfXdly+0bGyB
	bEeibZePseoz2fk44C39FZ2sHNK5S9mKhJgTzw2bMqYzb/YTWlNPIgKYAwvYITVn
	D87pz8gFuebQsPpty+erRk0bjQBKzGoVmllfuvXSH6R4btKmlUqT419BusTUzFd+
	QepYFc9odxoiE02LI5kiOCvBLBi2Oy47VNZzwn8YxwigwSBlTGtikqMLDGvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712036403; x=1712122803; bh=Z+gzss4TmjwD6gXMZT1dEoEW3Uqp
	T0AKyPdwr0f+mfE=; b=OaZwMI5NjAe9LWWs2efSLHHF5lo4por1GJPpg7a3a1bu
	mQwaG1gqwglHXk6uEwaDDf6ws2vRdT0kayhhqWURq33W5XlYBbRUI5gY1ZgMYAXw
	CPUVPDqyd8EGSGM6te9J5DxiCT3ESMrbLBTALP1zSb5ZGiHzUYKWQO1hOpYfdt25
	5GMXtfF4//OVUXyf7Myq+imxzvPkBKlP1MhkO30lN3NGkvw4nmOaXLw4r6ykY4eV
	RCef15qsKItA9X2vdijU+hEWA/vpy9AgcRvtGmpfnUWV94LN0h22GOpvf3PTe9pr
	ygC8EqHcO4e4AwU2i1vDRoyIdjCMqK7qJmRk/LA1Ag==
X-ME-Sender: <xms:M5oLZqSrEQFbZSPfiqWY3KvWg7zQBnrJq_ZYc4K2tJEEZFMHmO7OWQ>
    <xme:M5oLZvyI4Q_EELLex1SZR6wayznyR0B2t6W-MsUCgqZAPfMfn4zbd2HdhGrQWG5Yu
    nvqnpim7QmweIkBlg>
X-ME-Received: <xmr:M5oLZn0TyitjSdvDJJTwKduNn8qqDqvMvobROSGo-A_R333uyVDg6G89-NUUYQj4oMhwifej8uAaH8c-dzACi1fJqt5q1tcSaARFDLxim-keTOk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:M5oLZmAGrNRCNOH2CGlPqBPe4LzGH1NKM3gkpSsWis25DLN_aClWPg>
    <xmx:M5oLZji7vHexCNAwSRzm-ZcfkR79NpJJchNxXndewMvkd8xVS772yg>
    <xmx:M5oLZiqjFjQI8PqETWwqk7i24qkKatxn8dZ5bYECzszOp5FYKqi1sA>
    <xmx:M5oLZmjGkM07gzmzfuLAIAtqWHqHqTyHgZQKVlPRosx-pyNfll8_ew>
    <xmx:M5oLZuVBkVplepZ87d-HsKKLgKR5nfyo2WYApbQaDVzBGSEEpgOa85aC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 01:40:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d7253bb5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 05:39:52 +0000 (UTC)
Date: Tue, 2 Apr 2024 07:39:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>,
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH] RFC: add MAINTAINERS file
Message-ID: <ZguaLjWGte3zdQGW@tanuki>
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
 <xmqqsf0gvjrg.fsf@gitster.g>
 <xmqq8r27nhwo.fsf@gitster.g>
 <ZgPIEgFGVokYWc-H@tanuki>
 <ZgsoOnle3CC8DqUR@nand.local>
 <xmqqzfuc7muw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WlIGMTb4f+rWSlLU"
Content-Disposition: inline
In-Reply-To: <xmqqzfuc7muw.fsf@gitster.g>


--WlIGMTb4f+rWSlLU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2024 at 03:13:27PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>=20
> >> I don't think of this as "big enough to require this". I rather think
> >> about the onboarding experience for new folks here. Sure, we can ask
> >> them to "Please run git-shortlog(1) to figure out whom to Cc". But if =
we
> >> instead provide a nice script that does it for them then we make their
> >> lifes easier.
> >
> > Do you think that the script in contrib/contacts does a sufficient job
> > at this?

I admittedly never used it much, either. I didn't see a lot of benefit
because I can figure out myself whom to Cc. That would be less true for
newcomers to the community though, where it may be more useful.

> Yup, that was my first reaction.  If it is not sufficient to
> mechanically mine history with shortlog or blame or contacts, and if
> we can add a high quality hand-curated input to improve the result
> contacts gives us, that would be a progress. I view the MAINTAINERS
> format just one way to give such human generated input.

Agreed. I don't think that we have to pick either MAINTAINERS or the
"contrib/contacts" script, but would rather want the existing script to
honor MAINTAINERS as an additional data source.

When it does know about both I also see myself using it more frequently
in the future. It would be nice if git-send-email(1)/git-format-patch(1)
had a switch `--cc-command=3D` or similar that you can pass the script to
so that To/Cc lines would be added automatically. The script then gets
the commit range as input and can decide based on whatever criteria whom
to Cc. To the best of my knowledge that is not currently possible.

Patrick

--WlIGMTb4f+rWSlLU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYLmikACgkQVbJhu7ck
PpQg9w//YcBemnvzsyJDGYZBSn/Rr3vql0e0yrqFzfPqrd1gpGAEf5+740AblFUj
IfwLPq3vML8a63cPa7hNugYlI1wdwfMZAdPDs0nXD2qUIwYMNLsXCmHbFx0WmYYQ
HVBZ8XzRwDRZVBC5SjeMAH1CUIQvFleD+pAdhAw2g8uWRXATykRnRksSmC2b1xM5
qQ+gOTBC3S0tK+93RteiGxG0FoYVT9SofS0WSqC5zDZwnsa0lL+V5W4SgYjdIcXZ
OeO1+6fm8hAXXeJEMjg/Tr/bg1B1hKELBucQauWu78jDT2HfRoMHjpxlk/IosNCj
vdBK5LRTgJNLq/SPhTiMJEiRucPm7y/s+NaTGSGSzpm1Qr213wtV80EnGijV40zE
fpAQft2XwEVC78wAnWBcomkYmVYyOM4XLY6vHXpAQW7h89JTZwRDtmYJE5GkNIq5
xgRoKYpSbwcTAXdD/BAnF7qExvBZtvjjycx736oSrw8FJ6qtNkXA/jF3kS44bBuR
TDag1TGc0pLhjD/B5Xqrdnh4tfY0u8E6bAbQdSDGq2aP7ByOWWeCfWSMU2vOIf2P
7weXXVKRrSv6Sdx7j7XK0TiJfPewkKj8yAD+uKM/i7uuKppsTaQPzdiSId6JY2lD
Iw4VXn9O7xQKl+iC2uPRojRvtBdju6DBrkwrV6HdWO0a6siG2Ko=
=UQ6z
-----END PGP SIGNATURE-----

--WlIGMTb4f+rWSlLU--
