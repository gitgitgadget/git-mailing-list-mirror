Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5AB1396
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 02:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711074219; cv=none; b=WRznNm/LrdwTPzkKt26O3K6yfaXTT8bN3Rd5Ylni6DQfDycTrb8Utq8UOadwGkTYcK9URsmKCJn6goagMm5F0j8G4ln/WOH7HYZR0vOQN23LJDSPxKQUmZZBkPVZRZKF8vhstUXd8bpDQfzYCmfM40XJaoDHFHCEgdDK1aDVGD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711074219; c=relaxed/simple;
	bh=RzW+WkpQbITXVsJ1/tWrUUJoF0q+W99ya+nUM6yPEQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ye9ksW+5VG8ANGh7vVV76ueWnHtZDDe054KYt2UsFX9zNWJ+d4Mwo25ZYesXKzrfFdj7aXoN3bd1M8U9y2hqvpst3Ft+mwMKRFWriX30FI+htGmfYO7Zo2Z0XV6pjgf9nSuoYe6VJ+vLnEFMt1MAGbclOoemr4bZJ5jK2alvFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VfFoMzQb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eTuQ/Hqw; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VfFoMzQb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eTuQ/Hqw"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E4B9E1140117;
	Thu, 21 Mar 2024 22:23:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 21 Mar 2024 22:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711074216; x=1711160616; bh=1jDhgRHW0f
	KXsqYxufoD8Zbcyqo5NWArYz6g7BfHeGU=; b=VfFoMzQb0WX0ba1pVl7J32kVdT
	gnLdbUA7RatfkQwhcC60Z81QsdZiI+28ZrXuMZGiNmN+JxY4UxuSfJEbBDxfSd5d
	gvi0QlS9dACF9f7g9nkQ/CdokRgON7E8y9mZKe0AUFPFFW6Zx4IBWk+GkIE1I88B
	eIbz/5AOfa7GEDEyjB8mDY5oBlG120A2k0DcGYTvxYl0SvbvIPGVv/K0xfAbMlab
	eYUOR11Vd8o5hcrhbAxBWw2Z3whOGJryibzoT4YGCnVa81W4UUkm0lrkp3+9fqvE
	POlspYNBk1JMSeEawTjRi6lkaP7HD5su65i2yP2XQKmLSWnQhj0gX/yFP2+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711074216; x=1711160616; bh=1jDhgRHW0fKXsqYxufoD8Zbcyqo5
	NWArYz6g7BfHeGU=; b=eTuQ/HqwwDQPb+HQs42/mXThy0/twm99YJA9+bJoNwp1
	LgRi3zT77Qku0haEqoiwdTfjaijHSWx1XOMK9lRGodAZQJEXb9PHPrw6aTAbKALR
	CpVh7ZaKZ9nmemLB4IAlcg/OSmYKtLbK+W0nIby1inWpn+eCyFb/B3pdJhaqcPk0
	5kTQnIPHZPDr7WYYoL6Y0gFmAz/cnJ2mJIeK6WQVETuVzauNOxVWGoQ4fMmTjSxC
	lPGpMxdzC4jz2TbpRdbJrdzRp7ePrrTdmhLp/7HJQAgg6jfidMVesGewSKEHliS6
	Gn623SY234gAZvQUNLIFUDaPvpUfQx5WEewff634EQ==
X-ME-Sender: <xms:qOv8ZbRrWpeB6CbWpKpiKFJ7Zs04UVcWejfjPI8L7lbckJiv49VvaA>
    <xme:qOv8ZcyvKVhEAJjx5l1H8RVsodOYds5C2qww1P5q7IO5g9iD4BUqEaGes680PbvNW
    Cr9yOUdu7QifCe5Fw>
X-ME-Received: <xmr:qOv8ZQ16Ie1z39hS6UCcm0oBp6qWlFyWh4zwZpNZqrr51z6xbhAw_8TLDsXM5wFAVDA0fuPzZtsoapceHVFgLGzEIdybIi2YMHX3PUyzJeanTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:qOv8ZbARyBmeb3d4T2q95GD28K_nbHPVcPBnqmXPIc9X6yMnybiXSg>
    <xmx:qOv8ZUhsl-QUvXf5uGlR0SB0EIq3EsCpPqetNvSxlYS3lzCchlgNpQ>
    <xmx:qOv8ZfpmCCMqOcf80zYZiwLrUZpEeUVGKyc4sSx2zq8_0sgFrziXpw>
    <xmx:qOv8ZfgFLqTuAGUfn2u7-BqNENoOfuo90eHrEO9ygJT8fk_uEcUHLQ>
    <xmx:qOv8ZcdbbflRsm_wGc1WfNkNS-TvX0quUEGsc68bodqcQa0aVCHCbg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 22:23:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5feb894b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 22 Mar 2024 02:23:29 +0000 (UTC)
Date: Fri, 22 Mar 2024 03:23:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] t7800: fix quoting of looped test bodies
Message-ID: <cover.1711074118.git.ps@pks.im>
References: <cover.1711028473.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DY/6G/q62rYIjJ5v"
Content-Disposition: inline
In-Reply-To: <cover.1711028473.git.ps@pks.im>


--DY/6G/q62rYIjJ5v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that aims to address some
issues with looping around `test_expect_success` in t7800.

Changes compared to v1:

    - Fixed indentation of a paragraph in "t/README".

    - Added a clarification why one wants to use single quotes to
      "t/README".

Thanks!

Patrick

Patrick Steinhardt (3):
  t7800: improve test descriptions with empty arguments
  t7800: use single quotes for test bodies
  t/README: document how to loop around test cases

 t/README            | 20 ++++++++++++++++++++
 t/t7800-difftool.sh | 40 ++++++++++++++++++++--------------------
 2 files changed, 40 insertions(+), 20 deletions(-)

Range-diff against v1:
1:  fd37c29319 =3D 1:  fd37c29319 t7800: improve test descriptions with emp=
ty arguments
2:  a4ca974397 =3D 2:  a4ca974397 t7800: use single quotes for test bodies
3:  326fb79650 ! 3:  f83b710208 t/README: document how to loop around test =
cases
    @@ t/README: The "do's:"
     +		'
     +	done
     +
    -+  Note that while the test title uses double quotes ("), the test body
    -+  should continue to use single quotes ('). The loop variable will be
    -+  accessible regardless of the single quotes as the test body is pass=
ed
    -+  to `eval`.
    ++   Note that while the test title uses double quotes ("), the test bo=
dy
    ++   should continue to use single quotes (') to avoid breakage in case=
 the
    ++   values contain e.g. quoting characters. The loop variable will be
    ++   accessible regardless of the single quotes as the test body is pas=
sed
    ++   to `eval`.
     +
     =20
      And here are the "don'ts:"
--=20
2.44.0


--DY/6G/q62rYIjJ5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX866MACgkQVbJhu7ck
PpRdQA//V7EF38iHeGVKHZkmZR0VcgTEhqVl3jskvv+13f9Yu+MKz3KmBajnvkRE
m5hehAfdcIyz1ZqC0vILbRjD8Uygmiqs51RsU4kfShIhn5Vt+ZCnuIxkdR7mo51d
oaLSG/VozGtIna6ixTfKpev3o7769JngcSwsLqpWWtlWD9e0bR543A4YFL2QW8tN
Pan7gw/QziYVcJ5nJ+LyRLz8Mo8n8jQNINhyCfAa9BTcYRuEbQHCYvTsPRO8IrpC
dtRUba/rHk/j70JrOoZM3nJ2xJxuSxuHVbGPpe4QRJmUpqk/qllHsbzYn7k787g6
xRHVO60wUvffk6UVarc4fZRvxi9RmZMAvM2EM8qeuiAPFIojC6AW5xGakGgzjkAD
LIqvpca1vjF77Z7LrEojt6eMO+yUTV+XmppzJIObOlRY7G6a+YhvKlnXmwp1ArHo
gs81fJ+vs4VtX/Fwhfi79VL4kV6EcSZnsQm2QS0kGaz8f9oVqTrXA3WPzWvhGYbt
PCP2nrZTRGvfRj4ZlyNj4GZiNtv/vLAuaE2VSOYMy/FsHUOPPaf50OuiNbeYv0Ih
zNIhpwuPp+1P4Bijdv2pBYzyz00cj84DqY4PUHQnCA2Wnr+UUnWWG37pXDM5Y4bI
nbNbbjKdkgvAjLngipgYTLI+nbwvn3ZfY8anmaofqFfbWQ8B7ws=
=N14l
-----END PGP SIGNATURE-----

--DY/6G/q62rYIjJ5v--
