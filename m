Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4055E1AADF
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544992; cv=none; b=phpll8/WOWqoKsJ3+ASBYYdDMyWbCp/qubuVhlObpM2Ec5HZBWYWtne/UchTUtNjFGSMXIg2GxmCek46SJdaQBIdbQyu/K3Xjrp8IGwvVDNeZudFgp0tirRAT7iFFeSTVSEnveE0XPtQ6SM1da0WpXV9vEJPCMCIUozzsaUt2KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544992; c=relaxed/simple;
	bh=1VALZZxgnqXwAOpp4I7snS7GxfjjR828WelOj7dP/D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aa+KQSEsVQR4YrmRIbRt2M5xIAlJ0fJMi60HgHC1bSSfxJZGMl6VmYlYrCJd8YtzTBKpDgr9/RjOJEn1XK9P4gG9RE0cJmxPguD+LsIqHvGD66bHeMeglb+K7yL+ZRth0NgTJS76Hc44pa+1cU54tPjv6vCHoCfOKllz2LarbJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DiBdGSTQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OR7oQdrE; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DiBdGSTQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OR7oQdrE"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 46B1613800A1;
	Mon,  4 Mar 2024 04:36:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 04 Mar 2024 04:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709544989; x=1709631389; bh=1KGRf2W1FZ
	DN0YF6ABqMSXvXMQTNVxIAN2oMoqZnIBU=; b=DiBdGSTQhJrNQEeQemC5vlZ37I
	IcYPLp/Fhugw7pLB22hTHhInni2tmS7wrAHQ20zaQhvrcUC9WoY7IGRIW09cKCWr
	oo94BBR7sK4uCZVan/XACQTzJ7IGC4IwPjEKQVgPLzdIu0/0/8R9rjo+Ngnum8tk
	yIGS05a9x4AMZWbqD6dq/gQBCxbgiIrH19Zizad1UvR6sWI5yLHq+pg4pdBnnNRf
	gjlRLaDEZgBpHkwpcaoDSMVV8glZYih6R7BK08rWyWQ5g25MvS4gZsFyQTWf5OWv
	CiY7YzYZ1JPBExDp/r/uG5KCFQa/iQyCjZfZi/oG7fEdgV6yAXRk8IvcQT3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709544989; x=1709631389; bh=1KGRf2W1FZDN0YF6ABqMSXvXMQTN
	VxIAN2oMoqZnIBU=; b=OR7oQdrEtcbJAJ5MvByi/Ue8Uq3Uii41n/ZwlrfuNXv/
	gfItNqDlhpuun7c0mfp8gTZhY1NsBJSNsbDKCo2+CgeuL9Imdh3zFmlQnIAzDz3c
	fgVOIb9zuYWFn1q3MrcDUvdXZqcyvuZkH54EcwDg63yB6LxZEO/g9BHnF30pvQGh
	QZY4cxgWJFTzfULk3SrScpAYk3MiVVI2tby/bczrcRZ1da4uMGUQvlxLyWNYaPRo
	esDMY3/xT1GVNny7leZL9+hMSbDjQangYGbSLLsjCcTNmltSURC+fIyfWXLsR4gS
	LYHejNv42S/ZJxUxfuNVU8p5ed/oraPrNR1Z5JvycQ==
X-ME-Sender: <xms:HZblZQImq7gVdd_G4lSW_n_TlrS5XSlXEnb81A2IwPIfja2vAfgNwQ>
    <xme:HZblZQIX03JRXDugnMgWglLlrKDpTefrMlMTSJ0B_nvyieyDFBXWjMViiUbF7K_rU
    0l-ri1VsdrSOqkbQg>
X-ME-Received: <xmr:HZblZQvwxHOaPkju8OEMmxpUy0waVEIX8R-WUVdbuon-d38MBEi34c5PzAi9nV6tchIpGeZ7m47uxH2k1qIYSqXW5QeGRXMgt186KxebGvS2Q08>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeejfeeuueetiefhffeigeeiuefhtefguefgjeelffelhedvfeejjeehueefffeiteen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:HZblZdaCi1MmSnNlwHjDJuyh7BWU54ey7nkq2XyiirILl6G0poImQA>
    <xmx:HZblZXa9fldwrmd7zYcvNGR-9a4l1PVgA-1TN6E5jzrq4VtmCzVxCw>
    <xmx:HZblZZBL3ZzvvCanRQ6c5mgkqTinWj4_6uEL6czt1Tf0yJvOmtDU6w>
    <xmx:HZblZTGT7etQqAViubvkUE6MSmLQ_azKwb-W7KFeu2JDhl3hJSMZIQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 04:36:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b2c431cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 09:32:03 +0000 (UTC)
Date: Mon, 4 Mar 2024 10:36:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: W Sero via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, W Sero <sane0r@outlook.com>
Subject: Re: [PATCH] Fix  git-p4 decode() missing an assignment
Message-ID: <ZeWWGrbskLJHrQZL@tanuki>
References: <pull.1683.git.git.1709542455728.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OVBvJtfo5jx49086"
Content-Disposition: inline
In-Reply-To: <pull.1683.git.git.1709542455728.gitgitgadget@gmail.com>


--OVBvJtfo5jx49086
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 08:54:15AM +0000, W Sero via GitGitGadget wrote:
> From: SaNeOr <sane0r@outlook.com>
>=20
> bugfix: When using git-p4 in the python2 environment,
> some places decode() missing an assignment.
>=20
> Signed-off-by: W Sero <sane0r@outlook.com>
> ---
>     Fix git-p4 decode_path() missing an assignment
>    =20
>     When using git-p4 in the python2 environment, some places decode( )
>     missing an assignment.
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-168=
3%2FSaNeOr%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1683/S=
aNeOr/master-v1
> Pull-Request: https://github.com/git/git/pull/1683
>=20
>  git-p4.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/git-p4.py b/git-p4.py
> index 28ab12c72b6..9fa4b9b104e 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -307,7 +307,7 @@ def decode_path(path):
>          return path.decode(encoding, errors=3D'replace') if isinstance(p=
ath, bytes) else path
>      else:
>          try:
> -            path.decode('ascii')
> +            path =3D path.decode('ascii')

Is this fixing an actual bug that you have encountered? I'm mostly
asking because I think this actually works as inteded: we only try to
decode the path using the specified encoding in case where it is not
representable as ASCII. If it contained e.g. Unicode characters, then
this statement here would throw and we end up decoding in the `except`
branch. Otherwise, we know that the path only contains ASCII characters
and thus we don't have to change it in the first place.

Whether that complexity is sensible might be a different question. But
it at least shouldn't result in any user visible bug, no?

Patrick

>          except:
>              path =3D path.decode(encoding, errors=3D'replace')
>              if verbose:
> @@ -3114,7 +3114,7 @@ def writeToGitStream(self, gitMode, relPath, conten=
ts):
> =20
>      def encodeWithUTF8(self, path):
>          try:
> -            path.decode('ascii')
> +            path =3D path.decode('ascii')
>          except:
>              encoding =3D 'utf8'
>              if gitConfig('git-p4.pathEncoding'):
>=20
> base-commit: 0f9d4d28b7e6021b7e6db192b7bf47bd3a0d0d1d
> --=20
> gitgitgadget
>=20

--OVBvJtfo5jx49086
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXllhkACgkQVbJhu7ck
PpTprw//bZPGkhfD8Ic8BDQEEbjrRg9pLO7Dsc3CxHChs4D7heZMhytzv7W7FHPL
iYzs/hN9x7lswyHlgZKUI6MXE98IxJDOjVEF0uMjKRgVzTr58138lLpMCs7O6yPg
7YI/7XYB5agxKrQKy5fNPQcaQ6fdH4U0GcwqPTsT14NSCDzpcTce7yruPjqfws/w
v15db4xSvTNVy/BVC1DO5urtjE0mjZ19X9ziB0OtVpfCaTghi3bLd6uCjoceODlA
g9P3wHzQdRN93QM+r9Kv3T9D0ZIBEkg/kWbTMWyrGtpml49bzAIyW5V57hxQBuxq
ViwjIfPLpPKN/JMWWEc2J0rIDBFZbKHB1TT/cpPiL9l8azvGQ1+hxJ8tUJln7pMy
yTxfTVoV2XsibmBXx1307MRnZWXXr/BPLxu9PRQwFjJnmXOJEuYJtqnCyd9QV0YZ
WRAUToRmk+GtEpTN+vsI5N1XUbNv7o0767LBRG3v7CabT/ch/h860qhjnEUOgX8D
FHdJ44YnorP22RFigpwJdbs3K6K8QaoqwXK9SjkDrF8L7jyjjuBUYkIvEE+8LwsH
kcUeCQR3+aLg0oAajW85BSOPSwT0sNvMx4pPJ852TbeCY7gbm0QJGVi/5DFJRHbv
Qv5RpKLvMl/PQmkwytKbZkWwg6tCICxaQYQuo74sypvK9nNr8Gg=
=BCsL
-----END PGP SIGNATURE-----

--OVBvJtfo5jx49086--
