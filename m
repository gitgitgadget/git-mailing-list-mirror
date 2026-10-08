Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3D04FECCD
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487661; cv=none; b=sOPjq8ciBUrNWYsPZ8v5ObuqZE6+kNlytsPXFizqBJ5+1fI2GA77RIIcV9IVpfEe7+kohkjvVXhUZw7SVFDzJlcjEzbxN8iudK3qZcEG4vb+iZCRtu2v/dhCTpu+OLp1/i60QzNUIpEX6D6LIyhMyJVpYtedJI4CVBz2gc9O+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487661; c=relaxed/simple;
	bh=PinFug7WGT7HjQ3sHH5KuhCITq+IQ1fiPLa/7CBA95Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NURLPMveNHed9yOFHvSjDKKv3Faa5xoBSHirDSJ4T8gUv+c86R97+WFHV7gDpwjKBqPl2j+mm+0i387DextWbpQFzZqduyhQIFDKLnMwRXa0SIMZoZbtNNYeRuiFWtkGvN5TNYUFlZPpPoNz6nHfGL5TRmtKNDp6rm++v0o1SMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=T8RFYAqs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MDyfoC9F; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="T8RFYAqs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MDyfoC9F"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C221914001CE
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 15:27:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 08 Oct 2026 15:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791487651;
	 x=1791574051; bh=Ho/rN+8V/UH8+dVjGkdJ5eJB/03YPa8BaNB5Bq22SS0=; b=
	T8RFYAqsawn/f1KDO0Hqi81hhu9wdZPfCwXrWjBRTJYrktmQehSzXBfh4VD2VIdy
	xCI1E7ZhY7m+hvXRqaFkfehc9j+fg0J5wQ1fXZ0irec8X0uWtKcB6aD3XLeYAR4R
	Xw0AQkBPXAVD3w2IwJd4HJC8PVbyDX5ODlbTdj/IQ2OGDWNmMR4l2eOLx/1QjrP4
	r8e+tjhfRD6c5tklbduuxlNjBRIu8xscviKWg9IG/z9nVpruO/iENAWB9aLRz5+z
	cet6wSYZ+ioZt5k+tx2j8uIrVVGVnU5Z73aUS3ka+nyWQfs1HbGJuWFHD9/ooGgs
	xxxBy8+Yobe5cX+3OxebmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791487651; x=
	1791574051; bh=Ho/rN+8V/UH8+dVjGkdJ5eJB/03YPa8BaNB5Bq22SS0=; b=M
	DyfoC9Fc3XqnBHixt3YYNol8K8zomoR5h248wu/uF0gfTQS7j05Y/UOmwryUOw+a
	sb1qsWYSLeC0Du2GD4cKlukXJyagJaidotYTlpIFixIUvbOSo5c5mb9OwA02+YvN
	o+FSXjyqdC4TCZwGxa6Wy8WEh3+eI6Ek3D1hXKQMEAr6PDebxtUAp2AFF7DlDhL+
	qr6zaAKSd740LU/k7PiusmSSa5flPB+5VhVKR0ULTHhTF1DuSp68LyJrEfJi/bIs
	sIQPybNDff52F+rbg3aNmug/KYP80qyVDgBFqHeKZi3oizLWnSMyZ3x3+uv2/XtJ
	sz/+qDoZqXXHBnR6tOeeQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791487651; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:S02zscrWaJcF25JXWZpb23a6NoPPGVgzIFmZlCVSxmt9KoY
	U2C/pNZ6MGDNtjQVX1mzE+QIomOj7023eE/EgIFWv6KhafaG9hAR36fRC/8mOdSq
	X9+/wISfiocxTsJzWkOOK1Tx8AW2yF229/gnCwPBlrbumCU3NHr0Y+4nytz4ktCp
	BoECOvs0TS35ZxRW2Wkg/VQfXnHv2VgXv0+7rHY/LZIK6xe0xnL5a64bjnXENZUG
	R3YT6umTztU6KCSZUMLU7NgU3uoh8T4y2Pd5MJYrG+7ClH5ml+sn31bpP/oSKLna
	GNaINO+2wbOz2i7F8a77Hoee2y//EVoz7tPCKwQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:xjhijSS7DehERLA2ESUVZ0WosQflv4MCO/rDjicTH54=:PinFug7WGT7HjQ3sHH5KuhCITq+IQ1fiPLa/7CBA95Q=;
X-ME-Sender: <xms:o-7HargvRAnNqJRCToGMnQ8pJOsn9LPKAKmcsnyRl9ZJrpNy4C_ymKk>
    <xme:o-7HavBhtiXfgK4Y2Buo9y5Bsky9k3dOgHOYda_NBB3EKCQ1BioNHtzI0XIjTe2_C
    xO9c3BOFGDiShRp3IHT09gQWgVnWFUrsOHbhpv3FpWVsRaayvOVjw>
X-ME-Received: <xmr:o-7HagFhz8H48paKQXppRJfUe2w7NZdfw9WfK3PAxrGe1QOU4qp9eUdWeyMpIS20gPotlFCz63D95_MjITU0jp8EnvehAADeUSniri93j2VcCL3MBgm8V0U>
X-ME-Proxy-Cause: dmFkZTGTRK5tZNeCj0nwVcPKn8dRlXypQTn4jKezD+cDTVK6HeQWP9k4XcztcxNaRJwBad
    pOYZrXShCYzWXX8panY4Is9BtmFRLvAxZSvt+3qAQN6BpjAkw1c+sxc2rDK6b1e9Pu+d+8
    9fVhObUBYImDP55Po14B+OeX3t65W485cCytRQ8vPLRitRtsm+pk+LaZ9BFulvExTP1HkI
    jK9ihVticEfR1oIzVG7JW7gr9eNHJYR+fb1oasdfzuvYp5KL7b7Fo9UAYsQXbBn8EMKiFz
    8B52x66FS8G1KCsXmReSEr7nKtqHeKwhY94adNBr2pcV1DaRgQ4mkaOmBUvA0+iR9wbKQ7
    7Tb/gUlprain1VmOgc5KLL2NoFV8hJLPBf15tX6sQUnwmkBP71jGaLK876bg2ubJhRYAFe
    ntXquK5e/cc5o1FRwZAsT7ujkrYe5rGfCVqVJixJCF5YpirjClIjbUmzTKOZ0ac1f+Q7Gn
    /XYoislrHu71GlALsWB92C74oKzPbTxzWDs/WAd6VFsrnApmnbhpWnzGXXlA7iIbuhT7qa
    CDM88kZkGVAXIqu3u15Z4GE4YB5qypIuvRt+XCdAQT1VjUCmie7t4aCX6qOrDQ7V3k6eR7
    iD1tx2SxdpCi9n26+tQsbBiACvWcRxJPUJUIyxFK2aL7IIbFhi6m5v35JYeg
X-ME-Proxy: <xmx:o-7HanJBf_ojM9FJtGH0dpoe6cSrBbejsaIJ4JYwUJ4G880Z0Pyicw>
    <xmx:o-7Hakl_VNtlOdBz45ul2uNgP2npLOGsml9LiVUMAWD5aGbemlB58Q>
    <xmx:o-7HavQVOEGR7e5uHaSt2xQIqq5GsHaSNhsxVp6Al-Pcv_j5hSjfsg>
    <xmx:o-7HamKkdYWhkhVaDTaC5z7THwDxAVVfmhAmXqTdBhYsFWwjS1333Q>
    <xmx:o-7Hautp3hKK77p7-QhC62xTuid1OXotvbHbMg_6KaOT_YKEoeGGgn_3>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 15:27:30 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] doc: move BreakingChanges to a manpage
Date: Thu,  8 Oct 2026 21:27:15 +0200
Message-ID: <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: kh/doc-gitbreaking-changes7

Topic summary: Move BreakingChanges document to a manpage for easier
visibility.

Notes to the maintainer: conflicts with topics ps/ref-storage-format (in
`master`) and bc/restrict-hex-to-lowercase (in `seen`). Respectively, they
add these things to `BreakingChanges.adoc`:

(1)

     +
     Users that get immediate benefit from the "reftable" backend could continue to
    -opt-in to the "reftable" format manually by setting the "init.defaultRefFormat"
    +opt-in to the "reftable" format manually by setting the "init.defaultRefStorageFormat"

(2)

      matches the default branch name used in new repositories by many of the
      big Git forges.

   +* Git will accept hex object IDs only in lowercase. The fact that Git has
   +        historically allowed uppercase characters in hex object IDs has been the
   +        source of a variety of bugs and security problems in software using Git. We
   +        don't expect most users to notice any change.

(But (2) uses tabs for the three last lines)

So they would need to be moved from `BreakingChanges.adoc` to
`gitbreaking-changes.adoc`.

***

Users are the ones who are impacted by breaking changes. Certainly much
more than Git developers who are already plugged in to the development
channels that discuss the trajectory of the project. Advertizing the
planned breaking changes to all users will help the whole Git community
prepare.

§ Changes in v2

Drop RFC status since Patrick seems to think that this is an okay
change.[1]

Patch “mention gitbreaking-changes(7)” is dropped. This is because Julia’s
parallel topic je/doc-promote-git-help removes guide-mentions on the git(1)
doc.[2]

Series v1 patch “transform breaking changes doc to a manpage” has been
split into two in order to make tracing the moved lines easier.[1] I did
not go all the way and made another commit for a pure filemove. I think
`--color-moved` should be enough here. But I can of course make another
commit.

Note that this split isn’t that obvious from the range diff. It might have
been etter if it compared the previous round with the first commit, but
futzing with `--creation-factor` didn’t help me here.

Patch “replace msg-ids with URLs”: fixed unintended space changes. Another
linking scheme was discussed but it lead to no changes.[4] But! I found out
that one URL does not render properly with asciidoc(1). So I made a
compromise for now. Maybe that sinks the URL aspirations here.

Patch “move new-items discussion to the end” is new and based on what I
hope is my correct interpretation of Patrick’s suggestion.[3]

† 1: <ar0OicAaDipYx-xU@pks.im>
† 2: <ea29fe74-7f76-440c-9597-fdbc173be90f@app.fastmail.com>
† 3: <ar0OltAkeTiCx81c@pks.im>
† 4: <xmqqeceaa5h9.fsf@gitster.g>

§ Link to v1

https://lore.kernel.org/git/CV_gitbrchanges7_please.d1c@m5gid.xyz/

[1/5] doc: BreakingChanges: transform to a manpage
[2/5] doc: gitbreaking-changes: create from BreakingChanges
[3/5] doc: gitbreaking-changes: replace msg-ids with URLs
[4/5] doc: gitbreaking-changes: add note about living document
[5/5] doc: gitbreaking-changes: move new-items discussion to the end

 Documentation/BreakingChanges.adoc     | 360 +----------------------
 Documentation/Makefile                 |   1 +
 Documentation/gitbreaking-changes.adoc | 389 +++++++++++++++++++++++++
 Documentation/meson.build              |   1 +
 command-list.txt                       |   1 +
 5 files changed, 393 insertions(+), 359 deletions(-)
 create mode 100644 Documentation/gitbreaking-changes.adoc

Interdiff against v1:
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 6a4ef2dff5c..6f0075f9188 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -26,9 +26,7 @@ See linkgit:gittutorial[7] to get started, then see
 linkgit:giteveryday[7] for a useful minimum set of
 commands.  The link:user-manual.html[Git User's Manual] has a more
 in-depth introduction.  See linkgit:gitdatamodel[7] if you want to
-learn about the data model and important terminology.  See
-linkgit:gitbreaking-changes[7] for a discussion of breaking changes
-planned for Git 3.0.
+learn about the data model and important terminology.
 
 After you mastered the basic concepts, you can come back to this
 page to learn what commands Git offers.  You can learn more about
@@ -1206,7 +1204,6 @@ linkgit:gittutorial[7], linkgit:gittutorial-2[7],
 linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
 linkgit:gitglossary[7], linkgit:gitdatamodel[7],
 linkgit:gitcore-tutorial[7], linkgit:gitcli[7],
-linkgit:gitbreaking-changes[7],
 link:user-manual.html[The Git User's Manual],
 linkgit:gitworkflows[7]
 
diff --git a/Documentation/gitbreaking-changes.adoc b/Documentation/gitbreaking-changes.adoc
index 410476c7993..e984c2c8ca5 100644
--- a/Documentation/gitbreaking-changes.adoc
+++ b/Documentation/gitbreaking-changes.adoc
@@ -54,20 +54,6 @@ breaking releases. Furthermore, this document also tracks what will _not_ be
 deprecated. This is done such that the outcome of discussions document both
 when the discussion favors deprecation, but also when it rejects a deprecation.
 
-Items should have a clear summary of the reasons why we do or do not want to
-make the described change that can be easily understood without having to read
-the mailing list discussions. If there are alternatives to the changed feature,
-those alternatives should be pointed out to our users.
-
-All items should be accompanied by links to relevant mailing list threads
-where the deprecation was discussed. These links use this format:
-
-  https://lore.kernel.org/git/$message_id/
-
-I.e. they link to the `Message-ID` of the email on the mailing
-list. These references are there to make it easier for you to find how
-the project reached consensus on the described item back then.
-
 This is a living document as the environment surrounding the project changes
 over time. If circumstances change, an earlier decision to deprecate or change
 something may need to be revisited from time to time. So do not take items on
@@ -140,7 +126,7 @@ There is no plan to deprecate the "sha1" object format at this point in time.
 +
 Cf. https://lore.kernel.org/git/2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com,
 https://lore.kernel.org/git/20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain,
-https://lore.kernel.org/git/CA%2BEOSBncr%3D4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE%2BDiUQ@mail.gmail.com/.
+https://lore.kernel.org/git/CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com.
 
 * The default storage format for references in newly created repositories will
   be changed from "files" to "reftable". The "reftable" format provides
@@ -341,7 +327,7 @@ The command will be removed.
 * Support for `core.commentString=auto` has been deprecated and will
   be removed in Git 3.0.
 +
-cf.  https://lore.kernel.org/git/xmqqa59i45wc.fsf@gitster.g
+cf. https://lore.kernel.org/git/xmqqa59i45wc.fsf@gitster.g
 
 * Support for `core.preferSymlinkRefs=true` has been deprecated and will be
   removed in Git 3.0. Writing symbolic refs as symbolic links will be phased
@@ -379,8 +365,24 @@ This decision may get revisited in case we ever figure out that there are
 almost no users of any of the commands anymore.
 +
 Cf. https://lore.kernel.org/git/xmqqttjazwwa.fsf@gitster.g,
-https://lore.kernel.org/git/xmqqleeubork.fsf@gitster.g,
-https://lore.kernel.org/git/112b6568912a6de6672bf5592c3a718e@manjaro.org.
+    https://lore.kernel.org/git/xmqqleeubork.fsf@gitster.g,
+    https://lore.kernel.org/git/112b6568912a6de6672bf5592c3a718e@manjaro.org.
+
+== Adding new items
+
+Items should have a clear summary of the reasons why we do or do not want to
+make the described change that can be easily understood without having to read
+the mailing list discussions. If there are alternatives to the changed feature,
+those alternatives should be pointed out to our users.
+
+All items should be accompanied by links to relevant mailing list threads
+where the deprecation was discussed. These links use this format:
+
+  https://lore.kernel.org/git/$message_id/
+
+I.e. they link to the `Message-ID` of the email on the mailing
+list. These references are there to make it easier for you to find how
+the project reached consensus on the described item back then.
 
 GIT
 ---
Range-diff against v1:
-:  ----------- > 1:  2b5d0b23a5a doc: BreakingChanges: transform to a manpage
1:  4f98172c30d ! 2:  476d8849135 doc: transform breaking changes doc to a manpage
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: transform breaking changes doc to a manpage
    +    doc: gitbreaking-changes: create from BreakingChanges
     
    -    The breaking changes document is not a regular Git documentation page.
    -    That means that you cannot navigate to the doc with git(1), i.e. with:
    +    We can rename to gitbreaking-changes(7) now that we have changed to
    +    the required format in the preceding commit.
     
    -        git help BreakingChanges
    -
    -    You instead have to download the Git project source. Or go to
    -    git-scm.com.[1] Then you get this disclaimer:[2]
    -
    -        This information is specific to the Git project
    -
    -        Please note that this information is only relevant to you if you
    -        plan on contributing to the Git project itself. It is in no shape or
    -        form required reading for regular Git users.
    -
    -    But this document is relevant to *all* Git users. Everyone should have
    -    as easy access to it as the other doc and guide pages.
    -
    -    To that end, let’s move the text to a manpage. But keep the old page,
    -    just linking to the new one. (We wouldn’t want to break any readers.)
    -
    -    Just do the minimal changes for the new format. Also demote the first
    -    section to the second level, i.e. make “Introduction” the same level
    -    as “Procedure’.
    -
    -    † 1: https://git-scm.com/docs/BreakingChanges.html
    -    † 2: Which I first mentioned in 098230f7 (you-still-use-that??: help the
    -         user help themselves, 2025-09-17), footnote #1.
    +    But we also need to keep `BreakingChanges.adoc` in order to point to
    +    the new document. That way old links and whatnot are still serviceable.
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/BreakingChanges.adoc ##
     @@
    --= Upcoming breaking changes
    +-gitbreaking-changes(7)
    +-======================
    +-
    +-NAME
    +-----
    +-gitbreaking-changes - Breaking changes for upcoming Git 3.0
    +-
    +-SYNOPSIS
    +---------
    +-*
    +-
    +-DESCRIPTION
    +------------
    +-*
    +-
    +-== Introduction: Upcoming breaking changes
     -
     -The Git project aims to ensure backwards compatibility to the best extent
     -possible. Minor releases will not break backwards compatibility unless there is
    @@ Documentation/BreakingChanges.adoc
     -Cf. <xmqqttjazwwa.fsf@gitster.g>,
     -<xmqqleeubork.fsf@gitster.g>,
     -<112b6568912a6de6672bf5592c3a718e@manjaro.org>.
    +-
    +-GIT
    +----
    +-Part of the linkgit:git[1] suite
     +This document as been moved to linkgit:gitbreaking-changes[7].
     
      ## Documentation/Makefile ##
    @@ Documentation/meson.build: manpages = {
        'gitcli.adoc' : 7,
        'gitcore-tutorial.adoc' : 7,
        'gitcredentials.adoc' : 7,
    +
    + ## command-list.txt ##
    +@@ command-list.txt: git-whatchanged                         ancillaryinterrogators          complete
    + git-worktree                            mainporcelain
    + git-write-tree                          plumbingmanipulators
    + gitattributes                           userinterfaces
    ++gitbreaking-changes                     guide
    + gitcli                                  userinterfaces
    + gitcore-tutorial                        guide
    + gitcredentials                          guide
2:  a6626aafac8 ! 3:  c8983aced71 doc: gitbreaking-changes: replace msg-ids with URLs
    @@ Commit message
     
         † 1: 57ec9254 (docs: introduce document to announce breaking changes, 2024-06-14)
     
    -    Note that we have to URL encode two msg-ids:
    +    Note that we have to URL encode this msg-id:
     
              CAKvOHKAFXQwt4D8yUCCkf_TQL79mYaJ=KAKhtpDNTvHJFuX1NA@mail.gmail.com
    +
    +    Lore can handle it just fine, but asciidoctor(1) cannot.
    +
    +    Worse yet, this msg-id can be handled by asciidoctor(1) but not by
    +    asciidoc:
    +
              CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com
     
    -    Lore can handle them just fine, but asciidoctor(1) cannot.
    +    URL encoding does not help. So compromise by linking to the only
    +    second-level reply:
    +
    +        CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com
    +
    +    Which properly quotes the first message. So no loss of fidelity in
    +    my opinion.
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    @@ Documentation/gitbreaking-changes.adoc: applications and forges.
     -<CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
     +Cf. https://lore.kernel.org/git/2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com,
     +https://lore.kernel.org/git/20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain,
    -+https://lore.kernel.org/git/CA%2BEOSBncr%3D4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE%2BDiUQ@mail.gmail.com/.
    ++https://lore.kernel.org/git/CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com.
      
      * The default storage format for references in newly created repositories will
        be changed from "files" to "reftable". The "reftable" format provides
    @@ Documentation/gitbreaking-changes.adoc: The command will be removed.
        be removed in Git 3.0.
      +
     -cf. <xmqqa59i45wc.fsf@gitster.g>
    -+cf.  https://lore.kernel.org/git/xmqqa59i45wc.fsf@gitster.g
    ++cf. https://lore.kernel.org/git/xmqqa59i45wc.fsf@gitster.g
      
      * Support for `core.preferSymlinkRefs=true` has been deprecated and will be
        removed in Git 3.0. Writing symbolic refs as symbolic links will be phased
    @@ Documentation/gitbreaking-changes.adoc: those features with newer alternatives.
     -<xmqqleeubork.fsf@gitster.g>,
     -<112b6568912a6de6672bf5592c3a718e@manjaro.org>.
     +Cf. https://lore.kernel.org/git/xmqqttjazwwa.fsf@gitster.g,
    -+https://lore.kernel.org/git/xmqqleeubork.fsf@gitster.g,
    -+https://lore.kernel.org/git/112b6568912a6de6672bf5592c3a718e@manjaro.org.
    ++    https://lore.kernel.org/git/xmqqleeubork.fsf@gitster.g,
    ++    https://lore.kernel.org/git/112b6568912a6de6672bf5592c3a718e@manjaro.org.
      
      GIT
      ---
3:  75397436eb9 = 4:  46f08bb65d9 doc: gitbreaking-changes: add note about living document
4:  9d14f13664f < -:  ----------- doc: git: mention gitbreaking-changes(7)
-:  ----------- > 5:  85fe7ebe89e doc: gitbreaking-changes: move new-items discussion to the end

base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
-- 
2.55.0.793.gc667de3f2c5

