Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA411862A
	for <git@vger.kernel.org>; Tue, 14 May 2024 06:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715667414; cv=none; b=RqJ7YkeZAatouNxPCXGOZhVJGIX0LzkIh0I67gS4vHNnEacKPX/zInkeUPpE6okI8YG+l/xS4Abh0FLc6ccAj/kMv8A/uDCs3CMX4ZOtMQTpZpE/wmUrDFTTbLhm/QWnjQBj4IZO3hvv3hYmUduX9FMy7tY8s2+Lkzh1j605Bwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715667414; c=relaxed/simple;
	bh=YZF8NDaTyTy2VFxwnwQSU3Wvw4EcRE1+/AfyJu1uHi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWxSxnemcQXDyjEGxTHYrwFgJo3cLGJXWsxfMvCgaofuMIoHZzYqO9Xvt3D62sGYIUXv1KjnjcOBQIqg6RKviXYXagiwOdus9RHsejJbbMgH0NflWIzWa8jsIHsmkakctrfJ9IaeQf7V1uktuOTHYba91DMy41E9m8qYQ0FdgsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eJ0Cre1J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V6vQ33Po; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eJ0Cre1J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V6vQ33Po"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CB10511401C2;
	Tue, 14 May 2024 02:16:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 14 May 2024 02:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715667410; x=1715753810; bh=2DwAZQ3+Q9
	Fjq/ujIF7cw/QO0VN8fOhzzKAXUNG1+Ic=; b=eJ0Cre1JJ2yMLCJwYuC+joKR91
	jrUKDn7A1Bsi/Do+Ab3K8SP1eDCYnFDpi/B5xVVXPRUNuLTxjPDn+OeVivoi/UgS
	Y8pwQ/0H8s5p9MR/aYXXJdaa+kvN7SUg+c5JFaLu7nCimWoQfEUlTwod1eN3jv5o
	wsqVHFYTtfLcjDIM/hGgoUm30AjVM97wwSj+845FOR/tnCteOLq7bsyGiG/gslE+
	sP9qdiqBUcichuadTvKfr0b08ZLC4OCjDoLXvqJWdB357gl36wS4bRpb37OwLEUH
	S0T8cJ1ZGMHWJLq4JP3umtmJtfLgkhmSItxguzghji7B4ZI1Liib4Y63OFJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715667410; x=1715753810; bh=2DwAZQ3+Q9Fjq/ujIF7cw/QO0VN8
	fOhzzKAXUNG1+Ic=; b=V6vQ33Po7GrwCDq20AXGzff/zzTiv+AtNPl/VVaD3sIK
	Y/lzfmunh0/OBuGHQ1imKlwHjzZFeWX/pNu77ud4OC33ICSLw+kvFaqIjXcdAcyp
	9AKZzSNKxWZocG2vbkP6GEK3valDhQwiglzwZ4ujCJuo004sxCGkZDtR/kKiFa/6
	Lj2ZZAM5/SwFFKpIRajkoO0bwHWNKgwuY+yTli/XL4k9xfRjQfTyOx6Apnou5mSq
	93iHuId9YAWQYjkjdpOG+BpbQH8sLlMaoM2uzoHALvA49DXtaE61t9e2ZorcbWCU
	zyctIgGAJYV9bmdTc0UP1D5GqaLAkt8XHpCSBnnbWQ==
X-ME-Sender: <xms:0gFDZv2vOVPzlDyzcGrSKSJBqibUtnzQOaxiENyfXxciWnHMiGWTtA>
    <xme:0gFDZuFY3y6z_W3KfJapuzibxhUz3fKtLl3qn0-YNbt5PAkJXTZBQ5eE2bXaEkfhU
    TBZJEEOrNRtpyVE-w>
X-ME-Received: <xmr:0gFDZv5Vv6Po5090l7mZn7gT4B7MyzDuKcyWwcaNge1fIbKprJH5JFGD3pZH76PfWxNCDriKLEBUlPy2WKkUi8-3i7kJppu01ILz6iQpYe4TsBEnss73>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeghedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhephefgjeeigeektdfhffeuteeuuddtkeffheejgeefjeeigfeivedtgfffheefvdel
    necuffhomhgrihhnpehhthhtphgurghvrdhsuhhpphhorhhtpdhgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhm
X-ME-Proxy: <xmx:0gFDZk09xW5CmYpJl400zQlL2ZVAABxo4sOtUbooFQR6mGZ6HVPwCw>
    <xmx:0gFDZiEMTuSDgqzVyI3U_LDQFV3Njt9pZp74PByqWNakLy_DfoJABw>
    <xmx:0gFDZl9sc6FwlSzq121DOMkh-suN6Z9_ii5bWxqZKfqKgOcHXgcSqQ>
    <xmx:0gFDZvkPtC19WZf9o8LKz6dQOGWvbsoJHDvWabJHkAVoAxakm9b7vQ>
    <xmx:0gFDZn4OF9-wRZjqxfjvnP1MH0SCb1lurvq-3ILceDr_zMRgSQdIbJsm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 May 2024 02:16:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bc0aa320 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 May 2024 06:16:26 +0000 (UTC)
Date: Tue, 14 May 2024 08:16:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: [RFC PATCH v2] docs: document upcoming breaking changes
Message-ID: <2ef53ff98b12fe9373a15ec3a795235f040d9049.1715667067.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="euz7EljrVthpqnX+"
Content-Disposition: inline
In-Reply-To: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>


--euz7EljrVthpqnX+
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

I have tried to accommodate for all feedback to v1. Most notably:

  - I have introduced a new section that documents concepts that are
    _not_ to be deprecated. The intent is to capture discussions around
    proposed deprecations where we ultimately decide that we do not
    (yet) want to deprecate it.

  - I have added some more proposed deprecations. As before, all of this
    is up for discussion and I do not want to force any of the proposed
    deprecations onto anybody.

  - I have dropped the "$GITDIR/hooks" deprecation item for now. It is
    premature to have it at this point in time given that the
    config-based approach isn't even close to landing.

Patrick

Range-diff against v1:
1:  a78d68ecc2 ! 1:  2ef53ff98b docs: document upcoming breaking changes
    @@ Commit message
         noted in manpages, most of them are actually deprecated in the "hi=
ve
         mind" of the Git community, only.
    =20
    -    Introduce a new document that lists upcoming breaking changes to a=
ddress
    +    Introduce a new document that lists upcoming breaking changes, but=
 also
    +    deprecations which we are not willing to go through with, to addre=
ss
         this issue. This document serves multiple purposes:
    =20
           - It is a way to facilitate discussion around proposed deprecati=
ons.
    @@ Commit message
             they have good reasons why a certain feature should not be
             deprecated.
    =20
    -      - It states intent and documents where the Git project wants to =
go.
    +      - It states intent and documents where the Git project wants to =
go,
    +        both in the case where we want to deprecate, but also in the c=
ase
    +        where we don't want to deprecate a specific feature.
    =20
         The document is _not_ intended to cast every single discussion into
         stone. It is supposed to be a living document that may change over=
 time
    @@ Documentation/UpcomingBreakingChanges.md (new)
     @@
     +# Upcoming breaking changes
     +
    ++The Git project aims to ensure backwards compatibility to the best ex=
tent
    ++possible. Minor releases will not break backwards compatibility unles=
s there is
    ++a very strong reason to do so, like for example a security vulnerabil=
ity.
    ++
    ++Regardless of that, due to the age of the Git project, it is only nat=
ural to
    ++accumulate a backlog of backwards-incompatible changes that will even=
tually be
    ++required to keep the project aligned with a changing world. These cha=
nges fall
    ++into several categories:
    ++
    ++  - Changes to long established defaults.
    ++
    ++  - Concepts that have been replaced with a superior design.
    ++
    ++  - Concepts, commands, configuration or options that have been lacki=
ng in major
    ++    ways and that cannot be fixed.
    ++
    ++The Git project will thus irregularly release major versions that del=
iberately
    ++break backwards compatibility with older versions. This is done to en=
sure that
    ++Git remains relevant, safe and maintainable going forward. The releas=
e cadence
    ++of major versions is typically measured in multiple years.
    ++
     +The intent of this document is to track upcoming deprecations for the=
 next major
    -+Git release. It is supposed to be a living document where proposed ch=
anges and
    ++Git release. Furthermore, this document also tracks what will _not_ be
    ++deprecated. This is done such that the outcome of discussions documen=
te both
    ++when the discussion favors deprecation, but also when it rejects a de=
precation.
    ++
    ++It is supposed to be a living document where proposed changes and
     +deprecations are up for discussion.
     +
     +## Git 3.0
    @@ Documentation/UpcomingBreakingChanges.md (new)
     +
     +### Removals
     +
    -+ - git-config(1) has learned to use subcommands that replace implicit=
 actions
    -+   (e.g. `git config foo.bar baz`) as well as the action flags (e.g. =
`git config
    -+   --unset-all`). The actions will be removed in favor of subcommands.
    -+   Prerequisite for this change is that the new subcommands have been=
 out for at
    -+   least for two years to give script authors time to migrate.
    -+
    -+   Cf. <ZjiL7vu5kCVwpsLd@tanuki>.
    -+
     + - git-http-push(1) can be used to push objects to a remote repositor=
y via
     +   HTTP/DAV. Support for write support via WebDAV is not in widesprea=
d use
     +   nowadays anymore and will be removed together with the command.
    @@ Documentation/UpcomingBreakingChanges.md (new)
     +   shorthands for URLs for git-fetch(1), git-pull(1) and git-push(1).=
 This
     +   concept has long been replaced by remotes and will thus be removed.
     +
    -+ - git-annotate(1) is an alias for git-blame(1) with the `-c` flag. I=
t will
    -+   be removed in favor of git-blame(1).
    -+
     + - "gitweb" and git-instaweb(1) can be used to browse Git repositorie=
s via an
     +   HTTP server. These scripts have been unmaintained for a significan=
t amount of
     +   time and will be removed.
    @@ Documentation/UpcomingBreakingChanges.md (new)
     +   very slow, hard to use and has many gotchas. It will thus be remov=
ed in favor
     +   of [git-filter-repo](https://github.com/newren/git-filter-repo).
     +
    -+ - githooks(5) can be installed by placing them into `$GIT_DIR/hooks/=
`. This has
    -+   been a source of multiple remote code execution vulnerabilities. T=
he feature
    -+   will be removed in favor of `core.hooksDirectory` and the new conf=
ig-based
    -+   hooks.
    ++ - The "dashed form", i.e. support for calling `git-<command>` instea=
d of
    ++   `git <command>` in scripts, has been deprecated for a long time an=
d will be
    ++   removed.
    ++
    ++ - The command to import patches from Quilt seems to be used rarely, =
if
    ++   ever, and will be removed.
    ++
    ++ - Support for importing repositories from GNU Arch will be removed b=
ecause
    ++   it would not appear to have any users.
    ++
    ++ - Support for interacting with CVS repositories (via `cvsimport`,
    ++   `cvsexportcommit` and `cvsserver`) is of dubious use by now, judgi=
ng by
    ++   the number of times these commands have been mentioned recently. T=
he
    ++   code has been essentially unmaintained, too, and will be removed.
    ++
    ++ - Support for grafting commits has long been superseded by git-repla=
ce(1).
    ++   Grafts are inferior to replacement refs as the mechanism can lead =
to
    ++   hard-to-diagnose problems when transferring objects between reposi=
tories.
    ++   They have been outdated since e650d0643b (docs: mark info/grafts a=
s outdated,
    ++   2014-03-05) and will be removed.
    ++
    ++## Superseded features that will not be deprecated
    ++
    ++Some features have gained newer replacements that aim to improve the =
design in
    ++certain ways. The fact that there is a replacement does not automatic=
ally mean
    ++that the old way of doing things will eventually be removed. This sec=
tion tracks
    ++those superseded features.
    ++
    ++ - git-annotate(1) is an alias for git-blame(1) with the `-c` flag. As
    ++   the maintenance burden of carrying both of these commands is negli=
gible, both
    ++   commands will stay.
    ++
    ++ - git-restore(1) and git-switch(1) have been introduced as a replace=
ment for
    ++   git-checkout(1). As git-checkout(1) is quite established, and as t=
he benefit
    ++   of switching to git-restore(1) and git-switch(1) is contended, all=
 three
    ++   commands will stay.
    ++
    ++ - git-config(1) has learned to use subcommands that replace implicit=
 actions
    ++   (e.g. `git config foo.bar baz`) as well as the action flags (e.g. =
`git config
    ++   --unset-all`). The action flags will not be removed in the next ma=
jor Git
    ++   release as there likely exist a lot of scripts out there that use =
the old
    ++   syntax.
    ++
    ++   Cf. <ZjiL7vu5kCVwpsLd@tanuki>.

 Documentation/UpcomingBreakingChanges.md | 119 +++++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/UpcomingBreakingChanges.md

diff --git a/Documentation/UpcomingBreakingChanges.md b/Documentation/Upcom=
ingBreakingChanges.md
new file mode 100644
index 0000000000..8c7a5f2f38
--- /dev/null
+++ b/Documentation/UpcomingBreakingChanges.md
@@ -0,0 +1,119 @@
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
--=20
2.45.GIT


--euz7EljrVthpqnX+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZDAcsACgkQVbJhu7ck
PpQIXA//e9xr1V2rObUnDmI+mrB6ofRU4sTeilD//vJgOQy1tSrUjkFxS/Ev4m/L
rPkmdswHbfpVGU9Zww72u9Sfj0ZhBRAMqVgF7llD2UYkVuioAkK+XZsZGwYmDA6T
KS8hxaDRXDcDs/aTV2oa4fe9Yyk8eXKPuQpFVdppWcQf46rA2hvNxODiXuFy4KzB
mnxvlLPY+CxzZBtCn/DD2u5DwBGcY70iXoW53z/KFkcbyvMXS5f4fHqRp5Kf1GlG
uUM7pS9eWSNPYquWAx+6r8ze+hOHyRzISNhO1T4EY3GXn+6qZdxCG0fkgFoLLb3N
SZIRh9FQRd6z3SfplfJGNDscofXpsgaNBUv9wi5OIrQjQEB6RWkZPnO5ZPRqFRPJ
IkjWFipBR8+wP+4DHT+nm+YZgX0El5wHYyJ4NfHSjcu1NnN35eseaFO97ScxfstH
cHxIqHwh+KHQFgnLUQL+5DH3yVQeFLazb6lRg6HpoUsY6Y2jXuDloTqHJkZEHo1Q
niFD/UabFn6dxrLUmiGsKTtLI0D3bH7ZhZswdZ5PiE40oCU4sgtBx2tK3TAK+JsG
Z5AT79sUOErgNhoU3/SoKAvc59wCu+uBo4w5v9hW3fYNx7dXwLA80O3ZELunan/s
woTIprkt3HV/H3gCE12QapcDwwGG+wKnys1dDElk/k7FCILEJOE=
=VC0k
-----END PGP SIGNATURE-----

--euz7EljrVthpqnX+--
