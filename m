Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920EB2D46D5
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753440043; cv=none; b=s2UyO4uNLGHD7/tH8PX7YRemDVpDTxtFmwJcQ0VJsJ1+2Xml6QP0SjZ5VrbZ8LM5YyYpDIG7foQKuGmXLTHPHt5YPpWun5izGwBHz8Ss86rwbAd6C8TeWsYbV36gO7Fm+uIDcm6PVFBZPsVjqfY0kzHmgJbCShuhMz9cVKNnQm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753440043; c=relaxed/simple;
	bh=9XcqyWC7n52fO0JLthRHDgNcarTeEZDtPlDuKlMJzTw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ikxJpV5Fjr84CQ65bT3fdacFoTqbnrLs2gB+gCHVAJOrDQRr0jGE0GL8WQnlOYsI0BExsX2r/PD3f3MpOddKAY8i/QmXvxZRRU/ThiYydr+E/4pdn0b2Rzaq1ghRwzMra9GmyHOjRoWZHqdKPOfQehjkaABzddu4Hjcw3kOF49g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3JLCHmI; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3JLCHmI"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8da9b7386dso2238134276.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 03:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753440040; x=1754044840; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TOPcjyrid3ICnMh+f5FWDX9t1dCfkMY0M4ONODmefVw=;
        b=W3JLCHmIkbkKHczcGBvorxL0u72eAEgo0HoCSEK1T30ZcsX7auW/Ku1yMppBuSID8c
         HIQJxxxKoyybDan2Xvtp6kOtB0iwPSEt1O5vWi2a/fGEqOWkXlGXXQVlJh7CwYTT8Mh+
         xQnHzMc03wzP1w+lMebUSyqrRgek8OCPo61Ja0qB31X2OtD0Pw3dTSP8y7U4wRoCIAew
         q3vZAvQgowmHTBjcIyzWAr0pc5DWv4jOfobaR2QhJCEP7Sr6lvWKRUK4NDBCY42fkHwR
         P86GiFJa08C57P2dxVKsKPOZD1dSi6CcfVCf/ND4P3U7yICj2YGzmPr1bdMf5nEyZnSg
         zMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753440040; x=1754044840;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TOPcjyrid3ICnMh+f5FWDX9t1dCfkMY0M4ONODmefVw=;
        b=UlJ9mO4YdxUcFNz3/FXwnWWUxDK4WP6d7P0I6MvI9kR2lePoYNVhMmk4/WkoTCl0p0
         yWfHPTcyYa+e2U7GBWzo8mh+RbjEmX2H3qWx8Qp1KvLMxzWfcNtD1gbalxGjn0qqZhH1
         EsaboihrZiay0IGG9tO0ks/DwXdhuP+OP4Pt5akiSdE122/4+jFx0he5lBPjpuLy6781
         mdcNUxiaYfomcdFwIjv/1k13bANyVC0NZc4GIhar6xKAVugFWPKSXdzmYkH467RvCP6x
         MWW9QREnMCgB7Gwjr0n9CLd5oFVYGmCPY5fo0Wxr8kcbaRx8gnbiHTkcgX25iRq21+he
         KIfA==
X-Gm-Message-State: AOJu0YzCB487ApO/BgZ0wM2Irhxv+pBAlRtuOB0HLk9ln5SFI1rIwTOQ
	ZB7l1AXvQAPVA3zVwevSQMtyS7FcPJ4X6yz/ZsE+CgihQmcDLRbnNJeMe37wAwRZgePYAGgqB63
	KaMXcz8b1zlxUqXUavwdYYEfVS+fdZ+jhsfZsw1ANKw==
X-Gm-Gg: ASbGncuzHc6HsKMpyu7+ZUFux3M8DihpbMAEKColSYtDzGW2cYCLO4sHsX1i0RCFqyK
	LgfMEZGZztbltEzaPP2ydFkSwfkzE3rtBM4BFc8PYX+8QTfBkvvFn6N9Ih68BfAGpBRaT98r79M
	Cw8n7+6w4Vi2aNbFx0aWPKf3ccxE6h7xo4TrfVhKEEQIF5EwvqgbKyYyEE0+YB+PamSzDc5TI7c
	pID6CAVuVBPrhV0EV0DrvFZCOPV17V/+zk2n64OCj21IK7La2iI
X-Google-Smtp-Source: AGHT+IETJHYGhY1SGYVLZkaNSBbGad1cy1HWiXTFulKi1nPlBd+5yjHunWB5vuCkhcEcI4v5gKsK5BMaRF819cl+IWA=
X-Received: by 2002:a05:6902:983:b0:e84:1f8d:da4b with SMTP id
 3f1490d57ef6-e8de1f97890mr6423804276.7.1753440039988; Fri, 25 Jul 2025
 03:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kirill Sploshnov <sploshnov1998@gmail.com>
Date: Fri, 25 Jul 2025 12:40:30 +0200
X-Gm-Features: Ac12FXyfyZ9IBeQ3aMP2UsmrV9cZLVPsCimoPyzmoWp9UCQzqTkaV-sJ8-U1ou4
Message-ID: <CAOUUZ_wzNC=D4ZLf9Qw0xhFP+3ycTcPinRSCQA7aOJsiXA_FUQ@mail.gmail.com>
Subject: Subject: [RFC] Add config option to enforce committing .gitignore /
 .gitattributes before other files
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Git community,

I=E2=80=99d like to propose a new optional safety feature in Git related to
.gitignore and .gitattributes handling.

[Problem Statement]

Some software ecosystems - such as game development tools (Unity,
Unreal Engine) and other project-based environments - rely on
predefined project folders that include .gitignore and .gitattributes.
These files:

- Exclude large generated files, build caches, and temporary data.
- Configure Git LFS for specific binary asset types.

To minimize interference with the rest of a repository, these files
are often shipped inside each project folder, not at the repo root.
This allows multiple projects or heterogeneous formats to coexist.

However, Git only applies ignore and attribute rules after these files
are staged or committed. In practice, many users copy a project into
an existing repo and immediately run:

> git add .

This stages everything - including an arbitrarily large cache or
binaries that should have been excluded or redirected to LFS. This
causes:

- Bloated history and additional cleanup.
- LFS pointer issues and git workflow disruptions ("encountered files
that should've pointers but weren't" errors for other repo users).

This problem is especially common when:

- Teams copy/import projects frequently.
- Team members include non-engineering roles (artists, designers).
- Tight schedules or manipulation of large amounts of small projects
daily make careful staging problematic.

[Proposed Solution]

Introduce an optional config that requires .gitignore and
.gitattributes to be committed before other files:

> [commit]
>     requireIgnoreFirst =3D true

[Behaviour]

- If the option is set to true and ANY .gitignore or .gitattributes
differ from HEAD (newly added or has changes) and other files are
staged in the same commit THEN the commit fails.
- Enforcement happens at git commit (not git add) to minimize disruption.
- Error message includes a ready-to-use fix:

> Error: .gitignore and / or .gitattributes changes detected and must be co=
mmitted before committing other files. Please commit them separately first,=
 before adding other changes:
> git reset && git add <path to .gitignore> && git add <path to .gitattribu=
tes> && git commit -m <commit message>

The idea is motivated by the [pre-commit](https://pre-commit.com/),
the de-facto standard extension to use for git hooks managements - it
behaves similarly, forbidding to commit anything if
.pre-commit-config.yaml has any changes, requiring it to be committed
first to avoid inconsistencies.

P.S.: this option could potentially be extended to include not just
predefined paths but a list of patterns in a [.gitignore pattern
format](https://git-scm.com/docs/gitignore#_pattern_format), but I see
little incentive to have this customizable as of now - can be
discussed, but the simpler suggested option should be sufficient for
all cases.

Benefits

- Prevents accidental commits of caches or binary artifacts.
- Reduces Git LFS misconfiguration disruptions.
- Minimal intrusion - one local config setting. May be set up globally
for companies / users with many repos.
- Easy to advocate as a solution for the given software product users.
- Zero assumptions about any repo layout or user's local / global git
configuration.

Alternatives Considered

1. Repo-level .gitignore / .gitattributes:

- Requires potentially frequent updates whenever the project's
underlying format is changed (new ignored folder or binary extension
added).
- While less likely - users can still commit root .gitignore changes
together with other project data yet-to-be-ignored - which makes the
problem rarer, but not solved.
- No way to limit settings to specific folders in general, unless
users themselves enforce some naming convention - effect will be
global (see zero assumption point above).

2. Shipped git hooks:

- Requires per-repo setup.
- Not all teams employ git hooks in their workflows - forcing their
usage is likely more overhead than just setting a single option.
- For more advanced git workflows users may already have custom hooks,
and git does not have a concept of hook wrappers / chaining - this
makes it quite hard to provide a self-contained solution provided by
the Software in question.

Additional Motivation

- As mentioned above, such an approach is employed by other widely
accepted tools, such as pre-commit.
- Other similar Git safety settings exist, like
[receive.denyCurrentBranch](https://git-scm.com/docs/git-config#Documentati=
on/git-config.txt-receivedenyCurrentBranch).
- GitHub=E2=80=99s [.gitignore templates
repo](https://github.com/github/gitignore) demonstrates the ubiquity
of project-level ignore files, some of which could definitely benefit
from the current approach, making their effect more local &
manageable.

Contribution

If there is a consensus on the feature and the concept is accepted by
the community - I am willing to contribute an implementation as the
next step.

Thank you for considering this proposal - I am looking forward to
hearing from you!
Best regards,
Kirill Sploshnov (GitHub: NormanXpp)
