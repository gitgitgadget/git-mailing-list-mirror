Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738B926461F
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 22:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776723081; cv=none; b=HhOIETywSTc6VdhWBREKe/KaHlOoxoOA3HDrc3eW86w9bEIKltL2iN3pjFq/gvNK/NZOa4WhC6gjN4cPRR6uSdlwG+/AzqSjsqZng5F3P4C6T/0I+5IBTRFtOyJcEfi23xsNqkqfJGYu/VJeqcakg8DNW1iFeXi4LQ3lvqniE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776723081; c=relaxed/simple;
	bh=tjKhm5J4GQuP7zsuAue1bkRlnX64DqIZJPWfsHQd2lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kh95623EwVVctGik1w+jibEL5I14JunnJNaS+qyktj+AGRt3cf9uyrwO4Qbeh/A1vNzcmXqjzRenlyx3h2Li6zfgjYYyJ8HpNnhhIB6fCWst4FhVhCPaPgIFPhrjrE0UsPMBjGLRLAIiMSktLJgvItdy489RF0v2b6seEvEuK18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=XeLMQej3; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XeLMQej3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1776723072;
	bh=tjKhm5J4GQuP7zsuAue1bkRlnX64DqIZJPWfsHQd2lk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=XeLMQej3Lfj3LpkXbkdjG5vs6axHu/kiawY/hCk0g/LlaEPxULjvZLY4W0YKyCcEv
	 CUk6yPvbni2mFNubPx7RZwhxp1OBa47YXHBB7qp+W2b4+G7Yhsy+QnxWDsYWQr5TBb
	 C3caffoUUVjJ3gWo3xMVfCL7V9M9Vj24gaFadSAjirjxMZS/I90o89FU+jnfovbf5a
	 WqYAHrNv6xpC8GvGUgT5rahT1SX7edL0gS6cJ5W3SRr2e9HiYtSsAomRsww1JRxkl3
	 6HhRAJacab3qBdUbqBD/s6PMq8V+TEQFBRkpO8LYTqIOkvlj3j0MiFytLUFfzFqbcZ
	 JtGk0vhEC0DDLh2PwjbnJ378vabtEKS3AuvlYVzQiWzSTpuPZOpYCryvQ+vz4KdwcT
	 H1G0hG2yFo/k1fQq6VODdJyfvLRxFXuTAJ5VOTytuI6wsfe7kJM94UZ45tevn650uF
	 vl2HUY595onMmELIR7RUbrTroJ26GFZxYvF0Y0AhN7T2AgpokrI
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:57bc:7ea2:ca35:d24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6CB8B200FF;
	Mon, 20 Apr 2026 22:11:12 +0000 (UTC)
Date: Mon, 20 Apr 2026 22:11:11 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kushal Das <kushal@sunet.se>
Cc: git@vger.kernel.org
Subject: Re: [BUG] v2.45+: git commit -S invalidates signature for non-UTF-8
 messages
Message-ID: <aeakf0xcjSteTMZp@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kushal Das <kushal@sunet.se>, git@vger.kernel.org
References: <4d5d04e2-49c4-4781-a289-f8cf79570643@sunet.se>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wdKFShtsPpJQ4jWS"
Content-Disposition: inline
In-Reply-To: <4d5d04e2-49c4-4781-a289-f8cf79570643@sunet.se>
User-Agent: Mutt/2.2.13 (2024-03-09)


--wdKFShtsPpJQ4jWS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-04-20 at 08:59:05, Kushal Das wrote:
> Hi all,
>=20
> Every `git commit -S` since v2.45.0 produces a permanently-BAD
> signature when the commit message contains bytes that are not valid
> UTF-8 AND `i18n.commitEncoding` is unset (i.e. the default case).
> Verification fails under both `gpg --verify` and any non-GnuPG signer.
> The failure is deterministic: it happens every time, on every
> non-UTF-8 commit, no card or external tooling needed.

I'm not sure that's a valid configuration.  The commit message either
needs to be UTF-8 or you need to declare the encoding so Git can convert
it.

> My best guess is commit 6206089cbd0b1cb30a017ec904567f040ab4cea0 starting
> this (and I am maybe 100% wrong in identifying the cause).

It does bisect to that commit.  I wrote that patch originally, but it
got modified and sent upstream by someone else.  I'm not sure where it
got introduced, though.

> In pre-6206089cbd `commit_tree_extended`, `verify_utf8(&buffer)` ran
> BEFORE `sign_with_header(&buffer, sign_commit)`. `verify_utf8` is not
> a simple validator -- it mutates the strbuf in place, replacing
> invalid-UTF-8 bytes with their Latin-1 -> UTF-8 two-byte form. The
> signer therefore saw the transcoded bytes, and the same transcoded
> bytes were then written to the object database. Signer and
> verifier agreed.

The fact that we have a function called `verify_utf8` that does more
than verify is a problem.  I'll send out a two-patch series in a minute
or two that first fixes that to be called `ensure_utf8` and then fixes
the issue.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--wdKFShtsPpJQ4jWS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmnmpH8JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ9ba7+A+5k+ZJn1vqeDNw8niHoIAS98cPnTvrjLvi+PR
FiEECCzmip28ZfuD0cORfAxJYoiHooEAACqCAP9J2CJjAlyevv7ahO3k9mFnkd/x
j4vsI0TT7fdHLuE5zAD/ZtFVXpDm5ie+9P6smgE0jbjCLWt0FS6Lgm2upD4tcwU=
=qMGH
-----END PGP SIGNATURE-----

--wdKFShtsPpJQ4jWS--
