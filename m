Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E05D2C80
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711188217; cv=none; b=YFyDGO/hkqi1IbLmi7pMabjzZJOJAKwYyQazUQ5k8pJc5xv1cB5BTDn8D8nmJ+b1rW95yl0UG6H8ZQ1JuFsM9TzSanvOHFlLN0iNPfyMdADSCwkVdok5bky8tiKogq9xZAgKrPZ8eZVLN37cYPGZNgtZqklt5prh5OoboYNklIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711188217; c=relaxed/simple;
	bh=0yWjHrK8OM0n5/uYJqyJhHb1P6//0SkTl0wezNyeq78=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W8/O6ATMt2c98rWi6AEbxiqCHUujVzg0+e3c5WOIABB/lgEpthqqCFZ8G7xbIR4wuJVHCqDSJjTkagkBMJyJisjmLenpi23mP3h8fcjNFt1Tx5zmVoRT6TVygyab2OK8y+yIHur5GJEuEdee84lEk/zMR2XUoBCVU67yFzqesOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIiG4q65; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIiG4q65"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ea9a605ca7so131591b3a.0
        for <git@vger.kernel.org>; Sat, 23 Mar 2024 03:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711188214; x=1711793014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmgMrXz02Bwp7n8Tu29GkpcX6FHSx9DtVOhDrnNgWck=;
        b=UIiG4q65fMjg2SEGagQsn5lJjDMB19PyYENeBGAoZmcDzNuimI/K6MhTp69xsHAjef
         qJGbxjGYgN2Wn6GyUz3OoB5p55uG3rmAi0Px+KyAH8AfJr/HuBtrGNdFspnVZeHX5qXT
         b2yUU9TWGFXODlnhyAHCx/9VuSUhm48Q+kHzsIDyaYihn9eSfyroI7vf7XS2ariB8ZaV
         zx3dwfg1Ugr3RHJFnUjjiNwo73MteTWp3rTlyzzH7SL4kNiO61YNF/oUD+hjOwhLpLcS
         oEbPEN7jtWehe7+4PydIqd/j3ozodoin56lTaFKyHnmbidHrQgMxLtKiplV004JdZk5r
         PcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711188214; x=1711793014;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmgMrXz02Bwp7n8Tu29GkpcX6FHSx9DtVOhDrnNgWck=;
        b=YvZHOh26Yy7+319OE4KlrSB+vvrqvQ2+vutvZmqvAfZr7aOPvGDQawywiSDA74A49X
         Rypa4X+ZByilBfl+2/CCQFzBKYF2h/u9STjYDTqjyoenGXzeK6Dk8fS1dJIxDvkTKIRZ
         y+USxlHFDJspin6E0AhcQLKOjjTUSGrH6REOhhaoFefM9gGfSF75lO/OJgk8G0ij3LEq
         LgnPmqd0st5PV3xevysdmJbrxLOUt6tdUlLN5jaKef36zkuFuZmqerMQc5ejCojjyAlK
         cS48ui2AKBk5T+T+x1nV+JEgJn+lcc8Df5c/raYeakEdrdMU7sFwE5buhHSIKhz4cCrZ
         fUVQ==
X-Gm-Message-State: AOJu0Yx3uG0j5b3CMItrxZ7kbIwxLCcBiPqwElVXfBMJqwAt4hLwJfGj
	45gx3K6s0FcJMycH3UYr/gsKGTqbjZ95kG17wdBb2aL7SsMQ57MQDpaA8vIULvhQIw==
X-Google-Smtp-Source: AGHT+IHDTSrCrFcuh5VXqfP4bH4vWGmk51W00hpK4YD5dGtbvqV/WgMleRp6JshiNtXa4SPD8Qgicg==
X-Received: by 2002:a05:6a21:2d04:b0:1a3:8d32:c182 with SMTP id tw4-20020a056a212d0400b001a38d32c182mr2299230pzb.11.1711188213618;
        Sat, 23 Mar 2024 03:03:33 -0700 (PDT)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id 26-20020a630a1a000000b005c6e8fa9f24sm2922678pgk.49.2024.03.23.03.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 03:03:33 -0700 (PDT)
Date: Sat, 23 Mar 2024 18:03:30 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PROPOSAL v1] Implement consistency check for refs
Message-ID: <Zf6o8k-OLuVslQsa@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi everyone,

This is my proposal for the project "Implement consistency checks for
refs". The web version can be viewed at
https://docs.google.com/document/d/1pWnnyykGmJIN-wyosZ3PtueFfs_BRdvJq-cwroRorBI/

----------

# Implement consistency check for refs

## Personal Information

+ Name: Jialuo She
+ Email: shejialuo@gmail.com
+ Mobile no.: (+86) 13019582712
+ Education: Xidian University, Shanxi, China
+ Year: Final Year
+ Degree: Master in Software Engineer
+ GitHub: https://github.com/shejialuo
+ Blog: https://luolibrary.com/

## About Me

I am someone who loves coding, and my favorite quote is from "The
Shawshank Redemption": "Get busy living, or get busy dying". In my final
year as a student, I hope to continue doing valuable things.

I have some basic open-source experience, such as improving
documentation for Angular [1]-[2], adding some features to the
community [3]. I also maintain some open-source projects, mainly course
codes, book answers, and some practical in-action tutorials to help
others [4]. Additionaly, I write blogs to document and help others with
some of the public courses I’ve taken [5]. I have written a toy git by
myself due to my interest [6].

I am currently interning at NVIDIA, where I started in the software
department working on CUDA Test Development. My current position is in
the hardware department as a Tegra System Architect, and I will become
a full-time employee this July.

I hope to use this opportunity to continue participating in the git
community and contribute to open source in the future.

## Overview and Background

As [7] shows, when the "packed-refs" file gets corrupted, the
git-fsck(1) command cannot detect this situation where the "packed-refs"
file contains corrupted binary zeros.

The current mechanism for git-fsck(1) command can be classified into
two parts. The first part is to check the object database. For every
loose file which is under `$GIT_DIR/objects`, it will use the internal
method `for_each_loose_file_in_objdir` to check whether the result of the
content-hash is consistent. The second part is to check the "packed-refs"
file, it will open and parse it to iterate the refs which provides an
implicit consistency check. However, as [8] shows, when there are some
null bytes, maybe the read file operation will just simply ignore
those null bytes.

It turns out that the current git-fsck(1) command mainly focuses on
checking the consistency of the object database. It lacks the
functionality to check the consistency ref database explicitly. The
upcoming retable backend will soon be released which is a binary
format which would be hard for users to check the corruption.

And this project aims at implementing consistency check for refs
suggested by [8] and [9]. And there are two backends for git: one
is file and another is retable. Initially these checks may only apply
to the "file" backend and then apply to the "retable" backend.

The expected project difficulty is medium and the expected project
size would be 175 hours or 350 hours depending on whether to implement
consistency check for "retable" backend.


## Pre-GSoC

I first got in touch with Git codebase in February, 2024. I have only
submitted a minor patch as the microproject to get familiar with the
workflow of the Git community.


### MicroProject

t9117: prefer test_path_* helper functions
  Mailing list thread:
  https://lore.kernel.org/git/20240304095436.56399-2-shejialuo@gmail.com/
  Status: merged into master
  Description:
  test -(e|d) does not provide a nice error message when we hit test
  failures, so use test_path_exists, test_path_is_dir instead.

### Discussion

I have discussed with the community for some implementation ideas in
[10] which is the fundamental of the "Proposed Project" part.

### Learning the Source Code

During the time from completing the microproject until now, I have
primarily read the source code related to `fsck.c` and ref internals.
I have summarized the implementation diagram of the ref mechanism as
shown in [11].

### Previous Work

This project might be a new idea here. It is proposed mainly due to
the new-released retable backend [12].

## Proposed Project

As [10] shows, Patrick wrote:

> Some ideas from the top of my head:
>
>  - generic
>    - Ensure that all ref names are conformant.
>    - Ensure that there are no directory/file conflicts for the ref
>      names.
>  - files
>    - Ensure that "packed-refs" is well-formatted.
>    - Ensure that refs in "packed-refs" are ordered lexicographically.
>    - Check for corrupted loose refs in "refs/".
>  - reftable
>    - Ensure that there are no garbage files in "reftable/".
>    - Ensure that "tables.list" is well-formatted.
>    - Ensure that each table is well-formatted.
>    - Ensure that refs in each table are ordered correctly.

### Generic

It's easy to ensure that all ref names are conformant. The
git-check-ref-format(1) provides the functionality to check whether
the name of a ref is ok. It eventually calls the `check_refname_component`
in the `ref.c` file. And I have understood the rules of the ref name
as the following:

- Hierarchial Grouping:
    - Valid: `refs/heads/feature/new-feature`
    - Invalid: `refs/heads/.hidden-branch` (begins with a dot)
    - Invalid: `refs/heads/feature.lock` (ends with `.lock`)
- Contain at Least One Slash
    - Valid: `refs/heads/main`
    - Invalid: `main` (no slash)
- No Consecutive Dots
    - Valid: `refs/heads/feature/new.feature`
    - Invalid: `refs/heads/feature..new-feature` (contains `..`)
- No ASCII Control Characters, Space, Tilde, Caret, or Colon
    - Valid: `refs/heads/feature/new-feature`
    - Invalid: `refs/heads/feature^new` (contains `^`)
    - Invalid: `refs/heads/feature: new` (contains `:` and space)
- No Question-Mark, Asterisk, or Open Bracket
    - Valid: `refs/heads/feature/new-feature`
    - Invalid: `refs/heads/feature/new?feature`
    - Invalid: `refs/heads/feature/*` (contains `*`)
- No Leading or Trailing Slash, No Multiple Consecutive Slashes
    - Valid: `refs/heads/feature/new-feature`
    - Invalid: `/refs/heads/feature/new-feature` (begins with `/`)
    - Invalid: `refs/heads//new-feature` (contains `//`)
- No Ending with a Dot
    - Valid: `refs/heads/feature/new-feature`
    - Invalid: `refs/heads/feature.` (ends with `.`)
- No Sequence `@{`
    - Valid: `refs/heads/feature/new-feature`
    - Invalid: `refs/heads/feature@{time}` (contains `@{`).
- Not the Single Character `@`
    - Valid: `refs/heads/feature/@new-feature`
    - Invalid: `@` (single character `@`)
- No Backslash
    - Valid: `refs/heads/feature/new-feature`
    - Invalid: `refs/heads/feature\new-feature`

So for ref names, we could reuse this function for every backend.

### The Interface For Two Backends

From the discussion in [10], Patrick wrote:

> For what it's worth, not all of the checks need to be implemented as
> part of GSoC. At a minimum, it should result in the infra to allow for
> backend-specific checks and a couple of checks for at least one of the
> backends.

I think the most important thing for this project is to setup the
infrastructure with good flexibility which allows backend-specific check
and programmer can add checks easily. This is the reason why I dive into
ref internal, I want to understand how Git handles these two interfaces.
And I want to reuse this idea to add ref consistency checks.

As picture [11] shows, the `ref_store` is the core abstraction provided
by the `ref_internal.h`, it is the base class which contains the `be`
pointer which provides backend-specific functions whose interfaces are
defined in the `ref_storage_be`.

In my view, I think we could reuse this polymorphism. We could define
some common interfaces or only one interface in the `ref_storage_be`.
For every backend, it needs to provide its own function pointer. And
we could reuse `ref_store` structure to do this.

At last, we can use this polymorphism in `fsck.c` to elegantly setup
the infrastructure. And it has the following advantages:

- Reuse the current polymorphism provided by `ref_store`.
- We can add checks easily for future.

### The Concrete Checks

At current, this project proposal cannot determine the concrete checks.
It should be discussed to make the checks concrete and clear.

### Timeline

Pre-GSoC
(Until May 1)
- Continue to read the source code especially for retable backend.
  Understand the retable format to determine the concrete checks
  with mentors.

Community Bonding
(May 1 - May 26)
- Talk with mentors to determine the detailed infrastructure should be
  implemented to provide flexibility for programmers. Also, determine
  the checks for the generic part and continue understanding the retable
  format and code.

Phase I
(May 27 - July 7)
- Implement the infrastructure to support both file-backend and
  retable-backend. Write tests to make sure the correctness of the
  infrastructure. And then add the some generic ref checks both for
  file-backend and retable-backend (such as use existing
  `check_refname_component`) and write tests.

Phase II
(July 7 - Aug 19)
- Talk with mentors to determine the ref checks for file-backend and
  continue to add ref checks for file-backend. Also add write unit tests.

Final Week
(Aug 19 - Aug 26)
- Fix any bugs.
- Write the final report.

However, in my perspective, I hope this project could last 22 weeks and
I could add ref checks for retable-backend. But due to uncertainly,
I omit the timeline here.

### Availability

Currently, I am engaged in a remote internship, which allows me to
work 2-3 hours each evening from Monday to Friday. On weekends, I
am able to dedicate 8 hours each day to work. As I am in my final year
and do not have exams, I can commit to 20-30 hours of work per week.
Even after becoming a full-time employee in July, my schedule will remain
similar to my internship period. Additionally, I am able to continue
working until November (22 Week Project).

## Post-GSoC

After completing the GSoC, I plan to continue working on the code related
to retable and read other modules in Git. This was my original intention
for participating in GSoC, to integrate into the community through this
opportunity and, if possible, to become a mentor in the future, igniting
the flame in others' hearts. Most importantly, to "Get busy living."

## Closing Remarks

Thanks for every review for reviewing this proposal. It’s my honor to
work with the community.

## References

[1] https://github.com/angular/angular/pull/44674
[2] https://github.com/angular/angular/pull/44628
[3] https://github.com/ehForwarderBot/efb-qq-plugin-go-cqhttp/pull/68
[4] https://github.com/shejialuo/database-systems-complete-book-solutions
[5] https://luolibrary.com/categories/CS144/
[6] https://github.com/shejialuo/ugit-cpp
[7] https://lore.kernel.org/git/6cfee0e4-3285-4f18-91ff-d097da9de737@rd10.de/
[8] https://lore.kernel.org/git/20240120010055.GC117170@coredump.intra.peff.net/
[9] https://lore.kernel.org/git/ZakIPEytlxHGCB9Y@tanuki/
[10] https://lore.kernel.org/git/Ze2E_xgfwTUzsQ92@ArchLinux/
[11] https://s2.loli.net/2024/03/23/3YGoBgZzHNtOfVw.png
[12] https://lore.kernel.org/git/cover.1706601199.git.ps@pks.im/
