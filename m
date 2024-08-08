Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F138185628
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723102543; cv=none; b=ftL9C+J7OB0mViSmX4sQiaby12MNY9ZljGjxJ9aYiQUYbGQwS2h/6afcxq7ZxC6tAtVLKXV15qKEFBCENhWqE/HKRhednGxge4rNUYyvSNGzrYbYCascgSzq/n6kkhE0lKbq7Vf2ODCo34RztJ1xFB0Nu+uvTB4LSAGYcNO0jBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723102543; c=relaxed/simple;
	bh=4J+b5fHqZ4mHFNnGQj2LifjBllveWGRcYpi3LzqbusI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMR4W26eWgy9QiF9f6jzz+H1l1FexAp2Z2kGN+2MjxwvGS949TEqY82a8vhUaXjdZCYLKYnXo6m+blv5cjT3kFU48iU/xAgo7ZDu5lHexducceotlyTne6oh3lwSYojj5mGx5bhiqiDRYsRhQLLjAZHi0WfiGpbLU3YdcOaA7TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oYM/CYSn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WqQqEx5v; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oYM/CYSn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WqQqEx5v"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CC8EE1151B7A;
	Thu,  8 Aug 2024 03:35:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 08 Aug 2024 03:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723102540; x=1723188940; bh=nmmneoxzFA
	fI1Disqv2spSVr+fORkAoQP0PHid2f8Zg=; b=oYM/CYSnXmo6iqnZD0YwCEEo2o
	WT6lVrZowNF27ZQIOPE23FfG0+OXPYDwrb6k+6THZA0mpKHIm4DiCMHZBAQbcX2F
	G9pCb3898GS5LJT+rG+D2nOsjzVl+YCWVPJy7CHgBFePSJNYkpJVXp0CPhYFk9IP
	Dv4F5u4NKdvnnKwx8vZgXJOcboJ8FoTEjXPqWtBID/L2ig+livnWC1Y7yJsYROj/
	RRnJ9Ou/1X0zQB2Bdtu2hCtX1l5TDNGcqFoIya92BKVSY8bqPLPVv3CL0qX1nZ7i
	c7SkzT12sEGBLASxf/iXfg80Nm2uYo0ZR7+FVPZHEFqSgEH2evKXq4BsDmKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723102540; x=1723188940; bh=nmmneoxzFAfI1Disqv2spSVr+fOR
	kAoQP0PHid2f8Zg=; b=WqQqEx5vKnl0vyZ5RdNYO1KrdEdxbGm9mAk6iR368gGg
	pFo6T+q9HPIcqvMTugokiu87NeeeFR7qCOn87DOXwEtuRAlzJz56fWfPfT5QEgMG
	zkZCIzF8GQeMNocaWYptTchxbQR/FxRwXlKfLEEwtHx2NxLpdZNcpbLFPxjg/Qon
	RyyVGnRB5Ox5xc3Is0o3IvsFN1ODMMg4m6BQ98eAg1Z+k5dp4Woj7dqJt9zpKHyz
	WJ0XFpkZOuyACH+r7WJRQ4Eh1u8Ha8wqF8xv/XzP45IEiguFm1/6zsrdMIHlny1R
	NFZzjDGQAhHMjRKky39ZQO2Q1ZCiHA9XG5/i+dF32Q==
X-ME-Sender: <xms:THW0ZtkeK9eCZ7x8LRFBWyed4sCj_xMLMXefW9H2NeTrAzVtdBaMWw>
    <xme:THW0Zo00FUG-PzJ1-iSpLnSqh8-_vVAlSN8fxN34y_tZHzFcMkGfDcTm_fNr8zqN8
    uq-PoV7wuFBFjX-qQ>
X-ME-Received: <xmr:THW0ZjpmmnKSkx5NJDXPfMYRdNyyliZe5l-a-aQ7TnNGxLf8yQKsH1WTfCiUhWPwjg6ZRbpt0IjHdVWbs3IJP8iEHlEOM0jvIzb6uJQHYev1Z5yI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeg
    hefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhholhgr
    nhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhih
    hnvggtohdrtghomh
X-ME-Proxy: <xmx:THW0ZtkO8VE4rF3swWG1g7AEmzw7SZU2xAoLYVnyUnJDBMDRaS9Whg>
    <xmx:THW0Zr0MSpEPGtLMCjnSb3iIZFATpT0JaHeD7LVd2PDvy86mVHvEXw>
    <xmx:THW0ZsvWG4kp7LqL-20Oq0Z0X-m6czS0Px3Myauyv4IQoqs6QQP-Dg>
    <xmx:THW0ZvVnluMrE9HsYlT3-ymrURpy58pRggWwu9Xkm4y8SfVQMYY-kA>
    <xmx:THW0ZmQgT0e8vjwjO340hDD0h_g5175hEBQ1eiGUY5M3VhfNe3gjZshj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 03:35:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c9ddd0e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 07:35:33 +0000 (UTC)
Date: Thu, 8 Aug 2024 09:35:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/8] builtin/clone: propagate ref storage format to
 submodules
Message-ID: <ed314f533355dc38bf8acbf7a69651e47eb8f0f7.1723102259.git.ps@pks.im>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723102259.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lOSPFWNGTwWxuekU"
Content-Disposition: inline
In-Reply-To: <cover.1723102259.git.ps@pks.im>


--lOSPFWNGTwWxuekU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When recursively cloning a repository with a non-default ref storage
format, e.g. by passing the `--ref-format=3D` option, then only the
top-level repository will end up will end up using that ref storage
format. All recursively cloned submodules will instead use the default
format. While mixed-format constellations are expected to work alright,
the outcome still is somewhat surprising as we have essentially ignored
the user's request.

Fix this by propagating the requested ref format to cloned submodules.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c                        | 10 ++++++++--
 t/t7424-submodule-mixed-ref-formats.sh | 23 +++++++++++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index af6017d41a..75b15b5773 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -729,7 +729,8 @@ static int git_sparse_checkout_init(const char *repo)
 	return result;
 }
=20
-static int checkout(int submodule_progress, int filter_submodules)
+static int checkout(int submodule_progress, int filter_submodules,
+		    enum ref_storage_format ref_storage_format)
 {
 	struct object_id oid;
 	char *head;
@@ -813,6 +814,10 @@ static int checkout(int submodule_progress, int filter=
_submodules)
 			strvec_push(&cmd.args, "--no-fetch");
 		}
=20
+		if (ref_storage_format !=3D REF_STORAGE_FORMAT_UNKNOWN)
+			strvec_pushf(&cmd.args, "--ref-format=3D%s",
+				     ref_storage_format_to_name(ref_storage_format));
+
 		if (filter_submodules && filter_options.choice)
 			strvec_pushf(&cmd.args, "--filter=3D%s",
 				     expand_list_objects_filter_spec(&filter_options));
@@ -1536,7 +1541,8 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 		return 1;
=20
 	junk_mode =3D JUNK_LEAVE_REPO;
-	err =3D checkout(submodule_progress, filter_submodules);
+	err =3D checkout(submodule_progress, filter_submodules,
+		       ref_storage_format);
=20
 	free(remote_name);
 	strbuf_release(&reflog_msg);
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mix=
ed-ref-formats.sh
index de84007554..4e4991d04c 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -21,6 +21,29 @@ test_expect_success 'setup' '
 	git config set --global protocol.file.allow always
 '
=20
+test_expect_success 'recursive clone propagates ref storage format' '
+	test_when_finished "rm -rf submodule upstream downstream" &&
+
+	git init submodule &&
+	test_commit -C submodule submodule-initial &&
+	git init upstream &&
+	git -C upstream submodule add "file://$(pwd)/submodule" &&
+	git -C upstream commit -am "add submodule" &&
+
+	# The upstream repository and its submodule should be using the default
+	# ref format.
+	test_ref_format upstream "$GIT_DEFAULT_REF_FORMAT" &&
+	test_ref_format upstream/submodule "$GIT_DEFAULT_REF_FORMAT" &&
+
+	# The cloned repositories should use the other ref format that we have
+	# specified via `--ref-format`. The option should propagate to cloned
+	# submodules.
+	git clone --ref-format=3D$OTHER_FORMAT --recurse-submodules \
+		upstream downstream &&
+	test_ref_format downstream "$OTHER_FORMAT" &&
+	test_ref_format downstream/submodule "$OTHER_FORMAT"
+'
+
 test_expect_success 'clone submodules with different ref storage format' '
 	test_when_finished "rm -rf submodule upstream downstream" &&
=20
--=20
2.46.0.46.g406f326d27.dirty


--lOSPFWNGTwWxuekU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0dUgACgkQVbJhu7ck
PpRc1w/7B8lsD0uNw9YNipbCkGZRHU1l9kzXGsgSzmwRRJQ5Eg+x72CCR1M0HF4a
xNMscbYgkyrfzxrxHJy81Frxy/g9LcysJdPT1jAgi8J0fyEn0o8Mexqbz6SedCZP
JqAKH5mys8UER64t/fos4t3fncK/8zToPMahCaQ/sBea4Xi3EDPNencuIHa6S3Sl
hOaUc0xIPox9YY8iB9tomydcoLEa34tCyhgeMYe78aJIMsvuieG0BgWoST3c+bwI
v5nuKht12V3wAcoK3/W21lNCSiG4vQhbZwgiA4VSrwsrfBS0p8hC1hLZm4mMVPuJ
kWQUjm0gcr7o0snnlGEngnUElp+sg0Lt+F5PN8rF9QnhtjeluUE6peBvDkz3xs4C
Old3UmfYcILYSThG262gHAyhWFBUt4/Z9YOtImhn07vxCKrHqMGql+1V5oQLY6c8
6LNXxI4Dmw1cieJGD+79Cp4T6ftNFYtZNaftJ9I0Jn5HTZwaM1m7uaKMEdfpuhuq
VMeMz8IsfX897kVjfBpfYD6XPgZm2TZpBP+dyBeZ2BOGqC1Qr42FTVeS3wDqktUf
ny1F9zcPXHNxCcFTu3tCHpiVv0YVvt7BHjZCtBqJfWLasL6U/DHTnInKC/TiztRK
fL8YUj/+yQfSzHRa+8GFyMAsi8vBwLCfIl9Sox7sAK5sY2y02pA=
=O8A9
-----END PGP SIGNATURE-----

--lOSPFWNGTwWxuekU--
