Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0481E6744
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034649; cv=none; b=Uewt2QRlPxr/xOMyChsC75+8NorWOWAcKMsWCxcN6AzoX3mpIdmFu1cNDUQLh77YUhWG8GLszYB9ZS7vwQBt2Kpmr3PYKdPLUVuwXKrrBCaCFqPkiud9+eR9lTGUNf/d4k+RuaOfbTsYrCa985R7ysu0tlMlK3SjYldvhGAbnRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034649; c=relaxed/simple;
	bh=cSjsvq54kHdKX98EhYGQyRpXvjtcUEM+9WFMuWBdZeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aL7f4lvTun96bolFe0Og/cWC5zD+k0fNJGbAhMaCgq19u5mOvADvEvKpDC8lp5kBLxW2KkZjcXH0Ugez16GlsVgptMlYSvnPKZib3ho+yUsTxjE1GumVChFWEpvLr/aEZ+keyg+de2TmeL25wkydwOAMp273Ff3ElyvS6VGcr+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qoCpkYwq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kixGpZcB; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qoCpkYwq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kixGpZcB"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2CFAA11508E7;
	Wed,  7 Aug 2024 08:44:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 07 Aug 2024 08:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723034646; x=1723121046; bh=1NS8aK/DNG
	ieuabCVBfZL4neZzfyFwW3rGOmHUtmYLA=; b=qoCpkYwquUrH7G+FM2Ixff5EQE
	jcbjO3x0h7Lc5ELz1qfuM8srVZUSdfrsP7p5kZUAZIwjFq4XC85t/D1hOyBX+4NM
	WXWSQqI9eSfk44Zso5pSkItQFxgj/oBbb3kOgr+0GXXj3Tgw5YYWemwwlAX8NKM3
	ZklhZnICPXhUol8G8zoP4pxCCa88pSk1VcHJy2rwVn1iPlbC219h82fLA0d2uc3q
	swOx0wJzh7VACl0tZIx5ysdTfwXOdFvy2bA1UZq7PH3f1wFS6XJBjhqSIm71/ADg
	BDEijA6D7N7YeVo4CzDDFpwGYlR7VM5cxzVXTdeGVCe9awRgb4xhCTsQ6D4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723034646; x=1723121046; bh=1NS8aK/DNGieuabCVBfZL4neZzfy
	FwW3rGOmHUtmYLA=; b=kixGpZcBjWJnxG30ki0TD/W99ZJ3jPyNWJFSas9V5u4B
	RxE1wBbQU92prToajUMFWrF76n5yeI/yEOt0Jw9sqP+RCRZJnh33Qeq7F7j3PWJJ
	90v92H9Cq762Zhk5+4eB6uLC5EqKtXeseGUNNwMw76+trAR3TghCb5N9fEJ5FBpO
	hZtYDk1GLAWxYZ9D8D17RnghkYxMMBx/lCIbSINzaoIQdQ2RIgwj9pOrCQ1xHMKS
	6LZ+EuXjqAquLVj8fxKNIHIX1PbdJPG7f7W4IFJTv7ZrNWBYEniHYKQ/NsslDYme
	p2XF3i0m4WsL19dyfgKENQlCeBpThUQYvJPaeCz9hg==
X-ME-Sender: <xms:FmyzZgeIqMw6DXgb2Vn_8BT4F6mE2xnJ-6CX42Nfbob_KkxHs0bdwQ>
    <xme:FmyzZiNRYk50E5H83PydGC-uNvHsBcKpUkARvcqeYwg9iB4ZKXqoa8QM-3h7hE9EH
    wijZuK7ergZt7sVNg>
X-ME-Received: <xmr:FmyzZhhWZtJfHv3pQl6Z1D_OlHmGiJdKMMXZGXO6tt9KQBvlk64jbIyEUu-kE88hnJwYmp39xphpJQorUqvfqESl_YI9WlOEKRoOqcfEXLn_QM1k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:FmyzZl-k7_ml6aWKjh4SWxgzcOC8vNCW1jpaBJ8uisCONVLDnsOvAw>
    <xmx:FmyzZssajt4INONUHIqNLuT1vaEyHCKwdSjQoj0DWbPxSdWvRPfdsw>
    <xmx:FmyzZsFmnqygkunHNwuZZaof7cyha999A1-2qzpUmsjEfGgH6g3epw>
    <xmx:FmyzZrO3TFoY8x35tHDGiGEqz5pkHQWIULhLdDdUYqUmTuzjAsCIQg>
    <xmx:FmyzZoKDykB0i3KBhR-SZfq87XNcRcJi3ibMqW0Jbkzizxxa5GCEbbWP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 08:44:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2cd8c1c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 12:44:00 +0000 (UTC)
Date: Wed, 7 Aug 2024 14:44:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>
Subject: [PATCH 4/6] submodule: fix leaking fetch tasks
Message-ID: <8f8371c18a5f0a0f9b1412605199a21db334e90d.1723032100.git.ps@pks.im>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723032100.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7/fMbom6PWgj41Fm"
Content-Disposition: inline
In-Reply-To: <cover.1723032100.git.ps@pks.im>


--7/fMbom6PWgj41Fm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When done with a fetch task used for parallel fetches of submodules, we
need to both call `fetch_task_release()` to release the task's contents
and `free()` to release the task itself. Most sites do this already, but
some only call `fetch_task_release()` and thus leak memory.

While we could trivially fix this by adding the two missing calls to
free(3P), the result would be that we always call both functions. Let's
thus refactor the code such that `fetch_task_release()` also frees the
structure itself. Rename it to `fetch_task_free()` accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 submodule.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index ab99a30253..f027a6455e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1496,7 +1496,7 @@ static const struct submodule *get_non_gitmodules_sub=
module(const char *path)
 	return (const struct submodule *) ret;
 }
=20
-static void fetch_task_release(struct fetch_task *p)
+static void fetch_task_free(struct fetch_task *p)
 {
 	if (p->free_sub)
 		free((void*)p->sub);
@@ -1508,6 +1508,7 @@ static void fetch_task_release(struct fetch_task *p)
 	FREE_AND_NULL(p->repo);
=20
 	strvec_clear(&p->git_args);
+	free(p);
 }
=20
 static struct repository *get_submodule_repo_for(struct repository *r,
@@ -1576,8 +1577,7 @@ static struct fetch_task *fetch_task_create(struct su=
bmodule_parallel_fetch *spf
 	return task;
=20
  cleanup:
-	fetch_task_release(task);
-	free(task);
+	fetch_task_free(task);
 	return NULL;
 }
=20
@@ -1607,8 +1607,7 @@ get_fetch_task_from_index(struct submodule_parallel_f=
etch *spf,
 		} else {
 			struct strbuf empty_submodule_path =3D STRBUF_INIT;
=20
-			fetch_task_release(task);
-			free(task);
+			fetch_task_free(task);
=20
 			/*
 			 * An empty directory is normal,
@@ -1654,8 +1653,7 @@ get_fetch_task_from_changed(struct submodule_parallel=
_fetch *spf,
 				    cs_data->path,
 				    repo_find_unique_abbrev(the_repository, cs_data->super_oid, DEFAUL=
T_ABBREV));
=20
-			fetch_task_release(task);
-			free(task);
+			fetch_task_free(task);
 			continue;
 		}
=20
@@ -1763,7 +1761,7 @@ static int fetch_start_failure(struct strbuf *err UNU=
SED,
=20
 	spf->result =3D 1;
=20
-	fetch_task_release(task);
+	fetch_task_free(task);
 	return 0;
 }
=20
@@ -1828,8 +1826,7 @@ static int fetch_finish(int retvalue, struct strbuf *=
err UNUSED,
 	}
=20
 out:
-	fetch_task_release(task);
-
+	fetch_task_free(task);
 	return 0;
 }
=20
--=20
2.46.0.dirty


--7/fMbom6PWgj41Fm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazbBIACgkQVbJhu7ck
PpT5hA//dhJGmbJoIEA4SnG5PBLTyLtgx7tI6JE0vcNcCLHzD564w9TlxDX6e66i
FJ7hjffj1LX90MuSnZsaAHimdotojiW3LyEV6be2nB1frfTP79J6TkCNZux7BOat
Fe9rMFqUoo2wV8E8BLttVcL/fueSHWPCWCt6mh/nUD6aAwvQBgYGSe8imt2YRKpN
ehAgzol2X7aYmlMQLZSyh4JvOEIDs6sUKQ6U9kScgFur8mPdq9ENsgwb5BGS6eNq
OQEu4MrmLJGr2WctcL3BsdC3XU5BYaN8wr2tLJgPzbw9zt8IjBY1beZYP1KR6LmM
tN2Sj1Hml2M8HEr31IEahMDvAoai9emlUmjFXzSb0NV1F2oPC+LqFRSMQdWQzn+6
o9wKNRd2B8OcjpML2RaLueNkgUOIGL9UJ7pWCJei5jLfnAXCWzA1B6kybMULE/js
E/ouoHHufPptl3KP8UxDyj8+efgGO9vEdSyTgpG/1HeGczKfdH+ANgqbAjj+0hMh
34/DmAz8zN/wz2mMOudvkz3zO70mvFCod8cDluj2miFxJ7GZeQI0J+CBqxUGWOZY
n1+bRpcRoakCCYwNSsPw41BEUTsyw0J047uL/O+DdD7aqNc0egdD1aSPf1UK+dmD
WJF4xWvQDhTSyKykcm7oMvDDEoFaXKjgo3vf58DaM76Oo/p/ngI=
=HDfv
-----END PGP SIGNATURE-----

--7/fMbom6PWgj41Fm--
