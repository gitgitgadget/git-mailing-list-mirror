Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0CD22069
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712126084; cv=none; b=HAXS5FzusQERxUwibyS7pxv3xyY75aJxz1Nv1XK6V1saS0Labu9zXk/RjrsqxYC9I/YjC4gqVPmNgU6zeCfT68vcivdH2TnCrkKEQtMP6421wHSuJsRSIzBduv4xbHA1zrkS5PJzIjVYOvl90++eBbIaxxf3d6I4R1MCXk5KP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712126084; c=relaxed/simple;
	bh=RQQnLNCESjo1/xmQSOx08Zwu31WIK8tbzd8ve6Z75HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svnP+/psfdWE9v5QrdEW+B3/ojwsDHIakrP93OcAuxi2Mvq8QipvGG1C2KmyQZwx6U6pGrEO7z24bRTPmI7AsFMVg4QM1XbxqylmX9ZkV3nHbUcFdLq+odQ0p4JOHoZt7vs+7cgUz1v+aZuu+TXwgWJUKSuyL/nE5lgLxUjrSNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I/JTSxvY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WoO2IzT8; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I/JTSxvY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WoO2IzT8"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3137811400DD;
	Wed,  3 Apr 2024 02:34:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 03 Apr 2024 02:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712126081; x=1712212481; bh=pdwXro3SHA
	U9MtH5MoiCQBKh3at7EZjQGu2RB05gmbs=; b=I/JTSxvYjy7uPx8W0MOA0hbnzK
	tLNCY8PUo5EF7Hg1oi/fBXQtzF8x+TFR5im8elzyH/+S5aoUnWdDXSLgzberKYLh
	dxgexDfr+lWxKT3oPGQmvXjim5lrXOl5PW9VSCSAuIP1CzIBkSp2vB86dPDX4ex5
	eCpbAyl5MGcO7FUc/LupdwZn/Y8dpOEPPS3CIe5tPrZDJXm8AUeIheVCxi8ezuwT
	fs8OavZlr7JjwrUIPGWAd0et5lEtqJHsiKiJsTTuq4ealVOtcvkY56V1n7GUfQzS
	5pTjUTCWHVSGvuf36vF24OOYT4FFbHnDZixgonWUTUvH+7DAxPFH/cNS3YkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712126081; x=1712212481; bh=pdwXro3SHAU9MtH5MoiCQBKh3at7
	EZjQGu2RB05gmbs=; b=WoO2IzT8K7z/EO6scQc/s82cV927wz2m+0W56bSscGRr
	l7YSowvQ5RncyP+Te2VovjHwcv5TXNs/qdd6UvxipsUBqd0jCGV0+gHBY+eMv8jt
	4TzVMCnInNy+ygzNU0jqi3g/Y3CJg4BIOVR5QKJTBO7peWqRrB+U2mW8xecmVc64
	WXUzFj0LS2bYWaprq8N4ZNgrJaTLkUJcVIU+H/8tvL0aAr2laXzOh5kj9OPZwXjT
	JoerL1rfIADP9diq1uqlHg+bRncOb5eoLXdkwbVqJe56HKxHDbUcx1gxTnSkOanh
	9YiA8oiLDggeDgw5VYeeR0lzbDmSMIITM8Kio/2T7A==
X-ME-Sender: <xms:gPgMZv9cZJXe25CE5p6nN7aNoelA2pd7W_n9Ze1Y3YcwMbLUXQS2Pw>
    <xme:gPgMZrvOUuzNik_gZKrO1RBFg-olkp8-6RAc_Qtvy2R6b_X3QaTTNFZInNGjo7mzV
    FnGbXazy-j6LfgB6A>
X-ME-Received: <xmr:gPgMZtBfwrrbikFCMGjPnE-AL8wALEplCvV1BBySPNoJkrH1bel6Tm7hpvjHj1f5cjAccLXzMMIC6Kw6U2J6ExZluHOr-aovrntWYlXSEI0D9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeljeetffevheeggeetkeetieduieeiieegieegtdffheegkefhjeehfeekhfev
    leenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:gPgMZrcXex8F52K1LmD8Qcl-bKuw9mQ7tkdO2mKV2o9aF8Uyce79fg>
    <xmx:gfgMZkNHr8nt1bNmcPdTZDCLjgBmRHg2DKZ7vm7baW6SJkn1yn4ZAA>
    <xmx:gfgMZtklUqYvnwLCRndTtEY0BnaoI_waGmrpTJn5UrvEiuVK9jDb3w>
    <xmx:gfgMZuukpCOuj0DIqdHss59hVB4k4wXSfgA-P4s959T_80YG6uRpSQ>
    <xmx:gfgMZhrGj_o4sDsOZeOJ7jssgIVjzyfZ-P0XEuVi4r6v87B7baUSkUpH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 02:34:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bcdbb65a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Apr 2024 06:34:30 +0000 (UTC)
Date: Wed, 3 Apr 2024 08:34:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH 1/2] http: reset POSTFIELDSIZE when clearing curl handle
Message-ID: <Zgz4fTJg2iL07W_h@tanuki>
References: <20240402200254.GA874754@coredump.intra.peff.net>
 <20240402200517.GA875182@coredump.intra.peff.net>
 <Zgz3nvMLg4ts2rRI@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="09o9U4BOuSx0/w+I"
Content-Disposition: inline
In-Reply-To: <Zgz3nvMLg4ts2rRI@tanuki>


--09o9U4BOuSx0/w+I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 08:30:54AM +0200, Patrick Steinhardt wrote:
> On Tue, Apr 02, 2024 at 04:05:17PM -0400, Jeff King wrote:
> > In get_active_slot(), we return a CURL handle that may have been used
> > before (reusing them is good because it lets curl reuse the same
> > connection across many requests). We set a few curl options back to
> > defaults that may have been modified by previous requests.
> >=20
> > We reset POSTFIELDS to NULL, but do not reset POSTFIELDSIZE (which
> > defaults to "-1"). This usually doesn't matter because most POSTs will
> > set both fields together anyway. But there is one exception: when
> > handling a large request in remote-curl's post_rpc(), we don't set
> > _either_, and instead set a READFUNCTION to stream data into libcurl.
> >=20
> > This can interact weirdly with a stale POSTFIELDSIZE setting, because
> > curl will assume it should read only some set number of bytes from our
> > READFUNCTION. However, it has worked in practice because we also
> > manually set a "Transfer-Encoding: chunked" header, which libcurl uses
> > as a clue to set the POSTFIELDSIZE to -1 itself.
> >=20
> > So everything works, but we're better off resetting the size manually
> > for a few reasons:
> >=20
> >   - there was a regression in curl 8.7.0 where the chunked header
> >     detection didn't kick in, causing any large HTTP requests made by
> >     Git to fail. This has since been fixed (but not yet released). In
> >     the issue, curl folks recommended setting it explicitly to -1:
> >=20
> >       https://github.com/curl/curl/issues/13229#issuecomment-2029826058
> >=20
> >     and it indeed works around the regression. So even though it won't
> >     be strictly necessary after the fix there, this will help folks who
> >     end up using the affected libcurl versions.
> >=20
> >   - it's consistent with what a new curl handle would look like. Since
> >     get_active_slot() may or may not return a used handle, this reduces
> >     the possibility of heisenbugs that only appear with certain request
> >     patterns.
> >=20
> > Note that the recommendation in the curl issue is to actually drop the
> > manual Transfer-Encoding header. Modern libcurl will add the header
> > itself when streaming from a READFUNCTION. However, that code wasn't
> > added until 802aa5ae2 (HTTP: use chunked Transfer-Encoding for HTTP_POST
> > if size unknown, 2019-07-22), which is in curl 7.66.0. We claim to
> > support back to 7.19.5, so those older versions still need the manual
> > header.
> >=20
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  http.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/http.c b/http.c
> > index e73b136e58..3d80bd6116 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -1452,6 +1452,7 @@ struct active_request_slot *get_active_slot(void)
> >  	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, NULL);
> >  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NULL);
> >  	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
> > +	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, -1L);
> >  	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
> >  	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
> >  	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
>=20
> Can't we refactor this code to instead use `curl_easy_reset()`? That
> function already resets most of the data we want to reset and would also
> end up setting `POSFIELDSIZE =3D -1` via `Curl_init_userdefined()`. So
> wouldn't the following be a more sensible fix?
>=20
> diff --git a/http.c b/http.c
> index e73b136e58..e5f5bc23db 100644
> --- a/http.c
> +++ b/http.c
> @@ -1442,20 +1442,14 @@ struct active_request_slot *get_active_slot(void)
>  	slot->finished =3D NULL;
>  	slot->callback_data =3D NULL;
>  	slot->callback_func =3D NULL;
> +	curl_easy_reset(slot->curl);
>  	curl_easy_setopt(slot->curl, CURLOPT_COOKIEFILE, curl_cookie_file);
>  	if (curl_save_cookies)
>  		curl_easy_setopt(slot->curl, CURLOPT_COOKIEJAR, curl_cookie_file);
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
>  	curl_easy_setopt(slot->curl, CURLOPT_RESOLVE, host_resolutions);
>  	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
> -	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, NULL);
> -	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, NULL);
> -	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NULL);
> -	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
> -	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
> -	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
>  	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
> -	curl_easy_setopt(slot->curl, CURLOPT_RANGE, NULL);
> =20
>  	/*
>  	 * Default following to off unless "ALWAYS" is configured; this gives

Oh well, the answer is "no", or at least not as easily as this, as the
failing tests tell us. I guess it resets more data than we actually want
it to reset, but I didn't dig any deeper than that.

Patrick

--09o9U4BOuSx0/w+I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYM+H0ACgkQVbJhu7ck
PpS3rg//WWydGX5/gb1JF36C836kbuYdyrk4opke4mTnjPEDG+GAHy2iwOqZ196y
hQP50t4yauw7T0l6YKVdTZbs2u72JvQSSox2q6b5lANVXTk0V1RfQbfPyto89zga
rnfhgtpshrR4fogingwTzpRppCwhypP7FSDGG6xLsDeaXeyA+kwqhEPH5dXQn5GN
d6zI+ULzja6cyZQc2wDTBG4HOzQhewGdVl+e6e5WnMoK10TxLa7lAihccB3oJMSO
H5DPbGlmqtBUW+jRCwdRzOXfkarP12jl4wNppYKNbYY5e6VeQQv/D/KjTto1l7c3
qvPYXpmcczdZHLoxUXDio9s7BrqJSGQJnf22FJMrrllqAwKvUPAKcibhEYvTrsbZ
OrNOGRVxiMVzoCtSjUufFmjBTeEsjzR1cn0EXZAOSk4WgsAVCS/tqr8FeEy/Gtxw
pB+RSUYRtyYAE2UQHDXT1mGGSHl6cECZPWx9+F9mAysvf7gHw4YVUlxc6L7caXRU
FWJvwhqQGXS+RVeujXCDmXG/C0oFar0uGnVVKttfFOGXRelIQgwPqc4nArhQVmfX
kulvjWEr6dQTVarL2o/gnCfW93rIF7PyE8tnJHp5sshDlZEj2D8yBwrViV00gTIf
t7thvyMxny18Dob5tNRIAZIXtr4bjB9Yw/i3IfruStXFicNlwm4=
=H6qV
-----END PGP SIGNATURE-----

--09o9U4BOuSx0/w+I--
