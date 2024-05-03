Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74A11F951
	for <git@vger.kernel.org>; Fri,  3 May 2024 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714719422; cv=none; b=cjiglahmJB/VsBd9LFL6daBfKXx2l9kL0QfbgKPDRWdvTKUuNpMThNNeFQb7qKswNngFeqWAeJ4uS9rh99TFfkcdylL1XRAUh3TJrVahFL/xc+ZvXZxni0ipV8OwMFOQ4MZuP436i2xQreiyhgI/JOa7ZOcGudiBZB2WT7sXGxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714719422; c=relaxed/simple;
	bh=WKBtHjo/g9SM7K6/qrujDfVKleu4ZL52g0pOfvirZA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gq2fWM7NK1SQh3jDRJwGqduEOBwMT6nZdhoKa8788GeDJ7GG2QUIQK5H4+HLrGSLbbqV00RD8EZqQlIzj03m1Xu7GpEZAlh+kSMvnZtUD4eo1C6FSHcT4MivMU5Q1Z/DqzIGTd+7d0/imN1q5OUSOJ4lFVgu3W1Py4VVamDAd0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G+cQ+rdG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YBLQYqGO; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G+cQ+rdG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YBLQYqGO"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 0CE1B1C00150;
	Fri,  3 May 2024 02:56:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 03 May 2024 02:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714719419; x=1714805819; bh=41r4OfbVH6
	rJoTw2zPWCk8qsC5epl00X7zwRDT7m8RI=; b=G+cQ+rdGH9W2hkk1E1oSSEbEHE
	n0jNmRT2gKJ9FBqfFRA9N2Ayml731q4RduORsJ3HR0pnQ0Km30UKhG5/UFo9lrkE
	P5P27X8kqXIsxzWf6IlI1TOouEcwjZxaGgB9a29xw7F90n62SjjKdV1mliNl4DU7
	xvf3omKUAW9uc+Tz/mBeUmdi1xwEmqWUQ7jZ4pMtkbvorc4n6GX537FCQZfychPx
	hL3oxi8GREb4w9wdH0kXEiES+Dw8f9tziM9Sd2Ke0kw/Is/qX43NLtyeuDGJ2fXA
	wNOG4o6+NdQR+pdTyv1CYgboH00aqB4ErgkhDPyCR79Bvow5YMIqRQZNb16A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714719419; x=1714805819; bh=41r4OfbVH6rJoTw2zPWCk8qsC5ep
	l00X7zwRDT7m8RI=; b=YBLQYqGOyaLx0F/xFdZnwQDrtZwajjbZvp+Ulukp41oz
	qEoim60Zusm1Fn8O2asRPZD0RwnbpHNEHTeV56yiRCxWkl5jBZDfPR99O6JHvSL8
	PETWE8l/a1AJZnQhs6KwIy9Iq4L6wAUzPjwzo5vg8282HvJQonk5SeceqIFXe5Cn
	nFWau+mFZMpgwxmbXXlYFKF8/CpsNkqu2BE5PwB6Xez6Pr/OMqwKABFt/mjPpcMe
	QIqmf2kH9ofZ38k2AEzCB6Njtl6zg2aR0oDCjWIU6jiU+Is3ZjVNiQeEFIxjLy1K
	wywzHGq2O1hF5SsL4uxpp8mbYQZmoGDTPPiMvYONgw==
X-ME-Sender: <xms:u4o0Zoh-0mMld7ProAz6LxJJ_Qw05FOPJY1_PTnNtmpLzqTjxujAbQ>
    <xme:u4o0ZhAspHs-LdI-UOltYOWLgeUsJqZQDklwTAea99yxMQjXxkTOO236chc345zV6
    8WiLINOk4h5AENKAw>
X-ME-Received: <xmr:u4o0ZgF7nZpfaMASCZltorhm4br1LG8XRaQQObLFooOTXsLmPWH0FQRQiaxhh2yOWwaMrLH-RspM7yBbSv0KQCBEqhXQUQkCVy7gkGTJsFEZZvlJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduledguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpedvieeghfeftdejudeltdeileelfefhheffhfdugfegtdetfeelhffgvdfhvedv
    gfenucffohhmrghinhepshhhqddrtghinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:u4o0ZpSxX9nRcwJoZF3izmrkClJCHjPL7Ggd-DaRD_kyAVGACTNPhA>
    <xmx:u4o0ZlxY_c_FcKsnOLmEpbv4oaUPDIiAqslvmcAoBNuc__5w-jo2bg>
    <xmx:u4o0Zn7j9-nBkn1L9oIc1RX-dqHF5azqPp4FbfSXumRdHm3-bRBWXA>
    <xmx:u4o0ZiyitMOzcZxk_2YVw4hir6cDYfYiUXx6U9gym5gFyJz73W5XJw>
    <xmx:u4o0Zg-VoM_c6JKBwuGWNlBGkCLz9yI1V3H1XAAieRZ7Z4cUBdBtXgmg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 02:56:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9cf84206 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 06:56:30 +0000 (UTC)
Date: Fri, 3 May 2024 08:56:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 5/5] gitlab-ci: add whitespace error check
Message-ID: <ZjSKt73ohMkJcpH5@tanuki>
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240502193840.105355-1-jltobler@gmail.com>
 <20240502193840.105355-6-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pC+VkSpRLo20Kqiu"
Content-Disposition: inline
In-Reply-To: <20240502193840.105355-6-jltobler@gmail.com>


--pC+VkSpRLo20Kqiu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 02:38:39PM -0500, Justin Tobler wrote:
> GitLab CI does not have a job to check for whitespace errors introduced
> by a set of changes. Reuse the existing generic `whitespace-check.sh` to
> create the job for GitLab pipelines.
>=20
> Note that the `$CI_MERGE_REQUEST_TARGET_BRANCH_SHA` variable is only
> available in GitLab merge request pipelines and therefore the CI job is
> configured to only run as part of those pipelines.
>=20
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  .gitlab-ci.yml | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index c0fa2fe90b..6d046ce409 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -102,3 +102,12 @@ static-analysis:
>    script:
>      - ./ci/run-static-analysis.sh
>      - ./ci/check-directional-formatting.bash
> +
> +check-whitespace:
> +  image: ubuntu:latest
> +  before_script:
> +    - ./ci/install-docker-dependencies.sh
> +  script:
> +    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
> +  rules:
> +    - if: $CI_PIPELINE_SOURCE =3D=3D 'merge_request_event'

Nice :)

Patrick

--pC+VkSpRLo20Kqiu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0irYACgkQVbJhu7ck
PpQJKg//bcUagXbRBOqc5GGcAakzkJ0d5GRU0ARFJxTM3rVnT4HkjkBkQKKnOj8e
1J0PL1v6VAo6r4qvLwjqJGIBLACT5FLZ6m1z0MADZzO5ASL4XfgRw6BpY/aQKpoI
MTVw2xbXblSwGUoLUoCq01VBFB2v7g8UOWI8VT7+TPKpBzJrgBVqVg3MPRLrDuGN
/VIkofkMOfFqZUn9+pWwh+3bJKYoQ//jS9S9a/ldCP+FcKNYmdVqF2Z5PhDQBZE1
dY8W5Duyy7i+xVQ2dk2YE+TJ+Jm3rAiq5NxvX1NAzylTs3OyItezG0l5sfML5spx
98fBSQ/M/g8ihH19Tc5CYwjn+Fh2HTIpc6Fi7+ni+po6w1BKNkHPHKf//JyHIXRM
BY0Tv0ko2xxvwMCbqeVVa3yfHghHAuP8Wpb385ktzZRxH9bFb2MPz2UDXcdKtZox
vhikI1VLAY3LWT97b+XAHGVfHWzoCe5D63RE0dHymnTFYa7mhPy46Ae/ySeGlwU/
Drjd0WFQdUqbdqFumlS/obGeKANhyKJj5KKygzw1kksqLrh4KbTP87yFkRR+MuII
X45DdIjoI6se1spsqfUrdLgCHL+RS5ASYPLY3LBDiVdoTM0mOsh0C0pDhEfLBK+l
lmjUhoRVNJ9MrCAto/6ngGbRLwyb/C0TuSW7zUwMcGVQs4wFtDo=
=bAY5
-----END PGP SIGNATURE-----

--pC+VkSpRLo20Kqiu--
