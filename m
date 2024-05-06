Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2B764B
	for <git@vger.kernel.org>; Mon,  6 May 2024 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714978940; cv=none; b=D5CVRzHc1/jQjQxmIYjMvuBVe36Ejp53cwU8tDNUuredJN4diVgy/qybjp062YQLiMDlkyhM78Y1x+UR38WCB38BV+LRkg8Bg/trCXcQvEgSEyp0rApDxMGXfqhy8YvYyFliuObR3kXFgkFKoLItW0OAhjODh1zAsiziQ9sgpLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714978940; c=relaxed/simple;
	bh=IAYQZLEsOcar6fKjzSmoQxtHa6qtjdqaW3kfbiO03A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lmm+oRhywQMf/U8IHOnHNzCHM0PKVJq4JF6NIdL4YUlMfhwdF/E6kKm589VEBTHpOXqtZgfXx9NhtalmqielhfICwPZxWwz9EXqW7kYAxQp7tb5MGOmOBcKWsnQVMOGqqmG/LSXHbR5aJHHkKEh0HIym6EfQIHa16L3goEb/Rmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dx8992J9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K25yjRUX; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dx8992J9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K25yjRUX"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id BBF00180018A;
	Mon,  6 May 2024 02:55:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 06 May 2024 02:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714978530; x=1715064930; bh=Qb8PA4eKyH
	tbg0gAmfeZO9c37PkUwN/lViEjGYfNK6M=; b=dx8992J9zelhd1USoHsHSo8xQ1
	7aHizXeK/MfFc4gTNA08MDo9U6aasbQf3gI4luKUgtUSN8gk0oekAFLaIdtCbxGq
	tZ94OKx/el9AXs2f8RmaxS4aaaona+l/HDruwYrVTSP86S2UMPBeOa3EaNx4V4F7
	8ceF3Tm8f1kNLUKmZURA2sfuGDXyi64s5cM0lA3QqhBgxA509TGYuUuLRzD6keWR
	rb7nI+R96+5SjwiNLEPu5CsUI6v7J979DFOq+PA+bY2YBqKhmHUB2EYDUnVI+xqH
	1hKYn4IE8tJh1zPV5MPXyNInEnYuZpR//I0QPksa4kX1SnD+nT2AiIfET2NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714978530; x=1715064930; bh=Qb8PA4eKyHtbg0gAmfeZO9c37PkU
	wN/lViEjGYfNK6M=; b=K25yjRUXulpcShXMTMq6ZWx0kZpaprI2UYpT4SVy9WV3
	eBGZMGltjvG3zAyhDKA8CrUSJeHQnwp+KrRFAnmzfQPibx52p+pKkCDU9YmFGvW3
	lzrFCMkII1WwL5atlX5FUltbz+5FB2AIGsHnl4oW8vYUEx9g6r6H6Gp9qq0j205G
	/elci+xMiT6TYc0xQoyr/Ej0eOx1gqoKkV5AuP75ZBlZvFNsBwWwllg5wd16FYLV
	qaaH6ScInJgIC+rpm8axTLceZYchwWVbNtTJWjC0ojHSZZmfjNk3uQCd/K+DDOga
	+F0bng6dPTHUw2LY4WXBPFv2ZhaQZPHvBdnFU+vQHA==
X-ME-Sender: <xms:4n44ZotnnUA6WDwSJ_EkwvC_aejDPmXreenvIuyAHTizOSnBRv1Wpw>
    <xme:4n44ZlcUJjRP6RlZlb8-E7K8KmZUsG0RJg5MaarXALK6-cN-Fw87o3rDAxEhCaQyo
    t-HAeMa8w9Jo7Xk7Q>
X-ME-Received: <xmr:4n44ZjwrEZSqN93Xgy_3x0PKpGfMqA5Tww0-q05PRA6-hErHlx95erhtaKazBp5ewyAMnVn27M3o20gnb0tuH5eiaalKj3oO59qUfOROn1k28WMf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpedvieeghfeftdejudeltdeileelfefhheffhfdugfegtdetfeelhffgvdfhvedv
    gfenucffohhmrghinhepshhhqddrtghinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:4n44ZrO8WqBZ_mhw2OxW-e-UJYIgReJCQTCgahmErHg_iFX-JqMQdQ>
    <xmx:4n44Zo_ucjdkaogXxmNcBBTsnM-HXPZN9Svn8MpGxZYstnIXNR43Ow>
    <xmx:4n44ZjWp_kzMXZNfshY_ly-D38Lw6Ajcmy7lpQRKOmGBRP9819jfyg>
    <xmx:4n44Zhc77fkrZCx-9o7lRw9rPGAKH8epu4wW5xHYgKY0fdb9rkAIqg>
    <xmx:4n44ZqKecZAMH8CpeB5z1ObRHdUE_oWYzGt33lOt8FsEiA7DEQmXpyVv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 02:55:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d0a0a4bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 06:55:22 +0000 (UTC)
Date: Mon, 6 May 2024 08:55:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 5/5] gitlab-ci: add whitespace error check
Message-ID: <Zjh-3dCL2-MnV-PE@tanuki>
References: <20240502193840.105355-1-jltobler@gmail.com>
 <20240503172110.181326-1-jltobler@gmail.com>
 <20240503172110.181326-6-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aSNtAQ9PnFdmZXeI"
Content-Disposition: inline
In-Reply-To: <20240503172110.181326-6-jltobler@gmail.com>


--aSNtAQ9PnFdmZXeI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 12:21:07PM -0500, Justin Tobler wrote:
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
> index c0fa2fe90b..619bf729fa 100644
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
> +    - ./ci/install-dependencies.sh

Do we actually need to install dependencies? I imagine all that's needed
would be Git.

Other than this question the patch series looks good to me, thanks!

Patrick

> +  script:
> +    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
> +  rules:
> +    - if: $CI_PIPELINE_SOURCE =3D=3D 'merge_request_event'
> --=20
> 2.45.0
>=20
>=20

--aSNtAQ9PnFdmZXeI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4ftwACgkQVbJhu7ck
PpSSDxAAqWbADLFVFlJW0guP9I/dkur6Kg1hE3X6+Or0jwsvG/VDtKMsPuAKBHbi
ydnlZCvsEt43nrBeFz/sPNZj/hJid+UqbA6pRQckv0kr+QHDe9pLdHsCbFSvcvI1
E0lAv9M64QcH17fSct9EdksQFEfZdw6rrsCDDeHyaEyppG0MNQR0bK691ysZJeFR
u14MBFFDUVI8SVb9cEAYXTGdhcUvsKzAgVFNL4QfhmRx9pFeDOIw00qxBOIFtU/q
E7Mt0Yju2/hnr4KJ0EdJlhmaB/u9mIJ/8VrH6+9pN/DDlG0RFJ5JNOvRvMuzC50L
S/p3/JWvIV5Fc2l1yIkZEQ2cBTxV1vPK+WqAJDJTYQZCpN4CNUc/fbZtpJdRm6rB
n15xZB31oEgl0toLcnuzsQi50AAEueZEaK93y5PVH6RAtmYEmdwWEXP6KR1bg6ly
DtXNIHoDP9Bz6ff9ydzfRvv8R5q8duTwaUOEEkl1wIAHQMMaeuiXGY2dcYnf3X7e
VnEvu/AeVTmJ3nkMkGaNrE5OwLAdIKG6xZY2OvDj4Pk9M+OQ0EduO3yl/hJmGlHg
WhI0LHcJOyiaKwHOOOKUr0ssLJNxZb80zf2s2lXfrp4fdSCFBYXVxHtOdfK9ymKp
a7z1jYD4CYx+sD+bNZVRjDVNnyZBK5zP3Y5spl5rc3uf4dhUJv0=
=YcHK
-----END PGP SIGNATURE-----

--aSNtAQ9PnFdmZXeI--
