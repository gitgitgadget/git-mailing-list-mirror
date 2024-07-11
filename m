Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763E54963F
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720740270; cv=none; b=u4xv+1DihTfjXdjbJl9XdFqG3zbOMGLURwTS1B4QkZ3iU8ehU9EcbiIN8YNxbSUFme6Ish/uGx12RwaJVQIRi3HgeFfNZeyR+wbIKDK4HhPXIDZuZ41z/bSTsE9VmoHKq/oOG7UAQ8d/AJtUVNCIVrIgA5wQCWv/6RDh2j328xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720740270; c=relaxed/simple;
	bh=Vm/BNkUcnmxu+xEy40QRmUtllkqTkaHduztLPKE9m2U=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ZAPRq+j34qZIjWl3ALXaWFLbqoISBOw5jv9ibpYBU4O4qOO60y6i9z7avfgMIzgaHsftqL7inYhRqKQQwy7SIAae7Z3jpY9yj9pGtz0kzfYttJjon0sf0gsLkoIunMfxyoWzbAiqv6RfRTLhmMuc6eIhjhzULyEkbyKDAk0UO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--emilyshaffer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFGNDfV6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--emilyshaffer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFGNDfV6"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e057ae54529so2423375276.2
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 16:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720740267; x=1721345067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S6Yvv+laa2n/+9daDCd3HF8uKnHw/GxQRGbvesbN67k=;
        b=IFGNDfV6XOBSvHmcLsBbsTjrK+2Z8+TB1U7zOplqSFJILMVAf61AtWKk5AYYeEH3YI
         V/QRQyUQexkGn61b/loq3KcIZI05mSzDVYbOWhUYqsgSvTaRiaQNUisaGpSdRUezvz6N
         2rFZpxbWFYA0bmCGmh6RAnXm6LxWTHfRNjtUgMpJLU7Uek2y9hbiFW5EXswQkInLk43w
         HK65JG2EImAtmjvlzYmpHUQ+ZWfwliOYJ1MeQvGFj54xwmQDZdbbpjVIGkC16SqoGdFI
         B2EK/DGHIY43kea8I+Bvp+jDYMZV1gSikNXpWWQ0B/yf2egBCvFQ1kh+0QWw89sA4THn
         U09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720740267; x=1721345067;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6Yvv+laa2n/+9daDCd3HF8uKnHw/GxQRGbvesbN67k=;
        b=hW8wQhxiZS6WZ/T+EXvbt9mI9ZI+e+ZUU4m3yiWrb5KSG2ijG3wk+Ixi7eNkk3AeNy
         mlIs77h/NLq/I8Xc1tHa5UtBj39ke/3ONO7eXP0FX04WnQUiyP+4l52cvhnnkVzuH6ia
         mRnCsIuF763uu72SV5xWl65ZPvsuuEZRtccexMlyjijFCTiTdrLqs9czbleaMFU9e0FW
         LMi3kXGBRunso8JPNgo4xXC5PBiX5enNZpCTW6B+e0YVJYQ4N0/hBulai0YMWkOF9xAw
         I7oHf8JKIm7jN7tEnX9RBhakdBHWUDWtbtmOi11bdpqm1mFHFW8d8fH1gehMo1mh0+6E
         8Opw==
X-Gm-Message-State: AOJu0Ywan6eO0rh5WSSCdJJbbM58E1g+JbSjnyJiT8pu2qipuy/FCJXQ
	fJ0RrsmTkKfDVnS+cswyvmnI1ss+SrHPKBmORibaBsDphMV/6rYI6OQ72bu3K4vjfnbs0OArFPS
	/1HRj5wSMTNI2isRie+1FWC8eZtahA6+G/7CXc+wNh3RpxkhvE2sdqFDjX46Yb5QyUeGE9tbV2A
	P28rLDL/jFt3E+tJeIY4V3IGBPCQ7XGZU0J9IB/sejjZesb3buwyexY5ojFagf
X-Google-Smtp-Source: AGHT+IHTmPfB02B/KK/zF6plpvS3bGpsWnlJPY7gYwVHn9GyrFII+ozYS3n469gmZmHA6l57ayl2fxnJ5ZyXclCv9YY=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2d3:204:8bae:f5f4:9f6c:1d58])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6902:1002:b0:e02:b51f:ceac with
 SMTP id 3f1490d57ef6-e041b1415d3mr432673276.9.1720740267447; Thu, 11 Jul 2024
 16:24:27 -0700 (PDT)
Date: Thu, 11 Jul 2024 16:24:13 -0700
In-Reply-To: <20240709225042.2005233-1-emilyshaffer@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711232413.693444-1-emilyshaffer@google.com>
Subject: [PATCH v2] Documentation: add platform support policy
From: Emily Shaffer <emilyshaffer@google.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>, 
	"=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"

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

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>

---

New in v2:

- Added a "minimum requirements" list in response to brian and Kyle's
  suggestions. This doesn't mean "if you meet these requirements, we'll
  work hard to make sure Git works for you"; it means "if you don't meet
  these requirements, then your tests/runners/patches are not welcome."
  Would appreciate someone double-checking the language to make sure
  that's conveyed (nicely). Also, the list of requirements right now is
  very short, because I didn't want to make any assumptions :) so if
  there are more that I should add, please suggest them (or, maybe it
  makes more sense to suggest them as a follow-on patch).

- Added a section for a list of platform maintainers so we know who to
  contact. I guess this could probably use dates (although we have the
  `git blame`) to ensure that it's not too stale. I didn't add Dscho,
  because I figured we had better double-check with him before signing
  him up to anything; will add him to CC for this round. I didn't add
  avarab for AIX because the last I heard about it was years ago; will
  CC him too. Are there others that people know of?

- Fixed some typos Junio pointed out. I'm all thumbs.

- Reworded the "if we break release, we'll fix by next release" language
  to be less specific and hopefully more honest.

- Gave more detail about which branches are worth watching, and linked
  to the maintainer guide rather than the workflows guide. Also
  suggested watching `cabal`/security list.

- Made testing turnaround time requirement less specific (and more
  intimidating). Happy to hear suggestions for rephrasing, I'm worried
  it may be a little rude as is.

- Stopped mentioning coccicheck specifically; instead, invite people to
  discuss possible compatibility restrictions with the mailing list, as
  no one size fits all. I'd be happy to know if this is clear as written
  or not.

- Recommended tests restricting use of platform features come with an
  expiration date, and why. If I didn't get the reasoning right, please
  let me know and suggest a rephrase.

- Suggested that GitHub Actions aren't the only way to do on-demand CI,
  and if you come up with another way to do it that is as low-effort for
  developers, that's OK too.

Thanks,

 - Emily

v1 description at
https://lore.kernel.org/git/20240709225042.2005233-1-emilyshaffer@google.com/
---
 Documentation/Makefile                       |   1 +
 Documentation/technical/platform-support.txt | 138 +++++++++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100644 Documentation/technical/platform-support.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index dc65759cb1..462af0311f 100644
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
index 0000000000..b818e6a402
--- /dev/null
+++ b/Documentation/technical/platform-support.txt
@@ -0,0 +1,138 @@
+Platform Support Policy
+=======================
+
+Git has a history of providing broad "support" for exotic platforms and older
+platforms, without an explicit commitment. This support becomes easier to
+maintain (and possible to commit to) when Git developers are provided with
+adequate tooling to test for compatibility. Various levels of tooling will
+allow us to make more solid commitments around Git's compatibility with your
+platform.
+
+Compatible by next release
+--------------------------
+
+To increase probability that compatibility issues introduced in a release
+will be fixed in a later release:
+
+* You should send a bug report as soon as you notice the breakage on your
+platform. The sooner you notice, the better; watching `seen` means you can
+notice problems before they are considered "done with review"; whereas watching
+`master` means the stable branch could break for your platform, but you have a
+decent chance of avoiding a tagged release breaking you. See "The Policy" in the
+link:../howto/maintain-git.txt[maintainer's guide] for an overview of which
+branches are used in git.git, and how.
+* The bug report should include information about what platform you are using.
+* You should also use linkgit:git-bisect[1] and determine which commit
+introduced the breakage.
+* Please include any information you have about the nature of the breakage: is
+it a memory alignment issue? Is an underlying library missing or broken for
+your platform? Is there some quirk about your platform which means typical
+practices (like malloc) behave strangely?
+* Once we begin to fix the issue, please work closely with the contributor
+working on it to test the proposed fix against your platform.
+
+Example: NonStop
+https://lore.kernel.org/git/01bd01da681a$b8d70a70$2a851f50$@nexbridge.com/[reports
+problems] when they're noticed.
+
+Compatible on `master` and point releases
+-----------------------------------------
+
+To guarantee that `master` and all point releases work for your platform the
+first time:
+
+* You should run nightly tests against the `next` branch and publish breakage
+reports to the mailing list immediately when they happen.
+** You may want to ask to join the mailto:git-security@googlegroups.com[security
+mailing list] in order to run tests against the fixes proposed there, too.
+* It may make sense to automate these; if you do, make sure they are not noisy
+(you don't need to send a report when everything works, only when something
+breaks).
+* Breakage reports should be actionable - include clear error messages that can
+help developers who may not have access to test directly on your platform.
+* You should use git-bisect and determine which commit introduced the breakage;
+if you can't do this with automation, you should do this yourself manually as
+soon as you notice a breakage report was sent.
+* You should either:
+** Provide VM access on-demand to a trusted developer working to fix the issue,
+so they can test their fix, OR
+** Work closely with the developer fixing the issue; the turnaround to check
+that their proposed fix works for your platform should be fast enough that it
+doesn't hinder the developer working on that fix. Slow testing turnarounds may
+cause the fix to miss the next release, or the developer may lose interest in
+working on the fix at all.
+
+Example:
+https://lore.kernel.org/git/CAHd-oW6X4cwD_yLNFONPnXXUAFPxgDoccv2SOdpeLrqmHCJB4Q@mail.gmail.com/[AIX]
+provides a build farm and runs tests against release candidates.
+
+Compatible on `next`
+--------------------
+
+To guarantee that `next` will work for your platform, avoiding reactive
+debugging and fixing:
+
+* You should add a runner for your platform to the GitHub Actions CI suite.
+This suite is run when any Git developer proposes a new patch, and having a
+runner for your platform/configuration means every developer will know if they
+break you, immediately.
+** If adding it to GitHub Actions is infeasible (due to architecture constraints
+or for performance reasons), any other method which runs as automatically and
+quickly as possible works, too. For example, a service which snoops on the
+mailing list and automatically runs tests on new [PATCH] emails, replying to the
+author with the results, would also be within the spirit of this requirement.
+* If you rely on Git avoiding a specific pattern that doesn't work well with
+your platform (like a certain malloc pattern), raise it on the mailing list.
+There are a few ways to avoid these breakages, so we'll work case-by-case to
+find a solution that doesn't unnecessarily constrain other platforms to keep
+compatibility with yours.
+* If you rely on some configuration or behavior, add a test for it.  Untested
+behavior is subject to breakage at any time.
+** Clearly label these tests as necessary for platform compatibility. Add them
+to an isolated compatibility-related test suite, like a new t* file or unit test
+suite, so that they're easy to remove when compatibility is no longer required.
+If the specific compatibility need is gated behind an issue with another
+project, link to documentation of that issue (like a bug or email thread) to
+make it easier to tell when that compatibility need goes away.
+** Include a comment with an expiration date for these tests no more than 1 year
+from now. You can update the expiration date if your platform still needs that
+assurance down the road, but we need to know you still care about that
+compatibility case and are working to make it unnecessary.
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
+and for which platform.
+* Use the CI and test suite to ensure that the fix for your platform doesn't
+break other platforms.
+* If possible, add a test ensuring this regression doesn't happen again. If
+it's not possible to add a test, explain why in the commit message.
+
+Minimum Requirements
+--------------------
+
+Even if platform maintainers are willing to add tests or CI runners, we will
+not consider helping to support platforms that do not meet these minimum
+requirements:
+
+* Has C99 or C11
+* Has dependencies which were released in the past 10 years
+* Has active security support (taking security releases of dependencies, etc)
+
+Platform Maintainers
+--------------------
+
+If you maintain a platform, or Git for that platform, and intend to work with
+the Git project to ensure compatibility, please send a patch to add yourself to
+this list.
+
+NonStop: Randall S. Becker <rsbecker@nexbridge.com>

Range-diff against v1:
1:  71e537e11d ! 1:  653661002c Documentation: add platform support policy
     
      ## Documentation/Makefile ##
     @@ Documentation/Makefile: TECH_DOCS += technical/multi-pack-index
    @@ Documentation/technical/platform-support.txt (new)
     +
     +Git has a history of providing broad "support" for exotic platforms and older
     +platforms, without an explicit commitment. This support becomes easier to
    -+maintain (and possible to commit to) when Git developers are providing with
    -+adequate tooling to test for compatibility. Variouis levels of tooling will
    ++maintain (and possible to commit to) when Git developers are provided with
    ++adequate tooling to test for compatibility. Various levels of tooling will
     +allow us to make more solid commitments around Git's compatibility with your
     +platform.
     +
    -+Compatible by vN+1 release
    ++Compatible by next release
     +--------------------------
     +
    -+To increase probability that compatibility issues introduced in a point release
    -+will be fixed by the next point release:
    ++To increase probability that compatibility issues introduced in a release
    ++will be fixed in a later release:
     +
     +* You should send a bug report as soon as you notice the breakage on your
    -+platform. The sooner you notice, the better; it's better for you to watch `seen`
    -+than to watch `master`. See linkgit:gitworkflows[7] under "Graduation" for an
    -+overview of which branches are used in git.git, and how.
    ++platform. The sooner you notice, the better; watching `seen` means you can
    ++notice problems before they are considered "done with review"; whereas watching
    ++`master` means the stable branch could break for your platform, but you have a
    ++decent chance of avoiding a tagged release breaking you. See "The Policy" in the
    ++link:../howto/maintain-git.txt[maintainer's guide] for an overview of which
    ++branches are used in git.git, and how.
     +* The bug report should include information about what platform you are using.
     +* You should also use linkgit:git-bisect[1] and determine which commit
     +introduced the breakage.
    @@ Documentation/technical/platform-support.txt (new)
     +
     +* You should run nightly tests against the `next` branch and publish breakage
     +reports to the mailing list immediately when they happen.
    ++** You may want to ask to join the mailto:git-security@googlegroups.com[security
    ++mailing list] in order to run tests against the fixes proposed there, too.
     +* It may make sense to automate these; if you do, make sure they are not noisy
     +(you don't need to send a report when everything works, only when something
     +breaks).
    @@ Documentation/technical/platform-support.txt (new)
     +* You should either:
     +** Provide VM access on-demand to a trusted developer working to fix the issue,
     +so they can test their fix, OR
    -+** Work closely with the developer fixing the issue - testing turnaround to
    -+check whether the fix works for your platform should not be longer than a
    -+business day.
    ++** Work closely with the developer fixing the issue; the turnaround to check
    ++that their proposed fix works for your platform should be fast enough that it
    ++doesn't hinder the developer working on that fix. Slow testing turnarounds may
    ++cause the fix to miss the next release, or the developer may lose interest in
    ++working on the fix at all.
     +
     +Example:
     +https://lore.kernel.org/git/CAHd-oW6X4cwD_yLNFONPnXXUAFPxgDoccv2SOdpeLrqmHCJB4Q@mail.gmail.com/[AIX]
    @@ Documentation/technical/platform-support.txt (new)
     +This suite is run when any Git developer proposes a new patch, and having a
     +runner for your platform/configuration means every developer will know if they
     +break you, immediately.
    ++** If adding it to GitHub Actions is infeasible (due to architecture constraints
    ++or for performance reasons), any other method which runs as automatically and
    ++quickly as possible works, too. For example, a service which snoops on the
    ++mailing list and automatically runs tests on new [PATCH] emails, replying to the
    ++author with the results, would also be within the spirit of this requirement.
     +* If you rely on Git avoiding a specific pattern that doesn't work well with
    -+your platform (like a certain malloc pattern), if possible, add a coccicheck
    -+rule to ensure that pattern is not used.
    -+* If you rely on some configuration or behavior, add a test for it. You may
    -+find it easier to add a unit test ensuring the behavior you need than to add an
    -+integration test; either one works. Untested behavior is subject to breakage at
    -+any time.
    ++your platform (like a certain malloc pattern), raise it on the mailing list.
    ++There are a few ways to avoid these breakages, so we'll work case-by-case to
    ++find a solution that doesn't unnecessarily constrain other platforms to keep
    ++compatibility with yours.
    ++* If you rely on some configuration or behavior, add a test for it.  Untested
    ++behavior is subject to breakage at any time.
     +** Clearly label these tests as necessary for platform compatibility. Add them
     +to an isolated compatibility-related test suite, like a new t* file or unit test
     +suite, so that they're easy to remove when compatibility is no longer required.
     +If the specific compatibility need is gated behind an issue with another
     +project, link to documentation of that issue (like a bug or email thread) to
     +make it easier to tell when that compatibility need goes away.
    ++** Include a comment with an expiration date for these tests no more than 1 year
    ++from now. You can update the expiration date if your platform still needs that
    ++assurance down the road, but we need to know you still care about that
    ++compatibility case and are working to make it unnecessary.
     +
     +Example: We run our
     +https://git.kernel.org/pub/scm/git/git.git/tree/.github/workflows/main.yml[CI
    @@ Documentation/technical/platform-support.txt (new)
     +break other platforms.
     +* If possible, add a test ensuring this regression doesn't happen again. If
     +it's not possible to add a test, explain why in the commit message.
    ++
    ++Minimum Requirements
    ++--------------------
    ++
    ++Even if platform maintainers are willing to add tests or CI runners, we will
    ++not consider helping to support platforms that do not meet these minimum
    ++requirements:
    ++
    ++* Has C99 or C11
    ++* Has dependencies which were released in the past 10 years
    ++* Has active security support (taking security releases of dependencies, etc)
    ++
    ++Platform Maintainers
    ++--------------------
    ++
    ++If you maintain a platform, or Git for that platform, and intend to work with
    ++the Git project to ensure compatibility, please send a patch to add yourself to
    ++this list.
    ++
    ++NonStop: Randall S. Becker <rsbecker@nexbridge.com>
-- 
2.45.2.993.g49e7a77208-goog

