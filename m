Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BA413D52E
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 05:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742966794; cv=none; b=LKSVHLMeJDcvA9x0fLr0tB3Nmi+7VK4T9SOiEsZy1eRGsx6eBaCEsn8ALbmq5TSrGsTCCNGslILvRwJZgjnXEWtxDQZefxQWnjkdI8EbWfhoSbJ7mjo3Uzh8l8a9z36iFZzWGVBqihdYQoMvhPBN4u6YGAQ2PWetTurGiN7MSyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742966794; c=relaxed/simple;
	bh=2T8hiSbSIPMLZ5teWwcSYQfszhnA2PIGAjw59QBA8CA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U+9/A6E+9fjKib1R2oRk/RYwliB36fViB7bqqn1U1I+hXWD09mrI4JGyLmkvxomeHpQ7YZeM4KJMHM69favUxBB6N5iwYUoFk682v2eMu3PFfeca7RZfP7BZOg/POTX46J0RZw28FsMWzg8sCvh46Y/RQeSsqBH4pBwCgO9dqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaCHjYVN; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaCHjYVN"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso10907954a91.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 22:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742966791; x=1743571591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SjPgbHYADXjSf3glrRDn22OBXOTHeZCLJzdqsqChb6E=;
        b=ZaCHjYVNIA1PdEr/2+P/kYn9CXk9xLy5M4qJ33sOfuPQk29sOJPItsJVh+mDJ8pKcz
         5xGn29G94GaDX7F818buMOtuGm2SxPz0i3S8QxPsHH7D4EBXUlSmO9oygsne5kCyvDjL
         zuyI78uuofBpnEYp2QW8sYHBt+wDwnFtgG3w3ljOOu/1tLP+z6zkY16OQayJq1GEkGOO
         PqfZqGG3rBQ9Bf7cMv6BHKhTcVWxiooC7QawPo++26Mc6PPxioQnz55nU/nsnxnghmQe
         IzrFZUnPpQIZ5hltsh4Rw2G1m4N0uMtUS49hRP75SEN0BgW3mhODq+avvXsd/9pYyufb
         csIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742966791; x=1743571591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjPgbHYADXjSf3glrRDn22OBXOTHeZCLJzdqsqChb6E=;
        b=HzWR8wst6RdYZ6Cona1oyIpFL9gZZ97Er5HeuQFZkGAi8VYqbN2U+VAP24Kn3BYOYg
         7Dyq3ZTp0bZiJfGCqkxlO4VbEioksiGgsCXaixpYE1o9iNzC3LpcZQc822jXP3VWObuh
         rpzgNNRo3IqWZpTfNr/2AWoWTgXRmNkF+7S5QZY+zjt8AnQmhwybJOd/IJJwYPlT0IkC
         Pm58Ws52HP4iXC6kspsaHUBS2ksbmd9FmQcD2iUN7QAmzdEo4zlWb6ROvM2nqQGVkFQ5
         n6m9uWXM8nctliLYYiEmqB/6A9gRQKe9yiUISV+iE5ikLfDXjFixV84BjA6vsYNIP2ha
         JjCw==
X-Gm-Message-State: AOJu0YzvKg4p5UPml0F5/7oY33sy+mlvEeDsTP3Ce6i0blj2GDkv3BB5
	DS/URvDPjtGXyKq1IZD+eq7BrD557gf/jFVCS8tdCi+IQQYsHSOXOAFjo1vodbE=
X-Gm-Gg: ASbGncvEF1kMSGyWVHiGm96HR/htWWyaj1NMEuCeBtWuWQK+9UHMW+LgppL5qtUjm/e
	QzKAR1FdcLuTwU9UqikFqRPc115CSgnp7VKGTH6fJitQlWJZAmKeFJmbw+tP+E+v3Y7p1VVJA48
	XDBFo9n+83DUmd2taprNzT8fPEcvZg8CDnK/uuvaE0bGHTbTV9U7SZctGsSNSxXtA5l9kQouZWf
	VSzwfU8fxhsHLJTxfO4+YdBhsWNZZ79/h/dbAihj7ejoWE7DnU1qVL/Gt8CESci4BiWwalfd/lo
	6IsJJlEtTyqBCdhO0lb9jnIbvA3yE7nsfei6jizh4+Y8XZh6a+V53sfOPcfdBw==
X-Google-Smtp-Source: AGHT+IH6a1VgQe/cF/qRQyG3j2BnryqFTeU4GuGgdNGdlMvkefIwV9sKovBt26VFSKAZAn7e1tv26g==
X-Received: by 2002:a17:90b:4c52:b0:2f6:f32e:90ac with SMTP id 98e67ed59e1d1-3030fe8647cmr33492179a91.11.1742966790481;
        Tue, 25 Mar 2025 22:26:30 -0700 (PDT)
Received: from bl4ze-rig.iitr.ac.in ([103.37.201.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f5d7fc6sm11349491a91.20.2025.03.25.22.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 22:26:30 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com
Subject: =?UTF-8?q?=5BGSOC=5D=20=5BPROPOSAL=20V1=5D=3A=20Refactoring=20in=20order=20to=20reduce=20Git=E2=80=99s=20global=20state?=
Date: Wed, 26 Mar 2025 10:56:00 +0530
Message-ID: <20250326052602.265989-1-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.48.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,
This is my GSoC 2025 proposal for the project "Refactoring in order to reduce Git’s global state".
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

This project aims to refactor Git’s environment handling by relocating
these global variables into appropriate local contexts primarily into
`struct repository` and `struct repo_settings`. This change will not
only make the environment state repository-specific, but also improve the
modularity and maintainability of the codebase. The work involves identifying
environment-related global variables, designing a suitable structure to
house them within the repository context, and updating all affected code
paths accordingly.

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
to understand the reasoning behind previous changes. To better prepare
for the GSoC timeline, I also submitted a patch related to the project,
gaining hands-on experience with both the implementation details and the
submission process.


Patches:
--------

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


Proposed Plan:
--------------

I have been reviewing global variables across the codebase to understand their
dependencies and impact. To do this, I examined `config.c` and cross-referenced
it with `environment.c` to see how these variables are currently managed. The
goal of this project is to eliminate global variables by moving their
configurations into repository-specific settings. This involves:

-   Identifying all occurrences of these global variables.

-   Removing dependencies on `the_repository`.

-   Updating function signatures to pass `struct repository` explicitly.

-   Replacing global variable references with repository-scoped configurations.

Instead of adding all variables directly into `repo_settings`, we can group
related variables into specialized structs (e.g., `performance_config`,
`behaviour_config`, `whitespace_config`) and embed these within `repo_settings`.
This approach ensures a more modular and maintainable design while keeping 
`repo_settings` manageable.

I have also created a diagram explaining this structure in [10].

With this approach, I can structure the patch series by grouping the refactoring 
of related variables within specific structs. This will help maintain a clean and
organized codebase while also making the development and review process more 
systematic and efficient.

One key challenge is determining which variables should be part of
`repo_settings` and which should remain separate. While working on the patch to
refactor access to `core.attributesfile`, I received feedback from Junio that not
all global variables should be blindly moved into the `repo_settings` struct.
This reinforced the need to carefully assess which variables belong in `repo_settings`
and which should be handled differently.

This plan is flexible and may be refined through multiple iterations as I receive
feedback from the community and reviewers.

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
-	Refactor global variables, replacing them with repository-scoped 
	configurations.  
-	Modify function signatures to pass `struct repository` explicitly instead
	of relying on `the_repository`.
-	Categorize variables into specialized structs to improve modularity and
	maintainability.  
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

[10] https://www.mermaidchart.com/raw/327324ea-af1d-4a98-8bff-254479b3a79c?theme=light&version=v0.1&format=svg

[11] https://ayu-ch.github.io
