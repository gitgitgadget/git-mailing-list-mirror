Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD01651C2B
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711352327; cv=none; b=fGLCPfCtEgPCh8VmFBKvgPYuF8FD8x1B2SaYSXP0dmNp1w3gioY2lyOQWy8qranqjFADUTVrjMZ1lk4btA0qFYGJ1D5i/69sQ7MGW4MHoiqJAqqfPKSNXC3ePgESnRTqCw4WS4xZI4rJOLEgEqJ7yocHIoZ6ZHanBTkZaWcohok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711352327; c=relaxed/simple;
	bh=/ZZNaY98wXVu29xJQBykwvA67ABe2DUOXe/tGnFv6f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQoU5vnc89Ryw2jIoR/ZjYtTKDMylUuZVUP8Ddx6dqcjsPTvWp4yls3FnTV4ak0Xyt1zpRinzoqmPzOc0iwgmeIro+IG9EknAfNcmzgmQMSVLkgUIWWJGc6IF0dWVGByuj4A+bhk1lJT1URsFlzWQOjCFzC5EevpQZQnZlP1uQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jM3KCwIy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XODHP6VV; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jM3KCwIy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XODHP6VV"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CF7E811400B2;
	Mon, 25 Mar 2024 03:38:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 25 Mar 2024 03:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711352324; x=1711438724; bh=+fHhZz91EK
	1NnCWJ8igJ2NWMuaJXZHtsevliyyoo8uU=; b=jM3KCwIynCiRE5NOGVWWwJIDmG
	9gnP8tmDTV15QVgvozrBkGc1nPnsIt0pERXrLTcYmQE7EDlHnNJ5FNnhkyBISPhd
	y7T1fe5xC8AmC4o58707b4qjYnF4KQ31J4mm9kh8RpkhR+wnuXggebxjQQZPEF9L
	MUWlRJ2fYbud+hgf2/1FJKRp71h5iR8XI+ePr9kleKeYJiZrFInXXNcgw7aEQg3Q
	vIss1noQEXdesKDHScVCmdLCrFzAC7k99IGq2NCnV4jsX4jeW8nXsihsR+lVjpWr
	SQCDjwgcZ7zNIVduyzoZ6Pw9z08BqhMqeA8wgvYMH1mAQAftmWY4zO/4tC/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711352324; x=1711438724; bh=+fHhZz91EK1NnCWJ8igJ2NWMuaJX
	ZHtsevliyyoo8uU=; b=XODHP6VV6fR6cu0CuePSbOk2ryTQIm3UtGZZSFYu0ktQ
	Io/bbbpWuZLqXGWSdGFFNBYnfbsj9Gi4fX8WiMpga88kbofo96TjvyRBiEvH+OZ5
	DOS0+Ovhxe4ywFLlGq4ip2+MhJ6sqgZgLeWfHiJXaaV87LX5bcsAaZWtN22+Pka7
	WLZbYHRrC1vJHhwyhPSTf26lCICblYbRnRrJgpfagPukDbhMZaHVjhLIPDXC+Swo
	FhPlSeEdmizFWVHfZjk6/x6Vio1KUUX1OaVFRTwf6RAsUNsc0mcPqAvYq+Fie/2P
	Jyy/+hacVNm0407brxHBSfv38r6xNzsxv6tIXoIEXQ==
X-ME-Sender: <xms:BCoBZv8H8WTe8vjgDNj2fSl5rtAQ8ZqNqgzALoRndYmPj-rgGME7SA>
    <xme:BCoBZrud2VCR_CfQc8hz1nPPHIDMIDhZaIzn49PqK7UTNUHeYifbH7Gq310TeHXrc
    NXHWi4OcspsHoDvaw>
X-ME-Received: <xmr:BCoBZtCCInov_V-_u6I4hTjCRNGbLt6O40HKFYlTF5j80Qfyvv0NdwpSDSbzKPCORS8Q-S4p866fpvx-favvz7fI13N-ldb9cqUruyBoxe41LQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepfedvleefueetgeeitdekheelffekke
    fgffduhfduvdefffdtheekiefhkeejkeehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:BCoBZrf-2z7gj3eVHyls2pfMk9JubcY2waVwFg1w5IoBTjj0aAkB2A>
    <xmx:BCoBZkOieymDV6xrWPWw8yLySJEvW--Vfi6Na6aRVDLaE0iWB4JavA>
    <xmx:BCoBZtnkFu4bxXlI-YcpsksDwRe4OuWTNUz7ArCxQBplMgzLhVddxA>
    <xmx:BCoBZuv3A4peRx8IoP6mGHni6t3i1kq4l67pERYGaJ3do24dP-kDSQ>
    <xmx:BCoBZpqsG6k6OEY309d4JSfMkSJIQ14egz6M9tVnW9AZc60g8OC6uQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 03:38:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b99839c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 07:38:33 +0000 (UTC)
Date: Mon, 25 Mar 2024 08:38:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] midx: use strvec_pushf() for pack-objects base name
Message-ID: <ZgEqASsDnaovUV0T@tanuki>
References: <9483038c-9529-4243-9b9a-97254fac29c1@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g++RpnoMpqpaXBSh"
Content-Disposition: inline
In-Reply-To: <9483038c-9529-4243-9b9a-97254fac29c1@web.de>


--g++RpnoMpqpaXBSh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 05:40:00PM +0100, Ren=E9 Scharfe wrote:
> Build the pack base name argument directly using strvec_pushf() instead
> of with an intermediate strbuf.  This is shorter, simpler and avoids the
> need for explicit cleanup.
>=20
> Signed-off-by: Ren=E9 Scharfe <l.s.r@web.de>

This patch looks obviously good to me, so please feel free to add my
Reviewed-by. Thanks!

Patrick

> ---
>  midx.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/midx.c b/midx.c
> index 85e1c2cd12..41521e019c 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -2163,7 +2163,6 @@ int midx_repack(struct repository *r, const char *o=
bject_dir, size_t batch_size,
>  	unsigned char *include_pack;
>  	struct child_process cmd =3D CHILD_PROCESS_INIT;
>  	FILE *cmd_in;
> -	struct strbuf base_name =3D STRBUF_INIT;
>  	struct multi_pack_index *m =3D lookup_multi_pack_index(r, object_dir);
>=20
>  	/*
> @@ -2190,9 +2189,7 @@ int midx_repack(struct repository *r, const char *o=
bject_dir, size_t batch_size,
>=20
>  	strvec_push(&cmd.args, "pack-objects");
>=20
> -	strbuf_addstr(&base_name, object_dir);
> -	strbuf_addstr(&base_name, "/pack/pack");
> -	strvec_push(&cmd.args, base_name.buf);
> +	strvec_pushf(&cmd.args, "%s/pack/pack", object_dir);
>=20
>  	if (delta_base_offset)
>  		strvec_push(&cmd.args, "--delta-base-offset");
> @@ -2204,8 +2201,6 @@ int midx_repack(struct repository *r, const char *o=
bject_dir, size_t batch_size,
>  	else
>  		strvec_push(&cmd.args, "-q");
>=20
> -	strbuf_release(&base_name);
> -
>  	cmd.git_cmd =3D 1;
>  	cmd.in =3D cmd.out =3D -1;
>=20
> --
> 2.44.0
>=20

--g++RpnoMpqpaXBSh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBKgAACgkQVbJhu7ck
PpTPtw//Xdk11OqMAZ5LboOie2NVLzyrvEn2kkcZCdJx+a0qjQgDOBSoAu6aEQ2+
/AbtcRlBNj3jh0Vkac0KihHzmPDhIdnfW85Mzbk7xKR+oxT5WN6rQ1yYUpMs+QDn
+0Y6CrlCmPADKxDlcCG0vvDBMNESNhUhYIEMjB37GuiUByEao6R8ycrYlRClEv1q
+GAOLdAAPQpMCfebuZskx9pkURTTzCgXhDiU1gzdkV61wZGXe6zrhKDPQ0FPkJU+
yPekWu6GtZzj14+kWzVi6AJ/nzWn/cQfq8Mc+qOuxiC12ugb1sptbmamZWHIPjYH
ihj0cp49nCXdXOG0qD1VyehCFMagbooEWi2XpMleGkStftSPyYDocTQlPZq8fmT9
qX6k/4IW9Ii5LGeQiWybJj4+m6Lv/hd5Hbtd83m11My4BzleZGyURixMxJPTi86A
3zacWqrCQkPRCVaRd/kGmCXNTo756CtJ+Q4gjsItIqmkjcuB6EmuH2iMdshYqtTg
U92EIt55duJaV3oyMLGBhN+PlV6QOGCk9sar+Jn8tMJ9bYXB0tX6QXJHi8cWysxp
vi74tmDP3iDqsnuiON6v3SH95fPYzQ/jZ2NyYdmnP6M0xpqoVpMLj8TthdWOyNOi
QsaT5abGNk8rBhRtya5mO3rLVk/nXxlvjkDqfHz82VUsGEGaQ9Q=
=sPtr
-----END PGP SIGNATURE-----

--g++RpnoMpqpaXBSh--
