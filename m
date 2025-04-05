Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B8F61FF2
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743878483; cv=none; b=EmwWHPvEzmDtzRhG46bz5VjNSH+wRMuqguJqcXBNwusXO2de9tcHcQg4XeNuOSGGulyqYf0vv1hpIINmEmrhxcAwYYjqMeDYdeqbzPlVf63h27Yrm1ivzSv3Dll4b/H0wEWnHtzVEtr4+IfHxbeEvYKi0kiHrnyQy16NHfq7X0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743878483; c=relaxed/simple;
	bh=8zF+yG3T7va/Mk9MtO1c/9RXjeMW+RUgssMSPG1u9ns=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=CB0GBtt539zMTAJ9W+Q42G2BXZGjd6VJAxF8QG+pwWRSp6tv6GprrRKnNeImfSSSJl1bDkNRmB2Tpr600fKim1cRFItUF++RDk2fdDUlH1mbdzyxY94csdaJarBp/6K4mW/7XtZeiMjo4N/s1LNiLBRhrheH9FW7YAVsHWJK3O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBXT1KuV; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBXT1KuV"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736a7e126c7so2763380b3a.3
        for <git@vger.kernel.org>; Sat, 05 Apr 2025 11:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743878481; x=1744483281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vJ5hCDAUyIGMjxv80jWFbWvrux0XkslJmqoZzYuRlHA=;
        b=SBXT1KuVStn0jwikZ7Ehc3yl8drH+4Ra5PM9B2ASUUSNiTWDFpTtdlnysHApxPrXd/
         /EchM8Kbucwdct40DRQ+aLK5cRvfIdabTWzcDPgO8TKuhm11SPntBhIl+oNc4zFcTwWE
         WlfSx4jgsQ9Jr4NuGRBxGobubcj8aeXYz+mlp5UkYQb9ynHOwlflzXpXU8aeZJliyaeI
         Mz8LXGFFCP5aAHVgP2AGPmRy3gsyq2bXCfPyOvyE0OtXegj3Eqx/oF7yWsvYdG/DXqiz
         w22paNS7twLw5VBAZvqyD9PO6JM4vdw32VHXs4+NjLUnGBNEpM7gTzIfKUi2DPVbzM6h
         z88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743878481; x=1744483281;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ5hCDAUyIGMjxv80jWFbWvrux0XkslJmqoZzYuRlHA=;
        b=j8TarN0cSFiBaEZvi8XmrGr4QqZ41EldkIBFeK42Jl7mp5/9sKZ6DzcqpFuOtZ3ic1
         4rBdG46Y3SENsxOB1BfQNk2A2hCHE0lNEersTiqR1rF+x9ug0S7EEegeh+yZZTe6ROeW
         gUy1DC+QfliorowwkhFWOysg5uivwHrsDQ3r7UxEbHZrSkDIJ3LTqNxY+wg+XtFHPZaz
         87cxynW4sOW3IGORP+DE7MY+ChZiMbaNDv61NLNdJ+Iew53TXa5f6ntjPQ5zMxxOYahg
         OGVtXQUSrbUQqYS8jw4wEds/lqUPN/y51VVBZRqPxsFvLOKOdPj2S1RyE+UGuYa2GU/E
         c4MQ==
X-Gm-Message-State: AOJu0YycEytUZR6L1CgufA2JtSY2x2CKvHa+GQp/FMxBWMznDQlkR56o
	42QwZ/wuzVPwdMeNsv7/cZmsTzw06Fo8xND1dKaWRCql8ebiSK13V/hQ2A==
X-Gm-Gg: ASbGncs4ofE5HNsQgFxqoWk4mJBW3hPr3WsvIQ+wZDEceQtdKw8R07AcgYQMJnhaSqq
	roYNrKzxtE8JLCzY8b8koo7EXAzERie+A013ugeg+MC+Fq4YXYLbcdKdv7gtQSfoSkYDP+rvSQD
	gRLMwdpPa5Sws/A74u022rNx4v/MroyE5l+duMyKPkhrKH8n/yWmtslEqC3HLwEyXFahcztVTc5
	yG5JvLq04ccQ28kCeAZjNLAKCSEfYAs93F4dSWNphQ4fijpUQ/7LIDkP0U9bENsK/J4jh31P4rr
	B+zyCNpvwkskcDZRV+IIqhGzBMFgbYHOcRG+1PxpNdzEYzH4kuJXUnz3bNI1klweQJIGd5AGm2y
	S9u44/jLxiymY70bjAA==
X-Google-Smtp-Source: AGHT+IFBFXmN24Wre9sFdqEZ4dMhrISYc6Cq4y+EK0/EbugBItNLzQIsXnAkG3fe6ciHCcVVykq2Eg==
X-Received: by 2002:a05:6a20:d50b:b0:1f5:79c4:5da2 with SMTP id adf61e73a8af0-201047368bbmr13654193637.31.1743878480574;
        Sat, 05 Apr 2025 11:41:20 -0700 (PDT)
Received: from ?IPV6:2400:1f00:2:cc93:949d:973c:1dab:4995? ([2400:1f00:2:cc93:949d:973c:1dab:4995])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc2cf3c2sm4705609a12.10.2025.04.05.11.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Apr 2025 11:41:20 -0700 (PDT)
Message-ID: <7116fc77-2280-4bd1-b2f2-131e1108b8ce@gmail.com>
Date: Sun, 6 Apr 2025 00:11:16 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?=5BGSoC_PROPOSAL_v2=5D_Refactoring_in_order_to_reduce_Git?=
 =?UTF-8?Q?=E2=80=99s_global_state?=
From: Arnav Bhate <bhatearnav@gmail.com>
To: git@vger.kernel.org
References: <1077615a-1c31-416d-a754-58b36d404289@gmail.com>
Content-Language: en-US
Cc: Patrick Steinhardt <ps@pks.im>
In-Reply-To: <1077615a-1c31-416d-a754-58b36d404289@gmail.com>
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
  Status: Under discussion  
  Description: Refactoring of pathspec.c to make array iterator
  variables match the type of the variable storing the array's size.
  Where replacing the variable's type is not possible, because of the
  large-scale cascade replacements it would cause, an appropriate cast
  has been added.

- environment.h: remove unused variables
  Thread: https://lore.kernel.org/git/2c547567-2b72-476c-9fc5-71cac050fa15@gmail.com/
  Status: Under discussion
  Description: Removing two variables which did not have any references
  in the codebase, as they had been moved to `struct repo_settings`, but
  were not removed from environment.h.

## Proposed Plan

- Identifying global variables in environment.c that should be moved and
  identifying suitable locations, some could be moved directly into
  `struct repository`, some in its sub-structs that already exist and
  some in newly created sub-structs.

- Identifying and updating occurrences of these variables to reference
  their new locations.

- Identifying all occurrences of `the_repository` and updating them to
  use a `struct repository` passed to the function.

It makes sense that all the variables need not be in the same struct, as
separation would keep the codebase organised, and thus easier to
maintain. It would also make it easier to introduce these changes
systematically, as a group of related variables, combined together in a
struct, could be introduced in a single patch series.

### Timeline

#### Pre-GSoC (Until May 8)

- Explore the codebase, identifying locations where global variables
  from environment.c are used.

- Identify suitable locations for these global variables.

#### Community Bonding Period (May 8 - June 1)

- Interact with mentor, discussing the locations I have decided, and
  refining the plan if required.

- Start coding early, as my summer break will have started. (See coding
  period)

#### Coding Period (June 2 - August 25)

- Move global variables to their new locations in various structs,
  and refactor functions that depend on them to use their new locations.

  - Variables which represent settings from config (7 weeks)
    - Core (5 weeks)
    - Others (2 weeks)
  - Variables not from config (3 weeks)

- Modify functions to add an `struct repository` argument where they
  depend on `the_repository` and replace all occurrences of it in the
  function.

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

