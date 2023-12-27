Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E9B46B89
	for <git@vger.kernel.org>; Wed, 27 Dec 2023 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mlN/GA2h"
Received: from tapette.crustytoothpaste.net (184-074-143-030.biz.spectrum.com [184.74.143.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 191B75B171;
	Wed, 27 Dec 2023 17:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1703699271;
	bh=H2bxVf3wbexgny4vW1u+AoJb90jUUTVggvQvzfMefL4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=mlN/GA2hltw3pzUuoCo1diwgJg0EaSHODLBAxunrAcUCUi5N3SC1PuKnyU3/HwRiJ
	 uQgvgc7npooRFiemnsG/9YRuEVacZ3bY6tzRet9vA29Ggz5m85zPXd5IEaRGs6qz3e
	 hTkKOtLPFSLu9HmK8b2XF1ZcoXxX4ikKS8tPhQEiE83GZsD8z+jTX0b5EnRgk/lr5g
	 ajMhOkpYszEPsCpH7Id5Qi9KplJZg55zNe21NOS4PAQqF+Ipo4Sna1aH2cf/AkLcWg
	 elNusKpboLZApC6XkThd/p1Rb3GwBTS/6DZCxJtIEXO7yG7Vf9A6NHhMwSQsthV8ZJ
	 WlQA8o5hakIVAXlB54Z2EFCiMoUCwg+7JLe0+PN/Uk+kiGRfuuRiRDGgWyjoU76MaP
	 cagiEiOkxY5f8pT9Lg8pDb7LYhCUvb/NDCLuEql7XibinpaELeCgg3RdEv9p49MkWI
	 xqCJOifYd/+jwl+/R8TkR9Zq5ff7jJx0RMg7dVkhAOK3UuKYPlE
Date: Wed, 27 Dec 2023 17:47:49 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Brian Hart <brian.hart@xylogix.net>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Suppress 'info: please complete authentication in browser'
Message-ID: <ZYxjRZe9fCk909OJ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Brian Hart <brian.hart@xylogix.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <1858825158.1864122.1703697091856@mailbusiness.ionos.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sR/F/AmWgNcwzL1q"
Content-Disposition: inline
In-Reply-To: <1858825158.1864122.1703697091856@mailbusiness.ionos.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--sR/F/AmWgNcwzL1q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-12-27 at 17:11:31, Brian Hart wrote:
> Hello,

Hey,

> Here is the .sh script I am using, e.g., to do a pull on each directory i=
n a root directory:
>=20
> ```
> git config --global user.email "XXXXX" --replace-all; git config --global=
 user.name "XXXXXX" --replace-all; git config --global credential.helper wi=
ncred --replace-all; for d in */; do cd $d; echo Processing repository in "=
${d%/}"...; git config credential.helper wincred; git remote update; git pu=
ll --all -v --no-rebase; git add --renormalize .; cd ..; done
> ```

If your goal is to use a specific configuration, you may find it easier
to use the GIT_CONFIG_GLOBAL environment variable to set a custom global
configuration file and then GIT_CONFIG_NOSYSTEM=3D1 to unset the system
configuration from being used.  My guess is that there's a
`credential.helper=3Dmanager` setting in some config file, which you'd be
able to see with `git config -l --show-origin`, and that using this
configuration would fix that.

However, if you see this problem after that, I'd recommend contacting
the Git for Windows team on their issue tracker at
https://github.com/git-for-windows/git/issues/ or the Git Credential
Manager Core team at
https://github.com/git-ecosystem/git-credential-manager/issues/.  The
Git project itself doesn't distribute any binaries or anything but the
core Git code itself, so if you have a problem with Git for Windows or
Git Credential Manager Core, you should contact those folks directly.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--sR/F/AmWgNcwzL1q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZYxjRAAKCRB8DEliiIei
gWdOAQDqP1gNshurBUez/05hZJChXsgGeeEeGXETwkKX9RmTdgD/eiZnY/mJeELC
4dfsrwS02t5T3okqzmWGIi/z0nv4Awc=
=AZv+
-----END PGP SIGNATURE-----

--sR/F/AmWgNcwzL1q--
