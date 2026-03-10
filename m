Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C004E140E5F
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773183067; cv=none; b=IFnDGQm9rekXmO3mWGlcRhdMuGfPnbr8J3go0eCvzzcjoSJfjoX1qcxqas5cYz1oNDcIO9Q7P7LqPa11TfvjzCTupiCmbgp289gwJjlKPFc/wTdH3Om0Q+dKvprsOoH6VRxPEKaPrQ6YWaHOCNISC0MMeeVqddfuMVVRmF+RHQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773183067; c=relaxed/simple;
	bh=nbGqdwUNNUnAEe0eX/RSv+Se6TdZHSyrn8y0bBBzzaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvOoSzn2jl9aWsqeSwiFxE6YoCKSq/1eXFPWZeKwJgZA+RYWdK3SRUw1D0fMA1+AVL6Ko8r/cyoVdRdPoKvogyI9radQ4m2iSJZtUH1X+J12oXIq5UyVZJ+6JEGhGw+Xrfug48uwDdNyyn/scG4axqFtasRVEBPm+3RobNH+Ndo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=eDAbKkbP; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="eDAbKkbP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1773183059;
	bh=nbGqdwUNNUnAEe0eX/RSv+Se6TdZHSyrn8y0bBBzzaU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=eDAbKkbPAITgxeaQ+BpcA6bOYv86W44Oc3HpxLk17epU72JcAQy2bvTsEXVjCTpQO
	 ET6Em3SG1e6UuOLz1n7Qqo6upGJDMNlmbSWjxZbnsyqFx+fG17dWLUh2lQaxPQBA6c
	 BihoNtW7/LGfc5oESDAJyfI5TtDBwJQR5bZ9jSQsiRkJhUhBZtJf8BmVl/zoE5AgyB
	 saMV5hulCNX9A2ffoG9U/TLcIBbVqzOCuPcZyhgYq8ptogneyUntJ8lKeG+hK/c1HD
	 MDgq/RnMl+m+HvfdE8QDyN2Njg2ybJnRNmOlOBPnyUI811nhujrfYbsf/FHLUvui35
	 buTyStvE+1NCw3hwSSIVLqyJ1z310w1vje3HyXwIvRvL5kvZKpgoabNsJ33YlD/du7
	 qfQhlAFO9qZw31SU7Cm6VtoIEedTI02iFxFQxpgKBA7S7Fx0Dqvca9MNcY4otyw5jF
	 DjjNPXHYh05IYqCayCJ6i6Daj1R1i2kdJXG3GB0MK/f2mNI5+ZP
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:676e:74a9:1de6:9151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id ABB7720107;
	Tue, 10 Mar 2026 22:50:59 +0000 (UTC)
Date: Tue, 10 Mar 2026 22:50:58 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "R. Diez" <rdiez-2006@rd10.de>
Cc: git@vger.kernel.org
Subject: Re: git-fetch takes forever on a slow network link. Can parallel
 mode help?
Message-ID: <abCgUu3ZFSOIZwKu@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"R. Diez" <rdiez-2006@rd10.de>, git@vger.kernel.org
References: <5c7c975e-2541-47e1-b789-fee1fdb77d2a@rd10.de>
 <aas--JZ-CCWN-o7O@fruit.crustytoothpaste.net>
 <1d6a8eec-20b3-4d6e-83f1-d18b7a3c0145@rd10.de>
 <aazUlMBj_IK41Ss2@fruit.crustytoothpaste.net>
 <0ebf757b-eab5-424a-a58b-e654b1a2942e@rd10.de>
 <aa39obsSbk9R1mqu@fruit.crustytoothpaste.net>
 <3ed2d803-5df9-44f4-9427-958d28aa1c46@rd10.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="81Dk8xChUhFQLEIK"
Content-Disposition: inline
In-Reply-To: <3ed2d803-5df9-44f4-9427-958d28aa1c46@rd10.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--81Dk8xChUhFQLEIK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-09 at 21:08:31, R. Diez wrote:
> There is one more thing I am curious about. Git does not document how it =
uses SSH (or at least I couldn't find it in the standard end-user documenta=
tion). Git cannot launch a process on the target host over SSH, unless Git =
is already installed on the remote system. After all, the local system may =
have a different architecture (like AMD vs ARM), so you cannot copy a binar=
y across. And I haven't seen the requirement that Git must be installed on =
the remote host when connecting over SSH. In that case, I would have probab=
ly seen somewhere a version compatibility table between client and server.
>=20
> So Git must be accessing files over SSH using the standard SSH file trans=
fer operations. I am guessing that the same latency problem will apply here=
 too, because uploads and downloads over SSH will also be sequential. Is my=
 reasoning correct?

Git doesn't use standard SSH file transfer operations.  That would be
much slower and it also works poorly when the remote side doesn't grant
access to a file system, such as with a forge or gitolite.

SSH allows multiple commands to be run over a single connection with
`-oControlMaster`, which can improve performance.  The benefit to
running a single command for each Git operation is that we can do
authentication once at the beginning of each command, whereas if we have
a long-running SSH connection and attempt to do SFTP, we might
interleave requests on different repositories, so each request would
have to perform authentication.  That's not a problem if you're using
Unix permissions to control access, but it scales really poorly when
your Git data is actually spread across many different file servers and
the user is accessing multiple repositories, such as is common on
forges.

Using SSH file transfer operations also would not work well because you
would effectively have to download every pack file and loose object to
be sure you got the data you need, instead of getting a pack with only a
few objects if that's all you need.

However, you can of course mount a remote file system as SFTP with
`sshfs` and use it as a local file system if you actually have a real
file system on the remote side.  That will send multiple requests over
the connection when reading or writing since the `sshfs` does queue
those.

> Or does Git attempt to find out whether there is a Git on the other side?=
 What happens if there isn't then?

Git invokes git-upload-pack on the remote side and talks to it over
standard input and output.  If there isn't one, then the operation
fails.

Here's an example:

----
% GIT_TRACE=3D1 git ls-remote git@github.com:git/git.git
22:41:36.731673 git.c:502               trace: built-in: git ls-remote git@=
github.com:git/git.git
22:41:36.731937 run-command.c:673       trace: run_command: unset GIT_PREFI=
X; GIT_PROTOCOL=3Dversion=3D2 ssh -o SendEnv=3DGIT_PROTOCOL git@github.com =
'git-upload-pack '\''git/git.git'\'''
22:41:36.731952 run-command.c:765       trace: start_command: /usr/bin/ssh =
-o SendEnv=3DGIT_PROTOCOL git@github.com 'git-upload-pack '\''git/git.git'\=
'''
----

I don't have any systems without Git on them, so I can't demonstrate the
failure case.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--81Dk8xChUhFQLEIK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.9 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCabCgUQAKCRB8DEliiIei
gY0WAQDdMh4gDo+xohqrSxslPRAp6bstv21z6YxrNqQfkauivQD9EJMT/d5sxcBt
L+AMdKMuAmP3qe1PS9hJjpubSKKzjwI=
=Y/12
-----END PGP SIGNATURE-----

--81Dk8xChUhFQLEIK--
