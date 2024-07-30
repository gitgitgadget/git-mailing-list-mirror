Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0432114
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 05:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316338; cv=none; b=t7R3XV6wuIxkVcBIRyQ4XuuKzMj+N+8e1EEabbw4PT+taqNtH4FV//TekJWUbSxeTbYtraFNZ/SUfYaojrOK9YQWeDp1v+XFwvbsBoEMPQQNbCVx1MRNSq+JD3/T5DpilR/eh+a+EjJKFuJfGJQurR2Hd+j55nMwr28cBeEh3/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316338; c=relaxed/simple;
	bh=samLXgloP8+QYaErKm1tHXgyS2YwOezppMtFWaOTTlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxAKj5wkoorqMl5oQc9QHdtWSyfP0Of4MDTwJIRJj3ixxRtCEtD2iIHhozhPllygsce+clcJzB6myp2j11SSlAPyTjFrj7LcLfwvdJup0qSSCI7mb8pwoOzCwGKHcVhbpW5mTKgb9qAEZoJdxQQiV/xzihz7Gjlxb+renuLnwLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Af53i4t1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fF9cUu15; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Af53i4t1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fF9cUu15"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4074C114019E;
	Tue, 30 Jul 2024 01:12:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Tue, 30 Jul 2024 01:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722316335; x=1722402735; bh=I9xKiGZQne
	LYvKwjdk0uKw6nYMpQcSDzANgf7lpgQLM=; b=Af53i4t1u67DGBobveV7Rfr9CS
	Ev+12I/YUd/ZvsWvDuVegRUxlz0K5HGLd6JcUlb4qqDDzsTFeUkeuh6RN7OMyAv8
	B3zUVPhsTEWnhgqJ25+XVyIY+2X/fYfYsQFXdxCgyMQ9WH3Fxz6r8pQjafFyvFv0
	5fmXKMGeEK6R5ulZFdJ8Uw3ZsDhM6kBt1kT4IA2BjU2FO5Ysw9uZkNsXRmB11/8X
	g6KCBhkkPXiD4GvOFdrMUEDma5SJangMPsLvGR8aAZgrWDGxCLLDo8j/v3uLAzfQ
	WWV1IPkkDKOFoW4BHIVkXeM0G4a/r0urIcQRVjR4eVT5HbjjE2T3zmcvYlnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722316335; x=1722402735; bh=I9xKiGZQneLYvKwjdk0uKw6nYMpQ
	cSDzANgf7lpgQLM=; b=fF9cUu15pKJ9/HK4g+T8htr/rTRzhuzJ/p+TsFkJF8Qn
	a13bnzbRZDcmDKk1o8lO8Cw5NGct/06sBB6eAH2Cf5wMW3qCB31dB6mjiPw1Y7oE
	Aezg2CXJBQtEowVJE8RQGbXUWeJKYBobeArSl+3BnUUSYpWQSntIU3CllOHTmvKX
	6oELC06IevtbfpwMpWYrNIvKI7AUxnKXxvAzh9DQGecHLb2zKbGjN4aM+7N+8dOR
	EBuUFWtFuMgJ9krXJlqZi2rV0vhUOM7Nflgm1gEl6WT514OFxv71c63F5IooEvzT
	eeHpdA8iz11FVsNhFi+xwZ6Oj55zULbTjmjJg0cCTA==
X-ME-Sender: <xms:L3aoZtiRd-Xugvcf7vyjz48Zqk3JxX0TeOocy6E7nn1CPX2nMa--Fw>
    <xme:L3aoZiBFByx9Stu4wG8n54F-GiwINBgtuIzQLVxGtabi5DR2E6895NoId7ffkzxvL
    0NtBWA3NDNarNs9RQ>
X-ME-Received: <xmr:L3aoZtGGE7hoASjzGGTA8Z5_tZ_OzHxC-YK3IZ7ENxuZBstDdBOSMlN_YRXUbobkpHKqaikioI-RfBUwn30x1CIsfXhdSB-MpctqTrThEAmCcAk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:L3aoZiSZ_7bjl6mO33hh4bIca5_4QKZGb6ynC1hIoG9LIvtWAuWvug>
    <xmx:L3aoZqxQ3i-WKBAhGmscz_f6wrWMZoXnSwr-vH70V4vEHeHtT86PCg>
    <xmx:L3aoZo59mSWLI0Quxwqiz5s16swa6LVnXiU3FvATgB-n06JNKvqNRg>
    <xmx:L3aoZvyarT47QZEKmJ7NDykjSgs276vU5bTwRKYQGUf-AGnICiyIyQ>
    <xmx:L3aoZl9HannQLdwhzaZNdZij68c83Bn_yVXkA_eDd0TeL8SQs4bDOUNP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 01:12:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 67939e45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 05:10:46 +0000 (UTC)
Date: Tue, 30 Jul 2024 07:12:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] patch-id: tighten code to detect the patch header
Message-ID: <Zqh2Kije5omYzDPY@tanuki>
References: <20240621231826.3280338-1-gitster@pobox.com>
 <20240621231826.3280338-6-gitster@pobox.com>
 <ZqeGBJrqIrU2A4jl@tanuki>
 <xmqqwml4gdol.fsf@gitster.g>
 <ZqhyI7Ta9g_4AwfI@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yAnkbl0pjSd9yQ0l"
Content-Disposition: inline
In-Reply-To: <ZqhyI7Ta9g_4AwfI@tanuki>


--yAnkbl0pjSd9yQ0l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 06:55:14AM +0200, Patrick Steinhardt wrote:
> On Mon, Jul 29, 2024 at 01:12:42PM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > > On Fri, Jun 21, 2024 at 04:18:26PM -0700, Junio C Hamano wrote:
> > "Skip non-diff garbage until we see a patch" is the mechanism used
> > to skip the log message, so it would be a reasonable thing to skip
> > such no-diff garbage between patches, no?
>=20
> Oh, yes, it is reasonable. I just didn't quite figure out the flow of
> the above loop when reading through the code. As you say, it is somewhat
> convoluted and not all that straight forward.

As far as I can see we didn't have a test for this yet, so I did have a
quick go at it to reassure myself that things work as expected before
and after your change. Feel free to pick it up if you feel like it, or
to just ignore it :)

Patrick

test_expect_success 'patch-id handles diffs with garbage in between' '
	cat >diff-with-garbage <<-\EOF &&
	$(git rev-parse HEAD)
	diff --git a/bar b/bar
	index bdaf90f..31051f6 100644
	--- a/bar
	+++ b/bar
	@@ -2 +2,2 @@
	 b
	+c
	some
	garbage
	lines
	$(git rev-parse HEAD)
	diff --git a/car b/car
	index 00750ed..2ae5e34 100644
	--- a/car
	+++ b/car
	@@ -1 +1,2 @@
	 3
	+d
	EOF

	cat >diff-without-garbage <<-\EOF &&
	$(git rev-parse HEAD)
	diff --git a/bar b/bar
	index bdaf90f..31051f6 100644
	--- a/bar
	+++ b/bar
	@@ -2 +2,2 @@
	 b
	+c
	$(git rev-parse HEAD)
	diff --git a/car b/car
	index 00750ed..2ae5e34 100644
	--- a/car
	+++ b/car
	@@ -1 +1,2 @@
	 3
	+d
	EOF

	for stable in true false
	do
		test_config patchid.stable $stable &&
		git patch-id <diff-with-garbage >id-with-garbage &&
		git patch-id <diff-without-garbage >id-without-garbage &&
		test_line_count -eq 2 id-with-garbage &&
		test_cmp id-with-garbage id-without-garbage ||
		return 1
	done
'

--yAnkbl0pjSd9yQ0l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaodikACgkQVbJhu7ck
PpQ79g//SscynOgZ8JXlXp1wGaE3iRhbkYv7wjLZYbG60hVOZXBZSckTDnLofZIw
Os7uzb60wWxBEVn6T4Ze8lDIDrquLGowgMuwHDE/S6QLuktslQpyhMFPbaCYsneY
1mH7nib2kEe5uRPV1AtHSko7SVOyx1yb69EpOsoJbDpeWdMRS6zXuz8RiYQtPoOD
q7hAd1HV65DAJkyg/4kvzGICAF1vc80Zo5KVUgY+NcG2ezC569EhZxbqlYvJdym0
JUYtuJL7gIMGmb7Xtw19TRYi40OuBcmcaSUFxQHzklKbCAbxsukui3ElbVuu10jw
VHpNI/t5tvwXJ/+my0sLpwKQ7SB/ylQln1bCm2mSUwdO+7K/MeAeanaQxZYlK6PK
FtuRo/sBCrwlcz60yAF4thgOeRSjeuhhj3Xp7FcaYMB1mMJszFp/6UzrkEIX0x/r
mczFcTRFIAfwY+9w0r9c+mJHCzx2yCQwQ1FRzZhgaHVjvhD1UrCbhC/b+zShQFEA
t3Sq0FzDq43Sw8TyomqqOwTqt82iR4JwyL+vJz0sy3O8GleCiDV6+P+xWEje+pBc
r1IFtgUavrEiipQfJMVlZ1NNpZs6Ep1ObcLulylt97IuwqNSz1HgKLjx8O/hLIkO
82Pk563ts5Z1bv1ZaGZUKtN9lI3G5xsZC9XgurjxF2eHYmvulrY=
=hBh7
-----END PGP SIGNATURE-----

--yAnkbl0pjSd9yQ0l--
