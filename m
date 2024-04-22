Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86076175AB
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 06:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713765978; cv=none; b=pxj3ql8tVjFYULZ0ylon7RsgawhbJuHo/Hth6qOpTeSC7ZXCuhOYx5GeZgWkI9g3kUML9qCBOv7US8l50p+Q63ZeuwOOH2NcH+ZIdvWVVtJ7enLFN/J47OTRH8tFuwDnyvNO5LgtviJ/WvhN+IvS3u5EkXT47vg1yd60cCEy9KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713765978; c=relaxed/simple;
	bh=8J6q9IzhDYK200YtAiNIFUG9LURdku6TY9evmb5+pnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DL7N3Nncbnw0NQsz0hy7OsHYbH168rnqiyHWH9O3D+3Bil9ytGNjLXC7/fGsgOkjGEHQJ/Z7fVDCBgTStYRb3149Q3gVQ1yeMa2t85JDwDAPnNCRMboDsVOu2R3Fy0Y5NJZfbO5+htIAENkQDdKly5BxCmlKM6M+jPk4wdZRjKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HUpc+yql; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AX8vCN6U; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HUpc+yql";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AX8vCN6U"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6FAB71800120;
	Mon, 22 Apr 2024 02:06:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 22 Apr 2024 02:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713765974; x=1713852374; bh=4rIO3h5HOl
	6uNPJRlxSe0BX7JhA0uLX9DvpccBGmJ/k=; b=HUpc+yqldx9NTJcTD6vVIMj9Fn
	v6yFAgr1V4sejqJbAQ/l2xUmL1ICTVieM3QlCQKxaJCm8jvVpGHkZMB/kwuWbb2u
	MOEsP7qWYbjP1a6g+IiS0gUgFJ0FCnqilnT1lsl9lWmiyaimD7+YYmqkCyYisoYF
	BRhuwngwHo5GemRhrncVrAjrLyzIMwgkfu9+UtFbl94b6W84ZmZT6jYAlZbe+iXl
	E74IdiNKcuBxeZYCorDU0XeIyWsDffWpv+40N8NdQiFcNqtNVaiMk4jOk0DSFtmz
	0mmzaGOevXK3QNeT0Hg308+w0AiK9dqXdU+v1Tlxw28OIHCr3qWKb9LxL+hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713765974; x=1713852374; bh=4rIO3h5HOl6uNPJRlxSe0BX7JhA0
	uLX9DvpccBGmJ/k=; b=AX8vCN6UNeM96O4cDrRwM24Lk3VEQa2M1SLLX9raVYOu
	Z2dZ2IkFdOFMmJj/UWBs6poZ22XA/RFeS4/9To7bs32vsfjqfyadwNmyBfAIdp2F
	bCH2LOiYhjOnSQrTlFa1rw6aid16yqYa8ajbvwf/6r2ZUhXVBYzaPmqwuDaQ5fmY
	Y5sl/KZoJQsz/Mtr+obJfx7sFvjr5ZRjfDg/yVDS2JdBGzjm+CMw36PzdwH+nQdk
	TP6lBG74h5kvqJg1H12mUjafqYu6lyugDHXAuBvRiDbdybobJksTc5LEHkOQ1XcL
	JiZn+/q+rSZcl8qIAjzGp3RY/GWyYDYIgQJDsE7CAQ==
X-ME-Sender: <xms:Vv4lZtfWuRSM6bbDCYKKc0tKsAWQmr_S0eTeS1CH2PXzH4zE9InCHA>
    <xme:Vv4lZrO_T5Ld6Z0g_y4eXa-STpXgLEgLkK_TXnIh1ebJaqYTNqQU7aav446pu66BA
    fzSvhO4itix7Y6DBA>
X-ME-Received: <xmr:Vv4lZmjJk9xk_E43PAewd--YeE4_V7rNmQKPFTTeNXViL9Bd81Gq2WZdVBjVjGTNRO8tN9V5kTy75WKdjiFhouj7_gKINN2dEo-1xUefaUASVrgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekkedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeefvdelfeeuteegiedtkeehleffkeekgfffudfhuddvfefftdehkeeihfekjeek
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Vv4lZm-do9IPQ9ZBg4Y9DHpBbC8wWxnZJKt31pOtdJasaXx9I2HumA>
    <xmx:Vv4lZpuGs0_d0SzTm5H5ClbL0HNl_SwYEIvRFUcJC10cW9Ddfhyr0g>
    <xmx:Vv4lZlEuKjyV7u-AIM765ni-2WkGSLPsZ_vUPTlt25y5UfTLHKiD3w>
    <xmx:Vv4lZgMQ3ObWCjOf-fMZLBXAHgLGE0QkvJ2maZ5XfDgf40AljJWu-A>
    <xmx:Vv4lZi6s8Dyqjd4MiDOx5YJloLxOOZmH8EpPOLcMy9WQz49TdyxQ4Ea4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Apr 2024 02:06:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 52ded060 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Apr 2024 06:06:05 +0000 (UTC)
Date: Mon, 22 Apr 2024 08:06:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?iso-8859-1?Q?Rub=E9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] mark t3701-add-interactive.sh as leak-free
Message-ID: <ZiX-UB50y03h5JJc@tanuki>
References: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ARRbLgBWqlqq/nMP"
Content-Disposition: inline
In-Reply-To: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>


--ARRbLgBWqlqq/nMP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 12:22:46PM +0200, Rub=E9n Justo wrote:
> Rub=E9n Justo (4):
>   apply: plug a leak in apply_data
>   add-interactive: plug a leak in get_untracked_files
>   add-patch: plug a leak handling the '/' command
>   add: plug a leak on interactive_add

All of these patches look obviously good to me. Thanks!

Patrick

--ARRbLgBWqlqq/nMP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYl/k8ACgkQVbJhu7ck
PpSNyxAAiZWTTjfUxxiSjI2UV/PAnrWOA6yktM/TPUrMVI6wTUokkANmV512xwYY
v7Pf/A92NLdWdY5Zy7FBOA0nPL0rB+MHhU+czINP6hjJP937Kbyc1tZaJxpGpWP2
lA2Spdd35P7/3pz6oAhjHeJy23IJ49EdyX75paWqzkALnurLPwuOqYwu0cylijeY
YIdvd7q3G3ySOpufLItyi9yGWLyEhmed0arI6OgiskPk9ahkG3tdsvj3lqiU84XI
a/aGU9NVLjPzNivHkgS3KF1U7kIfTFtJ/8Z5uAmzzS69S0z9M/fxGzCGKVMt3Lfc
A6DClCfTK0Vqkdn1gxKqcWGVVL/7KoxsdGMHC01QrNZMtlbjGszbh89/FKEjtcw2
t8KXI/Qp+NUN8+qRn9rkOpAnxlWn26mES3fB13I9IOUQFr02Lhd5bIngNJzXhKTz
U4XfFLRO5fO3WYcgtGtvp3y1KUq2wJ4KWkOvgl/sUvwURbaQboWr5CReX/TOj73d
M1FWp2QPb/j/kpYBXcl96OkerBjbvQ+Vmh+0O8g1yIDXnuRJpa4AeBcUXoeDGgJH
zkpAF1K1iyfEICABAy1CUkCuouG3q0UJBenSv0rznF5NlxCFoA+fVgmnTzI3vD7s
/3oao9S75bfkc0k/0odx2LP9kI3GogyHbev5uVuyexwvCMDZc0c=
=ZpVD
-----END PGP SIGNATURE-----

--ARRbLgBWqlqq/nMP--
