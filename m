Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195841CD38
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708323789; cv=none; b=GsGuSFUXvt+vSndiaWgY5o2q/K6qT6UUHJmp1Bs6nGgIboA5hVsEZuf7T1lDB8zu6VVnLoIlCARiUULle0AMps4Z6oihsBicQarxPtg9hIh2hk8f3d/s5OXIXpMtWPxPxp6rdptL71TY9HkgOVTPTdywH3HENvHMrgMbsLnMw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708323789; c=relaxed/simple;
	bh=3BF1Rofp//QPNBDODCNm6IpWp8egpw15Lb4Q+IhS4as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7wgyD6h5Rt5z4+cJcjHwC3Di3ELN0isnkdQZhffzjoHBDZL6PhehogvqHV42/IclsTFIUrVu881uChHMDnIt8iJLhwNYYU4ECjs28ApZP5eiPDd5+9LTQaPJzWo0m3Akz8KJ+8BwxxguzST4E0AuvZ1XS4t6sF4HtTpszBg9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SMPHy2JM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TDUDPgj1; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SMPHy2JM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TDUDPgj1"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id A202B1C00078;
	Mon, 19 Feb 2024 01:23:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 19 Feb 2024 01:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708323786; x=1708410186; bh=Dcl25d+Ujc
	l0/NhppwjArVuzZ9EG2eX1/EnOcBK+YO8=; b=SMPHy2JMQzPGJ/tQs7IWFenH2l
	5o1KOQLsBEpbMGr6JwzYYWXUSX77M3HfLqLQzhpBoP4Ck5LzVOI5iZJtCr4H4KDN
	pczhxsfPXrosc2JA2E/1MP8G5N691R51glWFW5VKuGxJxY7ha1hukFh4YIQJKjkp
	v2aKxulGQYxqJtIrD7TG2J/zmekb2O5p1F8K3HnL5eZtGqlqn2iGnO86/Bs4DvZ2
	O+AtGYR1ctyW+A4UZElng438Y3212leYns/d2bZwAvaheK57YW7gv4Q0TeM7sXAN
	oJrYhX+5k/vv1ywFcydyZIL9C0PkZr+JT6nZHr9QhUiPnFVPSWBJylQqtYNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708323786; x=1708410186; bh=Dcl25d+Ujcl0/NhppwjArVuzZ9EG
	2eX1/EnOcBK+YO8=; b=TDUDPgj1I63+Wronf9sp2iBurIuWrfxjjnI1slmFmZea
	EFobVf+QFC457fENqggaBw1jTd7ZdeDsYyaWI4zEl2fF+IUgb0NZd5Iuv/ZS1ymO
	a54oIPYWK0CDugOIB+Jcuqj0gfM3Mxb3ejUhDAH5onZmEMww2oxIF0mX3KDQUEXs
	hiXvfIHBaULcwJ5nXDb/vrZq6CIvJpjKb+qeXFSWig8scGyH5ld4/Z0G92qk4naz
	YhE6xKphC3M7c/K51dub/Cm+0HOWi+ALcx1raqncvm3chYB+yPfr4OzLevEndvKx
	xDZXHT11X3Wjw4eNMnITl22y5Z0dtFWJXmtbvLYF4A==
X-ME-Sender: <xms:yvPSZRu53c_cmHwzZQMAiHAkaL6TZ_T0cyT6mw01-GOOR7Ptn4hj1Q>
    <xme:yvPSZacukAxjpw5gkKGsqKBixpS7P7NByxCdOWfMchN9KCGWC_V32tp13VhRQQJ23
    eyBFRkEd6mhE4XY_Q>
X-ME-Received: <xmr:yvPSZUw_oq7iVXh4629MD3MGRT0I6M8RQ-aFYQmeRxAHYRSpMi2ehPwyJDROM3Bta9vSd9hpbpX3044Hg2nkKBehM8u7_cmr0MT4h9XFmWrnYXVh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeljeetffevheeggeetkeetieduieeiieegieegtdffheegkefhjeehfeekhfevleen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:yvPSZYOn5qb1jBVijwImeRHWzLRYP-O7Hn6ifQxj4kCgHVSiYGkhYw>
    <xmx:yvPSZR_JvI2OdTPlDgzGzsfOGgSTq9Q9IFWUSWBTTrTbNapOPIP3Pg>
    <xmx:yvPSZYUYjsGM7eJn1Yfeuwgcc0EUHVLoTjJvZAtxb1dwG2v95IUowA>
    <xmx:yvPSZdZMHpGq7Zfg6HhzGE4Scqrt902xa8qLZ3zh2HJ156xyUACI5L-hKzc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Feb 2024 01:23:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e347c83b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Feb 2024 06:19:03 +0000 (UTC)
Date: Mon, 19 Feb 2024 07:23:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH] diff.c: use utf8_strwidth() instead of strlen() for
 display width
Message-ID: <ZdLzxYpY-klokgpI@tanuki>
References: <pull.1668.git.1708281443289.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ry5IbewJ/A3Gu72X"
Content-Disposition: inline
In-Reply-To: <pull.1668.git.1708281443289.gitgitgadget@gmail.com>


--ry5IbewJ/A3Gu72X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 06:37:23PM +0000, Chandra Pratap via GitGitGadget w=
rote:
> From: Chandra Pratap <chandrapratap3519@gmail.com>
>=20
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>     diff.c: use utf8_strwidth() instead of strlen() for display width
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1668%2F=
Chand-ra%2Fdiff-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1668/Chand=
-ra/diff-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1668
>=20
>  diff.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/diff.c b/diff.c
> index ccfa1fca0d0..02d60af6749 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2712,13 +2712,8 @@ static void show_stats(struct diffstat_t *data, st=
ruct diff_options *options)
>  	 * making the line longer than the maximum width.
>  	 */
> =20
> -	/*
> -	 * NEEDSWORK: line_prefix is often used for "log --graph" output
> -	 * and contains ANSI-colored string.  utf8_strnwidth() should be
> -	 * used to correctly count the display width instead of strlen().
> -	 */
>  	if (options->stat_width =3D=3D -1)
> -		width =3D term_columns() - strlen(line_prefix);
> +		width =3D term_columns() - utf8_strwidth(line_prefix);

It would be nice to add a test demonstrating that this indeed fixes an
issue. This would also help to keep this from regressing in the future.

Also, do you know why we didn't use `utf8_strwidth()` right from the
start? It would have saved the writer some time to just use
`utf8_strwidth()` instead of writing a whole paragraph explaining that
we should do it eventually. Makes me wonder whether there is anything
else going on here.

Patrick

>  	else
>  		width =3D options->stat_width ? options->stat_width : 80;
>  	number_width =3D decimal_width(max_change) > number_width ?
>=20
> base-commit: 2996f11c1d11ab68823f0939b6469dedc2b9ab90
> --=20
> gitgitgadget
>=20

--ry5IbewJ/A3Gu72X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXS88QACgkQVbJhu7ck
PpR0yQ//WB+z2eHe6vYKcCmRUMykitiPHoX/zjPIlQn6yxsLaxqBQlK13T7/D4LM
WYw8gHUPdayfy3XYwDITbyUXSpg3wm6/b95xfQIX24EFCwxI5qB0+FhmEUwb0ms0
FRe9xegjj3Iv2HelQX+XvPTTcxgijdSLNXdhTalypVUmuA99ygo0cgfwQjypCevt
/0UnLuUEKKLgV/OB1QF7jR2mDezhD1qHN5FVo1Wj5RkpWDPRJHGM0YjKxupqLQNb
dYeBimvspqMcoYJ+j55JprvIkfYT5H5fePmBvli6MiJMTzSGhpgf5rcJL+QzdDsd
AZoc0qEacrL3+ONLdGoCo2QwVZCHN+3f4p/Tl1DlV5oHwVzwaiii7ii1Au9VCmmY
PIumkWP4G3OKlT+tdS3hXQF4iPVGIwwwDyks/YxIVWb/enAkvU6vagFxPmcIhCSK
EUvAz/n8JpyiBDpyBXlb/WtWo8eW1x2hDSgjA4qiD9Q1v8wSBqZ6ZTS8A5OvT3gX
diMTWDVePIh1F5XHRNDOhNKMT/fEiphxLzBcT13wYLV4GbOweVzchXmY9uPFum7h
WuCVjTmvUp+hGuwNoLjjLBW7tOffhxARQRiFcQcxJS3BfUOduxqz92JoRRpeU7al
Wq1Hi8wQ4Dt2BOb8h1abv/b6na1yn1qpNRgA1q8ktq4XzK1yBh0=
=XgC7
-----END PGP SIGNATURE-----

--ry5IbewJ/A3Gu72X--
