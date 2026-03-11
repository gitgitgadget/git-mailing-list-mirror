Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1EF175A73
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773263738; cv=none; b=VkWN/daz2FzdOS+aRBL33pPTHwf2kwjBX0Iz9GNzmdmnwhm1vSViZs3FhKiI+fQkt1eHjFDI4p4DoJ7hyh4ROetm6xNAnLqkDWjj31/4tHUxmW7E5VvjyV8MS7HMecLIKYIOKvMom1Fwn1qAdN48nT9AozEErCDP5e0dl4cm5x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773263738; c=relaxed/simple;
	bh=A19PflewUnzcaqqlyDEdNtSZdaE9gYtm7j935zyEDp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeQEE5xna0Za6hWejGaALkbxoiT5LAdrx9j1+QxHHxOE6plq69t3xRWDlV12hCADw3siG9BJPqXUqsTOQoYNGDdDupcunLyrM4ngSMbOll2O0rWKZvSRLQnMGJOraDyMwPwv+CX7Xg5VbwZ3VUehK+AS+yCJA1fX0uQw6kbmLqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=AMXR+tL1; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AMXR+tL1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1773263735;
	bh=A19PflewUnzcaqqlyDEdNtSZdaE9gYtm7j935zyEDp4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=AMXR+tL1pfAgHy2GBkQfjUgV6KEHraVgoayvsHXYnPHyVokwo/C0HVw+fkW5v9xOY
	 g8l0jf8d/doE/lzYheCmkYI92tgbhD1jniS9NG16vwYixar4JbbE2Hnv9BiBoPozJI
	 IrTH08nBwJXO+8PWwEQTrsIvuOSX/32R4EZxIAezB5R9l1iKPdl1/sXu+w0GpiD3w+
	 8uhbb9j1LoTV/dSMLVpbMR4DMaAo2g+jKEx4ai4xnQV8FQys1dPKJ37aGfGYQlFOv3
	 2mr0s9ZQTeCykBEnSYvhNkKZIrr66doS2ynoZI7xMfdl6UXqSVi7lYxEKJqSi/h2mC
	 /1Q2NGKWoiPfETypegMgwmFkL33jFv41D1sjsqgNfK1uFCjKrAYLZYfdjwQAS/uDrC
	 rPejOxlWY+7BQup2rfCtvOFP6UYsVye6XJ7irNtjj87Xu1raHVke2rg/gqWGGdvDts
	 1wg64rFqyoI+h2LqKCmfuMA3lLwtzc9tBKdJzxCoiu1DJIJRAot
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:1cc6:4e25:b9fd:13bc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1A93B20107;
	Wed, 11 Mar 2026 21:15:35 +0000 (UTC)
Date: Wed, 11 Mar 2026 21:15:33 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Andrew Au <cshung@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/1] Fix zombie children when git is PID 1 in containers
Message-ID: <abHbddcYKpW4hlMz@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Andrew Au <cshung@gmail.com>, git@vger.kernel.org
References: <20260223165147.3294516-1-cshung@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1sbu88hB8a2JKVny"
Content-Disposition: inline
In-Reply-To: <20260223165147.3294516-1-cshung@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--1sbu88hB8a2JKVny
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-02-23 at 16:51:46, Andrew Au wrote:
> When git runs as PID 1 inside a container and exits via exit(128) on
> transport errors, child processes (git-remote-https, ssh, proxy) are
> never waited on because the normal cleanup paths (disconnect_helper,
> finish_connect) are bypassed. Since PID 1 has no parent to reap its
> children, these become zombies that persist for the container's lifetime.
>=20
> This patch registers atexit handlers in transport-helper.c and connect.c
> to ensure children are reaped on any exit path, and clears them on the
> normal cleanup paths to avoid double-waiting.
>=20
> Blog post with detailed investigation: https://cshung.github.io/posts/zom=
bie-git/

Usually people use a tool like tini as PID 1 in containers, which allows
that process to handle process reaping while still exec'ing the normal
Git or other command.  It's the case that _most_ processes are not
designed to run properly as process 1 in a container or otherwise, so
a specialized init-capable helper program is usually a good idea.

Even with this series to fix some of the process reaping problems, I
expect you'll find other cases in Git where we don't always reap
processes correctly as well, so an init helper would still be useful.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--1sbu88hB8a2JKVny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.9 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCabHbdQAKCRB8DEliiIei
gefrAP9sQe5M/e2TpbxMMpCzT3oAuOuQRMu5QSO0HB+1pFu/QAD/ZuoimEujSuN6
6EBNkSedPGkRmqDwGCL3dLJJuaHcRQs=
=jCbe
-----END PGP SIGNATURE-----

--1sbu88hB8a2JKVny--
