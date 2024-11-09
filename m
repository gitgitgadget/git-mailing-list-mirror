Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C02146A71
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731168362; cv=none; b=VfaROsQWEdcwWgM+C0qYeh2El0lDEP6lbKxYVDlMCFdfUjGeqMWI7WItkWKMdia8XQiBqDE26JpI5ChsD24e0vnD0Ot118Y1m4mBwTe1vBCu0GaaJQG8fiMlN1wwPK6bnvunnyKlihGm7XnYrgI1XFOB8Md6OauxotD2uwdywrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731168362; c=relaxed/simple;
	bh=H5JC2tzYT9/kskN5Li8AmEsN/LnT+YHilwY2Er6O3R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+VfQSyiqQY4vLDAisN0T894avr7CrbdVWzMntUdjjvLASuaIIgHIHTasfl5QadLFtWZlD1n2bZy97zlsXB4a6VWOtYx5LgQ4sPp678PLaYe8IyPWdKrsybT02+8CWEjPaZCGDuXkNQ0lz4sWDXvGq1MGFJwjg4MOZS1BE4TIAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Izn6FIPZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DMH3e8l8; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Izn6FIPZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DMH3e8l8"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B88AC11400E1;
	Sat,  9 Nov 2024 11:05:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 09 Nov 2024 11:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731168357; x=1731254757; bh=dqrjsfe9lI
	W6XU/qOoLe1+fUVIyFFgKi5xPu+Cfp/To=; b=Izn6FIPZ0Ez+FzeokTUUr7sShz
	EYR0knMu9MhczVNC/wTQmHHbdoHbiX+qNjV2oZ/MVJNO2UzUchxbQF2/vA2iEVTq
	IELPs0OpIcIr8pjZA+Fd5mj8TJ+gng8bE0jwST3sCawPeYPCrMVaHtBVFlQY8rPC
	UeBa3tjQbFkQKTB6henfYKglkaPmAfzratYOn5Gsk90EyPcF6HG0eKawYbqtQ6wp
	j6cbXpNMU1v/UCCETGJa2b7yGOlbVHNNI/cQ9L3LUWsO8JPtvKyPm8n/r2sY+xAl
	tGatTCQgk+G4hizqC4jB67fsMLaoZdPv+G10TMGWIFscleak9/PnZXkplEzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731168357; x=1731254757; bh=dqrjsfe9lIW6XU/qOoLe1+fUVIyFFgKi5xP
	u+Cfp/To=; b=DMH3e8l8e9TSw08SRkbkxfXlRHyEhIHcmA/E/lkP6a27MZewR6C
	U7utWmjk6AVXCywt9aNJlQ0OnSjjqECPC+UA52FUL0T/zzASLVwGgmlhrQHqpb2l
	nbZxdlaRaW8/v1vkuDuFM31GXytZ7E7PDE4dZ245uNTDFyKanHCQJIfAvDaX2AS7
	C7/A6P/WDQiVcGYaiQGwGKGQ8X8Fz/gk9S3UtybpFVznDWVI1X7Glql/zmOYU480
	ONZ1Yui0zmFjOwnuW/rtgrZkwu3XbLpUHA9UU5EcwUSxcvLHOA42Py0u71+QNuNK
	9eqKlkIZDCwMfoL0neTB6I2vwjwr3JDLa8A==
X-ME-Sender: <xms:ZYgvZxch_yISzLrDtTB9llMa4mIc88tiEYxqnlZI5kMu-ulPxX129w>
    <xme:ZYgvZ_Pchdk7BVyg2MPyVnrTo7739zX9ypldFQBzQaURIWA0_gsAn7iAak3o8EQTY
    Av-eV_6gg3Fa09aOw>
X-ME-Received: <xmr:ZYgvZ6i95UMpF27WiMv4OVfo17ZdZIKt1QVk-l_BJ8Qqx9xUfSahAiNewUGl_w3FEeHEySUYWbYHKUD32Hkm7EpzXs4mw5ioTcyUl6XgT9LrmuxNE--E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdekgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecu
    hfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtohhmqe
    enucggtffrrghtthgvrhhnpeeihfeltdelhffgudekgfeguefhfeetteevlefgledvieek
    udekfffhvdegfeevheenucffohhmrghinhepfhgvughorhgrphhrohhjvggtthdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhii
    sehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdp
    rhgtphhtthhopehstghhfigrsgeslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoh
    eptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZYgvZ68c-hzt_PN1EEPUCRTwPAVST8mhkZuyrJcj1MT7ZtMJdrjCxA>
    <xmx:ZYgvZ9s023tXJeOMfw_RynICi47FdgKKwmE8_KKYhWRqrWYivUkhqw>
    <xmx:ZYgvZ5HfnNK-Az3BpB5iChc71U0ufFit6S5bUgPEfD8l7DsrWNtY3Q>
    <xmx:ZYgvZ0MI8edKkqa5A_HhEmPBxk_vpthaSuGZ0sTB8fJi1tXBb2zZeA>
    <xmx:ZYgvZ3I81L0UEiPP0reM4eVFiWke9hZAjrYsBf_j-veWGa1PfJ8V7bkK>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Nov 2024 11:05:57 -0500 (EST)
Date: Sat, 9 Nov 2024 11:05:55 -0500
From: Todd Zullinger <tmz@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC]: Test Were failing on Fedora Linux.
Message-ID: <Zy-IYwjb_RO5NW-s@teonanacatl.net>
References: <CAPSxiM9GZLKNbyCmgpz6b7Z-MLe8TfMaatR8FPNwvsHA411dtA@mail.gmail.com>
 <CAP8UFD1-HsYsPRQwWMo8ipf-VdqF+9=HUTTr4BhEArR=V3ucxA@mail.gmail.com>
 <CAPSxiM9UGLVrOh6XR5fn38ginCVKMOc7yQMcm+qsaF3bi+anSw@mail.gmail.com>
 <CAP8UFD2=imvtamewLN+VvKDK83aL7NhGAb=MjvHQ2OwaK-n5UQ@mail.gmail.com>
 <87msi85vc9.fsf@igel.home>
 <CAPSxiM_h2yEZcUPP33q8HHdn6kqq7SbvzNq8eEFda81ZgY6R2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/PrRsFgA//Ac24GW"
Content-Disposition: inline
In-Reply-To: <CAPSxiM_h2yEZcUPP33q8HHdn6kqq7SbvzNq8eEFda81ZgY6R2w@mail.gmail.com>


--/PrRsFgA//Ac24GW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Usman Akinyemi wrote:
> On Sat, Nov 9, 2024 at 9:35=E2=80=AFAM Andreas Schwab <schwab@linux-m68k.=
org> wrote:
>>
>> On Nov 09 2024, Christian Couder wrote:
>>
>>> Yeah, not sure why it doesn't work while you have it.
>>
>> It's probably of the wrong architecture.
> Hi Andreas,
> Thanks for responding.
> It was actually the wrong Architecture. Thank you. Just curious, any
> reason why the 32bit was present instead of the
> 64bit ?, I will normally think the operating system should ship 64bit
> by default.

The 64-bit libc_malloc_debug.so.0 is in /lib64 and was moved
to the glibc-utils package in Fedora 40, with 2c1b0f0 (Move
memory tracing libraries to glibc-utils, 2024-05-15)=C2=B9.  The
commit message notes:

    On x86_64, glibc-utils will now only contain the 64-bit
    version of these libraries but still need the 32-bit
    version (in order to support tracing i686 applications).
    Therefore, on i686 the libraries remain in the main
    glibc package.

If you're interested in installing the various dependencies
needed to run the test suite on Fedora, take a look at the
Fedora git package spec file=C2=B2.

The BuildRequires contain a substantial set of dependencies
which enable as many of the tests as practical to run when
building the packages (I believe more tests are run there
than are run in the git project's CI for most runs,
actually :).

See also the %check section of the test suite for some tests
which are skipped and other comments which might be useful.

=C2=B9 https://src.fedoraproject.org/rpms/glibc/c/2c1b0f0
=C2=B2 https://src.fedoraproject.org/rpms/git/blob/rawhide/f/git.spec

--=20
Todd

--/PrRsFgA//Ac24GW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQSvlwC4tRNlCF6x+moHOcdGE+n45gUCZy+IXAAKCRAHOcdGE+n4
5mMnAQDcBzm4U3GNjKoM41H88EcPFkeUXAXZCWv3Diq+fpmsIAEA3XqVMq5x5f+U
zrDzMMw8P0O3ooHqp8pShLkYRoqndA0=
=qCVg
-----END PGP SIGNATURE-----

--/PrRsFgA//Ac24GW--
