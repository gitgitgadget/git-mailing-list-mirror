Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC68376EC
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759198; cv=none; b=JjWiPmbOitfnX9/GYMFakVHeRu9vCVBtWpLRQSbS5pURK2sjlDq6wOcGafIl9h5MuiztQbLv2IC5LNj+uizGdtKhOlbZEoon/iyP1xfNZSSKbPsu4wRH7UKbicAQoBdwCKMiQmw7tjGuCJ2dufigMSeUqxE08bM6zfE92T8EJBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759198; c=relaxed/simple;
	bh=xim6e9zk5yD8yB7HbU9Hg8g7oidPF3zorQnNwdjg6Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2wtPTRSh3XSfYT1WBp4MKaRV7a3z8iLT/oCnmaMJzbGu7EuchyfdDaSyLMs7ef47WT9ey5UI1d4efJuKPfNHM4xJGbRt9NCJ72F9E5mq2V1adBLvmuEPE5MkYRIppFwmNcmHRJeF+YX4ANyIIUwAgis5lmZubV2RVyG3jAd9DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N5VMLHey; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U2xiKl27; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N5VMLHey";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U2xiKl27"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id D946313800B8;
	Mon, 18 Mar 2024 06:53:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Mar 2024 06:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710759195; x=1710845595; bh=KFrt4V0XpV
	jNJ5VgIdrBlUv53iRXlnUuNtyTcu3Z3nA=; b=N5VMLHeyvKuixCSbYufqsE8YNe
	0DLNgQzlo4rS+QbWcR+vWk4eSqy6omUtIxCCz8Gn7iCn4HTBKFUIa7l0udZQIW8o
	KBgejwmFiNyY8EOLmJfMDVXqJi/SKCWOz2wuWalYUP4Bx8itIB6lZkJExBFbnd8r
	Lb+Lhmkm/Y2QiVlp5w7fnARZ8yOd2TI/0Mbz98FJqd32dH3VFl1DV9EyNLl1eC3M
	it0pAIYy9X+7s/tuYwrfbjVrEorqZtyUWDIzNUTxxjB/7UuT2Fqg5ZNSTuwSzNIO
	MehYdmINriY1r7CyDGysikSN5bbc59KAezA9OgZbDUV2IqZVInUWtzxaeUTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710759195; x=1710845595; bh=KFrt4V0XpVjNJ5VgIdrBlUv53iRX
	lnUuNtyTcu3Z3nA=; b=U2xiKl27ZA5aDoW7+C2ObkxkkXdqiyRsE1N5YenqpY45
	t2HzG5eQ1Q1vBcCDs3V0gJ/97wcaR43fakldTgk0EU+l4MZFqCxYkqwr+kAzlxoa
	4KRWf2ootb5oGf5xIw2X4IVAp2XZaPnSRPdzWBAPcnUPygijTfedR0i08nzR/Rs1
	W7+He0/kQh2hV938TMAfG31DNFOsEBCC5xkokzoXem89Lw0etSh2jV9oCg8YcbQk
	mABhaBT5GvaB35rPUrk+j0OlhRr+k1mBZ7Nshc7jkrTAilRrmWsorQV9jZdIxvpt
	iJ5RaLqwoaOj5OuIHtj7Aj3xr3Ajbl4yslu69TYW1w==
X-ME-Sender: <xms:Gx34ZVdMxSQ9qLoMTwzddPkgFCR3ybyRfymmqEZD8dNpy9LY92KoFg>
    <xme:Gx34ZTPHwQTJwyHHc7DSJz0zxMA3CM4o_p6o27u_82NCP_uDCIxLzfworfG5FRZqc
    G241HhZiZeoVCZtWg>
X-ME-Received: <xmr:Gx34Zej63fNML6A-YNEDDl4TNjWUuoiks9Cu6xIeDO1ob5dTGpDpGEvCVK3W4zF-D_GGbulrVdmKkORYw7oM9X-sb4RiXCTxJuXVilKCUrGU9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Gx34Ze-wsweETx3aCzOhO8pLuW5ePb8kDdzlPd60jITGDeAit11IeQ>
    <xmx:Gx34ZRvUEFM5oIZDlzlwOfCO7X8ibBVBaE6hO6LHa3RwzdDK_FfQ5w>
    <xmx:Gx34ZdEthfANZDJIctSTX2vrr8znaAJcMjIw3mwq7UnULAQnW8LsgQ>
    <xmx:Gx34ZYPZJ_0OJE8yllxSfqWGthzXJp2icc_FBWp6XzB4TCSKkxpvMA>
    <xmx:Gx34ZZIcfQy8Amcg9e4jx0Kdf9_aU8o0zD2wqxjcvLK7LU8l0b7AtQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 06:53:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 294c562e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Mar 2024 10:48:24 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:53:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 11/15] builtin/pack-refs: introduce new "--auto" flag
Message-ID: <8727f08bab8459ca608915a6320c817711742a87.1710706118.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SNdk4uwO/G0VisGs"
Content-Disposition: inline
In-Reply-To: <cover.1710706118.git.ps@pks.im>


--SNdk4uwO/G0VisGs
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
2.44.0


--SNdk4uwO/G0VisGs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX4HRgACgkQVbJhu7ck
PpRXdA/+LcfO3eifWwavcGiQrOKwlpPjnI9ZNWLdbD3lI3gIOgRUjHa2oQvcEQEn
mtBeWm5rKwUgU9BBynrcIyoxIJwmPgUN8/hXeN2FQeo9YJZ58yccnCM26TXZVxRc
MmvO7kBrZ9+u/Pxx6caCDrPLBiSaogARqI1Ozz0UXqUo6d9ovbcoc046Bl5ESojw
jH9kF2AcOql9bWCfhzQ+2l47MQ/wvQEyYyhb8mrcGq4x0oEJ+3cL/vcGRB/rF9pM
kotorurJ2sTo2omwnPMWN431f0HSHqw7RokUspF7eq/MQkpW17oon6GhNomFfH4C
d7+qcXQgFjo5IX/ve/DllDbdWx4qa/CHp1EqVbe66Hk3iBPrfmOA0Um68yAlDRCZ
lPDcx/skvqHEhQf5so4bkDUKcUbfYqOcbL+y2aafa/0vbLPtPDH6D9SRyKwajk1I
WC9Ll81RoGPkbvn7j6wb9PbwWhDjlYz6EJ87UThWXZHOJcgbDsfNGFrMjSGoH90N
rDf9MVw0L2JAtZqI9Uk8rpPAmAuPP/ngcrAWVNELxRkwuZZ00yXOKzfcicArLjVm
9J2IIQo+AdxCl3G5FqrJz09ZZm3GSIdEqVhcClHpNOX5StoDVl/nfpivAus4Tfwa
wB0kF54eaPK5GIwn2UMUJg3q8NARgo7Nxf5ePzzPFC5lR5kNnyM=
=VhSW
-----END PGP SIGNATURE-----

--SNdk4uwO/G0VisGs--
