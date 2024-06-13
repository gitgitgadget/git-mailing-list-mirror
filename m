Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CB8136E12
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259270; cv=none; b=Q1UX/KOBr8JJrHFJyw+W1fQJJ6u1QhUcqVrePI14RHSGmTFH6KyZ9jlejerRZlyxdsNjPh1rAYmasp6x6ztp7jf5gQgJ6LkSrL5SoWynZjUpO8Tew1Z7tinGATB0Tliyg90ZATTgKURQfXepVWvbE9f+mDm9DM0Hx9eRCaF7Sbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259270; c=relaxed/simple;
	bh=UWZGQG03ijMY64PmQWQ9PpCZithr2phBMxbx0XyjSGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKgZZ7l6FywsLtlfis4unCYGeqtjsMjuRmNGs7aBPZPaVs8TS9fCwQqrDdcRrEmBcxS0hcQLshQrnhYDv7m4Kfuj4AMqQxr21RwB7CupIbyHHrHeJ5H5eB7xGGRaSkLcaipGITapjQ57+FIhQfckH24ycyqtrCJgm6dD6n85nSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fwWuSW9d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EeoJqA0D; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fwWuSW9d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EeoJqA0D"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 57AA31C000A6;
	Thu, 13 Jun 2024 02:14:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 13 Jun 2024 02:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259267; x=1718345667; bh=E9XrcwPofp
	jg5Ktm54/C2oG/RMJx4N1RX7278HyQosQ=; b=fwWuSW9dNFS5aymEQNy2hC6i9d
	Gq/lXuB/wBpwwqscRydH8UsGEFJKudrYMvEprN1VFN0r2U/wM13rx/U7G6PNg5nm
	Vu18XJmQ/Uaecz0RXKn5IfltNPd97RjvzvgGhY805f8Xh1x6I4kiqjMCJMHE8g2y
	CW8nf6sZ2piVrkAyygbDBi1p5N+ZYsQCQsynpxF3HoHT/y29SDvCLgpRvAlm+fCp
	fjrdyNKGDZDeF0QwJj+JfNLbfcvywuSE6DZQRnXQQ7YXVvqrVgTaxaVEMOgjAWnZ
	/VU2Wkh3XHZ8WBVSHcokhiRxwYvNUsgz56yts1Eo0bBM/jPZQz/a7DYLZhHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259267; x=1718345667; bh=E9XrcwPofpjg5Ktm54/C2oG/RMJx
	4N1RX7278HyQosQ=; b=EeoJqA0D5bc8s5Cn4PBDsO52GSOAQcdC6Un46rSxUxB8
	GBumSjQSX+tmMzJ4MmuwX908FKXdZLao/0mtC55F6Jz/pqtAPKzlJeX1oaqMpv+U
	OH8ag4lOKDM9me+Ptxw70edpRPuVVyoTbPEcY7lQnddc2ksOqdSbyoulXu2tWhAw
	s/Qv8lvvGNZJJoputpQZVdnC6PJJRWfX7Zlti1N2pkRT1ikXo2iW1lM2lF47XGNV
	eDriM2j3Akw/Cat9qpJ+WHMa47YyOVRAlsZa423Cc3hfEPvLc9OLjOJtr9dwoO+u
	74loTxuX0qfiM4ZjkfwGDVqeYgWqB4J2u413HnDr+A==
X-ME-Sender: <xms:Q45qZqcY8c2YAr4AeBtkY502bEl5qu7M4-cmqu4tBYosiCAyHyXKOA>
    <xme:Q45qZkOltx8c_9ciYgcPo0rGnqnbvjThV7GEAc1WcLU1agpwY1nYT3HkrVWoP5RqU
    CNZmRf5YPvom9DheQ>
X-ME-Received: <xmr:Q45qZrjnz-oKHM76Za0L7z4UgeOOK0qkVXW3n2hKht8xrmhGKjAKCA-iX92Co1Uhou6wnC5Om5oTJAESB4BF1CKYsx_PyeOeCa7VavjOkvczrp-Gu7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Q45qZn9lODfeU7cHLVlb4lSyWsiycry2RadLVlFb7FR_dbs17mcPDg>
    <xmx:Q45qZmsVix0y8Nkas5Af8Ve0ulLNC5SI-B3MQ_eveSRDMMjuBd-aSA>
    <xmx:Q45qZuHcAJMI8r2H0DgexEsVp13Wh_J_scU_xC6VUPmIlGTPMGbY4Q>
    <xmx:Q45qZlPD2Y1GlHyornD-NDJGFczy53Jb7q3NgTWETGq3TqymAdMFvg>
    <xmx:Q45qZqKdeQ1od9S5IHOnzkPYQm8i5lccHMyktI_yo_Odq_ZWXriYkF4w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:14:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4ce9b09d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:14:14 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:14:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 13/20] oidset: pass hash algorithm when parsing file
Message-ID: <0b4436c32baf17525cc203bd0b816fd04f586c17.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JmOH+LFg1MBQKfy3"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--JmOH+LFg1MBQKfy3
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
2.45.2.457.g8d94cfb545.dirty


--JmOH+LFg1MBQKfy3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjj8ACgkQVbJhu7ck
PpSWzQ/+J9fZbDJ1Dlu2TLmUNGH55Qorua7j6ETLigDiUVfNKTgj8jCbQUO6IQlq
/5dPraP8HjStjT6KrPAJfVioT6EoHXaQ/ClV3XHA93u97M14xf4lcw+iwDUxZnD4
WigHhjuAC47//kgI6QzakWq2/XUQxCl4Zlh7uP/9l//CVmOvaMMrNa8s/IN+jMW8
FWbeQ8nhqDFqcpMvk9BQnlMDpF7FkXjpWLTNfBTAFUH5YIV10C7ojxxKPuvSKFb6
tm/cIilbVQzt/VY+N2TWXGc/kOKd/jdUI0iVgbOdcCJt5mSjHHA+BCOMrEGwu5Q6
Am8CKojZtP8/ez7xXyhZdKTOIVgxGE9nnd7Qb+CcrXw1uHcjtp+THUe0ZvjbvCh5
9VQmeWa3U9K/5SbyOe9MVgdR5/YbPoCOYVhYF+Znz5F+ZCInJ+TbHK8J7wJnXxRu
6wwb4fbzr4X2B6ng/CaYzMoLmMCZsxRPLpfVw5RXLFDoRoTA0ocuOsRHKEoWmb1k
NZvhJQGodWCOHEzX/S+FpzNMwPSWfw/AEBtZPqcFq4ZIFMey7p5WVCpg5V9zx86J
QJSZoE5A6yVSd1Z+iRayKoEKaIzku7VSt2Zyrj4RGffMAzhmAiM+ddTHkw0aTmMg
IIliSrb8O1/jrdIXp6sdPfqiXep7E7oJg7ISYIYqYwRU+MNyXZQ=
=Cz91
-----END PGP SIGNATURE-----

--JmOH+LFg1MBQKfy3--
