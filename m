Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ACA1667E3
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674538; cv=none; b=OSRpDU9e/i9R1aKMmUJ+vwbGPppopfFIb2gXozgBIUT3NJkYdvt0md7bzWjVZ1J+CP8yvKRtImV34ConO9bbBHX1Q4Dref/Osq5cPl6Qy6eih7Nf2Bvunr1cikTKalLj6TxZwThsEfxPHfBxyz0HP64xLLhbnCxWGIbAEC8XSHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674538; c=relaxed/simple;
	bh=iqRseVSDi7qmpM1NGCARY0B91Fco/xT2keRvsY3Cc9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2an0evy1zzVdXIOpPAs8okwoXbQmR0h/FrAc1y27WWmvttuIQKY1+hFekyTMg7blpYV2XQqLl0i+NMG/sC3g9sutl+bv6eO7iuxFvlnfE6ZxnjuyxMvI3AOum9Blu+/SCTxvOYUL/bc7IEhJKh2FrFNZntRR4ADXc+6ToaXj/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EzQZ6ySp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M0J0m+/o; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EzQZ6ySp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M0J0m+/o"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 50186114021D;
	Thu,  6 Jun 2024 07:48:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 06 Jun 2024 07:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717674536; x=1717760936; bh=LOaEJGOaUR
	fUsacp+4fAqGQsq1ivyIwgTo52oUlsoDU=; b=EzQZ6ySpmxeDxN04WtY0tBCzJu
	+CvGWJUPG+CTs0M6FdMYLR37nAJ78BK12/RCV7Xpxnfl0jpyz5dhAkF0wZhbipaW
	vXG1tslkeEhbl4w/r88PTdxXxOFvwirqzxhSZ3uGTAuDCeyBwNVGHIAQsrbU9Bcm
	jQUF+DB271uVy4WaOeTK/2Jz15s8aL/RBAFU2grn8ThMZi88mO5lCUjKJf9RHW6a
	UygL4wjqBPdMjGBVp8Ad5+rS8vvFpMvALv0dlZ+t5+MbE49ro2VCzJqG52qbz4AV
	ZzdYBuK34gt/joZArf/qhKDgFCDQnHZ4gKnbKM404g11lcjVaCXQg3IqYSIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717674536; x=1717760936; bh=LOaEJGOaURfUsacp+4fAqGQsq1iv
	yIwgTo52oUlsoDU=; b=M0J0m+/oTEMYRMY896jf5V4ALZ1kRNVIKOT4KB5ZnHfa
	y+t0hFueb3yT+FqduxO4QbgUQOVb3d5UX3Ak/eqi9lWYsqZTGoahlZ1DG2t9OVGK
	nLaIXQDNCOCG3uT2+NWZ9QYmoffbu1rBzjNFsjqrpSmVpBt/3BP/AyFwndU2PKnA
	mSKERLmL5SSDkTlNzbCP8oE0ufxp7Js9NmXWwqOQE+cO6WIhj4KXcm63UvmBTyuB
	+807yFgGxPfsn8/vFC+RIt61cO3XvCMJSZ2/84H08YIk/8AL94CK+dUuOg33PnTZ
	6ov4XZhgFWqwMVlYo0hm5qAsmFeMxURKvPQ38Jriqw==
X-ME-Sender: <xms:J6JhZpHJ3zN1BsAaqnfH0J7Bk6BcL-ZY8DyXWv-5LlnZFLsyat_npw>
    <xme:J6JhZuU0A_15UMJDrlfSUBjiPpMOnD2eKV4XSKUiJgj58k0fG2EfrHa1rIl-mCxCC
    2hOZfVmHgNI8IB0NQ>
X-ME-Received: <xmr:J6JhZrKbX-xBQ0g7dSCDXm0CjVvF9Caz2RdAJGy2kNgG0qXfvFcB8wAz0x1e3ytmrqEn4cTcpeD_CZ2VTn3jdF8F52Tn-DpN0hX5rxZYPgnA-WDd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:J6JhZvGikrOkxG92ey13Kj8Pju1Kjlb67MDZa3h8nFU1hSyO-IZjpA>
    <xmx:KKJhZvWqQ6SYUHhlntIlRYLbAM-TfGar71QbACbT_1xArSuwOMGcQg>
    <xmx:KKJhZqOEKk1ZpnHmiNw0WnLNtuDxFnW8O9QElPpmK2Ix6ID35j7Zwg>
    <xmx:KKJhZu18JiHyZrTm9voLAurRlTrHU6O2FT6vNsM2Sca23NUPXPje2A>
    <xmx:KKJhZqS7E6mWhCJP7c1Y0fiYMviWbqb_fywf1AeH8EZSanN_Tzj9y-Kx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 07:48:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 85c6f7cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 11:48:23 +0000 (UTC)
Date: Thu, 6 Jun 2024 13:48:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH 4/6] t-reftable-pq: make merged_iter_pqueue_check()
 callable by reference
Message-ID: <ZmGiJHeyWO4X-mev@tanuki>
References: <20240606075601.6989-1-chandrapratap3519@gmail.com>
 <20240606075601.6989-5-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IR8lxY3t0vSXyueN"
Content-Disposition: inline
In-Reply-To: <20240606075601.6989-5-chandrapratap3519@gmail.com>


--IR8lxY3t0vSXyueN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 01:10:48PM +0530, Chandra Pratap wrote:
> diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
> index 5c5a4ecdc5..30bf9cb492 100644
> --- a/t/unit-tests/t-reftable-pq.c
> +++ b/t/unit-tests/t-reftable-pq.c
> @@ -10,11 +10,11 @@ license that can be found in the LICENSE file or at
>  #include "reftable/constants.h"
>  #include "reftable/pq.h"
> =20
> -static void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
> +static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
>  {
> -	for (int i =3D 1; i < pq.len; i++) {
> +	for (int i =3D 1; i < pq->len; i++) {

Nit: we might also change this to `size_t i` while at it. I know that
these changes are not super popular, but I eventually want Git to
compile cleanly with `-Wsign-conversion`. So the more issues we fix
while at it, the smaller the patch series for this needs to be.

Patrick

--IR8lxY3t0vSXyueN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhoiMACgkQVbJhu7ck
PpTvBhAAmzlQIgW53annSY24IEAYNfJVX8tJgqtuz55mA6ZSsvGuzbdHTkjr+Bai
Ors3lIH5eyvbC3LR6HKpoy/YPmhP8arvXG/9LMLHWDe69YxDqJY/HemTxPLyJ9ZG
wlTMDz84+wfqbaztZsczs88cA7Ih18tIMj9wKTr7q7/aS6B514UrxZfsWB33x5Wa
qo3UoUCgn0xjJvUdDzVfgg45+/F5BBj/VdcxPmf1yUcTDmjTKoGi7DuL/RZDVIV/
kCRwRruvJgp28KkPRmottOH3/tqUgla0ME+23WJenf56nQ1sY1sGpufPKVoi/bM7
sOU8qeFhzdjgGbr2YHSfxIRXrFKQcrIBP3OC6UgnlPp15YxHgCbOIScS/XkYXVZX
uqlsbSxwroOVJ+VuxVY/OJp4iXV6jUB3mGErgdKFb2JwO/KUF+vB0aeTABjv8BUI
f3l8xRiyrRJjDdrIRGIiM4pmr0OkfUpCuN6vwnVaeNa99gb74+Rym1VObHTLyJEl
Mw3lfUtjhMWtj5z4ucNeu8gyV4DAlhfQr+PpUyg/neTMXqYQDRyKAYzBZs8XfJ1/
CZuh7TrR1rjARk5QuRZ/F8fDkKYZs2y6LfDT9Ge0qV0h1jx/kMrqFKsz3JNgYIpp
WxppYiGD3VG1sZj1MOeRul4QbGGRG6lpRL1vW/w0PIQ1olUJZ5k=
=HDMb
-----END PGP SIGNATURE-----

--IR8lxY3t0vSXyueN--
