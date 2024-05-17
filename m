Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406C62D044
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933914; cv=none; b=oalsunKu5JnrJnYe5Upg6e2DCfiLBxAylHj982/3qJTXjlSd2VDrxuUwKHgCuofTM2t8GJRj+ZEk5pAwCKa7NDwG+g6+IR4qRgT9vEHvZqcrHfoNBduqSRXehEocr4Ktszu2qH3sjVh1HfNSmyX1isAFWr5S3jE9UixhfkqvB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933914; c=relaxed/simple;
	bh=PnegIze7+EVfUYQRnqi1Gv7y3Pd+Hmr8mtQgtADAm9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxBAUsmey0z8zKT8JKC58WKL6YOaFy9Azb/0Ne6bM3uOP944bepC5tzewTSd8Az3dHUW1eUl6Ol7cyV7mMseKRCtQ76C+qdLczkZy9ZWUGXmyFrMOHf1SlKe1dRv1hQ24C4mwsoXg/ep42TuWTdJhVMH7PcEH6+DPf3wCATvBvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DlQmIqUT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bg6YRaOL; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DlQmIqUT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bg6YRaOL"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 5CA971C00092;
	Fri, 17 May 2024 04:18:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 17 May 2024 04:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715933912; x=1716020312; bh=Af34vpjTvR
	2fhCrGeicJzUbgANvzPftkFk2PMQEntdQ=; b=DlQmIqUTHUU2w6XBR93XD6kJak
	yR3hu6VsFXdbMYlKBeaxHuNvc6npBaglpL3ToEM/YbczJXnLnI4cbm7kioHESjdc
	5bwGfu1zDmGgZni8uGWCilPdFd4H1e+OIkp40fdOXw7wrm1cbjsaG2wY0G3nGLca
	yOadp66AbE1v6hdURr29UAmE7KeEtUf0P3u+hme1znrzyZNZiAP3wn7/reEXNbdT
	3DoN4KwYW3gc1j+Drwo26EtcyGDdt+iv0I4vUYxhPdZfde+7IO1NwfvF4Vbr14ef
	slXvdzk1SBoq3JmHZy+76WuvJ/3ybfAU6c27nmK5wMD1n5PP47tyQ1F08/pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715933912; x=1716020312; bh=Af34vpjTvR2fhCrGeicJzUbgANvz
	PftkFk2PMQEntdQ=; b=Bg6YRaOLQOrbje7X/vOGZJYuYszpBLB25DY7SWLkHFOO
	K3Dw3IUhc43bs1hwuMCF7gAmVmJ2we7pm4fg8OZfk3X4jeG46Ww1FYo3IU4KLXmK
	L3/V9X4irFnCCPUIU02v6wZLfzJZTEFDWpKVjiUFSBJRcGGD2EK1Vi2rexo8LWFJ
	eOarh1Zpdpjmvyw/Lq8yv2oBc+NOg9A2kPvP/srEkTPt47usbRC0v3QYTXmT4KgP
	1Q9sJeAVgEP4Z2SnAwSm/Nh1T1skV/udPIT2hUvo8pKCQiq/1GDzw+xBLL+gH89h
	m/bR+JBK6366TJJ2gRNc2MU5XlpKE+yltQSwOrHvsA==
X-ME-Sender: <xms:1xJHZonNdPWHTnuirTy4eee7I7LWVKrNDqqPKB7IrbgH0mMYvzipdQ>
    <xme:1xJHZn21pgNdyJEKjjb8EaGvevT_OPQqTarxcuW81vl3_fhq5z5NTC3ZmHREKMdU3
    1s2gnNKBvmZTPYJNA>
X-ME-Received: <xmr:1xJHZmrspQFORktr2qLElNDaGLB15Mf9KgHJpZ9vRdM5Ax4-oGuH7j3dTXxXDK6VnNHeOiwrr0l_ppb-fqNLKh7XwflfTyTkcBKxRZGUcm8wsdAfvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:1xJHZklRqOhtJ6WO9Oxt0ZVsdbXR1RFRHtZCI5SKXLhUvuJfvalGJA>
    <xmx:1xJHZm32QcI_jXIF8aXF2ucJI5kDd3YLebnGOUa5mx8cRXGOHngogg>
    <xmx:1xJHZrt23ixmyOPni_gFHpzfE7GIwtfUxhn_8nJUPEigjSRU8GVIYg>
    <xmx:1xJHZiUhZgqCKC__p3v9De9yHpbEEqczuXzp23_mRlfKHLqluEsp_A>
    <xmx:1xJHZrzYGigD7ot2mt1LnFayOkBgrWhnmCLxtUJ1hWvqd-GPTkzsFPL2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:18:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c10b93cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:18:04 +0000 (UTC)
Date: Fri, 17 May 2024 10:18:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/16] refs: track ref stores via strmap
Message-ID: <9ca54a12e892a188ba54922c8cbb0e8ceffab0f4.1715929858.git.ps@pks.im>
References: <cover.1715929858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VvcyiDtdpRrlfIbo"
Content-Disposition: inline
In-Reply-To: <cover.1715929858.git.ps@pks.im>


--VvcyiDtdpRrlfIbo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The refs code has two global maps that track the submodule and worktree
ref stores. Even though both of these maps track values by strings, we
still use a `struct hashmap` instead of a `struct strmap`. This has the
benefit of saving us an allocation because we can combine key and value
in a single struct. But it does introduce significant complexity that is
completely unneeded.

Refactor the code to use `struct strmap`s instead to reduce complexity.
It's unlikely that this will have any real-world impact on performance
given that most repositories likely won't have all that many ref stores.
Furthermore, this refactoring allows us to de-globalize those maps and
move them into `struct repository` in a subsequent commit more easily.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 71 ++++++++++++----------------------------------------------
 1 file changed, 14 insertions(+), 57 deletions(-)

diff --git a/refs.c b/refs.c
index 0f4d327c47..01e8453930 100644
--- a/refs.c
+++ b/refs.c
@@ -6,7 +6,7 @@
 #include "advice.h"
 #include "config.h"
 #include "environment.h"
-#include "hashmap.h"
+#include "strmap.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
@@ -1960,66 +1960,27 @@ int resolve_gitlink_ref(const char *submodule, cons=
t char *refname,
 	return 0;
 }
=20
-struct ref_store_hash_entry
-{
-	struct hashmap_entry ent;
-
-	struct ref_store *refs;
-
-	/* NUL-terminated identifier of the ref store: */
-	char name[FLEX_ARRAY];
-};
+/* A strmap of ref_stores, stored by submodule name: */
+static struct strmap submodule_ref_stores;
=20
-static int ref_store_hash_cmp(const void *cmp_data UNUSED,
-			      const struct hashmap_entry *eptr,
-			      const struct hashmap_entry *entry_or_key,
-			      const void *keydata)
-{
-	const struct ref_store_hash_entry *e1, *e2;
-	const char *name;
-
-	e1 =3D container_of(eptr, const struct ref_store_hash_entry, ent);
-	e2 =3D container_of(entry_or_key, const struct ref_store_hash_entry, ent);
-	name =3D keydata ? keydata : e2->name;
-
-	return strcmp(e1->name, name);
-}
-
-static struct ref_store_hash_entry *alloc_ref_store_hash_entry(
-		const char *name, struct ref_store *refs)
-{
-	struct ref_store_hash_entry *entry;
-
-	FLEX_ALLOC_STR(entry, name, name);
-	hashmap_entry_init(&entry->ent, strhash(name));
-	entry->refs =3D refs;
-	return entry;
-}
-
-/* A hashmap of ref_stores, stored by submodule name: */
-static struct hashmap submodule_ref_stores;
-
-/* A hashmap of ref_stores, stored by worktree id: */
-static struct hashmap worktree_ref_stores;
+/* A strmap of ref_stores, stored by worktree id: */
+static struct strmap worktree_ref_stores;
=20
 /*
  * Look up a ref store by name. If that ref_store hasn't been
  * registered yet, return NULL.
  */
-static struct ref_store *lookup_ref_store_map(struct hashmap *map,
+static struct ref_store *lookup_ref_store_map(struct strmap *map,
 					      const char *name)
 {
-	struct ref_store_hash_entry *entry;
-	unsigned int hash;
+	struct strmap_entry *entry;
=20
-	if (!map->tablesize)
+	if (!map->map.tablesize)
 		/* It's initialized on demand in register_ref_store(). */
 		return NULL;
=20
-	hash =3D strhash(name);
-	entry =3D hashmap_get_entry_from_hash(map, hash, name,
-					struct ref_store_hash_entry, ent);
-	return entry ? entry->refs : NULL;
+	entry =3D strmap_get_entry(map, name);
+	return entry ? entry->value : NULL;
 }
=20
 /*
@@ -2064,18 +2025,14 @@ struct ref_store *get_main_ref_store(struct reposit=
ory *r)
  * Associate a ref store with a name. It is a fatal error to call this
  * function twice for the same name.
  */
-static void register_ref_store_map(struct hashmap *map,
+static void register_ref_store_map(struct strmap *map,
 				   const char *type,
 				   struct ref_store *refs,
 				   const char *name)
 {
-	struct ref_store_hash_entry *entry;
-
-	if (!map->tablesize)
-		hashmap_init(map, ref_store_hash_cmp, NULL, 0);
-
-	entry =3D alloc_ref_store_hash_entry(name, refs);
-	if (hashmap_put(map, &entry->ent))
+	if (!map->map.tablesize)
+		strmap_init(map);
+	if (strmap_put(map, name, refs))
 		BUG("%s ref_store '%s' initialized twice", type, name);
 }
=20
--=20
2.45.1.190.g19fe900cfc.dirty


--VvcyiDtdpRrlfIbo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHEtMACgkQVbJhu7ck
PpQOjxAAgGHyCn15yvVeJ2TLXyTLEJhziudVy9NrIbEwjK0mcydlCLupQ0y8AJna
LkpHpMV9PmLwcaDMdjfg3ZfFUJ9puxvhleyQONazSzGjs7EtlSeBfV3DHwmkUfbT
xg2NrjK3ftAK5epn5LZ9GMwUuovYKlXNfdp56+z31Gmehc1bKpBINdyeT69vBrlL
/iPxUQS56h0H47O8Dicgwq16htOtpvoI+BMYC47UiCfsGEmaWW1LMgBw7ENhmBCY
mePBkbLEBb+b+P4FiwB+nGbTbbawMZYwl+U45VYcTFd678CF9kC0xFMj5VGL4qmz
r3rcilxSDfpSMLEHS0sai0qLmmoI4TimzYG2Ky4Yng9Wzz89ijGoj9uVIF3DSGqR
TBn+6x2/1r6ZuRow67RmyBK8i0g90jK06kHvxUpDEKCQkrdwW/EVqs7pIg1PnewU
HPbgTK6Li7hlqCcYF50L6THK9FPPhxrEftm++mM1/ghBOY72p1l0bc26RNkariY7
FPKruoM+l31ZfYEUfmo3Q/Y2YszgGq33s2oOn5TDoJ9d6DrZ9aOgzWR59L0ZGxjC
SXgmWp7NMgUFcezb/Zu+6noLxwu8Wk8N1ov8pNn4HWvRpBenAIvrACUxWyrjMr/A
vSoi/O8kKz87ZI6j/qfKUeukJnpQAcNo5iwrIFNrzlAz82KeuTA=
=Nh1p
-----END PGP SIGNATURE-----

--VvcyiDtdpRrlfIbo--
