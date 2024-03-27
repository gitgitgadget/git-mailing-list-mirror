Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CA2E541
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546248; cv=none; b=KiOZNFFKYT639CANsGTPEnoedbPg5fPiB9BWmEkNDn+eBMX/Cy6s/MOs9x7plwyt7YO5ABorZ+aMWHHEhvtw6Z6C2zKg1/Hmnmc89wymld54bmrRfaal3pLPMafUCo9G6ARJ52q+ZX/BxjvIrtIItyt7CyjUukw2w+wT3oc3INs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546248; c=relaxed/simple;
	bh=MwtodLNMMriBlU9ce+Dl6nfD2zESSpr3O+znfCwcO3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXoOcBckmDd7HV8DdTKp/FGbJKZ2MoqSADF7tbAnUWJ+dFzG3A3I7vaDYynvVfs9cScIzcgl6+q98z8dFXT1b81rmxk26uDsGUGTMEkCZi+46swF9llkuH3MPXxeg7jJSoVtwEH3qLlVZz1CSR3mfVUV8wY4WXeS1ug33+LcRE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fvHF+/+r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wz5PJ0Ta; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fvHF+/+r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wz5PJ0Ta"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id AC7BF1C000A7;
	Wed, 27 Mar 2024 09:30:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 27 Mar 2024 09:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711546243; x=1711632643; bh=MVKdoxlAmI
	aP44t9wZ5iGNAZackLUguTFgBPpxVG8DI=; b=fvHF+/+r+nKC6/Q0HQubZDeOWx
	nFp5KYZ7ps8H8OjAPTfN3jBfk8xQ5aUqGzX4LgcemyvwBkm4+OQr5DccTJb3JLpc
	e0K7mq5uE56MuVBTglFB3N/23+8vKMheaUhjTNcn5hwK1gWA8mX8W1DYbAqfS/ht
	BUA9L8yBPDVmy6Z2TZ3ARHOJD0LgrCJYN9xXhhRpUSZ1U23SoUWlT1ItsaXa4ClI
	6HcFEThs0hRoB/FULTuUyy5PpYWbmOmh1esEn0fbzFyECQSKigRelbVqHI3vrSTA
	lVp0BRrH5IOiOQMO+6PUHgNXPKNFkszhyMoMwCbRKp2PmzdE2pvunOScxJqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711546243; x=1711632643; bh=MVKdoxlAmIaP44t9wZ5iGNAZackL
	UguTFgBPpxVG8DI=; b=Wz5PJ0TazuoRYCtv9aAkhG0/Vl3ODm55pYGwawCVAI0D
	MmuRvzNtcytGyotXzf4Re2GMIlpDWj3avWN6RVR5OzDBrnLUyGYYwIoFgK15avZK
	JbOcwiC1XZt0G8tB5l78gBaZgMlrMLgkgFNl+UiwcIDG7GZjN/g1+towTd1kHfFn
	8b11F7zVPd6UWAcnI4Xhy8lPjPuPs/ynw0H1NMKR+Jat8bm7YjZj6O7pcm0D6IEC
	r1v6gJdFwEXKXioBrP6MKhKWz2V1xE/SzINg9ClRfAmVXFUlMsT08tDTloTJhYIW
	8EjldtQ+A0xR13mRe5gOhlIf4E03xR2do/TrOVnFXw==
X-ME-Sender: <xms:gh8EZgxBy1etdQQp30YqBHlPcURi9z7-tip8y0kW9YK9TvSJm6s-gg>
    <xme:gh8EZkSWAaXu_qeMmPsU_KM3pvjjTwDHLc7pdD3xVmJCoevx1cMrZJJBjCTfegsiu
    YIXnSxLC6BNaZhAmg>
X-ME-Received: <xmr:gh8EZiVrviQw5Vf7P02vJ-lnxwo5510IwlKW3Ve-R1DdpvOgrtJDVIhetL-cqY_BlTanA6VJzTCSxQqxe5ykwxYf_cHkvfLhHNTJmuaCd8Fs5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepveehtefgveetfeeufeduieffkefgledtkeettedtgeefveetvddutdefleetuddt
    necuffhomhgrihhnpehgihhthhhusgdrihhonecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:gh8EZuhIVtoe6mDwtptSoyDnU4GJbfVd2fKj8N8ejFeHtVx5vGvpXw>
    <xmx:gh8EZiA_YR5S3-8VACrajNVZDQ_VTviP0NjSsnmPtbskxt7i7zaQHw>
    <xmx:gh8EZvI8hcBFESp2gpCXBlYh_InlyOZtLbwCiemks2c2MuAJU7km4g>
    <xmx:gh8EZpDwMSt-6mc7xeU39lWIOXpZFR1pCzgEj2BkvxqbLpoHh7kY_w>
    <xmx:gx8EZtOOqZS_I3pQxn40OWAZxRXfGQWRnL-A4AB3X2wkzn5tBkEzYpqgihA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 09:30:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 886cbcd8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 13:30:25 +0000 (UTC)
Date: Wed, 27 Mar 2024 14:30:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aishwarya Narayanan <aishnana.03@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: GSoC 2024 [RFC PATCH]
Message-ID: <ZgQffea0krKmZUEt@tanuki>
References: <CAHCXyj09EKKdBOAdQ319LGY-6GbQw+HHp9u_Mbpf4C+wF6ReSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qqRxyiPbaeygGqUL"
Content-Disposition: inline
In-Reply-To: <CAHCXyj09EKKdBOAdQ319LGY-6GbQw+HHp9u_Mbpf4C+wF6ReSw@mail.gmail.com>


--qqRxyiPbaeygGqUL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 06:34:41PM +0530, Aishwarya Narayanan wrote:
> Dear Git Organization,
>=20
> I hope this email finds you well. I've prepared a patch to address an
> issue related to the handling of exit codes in our test suite. The
> changes ensure that the exit code of the write_utf16 and write_utf32
> functions is properly captured and not suppressed, improving the
> reliability of our testing process.
> Below are the details of the patch:

The mail's subject should ideally be a short summary of what the patch
does, whereas the commit message here should contain a description of
what the problem is, why it is a problem and how you fix it.

> ---

Additional context like the greetings you wrote above or the trailer of
this mail can go here, between the "---" and the diff stat. This kind of
information should not go into the commit history because people
wouldn't care about greetings when going through the logs, but about
what the patch itself is about.

>  t/t0028-working-tree-encoding.sh | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-enco=
ding.sh
> index ad151a3467..f372c14bc0 100755
> --- a/t/t0028-working-tree-encoding.sh
> +++ b/t/t0028-working-tree-encoding.sh
> @@ -19,10 +19,13 @@ test_expect_success 'setup test files' '
>   echo "*.utf16 text working-tree-encoding=3Dutf-16" >.gitattributes &&
>   echo "*.utf16lebom text working-tree-encoding=3DUTF-16LE-BOM"
> >>.gitattributes &&
>   printf "$text" >test.utf8.raw &&
> - printf "$text" | write_utf16 >test.utf16.raw &&
> - printf "$text" | write_utf32 >test.utf32.raw &&
> - printf "\377\376"                         >test.utf16lebom.raw &&
> - printf "$text" | iconv -f UTF-8 -t UTF-16LE >>test.utf16lebom.raw &&
> + test_utf16_raw=3D$(printf "$text" | write_utf16) &&
> + test_utf32_raw=3D$(printf "$text" | write_utf32) &&
> + test_utf16lebom_raw=3D$(printf "\377\376"; printf "$text" | iconv -f
> UTF-8 -t UTF-16LE) &&
> + echo "$test_utf16_raw" > test.utf16.raw &&
> + echo "$test_utf32_raw" > test.utf32.raw &&
> + echo "$test_utf16lebom_raw" > test.utf16lebom.raw &&

On the technical side: I don't think that these commands actually need
to be converted. As the microproject site [1] says, pipes may discard
the left-hand side of the pipe, not the right-hand side. And given that
the left-hand side is in all cases only using `printf` I rather doubt
that this would ever really fail.

So ultimately, we care more about converting sites where the left-hand
side is a Git command itself. "t2104-update-index-skip-worktree.sh" for
example has several cases where Git commands are on the left-hand side
and that could be converted.

Patrick

[1]: https://git.github.io/SoC-2024-Microprojects/

>   # Line ending tests
>   printf "one\ntwo\nthree\n" >lf.utf8.raw &&
> --=20
>=20
> I kindly request your review and any remarks or changes you may have.
> Please accept my apologies for any mistakes or oversights.
>=20
> Thank you for your time and attention.
>=20
> Best regards, Aishwarya Narayanan

--qqRxyiPbaeygGqUL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYEH3wACgkQVbJhu7ck
PpQO3A/+PmVj0558JFeFVUUjD/+rmhu75Fw5Nq+PgrGh2XuI5fJI2dDIWFCiGvGU
j1qIXqf4ll8wxXU7w3DruODDXF56oZpCSi4KXZnD/I3J//SJL2/yJ4baVHiP4ZXt
8rSZ5n8E4KmqgvbGskPewQNRbX6v3ML0iIGI9MyixXGjbAPtWNOOtBwCBwnKdD1i
KbYGv0hIUIyyjD5z4Tbh6l7rg12VYKN2BgyyKrzji30uXYWYD5Y0M4PK7w0cHCf8
efdVb1QetGyXeXIHrMlH0/dNhOyxPpimY22NOzvmwf7RVLMSd6YTHhreXsqEXyPc
3iWXte78/YkTUij5GU+zJ9jBmqB0tUv2WAZGs5Jy6tqbJxr6Uj5cRqFlYcoaExpy
ById6u05kfa1Bq8xM3hH5WURMtw8ia8e+ddEZwmfhioBuSrLHceVTsU3crVQxVW8
A+V94FFN4rmz3L8MUC+CsVZZHdos7xyRLU1KeOmEJorzWEJiB5Om6qUiFjSrv+gj
fbdchKpzT3b83jDkhj3mpfphXlxJcg+qy2rfBfhamVXXrjWJ3te5BMqaotNM+3gU
ixvQTjHvPr6uJ+PaAyNuVGpxdmQ/fH/MV+lE00K1DJuVB8V8LHMf5Hvs3EciIkpG
nYeeXjw/ZZDUJIR/GQmgMG+dIaDUAIuc1xZhDukL4uikQFfmtC4=
=1EWz
-----END PGP SIGNATURE-----

--qqRxyiPbaeygGqUL--
