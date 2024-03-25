Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5906C12C7E0
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360992; cv=none; b=ohI2JWgl6DVtrxUaMM2RMYJxPIwlZEnw4gzE12s96MapeJBklYSsHFCP7337fXSwLmWW1fSckPuWECp4AhYCVauboCam6lHViVXosFQTs6BMaiqZOoixCeuGHtBY/cSq1NoyU8iXEylbpUE5F1lDD+4WF+GHtnP3qzIWYDuZx3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360992; c=relaxed/simple;
	bh=Fg3t/vhWZAcdw/zuFXTXNuFa7/6p7zxNjsFTlej+6Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVip7214fCJxK+Q++ZgbS7mTT0ycYglKaqc7urI7OOkmhwT6k5Tm0tll9NZShPRPZuuJRKppsG4CgB8Fasvr17cUDbzbhbDb0cktd3sQTfvN1Rl6hfHjC8hnWTpfAbl2Vxebb5iEZ5tf0hsXra+AJx1UMdDT9/eU0fp19oiw000=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WuaUBNnP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cXkfrO14; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WuaUBNnP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cXkfrO14"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6A1F811400B2;
	Mon, 25 Mar 2024 06:03:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 25 Mar 2024 06:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711360990; x=1711447390; bh=hQRJt4A8Jg
	8iCyo62bjEcvEhyFpux5k/kE5uZ3/od7o=; b=WuaUBNnPC+mGaQ9PIht4DWAeWF
	/uggaU6K7JFYUe2Z+E6g+PhRd6d7Rb5egRn1DkdgylUZJZqrPQpDGDbm07TiaYHZ
	BZqlMHm92NaLDwDGQUjONziKVwV4Hn9rRdSNI7HK9pzKxX4pXkv0hlIulUksJNqM
	wRaOFy1al0BLSnC2up7tIrZgBTI9k8Kg3FCSJU8AjnQBceJwurSmzgS0OdsnhtuS
	r4d7IhXrab2/COKOcZ5BEJkxmJAY5tW54ClpQz0xrxX3bg+9TXI2GTvnGDB4LJIl
	MH9Q7MCEEgHk28E6w8kAD9lmGT0/WYDFCAOujUyFoNMqC9Ym0ydQgqkwTe5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711360990; x=1711447390; bh=hQRJt4A8Jg8iCyo62bjEcvEhyFpu
	x5k/kE5uZ3/od7o=; b=cXkfrO14cW+aGwYulofrPlJLwHcEdbNNB4SVq9CA4hSU
	K8ZphVup4jpzyzs0KzBm0UHxmFsGr3dIoVjtHP2rLUcKWry1aomgdTc39zFZZ8os
	eLnOOoWVlGiYTBVGICRaQIK0P6zNphzf7PAQKNlmHoGGouqSczKbPTwbfpteK4+i
	h0832s+XzUb9uWbDJw9Y9r0YbQ4Gul8n5PF5z/YKsfLb05mhwXxigr8cxOGQsl2V
	PidzLsxXUB9cUW/U61Rl2EjNRcGgarNTMpG2nsMKnS1xropM4x8YgGJjuiZzYLUs
	dCCEe+Y4IET11GmXSQ2RJscKbK2C8hAGlZUjAiA/bg==
X-ME-Sender: <xms:3ksBZgsqD-WMozhStZc98Y-z4CyISIZW1YhwHvkPoOqOdHd2OLlGrQ>
    <xme:3ksBZtfkVLtJyfTaa071MurBNX2eTTgG9gbwAKGEHK6IJkhtUkd2s5qEkJ97DmDEc
    0o4ib0QeIkZGBT3dA>
X-ME-Received: <xmr:3ksBZrzxUmhOvdlzsjhKvEbjtpTY1BMOEiNsEfbstrjYrCgfIvHpUfu5BEhZrEwPen9ZZ13Hte1LXgbK69xw17S7T007ltpd9toesN8wNK208g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:3ksBZjNBsxaYOg6nVxw4iOouOkoHFyegQRWkJuU84fbE-ErBwpb1jg>
    <xmx:3ksBZg9ZLkhjeeyBDTs0lGAkAHx_FQAtSENSByuhWWa17A9f17W76A>
    <xmx:3ksBZrUBevxxYRE90hLdbKNEgrOhvv4WEh4cXIMvEr8cWDRjiateOQ>
    <xmx:3ksBZpfp9BhFoY_POJqzbAZ4T3LwNaUe3fqC9PDFS1L2XYHBK9mOWg>
    <xmx:3ksBZkZ0azWYZQ-QQU5yl8hivEAgraDXDAP0qijc5sVTjr4qeT1Jfg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:03:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8886eb9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:02:59 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:03:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 08/15] refs: remove `PACK_REFS_ALL` flag
Message-ID: <cf966fc5846e87f191118c9b115774b36e8e9e9a.1711360631.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
 <cover.1711360631.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sAEDAA6X8C7Oq0MU"
Content-Disposition: inline
In-Reply-To: <cover.1711360631.git.ps@pks.im>


--sAEDAA6X8C7Oq0MU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The intent of the `PACK_REFS_ALL` flag is to ask the backend to compact
all refs instead of only a subset of them. Thus, this flag gets passed
down to `refs_pack_refs()` via `struct pack_refs_opts::flags`.

But starting with 4fe42f326e (pack-refs: teach pack-refs --include
option, 2023-05-12), the flag's semantics have changed. Instead of being
handled by the respective backends, this flag is now getting handled by
the callers of `refs_pack_refs()` which will add a single glob ("*") to
the list of refs-to-be-packed. Thus, the flag serves no purpose to the
ref backends anymore.

Remove the flag and replace it with a local variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-refs.c | 5 +++--
 refs.h              | 2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index bcf383cac9..97921beef2 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -21,9 +21,10 @@ int cmd_pack_refs(int argc, const char **argv, const cha=
r *prefix)
 						 .flags =3D flags };
 	static struct string_list option_excluded_refs =3D STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
+	int pack_all =3D 0;
=20
 	struct option opts[] =3D {
-		OPT_BIT(0, "all",   &pack_refs_opts.flags, N_("pack everything"), PACK_R=
EFS_ALL),
+		OPT_BOOL(0, "all",   &pack_all, N_("pack everything")),
 		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default=
)"), PACK_REFS_PRUNE),
 		OPT_STRING_LIST(0, "include", pack_refs_opts.includes, N_("pattern"),
 			N_("references to include")),
@@ -38,7 +39,7 @@ int cmd_pack_refs(int argc, const char **argv, const char=
 *prefix)
 	for_each_string_list_item(item, &option_excluded_refs)
 		add_ref_exclusion(pack_refs_opts.exclusions, item->string);
=20
-	if (pack_refs_opts.flags & PACK_REFS_ALL)
+	if (pack_all)
 		string_list_append(pack_refs_opts.includes, "*");
=20
 	if (!pack_refs_opts.includes->nr)
diff --git a/refs.h b/refs.h
index 139ce7113b..8c8994cb29 100644
--- a/refs.h
+++ b/refs.h
@@ -422,10 +422,8 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_f=
mt,
 /*
  * Flags for controlling behaviour of pack_refs()
  * PACK_REFS_PRUNE: Prune loose refs after packing
- * PACK_REFS_ALL:   Pack _all_ refs, not just tags and already packed refs
  */
 #define PACK_REFS_PRUNE 0x0001
-#define PACK_REFS_ALL   0x0002
=20
 struct pack_refs_opts {
 	unsigned int flags;
--=20
2.44.GIT


--sAEDAA6X8C7Oq0MU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBS9oACgkQVbJhu7ck
PpT3KQ/8ClI4rAMn4X/eYxEaKSBWEeSGtEHdIYwQPmOoOTNYLjF/fKKLegkoKfjY
ofuEVhGi3uw3EG9lO8m/p5cUkxNv/yuoEhIYGEJGN9vhyyCqWsAf+ZNMggwST5Qg
bNq8wJWrVW+QOUj6/Rs1x9WcFLHrIK3ke3cWnmEqKtMX2pfERg52ZzctCt0a+fm1
kNeLqSWzK+SZZD/zjM6XbNLUZvjXN5u8/UfukuTYm4TSF6qwSSR3ThaGxYvGxFW0
g6aLEe13m0YpfhVYsje1TwpmI885rtGekMWlN0rq9vTA/+SFsB4uhRBlx+APvEIO
bGHgYPBkZRua4ou/gGskYT6gLQJKr3W0cf58/1wfpDitIE7/BbZZ5YoycKa/1UrS
I0/kePPcF9nKAm6ez5+w9lh0znmw8kgoLEiknne07vROjLqTtqKvxcvYJPtiJ+2w
McmRwOP7e5qlR4jGFYSo6GEBko0yJfsPpKGkvI3JFroiFsxsOxsd+m8er66w0a9c
wyTs8/gOU3sSt3KrbM9hLCIS1EsqS5pjxyo4zvetIc36oiLbIPRn71FPiMrUMk4o
fcjzZSaPVlriIDBjmDHwjsrlSknSuSkCzxi38GAnLhJR4Pcq8WDrLqdBMMyO1p3x
7mk9uFetX8WbvIuG0OAhloT8paQX7WeE15kwc5fqBBYqMj9cUcM=
=tPkT
-----END PGP SIGNATURE-----

--sAEDAA6X8C7Oq0MU--
