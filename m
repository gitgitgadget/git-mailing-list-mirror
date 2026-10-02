Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484253F4DEE
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969865; cv=none; b=exZUWqo3KnkpfS0gHWG3Lk0vP+Z8zcAzKXylcfm0tDtkn4vQk3hsLvZj2DbXkxxDsW+SppadMhFrbVJzmk0M0rK24PRXN60qkm+BLD08dhXDdP7jcqkCuNhyDIBiPUa6SZFCpg9mzVLpDYyrbmw8O01z6Fdq7Mo1+XBEGHbbNwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969865; c=relaxed/simple;
	bh=9N89hPMiUR3tCcmPSWa2U1LmR7YBR/qTjTZkG4m7lA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftL90yMDKOmqhgEqvVtHDQ0QI+7OkXUcYfdPi/Gam8CC6xMD0x24tBeBBzMeimz4jPobYtXLUzHOx5hdvHkovsmKonTJNVERDW2Zqwyg69aGYhcKHCbXaXKhdWd5O+kP7egidbZgvg4Xf95e5sMnm1LA2VeX8bG75j1IA7aNvx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=KcWuEx6u; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KcWuEx6u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1790969857;
	bh=9N89hPMiUR3tCcmPSWa2U1LmR7YBR/qTjTZkG4m7lA0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=KcWuEx6u5U1qD96xz1H8e2HhH1c3cHA12aE/FqO/NWi8Y/UuAxzxA5PZs0/aDPMPb
	 IjrcgxCjTft97jYKTr8VCYE8b/ED0a7ipLPDTFuTtDHbiPRV4/d66ohCbn7yhtle7J
	 LylMnhUL35eDm5lP98fvekqOSKa4r4jEuM8TP3W0jshMtCeCG1cSTMJDOAZPkR+EzP
	 xEapobTrSiTZNiUP975Gv4dVke/y1NEkC31vb/IwcPHVO8mEnBfymxlpqca+INI7/4
	 yFEBD5rhpfOxRNJxe7AAJv5HnpI5Rn+ivnCh9kToQzb/qNfQC07WwurQGh1bghFnW1
	 8foApYopnUIHjYxGfsceI4hNKAQKb2Q72FTfHqDXnPIpThGpux3wZYC5Xzw8JHSrty
	 kJ4JMEbqb6Q/q6ASFIXExz7N8fy6bNuL/oBki5PCEU9TRUfyRE9BhfLWKUG2lvIjcf
	 oZgX1S1bL/PUrkNhjkH5tKpxpuLBB+FEALNjKdsxYTnluUKTRfE
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b933:116b:3dd2:3ac4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A41EA20075;
	Fri,  2 Oct 2026 19:37:37 +0000 (UTC)
Date: Fri, 2 Oct 2026 19:37:36 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: =?utf-8?B?0J3QuNC60LjRgtCwINCf0L7QvdC40LrQsNGA0L7Qsg==?= <nick.ponikarov@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] branch copy/rename update refs without running the
 reference-transaction hook
Message-ID: <asAIAHC_zuHPLljW@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?0J3QuNC60LjRgtCwINCf0L7QvdC40LrQsNGA0L7Qsg==?= <nick.ponikarov@gmail.com>,
	git@vger.kernel.org
References: <CAPHjog3wuWOdZS3pHQd20hdZNwA5iXsQMkEfmSnp=NGhLBzuJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K16Ke3xbZ5NviTud"
Content-Disposition: inline
In-Reply-To: <CAPHjog3wuWOdZS3pHQd20hdZNwA5iXsQMkEfmSnp=NGhLBzuJg@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--K16Ke3xbZ5NviTud
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-02 at 04:12:55, =D0=9D=D0=B8=D0=BA=D0=B8=D1=82=D0=B0 =D0=9F=D0=
=BE=D0=BD=D0=B8=D0=BA=D0=B0=D1=80=D0=BE=D0=B2 wrote:
> Hi,

Hi,

> githooks(5) says the reference-transaction hook "is invoked by any Git
> command that performs reference updates". Some branch copy and rename
> operations update a ref without invoking it.
>=20
> Observed on git version 2.55.0.windows.5, with the hook registered both
> in .git/hooks and as a config-defined hook (hook.<name>.event).
>=20
> 1. `git branch -C <src> <dst>` where <dst> exists and is not checked out
>    anywhere: <dst> is overwritten with <src>'s value and the hook is not
>    invoked in any phase. This happens on both the files and the reftable
>    backend. With every documented hook event registered to a logging
>    script, none of them fired, and a GIT_TRACE2_EVENT log showed no child
>    process.
>=20
> 2. `git branch -c <src> <dst>` where <dst> does not exist: <dst> is
>    created and the hook sees no line for it.
>=20
> 3. `git branch -m/-M <src> <dst>`:
>    - files backend: the hook sees the deletion of <src> and a
>      "0000... 0000... refs/heads/<dst>" line, but no line carrying
>      <dst>'s new value;
>    - reftable backend: no line names <dst> at all, and renaming a branch
>      away deletes it without a line for it.
>=20
> 4. `git reflog delete --updateref --rewrite <branch>@{0}` rewinds the
>    branch without invoking the hook, on both backends.

I think there was a recent thread about this at
https://lore.kernel.org/git/CACQ=3DSRHCOCcmVCgHqd+sjMsZ9LCdSHuXdCo0gkwxXwYg=
F7iwig@mail.gmail.com/

There were some patches, but they appeared AI generated and were not
picked up.  Perhaps you or someone else could send in some
higher-quality patches not using AI (see
Documentation/SubmittingPatches) that could fix the issue.

I will say that using reference transactions to solve this problem would
be very desirable from a variety of perspectives, especially since it
would probably go a long way to unlocking way better performance for
`git remote rename` with many remote-tracking branches as well.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--K16Ke3xbZ5NviTud
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrACAAJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ0EDUx0OA/Bl5RGuwdTsG+jkXvUyMyjJEIvltgh32evv
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAIVfAP0eialRULDY2gudPxAqI5WH3WiI
3fWUwSNr5GqkrCIAGAEA22uRYZUF7H97PkLgO0HZqw6/ojAo1Xf4hwCsw4U+vQw=
=2Not
-----END PGP SIGNATURE-----

--K16Ke3xbZ5NviTud--
