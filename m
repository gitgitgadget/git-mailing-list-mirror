Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFD4269820
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116761; cv=none; b=Dh1uw740un/+PdQFCNB4gKWYJgVYQv7tLwu13xjfLVqHWrSyKNa49wGWYXKJJTKJeaO7DEF+dMx8j62sIo055e+ezFU6CjLTCofb15bi3eqhpd2fO0w+ktz8SX93rvvT33kq5tf3RSoMpgLsm5BJeq7OMnHgUEf+9ZsOQl73E9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116761; c=relaxed/simple;
	bh=OfhLNi2xibHqlMPEf7LGFf26UJcyXWEKhgsbhlK0WJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A329qisYK1OKYDPfhOgAicOtrejyWR/jEQyToirtQwDPDE9liEjTiDctOkH1HsfJ5d6sx6+F4J8aliVyBVI+MPKRNlYXscwVievJBixQZGQLAloJL/zSPjZFl/1Napv4qsS7GRra2c4pWtF0zL/WuZxwh2jmznDY5QKCZdx6R88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0Dil5LK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0Dil5LK"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-226185948ffso55508125ad.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 05:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744116759; x=1744721559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yflzIsYCqnAl7PL17MUrG+YY75qHfkkQES38IEslfiQ=;
        b=h0Dil5LKUMaKr55xqN0UBqrhDofRGtZx4x9UqXFM9RRQqPNtC6nEgF2J0kpdtehlwn
         FG+AbZJgwojLJuHq1AM5MV+gVvlRz3+zg8JVJcVxSwEm4ZqxUQb7mmiVT0RnHojaY2BN
         xxPm+xHyVMbD+9xs0LWUZyTcDBF1r5bgoTKO+/WQsmn3+LdRckwBuduFVgGkuv4+Oarh
         UxAH5fW3obxPsO4WtelnoGDJ3DCK0YZfieZwPieyXP9IUA8etpO8RwpmymS3BbDB5p59
         6gADJvRnIPgrRozFVhz63PaPlVWknJ3/zjdLg4wNOjxwmU7sziuvt0HyBg5jkLgcohoe
         OtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744116759; x=1744721559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yflzIsYCqnAl7PL17MUrG+YY75qHfkkQES38IEslfiQ=;
        b=eb+8bhJ0En/V7Te8rGzuBmlu1mDctA/mHmoRqhWeHCi14oNhG9Nf14/MfGDmmVO00e
         VhAv5yFrvShe4CW7naXnxT6aTt4I1MNT/3tZPvT+mrFGFV7MiINd15CSZxYImTsL5ZuR
         mLh36p5MUwS6EytLAvLDWNbLwHyrMACr7lJjgN8N35xWIyuqq4qY7D5V6AiMkSjBR9Ye
         olfWyzUnU/LY8xHJPjlk2kAN3Yaj6llBra3vVNkvxS32DLFZxbxK8uHR6pfxgPWbyXMB
         u3mWEBu5bxHTwttCGqQ9bBeOLZxFrXv512yh4m/hBk5YVpt4TivfLhJEMk2NGgRzSLNg
         +uSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0LZLnk8UT+IJZlSeQd/s+P76UnJ/e9v8SmoTrO5nBmzTQdGpVAHMiIx5oTZ9Atj/H/nU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh4AYBrBwCIfLxezxafZiip9F3KokxfoMnEn9Q/AChXQYEM4Nu
	SF855NIfWhm3RmRgbJ71BcJgemop1hIXrLUHtSPVGGSppchI339N
X-Gm-Gg: ASbGncsgMegF66ch5YCNE55VErRk94vpVdlKCLDMaZIVnaYyEA/lFMAFFLuPXFW8XWs
	YFGuZVQj2hkufP7InkjUtmhpn1h/8eQggwFZHT9E04Xi/keAj4KGrM5LyCtWcEPnLbOBDNc1LfT
	qBxZEHr3vvfvvD2K00aS6JCAJ7oeypmdQKNSTmTgiz7CHivGvWxrrSfRAXIbPR8YBkKERSDmmmm
	y+chatiuR4RkE9/PITnSApXhbHF0FziMzVMLwwcce3vXk7oNHk9SmcmczIeWw/qURTHacRmE0Hr
	CyMtSAWjMGnm7lMYz0lSzcIpzOr2IReTyH2TEOnxY3UTlzT9uca0ze8U5pnSFIrHntsA2Ks7
X-Google-Smtp-Source: AGHT+IF160RYS2Vbesw0bokWxU8mOayZsMELyjBpftuflkx9mdRpnfrwRsXCLGoT+hchNUkWfgDktQ==
X-Received: by 2002:a17:902:e54c:b0:220:c066:94eb with SMTP id d9443c01a7336-22a95539c55mr161480325ad.25.1744116758784;
        Tue, 08 Apr 2025 05:52:38 -0700 (PDT)
Received: from bl4ze-rig.iitr.ac.in ([103.37.201.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb5a13asm11014105a91.33.2025.04.08.05.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 05:52:38 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	karthik.188@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com,
	shyamthakkar001@gmail.com
Subject: =?UTF-8?q?=5BGSOC=5D=20=5BPROPOSAL=20v3=5D=3A=20Refactoring=20in=20order=20to=20reduce=20Git=E2=80=99s=20global=20state?=
Date: Tue,  8 Apr 2025 18:22:19 +0530
Message-ID: <20250408125220.59963-1-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.48.GIT
In-Reply-To: <20250326052602.265989-1-ayu.chandekar@gmail.com>
References: <20250326052602.265989-1-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,
This is the third version of my GSoC 2025 proposal for the project 
"Refactoring in order to reduce Git’s global state".

The key change from v2 to this v3 is that I’ve added how I plan to tackle 
the 'the_repository' global object.

You can view docs version here: 
https://docs.google.com/document/d/1tJrtWxo1UGKChB3hu5eZ-ljm0FtU_fsv0TnIRwu3EKY/edit?usp=sharing

---------

Refactoring in order to reduce git’s state

My Information:
---------------

Name: Ayush Chandekar
Email: ayu.chandekar@gmail.com
Mobile No: (+91) 9372496874
Education: UG Sophomore, IIT Roorkee
Github: https://github.com/ayu-ch
Blog: https://ayu-ch.github.io


About me:
---------

I'm Ayush Chandekar, a UG Sophomore studying at Indian Institute of
Technology, Roorkee. I like participating in various software development
and tech-development endeavors, usually hackathons, CTFs, and projects at
SDSLabs. SDSLabs is a student-run technical group that includes passionate
developers and designers interested in various fields and involved in multiple
software development projects that aim to foster a software development
culture on campus. Being a part of this group has exposed me to different
software development methodologies, tools and frameworks and helped me become
comfortable contributing to an open-source project with multiple contributors.
Some open-source contributions I made here are: [1], [2] & [3]

I see this project as a meaningful opportunity to deepen my involvement in
the Git community and to build a foundation for continued contributions to
open source development in the future.


Overview:
---------

Git currently uses a global object called `the_repository`, which refers to a
single instance of `struct repository`. Many internal functions rely on this
global object rather than accepting a `struct repository` as an explicit
parameter. This design inherently assumes a single active repository,
making it difficult to support multi-repository use cases and obstructing
the long-term goal of libification of Git.

A key architectural limitation is that while `struct repository` encapsulates
some repository-specific information, many important environment variables
and configuration settings that logically belong to a repository are still
stored as global variables, primarily in `environment.c`, not within the
`repository` struct. As a result, even if multiple repositories were to
exist concurrently, they would still share this global state, leading to
incorrect behavior, race conditions, or subtle bugs.

This project aims to refactor Git’s environment handling by relocating global
variables into more appropriate local contexts, primarily within 
struct repository and struct repo_settings. However, some global variables may
only apply to specific subsystems. In such cases, rather than placing them in
struct repository or struct repo_settings, they should be moved into a
context that better reflects their scope.

This change will not only make the environment state repository-specific but
also improve the modularity and maintainability of the codebase. The work
involves identifying environment-related global variables, determining the
most suitable structure to house them, and updating all affected code paths
accordingly.

The difficulty of this project is medium, and it is estimated to take 
175 to 350 hours.


Pre-GSOC:
---------

I started exploring Git’s codebase and documentation around the end of
January, familiarizing myself with its structure and development practices. I
submitted a microproject, which helped me navigate the code and contribution
workflow.

After selecting the project on refactoring Git’s state, I studied the
surrounding code and reviewed past patches ([4], [5], [6], [7], [8] & [9])
to understand the reasoning behind previous changes. 

To better prepare for the GSoC timeline, I submitted a patch related to the
project, to gain hands-on experience with both the implementation details
and the submission process. The patch focused on refactoring access to
`core.attributesfile`.

Through discussions and feedback from the community, I gained a clearer 
understanding of a key aspect of the project:
determining whether certain variables should belong to repo_settings/
repository or be part of a separate subsystem.

Junio pointed out in a feedback that not all global variables should
be blindly moved into `repo_settings`.
Specifically, for `git_attributes_file`, adding it to the repository struct
doesn’t make sense. He explained that it’s similar to how index_state is
handled, while index_state knows which repository it belongs to, the
repository struct only holds a pointer to a single index_state instance
and isn’t aware of other instances.

Following this approach, instead of placing `git_attributes_file` in the
repository struct, we can house it within an attribute set and pass a
pointer to that set wherever needed.

This practice patch gave me a clearer understanding of the project.

Patches:
--------

For git:

+ (Microproject) t6423: fix suppression of Git’s exit code in tests
	Thread:
	https://public-inbox.org/git/20250202120926.322417-1-ayu.chandekar@gmail.com/
	Status: Merged into master 
	Commit Hash: 7c1d34fe5d1229362f2c3ecf2d493167a1f555a2 
	Description: Instead of executing a Git command as the upstream component of
				 a pipe, which can result in the exit status being lost, redirect
				 its output to a file and then process that file in two steps to
				 ensure the exit status is properly preserved.

+ midx: implement progress reporting for QSORT operation
	Thread:
	https://public-inbox.org/git/20250210074623.136599-1-ayu.chandekar@gmail.com/
	Status: Dropped 
	Description: Add progress reporting during the QSORT operation in 
				 multi-pack-index verification. While going through the code, 
				 I found this TODO, which I thought was interesting however my 
				 approach assumed that the qsort() operation processes elements
				 in a structured order, which isn't guaranteed.

+ Stop depending on `the_repository` for core.attributesfile
	Thread:
	https://public-inbox.org/git/20250310151048.69825-1-ayu.chandekar@gmail.com/
	Status: WIP, needs more discussion.  
	Description: This patch refactors access to the `core.attributesfiles` 
				 configuration by moving it into the `repo_settings` struct.
				 It eliminates the global variable `git_attributes_file` and 
				 updates relevant code paths to pass the `struct repository`
				 as a parameter.

For git.github.io:

+ GSoC-participants: add GSoC 2024 participants to the list #762
	Status: Merged into master
	Description: Adding GSoC 2024 participants will help new
				 contributors understand their journey, making it easier for them 
				 to navigate the program and the project.

+ Rename references from *.txt to *.adoc in documentation paths. #769
	Status: Merged into master
	Description: Since the documentation in git is changed from *.txt to *.adoc
				 format. Update references to reflect that change.

+ Rename references from *.txt to *.adoc in Rev News editions. #770
	Status: Merged into master
	Description: Since the documentation in git is changed from *.txt to *.adoc
				 format. Update references in previous editions to reflect that change.

Proposed Plan:
--------------

I have been reviewing global variables across the codebase to understand their
dependencies and impact. To do this, I examined `config.c` and cross-referenced
it with `environment.c` to see how these variables are currently managed. The
goal of this project is to eliminate global variables by moving their
configurations into their local contexts. 

The general approach for handling a global variable begins with understanding
its purpose. This involves tracing its usage across the codebase and identifying
the subsystem it should belong to. If the variable is closely tied to
repository-related functionality, it may belong in struct repository or
struct repo_settings. Otherwise, it should be placed in a more suitable
context based on its scope.

Additionally, it's important to review previous attempts or related patches
to understand past design decisions and ensure consistency with ongoing efforts.
Finally, the global instance is eliminated by relocating the variable into the
appropriate context and passing it through the relevant code paths.

Example: Handling `is_bare_repository_cfg`
The variable `is_bare_repository_cfg` determines whether a repository is bare,
meaning it lacks a working directory. Since this property is fundamental to
how a repository functions, it should be placed in struct repository.

I have also gone through the code paths and analyzed how this variable is
initialized. We can initialize it similarly to how hash_algo is set through
the repository format. The repository format already contains an `is_bare`
field, which we can use to set this variable inside struct repository.

However, I still have some questions regarding why the is_bare_repository()
function checks for `repo->worktree` and why the `worktree struct` itself has
an `is_bare` variable. If a repository is considered bare when !repo->worktree
is true, the role of `worktree->is_bare` needs further clarification. I believe
that by engaging with the community, my understanding will become clearer.
I also went through [4] to see how John Cai's approach was. 

This is how we can also approach for other global variables.
Through multiple iterations, this approach will be refined based on feedback, 
edge cases, and community input.

Other than that, we have a global object 'the_repository'. As an attempt to  
remove this globally, Patrick introduced a macro  
`#define USE_THE_REPOSITORY_VARIABLE` in this patch: [10]. An approach I can  
follow is picking a subsystem or file, and aiming to remove the macro and  
hence eliminating the usage of 'the_repository' in that subsystem/file by 
passing the `struct repository` explicitly through the call chain. 
This approach also helps in removing some of the global variables in that  
particular subsystem. 
This is also followed in the patches by Patrick in  
[5] and [6] to tackle the object and path subsystem respectively and Karthik  
in [8] to tackle the packfile subsystem.


Timeline:
---------

Pre-GSOC: 
(Until 8 May) 
-	Explore the codebase more, focusing on environment-related code paths.
-	Document how each global variable is used and how it can be moved to 
	repository settings.  
-	Study Git’s Coding Guidelines and the Pro Git Book to align with best practices.

----------

Community Bonding: 
(May 8 - June 1) 
-	Engage with mentors to discuss different environment variables, their 
	dependencies, and the best approach for refactoring.
-	Finalize an implementation plan based on discussions.
-	Since I will be on summer vacation, I can start coding early and make progress 
	on the project.

----------

Coding Period: 
(June 2 - August 25) 
-	Identify the appropriate subsystem for each global variable and relocate it 
	into struct repository, struct repo_settings, or other suitable contexts.
-	Modify function signatures to pass the new contexts explicitly, replacing 
	reliance on global variables.
-	Pick subsystems and remove the macro 
	#define USE_THE_REPOSITORY_VARIABLE and thereby eliminating usage
	of the global variable ‘the_repository’.
-	Continuously submit patches for review and incorporate feedback from mentors
	and the community.  
-	I plan to write weekly blogs which will document what I did in the whole 
	week.

----------

Final Week: 
(August 25 - September 1) 
-	Write a detailed report on the entire project.  
-	Fix bugs if any.  
-	Reflect on the project, noting challenges faced and lessons learned.


Blogging:
---------

I have also set up a blogging page at [11]. While reading blogs from previous
GSoC contributors, I found them useful in understanding the challenges
they faced and how they approached their projects. Their experiences gave
me a better idea of what to expect and how to navigate the development
process. Inspired by this, I decided to start my own blog to document my
journey throughout GSoC. This will not only help me track my own progress but
also serve as a resource for future contributors who might work on similar
projects. I plan to share updates on my work, challenges encountered and
insights gained from discussions with mentors and the community.

Additionally, I hope my blog encourages more people to contribute to open
source by providing a transparent look into the development process. Writing
about my experience will also help me reflect on my work and improve my
ability to communicate technical ideas effectively.

I liked the format and structure of Chandra's blog, so I decided to use the
same template for my own blogging page.


Availability:
-------------

As a college student, I intend to utilise my summer breaks from May to July
to work on the project. After completing my University exams in April, I can
start working in May. I can dedicate 40 hours a week from May to July, while
in August after the classes commence, I can dedicate about 25 hours a week.

There are no exams or planned vacations throughout the coding period. Besides
this project, I have no commitments/vacations planned for the summer. I shall
keep my status posted to all the community members and maintain transparency
in the project.


Post-GSOC:
----------

Beyond contributing code, I strongly believe in giving back to the community
and helping others grow. Open source thrives on mentorship, knowledge sharing,
and long-term involvement, and I would love to continue contributing even
after GSoC ends.

I have always valued mentorship, both as a mentee and as someone who enjoys
guiding others. If given the opportunity, I would be more than happy to
mentor/co-mentor future GSoC contributors. By staying involved in the
community, whether through contributing, reviewing patches, or mentoring,
I hope to help sustain and expand the project’s reach. I look at GSoC as not 
just as a one-time contribution but as a step toward a longer-term relationship
with open source.

I will continue to be involved with Git even after GSoC by contributing patches,
reviewing code, and participating in discussions. My work on refactoring Git’s 
state aligns with long-term improvements to the codebase, and I plan to keep 
refining it beyond the program. I see GSoC as just the beginning of my journey
with Git.

Appreciation:
-------------

I appreciate the Git community for its excellent documentation, which made it 
much easier for me to understand Git in depth. The well-structured resources 
helped me navigate the codebase and gain a deeper understanding of how Git 
works internally.

Beyond the documentation, I am also grateful for how welcoming and supportive 
the community has been. Whether through discussions on the mailing list or 
feedback on my patches, the information and guidance I received made my 
experience even better.

Additionally, I read the blogs and proposals of Chandra, Jialuo, and Ghanashyam, 
which provided valuable insights into their journeys and helped me shape my 
own approach to contributing.

Thanks for reviewing this proposal.

References:
-----------

[1] https://github.com/sdslabs/beast/pull/374

[2] https://github.com/sdslabs/beast/tree/add-teams-with-hint

[3] https://github.com/sdslabs/playCTF/pull/177

[4] https://public-inbox.org/git/pull.1826.git.git.1730926082.gitgitgadget@gmail.com/

[5] https://public-inbox.org/git/20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im/

[6] https://public-inbox.org/git/20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im/

[7] https://public-inbox.org/git/pull.1829.git.1731653548549.gitgitgadget@gmail.com/#t

[8] https://public-inbox.org/git/cover.1733236936.git.karthik.188@gmail.com/

[9] https://public-inbox.org/git/cover.1724923648.git.ps@pks.im/

[10] https://public-inbox.org/git/cover.1718347699.git.ps@pks.im/

[11] https://ayu-ch.github.io
