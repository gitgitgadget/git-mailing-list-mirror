Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43913C8F7
	for <git@vger.kernel.org>; Tue,  7 May 2024 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715070449; cv=none; b=ESZO3gavUu53dOQnvY+l5KC6aI7KVOZs9JzZId/8nrOqX0x3q9wBCFBO7jinYdT0OvAif16An8O8aDGY4+sJOK1PRpM8fMiLd0UEfsSdbxk3u1xXBD+dyY2NtRdDAG2pRJhlJF7ZcebE8q+sg/HfU911J4c6KzJ3gKEQ2KKn158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715070449; c=relaxed/simple;
	bh=Aq+tPY1YccSe1VhRg4VV6AiqYIgBTfvOrZanEPcwe80=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Rl+70TiDzHzKLmYYNfdv9pEuEkiCSIB1nyLsfKULEQRQDtl4jiDP5sIB2UaNYYqecmREW55cfva+cAtu38Z8FeAHYw7syL6xomRfP3vmqoMug/1FDo5GoMeAk28oCbf4Z+Qd6eEWh6V9rCk27M7tkiHcVpY98EoKuVntx6jW5vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PUSB99cT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DEgRCZ/7; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PUSB99cT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DEgRCZ/7"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id A3A051800149;
	Tue,  7 May 2024 04:27:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 07 May 2024 04:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1715070445; x=1715156845; bh=2eu2tdWERX3hR35LVUBeeFUicIZhfDDw
	1IF1IWkmpVU=; b=PUSB99cTF3sAZTQ92PHBSIDdHiKx3rlw7iQZYP7Et6x17Z0o
	yjGfzPhOdHjPAypH9DnkMK4n+COFfNDygQB1I8c4IUqSkD6jRqya7h4JKkhZddj2
	TJCbzsNHZl9YGsSaV97d86Dkb7ahilj5RfMaYLNvdRZO7NAw83T7TCdX5feBIYF6
	6C8pbU0awNZIV8kHMdYe86cImdiXXV8V99yjfYqvLNpy5s7hcPcO6hLsupqkAaqq
	P8QiCMkQ60RbMgIjTyc4YvhYtHlHWQytjewYOKVu9ZAxcoWv4ONqIWnUy6CDgCgM
	Eh6vhZVcFGM+QcX0tCkdmHDGe1qwU9Ef6/8bmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1715070445; x=1715156845; bh=2eu2tdWERX3hR35LVUBeeFUicIZhfDDw1IF
	1IWkmpVU=; b=DEgRCZ/7Qk27E/wsVS4Synk9HLd/YpuelqSBZgiMVSfFcZa8YKJ
	SsvlHRQ2/pi5dhQEtQXpqY7d3M3/d9rVEhIAZ3g6+wSSMkzWWrfYsegAwSrLAkKy
	3Rp8Dd7J2IhkRrJqRiv6llCL1jEoN2ZOHxoH9tdJOssDvygfG31oYdYlCLOumcb7
	prMhajXf4Ur4Di4fyie5AsiGUXI9D8W70R+z2iwbJcjcoot3B8nh5+5bNbE3lioO
	xrp7Z70XeWxcpr74ZzK3y1o7FJzkFZxU13QV9mwr99XxnLs/X5GDqpwLv2KsGiFx
	Fy7yfrYPlkBeUjGSnVQaLr1OlEjYHrlwurA==
X-ME-Sender: <xms:7eU5Zi0qG5TeLJVkCrCafqNJsPAvKhTerAx5q0SiC7RSwmnAHeI7MA>
    <xme:7eU5ZlF_56ZG6_bPRpeA-7_IFMogRBpOLPSC8LbjrCUjQXHkqZdNPX1JLTkvlFg0p
    5stIz0OeLWV4uNoLg>
X-ME-Received: <xmr:7eU5Zq5TAKG1aMGl4hP6ApZ2VgUah9OhK4BYAxG3I4yWleFGZ8R-ZQolqN7u2bpd_oGAUFi0rBGOroZdD9Ffz6HwYX7cN7SXhjgheY_7HcwSBDvwxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvkedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefgedvveevuefhvddugefgieefleejjefgle
    ehfeduffektdduhfetteekheeftdenucffohhmrghinhephhhtthhpuggrvhdrshhuphhp
    ohhrthdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:7eU5Zj1hnSW-oK7aHD2dWmFjTalGnN24qtGw-TSK1zBBenLpctxnoA>
    <xmx:7eU5ZlH53i9c0lLdw93sEJY9TPqyRewlx4qDnDuKkjlNHY91S2db9Q>
    <xmx:7eU5Zs-JgUtev7abxR_ob6faJf-cvef8Lu6b9BJ7w2KABc8v0aAZxQ>
    <xmx:7eU5Zqk4aYdrIcoLJbEp33E4TF1XsD-Z6VsoR2R2ya0UH_PS528P8g>
    <xmx:7eU5ZqR_F721Cv1QeY5JmvaSbfWwRjVZ1RDep8g_1A8ImotJohpLWp5Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 04:27:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a7ae04d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 08:27:13 +0000 (UTC)
Date: Tue, 7 May 2024 10:27:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH] docs: document upcoming breaking changes
Message-ID: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9GlsHonTkc2HTDxx"
Content-Disposition: inline


--9GlsHonTkc2HTDxx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Over time, Git has grown quite a lot. With this evolution, many ideas
that were sensible at the time they were introduced are not anymore and
are thus considered to be deprecated. And while some deprecations may be
noted in manpages, most of them are actually deprecated in the "hive
mind" of the Git community, only.

Introduce a new document that lists upcoming breaking changes to address
this issue. This document serves multiple purposes:

  - It is a way to facilitate discussion around proposed deprecations.

  - It allows users to learn about deprecations and speak up in case
    they have good reasons why a certain feature should not be
    deprecated.

  - It states intent and documents where the Git project wants to go.

The document is _not_ intended to cast every single discussion into
stone. It is supposed to be a living document that may change over time
when there are good reasons for it to change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

Please note that this is explicitly marked as a request for comments.
The proposed list of changes is neither exhaustive, nor do I necessarily
think that every single item on that list is a good idea. The intent is
to spark discussions, so some of the ideas on the list are controversial
by design.

Further note that this is not a "Git 3.0 is around the corner"-style
document. I do not want to propose that a breaking Git 3.0 should be
released soonish, and neither do I have the authority to decide that. I
rather want us to document deprecations such that users, developers,
hosters and distros are well aware of upcoming deprecations and can
either speak up or prepare accordingly.

Also, while a minority of the proposed deprecations does have links to
mailing list threads, the majority doesn't. If we have good discussions
to link to I'd love to add those links. I hope that some of the items
will spark discussions that I can link to in v2.

Patrick

 Documentation/UpcomingBreakingChanges.md | 65 ++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/UpcomingBreakingChanges.md

diff --git a/Documentation/UpcomingBreakingChanges.md b/Documentation/Upcom=
ingBreakingChanges.md
new file mode 100644
index 0000000000..94d77a8af1
--- /dev/null
+++ b/Documentation/UpcomingBreakingChanges.md
@@ -0,0 +1,65 @@
+# Upcoming breaking changes
+
+The intent of this document is to track upcoming deprecations for the next=
 major
+Git release. It is supposed to be a living document where proposed changes=
 and
+deprecations are up for discussion.
+
+## Git 3.0
+
+### Changes
+
+  - The default initial branch name will be changed from "master" to "main=
".
+
+    Cf. <pull.762.git.1605221038.gitgitgadget@gmail.com>,
+    <CAMP44s3BJ3dGsLJ-6yA-Po459=3D+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>.
+
+  - The default hash function for new repositories will be changed from "s=
ha1"
+    to "sha256".
+
+  - The default ref backend for new repositories will be changed from "fil=
es" to
+    "reftable".
+
+### Removals
+
+ - git-config(1) has learned to use subcommands that replace implicit acti=
ons
+   (e.g. `git config foo.bar baz`) as well as the action flags (e.g. `git =
config
+   --unset-all`). The actions will be removed in favor of subcommands.
+   Prerequisite for this change is that the new subcommands have been out =
for at
+   least for two years to give script authors time to migrate.
+
+   Cf. <ZjiL7vu5kCVwpsLd@tanuki>.
+
+ - git-http-push(1) can be used to push objects to a remote repository via
+   HTTP/DAV. Support for write support via WebDAV is not in widespread use
+   nowadays anymore and will be removed together with the command.
+
+ - The dumb HTTP protocol can be used to serve repositories via a plain HT=
TP
+   server like Apache. The protocol has not seen any updates recently and =
is
+   neither compatible with alternative hash functions nor with alternative=
 ref
+   backends. It will thus be removed.
+
+ - git-update-server-info(1) generates data required when serving data via=
 the
+   dumb HTTP protocol. Given the removal of that protocol, it serves no pu=
rpose
+   anymore and will be removed together with the protocol. This includes t=
he
+   "receive.updateServerInfo" and "repack.updateServerInfo" config keys an=
d the
+   `git repack -n` flag.
+
+ - `$GIT_DIR/branches/` and `$GIT_DIR/remotes/` can be used to specify
+   shorthands for URLs for git-fetch(1), git-pull(1) and git-push(1). This
+   concept has long been replaced by remotes and will thus be removed.
+
+ - git-annotate(1) is an alias for git-blame(1) with the `-c` flag. It will
+   be removed in favor of git-blame(1).
+
+ - "gitweb" and git-instaweb(1) can be used to browse Git repositories via=
 an
+   HTTP server. These scripts have been unmaintained for a significant amo=
unt of
+   time and will be removed.
+
+ - git-filter-branch(1) can be used to rewrite history of a repository. It=
 is
+   very slow, hard to use and has many gotchas. It will thus be removed in=
 favor
+   of [git-filter-repo](https://github.com/newren/git-filter-repo).
+
+ - githooks(5) can be installed by placing them into `$GIT_DIR/hooks/`. Th=
is has
+   been a source of multiple remote code execution vulnerabilities. The fe=
ature
+   will be removed in favor of `core.hooksDirectory` and the new config-ba=
sed
+   hooks.
--=20
2.45.0


--9GlsHonTkc2HTDxx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY55eUACgkQVbJhu7ck
PpRzaRAAkPBtjm72p67pPtCcodswvjuqlBKqnIQCokeEFqpLcgHyA9Ww+d7tEIEr
qABskVdSbRAjjvsQ+Purr+f+ZtPjfNemYkplPSHG9ZZztJMbglSOgSqO5JVXlcTF
/tAHlLIq3A1l+bAZ5jOddRF23UWOIx9/sn4injgVLpqtdK1ul7IYQQ+gsAUiJLw6
T+ukScXXLrzDQgT5Ftjhc8GyNXOx6xPB03cEkcv2GsCO64ymKe80keRvfTYMwlNX
3KpCS3HegJOHQVK49BE3UwypySF6E/EbJzQcDUy1YR/1bLsHW2BaQ1Ob1XZiFt8C
vhl5UanTHsBf6Shuo+iAM9apJ1qG+1ekO7XK2FOLvscgozgNQqxq7LDnAqrd29Ss
ySOCpuQUt184SqU3k0iz1dPXw56dNJk2CRAQCJHFWOYo3KvtM7bkEQmlroQ5QKB9
gzpNECxdjl6vwCxjQCgqSkSfvEk2MsyI7ktUVORPM6HBM/6Yi/D2YQacx2lvjzpf
KY0nLIAoqBqyX1A7u5wiMqR/SFBV2O3ooYzySpLb7c7zLt+qT9eFv3a3IrNJJF2Z
fouwIvWbRUyslmWRwCoGd67rFvouzlYlQacKZYT2FJ/XwjRGQgs+Ri4tkIRWRcIl
L1nHyrxn2xRs7rXFOFUZXH7X9O1ZnubKvtf1YFEvEIdXEcRxVZE=
=Q5mJ
-----END PGP SIGNATURE-----

--9GlsHonTkc2HTDxx--
