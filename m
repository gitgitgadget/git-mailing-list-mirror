Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517733BBDE
	for <git@vger.kernel.org>; Fri, 24 May 2024 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555297; cv=none; b=C2lL1ZLxM36KOROF4LKL0xKuZbflpXr+DBfnt6NR3S78PcUb1T4MRebMTcpc0SYGB8YKjNFLedMTqEF20ewv5vB5QrqlAV4ft3YC69YV6XggJlhnnO3Dkm0Pif64XQ6lTTm1zVOoJCQfukPr0K5IpEek5eR5Ww2EmTLJdpaWKJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555297; c=relaxed/simple;
	bh=4Fo4C5d47HUoNXbKGGpAbztYH9jJHK3FGBzWxU3TIEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyYC/jdEhTyohPJSBYKd+6RlkdqPWTSvsAppFtcbssVtBBR+2x0nvOhkbh+mzvhpJLZuQ90t5k9WiZN5SrNimk8zhV5BxNxMv1B5J8fkYNam/rDJ/ry3kxqOAqPL3603dXR2q2Zkz0nhqvQ8r2vdqXmmrlnqJgI4w89TozS+/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RB4iUDwz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fMnZEq7v; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RB4iUDwz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fMnZEq7v"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6F21C1140157;
	Fri, 24 May 2024 08:54:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 24 May 2024 08:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716555294; x=1716641694; bh=vAzRRMpSzA
	eZXdlFyOvGA8l0XXqSPumYIbB89D8QZck=; b=RB4iUDwzoE63PsNKDVi2jXiw4/
	cD7//61BQf3JuUHqFMgUQG3KAmQMoMzLoej0S05DW1Vu+3n3SZAFRY73tmkBoySR
	CB1dHBz1LPIARbQz6kObzjABLsvDEKVOLzIVRDcI+d5QwftXmw/JrrTDZjL/0MM3
	VKBgfgbRnIqKz4ILu7haKtO+Y0GuhiOh/LRdQn1KPn2w9QDy91UHKOT//oTQFktb
	7lNnV6EFN3yXB0tAQoF/Nj+Pt4WoNS7/lxT7UQZx2aGHgQSxwzXd5xIbReNY0swz
	gk50VxnNt9Ssai0rqNjhMK8wO1sZQ3PFm6Twe63CqCp4nt7rUBeey4rdikAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716555294; x=1716641694; bh=vAzRRMpSzAeZXdlFyOvGA8l0XXqS
	PumYIbB89D8QZck=; b=fMnZEq7v1CHnKvwC1DGcB2Fb12JRQid2VrHf5mFdwwDp
	CVyf9cjjiXSqNI2fM+RfyYjmCNExTxscY++S6sN3y8j4HiuRQneZeXNieUgO2Tc6
	lcvPKk6G+GhB5RU34HLIBsYxd+4PXzrWvAbyJRpCL79kHAZDDsQozXQI1QDBtnSc
	J+OKsfgmtzgRcQYXdlOTUFNLQthQfdd30Hd5oCa6rzcwgrgzznyfvqkZ+i3uraLO
	14aC+9PeyhL9PJeZfv8lhOKTxBwqM5xMvxxrLdXxTGirg6fzDD3x4uxlsMj3Mp41
	ZP+2Xa0GPcWovLecrnjA9QJmulu3lLGtiX0JAvbJ4A==
X-ME-Sender: <xms:Ho5QZl3QJTjJr5K6hhyk5_edvnjJhNg1P7pmtPvWR4PMkNFtzit2LA>
    <xme:Ho5QZsFh_-Tjb7WyoVonZa8xh4rxuFUfpU6yICrerkoPif2CLQp7i3Rke-K6xCPQE
    yOW37FpE_F4pv9ztg>
X-ME-Received: <xmr:Ho5QZl5d3GV_SPF2lVxAmTE_-mzEl07ba2WnipwybyUvuWR1tloyH7IKv9p4HjowTWMqkpWOefYhhI9A2dBvVcvaHiQTEaQWOLJRGKaqC7i81vM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhephefgjeeigeektdfhffeuteeuuddtkeffheejgeefjeeigfeivedtgfffheefvdel
    necuffhomhgrihhnpehhthhtphgurghvrdhsuhhpphhorhhtpdhgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhm
X-ME-Proxy: <xmx:Ho5QZi2hQTaQCfAYr_T6hkdeACG_wICu3JmXZSutJpYmOzKbxbY4Gw>
    <xmx:Ho5QZoHSf-hDKcSE4EkMvlnSyAtXk_xOR57fmgkDBb2QK-y2tPot2A>
    <xmx:Ho5QZj8jX0PQPaftGmml_mBZgvkGZyDTh6_RGHQ5G0qxufhrxFQEPw>
    <xmx:Ho5QZlkt3rsMru6mKr_kBitJHOetr337XDUGRgVfQQcmNlI8Ggdr-g>
    <xmx:Ho5QZj3eeMHXcA7Q_1bqmijaKp3dJoT6wkE0Pc6meRWk2_r5TdBbtIPW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 08:54:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f908071a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 12:54:47 +0000 (UTC)
Date: Fri, 24 May 2024 14:54:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3] docs: document upcoming breaking changes
Message-ID: <84c01f1b0a2d24d7de912606f548623601c0d715.1716555034.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MF9fncQUQVmvhzJ5"
Content-Disposition: inline
In-Reply-To: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>


--MF9fncQUQVmvhzJ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Over time, Git has grown quite a lot. With this evolution, many ideas
that were sensible at the time they were introduced are not anymore and
are thus considered to be deprecated. And while some deprecations may be
noted in manpages, most of them are actually deprecated in the "hive
mind" of the Git community, only.

Introduce a new document that lists upcoming breaking changes, but also
deprecations which we are not willing to go through with, to address
this issue. This document serves multiple purposes:

  - It is a way to facilitate discussion around proposed deprecations.

  - It allows users to learn about deprecations and speak up in case
    they have good reasons why a certain feature should not be
    deprecated.

  - It states intent and documents where the Git project wants to go,
    both in the case where we want to deprecate, but also in the case
    where we don't want to deprecate a specific feature.

The document is _not_ intended to cast every single discussion into
stone. It is supposed to be a living document that may change over time
when there are good reasons for it to change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

I've dropped the RFC prefix of this series now. I think that the overall
idea has been received well, and folks are supportive of documenting
upcoming breaking changes.

There's only a single change compared to the second version. In any
case, most of the proposed deprecations didn't get much pushback. I'm
less sure whether this is because people didn't look, or because they
silently agree with what I propose for deprecation.

I'm going to assume it's the latter. If you feel otherwise, my proposed
way forward would be to drop most of the items, merge the document, and
then add items via separate threads where we can discuss each
deprecation on its own.

Please let me know your preference!

Patrick

Range-diff against v2:
1:  8e268a291b ! 1:  84c01f1b0a docs: document upcoming breaking changes
    @@ Documentation/UpcomingBreakingChanges.md (new)
     +   They have been outdated since e650d0643b (docs: mark info/grafts a=
s outdated,
     +   2014-03-05) and will be removed.
     +
    ++ - git-pickaxe, an alias for git-blame(1), has been retired in acca68=
7fa9
    ++   (git-pickaxe: retire pickaxe, 2006-11-08) and will be removed.
    ++
     +## Superseded features that will not be deprecated
     +
     +Some features have gained newer replacements that aim to improve the =
design in

 Documentation/UpcomingBreakingChanges.md | 122 +++++++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/UpcomingBreakingChanges.md

diff --git a/Documentation/UpcomingBreakingChanges.md b/Documentation/Upcom=
ingBreakingChanges.md
new file mode 100644
index 0000000000..d057ef7cb3
--- /dev/null
+++ b/Documentation/UpcomingBreakingChanges.md
@@ -0,0 +1,122 @@
+# Upcoming breaking changes
+
+The Git project aims to ensure backwards compatibility to the best extent
+possible. Minor releases will not break backwards compatibility unless the=
re is
+a very strong reason to do so, like for example a security vulnerability.
+
+Regardless of that, due to the age of the Git project, it is only natural =
to
+accumulate a backlog of backwards-incompatible changes that will eventuall=
y be
+required to keep the project aligned with a changing world. These changes =
fall
+into several categories:
+
+  - Changes to long established defaults.
+
+  - Concepts that have been replaced with a superior design.
+
+  - Concepts, commands, configuration or options that have been lacking in=
 major
+    ways and that cannot be fixed.
+
+The Git project will thus irregularly release major versions that delibera=
tely
+break backwards compatibility with older versions. This is done to ensure =
that
+Git remains relevant, safe and maintainable going forward. The release cad=
ence
+of major versions is typically measured in multiple years.
+
+The intent of this document is to track upcoming deprecations for the next=
 major
+Git release. Furthermore, this document also tracks what will _not_ be
+deprecated. This is done such that the outcome of discussions documente bo=
th
+when the discussion favors deprecation, but also when it rejects a depreca=
tion.
+
+It is supposed to be a living document where proposed changes and
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
+ - The "dashed form", i.e. support for calling `git-<command>` instead of
+   `git <command>` in scripts, has been deprecated for a long time and wil=
l be
+   removed.
+
+ - The command to import patches from Quilt seems to be used rarely, if
+   ever, and will be removed.
+
+ - Support for importing repositories from GNU Arch will be removed because
+   it would not appear to have any users.
+
+ - Support for interacting with CVS repositories (via `cvsimport`,
+   `cvsexportcommit` and `cvsserver`) is of dubious use by now, judging by
+   the number of times these commands have been mentioned recently. The
+   code has been essentially unmaintained, too, and will be removed.
+
+ - Support for grafting commits has long been superseded by git-replace(1).
+   Grafts are inferior to replacement refs as the mechanism can lead to
+   hard-to-diagnose problems when transferring objects between repositorie=
s.
+   They have been outdated since e650d0643b (docs: mark info/grafts as out=
dated,
+   2014-03-05) and will be removed.
+
+ - git-pickaxe, an alias for git-blame(1), has been retired in acca687fa9
+   (git-pickaxe: retire pickaxe, 2006-11-08) and will be removed.
+
+## Superseded features that will not be deprecated
+
+Some features have gained newer replacements that aim to improve the desig=
n in
+certain ways. The fact that there is a replacement does not automatically =
mean
+that the old way of doing things will eventually be removed. This section =
tracks
+those superseded features.
+
+ - git-annotate(1) is an alias for git-blame(1) with the `-c` flag. As
+   the maintenance burden of carrying both of these commands is negligible=
, both
+   commands will stay.
+
+ - git-restore(1) and git-switch(1) have been introduced as a replacement =
for
+   git-checkout(1). As git-checkout(1) is quite established, and as the be=
nefit
+   of switching to git-restore(1) and git-switch(1) is contended, all three
+   commands will stay.
+
+ - git-config(1) has learned to use subcommands that replace implicit acti=
ons
+   (e.g. `git config foo.bar baz`) as well as the action flags (e.g. `git =
config
+   --unset-all`). The action flags will not be removed in the next major G=
it
+   release as there likely exist a lot of scripts out there that use the o=
ld
+   syntax.
+
+   Cf. <ZjiL7vu5kCVwpsLd@tanuki>.

base-commit: 3e4a232f6e3bd3b7dd920bb07b21cf1c8b4e1a7f
--=20
2.45.1.246.gb9cfe4845c.dirty


--MF9fncQUQVmvhzJ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQjhcACgkQVbJhu7ck
PpTANQ//TE6dSs0YyPDWFr6wnkjjUJFja0oLvGRL+SpTWask5BoEzpgop4H2+oG6
blzL1mmr6P8ApwoJSoQpAcExRV0NjJaDKJstFkWSZ7cGmrUt3FSSFmdNyK964Wzw
Z7BOT5jASa+tLwmVCQL0qYgPLEFa8+CKvNWiZt9vuO62auXGJKubcxwnweWF007l
M+V9X9WMDm6b0SRR+O3uEdPKptje+6KxKFaVnVgZOKf6lSwLu7BOtU2G1J9FEjDF
wUbxm4S2/ansN6Qh+7jakcWYjdKYpVYKkqvlz5NveIutwv25XSO9KLlajC9VPHY0
C17YJz3VJ4AnxKRbXC4ldxOaY06SKodAYYIylsk6vW2MSOURCFzhrgQdlNuahxSV
mV1mSOKvmAym/l7vs5EOFRvfedzbly2ZnU+/eLiFNSECQCN7ycVJDQftI2B/aq9p
HNtMdL4oQYDChPwDiv+yfC6gd8BZ6PZI2KUTg7qdLFWLtHRqJvNIeaPF54qnk+uL
9kwIFDfA1c1OO4bdhqVHSNd5ONtf0buG+MWmrlu6QKvyBub//QqFYSGgQE2MCNhG
eu0M/1b18qdxs/qKnLN7aa/njL6eYLYPOlMsdcabeUiHQjrc5iK2oUbX/BUF7Q23
3Ab5T2Wx30Bs15Gl9vdEUrVTSR3ZCBVDBs1onm+V+NvizV6P4V4=
=CibM
-----END PGP SIGNATURE-----

--MF9fncQUQVmvhzJ5--
