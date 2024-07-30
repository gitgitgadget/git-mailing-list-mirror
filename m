Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6217FBAC
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321144; cv=none; b=HLka3D9fajuRC6AmvtL8a5U6aw/umyiO06mV1c9A1ebVCVfR5rsCpF2IiOx1+PQ+BpXMd1h4ugDcWjGms4iT7u+ARHaSeOykRBifV01sY+KnWZsT6J1RJ0BWWv4qzVlvMqhrXMM3iuK4Vvt442Xf0gey5U/rRQfq/rcF/FRRrk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321144; c=relaxed/simple;
	bh=ld++x2SysESy085p3KzjE194eiqKsy0SCK/MgIZBFFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tE5HxMFkuS9WfC67uQKWMbYhzTg8WVnudZ4mXcMweqZaAtNyaFRtoo0Ll5lQJzV04QgtaxpJRUpvo88Klosxit1QCIGtdz13Jl7y/nLfv0lWtpnUoty3W/1ceCYdUCnhrSEPJz/bLV55IAQnBi4iTxz+unq4g2/NEIeVdD1Es0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GV2ykFDS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gwlfAzWM; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GV2ykFDS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gwlfAzWM"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4ABF111405BE;
	Tue, 30 Jul 2024 02:32:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 30 Jul 2024 02:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722321141; x=1722407541; bh=qCXHtCobnf
	PUGYQs6L3HE/oKV/H59q+Lh3yMFSCYH8I=; b=GV2ykFDS9fTE6yk8vOc2uhkLpt
	UNGWyP4+Ft2njNzkBZSx6Vq47BfHPvm9jK1EQvBnC1BMQcHMMSi8uf6iKA0Ziqcw
	VZAZ+Vd6RMBheaMtGE+BucwK6UeRFTm9hUk/uq2Ufzppcslv0H0Fy369sShsQqfQ
	oGahG0F7n+5jUn5MEMDGhNJHBmh6w7OHVFMqaMSWgECKGVr704m2rahgQAV7g+MC
	THJNLtQT6Z25tsP+mrM+8VPp3bShfrltO14q2WokGu4W67cgaL4BfLnqpupBdiLz
	MNXUt5mzByxR5APCZCDg+w50AZU5CCSlRg3bUFdy94OYk9gYj6Mg9u2dRPTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722321141; x=1722407541; bh=qCXHtCobnfPUGYQs6L3HE/oKV/H5
	9q+Lh3yMFSCYH8I=; b=gwlfAzWMEWtACHe/ByXy7tUaaioMoMVtGJsK3l+aOI9E
	GGInfz2creLeNJniqfJQv2HofFGdOU3aIa81MChk5BEg+7frz0xVC9aMnvLgZhM5
	Ug0Yaz0QOtRSKI4JoeLoRI0si7vhXajqpvWkIbxqqITv8a8SHCZAYndmpnRGLkVm
	ktIeBtymsSGlHTFPg5lEtc/xUjTSnwFt1unLo+LZqAk1rloNEv1xFsAtv1Eb9Zyf
	9buS8H/gxWS234BDGISRLABwYPHiCt3YGM3q6tAzmkGBGGCcqqmLpM4LmDOSmpds
	C+SYCRVUn3poVGyoMCssYXTb6Gb1qv2tNz3cecjFaw==
X-ME-Sender: <xms:9YioZuCUF9_TZscwewe0WppEXaPnt8QocyBR8xpoxGVHn4rclR_N4Q>
    <xme:9YioZoi_QfNxP_z4kMu7Pyh2M8n8LTgvOvdcdjZr191Ntm2qWHDGjtXi-MmejaH99
    eIw1SjyxWD7QIATzA>
X-ME-Received: <xmr:9YioZhkV0x0FmZ-NJUAQyc355HI18668LYy_Lf4j0YwHtUbzSHFR6UHYSv2TZyt5ExEghPfb-aB2BChYFC7-TexAqpouooRmqTeYq5A-IGS4fx4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:9YioZszdw71DWF7mJsiR7P5n-xWUBkzBR49JtZ9bEQfDw0iyB_7WGQ>
    <xmx:9YioZjR8_mHslLsqPitXHih5pMMZ7DBJjw9qCYMYW7eXj-5Mnb2WjA>
    <xmx:9YioZnY2yHWiZBU6ZH-sX8CY_22kKAcYyW9WD5OSNMz2BNCRmB0oIQ>
    <xmx:9YioZsTFkgKTPIPjq2wkAPQm6SGBptJgnp9sEHW0ifqB_bT_PfrRPQ>
    <xmx:9YioZte0WJfOxZHIXwiGRtoPiN8ypP9MP86IVfYYfNouaSNTnUJzdsjq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 02:32:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7a570499 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 06:30:51 +0000 (UTC)
Date: Tue, 30 Jul 2024 08:32:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 1/3] Documentation: clarify indentation style for C
 preprocessor directives
Message-ID: <ZqiI8H0Zbu_Zl2xS@tanuki>
References: <cover.1721818488.git.ps@pks.im>
 <64e0b449936a6828ead98438d621f7e7684546c8.1721818488.git.ps@pks.im>
 <xmqqv80uwxn2.fsf@gitster.g>
 <xmqq1q3irrgk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JB5+2DNbgiVwtATc"
Content-Disposition: inline
In-Reply-To: <xmqq1q3irrgk.fsf@gitster.g>


--JB5+2DNbgiVwtATc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 10:06:03PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> There has recently been some discussion around how C preprocessor
> >> directives shall be indented [1]. This discussion was settled towards
> >> indenting after the hash by two spaces [2]. Document it as such.
> >
> > It was settled to have space after and not before the hash, but I do
> > not recall ever agreeing to two spaces.  I prefer to increment by 1
> > for each level instead to keep the whole thing less distracting
> > while carrying meaningful information.
>=20
> Using the indentation consistently is a good thing I do not object
> to.
>=20
> Among our existing header and source files (excluding compat/ that
> is full of borrowed sources), scanning output from
>=20
>     $ git grep -e '#  *' '*.[ch]' ':!compat/'
>=20
> tells me that
>=20
>  - builtin/gc.c (3 lines)
>  - git-compat-util.h (52 lines)
>  - trace.c (2 lines)
>  - wildmatch.c (6 lines)
>=20
> use one space indent after '#' per level, while
>=20
>  - hash.h (10 lines, inconsistently 2 uses 1 per level)
>  - thread-utils.c (8 lines)
>=20
> use two space indent after '#' per level.
>=20
> In compat/ directory, only compat/nedmalloc uses 2-space indent.
> There in the hierarchy are so many files we borrowed from GNU, whose
> coding style sticks to one-space indent.

Thanks for checking. I don't really mind whether we use one or two
spaces, as long as we are being consistent. I actually took the 2-space
indent from the comment for "IndentPPDirectives" in ".clang-format",
where it looks as if clang-format was using two spaces. So I took this
as being the official style we settled on.

One thing I noticed though is that clang-format is inconsistent with
either of those styles because it uses a tab character to indent nested
preprocessor directives. So the comment we have in that file is quite
misleading. We can fix this with the below change though. I'll add that
to this series.

Patrick

diff --git a/.clang-format b/.clang-format
index 16fd12253e..0e3606a8bb 100644
--- a/.clang-format
+++ b/.clang-format
@@ -105,6 +105,7 @@ IndentCaseLabels: false
 # #  include <foo>
 # #endif
 IndentPPDirectives: AfterHash
+PPIndentWidth: 1
=20
 # Don't indent a function definition or declaration if it is wrapped after=
 the
 # type

--JB5+2DNbgiVwtATc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaoiO8ACgkQVbJhu7ck
PpRtnhAAi3T5FA49Z9yehfVm9Ed5k8X5vtND9E5b2Ek/eBcFUFEujZNWg1FASrvY
4TBRHXYLX6AlhEoxh/36GL7V0If9cUVtiajf1fnCuIepRMHkLxRK/WAEWBq75KtN
9wHfc41r7vOnmYEdsze5lnBX6dSqbSIz6HiinmctUAl6KalU9vqawHmTkKRBdO09
WHv685Pqx3O9PONKiDshkVdIsLVimRTgfLDig9PBxAlB7k56NjcV9KgMbygbuZVE
TWBAqUXORT8/vJ7HajjjXqATBltxoy3F9j8tWRQRCqJLyHV4OFHMFUbDGQxLklEo
pCqZtTd5HPzv3YlDHapmz2DLUQdJ0nhgZHuEqf3/+WLtBCuY56o8Z9mpAg5b58Do
uxvZMOweJffZyOFnk84yaw5MjrVgkuCotcDCVmZYesH0IDpcMKjv3ey9Si0qYQeX
r6aBPDcv5C1YC+K8Z7nd/i4RWHiqkVE6gO20nBQGJS40gHdXoJb5QMhXePpyGLTV
GT5JzwJsEOn4Ct6jEHs+sHjK6Vd1xiYX9BkP4Yjr1lIkQkG6u+nA7KchvfCSzm4o
TOo410PvOK+zTMZt+i6lRiuI+1ZmiqukoltOY2gH30LsuSM21ng6jivdYefRJPl1
0VPYlTRfR/jX01m/QSzmkE6J+rYM1bh8Zmbx2yTUlsH7dwrgmck=
=doPr
-----END PGP SIGNATURE-----

--JB5+2DNbgiVwtATc--
