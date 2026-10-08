Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A93CAE9B
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487693; cv=none; b=OZPk5sUWBaPqgH7iyCvjD2FUYPUt8NaieJr0ughI2gKnvFZNh/KBHqEEO4/KqD3gXdoFEjzFXTCA4q+m8z+phHsvGPMeuwTqwzsg/0o9yLdWA6x3G0tcc+AMcdjHRu0GTVrtYDBZQdqJFgrv/KpMI+qU7Gu2yjL6Z7XAy3pfsV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487693; c=relaxed/simple;
	bh=MVb40KjWnmUvAi40YT6i48TGMLTeddSkOg8ZZgRucwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9eHweQ1HlDHqa5tNAJ1l+IPy3mX8fcTntrSGGpcqsz/XLqm/lUI9IHrMLhjN9CIXvAy+DYlPOe5ZVaWQDvnvxjx7UXEU9i5Pw+PLh84e5ow9ND1ORutySfBoLEDgbHUowMXehLJvYf5U/s4kxir3kSf2OpB5Bt4QBAOjGXotFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QutmHEPJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lh8GDYmT; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QutmHEPJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lh8GDYmT"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 489ACEC032A
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 15:28:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 08 Oct 2026 15:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1791487688; x=
	1791574088; bh=VEpX6I8lFSLLdl96VG9kxIxAeeGvUVKwK7BFsK/7OrM=; b=Q
	utmHEPJmoC2Mwkqyjvo6kMJ0Y+tT8FYg6/RcuNzIDOFNC/ZO7vLvLh07yRvIQwzx
	ayqQ6al1HyhNYVrvXze7Y4Rm4GnraauxGapH5sBRomAOL1v9wRZwXZLqLAizG59t
	DwPdaKO4STpHvmtITBsSRA728dGPQNLAero4vWoQJA3CeAezwWk8NXqxKgLt3xvU
	kD8KLIYcGvy+H6vVd8BYSmoGJGgg6zOZMSl+uIZ5durHqoFau89tOiaRgSuyR8Ty
	RhmVRqIJTNrppRvrJmU4vRdJAcMDQdO9y0qJoqwPfxcAf3B6TNT0RxP8f/iFqbsp
	I1kqMEenetrNzgMwKH/fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791487688; x=1791574088; bh=V
	EpX6I8lFSLLdl96VG9kxIxAeeGvUVKwK7BFsK/7OrM=; b=Lh8GDYmTF+WhzDHfD
	/piJYoOu1MVtbqQp86+asVMtIbUtVNFhksHrIOods/bPwJznn2u7wcn7bvgHzMWF
	OYtoTxeP3+LbPKv2ZsKjr4NV3x72WINR6j1JzGZH5mlakoZzCGlV0ve2ra34HhBR
	/BUyeK/LVdq24qfPBpuH20gHen4sfHDBh0yyzrB0Q9vHaELmYtTlYiWetwfXYiMp
	zkjgSHCpyz54GmA7jEr6awoOy9/EH3I2AV9PCPItQBvMbNMn+msnkCsIeZmhgPpH
	2rjkcZjxiXUA8f5SnotFoOgyebunJw8va4AUNz7pUJiSNtErzqZuTUQm5ZCi384M
	jdPEQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791487688; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mmKjgAVsU1aoMvwAzWLL9LFqK9cw1XTbFneO1jw++tZEA3y
	4ZsOA/GzNvraRer58cytWRsDw1VdrQpCYLIN5fUkSpNJItjj1/ZO2tETgobCO/ui
	hx618oLq+4ilDtX4q6lU/II6vDBqu2zOnrkGK64mdROCEKTo0KB8jLVdXObEMc2A
	/raMzgUfsdRVbXBa8zM/LlhwdaOrdgsHwjULJNvq26v3eVXClI7b1FhunO9e59fF
	XI6a2HtSMecokVT+ruh4nQFkNTIzQMq0m64Xp+xrUeurpphTh2hZwE/OAaLGzlC0
	4HWMSJGlciGh6HcZTaV/qCawdUIu/FB0NlohLqg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yzRvqeuM5yiI1gMUzLmFXQHiw2wkYk3EGCUeOf8kH9M=:MVb40KjWnmUvAi40YT6i48TGMLTeddSkOg8ZZgRucwk=;
X-ME-Sender: <xms:yO7HatINZDjsuVws-63ftdmKOt3PsVcPKQYspSdWUu-hzvqGovy_BII>
    <xme:yO7HagJPyyOSXme4Op-fMNy-2AXc5XdQMqU3tRBn9RfZ10M2asFna20NMW3F5s2w9
    ZmbAsRlqNjYI3rNBeVLLgz0EGn0nQthb4yw5XTkyI8v9q_49_b8Fr0>
X-ME-Received: <xmr:yO7Haqt9Tuaz61MFivkZmUUkuL4cHpRVAbJafziT9T1XOEfDbk0TVlmQe4kZMTPdzO6EobvkeeKypjBjRS74ovnQg_JqOZEwzaF_SdtI586XTczG4eqv-xs>
X-ME-Proxy-Cause: dmFkZTEWAaJMLKueBwZym4MBQZ6tH1f0yp0p6G5vfw/COzGwSSfxqowK33cMH8T2SwjFDW
    m2iPcqmcJ1awNTdL/wIJHdaQoUnxwcN2kYeoAfDChjje1JPK482fUtGalEBt5bgDq/ALW2
    T8cQI4xmTZR0pFYDoz0dIhlWRA42en54ezpxcRdv52r4KR8ceWOMuz31YyojmgcHLj0mVi
    AurDh+Qa34wfAtPlvEk8P8Pl0uFpFmrCSM42L9dqwpEWS2YfmcjftNGGsLauKKI0aqpmG2
    l1TvRLfLiZ6o3Ojc+sUVtlxBiswo7K4DeGI2I9wGqImeUReaWRWkMzgB3oI7SlPAO3aAtR
    qno8V1MtZnUWq4o3dmRtrffAq3RRNy8uV3vh9pYAe3GY4T/zt7uP1MNngmmGP5jYmbjsPS
    757McMR24BNpLBrIzjlgPqX5YMAIE0SVL0gjgjYNmfWxAxxrcnIYb77wR/Ec33NlP3PZzX
    Dt9RNk1KcVGRMbpjwZVtUYtftslfD0cOxPjCEBHdbgXu4+++WnekW/rYKYCqharI8vzL9k
    C3LpkBlrJHq09QQZGzlfOE0zSxQwspcz3Kna/7A19Nhlk6FdcQsWyBr1e4sS2rpFaDCMG1
    pOXTIeU0tBtu9tqLGGmNwOeugTmPIvWBJWHZnihvfycURBBPais/uku0BaHg
X-ME-Proxy: <xmx:yO7HatQxF5HOiMrF41Xb0biYWkG_2J0ubjiBLqxrX8JxT9Av9YYUfQ>
    <xmx:yO7HagPlVRJoLcZKXMl_s4qRldX0gRhGb6d9s-rZaImovrRHlN1oNw>
    <xmx:yO7HaiaCrQF0mvku6pxgszoej7UBNHUw-IDPyj8P8dFGGtCDZa2FVw>
    <xmx:yO7HaqyhwRBduSFDs97dabIPC75IiJT5tQJCRSjLQ0OJQb1tnJe1WQ>
    <xmx:yO7HapUjixJw5xqUcM4OAuIOKKxoPsg0f2YartiJ3bAW_NyrSxRW2Hu6>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 15:28:07 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/5] doc: gitbreaking-changes: create from BreakingChanges
Date: Thu,  8 Oct 2026 21:27:17 +0200
Message-ID: <V2_URLs_not_just_msg_ids.dc6@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz> <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We can rename to gitbreaking-changes(7) now that we have changed to
the required format in the preceding commit.

But we also need to keep `BreakingChanges.adoc` in order to point to
the new document. That way old links and whatnot are still serviceable.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/BreakingChanges.adoc     | 379 +------------------------
 Documentation/Makefile                 |   1 +
 Documentation/gitbreaking-changes.adoc | 378 ++++++++++++++++++++++++
 Documentation/meson.build              |   1 +
 command-list.txt                       |   1 +
 5 files changed, 382 insertions(+), 378 deletions(-)
 create mode 100644 Documentation/gitbreaking-changes.adoc

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index c6b974b6d8c..d35850a08e4 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -1,378 +1 @@
-gitbreaking-changes(7)
-======================
-
-NAME
-----
-gitbreaking-changes - Breaking changes for upcoming Git 3.0
-
-SYNOPSIS
---------
-*
-
-DESCRIPTION
------------
-*
-
-== Introduction: Upcoming breaking changes
-
-The Git project aims to ensure backwards compatibility to the best extent
-possible. Minor releases will not break backwards compatibility unless there is
-a very strong reason to do so, like for example a security vulnerability.
-
-Regardless of that, due to the age of the Git project, it is only natural to
-accumulate a backlog of backwards-incompatible changes that will eventually be
-required to keep the project aligned with a changing world. These changes fall
-into several categories:
-
-* Changes to long established defaults.
-* Concepts that have been replaced with a superior design.
-* Concepts, commands, configuration or options that have been lacking in major
-  ways and that cannot be fixed and which will thus be removed without any
-  replacement.
-
-Explicitly not included in this list are fixes to minor bugs that may cause a
-change in user-visible behavior.
-
-The Git project irregularly releases breaking versions that deliberately break
-backwards compatibility with older versions. This is done to ensure that Git
-remains relevant, safe and maintainable going forward. The release cadence of
-breaking versions is typically measured in multiple years. We had the following
-major breaking releases in the past:
-
-* Git 1.6.0, released in August 2008.
-* Git 2.0, released in May 2014.
-
-We use <major>.<minor> release numbers these days, starting from Git 2.0. For
-future releases, our plan is to increment <major> in the release number when we
-make the next breaking release. Before Git 2.0, the release numbers were
-1.<major>.<minor> with the intention to increment <major> for "usual" breaking
-releases, reserving the jump to Git 2.0 for really large backward-compatibility
-breaking changes.
-
-The intent of this document is to track upcoming deprecations for future
-breaking releases. Furthermore, this document also tracks what will _not_ be
-deprecated. This is done such that the outcome of discussions document both
-when the discussion favors deprecation, but also when it rejects a deprecation.
-
-Items should have a clear summary of the reasons why we do or do not want to
-make the described change that can be easily understood without having to read
-the mailing list discussions. If there are alternatives to the changed feature,
-those alternatives should be pointed out to our users.
-
-All items should be accompanied by references to relevant mailing list threads
-where the deprecation was discussed. These references use message-IDs, which
-can visited via
-
-  https://lore.kernel.org/git/$message_id/
-
-to see the message and its surrounding discussion. Such a reference is there to
-make it easier for you to find how the project reached consensus on the
-described item back then.
-
-This is a living document as the environment surrounding the project changes
-over time. If circumstances change, an earlier decision to deprecate or change
-something may need to be revisited from time to time. So do not take items on
-this list to mean "it is settled, do not waste our time bringing it up again".
-
-== Procedure
-
-Discussing the desire to make breaking changes, declaring that breaking
-changes are made at a certain version boundary, and recording these
-decisions in this document, are necessary but not sufficient.
-Because such changes are expected to be numerous, and the design and
-implementation of them are expected to span over time, they have to
-be deployable trivially at such a version boundary, prepared over long
-time.
-
-The breaking changes MUST be guarded with the a compile-time switch,
-WITH_BREAKING_CHANGES, to help this process.  When built with it,
-the resulting Git binary together with its documentation would
-behave as if these breaking changes slated for the next big version
-boundary are already in effect.  We also have a CI job to exercise
-the work-in-progress version of Git with these breaking changes.
-
-
-== Git 3.0
-
-The following subsections document upcoming breaking changes for Git 3.0. There
-is no planned release date for this breaking version yet.
-
-Proposed changes and removals only include items which are "ready" to be done.
-In other words, this is not supposed to be a wishlist of features that should
-be changed to or replaced in case the alternative was implemented already.
-
-=== Changes
-
-* The default hash function for new repositories will be changed from "sha1"
-  to "sha256". SHA-1 has been deprecated by NIST in 2011 and is nowadays
-  recommended against in FIPS 140-2 and similar certifications. Furthermore,
-  there are practical attacks on SHA-1 that weaken its cryptographic properties:
-+
-  ** The SHAppening (2015). The first demonstration of a practical attack
-     against SHA-1 with 2^57 operations.
-  ** SHAttered (2017). Generation of two valid PDF files with 2^63 operations.
-  ** Birthday-Near-Collision (2019). This attack allows for chosen prefix
-     attacks with 2^68 operations.
-  ** Shambles (2020). This attack allows for chosen prefix attacks with 2^63
-     operations.
-+
-While we have protections in place against known attacks, it is expected
-that more attacks against SHA-1 will be found by future research. Paired
-with the ever-growing capability of hardware, it is only a matter of time
-before SHA-1 will be considered broken completely. We want to be prepared
-and will thus change the default hash algorithm to "sha256" for newly
-initialized repositories.
-+
-An important requirement for this change is that the ecosystem is ready to
-support the "sha256" object format. This includes popular Git libraries,
-applications and forges.
-+
-There is no plan to deprecate the "sha1" object format at this point in time.
-+
-Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
-<20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
-<CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
-
-* The default storage format for references in newly created repositories will
-  be changed from "files" to "reftable". The "reftable" format provides
-  multiple advantages over the "files" format:
-+
-  ** It is impossible to store two references that only differ in casing on
-     case-insensitive filesystems with the "files" format. This issue is common
-     on Windows and macOS platforms. As the "reftable" backend does not use
-     filesystem paths to encode reference names this problem goes away.
-  ** Similarly, macOS normalizes path names that contain unicode characters,
-     which has the consequence that you cannot store two names with unicode
-     characters that are encoded differently with the "files" backend. Again,
-     this is not an issue with the "reftable" backend.
-  ** Deleting references with the "files" backend requires Git to rewrite the
-     complete "packed-refs" file. In large repositories with many references
-     this file can easily be dozens of megabytes in size, in extreme cases it
-     may be gigabytes. The "reftable" backend uses tombstone markers for
-     deleted references and thus does not have to rewrite all of its data.
-  ** Repository housekeeping with the "files" backend typically performs
-     all-into-one repacks of references. This can be quite expensive, and
-     consequently housekeeping is a tradeoff between the number of loose
-     references that accumulate and slow down operations that read references,
-     and compressing those loose references into the "packed-refs" file. The
-     "reftable" backend uses geometric compaction after every write, which
-     amortizes costs and ensures that the backend is always in a
-     well-maintained state.
-  ** Operations that write multiple references at once are not atomic with the
-     "files" backend. Consequently, Git may see in-between states when it reads
-     references while a reference transaction is in the process of being
-     committed to disk.
-  ** Writing many references at once is slow with the "files" backend because
-     every reference is created as a separate file. The "reftable" backend
-     significantly outperforms the "files" backend by multiple orders of
-     magnitude.
-  ** The reftable backend uses a binary format with prefix compression for
-     reference names. As a result, the format uses less space compared to the
-     "packed-refs" file.
-+
-Users that get immediate benefit from the "reftable" backend could continue to
-opt-in to the "reftable" format manually by setting the "init.defaultRefFormat"
-config. But defaults matter, and we think that overall users will have a better
-experience with less platform-specific quirks when they use the new backend by
-default.
-+
-A prerequisite for this change is that the ecosystem is ready to support the
-"reftable" format. Most importantly, alternative implementations of Git like
-JGit, libgit2 and Gitoxide need to support it.
-
-* In new repositories, the default branch name will be `main`. We have been
-  warning that the default name will change since 675704c74dd (init:
-  provide useful advice about init.defaultBranch, 2020-12-11).  The new name
-  matches the default branch name used in new repositories by many of the
-  big Git forges.
-
-* Git will require Rust as a mandatory part of the build process. While Git
-  already started to adopt Rust in Git 2.49, all parts written in Rust are
-  optional for the time being. This includes:
-+
-  ** The Rust wrapper around libgit.a that is part of "contrib/" and which has
-     been introduced in Git 2.49.
-  ** Subsystems that have an alternative implementation in Rust to test
-     interoperability between our C and Rust codebase.
-  ** Newly written features that are not mission critical for a fully functional
-     Git client.
-+
-These changes are meant as test balloons to allow distributors of Git to prepare
-for Rust becoming a mandatory part of the build process. There will be multiple
-milestones for the introduction of Rust:
-+
---
-1. Initially, with Git 2.52, support for Rust will be auto-detected by Meson and
-   disabled in our Makefile so that the project can sort out the initial
-   infrastructure.
-2. In Git 2.55, both build systems will default-enable support for Rust.
-   Consequently, builds will break by default if Rust is not available on the
-   build host. The use of Rust can still be explicitly disabled via build
-   flags.
-3. In Git 3.0, the build options will be removed and support for Rust is
-   mandatory.
---
-+
-You can explicitly ask both Meson and our Makefile-based system to enable Rust
-by saying `meson configure -Drust=enabled` and `make WITH_RUST=YesPlease`,
-respectively.
-+
-The Git project will declare the last version before Git 3.0 to be a long-term
-support release. This long-term release will receive important bug fixes for at
-least four release cycles and security fixes for six release cycles. The Git
-project will hand over maintainership of the long-term release to distributors
-in case they need to extend the life of that long-term release even further.
-Details of how this long-term release will be handed over to the community will
-be discussed once the Git project decides to stop officially supporting it.
-+
-We will evaluate the impact on downstream distributions before making Rust
-mandatory in Git 3.0. If we see that the impact on downstream distributions
-would be significant, we may decide to defer this change to a subsequent minor
-release. This evaluation will also take into account our own experience with
-how painful it is to keep Rust an optional component.
-
-* The default value of `safe.bareRepository` will change from `all` to
-  `explicit`. It is all too easy for an attacker to trick a user into cloning a
-  repository that contains an embedded bare repository with malicious hooks
-  configured. If the user enters that subdirectory and runs any Git command, Git
-  discovers the bare repository and the hooks fire. The user does not even need
-  to run a Git command explicitly: many shell prompts run `git status` in the
-  background to display branch and dirty state information, and `git status` in
-  turn may invoke the fsmonitor hook if so configured, making the user
-  vulnerable the moment they `cd` into the directory. The `safe.bareRepository`
-  configuration variable was introduced in 8959555cee (setup_git_directory():
-  add an owner check for the top-level directory, 2022-03-02) with a default of
-  `all` to preserve backwards compatibility.
-+
-Changing the default to `explicit` means that Git will refuse to work with bare
-repositories that are discovered implicitly by walking up the directory tree.
-Bare repositories specified explicitly via the `--git-dir` command-line option
-or the `GIT_DIR` environment variable continue to work regardless of this
-setting. Repositories that look like a `.git` directory, a worktree, or a
-submodule directory are also unaffected.
-+
-Users who rely on implicit discovery of bare repositories can restore the
-previous behavior by setting `safe.bareRepository=all` in their global or
-system configuration.
-
-=== Removals
-
-* Support for grafting commits has long been superseded by git-replace(1).
-  Grafts are inferior to replacement refs:
-+
-  ** Grafts are a local-only mechanism and cannot be shared across
-     repositories.
-  ** Grafts can lead to hard-to-diagnose problems when transferring objects
-     between repositories.
-+
-The grafting mechanism has been marked as outdated since e650d0643b (docs: mark
-info/grafts as outdated, 2014-03-05) and will be removed.
-+
-Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
-
-* The git-pack-redundant(1) command can be used to remove redundant pack files.
-  The subcommand is unusably slow and the reason why nobody reports it as a
-  performance bug is suspected to be the absence of users. We have nominated
-  the command for removal and have started to emit a user-visible warning in
-  c3b58472be (pack-redundant: gauge the usage before proposing its removal,
-  2020-08-25) whenever the command is executed.
-+
-So far there was a single complaint about somebody still using the command, but
-that complaint did not cause us to reverse course. On the contrary, we have
-doubled down on the deprecation and starting with 4406522b76 (pack-redundant:
-escalate deprecation warning to an error, 2023-03-23), the command dies unless
-the user passes the `--i-still-use-this` option.
-+
-There have not been any subsequent complaints, so this command will finally be
-removed.
-+
-Cf. <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>,
-    <CAKvOHKAFXQwt4D8yUCCkf_TQL79mYaJ=KAKhtpDNTvHJFuX1NA@mail.gmail.com>,
-    <20230323204047.GA9290@coredump.intra.peff.net>,
-
-* Support for storing shorthands for remote URLs in "$GIT_COMMON_DIR/branches/"
-  and "$GIT_COMMON_DIR/remotes/" has been long superseded by storing remotes in
-  the repository configuration.
-+
-The mechanism has originally been introduced in f170e4b39d ([PATCH] fetch/pull:
-short-hand notation for remote repositories., 2005-07-16) and was superseded by
-6687f8fea2 ([PATCH] Use .git/remote/origin, not .git/branches/origin.,
-2005-08-20), where we switched from ".git/branches/" to ".git/remotes/". That
-commit already mentions an upcoming deprecation of the ".git/branches/"
-directory, and starting with a1d4aa7424 (Add repository-layout document.,
-2005-09-01) we have also marked this layout as deprecated. Eventually we also
-started to migrate away from ".git/remotes/" in favor of config-based remotes,
-and we have marked the directory as legacy in 3d3d282146 (Documentation:
-Grammar correction, wording fixes and cleanup, 2011-08-23)
-+
-As our documentation mentions, these directories are unlikely to be used in
-modern repositories and most users aren't even aware of these mechanisms. They
-have been deprecated for almost 20 years and 14 years respectively, and we are
-not aware of any active users that have complained about this deprecation.
-Furthermore, the ".git/branches/" directory is nowadays misleadingly named and
-may cause confusion as "branches" are almost exclusively used in the context of
-references.
-+
-These features will be removed.
-
-* Support for "--stdin" option in the "name-rev" command was
-  deprecated (and hidden from the documentation) in the Git 2.40
-  timeframe, in preference to its synonym "--annotate-stdin".  Git 3.0
-  removes the support for "--stdin" altogether.
-
-* The git-whatchanged(1) command has outlived its usefulness more than
-  10 years ago, and takes more keystrokes to type than its rough
-  equivalent `git log --raw`.  We have nominated the command for
-  removal, have changed the command to refuse to work unless the
-  `--i-still-use-this` option is given, and asked the users to report
-  when they do so.
-+
-The command will be removed.
-
-* Support for `core.commentString=auto` has been deprecated and will
-  be removed in Git 3.0.
-+
-cf. <xmqqa59i45wc.fsf@gitster.g>
-
-* Support for `core.preferSymlinkRefs=true` has been deprecated and will be
-  removed in Git 3.0. Writing symbolic refs as symbolic links will be phased
-  out in favor of using plain files using the textual representation of
-  symbolic refs.
-+
-Symbolic references were initially always stored as a symbolic link. This was
-changed in 9b143c6e15 (Teach update-ref about a symbolic ref stored in a
-textfile., 2005-09-25), where a new textual symref format was introduced to
-store those symbolic refs in a plain file. In 9f0bb90d16
-(core.prefersymlinkrefs: use symlinks for .git/HEAD, 2006-05-02), the Git
-project switched the default to use the textual symrefs in favor of symbolic
-links.
-+
-The migration away from symbolic links has happened almost 20 years ago by now,
-and there is no known reason why one should prefer them nowadays. Furthermore,
-symbolic links are not supported on some platforms.
-+
-Note that only the writing side for such symbolic links is deprecated. Reading
-such symbolic links is still supported for now.
-
-== Superseded features that will not be deprecated
-
-Some features have gained newer replacements that aim to improve the design in
-certain ways. The fact that there is a replacement does not automatically mean
-that the old way of doing things will eventually be removed. This section tracks
-those features with newer alternatives.
-
-* The features git-checkout(1) offers are covered by the pair of commands
-  git-restore(1) and git-switch(1). Because the use of git-checkout(1) is still
-  widespread, and it is not expected that this will change anytime soon, all
-  three commands will stay.
-+
-This decision may get revisited in case we ever figure out that there are
-almost no users of any of the commands anymore.
-+
-Cf. <xmqqttjazwwa.fsf@gitster.g>,
-<xmqqleeubork.fsf@gitster.g>,
-<112b6568912a6de6672bf5592c3a718e@manjaro.org>.
-
-GIT
----
-Part of the linkgit:git[1] suite
+This document as been moved to linkgit:gitbreaking-changes[7].
diff --git a/Documentation/Makefile b/Documentation/Makefile
index f8dea4b3953..8b0390ac0fc 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -49,6 +49,7 @@ MAN5_TXT += gitprotocol-v2.adoc
 MAN5_TXT += gitrepository-layout.adoc
 MAN5_TXT += gitweb.conf.adoc
 
+MAN7_TXT += gitbreaking-changes.adoc
 MAN7_TXT += gitcli.adoc
 MAN7_TXT += gitcore-tutorial.adoc
 MAN7_TXT += gitcredentials.adoc
diff --git a/Documentation/gitbreaking-changes.adoc b/Documentation/gitbreaking-changes.adoc
new file mode 100644
index 00000000000..c6b974b6d8c
--- /dev/null
+++ b/Documentation/gitbreaking-changes.adoc
@@ -0,0 +1,378 @@
+gitbreaking-changes(7)
+======================
+
+NAME
+----
+gitbreaking-changes - Breaking changes for upcoming Git 3.0
+
+SYNOPSIS
+--------
+*
+
+DESCRIPTION
+-----------
+*
+
+== Introduction: Upcoming breaking changes
+
+The Git project aims to ensure backwards compatibility to the best extent
+possible. Minor releases will not break backwards compatibility unless there is
+a very strong reason to do so, like for example a security vulnerability.
+
+Regardless of that, due to the age of the Git project, it is only natural to
+accumulate a backlog of backwards-incompatible changes that will eventually be
+required to keep the project aligned with a changing world. These changes fall
+into several categories:
+
+* Changes to long established defaults.
+* Concepts that have been replaced with a superior design.
+* Concepts, commands, configuration or options that have been lacking in major
+  ways and that cannot be fixed and which will thus be removed without any
+  replacement.
+
+Explicitly not included in this list are fixes to minor bugs that may cause a
+change in user-visible behavior.
+
+The Git project irregularly releases breaking versions that deliberately break
+backwards compatibility with older versions. This is done to ensure that Git
+remains relevant, safe and maintainable going forward. The release cadence of
+breaking versions is typically measured in multiple years. We had the following
+major breaking releases in the past:
+
+* Git 1.6.0, released in August 2008.
+* Git 2.0, released in May 2014.
+
+We use <major>.<minor> release numbers these days, starting from Git 2.0. For
+future releases, our plan is to increment <major> in the release number when we
+make the next breaking release. Before Git 2.0, the release numbers were
+1.<major>.<minor> with the intention to increment <major> for "usual" breaking
+releases, reserving the jump to Git 2.0 for really large backward-compatibility
+breaking changes.
+
+The intent of this document is to track upcoming deprecations for future
+breaking releases. Furthermore, this document also tracks what will _not_ be
+deprecated. This is done such that the outcome of discussions document both
+when the discussion favors deprecation, but also when it rejects a deprecation.
+
+Items should have a clear summary of the reasons why we do or do not want to
+make the described change that can be easily understood without having to read
+the mailing list discussions. If there are alternatives to the changed feature,
+those alternatives should be pointed out to our users.
+
+All items should be accompanied by references to relevant mailing list threads
+where the deprecation was discussed. These references use message-IDs, which
+can visited via
+
+  https://lore.kernel.org/git/$message_id/
+
+to see the message and its surrounding discussion. Such a reference is there to
+make it easier for you to find how the project reached consensus on the
+described item back then.
+
+This is a living document as the environment surrounding the project changes
+over time. If circumstances change, an earlier decision to deprecate or change
+something may need to be revisited from time to time. So do not take items on
+this list to mean "it is settled, do not waste our time bringing it up again".
+
+== Procedure
+
+Discussing the desire to make breaking changes, declaring that breaking
+changes are made at a certain version boundary, and recording these
+decisions in this document, are necessary but not sufficient.
+Because such changes are expected to be numerous, and the design and
+implementation of them are expected to span over time, they have to
+be deployable trivially at such a version boundary, prepared over long
+time.
+
+The breaking changes MUST be guarded with the a compile-time switch,
+WITH_BREAKING_CHANGES, to help this process.  When built with it,
+the resulting Git binary together with its documentation would
+behave as if these breaking changes slated for the next big version
+boundary are already in effect.  We also have a CI job to exercise
+the work-in-progress version of Git with these breaking changes.
+
+
+== Git 3.0
+
+The following subsections document upcoming breaking changes for Git 3.0. There
+is no planned release date for this breaking version yet.
+
+Proposed changes and removals only include items which are "ready" to be done.
+In other words, this is not supposed to be a wishlist of features that should
+be changed to or replaced in case the alternative was implemented already.
+
+=== Changes
+
+* The default hash function for new repositories will be changed from "sha1"
+  to "sha256". SHA-1 has been deprecated by NIST in 2011 and is nowadays
+  recommended against in FIPS 140-2 and similar certifications. Furthermore,
+  there are practical attacks on SHA-1 that weaken its cryptographic properties:
++
+  ** The SHAppening (2015). The first demonstration of a practical attack
+     against SHA-1 with 2^57 operations.
+  ** SHAttered (2017). Generation of two valid PDF files with 2^63 operations.
+  ** Birthday-Near-Collision (2019). This attack allows for chosen prefix
+     attacks with 2^68 operations.
+  ** Shambles (2020). This attack allows for chosen prefix attacks with 2^63
+     operations.
++
+While we have protections in place against known attacks, it is expected
+that more attacks against SHA-1 will be found by future research. Paired
+with the ever-growing capability of hardware, it is only a matter of time
+before SHA-1 will be considered broken completely. We want to be prepared
+and will thus change the default hash algorithm to "sha256" for newly
+initialized repositories.
++
+An important requirement for this change is that the ecosystem is ready to
+support the "sha256" object format. This includes popular Git libraries,
+applications and forges.
++
+There is no plan to deprecate the "sha1" object format at this point in time.
++
+Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
+<20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
+<CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
+
+* The default storage format for references in newly created repositories will
+  be changed from "files" to "reftable". The "reftable" format provides
+  multiple advantages over the "files" format:
++
+  ** It is impossible to store two references that only differ in casing on
+     case-insensitive filesystems with the "files" format. This issue is common
+     on Windows and macOS platforms. As the "reftable" backend does not use
+     filesystem paths to encode reference names this problem goes away.
+  ** Similarly, macOS normalizes path names that contain unicode characters,
+     which has the consequence that you cannot store two names with unicode
+     characters that are encoded differently with the "files" backend. Again,
+     this is not an issue with the "reftable" backend.
+  ** Deleting references with the "files" backend requires Git to rewrite the
+     complete "packed-refs" file. In large repositories with many references
+     this file can easily be dozens of megabytes in size, in extreme cases it
+     may be gigabytes. The "reftable" backend uses tombstone markers for
+     deleted references and thus does not have to rewrite all of its data.
+  ** Repository housekeeping with the "files" backend typically performs
+     all-into-one repacks of references. This can be quite expensive, and
+     consequently housekeeping is a tradeoff between the number of loose
+     references that accumulate and slow down operations that read references,
+     and compressing those loose references into the "packed-refs" file. The
+     "reftable" backend uses geometric compaction after every write, which
+     amortizes costs and ensures that the backend is always in a
+     well-maintained state.
+  ** Operations that write multiple references at once are not atomic with the
+     "files" backend. Consequently, Git may see in-between states when it reads
+     references while a reference transaction is in the process of being
+     committed to disk.
+  ** Writing many references at once is slow with the "files" backend because
+     every reference is created as a separate file. The "reftable" backend
+     significantly outperforms the "files" backend by multiple orders of
+     magnitude.
+  ** The reftable backend uses a binary format with prefix compression for
+     reference names. As a result, the format uses less space compared to the
+     "packed-refs" file.
++
+Users that get immediate benefit from the "reftable" backend could continue to
+opt-in to the "reftable" format manually by setting the "init.defaultRefFormat"
+config. But defaults matter, and we think that overall users will have a better
+experience with less platform-specific quirks when they use the new backend by
+default.
++
+A prerequisite for this change is that the ecosystem is ready to support the
+"reftable" format. Most importantly, alternative implementations of Git like
+JGit, libgit2 and Gitoxide need to support it.
+
+* In new repositories, the default branch name will be `main`. We have been
+  warning that the default name will change since 675704c74dd (init:
+  provide useful advice about init.defaultBranch, 2020-12-11).  The new name
+  matches the default branch name used in new repositories by many of the
+  big Git forges.
+
+* Git will require Rust as a mandatory part of the build process. While Git
+  already started to adopt Rust in Git 2.49, all parts written in Rust are
+  optional for the time being. This includes:
++
+  ** The Rust wrapper around libgit.a that is part of "contrib/" and which has
+     been introduced in Git 2.49.
+  ** Subsystems that have an alternative implementation in Rust to test
+     interoperability between our C and Rust codebase.
+  ** Newly written features that are not mission critical for a fully functional
+     Git client.
++
+These changes are meant as test balloons to allow distributors of Git to prepare
+for Rust becoming a mandatory part of the build process. There will be multiple
+milestones for the introduction of Rust:
++
+--
+1. Initially, with Git 2.52, support for Rust will be auto-detected by Meson and
+   disabled in our Makefile so that the project can sort out the initial
+   infrastructure.
+2. In Git 2.55, both build systems will default-enable support for Rust.
+   Consequently, builds will break by default if Rust is not available on the
+   build host. The use of Rust can still be explicitly disabled via build
+   flags.
+3. In Git 3.0, the build options will be removed and support for Rust is
+   mandatory.
+--
++
+You can explicitly ask both Meson and our Makefile-based system to enable Rust
+by saying `meson configure -Drust=enabled` and `make WITH_RUST=YesPlease`,
+respectively.
++
+The Git project will declare the last version before Git 3.0 to be a long-term
+support release. This long-term release will receive important bug fixes for at
+least four release cycles and security fixes for six release cycles. The Git
+project will hand over maintainership of the long-term release to distributors
+in case they need to extend the life of that long-term release even further.
+Details of how this long-term release will be handed over to the community will
+be discussed once the Git project decides to stop officially supporting it.
++
+We will evaluate the impact on downstream distributions before making Rust
+mandatory in Git 3.0. If we see that the impact on downstream distributions
+would be significant, we may decide to defer this change to a subsequent minor
+release. This evaluation will also take into account our own experience with
+how painful it is to keep Rust an optional component.
+
+* The default value of `safe.bareRepository` will change from `all` to
+  `explicit`. It is all too easy for an attacker to trick a user into cloning a
+  repository that contains an embedded bare repository with malicious hooks
+  configured. If the user enters that subdirectory and runs any Git command, Git
+  discovers the bare repository and the hooks fire. The user does not even need
+  to run a Git command explicitly: many shell prompts run `git status` in the
+  background to display branch and dirty state information, and `git status` in
+  turn may invoke the fsmonitor hook if so configured, making the user
+  vulnerable the moment they `cd` into the directory. The `safe.bareRepository`
+  configuration variable was introduced in 8959555cee (setup_git_directory():
+  add an owner check for the top-level directory, 2022-03-02) with a default of
+  `all` to preserve backwards compatibility.
++
+Changing the default to `explicit` means that Git will refuse to work with bare
+repositories that are discovered implicitly by walking up the directory tree.
+Bare repositories specified explicitly via the `--git-dir` command-line option
+or the `GIT_DIR` environment variable continue to work regardless of this
+setting. Repositories that look like a `.git` directory, a worktree, or a
+submodule directory are also unaffected.
++
+Users who rely on implicit discovery of bare repositories can restore the
+previous behavior by setting `safe.bareRepository=all` in their global or
+system configuration.
+
+=== Removals
+
+* Support for grafting commits has long been superseded by git-replace(1).
+  Grafts are inferior to replacement refs:
++
+  ** Grafts are a local-only mechanism and cannot be shared across
+     repositories.
+  ** Grafts can lead to hard-to-diagnose problems when transferring objects
+     between repositories.
++
+The grafting mechanism has been marked as outdated since e650d0643b (docs: mark
+info/grafts as outdated, 2014-03-05) and will be removed.
++
+Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
+
+* The git-pack-redundant(1) command can be used to remove redundant pack files.
+  The subcommand is unusably slow and the reason why nobody reports it as a
+  performance bug is suspected to be the absence of users. We have nominated
+  the command for removal and have started to emit a user-visible warning in
+  c3b58472be (pack-redundant: gauge the usage before proposing its removal,
+  2020-08-25) whenever the command is executed.
++
+So far there was a single complaint about somebody still using the command, but
+that complaint did not cause us to reverse course. On the contrary, we have
+doubled down on the deprecation and starting with 4406522b76 (pack-redundant:
+escalate deprecation warning to an error, 2023-03-23), the command dies unless
+the user passes the `--i-still-use-this` option.
++
+There have not been any subsequent complaints, so this command will finally be
+removed.
++
+Cf. <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>,
+    <CAKvOHKAFXQwt4D8yUCCkf_TQL79mYaJ=KAKhtpDNTvHJFuX1NA@mail.gmail.com>,
+    <20230323204047.GA9290@coredump.intra.peff.net>,
+
+* Support for storing shorthands for remote URLs in "$GIT_COMMON_DIR/branches/"
+  and "$GIT_COMMON_DIR/remotes/" has been long superseded by storing remotes in
+  the repository configuration.
++
+The mechanism has originally been introduced in f170e4b39d ([PATCH] fetch/pull:
+short-hand notation for remote repositories., 2005-07-16) and was superseded by
+6687f8fea2 ([PATCH] Use .git/remote/origin, not .git/branches/origin.,
+2005-08-20), where we switched from ".git/branches/" to ".git/remotes/". That
+commit already mentions an upcoming deprecation of the ".git/branches/"
+directory, and starting with a1d4aa7424 (Add repository-layout document.,
+2005-09-01) we have also marked this layout as deprecated. Eventually we also
+started to migrate away from ".git/remotes/" in favor of config-based remotes,
+and we have marked the directory as legacy in 3d3d282146 (Documentation:
+Grammar correction, wording fixes and cleanup, 2011-08-23)
++
+As our documentation mentions, these directories are unlikely to be used in
+modern repositories and most users aren't even aware of these mechanisms. They
+have been deprecated for almost 20 years and 14 years respectively, and we are
+not aware of any active users that have complained about this deprecation.
+Furthermore, the ".git/branches/" directory is nowadays misleadingly named and
+may cause confusion as "branches" are almost exclusively used in the context of
+references.
++
+These features will be removed.
+
+* Support for "--stdin" option in the "name-rev" command was
+  deprecated (and hidden from the documentation) in the Git 2.40
+  timeframe, in preference to its synonym "--annotate-stdin".  Git 3.0
+  removes the support for "--stdin" altogether.
+
+* The git-whatchanged(1) command has outlived its usefulness more than
+  10 years ago, and takes more keystrokes to type than its rough
+  equivalent `git log --raw`.  We have nominated the command for
+  removal, have changed the command to refuse to work unless the
+  `--i-still-use-this` option is given, and asked the users to report
+  when they do so.
++
+The command will be removed.
+
+* Support for `core.commentString=auto` has been deprecated and will
+  be removed in Git 3.0.
++
+cf. <xmqqa59i45wc.fsf@gitster.g>
+
+* Support for `core.preferSymlinkRefs=true` has been deprecated and will be
+  removed in Git 3.0. Writing symbolic refs as symbolic links will be phased
+  out in favor of using plain files using the textual representation of
+  symbolic refs.
++
+Symbolic references were initially always stored as a symbolic link. This was
+changed in 9b143c6e15 (Teach update-ref about a symbolic ref stored in a
+textfile., 2005-09-25), where a new textual symref format was introduced to
+store those symbolic refs in a plain file. In 9f0bb90d16
+(core.prefersymlinkrefs: use symlinks for .git/HEAD, 2006-05-02), the Git
+project switched the default to use the textual symrefs in favor of symbolic
+links.
++
+The migration away from symbolic links has happened almost 20 years ago by now,
+and there is no known reason why one should prefer them nowadays. Furthermore,
+symbolic links are not supported on some platforms.
++
+Note that only the writing side for such symbolic links is deprecated. Reading
+such symbolic links is still supported for now.
+
+== Superseded features that will not be deprecated
+
+Some features have gained newer replacements that aim to improve the design in
+certain ways. The fact that there is a replacement does not automatically mean
+that the old way of doing things will eventually be removed. This section tracks
+those features with newer alternatives.
+
+* The features git-checkout(1) offers are covered by the pair of commands
+  git-restore(1) and git-switch(1). Because the use of git-checkout(1) is still
+  widespread, and it is not expected that this will change anytime soon, all
+  three commands will stay.
++
+This decision may get revisited in case we ever figure out that there are
+almost no users of any of the commands anymore.
++
+Cf. <xmqqttjazwwa.fsf@gitster.g>,
+<xmqqleeubork.fsf@gitster.g>,
+<112b6568912a6de6672bf5592c3a718e@manjaro.org>.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index f4854f802d4..af436b2d5e9 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -192,6 +192,7 @@ manpages = {
   'gitweb.conf.adoc' : 5,
 
   # Category 7.
+  'gitbreaking-changes.adoc' : 7,
   'gitcli.adoc' : 7,
   'gitcore-tutorial.adoc' : 7,
   'gitcredentials.adoc' : 7,
diff --git a/command-list.txt b/command-list.txt
index 63ae2a67c94..1b7236a62fd 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -213,6 +213,7 @@ git-whatchanged                         ancillaryinterrogators          complete
 git-worktree                            mainporcelain
 git-write-tree                          plumbingmanipulators
 gitattributes                           userinterfaces
+gitbreaking-changes                     guide
 gitcli                                  userinterfaces
 gitcore-tutorial                        guide
 gitcredentials                          guide
-- 
2.55.0.793.gc667de3f2c5

