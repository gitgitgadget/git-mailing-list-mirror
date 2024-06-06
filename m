Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BF23D56D
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655428; cv=none; b=qEFbahN5S1ko5SM4EWeh/uXRy2r/dZAyXpjosSTvtQ1GE3cZiaYEx9b9cQZJcpPKxw2am7sNUYQPLjMHrYgXd6GU1jHG4m1QpduG3y/Bwx2ls57M4j5ribyK7KTwC/c8WEv23tnAOsRHKOGx7IfQuPfIHEkCwFlg7b9V0o4gZfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655428; c=relaxed/simple;
	bh=jvfyN3OUvnI6NDuO1jlVBiwIJep6w4pr/edHdjKc5ok=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WraBpZZ8czLuUVPx5y/dQKbMygZuwzOq8RchNZhGSV7UkMZipkvtU6AYm7FsCFjeJNsS0rEZm9/bKI0YfA5iNzg5Sx0L9riUVd77OZxu/h/92sX4in/1JOShHt8A/DWd2ePlj7l1FEkg1rOJViGp91CgUZTzqJYEpw7ftpyEhiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hzz1GwUU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g9UaJ0i6; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hzz1GwUU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9UaJ0i6"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id A670A138011F;
	Thu,  6 Jun 2024 02:30:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 06 Jun 2024 02:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1717655425; x=1717741825; bh=NtLnwGVOZt0nzCVfATevpK7oxFkZdWfN
	GVnIJcYCsFk=; b=hzz1GwUUEwtGtX5wXejBwVD+THc4Unqnze14bClN5H2MPd4J
	NjeyeTrSca2VBM4NuQWL9zoMy4Y0jia5jp/gxce/gIiEHXp8TAi1g5Ducakh722J
	EjOJAguf+BVEUNqs34SFaK5E8lVTln4WNn0OELrwQpj/mWk99ynWsU0dHoO69/zl
	O5D1P4xRpDuxvVg6b93xa8ZLHx5rv5MdwUQzqVuPF7orULsGMFpfcw4nTXzbve4F
	7yf9vfpNayKq+Dx1Dgkjf2oylVjEC3qfLgDBzExXq6/X6YsFgedQaQMVYF5+SmQ2
	gZI+wXOXvDvTmPRerTsTA2dHLb35TNuT6pTthg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1717655425; x=1717741825; bh=NtLnwGVOZt0nzCVfATevpK7oxFkZdWfNGVn
	IJcYCsFk=; b=g9UaJ0i6y2ZtZ+e1kpNRbd4TIl9BmN2ERUlBOdnnIgpgjVmCnyi
	CEs4qjebcc+5D0gOkluwOrU8XzkUNzD02bK+jK/BRnqXlVpl2HdivNexUmmkWUE4
	v48bwUMY7eRBEH5rffJ1tek7N1fIx8OT1wHtUG+AwIdb01t2MFhi/rM6zPSOrPNU
	8wy/Pnu9LdoMsVIZwu6x7ZIGV0gN3ii+65dMSyx+0BAr9iBbNmHV+84gMk1korCt
	plTxhJev9Grku9z7p+5wKa8tWSCpVT2X+5dBTP+4aqUi1CvEcKgvskaAaV5tEs/l
	1SXOgKXrmMZsa4s32EjRKHNCMx7jCRJPBGg==
X-ME-Sender: <xms:gVdhZr2GMT5wAPwCw9E-Bba4IncWTruw9wuzLQ83RL4EiAND80DIYg>
    <xme:gVdhZqFIVl4Z9DmL1lR06hah7flJWDBrm78vKsYiIctBeOzSMaPKLbgpCP_RI5ked
    bajDwic8Lt-fnR6-Q>
X-ME-Received: <xmr:gVdhZr7qyTlry2GeJBRxXldaZOXD0OoijzoSiNPJzu7MnkZNjDDgzZ9u5qxZ2tzPqKq_kioYNviV2tDxqVZ66xd0X2ogByME6ImyLJqHzNyvWmwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepuefguedtueeiheetleevgedujeekjeehle
    ejjefhhffghfevgfekueekjedtieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:gVdhZg0T63OdVs4dLC1hhf0oIHMwGzDdf2tXZn7qyhuPSNlfM0Po5A>
    <xmx:gVdhZuGOdKCVvDVpRKw8nfYnP7t6zFnrp1vr7mQcxNLzMe4R2ge1zQ>
    <xmx:gVdhZh-YUWDgev8aEdFd_ITOqGDcqtfNXw4CSQDhKcfY-UbCI4l0AA>
    <xmx:gVdhZrkwm-J9fUtx6_R2pcnGSpWwShiP6QP2ZPfI9E7pUUlO4xC4Bg>
    <xmx:gVdhZqBCIzsBwm2JcmsWjR2NeUKpS_e91qnThoOitQpdMYWRRPzmtpKu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 02:30:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id adfde936 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 06:29:51 +0000 (UTC)
Date: Thu, 6 Jun 2024 08:30:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] ci: detect more warnings via `-Og`
Message-ID: <cover.1717655210.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8J+HofWnkWD2H1ai"
Content-Disposition: inline


--8J+HofWnkWD2H1ai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series is triggered by the thread at [1], where Peff noted a
potentially-uninitialized variable. In theory, GCC is able to diagnose
such issues via `-Wmaybe-uninitialized`. But in practice, this warning
is dependent on the optimization level used by GCC, where the issue in
the thread is only noticed when compiling with `-Og`.

The first patch is just a small fix to our CI I found while at it. The
second patch adapts our "pedantic" job to compile with `-Og` so that we
overall surface more issues. This would've catched the issue.

Patrick

[1]: <20240605100728.GA3440281@coredump.intra.peff.net>

Patrick Steinhardt (2):
  ci: fix check for Ubuntu 20.04
  ci: let pedantic job compile with -Og

 ci/lib.sh                 | 2 +-
 ci/run-build-and-tests.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

--=20
2.45.2.409.g7b0defb391.dirty


--8J+HofWnkWD2H1ai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhV3oACgkQVbJhu7ck
PpSnKhAAlDoZjusqY3ke5dYZVoSpP+TiyKuK3O0hwhTocfFf2pdwruWIClVsnQOu
/Aav0rMf2UjIVFZayEiew939joaQApTdaAWZee8OFsgo59vxHBVFkjB+5icQISco
4Lk+wTixePznlmekUy9GQHB9pQ7G6DcjYPXedH2kDffHVJ+qFfaJrAhbrsGR16OX
IOx+GE49Si608zvv7ua0Tc2MhbOzMpnfJQJzpRqUQ/Ixi8CAbMYiTnGtYtXiJoxC
YnENZQMm0B6nOegvHGmunzKsfwXgO0idXWcac/RhFxmrfHThFeHKY0hIg3zLvyDT
Ge9U2eNZnRmPEN3v+7pDjCio6NjjvFmU1yBdAvmpBPAPqMgNgAYvck1B5bRAmQ4n
WUIFmmdnJCDB+mAkNEcJoXe4DWzy4kghr1ksXagv36/FexY+LBkEEVZ6S+bpi5cg
avj3VAvHuWzLoff3mj7pG0d11epeaZcvloixCh1dtemKPYNZvzib3b/6eUbOJyHq
Gj7v2sBohb7EBQwBfBMot/wMDzDk29N9DzpXub/EpzMKaOTLon4lpuBiwvm5SIe9
erc2oBHGYRFPQB/uh+eAxQ/Zbg8/gY2KJfWS3r92gWP5wJCZsh0qkn/quoMCUChT
ukzdUduvTBESr5DhEN0BKcivphPJu6mtWbknbpEwh4EsrFZPPSc=
=L97q
-----END PGP SIGNATURE-----

--8J+HofWnkWD2H1ai--
