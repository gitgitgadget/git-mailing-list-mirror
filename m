Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E13E13211E
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720565449; cv=none; b=pnICrTQD6sap9p04u2uAS0R2anFRef3qJtixqhR3g9H4wli6elpy3KdVid9/c+t7R38AR5AVeG8fM7l6rP2nMoSTsera1NSun5wwooMClBkVr6LzxpGySHWftTojGBe8unVgxre1GaAktptalGTy73UjbTvfnqdyOLAdWmXCgX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720565449; c=relaxed/simple;
	bh=UVpBFBQta91k+k/1IgLL4Ql4WSp+xWAtQUOb1aMjyVM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QsifIYYX78SiY87m1ht1s+3Il6pLTW55owJXuDLdFKBVQ14VXtD5cV3MfrXrgvhHLCAzowd9V2AWa3/xthMD77gD0Xx68oStX86bW7s+rLthNf842Fp6hHJ5n5mlWnR9wvxv6CzPPYwPmqglEgw8Z1TmE5b/mOw/AdVFPdsF8lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--emilyshaffer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yzo0N5k0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--emilyshaffer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yzo0N5k0"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64b5588bcafso92385377b3.1
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 15:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720565446; x=1721170246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LXnQGN+gdDwqa+lsxo9Eo9HREDTWRSuPNktcPEBHRDE=;
        b=yzo0N5k0rkCl7Q3I04VJE82bGXAjP6nusUvP4Z8h0I92Dq0xPqwiyYJ5YUBoanO0Xz
         YAX5Dc4GCoCgN+RwDNXJHXdtSXXRNkkjzgeFSBYXqwM+yHfXQ1Lks5d7F939+tbGb+qw
         Mo/t/uCwXU+tBPfvcVQFsiVX052YWnavmyTgbN/hgMg82yhVwvG/G8DE5zBUXnHDRf87
         TvyxA5VKrS3AkK2jA3bUd2WmBIYkqtuGAR0G6ZQ7omRnxqlwIC1RllPr5Stlg2Qw2Vgs
         rTgAQ12slhH+ChBC1+ovgx6Jc8k49wpTW62U9XXyS1aInslm/wmo+XjmpxHbggEWBGLS
         lQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720565446; x=1721170246;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXnQGN+gdDwqa+lsxo9Eo9HREDTWRSuPNktcPEBHRDE=;
        b=X+KaPNXuIRiwyJTVZayW7pLo3DAXns2WIfI9M+FV7hmvIKh7KSf+u//ZN8aqVf4Thu
         qDPOcF5O6ZG3bm6t71CLT8YKAT0Aa1DuEVPjdH6ocRvqDpkq503sfTmq/5BCd3TS6AT8
         0ul92XCt9H51MTFqn6+O4S39BzLSfyQqy0Yvm77jBXBYDDS2V66uUBrMurrwz0+Rhd9j
         OIuPRI5mLnKzR5qzVZLkJctVzjO0cS0oyuJhPEd49NM8UXBdEK9kVw2mnk/FqizJ3j/8
         SLNo7KznJ8NLYWpYhSTBpPmse++tKG8iKFdNkXiOyYakRgGrL/do4WM1RNK+1QLiT7xL
         wcSw==
X-Gm-Message-State: AOJu0Yw8Ku2qaOMBuS1JYNWHS8RK2lsF/ifr4utrYeZ/G0J2J6Jr36q3
	nrRnoEaM9RLKJwlziAfikGvR/YhCvPPcheHSdYP4TWM+QJRPABAs/je/aedhw5BIFSkrFYDzUfU
	vftxPV/kCfB+V44zGIOMYAIV3sdK2UhrSWkFVX2u5tXGUtjRilJRtlGLJjqq0ByFdEdooVgKNO4
	Tm0R0LZGnI8hkMKgJzU07FOpWkNc4juIK8AD2wc3EWMdTj2kNi4tZDluJ6Me0z
X-Google-Smtp-Source: AGHT+IH5Hy3RsfLC3hxDN6GZ5NkfhWbbuAcs9C1SaNpDmiJ6DNIbEDnnUtj/R5DBj7kwyzrx1vS8fUdRZLga1bH6Yiw=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2d3:204:43f2:e007:a76c:f287])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6902:2311:b0:dff:2d92:d94e with
 SMTP id 3f1490d57ef6-e041b112defmr8155276.9.1720565446404; Tue, 09 Jul 2024
 15:50:46 -0700 (PDT)
Date: Tue,  9 Jul 2024 15:50:42 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709225042.2005233-1-emilyshaffer@google.com>
Subject: [PATCH] Documentation: add platform support policy
From: Emily Shaffer <emilyshaffer@google.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Supporting many platforms is only easy when we have the right tools to
ensure that support.

Teach platform maintainers how they can help us to help them, by
explaining what kind of tooling support we would like to have, and what
level of support becomes available as a result. Provide examples so that
platform maintainers can see what we're asking for in practice.

With this policy in place, we can make changes with stronger assurance
that we are not breaking anybody we promised not to. Instead, we can
feel confident that our existing testing and integration practices
protect those who care from breakage.

Signed-off-by: Emily Shaffer <nasamuffin@google.com>

---

Hi folks,

Some months ago, I branched the Rust discussion to talk about platform
support[1]. That discussion didn't go far, but with libification efforts
touching the Makefile and worrying about compatibility, it seems like a wor=
thy
discussion to have.=C2=A0

My goal with this document is that if we claim to support a given platform,
that platform should be easy for contributors to test against. And the
corollary, if we can't test against a given platform easily, we shouldn't b=
e
assuring users on that platform that it will always work. I'm thinking of
platforms which rely on recent Git binaries but which we don't test against=
 by
default, like NonStop[2] or AIX[3].

Right now, this doc talks about "guarantees." I used that phrasing based on
what I've observed to be an implicit expectation that we guarantee support;=
 it
could be this isn't actually a guarantee that the community is willing to m=
ake,
so I am hoping we can discuss it and come up with the right term.

I'm hoping that this policy (or one like it) can clarify a "help us help yo=
u"
relationship with platform maintainers. If we can clearly define the resour=
ces
we need in order to guarantee that we're supporting a platform, then we can
make changes more confidently; if, instead, we make a serious effort to fix=
 any
and all reported breakages, then all patches are at risk of breaking a plat=
form
we didn't know exists but care about providing first-class support for and
being rolled back. I think there is some space in between those two extreme=
s,
too, that might be suitable for some less-used platforms, or platforms whic=
h
follow new releases less closely.

Looking forward to discussing.

=C2=A0- Emily

1: https://lore.kernel.org/git/CAJoAoZnHGTFhfR6e6r=3DGMSfVbSNgLoHF-opaWYLbH=
ppiuzi+Rg@mail.gmail.com/=C2=A0
2: https://lore.kernel.org/git/01bd01da681a$b8d70a70$2a851f50$@nexbridge.co=
m/=C2=A0
3: https://lore.kernel.org/git/CAHd-oW6X4cwD_yLNFONPnXXUAFPxgDoccv2SOdpeLrq=
mHCJB4Q@mail.gmail.com/
---
 Documentation/Makefile                       |   1 +
 Documentation/technical/platform-support.txt | 102 +++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 Documentation/technical/platform-support.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index dc65759cb1..462af0311f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -118,6 +118,7 @@ TECH_DOCS +=3D technical/multi-pack-index
 TECH_DOCS +=3D technical/pack-heuristics
 TECH_DOCS +=3D technical/parallel-checkout
 TECH_DOCS +=3D technical/partial-clone
+TECH_DOCS +=3D technical/platform-support
 TECH_DOCS +=3D technical/racy-git
 TECH_DOCS +=3D technical/reftable
 TECH_DOCS +=3D technical/scalar
diff --git a/Documentation/technical/platform-support.txt b/Documentation/t=
echnical/platform-support.txt
new file mode 100644
index 0000000000..23ab708144
--- /dev/null
+++ b/Documentation/technical/platform-support.txt
@@ -0,0 +1,102 @@
+Platform Support Policy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Git has a history of providing broad "support" for exotic platforms and ol=
der
+platforms, without an explicit commitment. This support becomes easier to
+maintain (and possible to commit to) when Git developers are providing wit=
h
+adequate tooling to test for compatibility. Variouis levels of tooling wil=
l
+allow us to make more solid commitments around Git's compatibility with yo=
ur
+platform.
+
+Compatible by vN+1 release
+--------------------------
+
+To increase probability that compatibility issues introduced in a point re=
lease
+will be fixed by the next point release:
+
+* You should send a bug report as soon as you notice the breakage on your
+platform. The sooner you notice, the better; it's better for you to watch =
`seen`
+than to watch `master`. See linkgit:gitworkflows[7] under "Graduation" for=
 an
+overview of which branches are used in git.git, and how.
+* The bug report should include information about what platform you are us=
ing.
+* You should also use linkgit:git-bisect[1] and determine which commit
+introduced the breakage.
+* Please include any information you have about the nature of the breakage=
: is
+it a memory alignment issue? Is an underlying library missing or broken fo=
r
+your platform? Is there some quirk about your platform which means typical
+practices (like malloc) behave strangely?
+* Once we begin to fix the issue, please work closely with the contributor
+working on it to test the proposed fix against your platform.
+
+Example: NonStop
+https://lore.kernel.org/git/01bd01da681a$b8d70a70$2a851f50$@nexbridge.com/=
[reports
+problems] when they're noticed.
+
+Compatible on `master` and point releases
+-----------------------------------------
+
+To guarantee that `master` and all point releases work for your platform t=
he
+first time:
+
+* You should run nightly tests against the `next` branch and publish break=
age
+reports to the mailing list immediately when they happen.
+* It may make sense to automate these; if you do, make sure they are not n=
oisy
+(you don't need to send a report when everything works, only when somethin=
g
+breaks).
+* Breakage reports should be actionable - include clear error messages tha=
t can
+help developers who may not have access to test directly on your platform.
+* You should use git-bisect and determine which commit introduced the brea=
kage;
+if you can't do this with automation, you should do this yourself manually=
 as
+soon as you notice a breakage report was sent.
+* You should either:
+** Provide VM access on-demand to a trusted developer working to fix the i=
ssue,
+so they can test their fix, OR
+** Work closely with the developer fixing the issue - testing turnaround t=
o
+check whether the fix works for your platform should not be longer than a
+business day.
+
+Example:
+https://lore.kernel.org/git/CAHd-oW6X4cwD_yLNFONPnXXUAFPxgDoccv2SOdpeLrqmH=
CJB4Q@mail.gmail.com/[AIX]
+provides a build farm and runs tests against release candidates.
+
+Compatible on `next`
+--------------------
+
+To guarantee that `next` will work for your platform, avoiding reactive
+debugging and fixing:
+
+* You should add a runner for your platform to the GitHub Actions CI suite=
.
+This suite is run when any Git developer proposes a new patch, and having =
a
+runner for your platform/configuration means every developer will know if =
they
+break you, immediately.
+* If you rely on Git avoiding a specific pattern that doesn't work well wi=
th
+your platform (like a certain malloc pattern), if possible, add a cocciche=
ck
+rule to ensure that pattern is not used.
+* If you rely on some configuration or behavior, add a test for it. You ma=
y
+find it easier to add a unit test ensuring the behavior you need than to a=
dd an
+integration test; either one works. Untested behavior is subject to breaka=
ge at
+any time.
+** Clearly label these tests as necessary for platform compatibility. Add =
them
+to an isolated compatibility-related test suite, like a new t* file or uni=
t test
+suite, so that they're easy to remove when compatibility is no longer requ=
ired.
+If the specific compatibility need is gated behind an issue with another
+project, link to documentation of that issue (like a bug or email thread) =
to
+make it easier to tell when that compatibility need goes away.
+
+Example: We run our
+https://git.kernel.org/pub/scm/git/git.git/tree/.github/workflows/main.yml=
[CI
+suite] on Windows, Ubuntu, Mac, and others.
+
+Getting help writing platform support patches
+---------------------------------------------
+
+In general, when sending patches to fix platform support problems, follow
+these guidelines to make sure the patch is reviewed with the appropriate l=
evel
+of urgency:
+
+* Clearly state in the commit message that you are fixing a platform break=
age,
+and for which platform.
+* Use the CI and test suite to ensure that the fix for your platform doesn=
't
+break other platforms.
+* If possible, add a test ensuring this regression doesn't happen again. I=
f
+it's not possible to add a test, explain why in the commit message.
--=20
2.45.2.803.g4e1b14247a-goog

