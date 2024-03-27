Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CA42C694
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526561; cv=none; b=bLYD0FXI7w/dANZFmF5y+7QlYiUI6u8CCdt3n3hCuWmCY7FbdnnKpefpVUzw37so579aSAm6xfCJoERY/RZIpNzBytrlv9FLP/QZF1h8YuXdC+a1HSM63EAGfC2YjkENyN21IH/qxLpH5+z2YgNgoN0eiYq9MWtsrfwDyRN7uWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526561; c=relaxed/simple;
	bh=ZJnzKnCEPj3u34g9cvgPI9Uxk0tRUmx852rj6f/J9jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDn9Mc7swzuCl0inRDRGaRXm/zK9SRBH6VBuXLMv1F7uHMQ4z6u9NFdvzXYzXTyfL0TgtEKy67TZaAo8so36R05DzZgqS3h+q+P5aOpQvTQVGO2+pPuOmh0V7wDcYCI6kYgp1a8a05REv93TANpLiCYjPBZcTWL076j5gIkTbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lWgdEP8M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m+BJG5yI; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lWgdEP8M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+BJG5yI"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E64A01140125;
	Wed, 27 Mar 2024 04:02:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 27 Mar 2024 04:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711526557; x=1711612957; bh=eBInDH1xje
	g5wgxaRFkxDm9//U9dhLfHFrcux892NiI=; b=lWgdEP8Mq/JRGH/2Fzal0+jwpo
	277EPDZJiX7Bo37bUmiehHQevoh2uUZRAffBgRQF56bKb9PE+H5ofNc0mZfuaDRr
	KMHcxOhVeR1+X9vHFqYy4yTFQjpf+Jn5M+9EOvYGFMa932N+J4my3hHzWxl2byAt
	5rsttoAdbq46sxy1O6n+pLBY9RfE4EOXzAvcY9JMM9VBFDTTS5OtclCrSTV/MK4z
	qipdFWKhJccGHlCMcZPkEwZPzJO3gl0gHfouTyMgNP23V+mveyXct5bEVKSMjY35
	S0vxd3eFPpeKpJ7piSN2DwxPUjTWjlUdpMvmvfGtkLuwdya8CxrweT0YbmLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711526557; x=1711612957; bh=eBInDH1xjeg5wgxaRFkxDm9//U9d
	hLfHFrcux892NiI=; b=m+BJG5yIo7IH7DD8MwRHVwX3P+I7/+U2YpK0r2MgUPuv
	/R9xPoodYF7BLsVG1VYmjwlXzX9Q4aFI/SDYM26ai7NRAGOUWH/Bs21vPW8j2bqK
	bv7CAi6wioswskEP6tsqp7m44BEWKrBBsRFw7SxF/BBT7H7YhKxcfwZtH3luvVRF
	h/MUOVMQy3+Bb6gSHljjZ1xj63MDTKnNReFotGktsWeAeCAQ6vaYwrMJLE4TeaMp
	wud0fA9/ROKV2GP9k8VDTHY1ttxlEFqdeZS/DHgPquD5tTnIkYXynbkOmqhYMGh7
	ylphEpmjuq46OdKEwDT7SuuVX64Qr/tyMD/faFmGew==
X-ME-Sender: <xms:ndIDZlsKO-l9AfCdWAXqDYXAYJTeNAM7Gvzf5x2nwRIRD9ydBlh06A>
    <xme:ndIDZudGSxcUCp8YUH0YLvbyjz4Cot3um-GdHtIafUf57If_YnewVFn3SkqtVVJ25
    E9jOEUmHAls5DXPnQ>
X-ME-Received: <xmr:ndIDZowSFTPahPEZr-WzNNKlztYQigW_O4wBgD9gMpSffYLWxO24aK91fnMLKN0eyA8h_pTjf28VH-FR2mHzJrB255BSN04PcA3lhsZkHfZP-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:ndIDZsMZlnRqLv4afKHVyJsRo6g06NzvZ44z2hqp9hXUScL1NW4YYw>
    <xmx:ndIDZl_uFZUGSzN2U34BoMzIdfDony62KWPVSNCbWay2wnGzlNtdHw>
    <xmx:ndIDZsV0-tAS7Zf7FYLt-cW-TORba9NQcliLSjL9ps0U_PBEjm2-rQ>
    <xmx:ndIDZmdHxu3d_6-gcvqYE9fb1Qu1n4UxOGkApQoUjtbXFLEP_mr3UA>
    <xmx:ndIDZly8uyohgJj-BvWWonBtz1NBU-soJ6ah1XGKtsg9_UuFnXlOgQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 04:02:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 102057e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 08:02:20 +0000 (UTC)
Date: Wed, 27 Mar 2024 09:02:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 03/13] http: use new headers for each object request
Message-ID: <ZgPSl0hWjH5B45Rt@tanuki>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240324011301.1553072-4-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XLBuKZ3G51EL390R"
Content-Disposition: inline
In-Reply-To: <20240324011301.1553072-4-sandals@crustytoothpaste.net>


--XLBuKZ3G51EL390R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 01:12:51AM +0000, brian m. carlson wrote:
> Currently we create one set of headers for all object requests and reuse
> it.  However, we'll need to adjust the headers for authentication
> purposes in the future, so let's create a new set for each request so
> that we can adjust them if the authentication changes.
>=20
> Note that the cost of allocation here is tiny compared to the fact that
> we're making a network call, not to mention probably a full TLS
> connection, so this shouldn't have a significant impact on performance.
> Moreover, nobody who cares about performance is using the dumb HTTP
> protocol anyway, since it often makes huge numbers of requests compared
> to the smart protocol.
>=20
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  http.c | 19 +++++++++++--------
>  http.h |  2 ++
>  2 files changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/http.c b/http.c
> index e73b136e58..1c2200da77 100644
> --- a/http.c
> +++ b/http.c
> @@ -128,7 +128,6 @@ static unsigned long empty_auth_useless =3D
>  	| CURLAUTH_DIGEST;
> =20
>  static struct curl_slist *pragma_header;
> -static struct curl_slist *no_pragma_header;
>  static struct string_list extra_http_headers =3D STRING_LIST_INIT_DUP;
> =20
>  static struct curl_slist *host_resolutions;

Nice to see that this also allows us to get rid of one more global
variable.

> @@ -299,6 +298,11 @@ size_t fwrite_null(char *ptr UNUSED, size_t eltsize =
UNUSED, size_t nmemb,
>  	return nmemb;
>  }
> =20
> +static struct curl_slist *object_request_headers(void)
> +{
> +	return curl_slist_append(http_copy_default_headers(), "Pragma:");
> +}
> +
>  static void closedown_active_slot(struct active_request_slot *slot)
>  {
>  	active_requests--;
> @@ -1275,8 +1279,6 @@ void http_init(struct remote *remote, const char *u=
rl, int proactive_auth)
> =20
>  	pragma_header =3D curl_slist_append(http_copy_default_headers(),
>  		"Pragma: no-cache");
> -	no_pragma_header =3D curl_slist_append(http_copy_default_headers(),
> -		"Pragma:");
> =20
>  	{
>  		char *http_max_requests =3D getenv("GIT_HTTP_MAX_REQUESTS");
> @@ -1360,8 +1362,6 @@ void http_cleanup(void)
>  	curl_slist_free_all(pragma_header);
>  	pragma_header =3D NULL;
> =20
> -	curl_slist_free_all(no_pragma_header);
> -	no_pragma_header =3D NULL;
> =20

Nit: this leaves behind two consecutive empty lines.

Patrick

>  	curl_slist_free_all(host_resolutions);
>  	host_resolutions =3D NULL;
> @@ -2370,6 +2370,7 @@ void release_http_pack_request(struct http_pack_req=
uest *preq)
>  	}
>  	preq->slot =3D NULL;
>  	strbuf_release(&preq->tmpfile);
> +	curl_slist_free_all(preq->headers);
>  	free(preq->url);
>  	free(preq);
>  }
> @@ -2454,11 +2455,11 @@ struct http_pack_request *new_direct_http_pack_re=
quest(
>  	}
> =20
>  	preq->slot =3D get_active_slot();
> +	preq->headers =3D object_request_headers();
>  	curl_easy_setopt(preq->slot->curl, CURLOPT_WRITEDATA, preq->packfile);
>  	curl_easy_setopt(preq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
>  	curl_easy_setopt(preq->slot->curl, CURLOPT_URL, preq->url);
> -	curl_easy_setopt(preq->slot->curl, CURLOPT_HTTPHEADER,
> -		no_pragma_header);
> +	curl_easy_setopt(preq->slot->curl, CURLOPT_HTTPHEADER, preq->headers);
> =20
>  	/*
>  	 * If there is data present from a previous transfer attempt,
> @@ -2624,13 +2625,14 @@ struct http_object_request *new_http_object_reque=
st(const char *base_url,
>  	}
> =20
>  	freq->slot =3D get_active_slot();
> +	freq->headers =3D object_request_headers();
> =20
>  	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEDATA, freq);
>  	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0);
>  	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_f=
ile);
>  	curl_easy_setopt(freq->slot->curl, CURLOPT_ERRORBUFFER, freq->errorstr);
>  	curl_easy_setopt(freq->slot->curl, CURLOPT_URL, freq->url);
> -	curl_easy_setopt(freq->slot->curl, CURLOPT_HTTPHEADER, no_pragma_header=
);
> +	curl_easy_setopt(freq->slot->curl, CURLOPT_HTTPHEADER, freq->headers);
> =20
>  	/*
>  	 * If we have successfully processed data from a previous fetch
> @@ -2718,5 +2720,6 @@ void release_http_object_request(struct http_object=
_request *freq)
>  		release_active_slot(freq->slot);
>  		freq->slot =3D NULL;
>  	}
> +	curl_slist_free_all(freq->headers);
>  	strbuf_release(&freq->tmpfile);
>  }
> diff --git a/http.h b/http.h
> index 3af19a8bf5..c5f8cc4620 100644
> --- a/http.h
> +++ b/http.h
> @@ -196,6 +196,7 @@ struct http_pack_request {
>  	FILE *packfile;
>  	struct strbuf tmpfile;
>  	struct active_request_slot *slot;
> +	struct curl_slist *headers;
>  };
> =20
>  struct http_pack_request *new_http_pack_request(
> @@ -229,6 +230,7 @@ struct http_object_request {
>  	int zret;
>  	int rename;
>  	struct active_request_slot *slot;
> +	struct curl_slist *headers;
>  };
> =20
>  struct http_object_request *new_http_object_request(
>=20

--XLBuKZ3G51EL390R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD0pYACgkQVbJhu7ck
PpQRvw/9HgqLEIhLYzMKQ/5Sxe6G1QblUhpvOn/FGd93e8FYc6FOByU1j2hse+38
s6y8G2qHXiIfEXVuDcevM4gxDEfI9j49j8LQeiVPFeBFFSONR1f6iOkrDLkJsMG8
i+bAdszSNuNTixSqnk5XnE8f5JkfU6kDoTSipA2gj1QsqX2jnyAWuXbPqD4jthiy
Da+vcUhRd6SoJ9/SxZdRl6BVb/Sio3Ob4sE8Zm5uWlcTPq4ZjL7luede/u/0tAvB
zVmFiMI//d1ZmTs0w6YR1Lmc9KQ0aeHnTHYmsOjxOCwLJrigtPRtNrJLbgyXQzal
2h+F/E2LJy1JgkVgdQXXiByafeFU4/7wwRlN8159Eka/UImSTIcEcZPOsNLfDyII
x87il3LkMYqSIyqR6a5UYqi3+Dd3qeOUZWwVNl6TLmAQXUGZpO+djJ0HYNoqOqJO
4QMjo+T2vYWB5ALgmqvbJ+rTz44efkkTGSEmqJwHcAKMWDqZR5vVFTD6l5gE1LEf
5fm869IiLoL7DcCoApgDENWsezApnTb7z+hIv6Sy8Pybl5Nf6/PJmrc7aZES65uJ
gyzgCB8fYiqEEhAXspaJyHVCh7MpR5YtSoshg3qLGGvAgZhEezb3MVYzB7Y1zZCn
72iEnh+Chj1B/FUDY/WlqkG5ZtpbA0yGGmf7k9D1LhUVAsZa1MA=
=Gx0D
-----END PGP SIGNATURE-----

--XLBuKZ3G51EL390R--
