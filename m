Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7C16F287
	for <git@vger.kernel.org>; Tue, 28 May 2024 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905156; cv=none; b=JBUPSKZG0nPx5ebdYvoZnLFga4OnKV9cH1GcECagosdv3ds0sb3MltVPwR0Zs0v6U0d+0hexlTXADyXJaasteTsPqzvQVgq7/0+Sw4Y8PNyLi/jEVQ911wn/k/BFUiox/83V49pvTuQlB6WgOr9m9Nx8jAZ6cGw+vFXb2+38qJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905156; c=relaxed/simple;
	bh=PZElwQ8JkdLQGNRIRht9IuBUAP1iOOlSrRQqZwltBjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ+/jmqVNHjkCwzXDNO5obohmn2AUkhIjkQUdnsnHS7I5QBn8zL3LKK3hqIgw358dugg30A2eJO6m1vYNJEQiCV4oIJfNEYVqNfgVcDinjoAWi66aveb/vVnPEFiPeSFs4sHSWplIkeyZB8G9Jxj+qGSxsNPyXZKucCRy5FR1DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=azzk8cus; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kk46JRLu; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="azzk8cus";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kk46JRLu"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id B01C01C00187;
	Tue, 28 May 2024 10:05:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 28 May 2024 10:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716905153; x=1716991553; bh=4HfiHF6WE6
	dPFmw2/5d2VakvLlcFO9LO4vcPgy4sieM=; b=azzk8cusUgpmvN1kCA7dA1Hs2x
	0a5huNNjJEKz0do6i8mfyzbVSi+n8zpcAwc0dxuMu6xSE4AKi3R/UCV8GDLqKH58
	7C6Tk3nJHXxqBWt+IocN6butpRYVZfwpJyNnwOTOtiBJjLusJrGclPMG4G30ODLf
	LEBNqbVN6OkOwVzT4bs5M76888htiImrFGjrbIsVba4MTEVJ2i9jLWup9V13hCrE
	0M5mpu/Ukdd5alOhv3A8+VWgst/hRxuZfJ3jaac2xBaoETArS4DqAUnuui5CYquO
	X+YlSvKib2eauEcn4UJ4YaLV6C9hceAQZ8PP4eryVtSP7lKoe/M8WB5K6RpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716905153; x=1716991553; bh=4HfiHF6WE6dPFmw2/5d2VakvLlcF
	O9LO4vcPgy4sieM=; b=Kk46JRLupHrxWMn67PgLuN7XPIkdMQ4+SWvVuxVwrjdn
	EiKvYbFIY0Fi7nGjGkiFY3UEd2CF5OyH5KJxK2piyrRwSFQyi9b4u6yoNS9N53/n
	P5gRX4uUMdkbbFk6O8GVfFz4ok2k9Xdj2fjMY6VxZbp0QOHtG9LKh/gXDrNqJetj
	h7/F6qoEIB/+w0tPuKxODlSSi3bhUmMs+QhNiiVy1qzIhtPiSbSwEtOt0YRkKn0n
	g/HvczOA8kp+fQYM05ipLMdlpX6oAXwKrjloCIDLaRCqSDEFCyoAFwbOaqXgPmgq
	7ApvtgCYatBhE3cIt94m5sV55iCc0/qNrV+WgnX1HA==
X-ME-Sender: <xms:weRVZjScA4ASSzv9wi8yYEM_kFle-pQeEWORbRtKyiK4u3P9Oq7Bzw>
    <xme:weRVZkxWxh8EUIIp-oP8WLcNvZeTkmuM2E3-2HgMn-zDSxkrRqKvn02bQrFOD9tJV
    uz8ok-EY1hK72vpFw>
X-ME-Received: <xmr:weRVZo1eayaTC4q69o80Za96_bewd__YuiVgD_8maV7uQ23oWUjS8NpBGJI4yKLjIPXfPLmtZ2I0ojsXt25FwpZL85JNXOjs9Sl40FPs-eKpoWgH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:weRVZjBciYcftZC0BY76m9UDIY8nc4tsadCom86xEsEpvMwu9yF4hQ>
    <xmx:weRVZsgk0_YTtEHzgUcJapbTrcoI_qCy3Y6qZp041KJ0XRn6W8wxIQ>
    <xmx:weRVZnr1OKTFuc2vGlHHByNtMh1oeqPurglz_uNq7uAG4Yyyq19odQ>
    <xmx:weRVZniy4aOMqaHDJ6VYaWPnNjHCR1vJs_nT8oXVEnxivz-b9-7mBQ>
    <xmx:weRVZlvQGLJp6LTsoWfcMfRxGuwm3t7nsUzRHtX35TP1IN07xqxmPsJm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 10:05:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 00e50df6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 14:05:38 +0000 (UTC)
Date: Tue, 28 May 2024 16:05:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: darcy via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, darcy <acednes@gmail.com>
Subject: Re: [PATCH] fix: prevent date underflow when using positive timezone
 offset
Message-ID: <ZlXkvEeR-PgZMitx@tanuki>
References: <pull.1726.git.git.1716801427015.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dg5U9jvBGiWd/elz"
Content-Disposition: inline
In-Reply-To: <pull.1726.git.git.1716801427015.gitgitgadget@gmail.com>


--dg5U9jvBGiWd/elz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 09:17:06AM +0000, darcy via GitGitGadget wrote:
> From: darcy <acednes@gmail.com>

The commit message should start with the subsystem that you're touching,
which in this case would be "date", e.g.:

    date: detect underflow when parsing dates with positive timezone offset

> Overriding the date of a commit to be `1970-01-01` with a large enough
> timezone for the equivalent GMT time to before 1970 is no longer
> accepted.

Okay.

> Example: `GIT_COMMITTER_DATE=3D'1970-01-01T00:00:00+10' git commit` would
> previously be accepted, only to unexpectedly fail in other parts of the
> code, such as `git push`. The timestamp is now checked against postitive
> timezone values.

How exactly does the failure look like before and after?

> Signed-off-by: darcy <acednes@gmail.com>
> ---
>     fix: prevent date underflow when using positive timezone offset
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-172=
6%2Fdxrcy%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1726/d=
xrcy/master-v1
> Pull-Request: https://github.com/git/git/pull/1726
>=20
>  date.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/date.c b/date.c
> index 7365a4ad24f..8388629f267 100644
> --- a/date.c
> +++ b/date.c
> @@ -908,7 +908,7 @@ int parse_date_basic(const char *date, timestamp_t *t=
imestamp, int *offset)
>  			match =3D match_alpha(date, &tm, offset);
>  		else if (isdigit(c))
>  			match =3D match_digit(date, &tm, offset, &tm_gmt);
> -		else if ((c =3D=3D '-' || c =3D=3D '+') && isdigit(date[1]))
> +		else if ((c =3D=3D '-' || c =3D=3D '+') && isdigit(date[1]) && tm.tm_h=
our !=3D -1)
>  			match =3D match_tz(date, offset);

Without having a deep understanding of the code I don't quite see the
connection between this change and the problem description. Is it
necessary? If so, it might help to explain why it's needed in the commit
message or in the code.

>  		if (!match) {
> @@ -937,8 +937,13 @@ int parse_date_basic(const char *date, timestamp_t *=
timestamp, int *offset)
>  		}
>  	}
> =20
> -	if (!tm_gmt)
> +	if (!tm_gmt) {
> +		if (*offset > 0 && *offset * 60 > *timestamp) {
> +			return -1;
> +		}

Nit: we don't add curly braces around one-line conditional bodies.

This change here is the meat of it and looks like I'd expect.

>  		*timestamp -=3D *offset * 60;
> +	}
> +
>  	return 0; /* success */
>  }

You should also add at least one test.

Thanks for your contribution!

Patrick

--dg5U9jvBGiWd/elz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZV5LsACgkQVbJhu7ck
PpSh2Q/7Br3CTB7sr4LuV0K2u9PVJ5zTK01g+t7PGivV91hiwPaKL5CLVQhnvlXY
TDv/kTPLFa2S4eYqIG0Z0NJ5b7Tu60QIHKXZthEnGaKbf5lSR0YyLuukOJoxfbyA
/Z2Li+YvrPcvaE3FjEqRWmsC2Z8Ovvkzx+tfRuMzpuAydVfkz8FuIWzrdo32qqRX
PgzyUm560NXX5nOTaGRSgB1ShAWe6LaPdM4MRjWUWbIDU/szxbLA8bVYvKzWtbQQ
gfLSico5bEMnnqwgrssTRHkzBRkQeV4YOd0roajTLTmkLmA+wYnwV5vf5GGVyIQf
1llpI34JDyQbX+9Tg4YKPrISf1coIg7+pwDOxKzAWmFECPth9cekoBtbrkQD+nl7
2rYmN1v8vRhsqrpcHChq8oZkSIBtdn7E/fj+HdZ6PKyJz1qtUrNBo+yRqloMTDBh
kkAH70w2Cg1CXr/fIjgZr9FiameGL6PxiTMvTt1GHnCkuDgGVd4OTfUaifE1AhNy
9JnRM2fVq3xzspkSI60L55OYj/gWZnd5Euv9Lvbyprvt3NfQL81YY98W86LQbPZ4
vhvaqY194iRQZzoUPYecv7qnVpVn8Y1rsllD+7GbR24Pg9PLswA4DG8GhR/MGUDZ
EH3j+oXtuHQ7kXBD8mMw5ffMR1MEvknYU2W6V3yxzfjV2vZuWPU=
=5q9Q
-----END PGP SIGNATURE-----

--dg5U9jvBGiWd/elz--
