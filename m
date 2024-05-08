Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D4613FF2
	for <git@vger.kernel.org>; Wed,  8 May 2024 03:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715139752; cv=none; b=fEvC6XL9i1t2sR/G70PyY/JS9NyVFPgCw0NChY3fKLErC4ZoXXaHFul7WiS2OWiBcHDBaeHDDthbbINARXjhVOODBSquQive3UcW7t9obEamcalsyS3wA2iDlOZnwlO0FmBYlMd/wjqgtoU0+JI3AbM1ER9yaxeg2jDuyPMgD9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715139752; c=relaxed/simple;
	bh=jT/ri/wmCT/dEhbiL+YQkRFhjtWzwvv+UjqrskuZ2Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+xxvRu/gxO8UjmGS4PQKSK7hjOoKr9OLunLkjvXWbpNTc+Bif7CzZbuIy5eSvc2YUViikRMJ2IEGhDnCY6tVvY7XV5j5nqgG4GAaUskTVW024edQitdpxTFeDwGn2UTz4OggGb1uGJZUCb6oEvDofssBm9SYVQl7Np+JsFBE5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PTSkQr8B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A0CYb8vz; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PTSkQr8B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A0CYb8vz"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9433F1381586;
	Tue,  7 May 2024 23:42:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 07 May 2024 23:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715139748; x=1715226148; bh=jT/ri/wmCT
	/dEhbiL+YQkRFhjtWzwvv+UjqrskuZ2Oc=; b=PTSkQr8Bn9R+ygTUlWw5P5qAuQ
	thwxdlnE0lAo8pPqCfqowhfB/8aRRR+M2R+qEUsqRT01Wtkxfy1/XpT8Xm7WnTyw
	CpJLXNfEXxlXPUwPtBvyjUGpJeBPLGoMnT5aNbjfgGmGC0MrASS0LpVtjIVkZE69
	btM0gfzNWn3L2zeohDpgwymvhj6nDgwCMYHpiikJbHCTldnoa3HTw7RQesrdIAUO
	DqUOjHBnhNJbidlnCEMKuH5T++xv0NP/7u8LxhqBZcI++cCPC5Jn82MqS4MrX5/+
	MCr8JCl2/KyHvQg8VM1biuz2CnuGTJSY4BZyhvYn/ihyy5SAdGx5hJzZtJWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715139748; x=1715226148; bh=jT/ri/wmCT/dEhbiL+YQkRFhjtWz
	wvv+UjqrskuZ2Oc=; b=A0CYb8vz+yWQSRzEpqz+BGj5NMOVIMzYiwUsIVUorZzO
	QJNcAFVojjwhmo4T4NH4QBWtfR2Cfc1+7H3vgK/Ra0xo1SegmmCQyySyj09V44Br
	RcV6vWQ2S55ING8VUu0pZ6sYWNyNwziNzDiTx6dI5hHy4cfd1rd1AHVJ0i/ZCDe7
	g4CNz48PEzRQ0n6/yQe85a4Pq4An37DNPsYm7tni4YITfzsOF064gI0oshNtGT+5
	6a84/ACjKCBIhIXN1onoYmalPbNVr+Z0QunpcMUl9tCIY+xlGO//YwrTKTAxqmpe
	sB6aHNpZJY+2Bq7J72g+JLoniPFLvtfQE7TCU3b40g==
X-ME-Sender: <xms:pPQ6ZniL-VR4Ocav8JCPgEgkuVMeoqlmC1oZYzuPsT5q57kKpKiRuA>
    <xme:pPQ6ZkBOJEzRqv3JTOonTQ54aQUAmz0fH2y7aRiyy9ao0e4xHkumQQcmbnOiIGSa6
    KMk-u9pA0LvVcBLIw>
X-ME-Received: <xmr:pPQ6ZnEpI6SdDX1jD8Z-SJyhshqJGnVnDgLHnk1_mn_Y43hOaWbdbmtJPlKh0Fa9ex696D8MOSSgaxdZc4UKQ3_5lIOAuKM6lJV1VTV349vmqU4lmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvledgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:pPQ6ZkSXQ_FoV16--8OhkQJ-vDf9nOzY7wD67wJSFoULyJxylPxREg>
    <xmx:pPQ6ZkxEohpcsl-9JEFoJDzTtlb5ZCIKFKIxjmPvjEjKiG3oJnMAqw>
    <xmx:pPQ6Zq74aX-a7FYNdMQZCexTh9hBSDZe_4xQV2gALISLQf7rPDhXkA>
    <xmx:pPQ6ZpzHkAyw0akJ7NH6kLbfAKcxBeVRxDlgoKBqaBGgTRv0bHRFPw>
    <xmx:pPQ6Zg-G6yagadD8bzyzdqn6ASaDJZhyINM8xvmuV0ntj2dsb7ty95uu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 23:42:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 85d3a008 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 May 2024 03:42:16 +0000 (UTC)
Date: Wed, 8 May 2024 05:42:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3] scalar: avoid segfault in reconfigure --all
Message-ID: <Zjr0nmJib_1EtdJU@tanuki>
References: <pull.1724.v2.git.1714874298859.gitgitgadget@gmail.com>
 <pull.1724.v3.git.1715126749391.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S8LGCFQcXIWSSRMB"
Content-Disposition: inline
In-Reply-To: <pull.1724.v3.git.1715126749391.gitgitgadget@gmail.com>


--S8LGCFQcXIWSSRMB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 12:05:49AM +0000, Derrick Stolee via GitGitGadget w=
rote:
> From: Derrick Stolee <stolee@gmail.com>
>=20
> During the latest v2.45.0 update, 'scalar reconfigure --all' started to
> segfault on my machine. Breaking it down via the debugger, it was
> faulting on a NULL reference to the_hash_algo, which is a macro pointing
> to the_repository->hash_algo.
>=20
> In my case, this is due to one of my repositories having a detached HEAD,
> which requires get_oid_hex() to parse that the HEAD reference is valid.
> Another way to cause a failure is to use the "includeIf.onbranch" config
> key, which will lead to a BUG() statement.
>=20
> My first inclination was to try to refactor cmd_reconfigure() to execute
> 'git for-each-repo' instead of this loop. In addition to the difficulty
> of executing 'scalar reconfigure' within 'git for-each-repo', it would
> be difficult to perform the clean-up logic for non-existent repos if we
> relied on that child process.
>=20
> Instead, I chose to move the temporary repo to be within the loop and
> reinstate the_repository to its old value after we are done performing
> logic on the current array item.
>=20
> Add tests to t9210-scalar.sh to test 'scalar reconfigure --all' with
> multiple registered repos. There are two different ways that the old
> use of the_repository could trigger bugs. These issues are being solved
> independently to be more careful about the_repository being
> uninitialized, but the change in this patch around the use of
> the_repository is still a good safety precaution.
>=20
> Co-authored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>

Thanks, this version looks good to me!

Patrick

--S8LGCFQcXIWSSRMB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY69JkACgkQVbJhu7ck
PpQNYg//Ul20pgHzkPLBAi9EZWe9unTaE7e+0uhJvTDf93ucWfEmSwxPAA8ELlLX
tI2Aj8yWyRCr802yISMH03IRmXlW6CtmkwRmuyf70DE8hCoAkA/AaQFzlJXTE6Ik
XsvJeOAFlvpaCBjagfi25HaQKkKbPoS4ZDlH/MKHR/StFaiVd5L6V5BueMJfd1F3
16oyGhX2OJOwf6oT27Sj/t/VaZ/XtDTGvhA+FlsH9PjmonRKzGaqOiR+07/oLdxg
U/L0JOqV+FA40q0kXsW9Kp2/XKRmMQxqfyDHcK2O2uYaHICP/prpZgHJ93WGvhkl
kQuvCSxcjTvSYhh6e1mES4ANreCvBf/JlmdSETrSiUkp63IyKVInyLNtEBKT2dnk
S1yqG7THQVyvJjqW9HzL6A08wtvSFpcdTTxJxaYgNdkxKJrRvn4YDLoj5W1rleju
TRBAY4y1Fv/sow3gNqSxQD+3NXln+vbSCy96od1Wn+3j0rX4A1OD23TeUJ+knx6k
DrIszn3Xm1d+pamJ2I6CMlopixJs29+x2fV1QDezp3uplLMsgHPkdyV6gicxCDAv
qo5sFgX/176I7vJm2wsFIFGriyQFFJ4c8n5tAfotmMECF8IPQut/G1I02Ge0VM/k
vI5+1tibPbFDDt76//J7j91IDthWOQeAS7I+P2PqBZYPYOJ+K1U=
=Q4Xc
-----END PGP SIGNATURE-----

--S8LGCFQcXIWSSRMB--
