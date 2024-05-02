Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F29A21A0B
	for <git@vger.kernel.org>; Thu,  2 May 2024 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714631249; cv=none; b=u7sjL5uEWbpE8GNvDqOEk5fylGzjYJEM9IXYI3gpO8wp1U5sVTDrMwh0mT8BZNzyvHjwWJY0p3sFlCepb0hiBkcVM93UwbV8Pve1KBdrUFARpOPrhXHNUwbhUv12cfM5wL6iZ1Mu38f+CmEJzRLkjbWAI5WEDdl07FVDyOhOcRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714631249; c=relaxed/simple;
	bh=/9nAWWhdVnoyvPA9CyFc7IfrhLUNOEizuxkER/uycsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0kVtAWNyqzsgTYAE6DWXEUHSGgp2f381UWeCdFjiFa25wpZpBaZSo8DG7hsmzxML2L/J2DJMAEs+CufIUEcY2kmumy2ZzoUfcG0/jb5g2X9Xd8beZtBwqD473Kpcvrn7FzVEORAkDWYtdFJsGv+ho8tuyeklEjpgd9un0tRM6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q4X6FnVk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GSkeLp6A; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q4X6FnVk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GSkeLp6A"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5A4E811400A7;
	Thu,  2 May 2024 02:27:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 May 2024 02:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714631246; x=1714717646; bh=gOJiymHQFv
	cH8T+pkysjAjygd3RY1iMq8pai2YdOIRk=; b=q4X6FnVk+KSOmENFOS+BB3gghw
	FtjyS7WrQu7QIeMXfahMHkHEf9NXsIZVLDqJtvrAd+VLnqB4ptvgpcb5oIttzt3x
	eRAHVAwho6PF/FBi1sWduyX1G6TQWh2Yiw9VRimfjpMEWHyh3zpzNmgdMNCWNt6v
	JqXAHgwNe9g4rGP5dkeTsmO9XhkgOpdTPSFVXUzAAaF98dsPSPWXM6shODx+ijDU
	Bo94f1Gmt3C0tvg3KkrpZxn3gxPj4AyyjsWKFfVW1SdvoIbNc4+zDEjq5zV4WKuu
	A8YauD6iuI7DJz4+19TAHl7MIfuMvl365JMakDHBv1okukyOmgA/S7guOaUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714631246; x=1714717646; bh=gOJiymHQFvcH8T+pkysjAjygd3RY
	1iMq8pai2YdOIRk=; b=GSkeLp6A6lyXCSocjSbziPKfKbI+NVbjXF+w+UXkpEZv
	pCPmzEpRXqOID+QuW0sLARWrl1DJwvWKbzr+TGoGj9S+QRv80lQuI/c2gJngGvdb
	5I2Vkq0gDF1ikrapQ+BnqC5uEgZGoUUBY3AEc3wBoP51YYWL78Bb+tTHnkg11hF8
	VIz0/rwWG05ZcALI/dwYfL3mw9DFE+CvM35RFn7603j8WKCr2Lwsh54OuQCKXPjJ
	ekq/KjCMTz0N7bmckxZU6DkyCwxROjNCpyL7Ui7NQCyWrD0JydHkTNXrEm1zHw7j
	LtV1ZHadJYpLKgztb3AspPEw+fLqewqugaiydmJrdA==
X-ME-Sender: <xms:TjIzZlgvFGV5Obc0bSHuhggNoVj2PZXFZFIwGMByXA36n-6AXTCYxg>
    <xme:TjIzZqBUN2m5UhZUxQOvJ_YW88q8OQdQ_pRlg3kM0QGyrTzcYk6bQvlAcGMwlA2nS
    R8ztOPMGxjfJHHl8w>
X-ME-Received: <xmr:TjIzZlEgdz3EY-fX8MSIj8ZOvre3WAQqK9XRF4OoxBOP26fkvriuoUr31udwlrsHjS1E9Rxk5cj31xrQlKdrAmrgN-A7-W1t5Xtg91ty4aB6qb8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:TjIzZqT0UIAB438nkl3tLQMAoPMQIXPC1u9M7AGOapxvLWuX9333Uw>
    <xmx:TjIzZixGt1n3Yy0TrB4-kFgGzPYJs_LDifU9cxWvLmW0EeV4NvRVZg>
    <xmx:TjIzZg4FizXkPAWR06mF_hOCHeno6uy4Lhz-BjJDcDPgUL3JMXCVcg>
    <xmx:TjIzZnxMQfJIOIG-wEOXFdBpjsTQm2w-3Fk2Nn5VrOyGQksSM1MyaQ>
    <xmx:TjIzZstuyS_Jwev5rjTl50ZhP6-Rh_YrDHfTTH_NWzbagOu5hC7v1t7t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 02:27:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a5fabbbb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 06:26:59 +0000 (UTC)
Date: Thu, 2 May 2024 08:27:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: John Passaro via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Passaro <john.a.passaro@gmail.com>
Subject: Re: [PATCH v4 2/3] builtin/commit.c: refactor --trailer logic
Message-ID: <ZjMySkLSUKKEiF_H@tanuki>
References: <pull.1723.v3.git.1714416863.gitgitgadget@gmail.com>
 <pull.1723.v4.git.1714488111.gitgitgadget@gmail.com>
 <8f53a54bbfe9a952ae5e86216681eef2a2e916eb.1714488111.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aKNSf+vyzo7oQQJc"
Content-Disposition: inline
In-Reply-To: <8f53a54bbfe9a952ae5e86216681eef2a2e916eb.1714488111.git.gitgitgadget@gmail.com>


--aKNSf+vyzo7oQQJc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 02:41:50PM +0000, John Passaro via GitGitGadget wro=
te:
> From: John Passaro <john.a.passaro@gmail.com>
[snip]
> diff --git a/trailer.c b/trailer.c
> index c72ae687099..ae0597d919e 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1170,3 +1170,14 @@ void trailer_iterator_release(struct trailer_itera=
tor *iter)
>  	strbuf_release(&iter->val);
>  	strbuf_release(&iter->key);
>  }
> +
> +int amend_file_with_trailers(const char *path, const struct strvec *trai=
ler_args) {

Nit: the opening brace should go on the next line.

Other than that this patch looks good to me.

Patrick

> +	struct child_process run_trailer =3D CHILD_PROCESS_INIT;
> +
> +	run_trailer.git_cmd =3D 1;
> +	strvec_pushl(&run_trailer.args, "interpret-trailers",
> +		     "--in-place", "--no-divider",
> +		     path, NULL);
> +	strvec_pushv(&run_trailer.args, trailer_args->v);
> +	return run_command(&run_trailer);
> +}
> diff --git a/trailer.h b/trailer.h
> index 9f42aa75994..c364405267a 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -4,6 +4,8 @@
>  #include "list.h"
>  #include "strbuf.h"
> =20
> +struct strvec;
> +
>  enum trailer_where {
>  	WHERE_DEFAULT,
>  	WHERE_END,
> @@ -158,4 +160,11 @@ int trailer_iterator_advance(struct trailer_iterator=
 *iter);
>   */
>  void trailer_iterator_release(struct trailer_iterator *iter);
> =20
> +/*
> + * Augment a file to add trailers to it by running git-interpret-trailer=
s.
> + * This calls run_command() and its return value is the same (i.e. 0 for
> + * success, various non-zero for other errors). See run-command.h.
> + */
> +int amend_file_with_trailers(const char *path, const struct strvec *trai=
ler_args);
> +
>  #endif /* TRAILER_H */
> --=20
> gitgitgadget
>=20

--aKNSf+vyzo7oQQJc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzMkkACgkQVbJhu7ck
PpSBaA//XHmU7lr9DbG8RBJ4UOgb4vGk7u5GzwASJe/MhuVpwGntwck/HO2w9sgU
DvU+zQzXh0oBfL5N0WlnpM4RGY7VAvNSmiYwPcDHIMuqgdQ7cpOySbaV7NBKQWEa
2fB6mpEtMug8G88HSr9K6djv/wbMYELduHaVOtuYtumrWoMWfowhLf86cXQi8t2k
brV8wdg6on+Q97WbNuGuWE8VKJTuN2BLP+l2N6QNsgP40Lkp7ubiF39QYBxWHevV
RB9ZUCSffVWXVRc9Nt3njUTvhQC2hwU11giLmj5mA5x1BuYZ5Tvafp2m8KuV5qyV
ElbCTnGsEz2HIyxIYY+QAQNG7C8BUJtWSAWwFSpKPvkC0g4drJqinBpa5i4WX5tZ
UNBASZdQ9BBKQlUZGogMG0v0WEW6JGBb0pgC+XeLDb8iOLzeU7oNHkJup6I/xijj
LvXLXvaaq6kaSeEzlEcBf9OYgp1kIM9lUlZGSGyXeXsVXm8B26pYJ/08uwG/vKDO
LNpa4mYF76jplsCungvjJ8ObxuPOt+89FbgDB3wA930rt8OtU+PHLPzr0sH/4cns
yl+AWUuW3Z0NTi4t6qf7i6IvS8BvLIRfQZo9SuYlhD/paQ/5X67IO/5RX6SSVyHI
JG5eXzLdZdnSR6SlZYRdsx8X+puTKCwdEHIwgnEuzytVo2z/LNw=
=Xdlz
-----END PGP SIGNATURE-----

--aKNSf+vyzo7oQQJc--
