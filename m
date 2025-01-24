Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C95E15CD41
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737750871; cv=none; b=dpuLC96ErEdAYqBjVSRY1EzG1oVm4UD26OdcHmqWxeHL3tMgjQraRoh91vWp4PvulNgIKON1rI6F0GQJ8IRkm7NdnUvQ6TGb4alwDFIBMKgxaOt/H8BY2Ehue77xCJmi356qow6NqKghy6KIq2X38BhrWJvLqYa02kz0W5JUHLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737750871; c=relaxed/simple;
	bh=vSJGI4Hinr/+9x8VkgM0B5+wIranjkR+5o9am35WlC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iR5IDWEk7QM01XzoMsVmy0Z0f4Uxe51dIP7kspdo9KTGWdLp6wOPqB7XvAqv5LziTzVeMwU+onEZMLrJr1ae1vOj4W2A0b8KpHMbNdoKjAtZptQTbt3twb8FtfqyEST58CzfKepjn3NTu5wDIOYBj/vIyZGu8tE8jNPIfnbC/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=J3oD2BwP; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="J3oD2BwP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1737750861;
	bh=vSJGI4Hinr/+9x8VkgM0B5+wIranjkR+5o9am35WlC4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=J3oD2BwP6KLe+0p2ayM5fgPf8bZ2diX+TlJFKVTwpuQlq2kTFZtDTsU4E4/oJFljp
	 ujFaNaJsFikgF1CiGdFilakxOHkGsN6abJVsiJ8Sw1RVWQW06uTANj5K5KS6gwXMiX
	 GQYZBfaGN2Fv9Ro+LdxU0HJmACR6sNR5Ke2/75s7xTsP6VuspTOwWEWoU4N2L0Ts1V
	 7EKme3d4QUN7pQx4lnhbPLw1XP7+d+u/csQ1XM2GwNiS7+eIGJthmRIooKzm2O5Dfr
	 DFd2z05+Wzhn5MRiS6feM+KTvLXjQXfzJwfq+g1V9z9B+g7hjrnypElis1VIcYqIKu
	 mjtIEThdjJd9X8ztSl4jzdDXa8KLBArFyjfpuxBknDPSHkOwyEQJIY2qWW4Y85ROHu
	 sBHPixqTc4EdxWfI0gaD7MlWfdYn9rJTJ8YSrW/RY6mndGQ2J4OMUQB3NP0nl0okM2
	 C5iBcSwIhiX+MkMFNK9hpmI/LQBGlPg8wQv8SFYyEU1egJUOJcH
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4223720033;
	Fri, 24 Jan 2025 20:34:21 +0000 (UTC)
Date: Fri, 24 Jan 2025 20:34:19 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Perez-Lopez =?utf-8?B?w4Fyb24=?= Ricardo <perez.aron@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug report: parallel fetch tries to unlock SSH keys over and
 over again
Message-ID: <Z5P5SwsMC_DKjp5O@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Perez-Lopez =?utf-8?B?w4Fyb24=?= Ricardo <perez.aron@gmail.com>,
	git@vger.kernel.org
References: <CAL_k5jZkYG0evQ2L+bCNvPAnePj=WdU-36GujfjRDwm3iX8ynQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MpPWSoetVr2ssJYO"
Content-Disposition: inline
In-Reply-To: <CAL_k5jZkYG0evQ2L+bCNvPAnePj=WdU-36GujfjRDwm3iX8ynQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--MpPWSoetVr2ssJYO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-24 at 19:46:58, Perez-Lopez =C3=81ron Ricardo wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> git fetch --all --tags --prune --jobs=3D10
>=20
> What did you expect to happen? (Expected behavior)
> Being asked for the password of my SSH key, then git updating all of
> the remotes.
>=20
> What happened instead? (Actual behavior)
> I get asked for my SSH key many times over, and the fetch does not succee=
d.
>=20
> What's different between what you expected and what actually happened?
> I should only be asked to unlock my SSH key once. All fetch jobs
> should wait for this and then use the unlocked (cached) key.
>=20
> Anything else you want to add:
> If I do just `git fetch` and unlock my key (once), it does get added
> to the SSH agent properly, and afterwards I can execute the command
> above with no issues.

While this would be nice, Git doesn't actually prompt your for your SSH
passphrase, so it has no knowledge as to whether a passphrase is needed
or not.  This is usually done either by your SSH client (such as
OpenSSH), or by some tool which functions as an SSH agent (such as a
system keychain).

Git, in fact, couldn't even just query the agent to see if the key is
there because it's possible in some cases to make the agent require a
password for every usage or after a certain amount of time, so even if
the agent has the key, that doesn't mean that it is or isn't accessible
without a password.

The only way that Git does anything related to the password is to pass
the appropriate file descriptors to the SSH process so that the SSH
client can prompt on the terminal if it so chooses.  So regretfully,
there's no change we can make in Git that will address this in a useful
and general way.  As a workaround, you can explicitly add your SSH key
to the agent, or you can use something like a password manager as your
agent (I use 1Password, but there are others) that will prompt you only
once for all uses, which will avoid the competing prompts.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--MpPWSoetVr2ssJYO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ5P5SwAKCRB8DEliiIei
gYx9AQCvB/DWUtFMtWyBhTgOupXyc9zcWJqxLmlgRZ73FrwwDwD/RjRCIjh4RPMA
TKaXecSyxDG5Ry7AahqOL+fVBwV55AA=
=FMmd
-----END PGP SIGNATURE-----

--MpPWSoetVr2ssJYO--
