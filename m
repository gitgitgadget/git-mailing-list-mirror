Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A042208A8
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 05:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848887; cv=none; b=GI/zPtemiqTbJ/m/JlEZpnC9XtGJHk0Kd9Q677RkTVGreS7sxFWwZg1jKG3QDWyTIvCfi+f7jFUZbjVo/6O4bBT2H1CszlIhgLCI1nEvxVwAFGYLTJ/lTi3TbyXwZu4CXVol4TBi1Hrp5gCzQhL4rjSdchO05wngTpahEi56v34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848887; c=relaxed/simple;
	bh=vaUlDc8inW0vv9csyVcCwIm727xMjw+JngAqbfAQD5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWYhDw2Xl0RnKpQ+Ok/G6ZMNtk+C/cZkmt22kYhR8SFGWJ0ZQBFpQHOVoKKmaSoFdE5xyFbfHxk9Q+WMjxBRvVEGFdBeP3TJYEH1Rly1kBySEC2p25+v9srp80HcU5+sOXDRv3CndPRoe/AHfVDAOQxSk7CEIHFir3N0MtySO6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G3jboM6z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bhw8/3aw; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G3jboM6z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bhw8/3aw"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id CCE3D1380252;
	Tue, 23 Apr 2024 01:08:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 23 Apr 2024 01:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713848885; x=1713935285; bh=aenadhVcZp
	+djtsKnBa7hgEUVlc3KuN4woe7JVIEckw=; b=G3jboM6z4YNNRa5hbI7lI0NIcH
	vIoRrm4+jf+YZ0C6tbz6uVSvp3Zh2C0mwtAiTrVH++tpnH82s/y00dxbojcfKGpU
	UeHThhR0qe1bTcrwrLEGejC4QJyIHAB4X1zFu3jQYJIFGs96oiFQeYkbklKH5miG
	Z3JgQI3002/mPTzQQ+DX1nQ+hS3jPLL93CIJf7+nwGnuPNZXe/raRPA9QZlFla+C
	xZn/j408hEBM2xy9NRTfPgyHXxftOMYYnpIgqxxWadTzaSmYM1WlyEnTzaD1e0py
	JvPn/Gpt7Zr6PSb7QLj+GByjI9uVF1R3cnd4S7ewbsVsn5XCKDSCB2WKXrCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713848885; x=1713935285; bh=aenadhVcZp+djtsKnBa7hgEUVlc3
	KuN4woe7JVIEckw=; b=Bhw8/3awu+7Fy9ozap6RtcvfX1lIKGn1wp8cZ/M2vgoB
	5jW9MbEMuqovf3ScJYNZi2v3ZYHZ9A3AJmN/kkU+0GgMrnNOepEE4AlB7Imte0vX
	x8/W3Hbca/WeF2YWt8+47IlYP73qRwH7CZABsGJgWBLTYZXqd7CbBB5GTjPTFZvy
	QUE/8NJ9qaE12ipEgCZaTtuEU0APiGs2PyKk1z5gTBU81pg7FNJd2ZB4AB593o6W
	gyVGu6UJYFc+XJyUu0R/CIgVPw404aTAjBxEaTTds6ZcZcbIW6Tr0v4PjUmE6xGC
	Z31o9XNhioV48UvA0z6XmA5lWgZ/q0I+1LYxvZve4Q==
X-ME-Sender: <xms:NUInZpg0DpiMbu4wYKpnQJz-c3-dJVNaOpN_Y6mqWsEJGZi-zo2CLA>
    <xme:NUInZuAQYxUv23OOKFpsMYm8Ju_pImjm22A3GjG-WE7Qk2GfkZMFwccg7oHA-HUc4
    3TTKxRNnUtnPCM0Aw>
X-ME-Received: <xmr:NUInZpHHN-LE5kHShGMsUwIyvJLhq_Diav3Zi98NNArN9iMlVfXV5XI31ar3bmOO5QMA55ARvLo5rzuo13W5qFrtnYLvHQLZzyODOR4q6Nr0aJmx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:NUInZuSqm2sVVywavyytyAvwWqmbnbo3pp61gs4oiRRutOxddSOujA>
    <xmx:NUInZmxfRCuEDCMHN_GYKZ-2XZJgAa62Th3iIkvkqPU9li0ObYvbcQ>
    <xmx:NUInZk5FTvqh8B9tRjsae1KxUQ2NUNorcmN5Uq2GEt-aKusBmll2hw>
    <xmx:NUInZrwnHeCa9YvQDc70u-hx73szRwkthRHL1ytKZpI8H4O4A9wApg>
    <xmx:NUInZgtyjdYt8Gg1mv0eb2BCxql0bcuKDT0MFqeVrI24Km19UQDLumu4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 01:08:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1b24aeea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Apr 2024 05:07:57 +0000 (UTC)
Date: Tue, 23 Apr 2024 07:08:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 08/12] builtin/blame: don't access potentially unitialized
 `the_hash_algo`
Message-ID: <1813e7eb5c2a9e136f828a74c53843be2f13f90c.1713848619.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1713848619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/9jIU3YUUt1YKdQh"
Content-Disposition: inline
In-Reply-To: <cover.1713848619.git.ps@pks.im>


--/9jIU3YUUt1YKdQh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We access `the_hash_algo` in git-blame(1) before we have executed
`parse_options_start()`, which may not be properly set up in case we
have no repository. This is fine for most of the part because all the
call paths that lead to it (git-blame(1), git-annotate(1) as well as
git-pick-axe(1)) specify `RUN_SETUP` and thus require a repository.

There is one exception though, namely when passing `-h` to print the
help. Here we will access `the_hash_algo` even if there is no repo.
This works fine right now because `the_hash_algo` gets sets up to point
to the SHA1 algorithm via `initialize_repository()`. But we're about to
stop doing this, and thus the code would lead to a `NULL` pointer
exception.

Prepare the code for this and only access `the_hash_algo` after we are
sure that there is a proper repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 9aa74680a3..e325825936 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -915,7 +915,6 @@ int cmd_blame(int argc, const char **argv, const char *=
prefix)
 	struct range_set ranges;
 	unsigned int range_i;
 	long anchor;
-	const int hexsz =3D the_hash_algo->hexsz;
 	long num_lines =3D 0;
 	const char *str_usage =3D cmd_is_annotate ? annotate_usage : blame_usage;
 	const char **opt_usage =3D cmd_is_annotate ? annotate_opt_usage : blame_o=
pt_usage;
@@ -973,11 +972,11 @@ int cmd_blame(int argc, const char **argv, const char=
 *prefix)
 	} else if (show_progress < 0)
 		show_progress =3D isatty(2);
=20
-	if (0 < abbrev && abbrev < hexsz)
+	if (0 < abbrev && abbrev < (int)the_hash_algo->hexsz)
 		/* one more abbrev length is needed for the boundary commit */
 		abbrev++;
 	else if (!abbrev)
-		abbrev =3D hexsz;
+		abbrev =3D the_hash_algo->hexsz;
=20
 	if (revs_file && read_ancestry(revs_file))
 		die_errno("reading graft file '%s' failed", revs_file);
--=20
2.45.0-rc0


--/9jIU3YUUt1YKdQh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYnQjEACgkQVbJhu7ck
PpT7Ug/+P3EzcMayxFq+z7NugG1v4Xm9thZVeMuBfVoDtBjd6pmqre5cA9j9B3ZZ
EP6T5OAp+4w0gKjzXm0dYzOPpX69XZEX/Zdh21QtAQ3RelFbRgJIgJScHOvLz6p4
Ubg7mB6uAQMLGQzyYFbwNwfepq9cLgdo7UkaFe3l/C4NVlBtoWjotfJYH0eVAhdQ
KrZTJia6VXGjTv+6lqWrDC7vgaYddpS31eG9A2TO5kBYlgVMiPDgu7qK2CXPpdNq
6tfpRbcsoCdbayZIrGSxby/KKYb/gvv+pMwoUTRX8gFftjL5uc/i3etFxnRZ423u
Ak/TPoHZdRUUeujls1rJX9uFLDZjaSIv2TgyesPyN5TEsm1t+vzL3xkbs0nK6iba
LsqkVaUOJVzgrz441Mc+CR4s9yFRUUXHu5Dl3cUFmpnfcI1w0M32C2NOkmQg8R3t
ic+qWeBwCQXma/dYaydXPGGqsJFCztylxRf8pp9Ppd1+uogOR6Zgbv4KmA4TWxEm
baMO6QoFcblAbsY0n6T6kWcRq8Ug66kyVNXP0oaQrI5HHIiSaEDxMjCshMvc3gJm
IQB8E/b5s48Eeke+n16eNYnjFh1Vp2f44SlTLV92tdih/qVlhZJcMk7G9yr5SpZ2
EmQ5VJqF70vOGACdSWLBvC+cQ5/pUFt+sgbjTGbQ4CsShaZmh0U=
=Z/+k
-----END PGP SIGNATURE-----

--/9jIU3YUUt1YKdQh--
