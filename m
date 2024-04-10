Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F736137
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730881; cv=none; b=bxQ3J/bPttFhcuSMFMRp32dmAVzG2njvEOmT0PPvZ7j5ZFbvJyMKCXpdyebeidca1cZ7wZnZEjZdwcAnwruVJiRowryEU/lDnSR8CB4SDroeUAGSxblKNnSz8WUASn9nCrCuJKy2ONjgTy1gY6BHqx6rXIBay7jB3f4L/IgwTFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730881; c=relaxed/simple;
	bh=E74H+6vWYb31m3y8SCGzfmrHfqoU2P5aylPoTXwi3kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okOo+8a2H5AJ4gFlAlT7Z4um7L1LqWL+nXRH3GNfl5IvN1VcD609Tdy+I8TxyCahEtNPhXu1rfmLygs+nphP2d6B2LwDAm5K+Oq2jbmahdmlHxPUcxx5PbJodN9iqeZCw73v71GkTW0DceegyNXRR3r52mzWiM9DkiEdb9K9K0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c8wJ3Rxw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h5NHePmb; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c8wJ3Rxw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h5NHePmb"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1C24A11400D9;
	Wed, 10 Apr 2024 02:34:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 10 Apr 2024 02:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712730879; x=1712817279; bh=9P3ASon09P
	0Zqaf8C1XBb5ublcTC65SCl24fvFgbfHA=; b=c8wJ3RxwRVOAnYNlbLOsOlFoXR
	1Z/1lrFkpP7E7NLxJz3LZTrCSbz09XvG8h4zksoZGxUhQ207sEThSdpv/HrMAM/s
	UtsQ6AToY5XVtSRcoCQ5sOld7bLP0qAGyWvPte3A+y7RcNORp25TvHIXC67smgGl
	I2AnNtpXb9NDVQWbkM5mzVONUwgu93q7XuKg6Sr9mhNl0JJvPeU9fAFueAw6s9Ho
	LCVxm+qFNgEgnK17H+GTR0CUZL30aEB54s1Y0c/nMSPMz4N+w31r3dXwBFu3iqSV
	+eDHpt37mq/LrDLB/J3ksG4klEAzbiRXdGtqxOUcxUcHQou7tmXAOsfRmRrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712730879; x=1712817279; bh=9P3ASon09P0Zqaf8C1XBb5ublcTC
	65SCl24fvFgbfHA=; b=h5NHePmbmkq1afNfYAyy47uSfgNsV4F1Vgr1ln3ZoprZ
	mvZrHBgBCXQ8nNZxzKLg0Qe/My9Y4kujI9K893IeSOTm8BRCVnEUarXEydgDqR+Q
	tMH47l3OGqLyi2AYj0wQQEtcKR3u6d4qjJJKp4anV5bc1uXueV9bmBBgkO+TqH+c
	Mo4fki5abh/E20/0J9Ran6h1pw4aDtLp90CZTzcv+WArlLridwFCu8oDvlNr9pIa
	tCjcJgWNZyuFkBIuti+GNAoWNGS88zKvZ/GFSFOXVJlmk2Qaboj4piyDszGE9Gbk
	fLMncqhLjhPOfREFEqxUKoC+99fcqM+PQA3nQHY8Og==
X-ME-Sender: <xms:_jIWZmViBAIar3UKenn5fOFhTCBh4oVQP-gHmAx9jyPMZYaS7UGUvg>
    <xme:_jIWZim_Vl9YSq6I-mgcViSwm6XrybBDhtfFuhug3_X-Ka0oiVfxhCXCRe8lHWvkC
    eozxnJxjv9434ay_w>
X-ME-Received: <xmr:_jIWZqaS2kbNNsS60a89EIS3ipqDWjXdxPYIEKNGnbaSgKA8lj8OBS2ul2y5qkBVH7FWK1xncnCoUuz_Q3tvW7sNfmtGYKc0hcQN6TqJfbYieco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehhedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfel
    gfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_jIWZtUAvfSNc2q8A86L3tbE9asmjBAZluY2KRAnyH8i-_xdygHsHw>
    <xmx:_jIWZgl92LkryY5jLNRgB09x6h0Ksl7ioVeuRKOSzmXaegDR87grHQ>
    <xmx:_jIWZifvtTSF1sZlyIcwliLnuqM-XgSGKhOX0EH055yGmYLWPmEWIw>
    <xmx:_jIWZiFv5aL9CAbbsEzd9WM4P2qS_hNkQAPGgWCq1LKND4pZKlR4MQ>
    <xmx:_zIWZqhySHqlKhe__9Qw0qZa3YgSZy1AWNr8eygJ2hH4Xcxfi25USIEW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 02:34:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6cd389e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Apr 2024 06:34:26 +0000 (UTC)
Date: Wed, 10 Apr 2024 08:34:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2024, #04; Tue, 9)
Message-ID: <ZhYy-rwepBwiziK_@tanuki>
References: <xmqqttkayuy5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="16ENUy+GjPWtigaC"
Content-Disposition: inline
In-Reply-To: <xmqqttkayuy5.fsf@gitster.g>


--16ENUy+GjPWtigaC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 04:31:30PM -0700, Junio C Hamano wrote:
> * jt/reftable-geometric-compaction (2024-04-08) 4 commits
>  - reftable/stack: use geometric table compaction
>  - reftable/stack: add env to disable autocompaction
>  - reftable/stack: expose option to disable auto-compaction
>  - Merge branch 'ps/pack-refs-auto' into jt/reftable-geometric-compaction
>=20
>  The strategy to compact multiple tables of reftables after many
>  operations accumulate many entries has been improved to avoid
>  accumulating too many tables uncollected.
>=20
>  Comments?
>  source: <pull.1683.v6.git.1712593016.gitgitgadget@gmail.com>

You mentioned in [1] that you'll mark this for next after taking a look,
so I assume that you asking for comments here is simply stale. In any
case, the patch series is ready to be merged down in my opinion.

Patrick

[1]: https://lore.kernel.org/git/xmqqmsq3bre4.fsf@gitster.g/

--16ENUy+GjPWtigaC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYWMvkACgkQVbJhu7ck
PpTsvxAAigYSeoxfMX6HrT+ICmm36JuG0vFqHZHnHcZhQtyHAswAPcxesnkrrjN0
WQfEKvrVivMataXtk11VvlnfjXHUlCog1/DNTy+FJ5wyrbB0g7JcPqDc+oxRZlWH
/NeAF6KvGVjJ+/kHDn4cnbJfuCJN0pVMThBOAlfRD2YGsTQnUDk4xJafdCwI8QEa
oD5AninTkN6XaRq57x0l0yMZ/cqnpW3QfGR9Y5aeZDHSKLJKyMZYimpEjpGaln6g
V8CYCNAL1ILqnG+62JWn+DCuNorY0TzXQOIpu9uQhy+WreaaUMsopTpbEZCwjo0r
a/qDckJeAFgTpgzbOC0uujvT25CuLI87nyaRdzULIgXfimkyc0nSgiISorDW0L4K
7+LfKEogDf/WWDiFu41l4HMvWTCbkvF2zoqXAiKTmrNgFVgvCN8EOkr6/gXuy+XU
Fx5UfvoQoRS0sZqvLNJVqlSSwiNmSrj5I0MaO7pzftpoC6qjbxD0bGciARgRoXOB
X4RS+ffkKgFD54ULjBvdzTbuMGXW33wDpvRDQze+SdVip4AExtQUQkBY213E/v83
wF8i/fCjDSQTzrKu6FbCDes3z/xvsVvOJCflLT+r2OrPlhPN4KKQ8R4qhY+fnpuJ
aiXbqI6locsSBb2dowfGAnlpNn/oADylrlvodWYS+JK2qqlUwNM=
=7YJZ
-----END PGP SIGNATURE-----

--16ENUy+GjPWtigaC--
