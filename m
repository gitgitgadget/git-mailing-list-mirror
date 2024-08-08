Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385F218CBF3
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122337; cv=none; b=dvMa3SH/mgxuibzHuL6GPOjQl9GqEuna/jMkRCZVktTMnqMZnuKmrrgsHpJ2dcLR2p4MZK+uirQM4KkPT7aFWFOU8iAdYCrevFd/6I/RdImpoKer7HEYgTMNCTbE9+q3lNdOroL1T/sUjX58sDv0KAvfFD8uX5ghli5qhnzipKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122337; c=relaxed/simple;
	bh=dnFkPaJomKdDhg+XEcx3a1eDMytOvx7O+JOswN8lIPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jroqdre/PUaHgjnwlAKwXjz0Au0HmqtCYayP4TRSFWtz2AsL/zY3FA72uDVCc2DPN0mn5PMR61D2X8KISdX1ywkj584etPoUp6j8HklpU1oGHuMfcHx35Qg28rvbbWCGgOfINV4/RljZFuFJidOjaQzH6Nn/J+WtrU4eiF6RXBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y8zCKvib; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JSnhNxxs; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y8zCKvib";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JSnhNxxs"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D054A1151ABC;
	Thu,  8 Aug 2024 09:05:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 09:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122333; x=1723208733; bh=I0EuISd35d
	RqYWFGmkzWeHGp/BdcgfO/FO3foq1Tf5o=; b=Y8zCKvibtX5wGKo2j6h2rWoRCL
	vLGp1VJx0IrCZXrUnHrcp0p32VoI14KU8DU0h1/r08tVv40IFQFatm/spuuy0iOY
	NOqgw/D9p0/SavfpJ23+M4ZTV6V6f35fx9ooFix7u328R8KIlYbISb544qsNQ4FE
	jIw9nQzmeaIsuM/bHxSz9wwCZ9j6Cr+vyrY4aIhIenYUNciPeQq9jtDQFoB+tpyU
	FL3zwxT7Jl4H1a8cPbbUC0VgL5fSw3JvjwZ4ms5nA8xLvxbAXTsHyZfBe/nZDqNh
	TxEz6DoKex1NCthQ8tWU2/k35Bibxsot1sRZ2e3qVR2WnfGSurR0A4haaIRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122333; x=1723208733; bh=I0EuISd35dRqYWFGmkzWeHGp/Bdc
	gfO/FO3foq1Tf5o=; b=JSnhNxxsOjZbzOGBHXbKMSWSpYPMn5rhsUmsYwzJ5H5F
	AcByEIRxn6hh3HMJf6JwzeOSIlwBdaiLGgd8E+HszWyoBXKzpS6GTG9GaR1eWeDe
	7PhVx1etVEOCUIc+DAiGxGX1WtbjOSYQd2Fe3z3kgk6n1tKpkBvOyVE+lVeD+71k
	e/T2v0+JCn+dxdzmrSv28TpkNC5+Tv7lZ5VNBvVQpRTPFeCfr3eh+FpEhS+gHYdo
	nuAvRM9qLmFyGD/4o/VRR2ZU+f2pGftU7/ao0umPprnhOx1yTWpkTZMSS0uKHCd2
	F3fkW9J3DaqL42aKz5tNR8jzHaUX34kYIPgid0Qu5Q==
X-ME-Sender: <xms:ncK0ZutG3PkHXPPYd6xw7rUIufX_sW9a3CQeTQql4CCIdK9ZQij3WQ>
    <xme:ncK0ZjdwG71WZzmQ4rnib4TSIN5mA1h1MPqm0kpLcCN0G1z27iSbl0F0x8QAleRzv
    kdJ39aBQjYxRiu3GQ>
X-ME-Received: <xmr:ncK0ZpyJlEdjhwCI_GeYIt1wWsYrJoxTXPEdZLZc_z3TSxBOUV0Zm7Uk35dXE_tqA0iQVcs9AGe41_47UshwvKn1UwmC3gcZa2vSKTxNXXooXb1n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:ncK0ZpMrlFbZyTg-FHzZAM_sbx2rWuWz01Y5mkANEO8mUXvkJCi6Lg>
    <xmx:ncK0Zu9jBN6TY0QA6h1iXPpOFoV9oZujuU8rWmBABkIVkEorvEKeBQ>
    <xmx:ncK0ZhXj4Vy1OPEx_WalFyVbY004NpYPfd_dqfgTczWiYJZi2U-8AQ>
    <xmx:ncK0ZncfLH6XEvyBCwI6q-ltUr07f3qBUlIrN95krl4YaZqiucLkMA>
    <xmx:ncK0Zla22QdCVjjGCLWdh2dpeNGKd0S3IZbNmIrF8JW_v7MUs55DMCcu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:05:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 951d5408 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:05:26 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:05:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 13/22] builtin/fast-export: plug leaking tag names
Message-ID: <d9dd860d2aab6346fedc8816891e916e4b948270.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o8voHMKWWid1/0Pu"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--o8voHMKWWid1/0Pu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When resolving revisions in `get_tags_and_duplicates()`, we only
partially manage the lifetime of `full_name`. In fact, managing its
lifetime properly is almost impossible because we put direct pointers to
that variable into multiple lists without duplicating the string. The
consequence is that these strings will ultimately leak.

Refactor the code to make the lists we put those names into duplicate
the memory. This allows us to properly free the string as required and
thus plugs the memory leak.

While this requires us to allocate more data overall, it shouldn't be
all that bad given that the number of allocations corresponds with the
number of command line parameters, which typically aren't all that many.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-export.c            | 17 ++++++++++++-----
 t/t9351-fast-export-anonymize.sh |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index fe92d2436c..f253b79322 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -42,8 +42,8 @@ static int full_tree;
 static int reference_excluded_commits;
 static int show_original_ids;
 static int mark_tags;
-static struct string_list extra_refs =3D STRING_LIST_INIT_NODUP;
-static struct string_list tag_refs =3D STRING_LIST_INIT_NODUP;
+static struct string_list extra_refs =3D STRING_LIST_INIT_DUP;
+static struct string_list tag_refs =3D STRING_LIST_INIT_DUP;
 static struct refspec refspecs =3D REFSPEC_INIT_FETCH;
 static int anonymize;
 static struct hashmap anonymized_seeds;
@@ -901,7 +901,7 @@ static void handle_tag(const char *name, struct tag *ta=
g)
 	free(buf);
 }
=20
-static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_n=
ame)
+static struct commit *get_commit(struct rev_cmdline_entry *e, const char *=
full_name)
 {
 	switch (e->item->type) {
 	case OBJ_COMMIT:
@@ -932,14 +932,16 @@ static void get_tags_and_duplicates(struct rev_cmdlin=
e_info *info)
 		struct rev_cmdline_entry *e =3D info->rev + i;
 		struct object_id oid;
 		struct commit *commit;
-		char *full_name;
+		char *full_name =3D NULL;
=20
 		if (e->flags & UNINTERESTING)
 			continue;
=20
 		if (repo_dwim_ref(the_repository, e->name, strlen(e->name),
-				  &oid, &full_name, 0) !=3D 1)
+				  &oid, &full_name, 0) !=3D 1) {
+			free(full_name);
 			continue;
+		}
=20
 		if (refspecs.nr) {
 			char *private;
@@ -955,6 +957,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_=
info *info)
 			warning("%s: Unexpected object of type %s, skipping.",
 				e->name,
 				type_name(e->item->type));
+			free(full_name);
 			continue;
 		}
=20
@@ -963,10 +966,12 @@ static void get_tags_and_duplicates(struct rev_cmdlin=
e_info *info)
 			break;
 		case OBJ_BLOB:
 			export_blob(&commit->object.oid);
+			free(full_name);
 			continue;
 		default: /* OBJ_TAG (nested tags) is already handled */
 			warning("Tag points to object of unexpected type %s, skipping.",
 				type_name(commit->object.type));
+			free(full_name);
 			continue;
 		}
=20
@@ -979,6 +984,8 @@ static void get_tags_and_duplicates(struct rev_cmdline_=
info *info)
=20
 		if (!*revision_sources_at(&revision_sources, commit))
 			*revision_sources_at(&revision_sources, commit) =3D full_name;
+		else
+			free(full_name);
 	}
=20
 	string_list_sort(&extra_refs);
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymi=
ze.sh
index 156a647484..c0d9d7be75 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -4,6 +4,7 @@ test_description=3D'basic tests for fast-export --anonymize'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup simple repo' '
--=20
2.46.0.46.g406f326d27.dirty


--o8voHMKWWid1/0Pu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wpkACgkQVbJhu7ck
PpS1ow/+PWvXUhoDrU3+Lwt7hZhbL6zNxWRMP09T41yNQbzFYYH2EXA+W14AOePe
wNDWEyx+H0xudscllP4W6TBPuRVBu5jBr+3Z2/gwFeBvK2oSgwa5qPm03fMtmDt5
68RecF0m7/dhQHumDf/h8YA0xqh4Ky3cG0gT4skpZOMbLJshVqg9gc90CetCKIbO
hyhmL+HU+r/xlkbW5hNDJQf6EXIeCWaHC3VxY0H22vrq+On0uvMpS2qgXZwbxFcO
1d7gfAYvjWcG17azvKEIC0C/iFGmCKB95qzZS5eo4i3eFHxVYEghLECSP8WsSwk1
kVGtrCK2/rgSSQyLfmX4ESkZXApWpvO526LmhLvQR7WHVDys0+O+OSw8qlTDLelK
hLIJuk17mCJV3DhV0at8ZHFNHYdUMlfVtdHxF8SiL6rE0g/+UnLWxwSiQQ4L4TTS
8TnTdJQTDnUlSsLCEw9W+O+M8MFWxj7mh099mhyYhnNsqSGEILo+GU4BSS7pf3GK
xJhUo2C/rM7SmNsgpgidSZwsMoJbEjuPD99lSI66lJDBSYxZq7z9IxUXWW5u+HTp
iFSXl3ma/P7X+rzoHxLOYeYHDJEhw0SPBhB8jSBLS1sTR2DhymX3JFTTCWZuWvJr
krQu7oP+1ujo7JU1POLctkTERhuOUcPFNsRI9RA70Qs/FtmuZKI=
=XKVb
-----END PGP SIGNATURE-----

--o8voHMKWWid1/0Pu--
