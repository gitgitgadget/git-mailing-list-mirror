Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836611A76C9
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722362095; cv=none; b=KzM5fNQk6eQg4lRfaZ3oK4TWu+tuRAwhi1c64zZMdU+ChJtVSJkGEEnYiDpj3CFLFGq9+5qY9sts4i7XNZG9oyTy6m/N3fXrWo4BmnxTM2x8hwhCCiyF0cm/tmy2Mvcxpw6JgXNWi61FEuCjnOb3q+5vBO60qL0FW9rD9ffXoiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722362095; c=relaxed/simple;
	bh=+e+9o6SRy4JrolwHLFOgUGOjpvmTR2Cih/jQlPPrkms=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ed4werDHCxEbsIgCofWCVGC2cZp8EQiMbwvodwkR4m4DC0BDA662FZ9x2GBLjEE7tfLIRACLyO4pVBTAAPDIcHHUBKtJyxGuU8Y1Nb8gz/M8ZEnqmSEZdOuLfZhVoJB/vdsScWJcVFCe19tmffCJFmmbsxdeSihvBe5lHrfxymU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--emilyshaffer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gGmheljH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--emilyshaffer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gGmheljH"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-664ccf0659cso89412377b3.1
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 10:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722362092; x=1722966892; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+I+sfewTrQCsRZUvvXizx4BP0jiYguo+OQSwzZDLzjU=;
        b=gGmheljH5wteLRPr0i+wA6XUkQTejdWaq0oQcFGVkAii20dW6F4Se8owoqJuD1IGi4
         nyN/TSqQVx++sXxqHujqEs0jr53SYYKFefMhiIsqNubH1hMZ/mfz+oflZRVaZZ+Av4e+
         7eZsMX5sbQBuB+yHu6WwqnLlgLhVE5fTLCts8lHJEUhZczPsTN1+BOISnk7Xn2Ctg8es
         VuLP+nkdD7KXVEwN0g/HB2CxVroS3ol/0K7xdFur6BaEEZ9FTC6PMQF7ko3VsAPA0NqI
         26SNG7U1jhourKNuieBEbXGz/OO7NIxDKIrpPNlybNaHwr4GJoZB+lGsVyx8myS923mb
         Hdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722362092; x=1722966892;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+I+sfewTrQCsRZUvvXizx4BP0jiYguo+OQSwzZDLzjU=;
        b=qdJfLt6NPBs7mMasDB6IOVpb4f1VGlc4UJUY3KyaamCYXM2caK2nT8WfGTl3UihPF3
         LcnvWhgIBd8eqgSSQ8q+110AEAbJss3Jwwz/aAcTXhRm+91c9tBdByxninHsVr7f8cDt
         FWzTf6qvU4gAMYVlpsBjSqttQGH/fuTgtYc/XRM7FE5kBS6E9uFwySnCR/rxzUVg6L2W
         o/+a3YJvPeOd/Iw4UyBuYpddFO2OdIWRELPhDtiPjYC93j4gOk8jaHpT+PqxsXEqLavb
         v4cBA37rilbn5klneP+bLbe5qW1vEV8CZHau4KdVTFyUDH9CmCXP2IIi01JmAOMoBdEt
         nCtQ==
X-Gm-Message-State: AOJu0Yy8dtT/9G3lbCfgDsIfqT7mrsBLoZRmbPPWYzh3tnVYUTieXj55
	JBNm+GT/TlWrVvkSJBCaxFXFX9OctVp1CVG+zu0ZplwCSmr2ctJffyHR7D35NJykBOF+++/pLp/
	PzKD5w8os4UF9s32VItZVKxoGV4fZU5s9SGHwg8L2sTjzwBaTeoK3JRh5QU9893d1ogePlu+z8/
	ht00ULBlimxnEa3J0BmGTJkhOACiK3j3n4YBE6ExsPfkIfY2lLXbry58FcEBfz
X-Google-Smtp-Source: AGHT+IHVeHchw/02l7jGQJ7o6cb5pOLQenL2n5XucRkoOyU4mPODDddxYoi4vdrY2vvhxsvV7tXv6qJ23qorPBDePyw=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2d3:204:c84a:e6c6:228d:1bd7])
 (user=emilyshaffer job=sendgmr) by 2002:a81:b043:0:b0:680:cd2b:90ed with SMTP
 id 00721157ae682-680cd2b9766mr945657b3.3.1722362092335; Tue, 30 Jul 2024
 10:54:52 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:54:48 -0700
In-Reply-To: <20240718173843.2411415-1-emilyshaffer@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240730175448.1727373-1-emilyshaffer@google.com>
Subject: [PATCH v4] Documentation: add platform support policy
From: Emily Shaffer <emilyshaffer@google.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	"=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Supporting many platforms is only possible when we have the right tools to
ensure that support.

Teach platform maintainers how they can help us to help them, by
explaining what kind of tooling support we would like to have, and what
level of support becomes available as a result. Provide examples so that
platform maintainers can see what we're asking for in practice.

With this policy in place, we can make changes with stronger assurance
that we are not breaking anybody we promised not to. Instead, we can
feel confident that our existing testing and integration practices
protect those who care from breakage.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>

---

My sense is that this doc is quite close, with the only open concern
being around the "Minimum Requirements" section and what they should
contain[1]. Would it be valuable for me to trim that part out and send
it as a follow-on patch for us to discuss in isolation, and merge the
rest of the document as it is now?

New in v4:

- Wording fixes in commit message and body

- Clarify cadence for tests against 'next'

- Attempt to clarify dependency version minimum requirement to something
  reasonable and flexible. Note: This section still probably needs
  better wording; I took a crack at it but it still feels awkward.
  Suggestions welcome, please.

- Be more realistic about finding non-intrusive platform support
  approaches ("we'll look for" rather than "we'll definitely find and in
  fact know a few options in advance")

- Move up "Minimum Requirements" section to the top, so we don't
  bait-and-switch maintainers of platforms who don't even meet the
  baseline but start making effort to set up testing infrastructure and
  so on.

Thanks,

 - Emily

v1 description at
https://lore.kernel.org/git/20240709225042.2005233-1-emilyshaffer@google.com/

Passing docs build at
https://github.com/nasamuffin/git/actions/runs/10167171645/job/28118949973

1: Thread starting around
https://lore.kernel.org/git/00fa01dad96c$8fda8890$af8f99b0$@nexbridge.com/
---
 Documentation/Makefile                       |   1 +
 Documentation/technical/platform-support.txt | 187 +++++++++++++++++++
 2 files changed, 188 insertions(+)
 create mode 100644 Documentation/technical/platform-support.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 1bd23fbeef..0f55baa252 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -118,6 +118,7 @@ TECH_DOCS += technical/multi-pack-index
 TECH_DOCS += technical/pack-heuristics
 TECH_DOCS += technical/parallel-checkout
 TECH_DOCS += technical/partial-clone
+TECH_DOCS += technical/platform-support
 TECH_DOCS += technical/racy-git
 TECH_DOCS += technical/reftable
 TECH_DOCS += technical/scalar
diff --git a/Documentation/technical/platform-support.txt b/Documentation/technical/platform-support.txt
new file mode 100644
index 0000000000..e0e7a3c2d8
--- /dev/null
+++ b/Documentation/technical/platform-support.txt
@@ -0,0 +1,187 @@
+Platform Support Policy
+=======================
+
+Git has a history of providing broad "support" for exotic platforms and older
+platforms, without an explicit commitment. Stakeholders of these platforms may
+want a more predictable support commitment. This is only possible when platform
+stakeholders supply Git developers with adequate tooling, so we can test for
+compatibility or develop workarounds for platform-specific quirks on our own.
+Various levels of tooling will allow us to make more solid commitments around
+Git's compatibility with your platform.
+
+Note that this document is about maintaining existing support for a platform
+that has generally worked in the past; for adding support to a platform which
+doesn't generally work with Git, the stakeholders for that platform are expected
+to do the bulk of that work themselves. We will consider such patches if they
+don't make life harder for other supported platforms, and you may well find a
+contributor interested in working on that support, but the Git community as a
+whole doesn't feel an obligation to perform such work.
+
+Minimum Requirements
+--------------------
+
+The rest of this doc describes best practices for platforms to make themselves
+easy to support. However, before considering support at all, platforms need to
+meet the following minimum requirements:
+
+* Has C99 or C11
+
+* Uses versions of dependencies which are generally accepted as stable and
+  supportable, e.g., in line with the version used by other long-term-support
+  distributions
+
+* Has active security support (taking security releases of dependencies, etc)
+
+These requirements are a starting point, and not sufficient on their own for the
+Git community to be enthusiastic about supporting your platform. Maintainers of
+platforms which do meet these requirements can follow the steps below to make it
+more likely that Git updates will respect the platform's needs.
+
+Compatible by next release
+--------------------------
+
+To increase probability that compatibility issues introduced in a release
+will be fixed in a later release:
+
+* You should send a bug report as soon as you notice the breakage on your
+  platform. The sooner you notice, the better; watching `seen` means you can
+  notice problems before they are considered "done with review"; whereas
+  watching `master` means the stable branch could break for your platform, but
+  you have a decent chance of avoiding a tagged release breaking you. See "The
+  Policy" in link:../howto/maintain-git.txt["How to maintain Git"] for an
+  overview of which branches are used in the Git project, and how.
+
+* The bug report should include information about what platform you are using.
+
+* You should also use linkgit:git-bisect[1] and determine which commit
+  introduced the breakage.
+
+* Please include any information you have about the nature of the breakage: is
+  it a memory alignment issue? Is an underlying library missing or broken for
+  your platform? Is there some quirk about your platform which means typical
+  practices (like malloc) behave strangely?
+
+** If possible, build Git from the exact same source both for your platform and
+   for a mainstream platform, and make sure the problem you noticed appears
+   only on your platform. If the problem appears in both, then it's not a
+   compatibility issue, but we of course appreciate hearing about it in a bug
+   report anyway, to benefit users of every platform.
+
+* Once we begin to fix the issue, please work closely with the contributor
+  working on it to test the proposed fix against your platform.
+
+Example: NonStop
+https://lore.kernel.org/git/01bd01da681a$b8d70a70$2a851f50$@nexbridge.com/[reports
+problems] when they're noticed.
+
+Compatible on `master` and releases
+-----------------------------------
+
+To make sure all stable builds and regular releases work for your platform the
+first time, help us avoid `master` breaking for your platform:
+
+* You should run regular tests against the `next` branch and
+  publish breakage reports to the mailing list immediately when they happen.
+
+** Ideally, these tests should run daily. At minimum, they should run weekly, as
+   topics generally spend at least 7 days in `next` before graduating to
+   `master`.
+
+** You may want to ask to join the mailto:git-security@googlegroups.com[security
+   mailing list] in order to run tests against the fixes proposed there, too.
+
+* It may make sense to automate these; if you do, make sure they are not noisy
+  (you don't need to send a report when everything works, only when something
+  breaks; you don't need to send repeated reports for the same breakage night
+  after night).
+
+* Breakage reports should be actionable - include clear error messages that can
+  help developers who may not have access to test directly on your platform.
+
+* You should use git-bisect and determine which commit introduced the breakage;
+  if you can't do this with automation, you should do this yourself manually as
+  soon as you notice a breakage report was sent.
+
+* You should either:
+
+** Provide on-demand access to your platform to a trusted developer working to
+   fix the issue, so they can test their fix, OR
+
+** Work closely with the developer fixing the issue; the turnaround to check
+   that their proposed fix works for your platform should be fast enough that it
+   doesn't hinder the developer working on that fix. Slow testing turnarounds
+   may cause the fix to miss the next release, or the developer may lose
+   interest in working on the fix at all.
+
+Example:
+https://lore.kernel.org/git/CAHd-oW6X4cwD_yLNFONPnXXUAFPxgDoccv2SOdpeLrqmHCJB4Q@mail.gmail.com/[AIX]
+provides a build farm and runs tests against release candidates.
+
+Compatible on `next`
+--------------------
+
+To avoid reactive debugging and fixing when changes hit a release or stable, you
+can aim to ensure `next` works for your platform. (See "The Policy" in the
+link:../howto/maintain-git.txt[maintainer's guide] for an overview of how `next`
+is used in the Git project.) To do that:
+
+* You should add a runner for your platform to the GitHub Actions or GitLab CI
+  suite.  This suite is run when any Git developer proposes a new patch, and
+  having a runner for your platform/configuration means every developer will
+  know if they break you, immediately.
+
+** If adding it to an existing CI suite is infeasible (due to architecture
+   constraints or for performance reasons), any other method which runs as
+   automatically and quickly as possible works, too. For example, a service
+   which snoops on the mailing list and automatically runs tests on new [PATCH]
+   emails, replying to the author with the results, would also be within the
+   spirit of this requirement.
+
+* If you rely on Git avoiding a specific pattern that doesn't work well with
+  your platform (like a certain malloc pattern), raise it on the mailing list.
+  We'll work case-by-case to look for a solution that doesn't unnecessarily
+  constrain other platforms to keep compatibility with yours.
+
+* If you rely on some configuration or behavior, add a test for it. Untested
+  behavior is subject to breakage at any time.
+
+** Clearly label these tests as necessary for platform compatibility. Add them
+   to an isolated compatibility-related test suite, like a new t* file or unit
+   test suite, so that they're easy to remove when compatibility is no longer
+   required.  If the specific compatibility need is gated behind an issue with
+   another project, link to documentation of that issue (like a bug or email
+   thread) to make it easier to tell when that compatibility need goes away.
+
+** Include a comment with an expiration date for these tests no more than 1 year
+   from now. You can update the expiration date if your platform still needs
+   that assurance down the road, but we need to know you still care about that
+   compatibility case and are working to make it unnecessary.
+
+Example: We run our
+https://git.kernel.org/pub/scm/git/git.git/tree/.github/workflows/main.yml[CI
+suite] on Windows, Ubuntu, Mac, and others.
+
+Getting help writing platform support patches
+---------------------------------------------
+
+In general, when sending patches to fix platform support problems, follow
+these guidelines to make sure the patch is reviewed with the appropriate level
+of urgency:
+
+* Clearly state in the commit message that you are fixing a platform breakage,
+  and for which platform.
+
+* Use the CI and test suite to ensure that the fix for your platform doesn't
+  break other platforms.
+
+* If possible, add a test ensuring this regression doesn't happen again. If
+  it's not possible to add a test, explain why in the commit message.
+
+Platform Maintainers
+--------------------
+
+If you maintain a platform, or Git for that platform, and intend to work with
+the Git project to ensure compatibility, please send a patch to add yourself to
+this list.
+
+NonStop: Randall S. Becker <rsbecker@nexbridge.com>

Range-diff against v3:
1:  575c5a5a5f ! 1:  02fda7106e Documentation: add platform support policy
    @@ Metadata
      ## Commit message ##
         Documentation: add platform support policy
     
    -    Supporting many platforms is only easy when we have the right tools to
    +    Supporting many platforms is only possible when we have the right tools to
         ensure that support.
     
         Teach platform maintainers how they can help us to help them, by
    @@ Documentation/technical/platform-support.txt (new)
     +contributor interested in working on that support, but the Git community as a
     +whole doesn't feel an obligation to perform such work.
     +
    ++Minimum Requirements
    ++--------------------
    ++
    ++The rest of this doc describes best practices for platforms to make themselves
    ++easy to support. However, before considering support at all, platforms need to
    ++meet the following minimum requirements:
    ++
    ++* Has C99 or C11
    ++
    ++* Uses versions of dependencies which are generally accepted as stable and
    ++  supportable, e.g., in line with the version used by other long-term-support
    ++  distributions
    ++
    ++* Has active security support (taking security releases of dependencies, etc)
    ++
    ++These requirements are a starting point, and not sufficient on their own for the
    ++Git community to be enthusiastic about supporting your platform. Maintainers of
    ++platforms which do meet these requirements can follow the steps below to make it
    ++more likely that Git updates will respect the platform's needs.
    ++
     +Compatible by next release
     +--------------------------
     +
    @@ Documentation/technical/platform-support.txt (new)
     +  notice problems before they are considered "done with review"; whereas
     +  watching `master` means the stable branch could break for your platform, but
     +  you have a decent chance of avoiding a tagged release breaking you. See "The
    -+  Policy" in the link:../howto/maintain-git.txt[maintainer's guide] for an
    -+  overview of which branches are used in git.git, and how.
    ++  Policy" in link:../howto/maintain-git.txt["How to maintain Git"] for an
    ++  overview of which branches are used in the Git project, and how.
     +
     +* The bug report should include information about what platform you are using.
     +
    @@ Documentation/technical/platform-support.txt (new)
     +  practices (like malloc) behave strangely?
     +
     +** If possible, build Git from the exact same source both for your platform and
    -+   for a maintstream platform, and make sure the problem you noticed appears
    ++   for a mainstream platform, and make sure the problem you noticed appears
     +   only on your platform. If the problem appears in both, then it's not a
     +   compatibility issue, but we of course appreciate hearing about it in a bug
     +   report anyway, to benefit users of every platform.
    @@ Documentation/technical/platform-support.txt (new)
     +problems] when they're noticed.
     +
     +Compatible on `master` and releases
    -+-----------------------------------------
    ++-----------------------------------
     +
     +To make sure all stable builds and regular releases work for your platform the
    -+first time, you can make sure `master` doesn't break for your platform:
    ++first time, help us avoid `master` breaking for your platform:
    ++
    ++* You should run regular tests against the `next` branch and
    ++  publish breakage reports to the mailing list immediately when they happen.
     +
    -+* You should run nightly tests against the `next` branch and publish breakage
    -+  reports to the mailing list immediately when they happen.
    ++** Ideally, these tests should run daily. At minimum, they should run weekly, as
    ++   topics generally spend at least 7 days in `next` before graduating to
    ++   `master`.
     +
     +** You may want to ask to join the mailto:git-security@googlegroups.com[security
     +   mailing list] in order to run tests against the fixes proposed there, too.
    @@ Documentation/technical/platform-support.txt (new)
     +
     +* You should either:
     +
    -+** Provide VM access on-demand to a trusted developer working to fix the issue,
    -+   so they can test their fix, OR
    ++** Provide on-demand access to your platform to a trusted developer working to
    ++   fix the issue, so they can test their fix, OR
     +
     +** Work closely with the developer fixing the issue; the turnaround to check
     +   that their proposed fix works for your platform should be fast enough that it
    @@ Documentation/technical/platform-support.txt (new)
     +
     +* If you rely on Git avoiding a specific pattern that doesn't work well with
     +  your platform (like a certain malloc pattern), raise it on the mailing list.
    -+  There are a few ways to avoid these breakages, so we'll work case-by-case to
    -+  find a solution that doesn't unnecessarily constrain other platforms to keep
    -+  compatibility with yours.
    ++  We'll work case-by-case to look for a solution that doesn't unnecessarily
    ++  constrain other platforms to keep compatibility with yours.
     +
     +* If you rely on some configuration or behavior, add a test for it. Untested
     +  behavior is subject to breakage at any time.
    @@ Documentation/technical/platform-support.txt (new)
     +* If possible, add a test ensuring this regression doesn't happen again. If
     +  it's not possible to add a test, explain why in the commit message.
     +
    -+Minimum Requirements
    -+--------------------
    -+
    -+Even if platform maintainers are willing to add tests or CI runners, we will
    -+not consider helping to support platforms that do not meet these minimum
    -+requirements:
    -+
    -+* Has C99 or C11
    -+
    -+* Has dependencies which were released in the past 10 years
    -+
    -+* Has active security support (taking security releases of dependencies, etc)
    -+
     +Platform Maintainers
     +--------------------
     +
-- 
2.46.0.rc1.232.g9752f9e123-goog

