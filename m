Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C2A1482FC
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347862; cv=none; b=Sb0td6uSs9Lt7gKAHvRh8gsk3He7k20mz8zYeU1COyEtwkwXHjyo1HP0K1qJaOY7OyuoFb6ZdoBisnMQ0ni/ajOQramQ1bAbR6incF0+9ty6OfkfQmN3EUuzpZZPAir6rW/dcUO0qoCYl4PSa7k+V4IdH7CwZDuwEk6rzR6zEaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347862; c=relaxed/simple;
	bh=Ivcq27/pCGZEdfR+nDnAnuKtaoQWmwMoLIp/z8rlRBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7MFIkk217FHyp/SK0g0R+yPHKVd9ueWySqvgPlUeNPvucVcIy7jIv5/N6s3bqin4FpsfAwSUZ5rKtXQQIXS7q0FhRur62uQIfaOnED3TJqVWm0y8z02cV8rUaS5MehcZnq9iYuVSu+TYchsEDIXlQiNvx3P2q3sKl77H4ArlEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xb+dzkMg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oY18hx21; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xb+dzkMg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oY18hx21"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F371711400CD;
	Fri, 14 Jun 2024 02:50:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 14 Jun 2024 02:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347859; x=1718434259; bh=1nd70QBh9k
	PTA8NdMHdvLr+wCUqLL50ScgkYYwMKgfw=; b=Xb+dzkMgRIUs3twcNFkjHE7BPP
	ksJFZEuc2AsU/bmWw5nJ/XwloerzAZ0Xp2eLQs2Hp8JR0DINLj7DqaGxP4768ilf
	XD+eMgTA4olSHZhMXJ6U+XTLCm2ULIQYnwSWAhHx/EsgKA2QyuW1jraY6vphB5PO
	c5nlkT0MDpocc3oWciwqraIjBXF9CFxiNLtct+cWfEGtytT7KW3axY6zBDz6+H/s
	WOQEl64/1YMxP508ptNGUTIiPAZSniQYktqd1pJKnIZ/pMWaDCtOkUzaanfUBHjl
	g9QrrGL4BSFmiK5JGroTGHZ9xK+C/pWDDQKw0dP1NpeNzqh5Wa3PewRmmqag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347859; x=1718434259; bh=1nd70QBh9kPTA8NdMHdvLr+wCUqL
	L50ScgkYYwMKgfw=; b=oY18hx21DUqngFChFUH7I/ChYcM+Ewmy17djbwpw6wca
	fEkoXVZNOYuGOseH3QjZEESPG+YyfwXilqmOOnHxIRZrt5IBpaS3oqxUUaXRiEK7
	RwlYN/RieE/AKTiLk+Hhn4W8VYArCXqGlgfEPEi7sM8uJZo8PL23TbKvpZu/jrRO
	rzbBe2V0TqhZQHc4CgZLXJ0OWApsNpceR71oukbj7iOXI7NT/gPbUfIAk6EAeBNM
	XA/K3Dpo1wQkYvPm22W9D/qEjKrlHC6sck1XtH8Hwv/cn4wrRFJVWsXQWuLVMjrS
	EfJYH7qkdOVO76CNjqnefBYg8qmOowQ+vBlGM67S0g==
X-ME-Sender: <xms:U-hrZktGWzpZuERaq6qSVyRPrikjYCEIYcPZhT9ZADB8nWhE3XSM_w>
    <xme:U-hrZhdsHvmp-E4ZcAaYcvSuw7lXrqMdaue6NvWvSqmb3Di2KNHkYAXsyay1JReOF
    azdc2QqXpO1SvSicQ>
X-ME-Received: <xmr:U-hrZvwHpfU7KtECes4XZVzee0UBbYqzaVSL9E6VyqjzFTHa7CLsYOjRYMANEbU-C5-tjXGuF4NPAa6uV85tqSGKNmNWetI6FFH70ZWHskDr4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:U-hrZnM6pAW6QD3OxXZ96eCuvD-aN2qsr8-ppuClAUk9-nG471701w>
    <xmx:U-hrZk_5t8uIAJO4v7TAQAGXOKDeGlZpil9qjKiN2Gr2FttEsjzRmQ>
    <xmx:U-hrZvW8DN_kO8eP9CLwNLUowxsoiPJXICNeMuPzjmHnkGQbdNu3xA>
    <xmx:U-hrZtcjqoR_68Pf2PgVURLSZDuAMQ4ndtiveo7PkActpiybMELdnA>
    <xmx:U-hrZjkRrG4bzaSHJlre1Nez-S22frVbBnRM2_3WkU7NXh3Qv6qEQnPq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:50:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 79aebbfe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:50:43 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:50:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 16/20] compat/fsmonitor: fix socket path in networked
 SHA256 repos
Message-ID: <5b8f981ea276f1f9d1f01c21bb1c8d02fa12e397.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="79FZThU8B+O8L6cL"
Content-Disposition: inline
In-Reply-To: <cover.1718347699.git.ps@pks.im>


--79FZThU8B+O8L6cL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The IPC socket used by the fsmonitor on Darwin is usually contained in
the Git repository itself. When the repository is hosted on a networked
filesystem though, we instead create the socket path in the user's home
directory or the socket directory. In that case, we derive the path by
hashing the repository path.

But while we always use SHA1 to hash the repository path, we then end up
using `hash_to_hex()` to append the computed hash to the socket path.
This is wrong because `hash_to_hex()` uses the hash algorithm configured
in `the_repository`, which may not be SHA1. The consequence is that we
may append uninitialized bytes to the path when operating in a SHA256
repository.

Fix this bug by using `hash_to_hex_algop()` with SHA1.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/fsmonitor/fsm-ipc-darwin.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-d=
arwin.c
index 6f3a95410c..52f4f29720 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -17,7 +17,7 @@ const char *fsmonitor_ipc__get_path(struct repository *r)
 	git_SHA_CTX sha1ctx;
 	char *sock_dir =3D NULL;
 	struct strbuf ipc_file =3D STRBUF_INIT;
-	unsigned char hash[GIT_MAX_RAWSZ];
+	unsigned char hash[GIT_SHA1_RAWSZ];
=20
 	if (!r)
 		BUG("No repository passed into fsmonitor_ipc__get_path");
@@ -41,9 +41,10 @@ const char *fsmonitor_ipc__get_path(struct repository *r)
 	/* Create the socket file in either socketDir or $HOME */
 	if (sock_dir && *sock_dir) {
 		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
-					sock_dir, hash_to_hex(hash));
+			    sock_dir, hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));
 	} else {
-		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
+		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s",
+			    hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));
 	}
 	free(sock_dir);
=20
--=20
2.45.2.457.g8d94cfb545.dirty


--79FZThU8B+O8L6cL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr6E8ACgkQVbJhu7ck
PpRyGA/+KalWKPmMtDgAB5A+Aobx/5mwBEdYrW9H6GBqHzSDV1tIFBgveooVkawv
7Cy4HUClgJnLpi9drTWah2aMnz4fLMGyKp2o448pI9i6m3K+RV/T+dIg7c/1A/Uv
RIGp52jk1au3HMPeMog6kdFgQxm1Yq5QMvWrwNQxOuz+iVj9SxQiwshXKBU6ykF+
0LR6dlWkI7Vdh0Bv1tR5qMxDWZTqOxyBpHDpr9DqHQ1CGBHSpGpLFnNNMv15Zi8N
Oo1ueHqTa075g5VeUtfDK0GhiOZHk6DB3TbqkK21oV75y19YYx6X6HR46wUFMGUu
JhMZdM6dmDjQVpYQ6eUjkcxNZOHvyi29H0HyufSidxbnK5TGp668zzRT02GrOAAP
z8NfwdzcWHRbgL54mgDWveY6WOS+KyEJB7MqJGywi/OrmsXkghm5ea0m500xDOce
ptbt4ahkmqmFL9EFKX3FHlufpGyFqt7XW58+NTpwUHcxeWgJ3fiqslUQ7+FA9IPD
mpZCkckf0nwHlyX8HiKEcuqPWJncy7EBstzZsNQgA/uyufd5Qv1xGWz241u/77lW
cyzP/JNbqmwpuiISnMupM86yFwx0EBbff49MhkKkLQYlFgS5O1u/naas342VQc56
/2F+k19X0yQ6A4SkuZWhtAa+KoOeuBqI4kDwGjZr8yfPLci9p5o=
=78cU
-----END PGP SIGNATURE-----

--79FZThU8B+O8L6cL--
