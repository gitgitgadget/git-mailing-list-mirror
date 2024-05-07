Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2809E6A8A7
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057626; cv=none; b=ZhTGtJ9WsZ2geXGluC7jqyygSLv66FMUurVurwhu5PY7SN8PR95mqEwOaL1DEfU3PQEroXaQIaUl4cbTAQGXxjSD0b38x7hNE9woXaZ7Onsj64RCgYjvq20uYHymN0cAf5AVp+hynjtffABw8jcbmRaI4kiYTgq3UwgS6TlNJ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057626; c=relaxed/simple;
	bh=SFkonS1Deut8+sOzXo3R7d2TU6wio+VaWoiIFo7PSig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4estba4R4GyKMnXhgz5vK0HW3xM6IzNrzDjwG640BDj5+Je2iI4NVnVACH78Ye93Davfo4HgWnt8hhSFuHDfwxW0kQcGRiMw0xLjnSyfVzSLoMovGHZOUNnPGA+6EgAF9mWF7I8WSMJbPJasPDkloHmqosm6GccMjb9sH72XHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sf38DCAv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gLn16HZF; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sf38DCAv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gLn16HZF"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3763D138024A;
	Tue,  7 May 2024 00:53:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 07 May 2024 00:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715057624; x=1715144024; bh=C2kQmGl05J
	jE+HaDHK30rr/Q7Q7WFj1mzvzVKnUZ6CY=; b=sf38DCAvlR7ZCiM3jG3F5rjO4J
	XPiYtmo7Z+xZLz83+xBzh+YFLiwqqME4B1bX0HK9AvENsvtbFPy6+NYaiblczGxo
	JDGPmPyYmQz3QN/W3N2LBQw/TOIsznm6a4RNMF50c6fPyeXfrLWwqVCsUurkGMUf
	LvzT/y+AU0tXBY4y0kY0VJ9syzaXSwfXV28BhRdY8O25mO+Hoxs7bulryTFzS57e
	Qtv2vtT96rzEm+10q5FRdrmUQom2+x3fdQBfLUySVmITsOzkIzDavACgJ3vojPtJ
	u4DX0UF0Aiq7s/FN+gUTJST9RsGgYlF2Np8vqOS7H6YfdlqZ4T27oZ+BjqWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715057624; x=1715144024; bh=C2kQmGl05JjE+HaDHK30rr/Q7Q7W
	Fj1mzvzVKnUZ6CY=; b=gLn16HZF4A/JMPu9q02WrxogDDhgIidgOwkN7A9x6gn+
	j3B1YuOcfA7RjSf3OGHCJoYXRwhkO3A/SlYzEspWnuftby6UK3ujYXhs/uRXsUKY
	6pQgPsjIs5g1NvBAfm52NCDinleKXsVBTB/L/TI0dFpF0S6w2PwpIz3Z7gKDFsWB
	YAObhBQkh3rXdLfNhVnX+iiRVNOMiYhzRmEwwF3l4/wOAq7ElNcLYlSFZSr84LCJ
	5VQb8q8HwfZx+RIlm1T1Ohm2IiRXr5361Mw4Zi2zmg6C7hmc42ICR6DDXePngAL9
	4dd5bwqXsE/Bf6HZFxGpU+K75+DW7JaGb3zC/bTlJw==
X-ME-Sender: <xms:2LM5ZlE9k9Kymsyj6MsWe6usHTeHVrLc3Z7tD6KxmojddseMKgUZHg>
    <xme:2LM5ZqX9af6IROCUB2UdlpHmlO8NDb539XiRfzaK9HU5r7sQRbaQkOEagUkKar1oy
    82uVEvFWxv9h1ePyA>
X-ME-Received: <xmr:2LM5ZnKVf25fq46odX8RhOc3eSVldKzNxIW2XQ4MeakjNx9BBqhoJY7M7yfx_L80D4BieLPEyYndzxpZAOUi2zEwvzxb1X_HHSSorncz8BLfz9SPmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:2LM5ZrF5kpJAtvDgSsbsC3fwW3eQGm1NFQXtsWANbom_ivy_Y3CPWg>
    <xmx:2LM5ZrWaIuupnArWegpTF2F7iFy3Ewfj5gpKgCtDVglitcZVLozuJw>
    <xmx:2LM5ZmMZfUqEf_hE8UBqcN4EjqdcMxfVK0MvCInf9tepar0sZcMH1A>
    <xmx:2LM5Zq1S9M_Poe6e42P8a1fTYFkBf15atd1o2r70oEOljw5fk9JYoA>
    <xmx:2LM5Zhyqykit73CHvHIl_VEMxTroJHJWx9TkbDJvlKgAmONUkFF403S8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:53:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 827b26cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:53:35 +0000 (UTC)
Date: Tue, 7 May 2024 06:53:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 12/13] oss-fuzz/commit-graph: set up hash algorithm
Message-ID: <f37beb0e8920ca2f57e74e8934596fb65ae935ac.1715057362.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1715057362.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M/ZIlFSV+rOiCcG6"
Content-Disposition: inline
In-Reply-To: <cover.1715057362.git.ps@pks.im>


--M/ZIlFSV+rOiCcG6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Our fuzzing setups don't work in a proper repository, but only use the
in-memory configured `the_repository`. Consequently, we never go through
the full repository setup procedures and thus do not set up the hash
algo used by the repository.

The commit-graph fuzzer does rely on a properly initialized hash algo
though. Initialize it explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 oss-fuzz/fuzz-commit-graph.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
index fe15e2c225..75e668a057 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -18,8 +18,9 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t si=
ze)
 	 * normally be read from the repository's gitdir. We want to avoid
 	 * touching the disk to keep the individual fuzz-test cases as fast as
 	 * possible.
 	 */
+	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
 	the_repository->settings.commit_graph_generation_version =3D 2;
 	the_repository->settings.commit_graph_read_changed_paths =3D 1;
 	g =3D parse_commit_graph(&the_repository->settings, (void *)data, size);
 	repo_clear(the_repository);
--=20
2.45.0


--M/ZIlFSV+rOiCcG6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5s9MACgkQVbJhu7ck
PpREehAAmj1PWSfG4FuLwR4fDTu4vZLz877f3EbdFg/1GPisIS9BRn25pP+VWwcU
VEIORrFzj3hnAHb3evnM+lgpA1qqlH/M/bI2pYoO/IQI3LoEkbd+LjAIjQYWPHcc
9YhHaKcQJIRyLFgakLuM/P81gIUuB4mnUyntYb/TCuRIJXkwGMKnfzlVXnt2hGe0
AB22ILYcN8VzeTPHhEaVjWagY/V2nvqqxXK661KDW/hGv8POvbYGCaawNlxsdBj5
cdhf9JpWmXBizVV7auyznDFc5j7d0FUox9hsJFoiiKiLXm5PMvugL4aSk4wD0d07
roWk6sofk+1GxC5fq8/KZi0lhpmGJEWgQRytwYk8vkw3EkQN9OTGaP4Mv+hMx1Ud
kKRRYaf+0hqF+p93XVq9rgiQiviFLyzkxbIFYRiQJ9fjcC67tdqipxA5nO3/KLUY
+eVNxutEBoXL6DaOcrbkB85fE6P95pPsIOQsrI82BLkfRlb0EF+RKhEUiH+u9huz
YoH2SRWD4n50C1956M2Ftm3LUvHPO0h6MsNoicx4trmaxLf0UjNX9CnTQiChPb7n
yp8G2ksL71WzMniGOcZCEeMmIFIAEJcEGAAgahdhGJM8tjVpiMZt0xxJEKIX1D1s
bCT69gxxEVCozsiW2TNEQ8ABrLHBOrpJw+W1qHw8XIk6ViKafq4=
=KULu
-----END PGP SIGNATURE-----

--M/ZIlFSV+rOiCcG6--
