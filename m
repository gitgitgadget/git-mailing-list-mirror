Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C12130A5C
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722637197; cv=none; b=uD43mFbiMccht7IW/xwyKhicd5F1UGLMqRdb0CO9icd5XaHhPzcH4m8QQmYJnWKHeWSmhLWzYFt6bYDLM7cL8vusrIt0lo/uIffKu+1R0dDMrI/QlnQKMxRWyXJqPReYAZR5/LNHSwvZEgaj4Eh334pax6erKqomjybZSTo4sSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722637197; c=relaxed/simple;
	bh=OQi3+UnuI+Bu3F4A023VU9YUGD6iBNYiHE1mGvNYY3s=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=RjAqXhMYYHl4lX4SzASURnjMhP1mfHc8b8LgHYr5V+qQvOvIMg2FdBKStXnWIeACk4N3UzTg2ox3QNUmuLEiYOmJw0Oy2wORcvNXSvOKaHOt3hNLtWAud3xspUOCSdkJ+plZDcG2Z2lCx2zYf9ko4EE+/E00PoCKy6h/4xBQqAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--emilyshaffer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UKT3+VH7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--emilyshaffer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UKT3+VH7"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-672bea19bedso190086577b3.3
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 15:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722637194; x=1723241994; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LgT5JmQ/ToMnEY8m2ILl4pqk/To4DT3Joi+XnGKEoNU=;
        b=UKT3+VH7KiUxe2rPlnIGFdbUMT6TJaFXDfpnNsINRCn6Jfgq152BPbRIKd5LlMBCVo
         zenT8oaoiWtjamzDOBBm2T0tbjxmF8Tt0rG0aLi9++0XgIlHbRiVfix6k6810Wgi+QSW
         YfnkqDFj0VWete6ahur4QkjNbZ9uJDslT2S1766uXGYvhIACA0KVRDJCRWwewXpUrdaQ
         iyH/9kGVecYSPmItYc5zAyKF/LHUECMGQym72BQBT08/1jtM6Y4yYUHpKq0ark/v0CJF
         fAHqyA1jCRnAp+iWkm9GybHxWryG4TsY56nXV+R6+bvZ4pYk836P/mr8S5OrpRVA3PHa
         +OGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722637194; x=1723241994;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgT5JmQ/ToMnEY8m2ILl4pqk/To4DT3Joi+XnGKEoNU=;
        b=f9M5a/BT9140vAYx8dOgq8IXWSUjp1Zq9UAYA8U9y0DGCQcCBLC032buiRsu0rvszL
         pXjLW8+ZhCUvgrnSwIEbUY8J+kHX1BBIbVVhE2zx1LVKgZnhXB3WKXh2ssbimT5gvPTK
         UWZTbY86C8WE6c3NgGGEs84DJLGTZHz1boNHMR+wcGKOMWDMbnizXBg3WOKUjZWZr6Cp
         +Pz2z54jGCWLvRxQspFX72Zpy6+REQYfVmuz5Ckzj2qJb7dJF8gFB6VMSWWD47wI4s9S
         BrbBvpL7Diotxb453m3cBCpHVYp6w+yxASqiTrMskZw+ueS+qKYTzUvrHlvj50NdVJ/P
         G9zg==
X-Gm-Message-State: AOJu0Yz8OzJ94JR3QiDvVYwvJXcqJ6qxdgQH2bJcdTnG0TjBXR4b2J9V
	DXY0vB61zrygJgNJ4m6H5rTFRmwuXnIjAxayVzu1+8/Y7k6NWeVYDH/kB7juygbSJBPBpaahAPc
	Rp1ggzXDl5din69Unmp2f1KgtfYO/HOMSgW1Uc0l+xjICIB1e2p23HvYDinmPfYfxQRUSIGOcJd
	OmTI1g48OBUe50UiTlc96up4Tpfawx8BC5OlRzXFirmaIWcjGRbkQY/flvRLLa
X-Google-Smtp-Source: AGHT+IFT3JSDize2LfToMbeTbjghPCDQG3bkI3nAWrByZszQT+/2FoehB1FmiJ6mvng4E0XNFOetwBVcTImhkLTruBY=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2d3:204:63e8:3fed:873:97a2])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6902:2b0d:b0:dff:1070:84b7 with
 SMTP id 3f1490d57ef6-e0bde21e24dmr9310276.5.1722637193845; Fri, 02 Aug 2024
 15:19:53 -0700 (PDT)
Date: Fri,  2 Aug 2024 15:19:48 -0700
In-Reply-To: <20240730175448.1727373-1-emilyshaffer@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802221948.2367124-1-emilyshaffer@google.com>
Subject: [PATCH v5] Documentation: add platform support policy
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

New in v4:

- Wording and bulleting format fixes in commit message and body

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

I believe that this version addresses Randall's concerns with the
"minimum requirements" policy. Are there any other outstanding concerns
with the policy itself, as written, or is this ready to go in (modulo
nits)?

Thanks,

 - Emily

v1 description at
https://lore.kernel.org/git/20240709225042.2005233-1-emilyshaffer@google.com/
---
 Documentation/Makefile                       |   1 +
 Documentation/technical/platform-support.txt | 190 +++++++++++++++++++
 2 files changed, 191 insertions(+)
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
index 0000000000..a227c363d7
--- /dev/null
+++ b/Documentation/technical/platform-support.txt
@@ -0,0 +1,190 @@
+Platform Support Policy
+=======================
+
+Git has a history of providing broad "support" for exotic platforms and older
+platforms, without an explicit commitment. Stakeholders of these platforms may
+want a more predictable support commitment. This is only possible when platform
+stakeholders supply Git developers with adequate tooling, so we can test for
+compatibility or develop workarounds for platform-specific quirks on our own.
+Various levels of platform-specific tooling will allow us to make more solid
+commitments around Git's compatibility with that platform.
+
+Note that this document is about maintaining existing support for a platform
+that has generally worked in the past; for adding support to a platform which
+doesn't generally work with Git, the stakeholders for that platform are expected
+to do the bulk of that work themselves. We will consider such patches if they
+don't make life harder for other supported platforms or for Git contributors.
+Some contributors may volunteer to help with the initial or continued support,
+but that's not a given. Support work which is too intrusive or difficult for the
+project to maintain may still not be accepted.
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
+* If possible, build Git from the exact same source both for your platform and
+  for a mainstream platform, to see if the problem you noticed appears only
+  on your platform. If the problem appears in both, then it's not a
+  compatibility issue, but we of course appreciate hearing about it in a bug
+  report anyway, to benefit users of every platform. If it appears only on your
+  platform, mention clearly that it is a compatibility issue in your report.
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
+first time, help us avoid breaking `master` for your platform:
+
+* You should run regular tests against the `next` branch and
+  publish breakage reports to the mailing list immediately when they happen.
+
+** Ideally, these tests should run daily. They must run more often than
+   weekly, as topics generally spend at least 7 days in `next` before graduating
+   to `master`, and it takes time to put the brakes on a patch once it lands in
+   `next`.
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
+can aim to ensure `next` always works for your platform. (See "The Policy" in
+link:../howto/maintain-git.txt["How to maintain Git"] for an overview of how
+`next` is used in the Git project.) To do that:
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

Range-diff against v4:
1:  02fda7106e ! 1:  6b8123acb6 Documentation: add platform support policy
    @@ Documentation/technical/platform-support.txt (new)
     +want a more predictable support commitment. This is only possible when platform
     +stakeholders supply Git developers with adequate tooling, so we can test for
     +compatibility or develop workarounds for platform-specific quirks on our own.
    -+Various levels of tooling will allow us to make more solid commitments around
    -+Git's compatibility with your platform.
    ++Various levels of platform-specific tooling will allow us to make more solid
    ++commitments around Git's compatibility with that platform.
     +
     +Note that this document is about maintaining existing support for a platform
     +that has generally worked in the past; for adding support to a platform which
     +doesn't generally work with Git, the stakeholders for that platform are expected
     +to do the bulk of that work themselves. We will consider such patches if they
    -+don't make life harder for other supported platforms, and you may well find a
    -+contributor interested in working on that support, but the Git community as a
    -+whole doesn't feel an obligation to perform such work.
    ++don't make life harder for other supported platforms or for Git contributors.
    ++Some contributors may volunteer to help with the initial or continued support,
    ++but that's not a given. Support work which is too intrusive or difficult for the
    ++project to maintain may still not be accepted.
     +
     +Minimum Requirements
     +--------------------
    @@ Documentation/technical/platform-support.txt (new)
     +  your platform? Is there some quirk about your platform which means typical
     +  practices (like malloc) behave strangely?
     +
    -+** If possible, build Git from the exact same source both for your platform and
    -+   for a mainstream platform, and make sure the problem you noticed appears
    -+   only on your platform. If the problem appears in both, then it's not a
    -+   compatibility issue, but we of course appreciate hearing about it in a bug
    -+   report anyway, to benefit users of every platform.
    ++* If possible, build Git from the exact same source both for your platform and
    ++  for a mainstream platform, to see if the problem you noticed appears only
    ++  on your platform. If the problem appears in both, then it's not a
    ++  compatibility issue, but we of course appreciate hearing about it in a bug
    ++  report anyway, to benefit users of every platform. If it appears only on your
    ++  platform, mention clearly that it is a compatibility issue in your report.
     +
     +* Once we begin to fix the issue, please work closely with the contributor
     +  working on it to test the proposed fix against your platform.
    @@ Documentation/technical/platform-support.txt (new)
     +-----------------------------------
     +
     +To make sure all stable builds and regular releases work for your platform the
    -+first time, help us avoid `master` breaking for your platform:
    ++first time, help us avoid breaking `master` for your platform:
     +
     +* You should run regular tests against the `next` branch and
     +  publish breakage reports to the mailing list immediately when they happen.
     +
    -+** Ideally, these tests should run daily. At minimum, they should run weekly, as
    -+   topics generally spend at least 7 days in `next` before graduating to
    -+   `master`.
    ++** Ideally, these tests should run daily. They must run more often than
    ++   weekly, as topics generally spend at least 7 days in `next` before graduating
    ++   to `master`, and it takes time to put the brakes on a patch once it lands in
    ++   `next`.
     +
     +** You may want to ask to join the mailto:git-security@googlegroups.com[security
     +   mailing list] in order to run tests against the fixes proposed there, too.
    @@ Documentation/technical/platform-support.txt (new)
     +--------------------
     +
     +To avoid reactive debugging and fixing when changes hit a release or stable, you
    -+can aim to ensure `next` works for your platform. (See "The Policy" in the
    -+link:../howto/maintain-git.txt[maintainer's guide] for an overview of how `next`
    -+is used in the Git project.) To do that:
    ++can aim to ensure `next` always works for your platform. (See "The Policy" in
    ++link:../howto/maintain-git.txt["How to maintain Git"] for an overview of how
    ++`next` is used in the Git project.) To do that:
     +
     +* You should add a runner for your platform to the GitHub Actions or GitLab CI
     +  suite.  This suite is run when any Git developer proposes a new patch, and
-- 
2.46.0.rc2.264.g509ed76dc8-goog

