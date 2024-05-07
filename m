Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3234B6A8D2
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057615; cv=none; b=TbxzrVAC2u2+vfa2C/l20yjybGtPxtSKod+VTcOABPdMNsvK/9F97Z7X3Q1hs9jYMtRBfLTGLVIrJeB7VUegRgCo48czHsZdJoA3Vd6Q+/K8/PrmeLb81II8ISfZ1AwRW2gk0F5/HKjrN/4cEx/j3fo5rUhSMkZgDt7SfDI02Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057615; c=relaxed/simple;
	bh=E51zcTX+liZay6CUrXNT74OlitW6o+CrYmKL5dThJFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGLCFJpBcWFgXD6eFYjbVNCBBU/9AGXKq5eRUbIxr6QE8sdnSu1CgYm77LzhPF+oT5ELaB1Zt2iHNtgZJyHuwSgW1LmRP+ods05VYLnUe9nWAEE33GM2Zp58mboTG1mOyuLRJlw8PLmhYBy6C4EqiVH6JZsLuCVjxSyI4jWWhr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l8m4E++I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AUZIP1h8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l8m4E++I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AUZIP1h8"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 72CC8138024A;
	Tue,  7 May 2024 00:53:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 07 May 2024 00:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715057613; x=1715144013; bh=T5FQCQqFmr
	6H4P8sIjfXs42aRmtm1ntm0z0T2ZcyRmM=; b=l8m4E++IdNgJRVgAiHZKPOPOQw
	YX3APwgpkYGtdGws2xmlIG+B5pV+m818SZgGgHkuLzvog/gNFiUq8AKyCcuAkkFq
	gXMG5Jz8VREEzxm6TLsnXBzJXjxcfQ0hspDES5thqzF6DxQ6oCXG6GfiJm8QN7wx
	IRXckuixPpNe8y94PhDoS/E0qbAeg6Ducz4Jo0+HkngN6O8NMVpoF2wkilYX1s6G
	cqaK+qWwZVBM+yV3/CvEUZ1jx8d3Irg6psMFkoiaMySbf0BrtmTAwQCiCHgz5Iw3
	vxk+47xAamJvlpLHzJkirRIBPuBEbr54R+g1o89tUdz0cZ9JkStCkgq/gJdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715057613; x=1715144013; bh=T5FQCQqFmr6H4P8sIjfXs42aRmtm
	1ntm0z0T2ZcyRmM=; b=AUZIP1h8HfrH1Mh+BosrPOusyNtgMOv+gyz7Axidfor4
	fOP/zq1KPf5mpsqqXp84Kz5FWIGlzRv2w7Z2NiogtsbcMhklHcfRKcMGKxFw9aQi
	2DC05hznvqZBTtMn0sAhrC03nfPXMS+RNWDplkG32pF3h1HaHgyStDUahcWXBe6+
	X45ujNuzSXqqM5tXornzgzXk6pUNZA4kSNrv0GpaUaxw3WiIxAEKhgNGbcvf0jk5
	8nv4nWicQoT9rtCR5sODnyYbXtlYkaWbau2Vw7tzh5ezFBnOTmSBPEfHXuD0YkAL
	ORSvxE0hQVcFPHia/tGB8Q0BCaY+76+WGDgAF28BAw==
X-ME-Sender: <xms:zbM5ZmK6EAMO5ustBCzUoTW6UMdseWBQBMqNXfNrdM1GyKDDZoWipg>
    <xme:zbM5ZuKD4WuLU44UZa3dOykhkXBzwuQTejEIpVRr8O3E8uSUiiVxOi0OAnEqALl1R
    g8CZv3ix-v_4gGU3w>
X-ME-Received: <xmr:zbM5ZmuLOhOJFiJg_H-OwNONc6fB3dxuoaq_YzBD5VCSQkSS1KwAQI3rKL47FfkfOeC8k2aNu1miK0TwxDxxCBFVx8j-oQ3O00Ko2pfg2NOQcjw52A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:zbM5Zrbqtl6Qi8Sa_oXC9H4PCOrkVWbDLRVR2i8AfFixdEZd7jZf_g>
    <xmx:zbM5ZtY3zRppLijgXdOUwCSYlMUYGaUIVrGPMjx-zCHlpEUPUOPxdQ>
    <xmx:zbM5ZnCmuVdniq0Ahiq16vbmaQktXHF3qcb2sp3ZRxJFPQGG48gUfQ>
    <xmx:zbM5ZjYPcicHqBaCyBpBW3ot2vEu-LANUmI2emHY3Hxh0HnRQzGlXA>
    <xmx:zbM5ZsUO5v6hUiUwJJK5TcmwXBk4xrmCe1y9PGoTT2SIzTJqufkynM6F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:53:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5022651e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:53:24 +0000 (UTC)
Date: Tue, 7 May 2024 06:53:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 10/13] builtin/diff: explicitly set hash algo when there
 is no repo
Message-ID: <e7254ae757b5522a78f4bc390c72af406ea08641.1715057362.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1715057362.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E4UIQCNH9bKSRvZ8"
Content-Disposition: inline
In-Reply-To: <cover.1715057362.git.ps@pks.im>


--E4UIQCNH9bKSRvZ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-diff(1) command can be used outside repositories to diff two
files with each other. But even if there is no repository we will end up
hashing the files that we are diffing so that we can print the "index"
line:

    ```
    diff --git a/a b/b
    index 7898192..6178079 100644
    --- a/a
    +++ b/b
    @@ -1 +1 @@
    -a
    +b
    ```

We implicitly use SHA1 to calculate the hash here, which is because
`the_repository` gets initialized with SHA1 during the startup routine.
We are about to stop doing this though such that `the_repository` only
ever has a hash function when it was properly initialized via a repo's
configuration.

To give full control to our users, we would ideally add a new switch to
git-diff(1) that allows them to specify the hash function when executed
outside of a repository. But for now, we only convert the code to make
this explicit such that we can stop setting the default hash algorithm
for `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/diff.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/diff.c b/builtin/diff.c
index efc37483b3..9b6cdabe15 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -464,8 +464,17 @@ int cmd_diff(int argc, const char **argv, const char *=
prefix)
 				!path_inside_repo(prefix, argv[i + 1]))))
 			no_index =3D DIFF_NO_INDEX_IMPLICIT;
 	}
=20
+	/*
+	 * When operating outside of a Git repository we need to have a hash
+	 * algorithm at hand so that we can generate the blob hashes. We
+	 * default to SHA1 here, but may eventually want to change this to be
+	 * configurable via a command line option.
+	 */
+	if (nongit)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	init_diff_ui_defaults();
 	git_config(git_diff_ui_config, NULL);
 	prefix =3D precompose_argv_prefix(argc, argv, prefix);
=20
--=20
2.45.0


--E4UIQCNH9bKSRvZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5s8gACgkQVbJhu7ck
PpSnqw/9EY2jqpQTXUtbw/9gGLTjKcmLv955sSCG3gUtOnEIR5Rt0YnNxJ/4LBxC
PhBr+iIMoP+EuoC9GoZk/yhZwnSGnqw2fHfySZg6JRFioYx2Y57pOXGiwoZKrrb2
m8etCq4lfIx8XFUkBPb6nqKjafLsylmCHeb6azVbMAgCAfuQnIid8kCeccJVvoPR
e98t1FbIKhtcQ4vu25Yqg/0chNr4qrcNlPGLiKu99qanaJz2YInyeFMa5MdOqeu/
LZ+yYsysdXkOI5b0SBks7iRU2+jK0Ujjej8tqErUcSMGivZNqXzXTeLHEBxZKd+Y
Gh3bcWGcmLi9wAPb+snxw5BQy6f7gADem+sTXB3qGJ7zGgLgNTC+p+e34T6HWRNm
iEsI5xMW1f0rZmwX8CDoAhoy2IwZDsCPIPTY0yPtrrU990rpwYJZZH0Ub4SJr8iO
XwnjSkZCjL7ie7D5+LSYpNkoywWef4mRWWZlxkmVLCQaErWQsyo4JQ+4Q+nzv52a
JgbT/HJKzeilaCiD5h0bbKzEtW0mgFfuOY01kQZiI1QODbhdXNOvkqTzxuDvqDSK
tx7M2RNvoNuIj+UqYbAMKYyGhuZ+Uj9YnSKbjt2kL9TPi76ozH6yIyjiWvvdi0s5
M8E+X1898L2E9ll2SCC2hf67uqE8HS4TdaSgsZ1CaDBtmxDthy0=
=SDAw
-----END PGP SIGNATURE-----

--E4UIQCNH9bKSRvZ8--
