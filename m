Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B70335C1B6
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773694787; cv=pass; b=sXppGYQ3MQbKHTyvKE2gc99zpovGAWRmDA1GtFMiOvIYvVDAW3ylJiLN71XRJN0aV4znk9ylI5xAWJXoQ3OR9dDkCb3JW1OuSuMKaupTdFnJ1HnZbk9dth7oiu2P5+GK1T3IINVTqS7SzXbJlAMTsLVD75gPIF358RqzD+vnGG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773694787; c=relaxed/simple;
	bh=0hqWigkTBhwjKAbRSdri0taF2cwtuK2qxGtVnK9cEIc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=TSNsIZC/P3vuCtsw04q2pj+MfyusTv1sHgvItzcwRQR2JczXqPzzeGinCc5dBMYzFvG+o24g8qVlRxIgCQAI15G/aRzh9NGQKUIvGoxGnSxS7w6je7ver0N6EMAYwVihGI1ypWZJA8jfkuSZd98Xoy9ji9D8HJsdhr5iQz/hdqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnv6jtLG; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnv6jtLG"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5ffdd9a6155so97680137.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 13:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773694785; cv=none;
        d=google.com; s=arc-20240605;
        b=P9L6C9Mb4FGo/wfS0PtiJ5yUtR6sGRJAv8miKVxbs3uqgjZxAOlwSTu50Pplvpdllf
         I4HyA9cmMJay4ee22gGN8BnoLvQS36RfxwX6lTUkxQ3N3ewLvtN83YsysTT8gQjkArPG
         EBdHp8EPZSJY2JnE/7kwrWbigWL62BuqZdZ004HHtJ5PPNBkJi7b1KsMMQQw9kqcdRwM
         8oIz/gD6VdGm79YbLX/u3iHj++JUtfsh1jpawQJ3lcYtdaJ+IUUz4IqTU08Qsw+eHywS
         dJnF534v9ba/8sz0ILetb8AXW/ZRhI5cNmOBQwOcW6hexisrXWwll7tHTfAMrok0pp4F
         qgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=T5xrnoTyNRxg7zzdVkm55hjPERzmWPjzDZXS09UcW04=;
        fh=dJe/SEVgvjq65n5BD7aZ+48Qzyr7pQMx9Dmmc8jSloM=;
        b=dyKQKO04pCKEy3tYg4LEj8alJGTHzk5Mz8fE+PVqWRCllVCAM7TUG3bysti/CH4Q8I
         Bfi1vOD30fDuxcI38vYvS+/6XOipbqT8tdaPAEFbcG6Yuid/CoejHSBTDKM5IA373dxh
         rbf45TjfmPCCCsfPx+kwS4u59I/htP+JFDvM2rGAyMGdSlAeIZvEI/5CDxJG++OpkSYc
         gHS59CY7acdW6+Qqb1mMOtRR4OVAHaWlBEVXr0jzXRgkTIhr4DdiU3+Udi+hxFoLlJbr
         /GFT+OWo8pksqn4JW1EruAJ6H2xFJQb7f2sCrhXyrgRe9a74vOzNcnM4+4qbDyks7EHQ
         ORhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773694785; x=1774299585; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5xrnoTyNRxg7zzdVkm55hjPERzmWPjzDZXS09UcW04=;
        b=hnv6jtLG9N9ZgP8LwAKb3DBgB7CiGXnb6XPkBOacL9jYCW3BEKBFzxJccoiCMGi2sr
         W4uC/n6EOgt9vFUxhhQilMj0YBv/FHWUOYuK+4f5BnC1bFdePqtQpIjw5OZKQvumnpSD
         CgmMlKOWi0IRK/JIy0l3o+KwjSdqYLpUkSJ7QFXY6q9PcWHYNqIyKbUC0USCHKUhS3tO
         C0bMl9m2pxwYO3if4waeUwBsMgAtSRdePkEZVQ84854rlrN39/q/mdWImdXBhbhwV8o9
         o7ocWeYhk0kx3Jzmarz/gZO4UUaPXl/tIh+2OaXns//1Vjq+aPXYZAA8B58p6WRxEyu6
         hlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773694785; x=1774299585;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5xrnoTyNRxg7zzdVkm55hjPERzmWPjzDZXS09UcW04=;
        b=geU6kSyGdjTyF/f9dDm4YlJupUTn5yGT/HoKEyhIhrpnJNZCewbe76Nr+QUxuaBkG9
         3d+MhRGUsvAU5O53DFkwpC0f7htwhU5gnktK+ctyduo82E/r0Jn836aQ/bJTlkWeENjz
         9rEX8NZyqd+Xjx7I3diOt5HXCuusEdXFWJPpl/wbWlfSonxYnXGsIn3PXYy/0j6yGqAl
         NQjBXkR9nLgbp+OZJFrqjELecOb78LtvxJJFX6yI4a5+OH8vq6Rni1jw1ehj4j7NBnbh
         b4rm+nTO40cgZXlhtmC3MMV6Fx3Dd5aXAiUrIyFKo7gsIrTnpviNojLPbPVPTqooAbT8
         +nuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcz83SNvB2F7U5+qOnYEunnZfGV90H4NRKUNsPo2+xUOLiPKAFD+ja/DuNippwx+7zQes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzYiKyqxWKFKnRE06k2mJRjzMq1rm16o4SJRP4lzFLma2QnynK
	Cys1cX9XOCF6Pyh93N5IGD5+nPA2ilbuYRVPPPR2lmqt/a29hQMI5rNjtO3SQnvduYCgHNPrY0d
	a5AoSIfJ5ZQrXacQ6yj6TYkVu8EwGN6c=
X-Gm-Gg: ATEYQzw+UB0UieIyMXxAXk5MlAfmEjCDkRNhtAuVImjML0ZVHLWh1VE2ZMZ/4JqnpMK
	eKsiFIAdg5dTNej2iCoXiK831o4Ke6evKVE+HFLN68ApAfevgUw/b5beYaPDLLoy7gWj+sloSjc
	znLqTKvRexpceaJryvF/X6FhfgGCAgBeRDSvhX/Bjp1Ke1Yr6yEBxj/+SiBHUWNI4X00YZebhQZ
	YMIm9khy1YyHIOqcv61b0v5S2eZNFy8MEtJEg1EKh/uB3LrxBwbh0aK3xGu9Gur10WUEpcVhAIS
	TS4entHEuWzwPNJHQlVAocC4xReX3g41OdeCaQKp
X-Received: by 2002:a05:6102:50a3:b0:5f1:b685:e654 with SMTP id
 ada2fe7eead31-60263e28c63mr444175137.8.1773694784837; Mon, 16 Mar 2026
 13:59:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 13:59:44 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 13:59:44 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <9fc1d23fbc7d46349ac01314fbfc06eb.gsoc-proposal-draft-jerrywang183@yahoo.com>
References: <9fc1d23fbc7d46349ac01314fbfc06eb.gsoc-proposal-draft-jerrywang183.ref@yahoo.com>
 <9fc1d23fbc7d46349ac01314fbfc06eb.gsoc-proposal-draft-jerrywang183@yahoo.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Mar 2026 13:59:44 -0700
X-Gm-Features: AaiRm50D7VWUlVVs5mwzM4llP1jwue0fDwxBy6YA-pz-rkLu6NMWSqHP9LlfCWg
Message-ID: <CAOLa=ZQ7AMUb72N-0Z-h09KneE+ASuXt=BUOmO9Bzp4y6w6XyQ@mail.gmail.com>
Subject: Re: [GSoC] Proposal draft: Improve the new git repo command
To: Jialong Wang <jerrywang183@yahoo.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000973ebf064d2a7fbf"

--000000000000973ebf064d2a7fbf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jialong Wang <jerrywang183@yahoo.com> writes:

> Hi,
>
> I plan to apply to Git for GSoC 2026, and I would like to share a draft
> proposal for feedback.
>
> The project I am currently most interested in is improving the new
> `git repo` command, with a primary focus on extending `git repo info`
> with path-related repository metadata.
>
> My draft is below. I would appreciate feedback on whether this scope
> looks reasonable, and which parts of the current `git repo` work would
> make the best starting point.
>
> Thanks,
> Jialong
>
> ---
>
> # Improve `git repo info` by adding repository path metadata
>
> ## Name
>
> Jialong Wang
>
> ## Email
>
> jerrywang183@yahoo.com
>
> ## Preferred project size
>
> 175 hours
>
> ## About me
>
> My name is Jialong Wang, and I plan to apply to Git for GSoC 2026.
>
> I have been getting familiar with Git=E2=80=99s development workflow by b=
uilding
> Git from source, reading the contribution documents, and working on a
> microproject. As part of that process, I prepared and sent a patch to
> the Git mailing list.
>
> I am interested in the new `git repo` command because it is user-facing,
> but also closely tied to Git=E2=80=99s internal repository model. That ma=
kes it
> a good fit for the kind of work I want to do: understanding existing
> code, discussing design details on the mailing list, and implementing
> improvements in small, reviewable patches.
>
> Relevant links:
>
> - Microproject discussion thread:
>   https://public-inbox.org/git/CAKWWG_nGhD6vqhAS1mkEwBQPrg_YX0+C3-xW=3DQ3=
ifFDw4dDviw@mail.gmail.com/
> - Microproject patch thread:
>   https://public-inbox.org/git/20260315231538.68586-1-jerrywang183@yahoo.=
com/
> - SoC 2026 idea page:
>   https://git.github.io/SoC-2026-Ideas/
>

Perhaps it would be nice to give a few lines about what the microproject
discussion thread and patch thread are about.

It also helps if you can state the current status, maybe look at other
proposals for examples around this.

> ## Project summary
>
> I would like to work on improving the new `git repo` command, with a
> primary focus on `git repo info`.
>
> The `git repo` command was introduced to provide a cleaner interface for
> querying repository metadata. However, several useful path-related
> values are still mainly accessed through `git rev-parse` and
> `git rev-parse --git-path`. My proposal is to extend `git repo info`
> so that it can expose a selected set of those values in a more
> structured form.
>
> The goal is not to replace `git rev-parse`, but to make `git repo info`
> more useful as a structured interface for repository path metadata.
>
> ## Motivation
>
> Today, scripts and tools still often rely on commands such as:
>
>     git rev-parse --git-dir
>     git rev-parse --show-toplevel
>     git rev-parse --git-path <path>
>
> These commands are useful, but they were not primarily designed as a
> structured repository metadata interface.
>
> Since `git repo info` already exists for this purpose, extending it with
> path-related values would make repository layout information easier to
> query in a cleaner and more consistent way.
>
> I think this is a good GSoC project because it has clear user value, can
> be implemented incrementally, and naturally fits Git=E2=80=99s patch-and-=
review
> workflow.
>
> ## Current context
>
> I am aware that work on path-related `git repo info` fields has already
> started. There have already been patch series for path keys, category
> requests, and path formatting. Because of that, I do not want to assume
> that the work described on the ideas page is still untouched.
>
> One of my first goals during the bonding period would be to review the
> current state of these discussions carefully, identify what remains
> open, and refine the project scope based on maintainer feedback. I would
> rather build on the current direction than duplicate work that is
> already in progress.
>

It would also make sense to have some sense of what that direction may
look like and add that to the proposal.

> I also think this project should be scoped carefully. The ideas page
> mentions improvements to both `git repo info` and `git repo structure`,
> but for a GSoC project I believe it is more realistic to focus first on
> `git repo info` and only expand beyond that if the main work is in good
> shape.
>

That's a fair assessment, what we do like to see is how you plan to
structure the goals and possibly future work into the timeline. Reading
on.

> ## Proposed work
>
> The main objective of this project is to extend `git repo info` with
> selected repository path values that are currently obtained through
> `git rev-parse` and `git rev-parse --git-path`.
>
> The work will involve:
>
> 1. Studying the current implementation of `git repo info`.
> 2. Comparing its current output with commonly used `git rev-parse`
>    path queries.
> 3. Identifying a first small set of missing path-related values to add.
> 4. Discussing output design on the mailing list, especially where there
>    are open questions about relative versus absolute paths.
> 5. Implementing the agreed functionality through small patch series.
> 6. Adding tests covering the new behavior.
> 7. Updating documentation if needed.

Generally each commit should be self contained with tests and
documentation, so perhaps 5, 6, 7 are a single point with subheadings?

>
> ## Initial scope
>
> The first stage of the project would focus on a small set of commonly
> used repository path values, for example:
>
> - `git-dir`
> - `common-dir`
> - `toplevel`
> - `superproject-working-tree`
>
> I think these are a good first target because they are already familiar
> to users through `git rev-parse`, and they provide immediate practical
> value without requiring a large interface expansion.
>
> Depending on project progress and mailing list feedback, I would then
> like to extend support to selected values currently accessed through
> `git rev-parse --git-path`, such as:
>
> - index file
> - objects directory
> - hooks directory
>
> I do not want to promise every possible path-related key up front. I
> would rather start with the most straightforward and useful values, get
> feedback early, and continue from there.
>
> ## My approach to scope and quality
>
> One thing I would like to be careful about is not treating this project
> as a simple checklist of fields to add.
>
> I think the quality of the project will depend on three things:
>
> 1. choosing a small set of fields that make sense together,
> 2. agreeing on a consistent path representation,
> 3. and making sure the result fits naturally into the existing `git repo`
>    design rather than becoming a thin wrapper over `git rev-parse`.
>
> Because of that, I would prefer to make progress in a few coherent
> batches instead of adding many unrelated keys at once.
>
> I also think it is important to keep room for scope reduction. If some
> part of the design turns out to be more controversial than expected,
> I would prefer to complete a smaller, cleaner set of path fields rather
> than stretching the project too broadly.
>
> ## Technical approach
>
> The implementation of `git repo` is primarily in `builtin/repo.c`. The
> first step would be to understand how `git repo info` currently collects
> and prints repository metadata, and how that existing structure can be
> extended without making the interface inconsistent.
>
> Many relevant repository paths are already available internally through
> helpers such as:
>
> - `repo_get_git_dir()`
> - `repo_get_common_dir()`
> - `repo_get_work_tree()`
>
> Similarly, `git rev-parse --git-path` already relies on existing path
> resolution logic. So the work is not about inventing these values from
> scratch, but about exposing a selected subset of them through
> `git repo info` in a way that fits its current design.
>
> The first implementation step would be to map existing helpers and path
> resolution logic to a small set of `repo info` fields. After that, I
> would extend the output code in `builtin/repo.c` to report those fields
> in a consistent way.
>
> One of the main design questions is path formatting. The ideas page
> explicitly mentions the need to decide between relative and absolute
> paths. I do not want to assume the answer in advance. Instead, I would
> review the current discussion, compare the behavior of existing
> commands, and propose a small, consistent approach on the mailing list.
>
> I also expect that some preparatory cleanup or refactoring may be useful
> before adding new fields. If so, I would keep that work minimal and send
> it as small separate patches.
>

Something I would like to see is how we can leverage the existing tests
for `git-rev-parse(1)` and use them.

> ## Patch strategy
>
> I expect the implementation to be divided into small patches so that
> each change can be reviewed independently.
>
> A likely patch strategy would be:
>
> 1. small preparatory cleanup if needed
> 2. add support for a first path-related key or a very small set of keys
> 3. extend support with additional related keys
> 4. add or refine tests for the new behavior
> 5. update documentation if necessary
>
> If existing in-progress series already cover some of these parts, I
> would adjust the breakdown accordingly and focus on what remains useful
> and open.
>
> ## Tests
>
> Tests would be added to cover the new behavior in common repository
> setups.
>
> Depending on the exact scope agreed on, test cases may include:
>
> - ordinary repositories
> - linked worktrees
> - superproject/submodule cases
> - cases where path values differ from simple defaults
>
> I would keep the tests focused on observable behavior instead of
> overfitting them to a particular implementation detail.
>
> ## What I will not try to do
>
> To keep the project realistic, I do not plan to:
>
> - redesign all of `git repo`
> - fully replace `git rev-parse`
> - implement every possible repository path query
> - work on both `git repo info` and `git repo structure` at full scope in
>   the same project
>
> The project should stay focused on a well-defined subset of path-related
> metadata for `git repo info`.
>
> ## Expected deliverables
>
> By the end of the project, I expect to deliver:
>
> - support for a useful set of path-related values in `git repo info`
> - tests covering the new functionality
> - documentation updates if needed

wouldn't documentation be definitely needed? ;)

> - one or more patch series discussed and refined on the Git mailing list
>
> ## Timeline
>
> ### Community bonding period
>
> - Study `builtin/repo.c` and the current `git repo info` implementation
> - Review recent and ongoing mailing list discussions related to `git repo=
`
> - Compare current `git repo info` behavior with `git rev-parse`
> - Refine the exact scope with mentors and mailing list feedback
>
> ### Phase 1
>
> - Implement a first small batch of path-related values
> - Send the first patch series
> - Address review comments
> - Add tests for the first batch
>
> ### Phase 2
>
> - Implement additional agreed path values
> - Continue design discussion if needed
> - Refine implementation and tests based on review feedback
>
> ### Phase 3
>
> - Complete remaining agreed work
> - Update documentation if necessary
> - Rework earlier patches if needed for consistency
> - Prepare a final summary of the work
>
> ### Buffer time
>
> - Handle review delays
> - Fix regressions or edge cases
> - Narrow scope if some planned work turns out to be too large
>

We generally do timelines in terms of weeks of GSoC. So it would be nice
to see that mapping over the phases mentioned here.

> ## Risks and mitigation
>
> One risk is that design discussion may take longer than expected,
> especially around path representation and output structure.
>
> To reduce that risk, I would keep the patch series small and prioritize
> the least controversial values first.
>
> Another risk is overlap with work already in progress. If that happens,
> I would adjust the project scope to avoid duplication and focus on what
> is still useful and open.
>
> ## Why I think I am a good fit
>
> I have already started learning Git=E2=80=99s normal contribution workflo=
w
> through a microproject, including building Git from source, running
> tests, preparing a patch, and sending it to the mailing list.
>
> This project fits the kind of work I want to do in Git: understanding
> existing code, discussing interface details on the mailing list, and
> implementing improvements incrementally in small patches.
>
> ## References
>
> - SoC 2026 idea page:
>   https://git.github.io/SoC-2026-Ideas/
>
> - General application information:
>   https://git.github.io/General-Application-Information/
>
> - `git repo` documentation:
>   https://git-scm.com/docs/git-repo
>
> - `git rev-parse` documentation:
>   https://git-scm.com/docs/git-rev-parse
>
> - `git-sizer` project:
>   https://github.com/github/git-sizer
>
> - Recent patch series adding path-related support to `git repo`:
>   https://public-inbox.org/git/20260228224252.72788-1-lucasseikioshiro@gm=
ail.com/
>
> - More recent work-in-progress series for category/path keys and
>   `--path-format`:
>   https://public-inbox.org/git/pull.2208.v6.git.git.1772428548.gitgitgadg=
et@gmail.com/
>
> - Recent GSoC proposal thread on improving the new `git repo` command:
>   https://public-inbox.org/git/20260303140732.16886-1-pushkarkumarsingh19=
70@gmail.com/
>
> - Another recent GSoC proposal thread on improving/extending `git repo`:
>   https://public-inbox.org/git/CA+rGoLd-1Mb5JG1H1PvE-kyjdznrLVFjwQiMLHtd2=
ETQ-igmXg@mail.gmail.com/
>
> - Recent proposal thread focused on the same SoC idea:
>   https://public-inbox.org/git/CAO_P5U3g_+RpnDUmEv_qX-3GVhpxLV97eMxP1apER=
c0KU_95tQ@mail.gmail.com/
>
> - Recent discussion around `git repo structure` enhancements:
>   https://public-inbox.org/git/CAO_P5U2f4MD-URre+4ocC=3DYQ570hr03pZHDk1jv=
uSOKx4aLOCA@mail.gmail.com/
>
> - Microproject discussion thread:
>   https://public-inbox.org/git/CAKWWG_nGhD6vqhAS1mkEwBQPrg_YX0+C3-xW=3DQ3=
ifFDw4dDviw@mail.gmail.com/
>
> - Microproject patch thread:
>   https://public-inbox.org/git/20260315231538.68586-1-jerrywang183@yahoo.=
com/
>
> - Review on the microproject patch thread:
>   https://public-inbox.org/git/CAOLa=3DZTpfHUySnMgCFMnvo2JcRSv8zqFP-cLFSs=
+Ab5Cy2zsvg@mail.gmail.com/

Regards,
Karthik

--000000000000973ebf064d2a7fbf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d81f62ae3e1efd5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tNGJ6MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNTdUQy80NVFPb3pXNUdWZDBEM01VNGZaL1JBMVdLWQptdFB3MlZLZDJR
NUQ4em9rK093RmNualErQmtsdnRlbjRkdjkyUVdGUmdMb0F6aVlQbWlaMjRRY3U1NHZmYmpIClVh
RXFianl0RTBBTHo2ZkJSY2pCL1F0MlNxdzJPS0dsMElzNy82aUlTSkhsUGQ3cXNON3NJNFBPMjd3
c0FDWEwKYTBscVRBSFZXczUyeTRYZmN2ZFRVbWVTNWFVc1pKeGl6SWhMeWRmSVFGVmdCSVZtMkU3
QzZMcWp3aG1oUXN5Ygp0UmVWNkNmMVV0NFJyZWlKZ3pGV2NQeDhkbW9LUFFIdHJvRFd3bllFZ0d4
eEpua29pdlRXQTQ4UUdNTi9FMXRFCnh6Q0lTVlpsMXE4d2dxY1EyVmNoWlJXcitHREN0ek1KTnIr
cm5nZ1Uxc284U0ZzS3A1cTRxM0ZLVFlGeThKbG0Kd3JIOUpxVHFYem04bVRkSzNZdmtBWUtCYm9m
bW1FSU5Zbk1vQzNwRHgvS0NxbUV5ZitOZW1UaTAxZ1N5aWRROApqNVVwa296R2plR1QrNTM0SVMv
OHh1MklScHBRS2s5Q1dWOTdHdDFZamYvNWd4NmdZMkRrbkh6TjRIRzlIcHhGCk52djZkQllYUXZX
ZXM1NzJ5b2lUazJRUEVIQ0dla1dTR3lidHVlUT0KPUY5MGIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000973ebf064d2a7fbf--
