Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD0519D1D1
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361265; cv=none; b=nVnvfiLw72HzjdaQHrmlo6m57LJwCYfIVQSoEJCOcQENOfOwy0HxnoeEJMc+t/MJJOddbz7OR/uynyQPt6lx25ty133GiEPjLdn1eBMws7THzWgPC/6fSVqrC5p0Yf+FcxM/Mby7R0MwE2EMwLOcllBJMj08mB5P6U3L9TPf/r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361265; c=relaxed/simple;
	bh=D7CFBN5z8jVLbklKnoaMRCkZXX61C8J3Yajx9m+CEx0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9i9f1A7pymStWNc6g+moQhE0mMLyfhOamnkMXkk6Vg69tuvA5Z4QYWz5bEGbk7fT/amablgW7yzOz/2MCiwtsD82j/1MU4QMEgXbwS2Lki9IbuprEqUz9ZSA0ppiNpIRcrHqzDJK40uyV9epNIqzU/tJAy2QJDoKVSDOEpFsaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Uacw5n6i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f+IPKkiF; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Uacw5n6i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f+IPKkiF"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id E8E9B5C0041
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 06:07:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 25 Mar 2024 06:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711361262; x=1711447662; bh=wjzCGzgz9P
	7qHpXDn8yIWgz7gkOGO8N2a9yhu2cyiHs=; b=Uacw5n6idxa8Rx3ETDMp2jerXv
	BH9P4AYCQ+i7QdDJz2Kj+rYcA8JhyukwBkKzLQIlPCiqz7SbXcNnQg1hQeVmjNf4
	pzdC2rlU/lzisrdY34i6qRRq0Y7Rfzk0Teqf95hf2YHq8L+LsIXmLMv/w6ZjTSiY
	aeJGpAbW4JW7Jw5m1N0xuc7UWPLCT9mAD01QQmPHDrqc8QvO/fCNCebJ/BYCm05U
	EnxK6T+HMSWBVk+2zM/PZwsPUXN148sZ+LoyHVCquMExfpCmEmcPlOQy1VIvsm6I
	75zf14g2hLEejG2y6P9MGUN29wY1a5X4HLHgpR1lW7gn/saVyUxNkRUeyHQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711361262; x=1711447662; bh=wjzCGzgz9P7qHpXDn8yIWgz7gkOG
	O8N2a9yhu2cyiHs=; b=f+IPKkiFVNxl02VdxUqgs05UWduBdlAdCPWXzVcoDuQf
	9sGo9uofIqY7fQb+4tsUUslft/6Whan8hQJOzu+0L5SlHbwNlBMYC8w83UU2yviB
	cm+/2n//2t0RPEldvqXzu3nQAe/bzW1Jw8o72f8UmBds6gXC1rGPMbORROobkIk3
	K/Wv5ouqaomKRzpFIzJoCpL+bAZnzxfdN9OP+okNws/Lbynwcm0c0MVR9E9JFs/v
	97RxAE0mgY0f/kNtyKrmdL4ZZ4xp+ZzWxmCpf2JVaps7Vcp/rhcDuBRI4d/4IgIJ
	USiIriI/pyCvAT4RushCfug9ZXwMwiMleqCJuVSWOA==
X-ME-Sender: <xms:7kwBZgWns7TnRubb6zcf2qz9rtoRCOUXoIUN23iP0CIy_hsni1qWeg>
    <xme:7kwBZkm3Hu-xcjy4Kqog-OmCe9mJSbFT4nr9QZBiQHIZ0Yi2DErZLtaLp81arDk26
    5a4ySk2NbAInxY4pg>
X-ME-Received: <xmr:7kwBZkb4a6XYdoxpiu4DEsejq43cGEOA5bJJVS_B9wyv_Cd6r1qJxJ6u23zEp-qCS5qIFDiF-y47VDvB-OZfSU-oFft-Sg3Oq3LI9P3BkBnCvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:7kwBZvUFc0nS8_m0g5UqbsvttTvaId38jy-2VsBPgBhyOyFQ2S8NXA>
    <xmx:7kwBZqlrc80C0vPe7vdm5t9aU02NNKUl7A_jBrwtmvQl51sxf_hApw>
    <xmx:7kwBZkdJkXvBk0_G16nhJqd0p0h_0PJbOKVYuAIk97bMHjaNul8w8A>
    <xmx:7kwBZsGOw7Z0DQicTErz53ae6ve1d85h059Cjt-o8btq8PmBE5YdrQ>
    <xmx:7kwBZuv6RguCZy3DQiB5zjNZ7Zksx5KwF8wf3OzlJ_SPRgufLpqJXw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 25 Mar 2024 06:07:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c9f8e104 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 25 Mar 2024 10:07:32 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:07:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 3/7] reftable/refname: refactor binary search over
 refnames
Message-ID: <ZgFM7Jw5y3JdImbE@tanuki>
References: <cover.1711109214.git.ps@pks.im>
 <44386818ce681da02f00a498acf66043aa55558e.1711109214.git.ps@pks.im>
 <4ea7gnm5gbuvqnoyxdll3ccxxhr4bmlgzwpjtc7kqzbaf5juzb@5kwcy2qhblss>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VX6nkuFwnRGyDtUb"
Content-Disposition: inline
In-Reply-To: <4ea7gnm5gbuvqnoyxdll3ccxxhr4bmlgzwpjtc7kqzbaf5juzb@5kwcy2qhblss>


--VX6nkuFwnRGyDtUb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 01:55:17PM -0500, Justin Tobler wrote:
> On 24/03/22 01:22PM, Patrick Steinhardt wrote:
> > It is comparatively hard to understand how exactly the binary search
> > over refnames works given that the function and variable names are not
> > exactly easy to grasp. Rename them to make this more obvious. This
> > should not result in any change in behaviour.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/refname.c | 44 ++++++++++++++++++++++----------------------
> >  1 file changed, 22 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/reftable/refname.c b/reftable/refname.c
> > index 64eba1b886..9ec488d727 100644
> > --- a/reftable/refname.c
> > +++ b/reftable/refname.c
> > @@ -12,15 +12,15 @@
> >  #include "refname.h"
> >  #include "reftable-iterator.h"
> > =20
> > -struct find_arg {
> > -	char **names;
> > -	const char *want;
> > +struct refname_needle_lesseq_args {
> > +	char **haystack;
> > +	const char *needle;
> >  };
>=20
> I agree that the previous `names` and `want` are a bit ambiguous. What
> do you think about `refnames` and `target_refname` instead?

As said in the preceding commit I was rather aiming for consistency
across the callsites, so I'll keep this as-is for now. I'm happy to be
overruled though if others feel the same way.

Patrick

--VX6nkuFwnRGyDtUb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBTOsACgkQVbJhu7ck
PpRqHxAAhAjs5q61owWj2xf32GtukKU0IRPzG3eJSa562GoxM5lsH+oEY5wwKaAo
KeY8Re3AofNNcpFoYJ2SidFqTmR6T5yyQ00A13EUV+IxkA93tLA/1KpvE3I8HAdg
JVxwbPpmbv3UNZlZ1hmEkDqbZcDpKnIco5H78tptrjD4mPgReva2SLznD5mlzaT/
rFMfP5Unep2JJJpn9vAPpWdlff8Q0kfwMDv9yDYEkZF1GYskMt4SS3+2quZkHQvN
ku6uHkDjnp+CjR6GJY5vRAXpDmngZXg9mQJHEf2oORcucfIssYR4ASMRTc5kqJEf
TP9RqZJtxyn8fFYBuWStY/jcUIVlj5LLFBRYejlTcmktS5xdIeYdi+ZSuwxvhjFZ
GVpqQ/WMZIRJTwFuMPCnIjBORbxJHQ42urYEyvskl8iHFWqJNuDuta7T6efAUutb
ZLDqdNqpSQJlH1EXO5rWuedF7nDa4+0MCjVPpsV/shPQ7qVy4PE+Q0L/3du7876b
wmZU5q6p8pxeBplRK/3g8p4vM8Y1//A0luYpk2rFM2+1yrp1FNmBWt3PNUSjUfeD
SFasiCmmWcGKYkxhzWdeOrL2O/vyKnTsnN2BuRsWS7xD0ZQBRu3aJHhFFE/qCVA+
q8QTxYCqaanlm5t6G8P9eU/rV1LaoqlRC4IqWTk2wEiTFPznDlw=
=FjAa
-----END PGP SIGNATURE-----

--VX6nkuFwnRGyDtUb--
