Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EE4178367
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097672; cv=none; b=eL155kY3GzonEO6MAXmWHp8iNtsPFVpvBq93oB3O1RPj3377c0GtF56r3euZVQIf/6y9tnJkf5iusSFwvkCdCsFQPyLMIQBvz/rzfciAo6geW7pZ7fgilY6ttHKe17N3tZhqGhO3N9NpU+JswNa3+o16dkYdzEkq8cjMykx7dHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097672; c=relaxed/simple;
	bh=BphcU00v+raR/uCl+wLKDQI0/4036zPH2JgllF+/TMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Smk1XSROQNtqBZer8a8lqaIdi3S291QPIoagoYY6/77nTBDuiuQod03FhSFHc6vu0iBpqUqIfllDaxzIHN19Yr7SPj0zIc4dhwRmXHYi/poIRzVPSUbvBSDnxWwoxBD8ogA5oP7F0X5x2ZsGo404CdHI6wF2OFufmpCfoorCexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hG8+mKA3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IlX6IAwt; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hG8+mKA3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IlX6IAwt"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 511A31C000C0;
	Tue, 11 Jun 2024 05:21:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 11 Jun 2024 05:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097669; x=1718184069; bh=OV2jzFbIlB
	WdBPFpHg6roN6CbhQjyno97vDor/eg+PA=; b=hG8+mKA3ympqG09vN84qT4nX8j
	0U70Tce2zyc/uuJjOluburIfjnV13H2HxYdqNEuxne3f6fdu6WFa60PcgQfZXA8V
	o6z3jhe+poxnGCgmoF3efBTFLKddTHGstfv65eTVWto72CZhPIBQ5Cd5Y/5afe8/
	q0R2Mv+v5V/tgojxhxuLi46SsbNEKwq7URBD0BHVXuDaGufrgq9fEqrTsWYvRRvT
	X1YAfjYU2+9UQeQEjSunfnEWXCaqSqeM0jxscg69yIkoPB8mqGweQxV5UfajtL8C
	Sj3DBhpj47Mo+wMk0VmP8XwXNTgtDc1pmTsV3bPsG7uTREbY2Wofch25qqmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097669; x=1718184069; bh=OV2jzFbIlBWdBPFpHg6roN6CbhQj
	yno97vDor/eg+PA=; b=IlX6IAwt38ekyltHtjUJeO9G3RONNirQ/0ysrVVXpzlR
	BfTzx6YiErhD8pYPymjMxzVRLkdI6E8QEQZ4yciyzYXqAwTTL30asmwlvvPPlrd1
	RitxgeKOwE3eKKxgYSh2e775fAF0wi2WWIrWr7F01C5YW6nlD9nw5XvG+Yk0hrvd
	3naAL2W4WivEg6MbVhvAdOz+NkPJ7bPH3SUgiLcc1FQMUIrweJ5ShOuwQaOr6Nwo
	DUVJDRVy/dy4pSn8hhekG/uklwOlB/tvKDn6uXHExd2hPiZ2l5X/kBPgChNLc299
	G69g3WLG/hlgRrA7hmHgwkUiWP5bNhAWplnwBDADiw==
X-ME-Sender: <xms:BRdoZi0OGyS9nVs3hU9noL8xD0XtCPlwnhhN9YxqZu5bXlgNCjsR4w>
    <xme:BRdoZlGTsw222FbfUcIO0bRMv8VhqjQwY9SLHAt1ePxdZi2DUHEr9Z0F6y00wZ4PA
    TXqiUM9YDGxqzCeQw>
X-ME-Received: <xmr:BRdoZq7X3C8fxn7Fe7Snwy69E1MHd8IUO-OUW8FmvoLmtcSlQhf6OUqxIkn2u3MZWhGeQK6tkHvBPhbl5tBRB7nO1Lrrw-pXhrizymeCjzlPPRs3kRRK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:BRdoZj2VGcj9SZbiFRd-LIvpqn3IQfzEEVw_fIaBdUHAzFWt0vT5Tw>
    <xmx:BRdoZlEdeeX-01-6V-kmon2cG7_O8WqT9fV_jwEx_EofezxyaqWscg>
    <xmx:BRdoZs_dekoaXZ-kGdyCVvPcCwhNzcFLUiuIsJl1oDFP_bYbo9to0A>
    <xmx:BRdoZqn8CYnKyaDhyiUtDDL7a2LORWfsY7s7yYhG7gR9_1q1KokYog>
    <xmx:BRdoZlCOLW8ilISu6pe2LxVURDqC-02ni51BCXOaeqUzk_4HeBUKNONX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:21:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e488623d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:21:00 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:21:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 24/29] builtin/merge: fix leaking `struct cmdnames` in
 `get_strategy()`
Message-ID: <be9bccc853c690b047fbef6dad419cc35cbbd4c0.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vUmxz8GHRI4ikeRq"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--vUmxz8GHRI4ikeRq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In "builtin/merge.c" we use the helper infrastructure to figure out what
merge strategies there are. We never free contents of the `cmdnames`
structures though and thus leak their memory.

Fix this by exposing the already existing `clean_cmdnames()` function to
release their memory. As this name isn't quite idiomatic, rename it to
`cmdnames_release()` while at it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/merge.c         | 10 +++++++---
 help.c                  | 12 ++++++------
 help.h                  |  2 ++
 t/t7606-merge-custom.sh |  1 +
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 50b0c87a95..682c6ed868 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -164,7 +164,7 @@ static struct strategy *get_strategy(const char *name)
 {
 	int i;
 	struct strategy *ret;
-	static struct cmdnames main_cmds, other_cmds;
+	static struct cmdnames main_cmds =3D {0}, other_cmds =3D {0};
 	static int loaded;
 	char *default_strategy =3D getenv("GIT_TEST_MERGE_ALGORITHM");
=20
@@ -182,10 +182,9 @@ static struct strategy *get_strategy(const char *name)
 			return &all_strategy[i];
=20
 	if (!loaded) {
-		struct cmdnames not_strategies;
+		struct cmdnames not_strategies =3D {0};
 		loaded =3D 1;
=20
-		memset(&not_strategies, 0, sizeof(struct cmdnames));
 		load_command_list("git-merge-", &main_cmds, &other_cmds);
 		for (i =3D 0; i < main_cmds.cnt; i++) {
 			int j, found =3D 0;
@@ -197,6 +196,8 @@ static struct strategy *get_strategy(const char *name)
 				add_cmdname(&not_strategies, ent->name, ent->len);
 		}
 		exclude_cmds(&main_cmds, &not_strategies);
+
+		cmdnames_release(&not_strategies);
 	}
 	if (!is_in_cmdlist(&main_cmds, name) && !is_in_cmdlist(&other_cmds, name)=
) {
 		fprintf(stderr, _("Could not find merge strategy '%s'.\n"), name);
@@ -216,6 +217,9 @@ static struct strategy *get_strategy(const char *name)
 	CALLOC_ARRAY(ret, 1);
 	ret->name =3D xstrdup(name);
 	ret->attr =3D NO_TRIVIAL;
+
+	cmdnames_release(&main_cmds);
+	cmdnames_release(&other_cmds);
 	return ret;
 }
=20
diff --git a/help.c b/help.c
index 1d057aa607..3686285ca3 100644
--- a/help.c
+++ b/help.c
@@ -157,7 +157,7 @@ void add_cmdname(struct cmdnames *cmds, const char *nam=
e, int len)
 	cmds->names[cmds->cnt++] =3D ent;
 }
=20
-static void clean_cmdnames(struct cmdnames *cmds)
+void cmdnames_release(struct cmdnames *cmds)
 {
 	int i;
 	for (i =3D 0; i < cmds->cnt; ++i)
@@ -359,8 +359,8 @@ void list_all_main_cmds(struct string_list *list)
 	for (i =3D 0; i < main_cmds.cnt; i++)
 		string_list_append(list, main_cmds.names[i]->name);
=20
-	clean_cmdnames(&main_cmds);
-	clean_cmdnames(&other_cmds);
+	cmdnames_release(&main_cmds);
+	cmdnames_release(&other_cmds);
 }
=20
 void list_all_other_cmds(struct string_list *list)
@@ -375,8 +375,8 @@ void list_all_other_cmds(struct string_list *list)
 	for (i =3D 0; i < other_cmds.cnt; i++)
 		string_list_append(list, other_cmds.names[i]->name);
=20
-	clean_cmdnames(&main_cmds);
-	clean_cmdnames(&other_cmds);
+	cmdnames_release(&main_cmds);
+	cmdnames_release(&other_cmds);
 }
=20
 void list_cmds_by_category(struct string_list *list,
@@ -689,7 +689,7 @@ const char *help_unknown_cmd(const char *cmd)
 	if (autocorrect && n =3D=3D 1 && SIMILAR_ENOUGH(best_similarity)) {
 		const char *assumed =3D main_cmds.names[0]->name;
 		main_cmds.names[0] =3D NULL;
-		clean_cmdnames(&main_cmds);
+		cmdnames_release(&main_cmds);
 		fprintf_ln(stderr,
 			   _("WARNING: You called a Git command named '%s', "
 			     "which does not exist."),
diff --git a/help.h b/help.h
index af073a7a02..e716ee27ea 100644
--- a/help.h
+++ b/help.h
@@ -13,6 +13,8 @@ struct cmdnames {
 	} **names;
 };
=20
+void cmdnames_release(struct cmdnames *cmds);
+
 static inline void mput_char(char c, unsigned int num)
 {
 	while (num--)
diff --git a/t/t7606-merge-custom.sh b/t/t7606-merge-custom.sh
index 81fb7c474c..135cb23085 100755
--- a/t/t7606-merge-custom.sh
+++ b/t/t7606-merge-custom.sh
@@ -14,6 +14,7 @@ Testing a custom strategy.
 * (tag: c0) c0
 "
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'set up custom strategy' '
--=20
2.45.2.436.gcd77e87115.dirty


--vUmxz8GHRI4ikeRq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFwEACgkQVbJhu7ck
PpRuABAAhw4OzJ498vSvQ/0BzwKbbZofh1QNvXyf6r99lIqnC0JNfpI0SrNRQ28y
isIUka84to/WcxZcO92hOqe+IzQUSp0CtziSoV3Npmlj4Nc/kGTJC4UAVHjeut/P
ZpBI7CWEO66xRrE+Cf0YDXj9Pq97415ixp4acHAb9rmCKjEKhEGfzSguZqw0eb9U
teHiNdYLnsMk5Mqq6RBVa6J/MAwuyLZQNrQt//vhd2bJRJBUzBuq7mP5do/JC7wk
m2a2CUdR/GnIvO0GdOUmfvBTqe21PmFDf9fD89F1GCCU8l7do+HBHF5Cwtls5Ytr
VxprAWrXhcoqeyIVmfNty8gBdEYmqIa2uUHp6fiMA5Elj1r+QmJe9YxSs/1SXl3I
Tbc++YZ6EBxCfp8fiJDqXpS4bM4M9z71UGW3C3qfGWOtsLAkgOFGSQeU5HjZUwxX
1c9umA/5djGEbhMfaGmexiHiRW4SlrpSNdPkII2ecqeQ9LYF/ZSpdObbHAdboKe3
Ax0xAr//h2PBcDGqOX6jFL65M7Q9dtRQ5RQ0r73cH06NicjUxNwrTSgkmBdJ+HhV
k8l4RyMn+gg03j/p//OvrkmJwMwTAD6IRssYgju+0P50otthLmPwtjcLrC9UPL39
65bC5BnoX7nXLX3IGur5Bv8q/+vmIs5cJLfHkvK+IdysObjdBlM=
=fws4
-----END PGP SIGNATURE-----

--vUmxz8GHRI4ikeRq--
