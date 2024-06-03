Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D057E59A
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406909; cv=none; b=g7q2xz/whD0glWl72/HYiuabybTojwZVC94DP/eOLIAqeqjFFg2T2DrV8kPDLTWKfuMhca/I+mwN8dvqc/0fVdbm/vb0gcWhvZA+2i0fHI8BiyCAdybdzjQDdvHvDALM8o1RQRyvobPfnilJXbMJDDJOeMbNyHTuxr0VFNfETkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406909; c=relaxed/simple;
	bh=em1Ie6br8BSCDF/MKbqfdUEHtzU2pdmUJTJOfLikn9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILlu1dPCFHOCjUcTlJ+g7dYpzytPxF0yG2Al3zrNPXy220Luo1NA93myZiaDjS3xDyn+hWoMxKaviYs4pd8dJvyrLUJG2nnYa+acAVXCZbuZxpUmEpwHuFOg438V30ba9IMBt6BaNXXNgQVssrVswccHgiJ6Dzqd/HKhpgWN1oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hd8VNr0A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TZFXhzqz; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hd8VNr0A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TZFXhzqz"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 309361C000FC;
	Mon,  3 Jun 2024 05:28:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 05:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717406904; x=1717493304; bh=y3bPSmRkZR
	j+wp59H6K4yQ4jPO+DQaXpyYakS/w8LsE=; b=hd8VNr0AbQzQfEvMlP1l6KrtL1
	ZFD2y0Yk/o0LUKVIdGmvMlozSn0ovO97KkALQiO2l2Fk6HqJYYXPjq0XKHEhpZIn
	dyNaZpZ0H147yIEr4qldlREQLmzeQo5/2GHsKIJxLy05rCIUMqWvgif4PaxzUanO
	pzRQBjDTROaiA73UrCQ/TPS7QgkFEbdeZJJzIK77ZqaAaGRvlXvPB3dNrY6CGq4a
	+VuuEkDnoHYMZtUwhdOTbaC4RJIReCQsmAHSPFWv1B56nSm1qWhcxm6EPkOGGe3U
	HVogMOE5CxmieBGzY+wcBKa5JUMc2iQXxG75hEHOhiHFqeRYcLZI+VJ72bXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717406904; x=1717493304; bh=y3bPSmRkZRj+wp59H6K4yQ4jPO+D
	QaXpyYakS/w8LsE=; b=TZFXhzqzsUZqWJVbQTTv9nBvizIZkP7/yLlhoJt7NcyN
	4jWAaxi/ZjLvkbJ8dV5ap3g/HCsnIidQZ7rkTRP/LCnLdPZ6QDK0UHXDydjodOPA
	A0hwUfV5iwAZf0sa1FqgutFKLcBvr5BpFEdlwlHKL2uO5340RKJihIvKurzvfTGn
	Cx2GKVdAH0Lth04W+7SCOlI/LropHhRcrRqr3gdHUEBaNGvV1Jq5Y9djHJQFNRLF
	+83jdRMdtnUGoWg2WfE6BY1VD3bo0IAsrtGgVLwYUEbhc0vUl+8MaGgJ/55wwHbW
	XqsRijlxYuRhkpa2ArezDe95wMZe4NSO5aJh/4kFLA==
X-ME-Sender: <xms:uIxdZjDlG1mf6vLLjWdc3fEuUnYZ3fsjkzE3K5j8K_9sWto91BPWMw>
    <xme:uIxdZpjR_zDX3477V4F-Cwp422h7Ig87Q6qiMPfl1sG6VYsXPyAhtZm-5BxmHq3A9
    eGm8iq65PVA5p0GXg>
X-ME-Received: <xmr:uIxdZuklu7IIWM1QKr7qdcWPlIFAQRrAXGR7vdnjakmo3FydpacLvpA4iFhBs1dk7xclqAceUiekYhkqQ_VYOzeFaHwAOt5Gh_swMiuwNKlJqExk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:uIxdZlzmbYMUvrB3JoMlKv2is6pLoybSkyqA3k1-v_X-SnHOKjjirQ>
    <xmx:uIxdZoSB1ROZsNivar23OSVnrfg_HtcFKxoFdyQ6qVvWmpc7aKaGyA>
    <xmx:uIxdZoZZ26IPCY-xouwzcFenPVb4vN9YqQT8m32dXvDESLyKxYWL2w>
    <xmx:uIxdZpQT-Zd6l3W-sabs9Cw0f6lnTrPi3t89xWA2JF5rN-DAx_NMAg>
    <xmx:uIxdZrFaE51SUqocWzZRMkxEhnwyLoxNfZonkdnv5GNFPxnmN4F2rhIc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:28:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7cb4be25 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:27:55 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:28:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v5 0/4] docs: document upcoming breaking changes
Message-ID: <cover.1717402497.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6GCduec+Ba5fOgzJ"
Content-Disposition: inline
In-Reply-To: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>


--6GCduec+Ba5fOgzJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is another iteration of my patch series that intends to start
tracking upcoming breaking changes in Git.

Changes compared to v4:

  - Converted the document to use AsciiDoc instead of MarkDown.

  - Reword "major release" to "breaking release".

  - Note Git 2.0, which is the last major breaking release.

  - Note that minor bug fixes that lead to user visible changes in
    behavior do not require a breaking release.

  - Clarify that misdesigned features may be removed without
    replacement, if necessary.

  - Fix double negation in commit message of the last commit.

Thanks!

Patrick

Patrick Steinhardt (4):
  docs: introduce document to announce breaking changes
  BreakingChanges: document upcoming change from "sha1" to "sha256"
  BreakingChanges: document removal of grafting
  BreakingChanges: document that we do not plan to deprecate
    git-checkout

 Documentation/BreakingChanges.txt | 115 ++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/BreakingChanges.txt

Range-diff against v4:
1:  993b936348 ! 1:  67cb4de5cb docs: introduce document to announce breaki=
ng changes
    @@ Commit message
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    - ## Documentation/BreakingChanges.md (new) ##
    + ## Documentation/BreakingChanges.txt (new) ##
     @@
    -+# Upcoming breaking changes
    ++=3D Upcoming breaking changes
     +
     +The Git project aims to ensure backwards compatibility to the best ex=
tent
     +possible. Minor releases will not break backwards compatibility unles=
s there is
    @@ Documentation/BreakingChanges.md (new)
     +required to keep the project aligned with a changing world. These cha=
nges fall
     +into several categories:
     +
    -+  - Changes to long established defaults.
    ++* Changes to long established defaults.
    ++* Concepts that have been replaced with a superior design.
    ++* Concepts, commands, configuration or options that have been lacking=
 in major
    ++  ways and that cannot be fixed and which will thus be removed withou=
t any
    ++  replacement.
     +
    -+  - Concepts that have been replaced with a superior design.
    ++Explicitly not included in this list are fixes to minor bugs that may=
 cause a
    ++change in user-visible behavior.
     +
    -+  - Concepts, commands, configuration or options that have been lacki=
ng in major
    -+    ways and that cannot be fixed.
    ++The Git project irregularly releases breaking versions that deliberat=
ely break
    ++backwards compatibility with older versions. This is done to ensure t=
hat Git
    ++remains relevant, safe and maintainable going forward. The release ca=
dence of
    ++breaking versions is typically measured in multiple years. The last b=
reaking
    ++releases were:
     +
    -+The Git project will thus irregularly release major versions that del=
iberately
    -+break backwards compatibility with older versions. This is done to en=
sure that
    -+Git remains relevant, safe and maintainable going forward. The releas=
e cadence
    -+of major versions is typically measured in multiple years.
    ++* Git 2.0, released in May 2014.
     +
     +The intent of this document is to track upcoming deprecations for the=
 next
     +major Git release. Furthermore, this document also tracks what will _=
not_ be
    @@ Documentation/BreakingChanges.md (new)
     +when the discussion favors deprecation, but also when it rejects a de=
precation.
     +
     +Items should have a self-sufficient explanation why we want or do not=
 want to
    -+deprecate a given feature. If there are alternatives to the deprecate=
d feature,
    ++make the described change. If there are alternatives to the changed f=
eature,
     +those alternatives should be pointed out to our users.
     +
     +All items should be accompanied by references to relevant mailing lis=
t threads
    @@ Documentation/BreakingChanges.md (new)
     +revisited from time to time. So do not take items on this list to mea=
n "it is
     +settled, do not waste our time bringing it up again".
     +
    -+## Git 3.0
    ++=3D=3D Git 3.0
     +
     +The following subsections document upcoming breaking changes for Git =
3.0. There
    -+is no planned release date for this major version yet.
    ++is no planned release date for this breaking version yet.
     +
     +Proposed changes and removals only include items which are "ready" to=
 be done.
     +In other words, this is not supposed to be a wishlist of features tha=
t should
     +be changed to or replaced in case the alternative was implemented alr=
eady.
     +
    -+### Changes
    ++=3D=3D=3D Changes
     +
    -+### Removals
    ++=3D=3D=3D Removals
     +
    -+## Superseded features that will not be deprecated
    ++=3D=3D Superseded features that will not be deprecated
     +
     +Some features have gained newer replacements that aim to improve the =
design in
     +certain ways. The fact that there is a replacement does not automatic=
ally mean
     +that the old way of doing things will eventually be removed. This sec=
tion tracks
    -+those superseded features.
    ++those features with newer alternatives.
2:  7c84b2f957 ! 2:  b36ffcbaa6 BreakingChanges: document upcoming change f=
rom "sha1" to "sha256"
    @@ Commit message
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    - ## Documentation/BreakingChanges.md ##
    -@@ Documentation/BreakingChanges.md: be changed to or replaced in case=
 the alternative was implemented already.
    + ## Documentation/BreakingChanges.txt ##
    +@@ Documentation/BreakingChanges.txt: be changed to or replaced in cas=
e the alternative was implemented already.
     =20
    - ### Changes
    + =3D=3D=3D Changes
     =20
    -+  - The default hash function for new repositories will be changed fr=
om "sha1"
    -+    to "sha256". SHA-1 has been deprecated by NIST in 2011 and is now=
adays
    -+    recommended against in FIPS 140-2 and similar certifications. Fur=
thermore,
    -+    there are practical attacks on SHA-1 that weaken its cryptographi=
c properties:
    ++* The default hash function for new repositories will be changed from=
 "sha1"
    ++  to "sha256". SHA-1 has been deprecated by NIST in 2011 and is nowad=
ays
    ++  recommended against in FIPS 140-2 and similar certifications. Furth=
ermore,
    ++  there are practical attacks on SHA-1 that weaken its cryptographic =
properties:
    +++
    ++  ** The SHAppening (2015). The first demonstration of a practical at=
tack
    ++     against SHA-1 with 2^57 operations.
    ++  ** SHAttered (2017). Generation of two valid PDF files with 2^63 op=
erations.
    ++  ** Birthday-Near-Collision (2019). This attack allows for chosen pr=
efix
    ++     attacks with 2^68 operations.
    ++  ** Shambles (2020). This attack allows for chosen prefix attacks wi=
th 2^63
    ++     operations.
    +++
    ++While we have protections in place against known attacks, it is expec=
ted
    ++that more attacks against SHA-1 will be found by future research. Pai=
red
    ++with the ever-growing capability of hardware, it is only a matter of =
time
    ++before SHA-1 will be considered broken completely. We want to be prep=
ared
    ++and will thus change the default hash algorithm to "sha256" for newly
    ++initialized repositories.
    +++
    ++Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
    ++<20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
    ++<CA+EOSBncr=3D4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com=
>.
     +
    -+      - The SHAppening (2015). The first demonstration of a practical=
 attack
    -+        against SHA-1 with 2^57 operations.
    -+
    -+      - SHAttered (2017). Generation of two valid PDF files with 2^63=
 operations.
    -+
    -+      - Birthday-Near-Collision (2019). This attack allows for chosen=
 prefix
    -+        attacks with 2^68 operations.
    -+
    -+      - Shambles (2020). This attack allows for chosen prefix attacks=
 with 2^63
    -+        operations.
    -+
    -+    While we have protections in place against known attacks, it is e=
xpected
    -+    that more attacks against SHA-1 will be found by future research.=
 Paired
    -+    with the ever-growing capability of hardware, it is only a matter=
 of time
    -+    before SHA-1 will be considered broken completely. We want to be =
prepared
    -+    and will thus change the default hash algorithm to "sha256" for n=
ewly
    -+    initialized repositories.
    -+
    -+    Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
    -+        <20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
    -+        <CA+EOSBncr=3D4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.g=
mail.com>.
    -+
    - ### Removals
    + =3D=3D=3D Removals
     =20
    - ## Superseded features that will not be deprecated
    + =3D=3D Superseded features that will not be deprecated
3:  91d78490c2 ! 3:  4142e472ac BreakingChanges: document removal of grafti=
ng
    @@ Commit message
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    - ## Documentation/BreakingChanges.md ##
    -@@ Documentation/BreakingChanges.md: be changed to or replaced in case=
 the alternative was implemented already.
    + ## Documentation/BreakingChanges.txt ##
    +@@ Documentation/BreakingChanges.txt: Cf. <2f5de416-04ba-c23d-1e0b-83b=
b655829a7@zombino.com>,
     =20
    - ### Removals
    + =3D=3D=3D Removals
     =20
    -+ - Support for grafting commits has long been superseded by git-repla=
ce(1).
    -+   Grafts are inferior to replacement refs as the mechanism can lead =
to
    -+   hard-to-diagnose problems when transferring objects between reposi=
tories.
    -+   They have been outdated since e650d0643b (docs: mark info/grafts a=
s outdated,
    -+   2014-03-05) and will be removed.
    ++* Support for grafting commits has long been superseded by git-replac=
e(1).
    ++  Grafts are inferior to replacement refs as the mechanism can lead to
    ++  hard-to-diagnose problems when transferring objects between reposit=
ories.
    ++  They have been outdated since e650d0643b (docs: mark info/grafts as=
 outdated,
    ++  2014-03-05) and will be removed.
    +++
    ++Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
     +
    -+   Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
    -+
    - ## Superseded features that will not be deprecated
    + =3D=3D Superseded features that will not be deprecated
     =20
      Some features have gained newer replacements that aim to improve the =
design in
4:  40594bda5c ! 4:  9ff94b6f32 BreakingChanges: document that we do not pl=
an to deprecate git-checkout
    @@ Commit message
         not the case though: the use of that command is still widespread, =
and it
         is not expected that this will change anytime soon.
    =20
    -    Document that neither of these commands will not go away anytime s=
oon.
    +    Document that all three commands will remain for the foreseeable f=
uture.
         This decision may be revisited in case we ever figure out that most
         everyone has given up on any of the commands.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    - ## Documentation/BreakingChanges.md ##
    -@@ Documentation/BreakingChanges.md: Some features have gained newer r=
eplacements that aim to improve the design in
    + ## Documentation/BreakingChanges.txt ##
    +@@ Documentation/BreakingChanges.txt: Some features have gained newer =
replacements that aim to improve the design in
      certain ways. The fact that there is a replacement does not automatic=
ally mean
      that the old way of doing things will eventually be removed. This sec=
tion tracks
    - those superseded features.
    + those features with newer alternatives.
     +
    -+ - git-restore(1) and git-switch(1) have been introduced as a replace=
ment for
    -+   git-checkout(1). As git-checkout(1) is quite established, and as t=
he benefit
    -+   of switching to git-restore(1) and git-switch(1) is contended, all=
 three
    -+   commands will stay.
    -+
    -+   This decision may get revisited in case we ever figure out that th=
ere are
    -+   almost no users of any of the commands anymore.
    -+
    -+   Cf. <xmqqttjazwwa.fsf@gitster.g>,
    -+       <xmqqleeubork.fsf@gitster.g>,
    -+       <112b6568912a6de6672bf5592c3a718e@manjaro.org>.
    ++* git-restore(1) and git-switch(1) have been introduced as a replacem=
ent for
    ++  git-checkout(1). As git-checkout(1) is quite established, and as th=
e benefit
    ++  of switching to git-restore(1) and git-switch(1) is contended, all =
three
    ++  commands will stay.
    +++
    ++This decision may get revisited in case we ever figure out that there=
 are
    ++almost no users of any of the commands anymore.
    +++
    ++Cf. <xmqqttjazwwa.fsf@gitster.g>,
    ++<xmqqleeubork.fsf@gitster.g>,
    ++<112b6568912a6de6672bf5592c3a718e@manjaro.org>.
--=20
2.45.1.410.g58bac47f8e.dirty


--6GCduec+Ba5fOgzJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjKgACgkQVbJhu7ck
PpQ7pg//cObtlKBsj8t8heOGFzxfFt1UviFupRhm14Q/i1HFcTH7gu037+4wHs0v
VPReC+kVYfMQ9GE0KpEt2Pj0b1NbKyIIJFixLJw8aH/lwWMduUvGAlu8whuBs68H
UXv1fz7A8ZGk3VrtQbimR1S358dOJseHenaspfIM86QU1czuwTYrAzF0wCZEk+aK
OWh/oqAtabayxw4B80fZkwAv4v4CdlN2yiwpoAc2Tw550cMYpqWx/IW8Wfad/wyw
M4syf5nDydJmd7vDRgH8Dgl1f/fCY2ErP1IsSQPa7knGDk7gaRNgRbQjHj/e0Bf8
s3mqmjMZekTqBuN3lp2+JVknlDk/Aob6KEBJtrtq0jFGBeM3fu0whMfudRk03SMs
EC8EifbIhiCvw/RBbfY3ZheQfK8c0ON44rbaUAQBJeimvJtg/ApueEYHIrmjqHY+
YN0pXG61SLM2aGPDAAWkU9TYCVkM49ZT/4F8LmTETrLENMRDsA0Msse/J1pcT2gD
sxqHqsakcKduLib3RrrfWgF+5EzTvzqVZYNKHXqQEwp22lXn1ZNHt71EntpJBKLK
yG3mLnc80PjhUR/pZbwRAdGgOyrMAtT2sH4iA2OsG5NQdJEuOD45/D0r56uUSF5m
0+4nMYFseY1vKQ0Nx4mgOfsg/RHY1UACnx/it/5BZd2DknwamhY=
=qGBS
-----END PGP SIGNATURE-----

--6GCduec+Ba5fOgzJ--
