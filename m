Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F218026
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861542; cv=none; b=u/wUbyhhWHPZWiJ62h7Mk8l1Iy6kvbvMzPObVmxmzaQMAGMZTqVUQ+9e0/5RNPNQaBwc5dbkl7Sx4xpDIgqOkLsMecsmIUej2pp/5t3XfLgd+WHwyAJVWmt+1FfBC50YlYvJVS3qTnWq4JlOIg7oh9PgfR0eTpN4FPf8B/rjRIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861542; c=relaxed/simple;
	bh=XomUeVWk4LHURWwf6c88Bm3uBzFiRcawBNWBGulx+XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XypsvG1Oz3sUXp0mT79TAT8/FP+A9xMM2W9/zB9CHCMofA91i4s2wV6N3BC8rPUuDNFofl8rDaXYDCh81CxPY8OnSmccxkg4WLj7D+U9NW4GtyUwFSoFXunP8CD2ZDkdshUO0U0F828wdqRwU4Y139aT5uWpfXAK5BogE9IMEo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zw0MmbNU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JgVv828s; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zw0MmbNU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JgVv828s"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7AE3E1151B4E;
	Mon,  5 Aug 2024 08:38:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Aug 2024 08:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722861539; x=1722947939; bh=V8MzfHOJKv
	/TbXizdknJRpDKfEy7oy4z9kJX26VfsBI=; b=Zw0MmbNUvfOSRFeE8yEFGS7jVo
	57Jddune3nx+5dy97/NvBShuuXJsaQ5yn8tPVnhU8JeLD6IGU0QzZPCQTIyShyyM
	THKBapT6birGYyrZ7kC7pgpqBay4bFpqVWQEcNOW/OQDGtIZXjMBcxUE54RD00S3
	tfLbaSQBQd6A+9LQNlY+9iLrQ+bDC8QgNiYluNk/KebGMa8hHjh7weSzJV6Jjd2U
	nbJSsjY65DHyPWh682aLFUVsJE2eL7tI2tJ4EGMa87R2G8bPcRUGd/ZFX9z1zxB8
	fqrat/eYzL483gcVWR9TO51XfzB/hjMWrHnLOrFEeiv8N8JtPbKTdAMbFZZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722861539; x=1722947939; bh=V8MzfHOJKv/TbXizdknJRpDKfEy7
	oy4z9kJX26VfsBI=; b=JgVv828sA/9K+1NGdgEd4Sdw9J6d5pwHv3IV6wX70TC3
	rFllSeK9NnK+cNim/HD6AfkoSUQtjoTEbm8snKgfpME4KPGZzJRy1oeIXdSixHWO
	dS2+YGl0hTJOJeKFurc8terbe/qYh9NuAFrzfl28Gd/L8/K31oNiVx9vnJWHFoTe
	qiYXuHD0Q2OFcXZG30QEv7VbDHwKuD+FYLUMDTx8a62ZGToc/bZKT+5jocIr+4n8
	9YatJCVXItB49t081bIxc19jXWCH5JlE+gQZFEOkh4kpp0QrrSFmI+prRGJMPeSv
	3XvCV4xAMIX1i6jomp5F3hnja5K+2mhkyyF/LhMAag==
X-ME-Sender: <xms:48ewZl2Kb1AYGX8dtHjHUNBllDg0zP-3JcuglzL-KW8XEBogtVyc3g>
    <xme:48ewZsGTf_FkRy2s03w9PDO_4IC3Q96-4dErOBKYdUY3UZhSvMSKMt9rW9kc8sW3s
    I55qV6KW6aYwNQnHQ>
X-ME-Received: <xmr:48ewZl6nXf11y9dTasyw_t1c-H1zW7_4Cfg94UGPYUfT-UVlo53_6oxQdUApkHYuH01mtPwO53vi1mS5s0f3ggLZSHPiIhMG2hOU0OyVGLrd6iUcog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfelgfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    td
X-ME-Proxy: <xmx:48ewZi0jyhgXgGfSZzPsQR1sVOz_wUds_tNehEPZGKjiqNLvKZ8GAQ>
    <xmx:48ewZoEsa9n4iArxOrVMME7iXxS01xyb23a6ysod6JoRUkq8FXhaEg>
    <xmx:48ewZj91cELxAsg7t-w3s_fJfLQOermVmTtmr3kPLurbL6dlW9L6HA>
    <xmx:48ewZlkX6n1IgpOjnXpPr0vAKe6o_Cy8F-5YuWs73OzBZgMm0asbyg>
    <xmx:48ewZtO8tH5Gosh-JmWNPKg_r0fxQaSidjb7e3q8Dt8Y65RY38mmjnGW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 08:38:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c1897164 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 12:38:56 +0000 (UTC)
Date: Mon, 5 Aug 2024 14:38:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Han Jiang <jhcarl0814@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] config.c: avoid segfault with --fixed-value and
 valueless config
Message-ID: <ZrDH3ryOO0wIJIDE@tanuki>
References: <c78bacfa8fb274fbb48f259b13f4f30253932f69.1722532013.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LufcDtm+INYEiS4V"
Content-Disposition: inline
In-Reply-To: <c78bacfa8fb274fbb48f259b13f4f30253932f69.1722532013.git.me@ttaylorr.com>


--LufcDtm+INYEiS4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 01:06:54PM -0400, Taylor Blau wrote:
> When using `--fixed-value` with a key whose value is left empty (implied
> as being "true"), 'git config' may crash when invoked like either of:
>=20
>     $ git config set --file=3Dconfig --value=3Dvalue --fixed-value \
>         section.key pattern
>     $ git config --file=3Dconfig --fixed-value section.key value pattern
>=20
> The original bugreport[1] bisects to 00bbdde141 (builtin/config:
> introduce "set" subcommand, 2024-05-06), which is a red-herring, since
> the original bugreport uses the new 'git config set' invocation.
>=20
> The behavior likely bisects back to c90702a1f6 (config: plumb
> --fixed-value into config API, 2020-11-25), which introduces the new
> --fixed-value option in the first place.
>=20
> Looking at the relevant frame from a failed process's coredump, the
> crash appears in config.c::matches() like so:
>=20
>     (gdb) up
>     #1  0x000055b3e8b06022 in matches (key=3D0x55b3ea894360 "section.key"=
, value=3D0x0,
>         store=3D0x7ffe99076eb0) at config.c:2884
>     2884			return !strcmp(store->fixed_value, value);
>=20
> where we are trying to compare the `--fixed-value` argument to `value`,
> which is NULL.
>=20
> Avoid attempting to match `--fixed-value` for configuration keys with no
> explicit value. A future patch could consider the empty value to mean
> "true", "yes", "on", etc. when invoked with `--type=3Dbool`, but let's
> punt on that for now in the name of avoiding the segfault.

Edge cases like this really make me wonder what the benefit of implicit
bools is in our config files. They have been a source of bugs, including
this one, and in my opinion only lead to confusion when reading through
a config file manually. I would claim that 99% of our users out there
don't even know that you can have implicit booleans, and would think
that the config is invalid. And the 1% that do know probably don't care
much. It's not even like it would safe you a ton of typing.

So... why do we have them in the first place? Is there even a single
good reason?

> [1]: https://lore.kernel.org/git/CANrWfmTek1xErBLrnoyhHN+gWU+rw14y6SQ+abZ=
yzGoaBjmiKA@mail.gmail.com/
>=20
> Reported-by: Han Jiang <jhcarl0814@gmail.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  config.c          | 2 +-
>  t/t1300-config.sh | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/config.c b/config.c
> index 6421894614..05f369ec0d 100644
> --- a/config.c
> +++ b/config.c
> @@ -2914,7 +2914,7 @@ static int matches(const char *key, const char *val=
ue,
>  {
>  	if (strcmp(key, store->key))
>  		return 0; /* not ours */
> -	if (store->fixed_value)
> +	if (store->fixed_value && value)
>  		return !strcmp(store->fixed_value, value);

Okay, makes sense. I think we should at least have a comment here saying
that we simply ignore keys with implicit values. I was also wondering
whether we want to warn about those such that users are aware in case we
ignore them?

Patrick

--LufcDtm+INYEiS4V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawx90ACgkQVbJhu7ck
PpSrzw//dfyVcIQSQ9NkY9J2DPplnPamvsR61nbPeAMJ7/IRIjeVrh5FniknkYlj
PdWRF4g01iNK+m895UQOKf6/TBlIFpP8InXZ3koQDvx5db6/LhM2HPjmerqBeEF4
RahnufbQ3WAVhAhpjBoJ2dtWdmgBCe+jzVibyf67DsJPIg8JiW1Oe57wtr2+oyVz
zD5aopxNffjY/yiCvGhp40460p4nsAj/FWiS/GzNhc9ZojaFs8A25k0NYHrcrAg8
iYxBuQT2TqILUbAH/qyqvYwhaUj9eYQaZmm47m0acg7XgqnMwNKLou7MG5y4RyJb
rHgd/U1Edghp8DweFe57eNUQCL+ak4R0Fh0nmnh2s9VT/qOWyZHyf6FfyTLh+upc
K0iq7PwMoGxCTwgBGqz9GELNsmCk3n7x286zcvsUNu4x+mvbuT5Tall8czlMPmKg
TueMLJo/BCENhYAYJ/doHVCtre9HlYo3Uzq3GfL7uSq6wI6CO74rxhf/3Wv7P6FB
Zto+P8sZudd/9q6gJyIQ06n3HTONbi/uHuUlitFCLqKg6I9oR9aXKzic4tnGnaI7
29uhyBOI7GdyEsJKf98pCKoPvFPtaEb5PE/i2jkVr47UgiTP6/zcbHvI1dZNj5yG
s35TaTJ44D0Azi2Q1O8E5Tf5My7XjDdOhrqEQSFVKBEQnufZcvo=
=pnLk
-----END PGP SIGNATURE-----

--LufcDtm+INYEiS4V--
