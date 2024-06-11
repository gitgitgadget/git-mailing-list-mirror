Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6125117624A
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097586; cv=none; b=kQAwXnwVJ54O9FAkK+vEVvL2DU6nANYjZVgH2LylDjxBI7eZ0yAyU68KBYRtnGFrdsFUr/cYo9/fWAsj95iN0rLCvXu5fWrDUwb+/ez4UOrNh2ftMX2oDWkq095CryO4l2b1QcvVMlkPqttkLv5ptnM6R2qd1VAVmWtmhfdqSoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097586; c=relaxed/simple;
	bh=jOvXoRXEGdlonBSSGbp7rASokQ6nzTp/jmpOgYeY+Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qx3LzpCHJyC8nrsXejCaJn/I4yDHDV5a6jAIa3Rz1Xk3IpTP52sKF/TEHgcfd0SUp9eyP40VziptWWnfkt5s6H8cZ7SCk7Ksj8ifftOSjuQGO1cPA5abfFshnDFZojdVKtsGNAej2mj+dPefkGw/NZHCHNNx+zQh8WJlI3l7DW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h82/PKVs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K+/0gUne; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h82/PKVs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K+/0gUne"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 8118D1C0010B;
	Tue, 11 Jun 2024 05:19:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 11 Jun 2024 05:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097584; x=1718183984; bh=kVwsnpp01v
	/hyIU9WBdvtsCGLMmn0N2f+aHPsfhKe8Y=; b=h82/PKVsILLyg1ted0v6q6NrwV
	TlPHIJduGL7Gw9e7Zdk0xipXsTSQ7dnab9+8DRwUmRejK/q+j6jwcvOE4FrANWi2
	Dqo/N83OHw+rMLbOV3+Y4G8GDbPIWRzvZB9JYoCPRX5CsytvtjcBs9kGvyxZcxwr
	QAN5BlVjMemmpkbyAEp+uSx1SFtLdsY3L97/on7cgWjEiNabcNlhLAUS2f02FrNd
	xWSTxW7V0NAfzBeXVUEv1wGhab3qrKMN2kkJNyCvna7e7PuSbP4qJ5nBT9wCgf12
	y7DPqaJkRdtUI4sTQOhTGUpHdgXseWSUe23HR+dMXDJSKvwGyFnDMDtgjbrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097584; x=1718183984; bh=kVwsnpp01v/hyIU9WBdvtsCGLMmn
	0N2f+aHPsfhKe8Y=; b=K+/0gUne06iTcGLePrv/3EQpBwpRh8xmE71IuQ/mvwKx
	izRieX/z8kz63Ko7XrNn0GND0xGB5BHdncCWqdfpvs1E+My7VBVu0zl/MaCLDV6n
	RMjAuaFP5Kb/J1Mo/HOAnEvq1nDGzhIhpo5kEGy/Te2oUc2/rW7wm77ubu6srevz
	Megmmwrc+aAS4UvFnfS+yjep4zgtCGaqDQ17gi/j0h0z7x2beeyu4dJapbGT7L/w
	W82oRhBiOmKipRuJxQ4Dva7psBNheQMNadt38L8qSZs2oa3f82F0jY8B2qlFZuRu
	TpapddPrWTu/yL9MDN5+NCf69pLaKonXBqTctGwb5A==
X-ME-Sender: <xms:rxZoZiHcS6fb08jwFaDrs2qSNHWHaAUVz7E7GI4qusZrVsTSR7mmWw>
    <xme:rxZoZjV8dDdX7gGeczqVmzOpSFXkjDeaqe7VTmcOWnB0LJZq1m54PUQ9-LSDYVu0S
    BoyhXIr-T0ja53bqw>
X-ME-Received: <xmr:rxZoZsLYbLKlm0rnm8o3JKjJNicShK4v-tUmMJwPuxFo5ahWl9BM1_SI5uDZZTzkuCClQFo64WNLzEdfoYU6hCbQhujr2sCDgR9SaDWcxUeMAfbgEs5z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:sBZoZsEC0hamPKB7eMpu3ORRLEJn2jQatFx4L5LOcz94EDVMMM86rw>
    <xmx:sBZoZoVWFIpSmqG0a69M6lq0PtlzQW5AZilf-Vv9rH4SgpJwf9ISwQ>
    <xmx:sBZoZvPw5ql8xQql_bPqi_qV7LGQewXWg8ZrQzSDA7i1lkYY7C84SA>
    <xmx:sBZoZv16cCDnAheEXt2RIdavTh47VJW8psFC5_y0PtT6z6uxbTvjbA>
    <xmx:sBZoZvRhM_z7KFx61C5TvDWUhPyFzoLI8LsfmcvlhYMVnbs7HFXpMZ_o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:19:43 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 32c72a1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:19:34 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:19:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 06/29] merge-recursive: fix leaking rename conflict info
Message-ID: <f16c29a20a041d6d64681ed65ed051363d831235.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GE/pxlxymC5OOjf8"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--GE/pxlxymC5OOjf8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When computing rename conflicts in our recursive merge algorithm we set
up `struct rename_conflict_info`s to track that information. We never
free those data structures though and thus leak memory.

We need to be a bit more careful here though because the same rename
conflict info can be assigned to multiple structures. Accommodate for
this by introducing a `rename_conflict_info_owned` bit that we can use
to steer whether or not the rename conflict info shall be free'd.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 merge-recursive.c                  | 8 +++++++-
 t/t3401-rebase-and-am-rename.sh    | 1 +
 t/t4153-am-resume-override-opts.sh | 1 +
 t/t7201-co.sh                      | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8ff29ed09e..8c8e8b4868 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -239,7 +239,8 @@ enum rename_type {
 struct stage_data {
 	struct diff_filespec stages[4]; /* mostly for oid & mode; maybe path */
 	struct rename_conflict_info *rename_conflict_info;
-	unsigned processed:1;
+	unsigned processed:1,
+		 rename_conflict_info_owned:1;
 };
=20
 struct rename {
@@ -308,6 +309,7 @@ static inline void setup_rename_conflict_info(enum rena=
me_type rename_type,
=20
 	ci->ren1->dst_entry->processed =3D 0;
 	ci->ren1->dst_entry->rename_conflict_info =3D ci;
+	ci->ren1->dst_entry->rename_conflict_info_owned =3D 1;
 	if (ren2) {
 		ci->ren2->dst_entry->rename_conflict_info =3D ci;
 	}
@@ -3055,6 +3057,10 @@ static void final_cleanup_rename(struct string_list =
*rename)
 	for (i =3D 0; i < rename->nr; i++) {
 		re =3D rename->items[i].util;
 		diff_free_filepair(re->pair);
+		if (re->src_entry->rename_conflict_info_owned)
+			FREE_AND_NULL(re->src_entry->rename_conflict_info);
+		if (re->dst_entry->rename_conflict_info_owned)
+			FREE_AND_NULL(re->dst_entry->rename_conflict_info);
 	}
 	string_list_clear(rename, 1);
 	free(rename);
diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename=
=2Esh
index f18bae9450..328c1d3a3f 100755
--- a/t/t3401-rebase-and-am-rename.sh
+++ b/t/t3401-rebase-and-am-rename.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git rebase + directory rename tests'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
=20
diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-overrid=
e-opts.sh
index 4add7c7757..6bc377b917 100755
--- a/t/t4153-am-resume-override-opts.sh
+++ b/t/t4153-am-resume-override-opts.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git-am command-line options override saved options'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
=20
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 42352dc0db..189d8e341b 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -23,6 +23,7 @@ Test switching across them.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_tick
--=20
2.45.2.436.gcd77e87115.dirty


--GE/pxlxymC5OOjf8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFqwACgkQVbJhu7ck
PpQMjBAAmQFvgLI+wQtxnhkqPCDLZSGAE1UEnub0a855MAPUG7/8GPBh/T/etGDM
cdMU5EnCm2E1w8/aE8c/s8sp7OxfdLxT/EXx7TU/5DpmE0wuwI9uJobqxuo3x+JQ
N636fSQua+BN8zxyjF8/+v2sZLj7IAPEDXF+APJPQ6FchgZvykKbmDRI5vz5Xe05
JQI6cEwPVMzXOHgGDv7dFwEsKmMpRfsA8ielbGoAobqcB+dZI+VpCIvbuHQLMUwh
v+HaI5H6DF93LFZmY7M3xs0E44ri85ekHc8zrCJEo1upML4dVZLniJ5g/ixx4amT
S8ftBCOrUUPlIDfVgiZOYUuJ+m5EO0M96ycVj+NxxNqXdX3IvLBSTLqNgesrlZGV
W269r10Vk0aovTjTdRN/FsP8BKqS56VqWa7qKonmlJ/J3IxK6NfYYUGl5Z7U56Ji
WqHVER1zCDSfF0IhRPH3asA8KacPzouG0L5yzpLrwnOA//8ogJziTlIyZmqgTY/+
TlwqMDPenHJn7YAiFiEV9A/b6XgabAa+AcHJELDOy63oMA97AIEy59HpYpedFM48
VRqaWdkZ+qSDONvibwHiz6lJhZfFuLKycnP23VqOMkW/9PYHZcfUm+xTV6Hbmr+W
Awuz/2i+6qX+uqYBSvLIyOZh9lU2a7X/vOgk/6semskQt+1wcTQ=
=Ujr4
-----END PGP SIGNATURE-----

--GE/pxlxymC5OOjf8--
