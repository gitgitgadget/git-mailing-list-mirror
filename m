Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8010B1487D6
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347848; cv=none; b=OeqlzlcJEfNg1cXrV1Jjb/vOWk60Tjs8wA15K6k6rPL6/Zille2cQqo222Wf0MRBO3qHI2pHHg5wH80ugLktCayMwcy1Wvg81VP7zUDA59dQP7uUesRH5TXWB/i3K4SNMQHtWRuZ3JT9gEKqMirAV8KwzKDJnjNiLW9WMqkn+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347848; c=relaxed/simple;
	bh=TagHxw776KcwEeqoYTem4lG1igRmADeuSCBqQApcwe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhaoPwlCb3emUiQQRRD1jaimLujadCoTET/YeCMVjZUUMsOIOBOZ+UP3AZwfxUCjQLKjxKgYHs++/b949ajCfQQb559eGR6DM5NUD50tFRhSoycYr7Ia9DrbweUJebWLYIE0/uwAY7AM2GNkMl1FHmQaHGO3YUW89oSjrD4P9T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lVma6kin; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RNlRstH2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lVma6kin";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RNlRstH2"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BD44A11400CD;
	Fri, 14 Jun 2024 02:50:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 14 Jun 2024 02:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347845; x=1718434245; bh=E/D84aQtrn
	JjZ2IazwfJ5poXoyX5KdNzfOjrj1SQxds=; b=lVma6kinYhX4itz4CUJlb0vW/1
	XBY9w0zc54zTHxYGxJ4fRwE7AJvbLFdjIyql+YZBLIZDDmtf6/ghKck60XetKl2C
	SJj5Xw+FqvwVIJ4/E8PR0uc3pAdIRO7hfdsHCYEwNRfJb0xhs0u5MhkXFcWF5CYu
	mFXMOaFphhuJM1VhcPghn+E8Fh+sdLf8lkdm6LY5mscedSqpSsiPjVNfX3lB4ST6
	i2Ps4DzJ1HfhdAv3mFeFJ4VqkzKLgGiutUXDaQSn4JZMG/6rAox/eM4NetAtny4z
	acCl/2Ze1Pgc6xs+yxoXOchOPppOLpVtlhhmUHTwjhYuiyd7GVd1rqg8gytw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347845; x=1718434245; bh=E/D84aQtrnJjZ2IazwfJ5poXoyX5
	KdNzfOjrj1SQxds=; b=RNlRstH2LgB2310xegxnM1GrBnVSboFB2Jp+6Fz1SfhU
	I+LsXQQkCKjT1KVqY82f1tx0dfc8X6kfppe/cqXbM8U4wniZC8v09S20f6Z4/ifj
	9QQ/uKFC8bf69Hfh0zzNFK6GupTEADyC+gjBv6gPGSjBidN0k4SbLecipNYzv27G
	+I89z+m3jw4G391eiQqm0zpkKqhJFS/7cawcFSvumzukRGyR2S2d3xir6mKHtRjz
	D8+a5UX9PJJilNX+WCO5Lqu4vqvkCtH3XK7/GyOdOzBelDIU+/q3bwh3ksDdrLCK
	cEM3wfh5AE+KRD0aA+s/Z5rf0+H6BUxQfOnEZtO+pg==
X-ME-Sender: <xms:RehrZvEKkFgRWpbV-gL_iXDRuT1SEJeCRY4Xns-RXuGamcI_TUjExA>
    <xme:RehrZsVKS3sJtxEEjEHX-J5GZr55pnX9VmmiV1LlXZpeeTREEGAVclUfStJaNrTI3
    c4p4s7A2ar41CflSQ>
X-ME-Received: <xmr:RehrZhIsON-u5GNi23w6849TVZufJAwMn08Ahk47CJcQiOqOQkoT0ZmMw_GCWRIbPfvu0XNK_aa-hzOqavPBArmQNNN-_EfHyER2r8REUlyTeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:RehrZtFb_gOcZhAnW1lAl8OdUP1t6oG_MBd7fgAX-vi6rSfT6wCG0w>
    <xmx:RehrZlWiulgZlQWwv7ziPIe-aiMkyOBqJCeK3vVGDzvnmo88lbYn9w>
    <xmx:RehrZoMYklJc9DUIb9BrHN2vzndB_W8FvqBYpWIWDBJBK4pI8vCcCw>
    <xmx:RehrZk2zmw8GNDNN_V4fzZ3FX0y6g5paGTmc5FfszdI1JcCTzwJxbQ>
    <xmx:RehrZjfUmDVIcFZhgmQx6ttxUqG67UIzdF0E-FnfOtrU9KVm2DHJ2dQO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:50:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a61a2883 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:50:30 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:50:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 13/20] oidset: pass hash algorithm when parsing file
Message-ID: <fa41a85c7e13870439e2bc913343400e8254bda8.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ULFFUDm7+l4rlRbY"
Content-Disposition: inline
In-Reply-To: <cover.1718347699.git.ps@pks.im>


--ULFFUDm7+l4rlRbY
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


--ULFFUDm7+l4rlRbY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr6EEACgkQVbJhu7ck
PpRgow/+MhhxTVoFmC+o3vAZIJsTaPW7wdvKMxVq5NIgWn+Pr/tK1y5boi122rhi
+nirKM8EjGjMg2rVoEatQYXslZllx38vCAZyChaq6AdVZAPZ3r5YZsZlkMG75BeG
mrDeWaMLFF3sZthJSLvjg2cpfVh2wb3op7snt3kS5fwLJHzIVxPP6XWcDwMwOxU4
tb+XXKMTIxifcCdfgQf2zJs8kaFqSQqncowtP/T4I4mUdNIDcIBYxQ7OcUPWPRNn
TNQvtmcWNw+DYSV5M55G2rw8sc1BEx2Dfxj/FosChBO3E8CQc08hW9vt208pgEoF
po6MgI5JIRktLxCyvuUAfh9ssLWFDiiP4r1sTxgih0oU1sN4oz6jObDibdAB8RCM
BOsSh/zqEz0xrnJ4jUi60H363V1oykMOVQEXIy/g9OFt3xVbk+3QneXttbwJVj2r
wlGQb3imzf3yt8L6Qvj/sZ1LH9tQfa7PgWBNpdGNMdqNUZ8KbXeQ8IYAIDtrXLFu
fGbaxxjyuAON8mxQi9CdVgkvUdMOn8Aqd4UleAls4jh+gVKIl7Tw4ZBJN3GRNLKa
mu3j3dta/N9Ahp1tP5gtcEUR1DsveXv3RqRt0SqcsANdeUj20cbh87TsxirDUHS/
VphbSPQ4NSUarKMOTnSAKf4hXuyIHiBOLdT+Cal2MzHOON4us3c=
=x6vT
-----END PGP SIGNATURE-----

--ULFFUDm7+l4rlRbY--
