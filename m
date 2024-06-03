Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3439D84A34
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408105; cv=none; b=Ljo9O+kJZGdBBaVThDMkIjzV+nWiGtj9GbrL/Q2BchdLkLQWkCkyTvFuqSGJnIkyjTR4R01dhLB2jhYtNtSkmLuJkYT7qTHpwdgciZteuSHi/GYpWS0RTRJz5UktznEJF3aV9rfJRsJt2eIy9WmH81rFatlOTfWTUAWKLABQVVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408105; c=relaxed/simple;
	bh=b8dkX6gBWs1MaoLX7HibSyxT+JvghrKznfJpnY9jmaY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdbJosKJemyzWUy409gLJ0ROOjFfPj4OJ2O2h+D2/p5fzCqUdc7e0ihwHK6VjWFiZGIfMs5yvx+S/N8lil/OReiPUvB2qrDMrshu+Y9DZ6wo8yi5dAlWHWuAmxt2QuyE3+vmhPP15P6QvFVqh7HGXU0n34G2OuAkAW5lzKsJnmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IleWmJcy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HIi7a6Qy; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IleWmJcy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HIi7a6Qy"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id B15F21800099
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:48:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 05:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408103; x=1717494503; bh=CyqMy6x4Ls
	AnHkHWSYLJtxYZEbM9yqpRsefeEBPt7to=; b=IleWmJcy10gIr37uZ1c2lZbCxy
	Ha2rheBagYodXFej4oaTL4jXHPlSfjpsftFyOYpjcIo4isag/jtVufuEdSRCrWMp
	phpO8dL7VTs6TYDQiMEX1uYqhW3M4KdsUNLmoqWIYI2qx4JxdX0LgtImZv0vVwLr
	hyE2+5i8rr1Lzj66+t30Lqd/ooa9w8BGm87uXr12iaNjm44DwxAK6YXWfqIkNjfU
	TidGmj0Or7ow0/sj27RICCB3PaVxohy4FxwrCQKbTEre9CtNdfmkt3hpHrXSpuOq
	cTf6rXabm6puqn6rjo9FBu8mbF8cIIYaOytLrFNf0FEv2HFHUi0MtG8YwjWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408103; x=1717494503; bh=CyqMy6x4LsAnHkHWSYLJtxYZEbM9
	yqpRsefeEBPt7to=; b=HIi7a6Qy8VojE3zw/oSaw3lNZ+WZ3nDrS/Q08txvuBB7
	5t5Tw7G+dPtmwlgwuumHcHEVuI/n81gM/c50Y1Al5Fz1L5L2WJMcIYfTfjXApgCi
	gxSMFidC+K2wEQ2oYVei703TSxvxyZ6GlfwAU1f8Yiuae1kS4QQc6ToB4s7spI8U
	iLfAnrT1rnL+EQC0qewRVOTGtPE9zuPs3y5PfADWUT7bgl+Rsct9cQQ7JHDRtDUL
	0NISk15LP7mejo+7LK3WTzrt2Lc2O/u7prvqHG6nBNiCvgL0nJrv1pNpLNUM40jY
	w8jRwY3jUgSWmufFHhfqdYck+J/2/Bpd/MqWtqtzZg==
X-ME-Sender: <xms:Z5FdZq1B8EnEqh-xDrr8QPhQLBxw991x9MvL_xsG_KCb9c04LFjpXA>
    <xme:Z5FdZtGAvy9w0FyKkbweAGdcIafxPke4MtwKJ5W9hAW3INlB-K1PJaaswEnl9Cnxn
    SLFk7eflwzh4pLv-Q>
X-ME-Received: <xmr:Z5FdZi73UViJHVprH24GcLggmU-fISYeuiMIi-1lgu7Rkk9WITSo8eZiAvfhGUYXoHdVZvtOtOIaWTcl-0eN93NOjn7DccfNFeoRJYa9j5tG6hJG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepgeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Z5FdZr3-REbNpuCohv0bNDgWufqoeiDoDBXOcQ6OKBTdOBm5wLfreA>
    <xmx:Z5FdZtEIvuA_y9lF5Vn6ejJaqUtOLizp5sXnNKltfTFXwzEtr59P-Q>
    <xmx:Z5FdZk8jaEw6UrfettrY1diD7qiQdi-LgIRyArw5k66m_qDd24HJ2A>
    <xmx:Z5FdZimUgZnsod1_0_yo_B7pDqeWItf-h4F85FsD9yTVyIy2_OuLvA>
    <xmx:Z5FdZrNExDhyeznHgxqNOKtbN9owDQeTCwJd7EsL1bMnCb_v6fT_v3Wi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:48:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id af89bc07 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:47:58 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:48:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 24/29] builtin/merge: fix leaking `struct cmdnames` in
 `get_strategy()`
Message-ID: <eeef280dd5f17716ad7c4c975dd26ce957a78c52.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u2ut7jCGrk2qZHhi"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--u2ut7jCGrk2qZHhi
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
2.45.1.410.g58bac47f8e.dirty


--u2ut7jCGrk2qZHhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkWMACgkQVbJhu7ck
PpRKug//drQAZV0PMkoEVBZ3mVzr0c7ENrlgSbYge4UOUgUCfQdViw+lvoC7BEmj
5PpLh3FPL7Cb3HLPiJvOobRytGrOrhX90rZD5FB5Xa7cYIgPdPF5dyW3I7VPSmQb
k6CIjgce8tlroW6v8pC5HfyaZua/GxdngVzHKgkAlBMnzDW6Ig+61fuC474PS54M
Lgd4cV8aAV6gafTQHx/W/8sJ58yioP74kbaMZr4LrxHfm2iSxFztDHG0zTMZItdK
8n5qI8aMNz5kesnB5ijJxxDreqn6eJOJ51sEDTj20DxFyBmnYLfCbx3UjPFA2C0D
e+7otd9p6KYkPITySaOzZp5HRGuevIy81ijqlj7aJ14neVpisWeTW2hgYKFpqi/5
x528bzl1dYU+hOxoHUkYDfXVdowmbfcjASByNDg23pH+fFvb63swaz/rpcje7WIQ
bU2E/Gcnq1m6XhTJcmUnDA9EZepbhpAjKF69lpI619ectXE8WacDCjianYbYz8y7
t65AQk/3ouHDDqYr5uJkW5pBDSOZJ5TdC3/P6lUcgjsHOisWglWWpjT7QPPd0iub
CqsHQ1fwbPQT3fIkHY2NndDcQCIXc8OWkLiGPdONvW8NDTb7GHsgYRyu1dX4jwN2
OmjzD8CIq/AtAdezfjWDHQJJlnlzcSRkl7r3aRCtA4yeOk4uhz8=
=ESw9
-----END PGP SIGNATURE-----

--u2ut7jCGrk2qZHhi--
