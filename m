Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD7117C20E
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107119; cv=none; b=RkgFKGMz6uhjsDfExdvA1DyymhbTLxA5BbBLKs1sZzewxXEofAjrYchni1NP2C4oqOw1jcT5l+NIeHQDfP0bVmLri6/Rbgcc831ksJpAejvMjl4D0QQExd26RALQbi5V5sVZC/DdtPEUgVM/7gIr85FnDRPhmcB3EvwdN2YHvTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107119; c=relaxed/simple;
	bh=lP9MDDQZ0IJNf+/pNaoaMIIbN2irhWPTWzS+wlSQAgA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPO0JOiBhaaRedpC6KnFDf7qLfsPyQER4K+U7Yrshe2SLSwNOOcwvuRZRfZmpBYEukWXf4H21DBksa7ABGIaaZp9bgjrfeDbPnturqpuo6H5G+qjc4VJBxJpMwiGauVm3Vct3MbuuF2dl3wbqQtNdJLNqbTEJstvzQ9gcZe12sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cs/talYR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AfLMd1Gk; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cs/talYR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AfLMd1Gk"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 0F6781C000EC
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 11 Jun 2024 07:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718107116; x=1718193516; bh=4bJFESBao8
	RCw4cLV52nC63rStX2erUyAqLGDdnmiD4=; b=Cs/talYRBZuk/4g4Mo2bXZGGfF
	H8sJi7Z1LWBu7XqVOd+oEwMmwskA2OBEP0+13fuUc7QOJRBZltPGOGu2E/TXW/f0
	T995tjHH4CbxDntiZ9HZTXU6rBzlBsgnwlYTxDD+w/d8zbvxZG1Y+URgoA/U+2jI
	SnVDVuhMcw2fDO2XQVrqmvQAVeQmo+qNVZr034TeHSlj9hQJNJ65/bJTh+ldXdpP
	PfP1qsmUurUu74t1R6Y5TpVT/UmLY8LzaZLBQ/LJ1wcL5A7zxHeblThwqnS0PP/A
	uRDjV1y+x6q2d2k66FPLf99CYIBbxgEqoE6KiUk8Wf11LIW5NL0/4E6gn9pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718107116; x=1718193516; bh=4bJFESBao8RCw4cLV52nC63rStX2
	erUyAqLGDdnmiD4=; b=AfLMd1GkuP0KIEBWuKn8tQvZf5fpGFGRW5JhCISmATjm
	GA6ErIt+FP4ejy5moshILXrOI+H8oj51mal4RnujepgUO4Tyf8JBoYnbRzgW2e9K
	v/lhURWdkCKbXS/YbDshZ+kHXG1k3vZ9jlrwiBILkwC3iCA9oLirAO030pCVNr93
	4Ia7bGBOm7vJwSmDsBBsngb685L/NpeDmX5yU+uWUdVrIi/Chs+3wD1FAAjvK6NH
	7upRjia6sHLorNTgfu5nZxxPUaq36wp0d8YCypfRe0xq7cCCEKrS6TfoOx4YiW7b
	YaSsFaaxHoXrKzQVXBeFRUHqattVz+jpbpI/54qJyg==
X-ME-Sender: <xms:7DtoZiB0f1LruMnn9eAGVTFZlHp59LVMa4aDiihMY-laVJ56H5E3qQ>
    <xme:7DtoZshND7g340bzlQRIVPkZ_cXDyClhVtNy27w9vaUEAYEstSNs-Ebk8nFCdAeD1
    XZn619j80hggzi3_g>
X-ME-Received: <xmr:7DtoZlkmJjpA186MmUALly7Fp8Ec8ZO-tKDic03ESQv6HDGYt-yqzx3qF0x2QxJKb412Xhle5-vNIQylLDoqwsd4Kxi_J2A59deSBxi7vjkEB1z7gQCG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:7DtoZgy2odXSe9l392AKPF5ysx-BNgFQ0QX4AP_hbtZH74_c564_mg>
    <xmx:7DtoZnQPvbYU_sqv7oITghd-UzdzZyGsqXITftHWyvITvIYuGU_Miw>
    <xmx:7DtoZrZoOAJ4AaPyc86_X2R5cpODhd0ehpj08R9qKkQZUVMLkqupBA>
    <xmx:7DtoZgSrfW7PkEJun5PsTqyDYIVhfcbt8h01MVTBWLjfUWfQTGoloQ>
    <xmx:7DtoZuL2_NjoViidL5MEzw-lR7VfEJeuxGXH_T4WIoHGeqhuWLEsKqmp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 56602aeb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 11 Jun 2024 11:58:26 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:58:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 13/21] oidset: pass hash algorithm when parsing file
Message-ID: <95d9b5fa3e184d10d55971167c55aef36ce31f8f.1718106285.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iiBCAqYCQn+AnZmm"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--iiBCAqYCQn+AnZmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `oidset_parse_file_carefully()` function implicitly depends on
`the_repository` when parsing object IDs. Fix this by having callers
pass in the hash algorithm to use.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c | 1 +
 fsck.c          | 3 ++-
 oidset.c        | 8 +++++---
 oidset.h        | 4 +++-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index de89fff3f8..18f1a3cea0 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -852,6 +852,7 @@ static void build_ignorelist(struct blame_scoreboard *s=
b,
 			oidset_clear(&sb->ignore_list);
 		else
 			oidset_parse_file_carefully(&sb->ignore_list, i->string,
+						    the_repository->hash_algo,
 						    peel_to_commit_oid, sb);
 	}
 	for_each_string_list_item(i, ignore_rev_list) {
diff --git a/fsck.c b/fsck.c
index 432996cbb6..304f4a17ec 100644
--- a/fsck.c
+++ b/fsck.c
@@ -205,7 +205,8 @@ void fsck_set_msg_types(struct fsck_options *options, c=
onst char *values)
 		if (!strcmp(buf, "skiplist")) {
 			if (equal =3D=3D len)
 				die("skiplist requires a path");
-			oidset_parse_file(&options->skiplist, buf + equal + 1);
+			oidset_parse_file(&options->skiplist, buf + equal + 1,
+					  the_repository->hash_algo);
 			buf +=3D len + 1;
 			continue;
 		}
diff --git a/oidset.c b/oidset.c
index 91d1385910..8d36aef8dc 100644
--- a/oidset.c
+++ b/oidset.c
@@ -48,12 +48,14 @@ void oidset_clear(struct oidset *set)
 	oidset_init(set, 0);
 }
=20
-void oidset_parse_file(struct oidset *set, const char *path)
+void oidset_parse_file(struct oidset *set, const char *path,
+		       const struct git_hash_algo *algop)
 {
-	oidset_parse_file_carefully(set, path, NULL, NULL);
+	oidset_parse_file_carefully(set, path, algop, NULL, NULL);
 }
=20
 void oidset_parse_file_carefully(struct oidset *set, const char *path,
+				 const struct git_hash_algo *algop,
 				 oidset_parse_tweak_fn fn, void *cbdata)
 {
 	FILE *fp;
@@ -79,7 +81,7 @@ void oidset_parse_file_carefully(struct oidset *set, cons=
t char *path,
 		if (!sb.len)
 			continue;
=20
-		if (parse_oid_hex(sb.buf, &oid, &p) || *p !=3D '\0')
+		if (parse_oid_hex_algop(sb.buf, &oid, &p, algop) || *p !=3D '\0')
 			die("invalid object name: %s", sb.buf);
 		if (fn && fn(&oid, cbdata))
 			continue;
diff --git a/oidset.h b/oidset.h
index 262f4256d6..0106b6f278 100644
--- a/oidset.h
+++ b/oidset.h
@@ -80,7 +80,8 @@ void oidset_clear(struct oidset *set);
  * are allowed.  Leading whitespace and empty or white-space only lines are
  * ignored.
  */
-void oidset_parse_file(struct oidset *set, const char *path);
+void oidset_parse_file(struct oidset *set, const char *path,
+		       const struct git_hash_algo *algop);
=20
 /*
  * Similar to the above, but with a callback which can (1) return non-zero=
 to
@@ -89,6 +90,7 @@ void oidset_parse_file(struct oidset *set, const char *pa=
th);
  */
 typedef int (*oidset_parse_tweak_fn)(struct object_id *, void *);
 void oidset_parse_file_carefully(struct oidset *set, const char *path,
+				 const struct git_hash_algo *algop,
 				 oidset_parse_tweak_fn fn, void *cbdata);
=20
 struct oidset_iter {
--=20
2.45.2.436.gcd77e87115.dirty


--iiBCAqYCQn+AnZmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoO+gACgkQVbJhu7ck
PpQC5RAAmB3GFdF3J/hBN6iQFAAt04V3pwUE57vrIp+lTc7iM7ZBTOiMRluEvmCw
cTgszpGrAi1kU4GqnrtdArUTvCCYEITqLY/oALWi6PWQ/aOdEQBDSCD02kbYr0f2
RIGL0jsoLKwURz8MoYvD0e3wgMNmlOnCnsMkbWbZhsl9yjvebcV7iipaSmxeDeTQ
fat6evpCLPFS7HIDJb7NVoghEimRnal9vc+6f1T6mdEdp3Q90NvoxCnzisO0tiZx
Nl4WL+hQNI6e2nDD66otsCxgJmccGFypp4V4B3/Rr6GuJSjQnoUI2PJ5Eqii2+uk
ytAG6YQP3xF8KFyGz654aDcgQp6TznDhEnkY5thCMw1Ef/6tW9UMNYTCPdHafhyH
+3xOVSp5/7Bdy+SO70fGVc5gFbvWaPcc4WLBr23FW4QJXm/BD19tc3fVWSndsxU3
mPrzKYNqWWHThB7ekl2Kx+yMp9O2VdzD3UJ8Dx3ZqKq1zsYx8Po3DMEzdMPcuWhF
kWC4JqNetHNZQMgXqIwOxArqItRisa2P+d1i6t14MxPDuHb/smlbEgR+nBoMzR1J
Q759tDRDJIvWH8YuZCRNKis/B00NaBpCiQEyBWPSBzVXr9VWSl7L5zDoqIpn0cTT
oyYB8f1Dz8hwSlpx04OGk66Cpwgvj07pxnvBkLxZGJB4PH1F5W8=
=gb3P
-----END PGP SIGNATURE-----

--iiBCAqYCQn+AnZmm--
