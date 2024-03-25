Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072F7157A65
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361005; cv=none; b=eAoLTQm4XRsYbjJJe8RZsWkNOapRb/sKc/6c4QGFAmz1UDHjL16VW3jzfho7L453h63nkC4C5Sahwo8rQbBB4zzcl35GjX1TwEIjft8f5D2+vSxJgUaOewc6P6cjpOFEmGGCaHaWAj7/KuVaRk2kXESsZhDBmEZjbtGqJwMAuys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361005; c=relaxed/simple;
	bh=gXrTSO17S441FzVQQVFduhzayVPW5LYYv3IVBx4ofaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQHtVbBSI5pw8GaNiy2HUi3tB1HE4RiKWMEp9Ic3DWeMrwE6gb5xBK6ucOBs2iorjUAFYfXoUHDKKpyP2DqNqJtKzbKXQRSZrY8WT4N2ZwZu3IB3L3zJETD2j2dC6ChfvRCodUgE41kK3XSnFvehRQrqzDeD1opA3bCThz56d6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VUdVkIsr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GgOH1v5m; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VUdVkIsr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GgOH1v5m"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2AE3E1380083;
	Mon, 25 Mar 2024 06:03:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 25 Mar 2024 06:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711361003; x=1711447403; bh=nOHTcM7vJ5
	r6Vre8Ag4Y2AEW5xyggp4/uXmSQcYUkoE=; b=VUdVkIsrSqwfCCGe4ld8mjVpUK
	BuCF6wiJQnhylYEsO00g8vkhiNTStrzdCHi+gjij6YXEW4qobYWbX1xJ+U5yFQaa
	IfWv3Hh90jvL73ulcc15Rso3QuiJLyQP+HGLx6IxQi5UDs+0XC9nrgoz4IZB7ZcM
	MeoXrLOKDeHSivzMG0x74pVohmG3MotsJxGK9jtFGcIvE5wSLZaiMozhC47sgw/y
	MuirzmekVI0GE2QC6H4wkXu72P+xivupITSQOOT0Ut4Y+cvKpDBy+Uy1FMjTLnGR
	AnaMJs5E1NMmmqd0PwUX0sjtPpUZiNkOjnWE46ZmgzyAr3/1Pq1E25k7+Wqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711361003; x=1711447403; bh=nOHTcM7vJ5r6Vre8Ag4Y2AEW5xyg
	gp4/uXmSQcYUkoE=; b=GgOH1v5mDnmmj6CjJ2fIWoNB/h34hNheriv8c2GPbxMJ
	0KUPMiwEvV7SYACWLXjdOUESikPaQiEogq0NtPMYLsMAJ08eqZlvhaEAf1xj4jlh
	TXDR7cHgboil3eq9OT9D2GJ9+aKbNWE6zB4vpAXHAeR4tW7JIBN+XkuJih6M7Uda
	tnOn2mmaKvHJbgHFgQrmdRE88M/ZUL0KMjz8pdAuQ9VYf7PE4Q4Nm3ZMNNqR67qH
	sXbrEikJ+WTcM2sLvrkjVBt3LA3f9off9ad31r0w7BaY5hmiJjzzMCXT9HEjsax5
	JySMnVI5n439j6+/TFIOzRbI4DQd43ouX7wIw+zqDw==
X-ME-Sender: <xms:6ksBZiOiF7bZcgUnOdYbg8vcUFQtG-9sDIvQQslgEMohUIEdnHTNhg>
    <xme:6ksBZg-X9d3b7vXAak-8nRsx9MQIl-TCEbDd0Zm6tkhb8osL1XkP3HfQ-lIuAGoqa
    OPsAZIw4_jsb4hbJg>
X-ME-Received: <xmr:6ksBZpQjfWL_TUyfxVyqPppBRU7UIKztT5Nm8Rdp_B_CDnBM1Woi3GhcSs2Aw3nY1sa8cmKnxz61T8RhJSs-X5S1t9ETiZr_pqvUcP_B4iuyew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:60sBZiuKksb3F4kYGddbju2K6rerzoSjUqxrr_HCCft2PyZJbuKqfQ>
    <xmx:60sBZqc6bxomtP64UleE2NmIO8B0cm6hMNg2sQrOYvQ3CA98kuah2g>
    <xmx:60sBZm2f6JRr5NNf3jXTQ_DbFQ4HRHzzjDfShdbkVqBfOJYJTN7i_A>
    <xmx:60sBZu9gYVe2P4UEk4gpQ1SQGSXroITX7b4H6bY1A6by1MEdiLTlvw>
    <xmx:60sBZp5-PofdzPUzOU2f1C7j3YFcUjy8GUIFOZbK_MytSsqgNywZHg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:03:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 06eed119 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:03:12 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:03:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 11/15] builtin/pack-refs: introduce new "--auto" flag
Message-ID: <eb48ac0329fb23fd781fca8cc421ea3e9bf781a0.1711360631.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
 <cover.1711360631.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pJ1+UEKnCsmps8//"
Content-Disposition: inline
In-Reply-To: <cover.1711360631.git.ps@pks.im>


--pJ1+UEKnCsmps8//
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Calling git-pack-refs(1) will unconditionally cause it to pack all
requested refs regardless of the current state of the ref database. For
example:

  - With the "files" backend we will end up rewriting the complete
    "packed-refs" file even if only a single ref would require
    compaction.

  - With the "reftable" backend we will end up always compacting all
    tables into a single table.

This behaviour can be completely unnecessary depending on the backend
and is thus wasteful.

With the introduction of the `PACK_REFS_AUTO` flag in the preceding
commit we can improve this and let the backends decide for themselves
whether to pack refs in the first place. Expose this functionality via a
new "--auto" flag in git-pack-refs(1), which mirrors the same flag in
both git-gc(1) and git-maintenance(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-pack-refs.txt | 15 ++++++++++++++-
 builtin/pack-refs.c             |  3 ++-
 t/t0601-reffiles-pack-refs.sh   |  7 +++++++
 t/t0610-reftable-basics.sh      | 34 +++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.=
txt
index 284956acb3..2dcabaf74c 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -8,7 +8,7 @@ git-pack-refs - Pack heads and tags for efficient repositor=
y access
 SYNOPSIS
 --------
 [verse]
-'git pack-refs' [--all] [--no-prune] [--include <pattern>] [--exclude <pat=
tern>]
+'git pack-refs' [--all] [--no-prune] [--auto] [--include <pattern>] [--exc=
lude <pattern>]
=20
 DESCRIPTION
 -----------
@@ -60,6 +60,19 @@ with many branches of historical interests.
 The command usually removes loose refs under `$GIT_DIR/refs`
 hierarchy after packing them.  This option tells it not to.
=20
+--auto::
+
+Pack refs as needed depending on the current state of the ref database. The
+behavior depends on the ref format used by the repository and may change i=
n the
+future.
++
+	- "files": No special handling for `--auto` has been implemented.
++
+	- "reftable": Tables are compacted such that they form a geometric
+	  sequence. For two tables N and N+1, where N+1 is newer, this
+	  maintains the property that N is at least twice as big as N+1. Only
+	  tables that violate this property are compacted.
+
 --include <pattern>::
=20
 Pack refs based on a `glob(7)` pattern. Repetitions of this option
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index ea2baeec76..db40825666 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -7,7 +7,7 @@
 #include "revision.h"
=20
 static char const * const pack_refs_usage[] =3D {
-	N_("git pack-refs [--all] [--no-prune] [--include <pattern>] [--exclude <=
pattern>]"),
+	N_("git pack-refs [--all] [--no-prune] [--auto] [--include <pattern>] [--=
exclude <pattern>]"),
 	NULL
 };
=20
@@ -28,6 +28,7 @@ int cmd_pack_refs(int argc, const char **argv, const char=
 *prefix)
 	struct option opts[] =3D {
 		OPT_BOOL(0, "all",   &pack_all, N_("pack everything")),
 		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default=
)"), PACK_REFS_PRUNE),
+		OPT_BIT(0, "auto", &pack_refs_opts.flags, N_("auto-pack refs as needed")=
, PACK_REFS_AUTO),
 		OPT_STRING_LIST(0, "include", pack_refs_opts.includes, N_("pattern"),
 			N_("references to include")),
 		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index b1cf587347..219a495451 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -164,6 +164,13 @@ test_expect_success 'test --exclude takes precedence o=
ver --include' '
 	git pack-refs --include "refs/heads/pack*" --exclude "refs/heads/pack*" &&
 	test -f .git/refs/heads/dont_pack5'
=20
+test_expect_success '--auto packs and prunes refs as usual' '
+	git branch auto &&
+	test_path_is_file .git/refs/heads/auto &&
+	git pack-refs --auto --all &&
+	test_path_is_missing .git/refs/heads/auto
+'
+
 test_expect_success 'see if up-to-date packed refs are preserved' '
 	git branch q &&
 	git pack-refs --all --prune &&
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index a53d1dc493..6de7529575 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -387,6 +387,40 @@ test_expect_success 'pack-refs: compaction raises lock=
ing errors' '
 	test_cmp expect err
 '
=20
+test_expect_success 'pack-refs: auto compaction' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit A &&
+
+		# The tables should have been auto-compacted, and thus auto
+		# compaction should not have to do anything.
+		ls -1 .git/reftable >tables-expect &&
+		test_line_count =3D 4 tables-expect &&
+		git pack-refs --auto &&
+		ls -1 .git/reftable >tables-actual &&
+		test_cmp tables-expect tables-actual &&
+
+		# Lock all tables write some refs. Auto-compaction will be
+		# unable to compact tables and thus fails gracefully, leaving
+		# the stack in a sub-optimal state.
+		ls .git/reftable/*.ref |
+		while read table
+		do
+			touch "$table.lock" || exit 1
+		done &&
+		git branch B &&
+		git branch C &&
+		rm .git/reftable/*.lock &&
+		test_line_count =3D 5 .git/reftable/tables.list &&
+
+		git pack-refs --auto &&
+		test_line_count =3D 1 .git/reftable/tables.list
+	)
+'
+
 test_expect_success 'pack-refs: prunes stale tables' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
--=20
2.44.GIT


--pJ1+UEKnCsmps8//
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBS+cACgkQVbJhu7ck
PpRNihAApxImWSrLM0ppmy7sgAhTUG05UVZa0hvASV3Try4cTDlXH8PUEgSKyPfb
8mftjZLFjdAYM4OsFt4FrFXTnvYylD93oyiMQM3CJKZxpITPmhmEFlo/uxTP5MDo
f9byx4QmMVdzMrW/nStf/UgiNOhJmMKLWAEOZPOdg6J3P0jyTj/CCzHPO4vmBrJW
wVbmU98V70qpsXm1TkpoC/+dgZ+CtfdMdv8rx6TKSBti5kYV7rtkr+b8Y9TIhaaM
hqfVIi2YB4hEowrHFEdBxzhjX26srmrd1RSFLTO30HWP/kfQtekPVS46X+xpU1oS
vbhEXP8vvqwqrZm1S9Ygdb5SRlwMZ+6l0nscJojDQ2vSqO1RghfdN7MQ+lW9izsA
0ayY/t9z6N40Njgoh80JBWUgb+ExH1xVWxxPku4UiC3JPS/R8DWAxykhLz20qsHQ
u4TVoL5BzeufIBzqVODdQNroTYcUd2e5pXUIbPqMwD4XuRJuyORSWNFoHj8IrHdV
ly7TxDoPkIgFSVA4RzTmQxQQA1hP5eGdpQnEe4Mn02Z3EcHYC57ZORBYs6IQstvu
3AMX1PDwiiDtYnfQ3zcTLFPMrLYswI0zyqXal4mBCJTBY9la0DtgTfg57yoqRUls
JYbq0/uV18qP3OJnUpSDJrfVsmAGyw09378+bBtSV+x4IFW9cj4=
=jMfi
-----END PGP SIGNATURE-----

--pJ1+UEKnCsmps8//--
