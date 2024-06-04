Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BA2446CF
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488132; cv=none; b=Lpu41yKdbx8HIwBobSs4jD0zUNMF+SN/hJlYANOY1qFooXbQH6f+iAwCGSUFvsbbVg7b7U+vNBKcGeDTlXblTlN3JvJHnV8YoS6nfRu2OTCkUss+6Tpuu7WxRGAGWiFujHJlQgjK1CwYQHbQ0XwrS28yTt9UIZD+io1ffTdza40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488132; c=relaxed/simple;
	bh=c3f9pgKgiqYsr9kucpexSPT0whu8qqPSvXabAztqsfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8dtmbU+g+yf0ayZ2IrWkohBTGUfrRAL36ePB/D9h2DbRuGl1zsnXCV/HK35UrNaVBXjk5YrAWuXQRSxFACt98z5x2C+DGHAbNncE8O/Pj/yOAqqj/4kje1xdH5l54CkU8FLyhYEQPZPJoGOOT4Xw+s4w6AoiYWH9f/mKTPXba8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sp8nKyIz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PfC4FmCo; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sp8nKyIz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PfC4FmCo"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 2C5691C00170;
	Tue,  4 Jun 2024 04:02:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 04 Jun 2024 04:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717488129; x=1717574529; bh=ylrVvBl5+5
	Cid2Er2+xVbf4Uxu5MBCcVSBIDU3psEjE=; b=Sp8nKyIzlleNH+RgsHdkpUP0Zo
	P+vjglwbNQmCbexOC8w3VsKUpSXbHFF7dDg2O8JjFbkoyekHW+uwlTJ2niXr1XGF
	m/3bKO23O7RxVSC+WScvCZqcvWowX2gYj0waLTQmYXSRp7WFY3VV/8F8Rv2bSoLs
	Bt8CoARHnlNAWQKVNyz+KwqLycBOomZbxXuBiVlWJEJE3VZYO5TlvMtkq2+BDarx
	bN3T6cQrzAAepjvlxETvlNLOcdT7vRbpPCY8Jz0eC2VfWFo4btdzJfmXCVStW9ZI
	OvyM1Dm+cTuDr+tgsOqppLi97JLgydkNzCUJII+yhxfsb9ImqIx0lZQDetGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717488129; x=1717574529; bh=ylrVvBl5+5Cid2Er2+xVbf4Uxu5M
	BCcVSBIDU3psEjE=; b=PfC4FmCoQzQfWz9oyqKdZL8YymIPftuZsbz169y1auby
	EUxvnayTIeqmuDgCixNCu8nFCz2sLa+vdXuLZu2SBwPLqK77pNMyIFvK203Ll/MM
	o1zfmukzJpcvdUGkLNeGFPhDPawRk86wjV3KT5BNsR1+8oJMpzeh7IZL4Y9NV8C/
	bM12h2IdoOk6gC9EyOkZb9Vj+Y5GV1ItB8nBi0kWllCAC6YLBe1BmQKaVk4jD5Wg
	UNjvQfyWoB1kExQBMUr6PDQlBAK7xh5qH7xO5q84Of48T1Jn/ZXlM+5KCwf9krB3
	Z5MbhCBuItQ3XyrqZCfV5SKxgPKIfBwGHxtE5eUhSw==
X-ME-Sender: <xms:AcpeZocB5x20dvQbFENCYdzM5b2cqKJAQr5o3A06WWSZ0SbwPjnWdA>
    <xme:AcpeZqMMJQn0vf190dq0OOk8xLD3HSeZ48IQzWrhteh2WdhSsAu0DJEGGeN_4kh46
    YyzMAIMMEG7s9jeqg>
X-ME-Received: <xmr:AcpeZpgrxSU_zzi8ofnLjaMJ53_uIEOjg0vnJPmbMGVC5wMumRfM4ntUAGQ4VbZ_thIqpLtEydxCDmBL4Z1FnQqDnfu7Soh2IfmzYKvMrxw1jVzN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelfedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:AcpeZt-LIX_jgvCDdORAkTsiIxn3ZuB7KH17Ll6nBuJ9inl9azsqRw>
    <xmx:AcpeZkusytSFCQmPMmhctCBWQdxwrNNT-7SQfby_V0RR5MWEZMjZaw>
    <xmx:AcpeZkFaIREvXBjfUhqYV00HCAtKDRpjSLD0c-eDOVII5lpfxmzVYg>
    <xmx:AcpeZjNl00a3LT5P1-AO4nGGWJLFClzIDEiLKXA-ryyW4n66dQBn5w>
    <xmx:AcpeZt7XxIcsY8xSseC-qHgOlnOe51Gapna1PtGElvG4-GsUnCWsoekz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 04:02:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cd3f8991 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 08:01:41 +0000 (UTC)
Date: Tue, 4 Jun 2024 10:02:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] format-patch: assume --cover-letter for diff in
 multi-patch series
Message-ID: <Zl7J_Xr6Z7Ot6Hlk@framework>
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+XVIx9h/SM7SEik3"
Content-Disposition: inline
In-Reply-To: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>


--+XVIx9h/SM7SEik3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 12:49:35AM +0200, Rub=C3=A9n Justo wrote:
> If either `--interdiff` or `--range-diff` is specified without
> `--cover-letter`, we'll abort if it would result in a multi-patch series
> being generated.  Because the cover-letter is needed to give the diff
> text in a multi-patch series.
>=20
> Considering that `format-patch` generates a multi-patch as needed, let's
> adopt a similar "cover as necessary" approach when using `--interdiff`
> or `--range-diff`.

What does git-format-patch(1) do right now in this situation?

In any case, this change should probably have a test or two to
demonstrate that it works as advertised.

Thanks!

Patrick

--+XVIx9h/SM7SEik3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZeyfwACgkQVbJhu7ck
PpRKnQ//enBzg6aru/nyUT+0+Jr8IJUa8rO6U+Kc2lUAUoOSBOE4aIlgetmr0beL
vmG/hpJqVyrwgaGTBbvcPXOiD2TY5U7zrGDYwF726+VvuOGqNlhqWfGuLPAlZCJR
fgHJojVYGUuqE5KGq+FTGWKAc45dIWC/dUxDK7s7vETmXdcpldn5fVMYKeR0hkrJ
RdQE3tINMQKrKh9rwi/0bVevwpM2uRvKDvYFLoXzHvHX/jiww3yZPQg+dGeyy8OY
o4U9tI8Jdatpbj6tqsAs9UBUr/lkh/XMyqi1h8fdp7ZolubAMMfLxm80bYysM7ae
m+i6H/yzOFi3rY6HsAS49wZ2YAfZPQHA9xGD1DYE7AWAcX1RJEEaQ8h+6VbnbhjV
4TND5vb+/lOKVWytOTwBXd71cLQI/50qX10uv5yVYHC8OgBYumodA+3ImpClS88D
Aw+njaUfhGh7Q6IFWaI+Vi5MAkwAht/BuqR0Vvnj/hWEdDyCpberUhLDY/PMaoDR
QLAoZUhpR1ZNbOIxizfqctIRUdK3tc/RmeiZM7Qlny/YrlMSJJw2tL3j86ImEhHY
TuVCVVpEfCJNRTMSS2Os1OwaU5yw0JsRBBoiguy1pmtxwtcLRnd4z0f7xZVPQBNj
xrJFW9D3fnEEALvJ4Ab1EwtdS8Hwnpu3/fdYuqAJyTeoeAeadv4=
=rvip
-----END PGP SIGNATURE-----

--+XVIx9h/SM7SEik3--
