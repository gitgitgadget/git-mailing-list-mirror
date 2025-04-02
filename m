Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F2C1E4A4
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617658; cv=none; b=CRUjuY8I1HZJAg6Zd6LJOTTIx/B+CL9fj6l+6An8+Um8XVYlk1CheJE8rlqXctELro/KSKUUjGvCvZVAwlD5nqYBSiuy5A5nwTrugSJyn/gNG/oAopjG5Elp0okVZMJ+VRd8IsQnZZbvwbRRpmUdsOHXATuvB9m0B5fILwGMbFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617658; c=relaxed/simple;
	bh=zN9lj7Xuv/cEbI+cHO6d3ZMPxSMXiqvhwrfFw8JBcP8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=dnNhkVSdRuPUbgi6k1h0CHdM3m+TbJYj/qpX5cgg7LE/FVmfGLk16YnOKN14ccf8Ljnn9uLdEoxBkEAwTwm6xHoC/IsKcYsMRuJZsmhwTK2A34Kh1zS19rEqfpuAZbCLdvsk5Y/QIFNW8/NOdSs8Z8myc7xd79gMgEt7Fdv0T0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNcIzSzC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNcIzSzC"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736dd9c4b40so406990b3a.0
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 11:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743617656; x=1744222456; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+9mHqJ7/FwRNYoj+CA26bwO/ue/JuOvG8QoEt9TgVs=;
        b=HNcIzSzCQFvrg1dxkl/ciNeGg3MsiuwZBvCLdxRJjaDVEmLJjSZCvYQtR2mVZ6hI1C
         condcviIWCzt/6jVnNmIJd16GSP86W1PnfZ8IZlDZIWr6dbId4thsICzL+tcxHiMLmoM
         GyJkRVG17cB9rYqe1PWtw1nxBNCi2jLBaUvmyfkphYicCONPEAdghH2uMrNoC+ujElXA
         x7ypz3UiEJQFW30d3kHsruH2Qe9mC7/yss4qenEjmulMKGTN85mk++pjgYZX/Y+Z8+pR
         cSgEFcVkT8xNEPmkkDSpQK9zab+FeX7/97j1Jj3fcPXDMBkBxexTB5F3x/2R7rLTwDNU
         JALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743617656; x=1744222456;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p+9mHqJ7/FwRNYoj+CA26bwO/ue/JuOvG8QoEt9TgVs=;
        b=rpEbp46IQadXEtAEwWjVSqncYT+D5F4rI78HbZs3ZvEUrXaez9bBzqKM9pWxNWD0ND
         3AIvNiYhI6JlnGqVELkPGLoDsyWwHDSNhd4FbhZbWu2ETdZtj4yA0YQzpVCI/bCxUFz1
         eRmQo8jVG+PKpGX+cPfR7Zy9XmiLfXOjr9w1BxpxXHlwCumtC7kUhhMLjlGkdH/h1rrL
         1a8DXcOjz1n44lHJuQITQ1bSN0trn+qtxA9MlWh8dVEurGc7uNA/cUwr23AHqmyN8rwr
         YL3LkK2K+4MZWLyjrm+X9l9CJUtrGyCu/tP9/HbygzEJHPFiPOTgh1L3n6oac+eoVzJg
         b8OQ==
X-Gm-Message-State: AOJu0YzQN5MuFqrqr1YOLLfISJuR6EjYL2JX32qYvlCWR9lEGsI2B4oT
	ZwEZb0ITesO70R2nHd7hz9yrsQigZl0k5/353kHDmBhhpu+xAlinvDQwhw==
X-Gm-Gg: ASbGncvTuNRmpyUeEjSxglcZvIm8c9wqjnBpmakIPBO++YyHOtvvrwUL1kpCcybhRyi
	uWaO9NRhj8ho4TYtTy3zvM4eEwd2NQd7754Rcr+3IRpRQ/QGdSOjs0Q1it/h+IANHJIR5tBFUUm
	e7XRzC24whdrvv2zaZmSyYo0a6nTzaJfrVPk3KLpdvfa6OmjYwxGJybPilvPTKVzWEHZVrz7T3p
	1oPPKtr6Iasjq7cGhlXq98ckz4z4F9HKLSJOGosHUjhmbakZyClN3/0y5y3R/Kln6FRvYmVwXGp
	QNnD6QNUa2ICwRwujl0nK7CPCX6hUlSoO0MBen2lniqGvKhOyQ==
X-Google-Smtp-Source: AGHT+IFC+07GFnGQJ38TwN5ZzeI1ugKuZX3x8Ly2S+zxLI/09uPnEFTbXJHpW+E6MNR3QxnmvUWvxQ==
X-Received: by 2002:a05:6300:4044:b0:1ee:450a:8259 with SMTP id adf61e73a8af0-200f570f848mr574234637.18.1743617655969;
        Wed, 02 Apr 2025 11:14:15 -0700 (PDT)
Received: from [10.61.75.249] ([103.21.124.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b8ad858sm10077711a12.60.2025.04.02.11.14.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 11:14:15 -0700 (PDT)
Message-ID: <1077615a-1c31-416d-a754-58b36d404289@gmail.com>
Date: Wed, 2 Apr 2025 23:44:12 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Arnav Bhate <bhatearnav@gmail.com>
Subject: =?UTF-8?Q?=5BGSoC_PROPOSAL_v1=5D_Refactoring_in_order_to_reduce_Git?=
 =?UTF-8?Q?=E2=80=99s_global_state?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

## Personal Information

- Full name: Arnav Akshaya Bhate
- Email address: bhatearnav@gmail.com
- Mobile no.: +91 8291328838
- Time zone: UTC+05:30
- Education: IIT Bombay
- Year: Second year
- GitHub: https://github.com/arnavbhate

## About Me

I'm Arnav Bhate, a second-year UG student at Indian Institute of
Technology Bombay. I love coding and so I am a member of IIT Bombay's
Developers' Community (DevCom), which is a group of roughly 40 people
developing software for use by students and staff of the institute. Most
of the software developed is not open source, so I can not include
examples of my work there in this proposal. Being a member of DevCom has
exposed me to collaborative software development.

A common link in all software I have worked on is that Git has been used
for version control. I thus see this project as my way of giving back to
the Git community in particular and open source in general. This will be
my first significant contribution to the open source community, and I
wish to stick around afterwards.

## Overview

Git currently uses many global variables, most significantly
`the_repository`, which are included in roughly 290 files. Apart from
`the_repository`, there are many global variables, some of which
logically belong in struct repository, as they represent information
specific to a repository. So even if all instances of the_repository
were converted into a extra repository argument for the function, there
would still be many global variables left.

The use of such variables assumes that Git will only operate on one
repository at a time, which renders multi-repository handling
impossible without kludges.

This project aims to move such variables from global scope into more
appropriate local contexts, mainly `struct repository` and
`struct repository_settings`. This will not only make the environment
repository-specific, allowing easy multi-repository handling, but also
make maintaining the code easier.

The project involves identifying suitable locations for environment
variables in repository specific structs, moving them there and updating
all the code affected by the move.

## Pre-GSoC

I first got into Git's codebase in February 2025, with my first
contribution in March. My first patch was on my microproject and since
then I have submitted two more patches on a similar topic.

### Patches

- (Microproject) decorate: fix sign comparison warnings  
  Thread: https://lore.kernel.org/git/afa6b428-3190-42ae-9eac-540c95b576fd@gmail.com/  
  Status: Merged into master  
  Commit hash: 2bfd3b368572cbf1ce287de09db08b7e7e429ecd  
  Description: Refactoring of decorate.c to replace signed variables
  with unsigned ones when they are used to iterate over arrays whose
  sizes are represented by unsigned variables, and remove 2 unnecessary
  variables which just hold the value of another variable without being
  modified, replacing them with the variable whose value they were
  holding.

- rm: fix sign comparison warnings  
  Thread: https://lore.kernel.org/git/38de63ce-6d4e-4f1f-95b1-049df78d9cfc@gmail.com/  
  Status: Under discussion  
  Description: Refactoring of rm.c to make iterators over arrays whose
  sizes are represented by unsigned variables unsigned. Specifically in
  `get_ours_cache_pos`, where before a signed variable was being passed
  and then inverted in the function, now the already inverted variable
  is passed as an unsigned variable, with the inversion moved to the
  function call.

- pathspec: fix sign comparison warnings  
  Thread: https://lore.kernel.org/git/a3aa5f99-63ce-4be5-8d64-fb6e226b3bf9@gmail.com/  
  Status: under discussion  
  Description: Refactoring of pathspec.c to make array iterator
  variables match the type of the variable storing the array's size.
  Where replacing the variable's type is not possible, because of the
  large-scale cascade replacements it would cause, an appropriate cast
  has been added.

## Proposed Plan

- Identifying all occurences of `the_repository` and updating them to
  use a `struct repository` passed to the function.

- Identifying global variables that should be moved and identifying
  suitable locations, some could be moved directly into
  `struct repository`, some in its sub-structs that already exist and
  some in newly created sub-structs.

- Identifying and updating occurences of these variables to reference
  their new locations.

It makes sense that all the variables need not be in the same struct, as
separation would keep the codebase organised, and thus easier to
maintain. It would also make it easier to introduce these changes
systematically, as a group of related variables, combined together in a
struct, could be introduced in a single patch series.

### Timeline

#### Pre-GSoC (Until May 8)

- Explore the codebase, identifying global variables and how they are
  used.

- Start to identify suitable locations for global variables.

#### Community Bonding Period (May 8 - June 1)

- Interact with mentor, discussing best ways to refactor various
  variables and make a plan based on that.

- If time is left, start coding early, as my summer break will have
  started.

#### Coding Period (June 2 - August 25)

- Modify functions to add an `struct repository` argument where they
  depend on `the_repository` and replace all occurences of it.

- Move global variables to their new locations in various structs,
  and refactor functions that depend on them to use their new locations.

#### Final Week (August 25 - September 1)

- Fix any bugs that may be left.

- Write final report.

### Availability

My summer break from college lasts from May to July. I am currently
planning on taking a vacation during this period of about 1 week,
however, the dates have not been decided. Outside of this vacation, I
am not occupied in the break and can devote up to 60 hours a week
towards the project. In August, once classes recommence, I will be
available for 20 hours a week.

## Post-GSoC

After completing my project, I plan on staying active and contributing
patches, and start reviewing code.

-- 
Regards,
Arnav Bhate
(He/Him)

