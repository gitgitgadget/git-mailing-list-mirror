Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F17F13C69A
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246541; cv=none; b=d5+NIIruwUd/PzJvB8tJ2i2OHFZ42suxGhYqUBwQc5IbdPUKy2luf+hqOjjJZbgnjNvukYOre+kOOTR/mTa5ghGBoHZ1TLUQrJn6AmFerY89/mwXVECDlb5WOFchSeiitjgm0U7MbWHgzYS589Iy7Wb4qpSmvZV0IYpJHoh3mXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246541; c=relaxed/simple;
	bh=EYw7fTQki6czK23EuGnGPNveg7puewTGy8TfUhpvl4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V21WLZeCgV1QG9MqoobK0/oA09LLiTT9EOD2HP133yUCEyIGeoqlqO4VTguMK+zw84h9FxPYT21988ERmfOJ4LKarJGm79j/TaxJutQJmgz0NUoYGlurOn4DLK+zEnN5VEEWw0WZh6COwsfvErCnCzgoEVkEUctjCfwgP1oG+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PwohITvF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nCU6O7Iz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PwohITvF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nCU6O7Iz"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9AEA01140149;
	Mon, 29 Jul 2024 05:48:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 29 Jul 2024 05:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722246537; x=1722332937; bh=22VIPxR5cm
	w6fJGNiFsaBG2ATMfSPDm2tzin787Vfho=; b=PwohITvFak2p4R2+PfWL7zzJ4V
	L/pS08Gnn7o/P1aKmooORV3/d1NnvjtT40VQWTIvbyqxRgDFM6tsrkQ3LmT+xRYK
	Sy9XVdyZsYrlzsj/A84nKH34hESLmCDJFUf6Ls4SInjw2lETXjobgSZbhu5ttGGB
	XI4yaN6H36XvSlRI5aQgdSMKj4ZBdtTLbR3/Y7t542NVc43zFxey7UfdUQcoZLHI
	MfJ2epHPHMURJlXhjTkQzSFX/tgPIQ0GOSK4bsHJN7PI2W5OdDs1ATsVYwyM8ye5
	XuarMgW/5R/B/j3M+yVxPjYKTkh7ICjMhyeojrPYdUiW8ki6KclAgJbDpyag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722246537; x=1722332937; bh=22VIPxR5cmw6fJGNiFsaBG2ATMfS
	PDm2tzin787Vfho=; b=nCU6O7IzK9Rrou52YJYZxPjjbGPvWdHBWYGdWBIqEqJS
	85mcH9Wy10m8HG03pDHDB5wJY37zLM7Mkekj4zOtnEm8aOvP7DQrP/ytCa7MjWR0
	hl817abFAjBNRRn2XfyJJRdVWqD0XPhcVss33xWN99p+Y0/yR13RIfqb5SZw6/D2
	0jzJV1CsQZoE+6kzk2PLjaaXdRF5XcGLTigvuZkpJryX6fAGIVHznhr787jbOok8
	7SgwOISo3akvJ1BHvqBFLlvSykRjhaQTjcS9HHOAtnV1g2JryHRL0wy4Gpls+EXV
	l+M+5JaQdhvyDMZe+1D5sfjMfPoxu8na+kjFhiwjGg==
X-ME-Sender: <xms:iWWnZpVNhe5IZq7accMemGOspwFwdLcjtO-htrwhebdGko1CQjiP4A>
    <xme:iWWnZpkCyFVlNZ_J8drstDLn8pYpvkh0wsbwZNzjlj-DrUmBTe87chvVa19ori4d8
    ffYSvIhgXOEtzFD5Q>
X-ME-Received: <xmr:iWWnZlbp6kKvpK8fyd3fLBds3bD05nlmtil2pIrMwzdvYtG5k6OpkbzQOQ38fzAvwI2hH3b9AqYU9yeBSsLSU_5d3Piej-ENipg1ADJGEFB_cg10_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeljeetffevheeggeetkeetieduieeiieegieegtdffheegkefhjeehfeekhfevleen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    td
X-ME-Proxy: <xmx:iWWnZsUJ1H9_yQj4je_L493FPTT7dtp8W-QFqqsq6JeLiYfpfRAujQ>
    <xmx:iWWnZjnr7gFjrBpmTwp0ZZl-RipKsFIybXA15Rg5Rc6XWFdUfTWjjA>
    <xmx:iWWnZpf5gUGzkA1L7zlo0X0G4vadYshTe_tU323ghBhChlerPZWzJA>
    <xmx:iWWnZtGAZibSBKDoku4ncx2t6ycAyA7_5EbS82cH9mhYVQH-VIzHCA>
    <xmx:iWWnZhZCZU3HmfqvUdxeFRo5x9477IKIEO2tXCgd0CWzeaBSzpxeKUCX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jul 2024 05:48:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f6c9912b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jul 2024 09:47:28 +0000 (UTC)
Date: Mon, 29 Jul 2024 11:48:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kyle Lippincott <spectral@google.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 3/7] unit-tests: add for_test
Message-ID: <ZqdldZE2MV-Pkuu-@tanuki>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <73465c3d-1be0-456b-9471-f875e819c566@web.de>
 <c51025cc-26e5-41e2-be56-94e141a64f5d@web.de>
 <CAO_smVi2rJd5SDMsbbxzFUj28a_1KTgdHMz4DTKMsii+Wt5H_Q@mail.gmail.com>
 <xmqqfrrxjw8f.fsf@gitster.g>
 <CAO_smVhq=MkQV3a6qJtDiFykvR4im7AX4hMfKMNcL5SegnOSLA@mail.gmail.com>
 <xmqqv80szxgw.fsf@gitster.g>
 <ZqOc9vxdD4qttkFs@tanuki>
 <xmqqed7gxhyz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BDqjh1Lh9TPIuBWn"
Content-Disposition: inline
In-Reply-To: <xmqqed7gxhyz.fsf@gitster.g>


--BDqjh1Lh9TPIuBWn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 26, 2024 at 08:59:00AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> If there is an existing well-written framework for C unit tests we
> can apply to our project, it may not have to be so much "magic".  If
> you think theirs is not so good and worth copying, then let's not.

With "theirs" being the libgit2 one? I always enjoyed using it, and it
is standalone nowadays and called "clar" [1]. The biggest downside of it
is that it depends on Python to auto-generate the test "main" function,
which is not really a good fit for the Git project. So ultimately, we'd
have to adapt the heart of clar anyway. It's not all that involved, but
something to keep in mind if we wanted to use it.

Patrick

[1]: https://github.com/clar-test/clar

--BDqjh1Lh9TPIuBWn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmanZXAACgkQVbJhu7ck
PpQsQxAAlkQyDIMTPX4UxN5QKX9oeh7FEYiKrDH0esJwPEM1ZbM1Gla5S7W1ZCA4
yCU2Mp4/mCA2jVhkHZJGBXhGCNLYPX8fDVN2MJUSnyXQOk3aBzFw3YCj6LL2j18t
+PEJWNJg2+CQ05yq1fp38LClNSNV4zRIrpuIcdH2a7AAj1/zFRzAL2GMOi2cHB5C
kNL3FZ34IU0aRYL3MJhMY+8h1H6WUxoPjXZPrzX+VVxUZeoI4ZCuyQDTr2iDkJbo
Q0jJSyBgHyip5emc7+XS3aRK6+8z5Mn7xjbpUhtOhysHTpji2/VwqIIsM3iZBCsZ
hZIXZAaHRUHTt7vN2dvPzOZawmICC11yFvQ9NpioOzEvOvwa3QMgRw4u7QcYoTRi
T3n8RsdkQjmwqKrvfzeyIGmWRu+cLXpUu/JmUggZfIy04JDxLEF8AOg+Cbp2PK41
LXQSjRyn36eNLEVM57Z25urZR6ASvx9mdfSFsXN0TFy8ZXu1ieuTqcdqYt9fdggz
UT1CRtmUiUM/dYO7sl4B/jJrjaN4x6xIQ9pf4oBlAudoaQKXSim6hQGsNgY9k8Ys
nEpB8xMQM9w2bBlyS0qis+WH8Ymm2n+FG2LEKqjxgI3T+x47jATLdFf49qdMzcxh
zub6GDeYbw2Pj3Z0PkeqLKgclSa8vKZRvXnIhVfVI59faBzB+S8=
=M66M
-----END PGP SIGNATURE-----

--BDqjh1Lh9TPIuBWn--
