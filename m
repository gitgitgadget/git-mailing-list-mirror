Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEED256D
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 04:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722573860; cv=none; b=rbGQMFwQbIA4T9kQr7zF34ocDH1bnqOmERRyBmk7SQ+D+slE03/BAY/0DAJ+lPxhyUOg9Vgvr/jG34boPrY1/6p4KKG7DYmNwk6v+wiYKdQ2kPAMvrs6sCh7nCMoVhoDfxAOUFfNFtvTcOVwWxQRZ/yFOEr0lj8EhPlJkfVUS2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722573860; c=relaxed/simple;
	bh=jJck9f8G3xhCQyK6YKVVlY5twrpd/X7sMznLemIF0vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHsS963l8bBjULvbED1PoeuK2z94Cgcp4iqs4yyeVgmfHEmSrnf5AGu7te7idFf8YjK0isQLDVCiSlkuyqRJ6j4lG3udh9+yovxGZYNCZWIcELSlxTEd/wV0ym+KeWBY8WljlXfP1kF4dCOPFfHSF3B4VKEO9PNmb2VOZIU1Zmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DzVmj/KN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oklssq4v; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DzVmj/KN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oklssq4v"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E295E1151B55;
	Fri,  2 Aug 2024 00:44:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 02 Aug 2024 00:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722573856; x=1722660256; bh=DF/yOd6G7P
	zot1DatKXNgR/jvZBLd6Iq7K4AxMJBvKU=; b=DzVmj/KNLi9eCKdtY/8lfDz/6s
	I9MSx01cH6ZnpafSR2kAHMEzZj+e9z7P238uYqiN5nyiq6McmMLobgoxaaMSWHn9
	DNCJFiUb9Qzlkq+iqYw85UB/lZXSh1KD6RBuCGPMX/YWSZPCV09+o8YfQoIPcTJ0
	HBQpuA/3nc65d9MpJH5Ip/9O3XHWsh5JUA5a1mXm8ziLy2lj2aN2IxN6xmdPsqot
	XFxATVU6oFLzXUQFKtl3x4ND0ufEiVA0mJFJDWfs1QLCoCv/FFmLG6y0096jB35I
	EU1mW0bPtxXvJvXZXj4sQZEEGjrmQbPZ+3xUJOuERKAPK91nKqV4ofMSM7xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722573856; x=1722660256; bh=DF/yOd6G7Pzot1DatKXNgR/jvZBL
	d6Iq7K4AxMJBvKU=; b=Oklssq4vR3p5cITZjW+dWtRjYKxx54Gm+qeCPgGyqNaZ
	o3olyz2BrkPGJerJwWh90edBLpDsnLICQJHmlC8VXzw2AulpqmbvIqdnbcNjudl0
	nCl/VUz8lQLEt5qpYI0MhGcFXfBpu6QigHgsWG3ZG0S45o2qL1UdhVCzEhGOFrNc
	Z/0uJDkikC8+EEOGFWDxecHaAMA915RBEzBWUqYIsq4QU0ph4NtfJv3MWFlYSJJb
	1XJ3lpWrS2MUiGR6X+cwXhamzRpgTWCIVU1mOyVhIhjRauqYFr9cXJSOAeBnR8Ih
	2C9iS4Kcs0RHro99srysiIR/VpeAbuiG1JrTJJbQlw==
X-ME-Sender: <xms:IGSsZu2Kz4ZvfSL0c8U79SC4GlIAT1lzre9ooDXrSpwwJK3hnbXu7A>
    <xme:IGSsZhExob2PQY2ICKz-ndj1MV7TZ-JkxlJVQX2Wx2PY-9xfhQeiMA77HKnZnoKgc
    jzzrbCiDRCmbWh_Tw>
X-ME-Received: <xmr:IGSsZm6Cw4C9Pz2cojFjjoAmxX5dpUDIczkyMIXVhJYT_-kB9VweBbh3AthegMEsGhla348abWdCW39mZ0vcMeNeP0jfInBs0zYzYNIvsJWUSZtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeelgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:IGSsZv3IuGDIOXBbvuuiEajZOrjb_XvyLZEPH9lSixXMwSy5McttdQ>
    <xmx:IGSsZhGmwB5c5joOdUwsjCYuZqfZ1dhFkIhxRd5jTGv2uKo1yHFF-w>
    <xmx:IGSsZo-XzIMHYxk1Ad0q3XT9REzJxwFZM98xVoQ14gM6FL9Q58C9xw>
    <xmx:IGSsZmmTuBrgXz43DSCT6viVA4oikSUzzFAjqL1v-10-avfvOUT9Mg>
    <xmx:IGSsZhDA1K1t3XVEeGxf-nk-Wf5xbs6Y-cBQQZmwGLEtQvuqNfdijm2U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Aug 2024 00:44:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 109966f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Aug 2024 04:42:40 +0000 (UTC)
Date: Fri, 2 Aug 2024 06:44:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin/ls-remote: fall back to SHA1 outside of a repo
Message-ID: <c52112d3946b2fd8d030580cd7acb809fa54012a.1722573777.git.ps@pks.im>
References: <20240727191917.p64ul4jybpm2a7hm@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AGBtVSU8S4DGd6YM"
Content-Disposition: inline
In-Reply-To: <20240727191917.p64ul4jybpm2a7hm@glandium.org>


--AGBtVSU8S4DGd6YM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In c8aed5e8da (repository: stop setting SHA1 as the default object hash,
2024-05-07), we have stopped setting the default hash algorithm for
`the_repository`. Consequently, code that relies on `the_hash_algo` will
now crash when it hasn't explicitly been initialized, which may be the
case when running outside of a Git repository.

It was reported that git-ls-remote(1) may crash in such a way when using
a remote helper that advertises refspecs. This is because the refspec
announced by the helper will get parsed during capability negotiation.
At that point we haven't yet figured out what object format the remote
uses though, so when run outside of a repository then we will fail.

The course of action is somewhat dubious in the first place. Ideally, we
should only parse object IDs once we have asked the remote helper for
the object format. And if the helper didn't announce the "object-format"
capability, then we should always assume SHA256. But instead, we used to
take either SHA1 if there was no repository, or we used the hash of the
local repository, which is wrong.

Arguably though, crashing hard may not be in the best interest of our
users, either. So while the old behaviour was buggy, let's restore it
for now as a short-term fix. We should eventually revisit, potentially
by deferring the point in time when we parse the refspec until after we
have figured out the remote's object hash.

Reported-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

I didn't spot this in the "What's cooking" report. I guess that's my own
fault for not sending it as a proper patch, so let me fix that now :)

Patrick

 builtin/ls-remote.c  | 15 +++++++++++++++
 t/t5512-ls-remote.sh | 13 +++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index debf2d4f88..6da63a67f5 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -91,6 +91,21 @@ int cmd_ls_remote(int argc, const char **argv, const cha=
r *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	dest =3D argv[0];
=20
+	/*
+	 * TODO: This is buggy, but required for transport helpers. When a
+	 * transport helper advertises a "refspec", then we'd add that to a
+	 * list of refspecs via `refspec_append()`, which transitively depends
+	 * on `the_hash_algo`. Thus, when the hash algorithm isn't properly set
+	 * up, this would lead to a segfault.
+	 *
+	 * We really should fix this in the transport helper logic such that we
+	 * lazily parse refspec capabilities _after_ we have learned about the
+	 * remote's object format. Otherwise, we may end up misparsing refspecs
+	 * depending on what object hash the remote uses.
+	 */
+	if (!the_repository->hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	packet_trace_identity("ls-remote");
=20
 	if (argc > 1) {
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 42e77eb5a9..bc442ec221 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -402,4 +402,17 @@ test_expect_success 'v0 clients can handle multiple sy=
mrefs' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'helper with refspec capability fails gracefully' '
+	mkdir test-bin &&
+	write_script test-bin/git-remote-foo <<-EOF &&
+	echo import
+	echo refspec ${SQ}*:*${SQ}
+	EOF
+	(
+		PATH=3D"$PWD/test-bin:$PATH" &&
+		export PATH &&
+		test_must_fail nongit git ls-remote foo::bar
+	)
+'
+
 test_done
--=20
2.46.0.dirty


--AGBtVSU8S4DGd6YM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmasZBUACgkQVbJhu7ck
PpSQDw//Y5i+S20IRgVEk1+xGuUjBLKREkEv4Qxm3APDmk+fijjXOu+6CUjr+Ior
0x55Fo0hVQMEP52Qedl7r5yRZlSra/j6j8VqbjfKoSnRpDlz20Q6gkmdAPV1cjQB
5Osz+c4HLH3SIU1DdFhd5Jqxx2psT0wq++3QLO3AvS2k3XdkHgUOp0M+r/9oRBb3
SinNVMFbPyJM0gW2S+ispxZEuk8+5Hv7ySdsngVXROxR21j/WtBkZi5c5SWlSE3Q
yHlZ7CrrBU8R0ZEeZDiZL7wC+Yxjj0CfmCdhnJ4YVteFQg+XFBaEmrAgSZuz+xev
FF7qbsrp8pse3RKg5LOrKqXTzmq1dlh4eQSiazXfKaWi74TYC8TabhIyN/OiLF4V
YG5Od/VKWNAa9P1XdSLwnM3clBx3AWp+bwp46VlxlevcqGu8myTzRLAx486xWxlJ
4qqoCRnfZ4vm5Xo9kvy2hH5rKEs8OrQn6yg0FhMLeVlYghNhx50eVJnMerLXX6iH
R25Qqev2Jmerez+EgMWMT0Ml2TVuiLizlMpp6NrEHOk8WAK/G3JTiVbukpPTMP/W
ETLj8nTXJX0aiys72CAJpcZ61geYea1Px3YIMsd9MbNbtks/xwDIsBi0SVH2D/y3
H003nLA1S9D8lGHXRKxH2JbfwFKVWZHNodGeOd2Y1w6zH/bUyUY=
=CJen
-----END PGP SIGNATURE-----

--AGBtVSU8S4DGd6YM--
