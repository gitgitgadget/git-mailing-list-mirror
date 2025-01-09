Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBBF37160
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736406337; cv=none; b=dCo6BhQBjua1RXRNYBNHFu9ngwoKyWuW2mga8ZgD6ssdnSUjfKdKeh15+muTRmOFOCwuOIoAKUUbjcppp11xGdzppuhS9wfBiNC7PUtAHHcp49BmDWyWLFJtpuoRuBDitZ3opFneQPGGE5ALwkBeQsst9CmxzFRPXKmjGSazPbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736406337; c=relaxed/simple;
	bh=uBQ/Lu8zsCIOJXePavXot96nnpH/KeVmGV1ntq+eMnI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=g4l7OHsmB0o7PzkhB23VQgQPKst1cAdeVcfwGeqQSbuans1ScDXXOMQSGKItHLpT6VEwRfJEre4oayxJx6FQcSn+SZRJE0kwroxA5xdI3s4+5H9hxxABxTD7i5NwVaUX7r9CLEVqObR6ZMNY0rO9sS3POow6HbnP8friUdEpx7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=revi.email; spf=pass smtp.mailfrom=revi.email; dkim=pass (2048-bit key) header.d=revi.email header.i=@revi.email header.b=CjHnvEvU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E0ygczJy; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=revi.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=revi.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=revi.email header.i=@revi.email header.b="CjHnvEvU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E0ygczJy"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EBD581140170;
	Thu,  9 Jan 2025 02:05:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 09 Jan 2025 02:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=revi.email; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736406332; x=1736492732; bh=uBQ/Lu8zsC
	IOJXePavXot96nnpH/KeVmGV1ntq+eMnI=; b=CjHnvEvUgbjGerPymL48oRq8+A
	LcI4bK8habJKwA0ATq+diO7qOO0oziz1L8RNMIlnyA0BiQ2HW7tGdbdWZ2rkcqSU
	jHliddyeEnYU44FI+Lgr4F+RWnFegHqzVHhDr2BNTB1p/NeGpivW69uGEkBiFFEi
	SrdLFkX32MDBW6CMhGKs12mqQ1a5umpyHRaJYx/P0wDnMUgUbf7udTFn4XGyxYxz
	8SgoCJPa2zPOLTC9qHcxvZ4T1bZk7U9SvMyO3C7RjBR99yTRsGkFJrfgQRykf/J0
	HcwRNkIPrpaBtS5vxScasnPBPtV6XKYWFODos1TV7ol/YCeg+SQDZsF4i8rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736406332; x=1736492732; bh=uBQ/Lu8zsCIOJXePavXot96nnpH/KeVmGV1
	ntq+eMnI=; b=E0ygczJyyM0F1uG+cB1oA2cU0k6vZJGEKYjqGfTfeXmxPVFnYhC
	mPPckk60QsuI6OmWM3oztxgtIVIM7EzYw0eG9BrYZt/eKDMHtm0Y7GXFxIbjZSU1
	xy6/Reqmk6y3hZkg9gqFRo9Dsrd0SUeXbDg8x8FWV/BsWXbS7/Ul6Ghgu03u5OgP
	D5u7C8YdQlqbEvV25uPkKVjkvWj2BXQTFDpACKBM2XozEXnsAMBYi2nX20yQ6o2y
	GxbnZEL6c6Cq0hSrwY2NtWtjo38FY7Gm80FG9YeECcAWNiPH77hNM9DaXoc/jPwN
	0veOitLNcQk+K9QL4AsEYF+U3TRCKS/TRRQ==
X-ME-Sender: <xms:PHV_Z5bm3i31DNUM1WfBddh65UHxX9c9uQlmyfYwdOyyIe0ro6q2aA>
    <xme:PHV_ZwYOUbkVtJ5n6VIY6R4X1O-qYsWdBew-Cyljy5F20Oy5HQqHhzZHLj49vrwie
    E1ysuptYlsOmpQMv0Q>
X-ME-Received: <xmr:PHV_Z7-0BNP01al7tOP2ClBNxDR6C8ZVFIQ529kB1sjCPEchmWRRCMOrlnx6fNY_jEvKMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeghedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenfghrlhcu
    vffnffculddvfedmnecujfgurhepkfffgggfhffuvfevfhhojggtsehgtderredtvdejne
    cuhfhrohhmpegjohhnghhmihhnuceohigvfihonhesrhgvvhhirdgvmhgrihhlqeenucgg
    tffrrghtthgvrhhnpeduveeiueduuddvfeevudeufeettdehveekteetveefkeffgfehje
    dufffhgeelgfenucffohhmrghinheprhgvvhhirdighiiipdhrvghvihdrkhhrnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephigvfihonhesrh
    gvvhhirdgvmhgrihhlpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgthhgrtgho
    nhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:PHV_Z3r7W5o3m8tKoveWYeC-wkh67HA9nylEE9RYJJ1i5IK7ssYxGw>
    <xmx:PHV_Z0pz1TlacnKfUcVqBUt-iGwEKuKMcrYqPkL9-VM6mzilWvFCZQ>
    <xmx:PHV_Z9QulVoc_kIrtlGMjvb61ogbF-W5EFffZ1BfMU89ZkPbt8doUw>
    <xmx:PHV_Z8r5pA_-TtYxoiDnakbpyeLAQrDnRa_CZpaeuGV4B16pUt0myA>
    <xmx:PHV_Z_UanassRZw0hYxZv1P_8WuLZrnDNPVsTcHWBsiukLWorFTRT-P6>
Feedback-ID: ie2a949ef:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 02:05:30 -0500 (EST)
Message-ID: <09e516e7-37a5-4489-a30b-f26dd2462fc3@revi.email>
Date: Thu, 9 Jan 2025 16:05:29 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yongmin <yewon@revi.email>
Subject: Re: [PATCH] help: interpret help.autocorrect=1 as "immediate" rather
 than 0.1s
To: GitGitGadget <gitgitgadget@gmail.com>,
 "git.vger.kernel" <git@vger.kernel.org>
Cc: Scott Chacon <schacon@gmail.com>
References: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>
Content-Language: en-US
Organization: Wikimedia
In-Reply-To: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qXQ2J0Y1MR9U9YonA51UB2ZD"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------qXQ2J0Y1MR9U9YonA51UB2ZD
Content-Type: multipart/mixed; boundary="------------r8yFXtod9xF4LibzaN4b6lHD";
 protected-headers="v1"
From: Yongmin <yewon@revi.email>
To: GitGitGadget <gitgitgadget@gmail.com>,
 "git.vger.kernel" <git@vger.kernel.org>
Cc: Scott Chacon <schacon@gmail.com>
Message-ID: <09e516e7-37a5-4489-a30b-f26dd2462fc3@revi.email>
Subject: Re: [PATCH] help: interpret help.autocorrect=1 as "immediate" rather
 than 0.1s
References: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>
In-Reply-To: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>

--------------r8yFXtod9xF4LibzaN4b6lHD
Content-Type: multipart/mixed; boundary="------------6KjLVIqGiQNyKfkpZMkcYZ75"

--------------6KjLVIqGiQNyKfkpZMkcYZ75
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAyNS0wMS0wOSAoVGh1KSAwNDozMTo0NiswOTowMCwgU2NvdHQgQ2hhY29uIHZpYSBH
aXRHaXRHYWRnZXQgDQo8Z2l0Z2l0Z2FkZ2V0QGdtYWlsLmNvbT4gd3JvdGU6DQo+IEZyb206
IFNjb3R0IENoYWNvbiA8c2NoYWNvbkBnbWFpbC5jb20+DQo+DQo+IFtzbmlwXQ0KPg0KPiBU
aGlzIHBhdGNoIHNpbXBseSBpbnRlcnByZXRzIGEgIjEiIHZhbHVlIGFzIHRoZSBzYW1lIGFz
IHRoZSAiaW1tZWRhdGUiDQo+IGF1dG9jb3JyZWN0IHNldHRpbmcsIHdoaWNoIG1ha2VzIGl0
IHNraXAgdGhlIDAuMXMgYW5kIHNpbXBseSBzYXkgdGhhdCBpdCdzDQo+IHJ1bm5pbmcgdGhl
IGNvbW1hbmQsIHdoaWNoIGlzIGFsbW9zdCBjZXJ0YWlubHkgd2hhdCBldmVyeW9uZSBzZXR0
aW5nIGl0IHRvDQo+IHRoYXQgdmFsdWUgaXMgYWN0dWFsbHkgdHJ5aW5nIHRvIGRvLg0KDQpJ
IHRoaW5rIEtyaXN0b2ZmZXIgc29tZXdoYXQgbWVudGlvbmVkIHRoaXMgYnV04oCmDQoNCnMv
aW1tZWRhdGUvaW1tZWRpYXRlLw0KDQotLSANCi0tLS0NCnJldmkgfCDroIjruYQgKElQQTog
bMmbYmkpDQotIO2ZjeyaqeuvvA0KLSBodHRwczovL3JldmkueHl6DQotIGhlL2hpbSA8aHR0
cHM6Ly9yZXZpLnh5ei9wcm9ub3VuLWlzLz4NCi0gV2hhdCB0aW1lIGlzIGl0IGluIG15IHRp
bWV6b25lPyA8aHR0cHM6Ly9yZXZpLmtyL3RpbWU+DQotIE9wZW5QR1AgPGh0dHBzOi8vcmV2
aS54eXovcGdwLz4NCi0gSW4gdGhpcyBLb3JlYW4gbmFtZSA8aHR0cHM6Ly9yZXZpLmtyL25n
M3VsNTk+LCB0aGUgZmFtaWx5IG5hbWUgaXMgSG9uZyANCjxodHRwczovL3Jldmkua3IvNjE3
WlRxYj4sDQogICB3aGljaCBtYWtlcyBteSBuYW1lIEhPTkcgWW9uZ21pbi4NCi0gSSByZXBs
eSB3aGVuIG15IHRpbWUgcGVybWl0cy4gRG9uJ3QgZmVlbCBwcmVzc3VyZWQgdG8gcmVwbHkg
QVNBUDsNCiAgIHRha2UgeW91ciB0aW1lIGFuZCByZXNwb25kIGF0IHlvdXIgc2NoZWR1bGUu
DQo=
--------------6KjLVIqGiQNyKfkpZMkcYZ75
Content-Type: application/pgp-keys; name="OpenPGP_0x011E455250EEBEDA.asc"
Content-Disposition: attachment; filename="OpenPGP_0x011E455250EEBEDA.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
/McD
=3DPORJ
-----END PGP PUBLIC KEY BLOCK-----

--------------6KjLVIqGiQNyKfkpZMkcYZ75--

--------------r8yFXtod9xF4LibzaN4b6lHD--

--------------qXQ2J0Y1MR9U9YonA51UB2ZD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQR6nowvPdI99GnCxH3fWe4Q/FmP5AUCZ391OQUDAAAAAAAKCRDfWe4Q/FmP5Pvf
AQC2sf2CzAdbcQDvp8NYc8SMlR6vnCwb2baIsF8AkMnH+wEA+oynp+VMwGvN0J4ia56tTqR2SOO3
jyCVsoSwE8A8twI=
=mO4Y
-----END PGP SIGNATURE-----

--------------qXQ2J0Y1MR9U9YonA51UB2ZD--
