Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815D1BE867
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934840; cv=none; b=IRCbqj60x04wgKi/151mds8YVrFngt2U0HQagEdhd5eBnO+6zp7eieXkVhdw8N+Curze7Je8ufCM4guRjDRE2c1S50TApaBX8Id2Ulq3/40WvZr7awvNOiltrVIinvNRvoT5vnW9fgqoPJxeGIiUWrG/H9dB4wcEbLXFH4RcpHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934840; c=relaxed/simple;
	bh=MVaAzJOgESC+nGmqLRLYtbs25qcNwR4AKLy54dyZqkM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SF+UAs84apBahy/Bihzzwx8O1PSSRkQYkMHPglJi0jLAOXeQEmeH5AdffJuMJ7Q6uo2d0MsIFcrp+dZAEnrXwenZ4b6Mc0baawbfnoTn/1FagWx8VF+mNn87oIaXCaiMZig/bc0B/dIf95lfq/Xc/bpzZkVgTxWIfnEdNTMd4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qEcTEyp4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tg8B8FoC; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qEcTEyp4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tg8B8FoC"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 492971151B52
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:00:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Aug 2024 05:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934838; x=1723021238; bh=fE1gftK/xM
	5FqlBk6hc8IXFYw5cK4AOgE+njagGsHKU=; b=qEcTEyp4zvHCKcFmUk1Sc7K0ym
	dYguatRvOARUhgXAdq3a3rBPAzFQkwzmL3NGp5BZ2on3CnUhOS6WfVv+4nFjtQ5a
	S/ilXUofPgA5k0hSS5+0rroQHKVxmNN9txsB1ScjIl9i7ucn1RQvxjW6huJ3xIgG
	LO5jUqSKZ1UvEuOWuY5u3IQSCRdbFebvs+xZ1fPpelLGAAa7RCyHNfXdrrxyrVWu
	dHQKAY3yvDdrpEpQUeOsDLS9kbNqYEFQRy0XwViQPZgpMutjZyHSnXuibjaVrw4a
	JDGorxj1FoWHsYfvnEqdxGcT/FRM1K9ippRV5bdrwyzbz9VsA/HZ2yJPbLvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934838; x=1723021238; bh=fE1gftK/xM5FqlBk6hc8IXFYw5cK
	4AOgE+njagGsHKU=; b=Tg8B8FoCjOkNWRDm+mkzGXubRzD5AG9ma8Bgj8ipwP8N
	2FtxIgJlcGYu8ZPhVOU2IZvuQe50/eGUDDrDKsnJqeBnbZi1y7sfaJ1BmpDBPyBQ
	8GlmgKBPdKK/G39sJ4ICW4PjDP5HMHcGWpBCYbzhQralUp7T/nWWygn04z2xY9Px
	9Jb4BVzSyQdqn0v8k2Zu2KP5JSRjOI26dek5SuhKEHqV0GdCitDq6vxq501OiZq9
	Rtzt5GYwfr46utX/7RH+h4zp/VCuM343KJ5xkACHsKqy6TbX5n/Rigv/C2x21+hF
	jqZIxnUK4U1WykJUQuvFSvXheg55E0PJrjhHi59nTA==
X-ME-Sender: <xms:NuaxZqwvYnj-f0L8CUrT-jP16Cm0Nq4uHmUKo2vt5qDCyFkYp7UqdA>
    <xme:NuaxZmTwKNs5Q5t2wTyMvnkA1c-_dBRf0nXp-LLOW53cKkCT-BrnIM8sdhs6sPzwS
    QnCqqY4KAaMweyXWg>
X-ME-Received: <xmr:NuaxZsWK-GMe_415hPcpE-HodMOL__kMSdye1wXVBsJLylqpTghNroL-TNsDlDGmWMax_RfCvWipsdVc2WN-5o-b2B5Faams5UJZiWOiBFXT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:NuaxZgiA_-Wbw0ozuqWaJU0F-M2ydvzUdmihTZGT88x8oWT3OOmE2Q>
    <xmx:NuaxZsB3dK7RJ0me7s7CGh37XBdi1iRX9GJrMPuqaLzxUExM57dCHA>
    <xmx:NuaxZhIZFFHSmnQlZSlQp2Te4zUqbcj35ZFAEs6ogUpa3C-6S6wsLw>
    <xmx:NuaxZjBqSr9is8lTFUMvRZLK6Sxv6Wtd_t-4FWhOxzdPnor1NmhUwA>
    <xmx:NuaxZl6E8-qHh2XHl4mcbuKG1OsIx7w5f2Jc05ayZKx73o93HLctJZG_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 05:00:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 62f3e5b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 09:00:35 +0000 (UTC)
Date: Tue, 6 Aug 2024 11:00:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 13/22] builtin/fast-export: plug leaking tag names
Message-ID: <64366155dee25209ab9c434016c5918d47d7e1d5.1722933642.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QW2iXdf8vZf2hnWo"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--QW2iXdf8vZf2hnWo
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
2.46.0.dirty


--QW2iXdf8vZf2hnWo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5jIACgkQVbJhu7ck
PpRBJA/+Plwmv+CIWfmkHkFKRyVZU/Jts38gPyy+HrkBbf27RfEAnFvBTsy+dEKw
s3aAN4BJ83YiPiMMvX2roDIDyxn/7EMPPe6l+nXnKFZk2jbhO0vUkC+xv0vBnd9X
7/8L7jlh/avomgBYbJAWWrZd8IHmvQyNaoeWeRb3U84ZRNN8O0NAa6uke1sbYhnJ
LFeRnNj3F+X7VIT8uL86RIjnkLunkM20s42jb+vw+KtXBKA2nuwS9DXHOw4WGMIM
A5JjAId9iSFQGq17EexPWtXZN/DAQkfxt1H526eBJ+XFFoyBJyvnnCgBsaNzu2Ru
vUi4qwU4P1A4h4RIYrHmiK0Jt7K1x/LJeGEVKA3EYkRsjGchchyh6iW/z+U+Q9sC
30mwvqub8A9tvWTFECZOXVfHW2RDnq9uM38wKMZMUxnWIcggcKtTzCEqjgpw3jLk
ZTKZRuiceQTukgc4RRdZhAoe2cp8lBkQj9menrCpUUfkSAdlO9p0CRnUjdgyEBwh
1QGhyPO3U8Ex8Eq+SOazDiEp71FDv8qvA4IfV2O7i+EoVmGOiEwFZBHpyTO1E2cg
B0aMQuJChOJZVzArExcMuPCpNC6CRyg0mFkDNTgjZJEH+mbW22YP+OnD0bhCVQGD
vrcnkGOipS5MhmJ5KlG7MQtekpJejZ1H0lMvrf7bYT1vxbGd5lQ=
=rmD+
-----END PGP SIGNATURE-----

--QW2iXdf8vZf2hnWo--
