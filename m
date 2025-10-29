Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8E2DA751
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700735; cv=none; b=Qx9Ftqf7L8hRcD/IgBEpONdhLVmqHwHd8mhdIKp7Ak4Xy2Uvt1N5oOGlkdlvg91q4VoCiK/AVAdmCuMqOoLLS2GJA9i3atzKuSB3dO5SdYWSMfaxwvWetxM39dtIrj0MXeFo/7JyO3Y7WQvTygnv0cLORaVOIMtL2QtaA3STLjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700735; c=relaxed/simple;
	bh=tN3tgVn6KKTEXR6P7rG14o5loR1W/htGFECVUPO0AYQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KGBJ8XqCpJSUDXOONyJjN3vp3OXMrv+p2K2Xe0ga5VlF0UsQfnvkrkMu12rAgQpTgXIaETKtkhC/Oc0axrP4CSb3WJg6xYTHb4piwOPC5obk+5h4AUBjZBJUr+8YDM8iX/1GJxpyzUIt6UygbC7RuvHTx0AkgnvYTa0JGisZo7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m31uvbD9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m31uvbD9"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b593def09e3so4046409a12.2
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 18:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761700733; x=1762305533; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ0dkE57CzXrtY7YG1hMrab0ErgUeITbZ0Wp+cE4SHU=;
        b=m31uvbD9nbOMycIq2rELib5IBv0fff0v6id3r36GVw/CpRmZDBYEMnSuT9y/KUwwQ5
         LQz0kf6jaVoeGRTyeqi3YahKz60qJUJGv3xhLWpU25p1HO4UL4Qd0oWC6udITUu2TiXn
         9kWVLldsv/6LKlIFpuLOVcT1AMjpfHYR9ZT/k+tgetd7qBfWJi3NWiZjUIOQqtg4tdKr
         SwKRh2qIfj1MRAcxL6MfvrNjCgA/WROaOTlxmqcxNBfL2Z/9xv3UMD/J4pPLYLIww1Qp
         +omB0hGHmTw55sDtuGemr9kkr9rVFP9eH2JapGSGIvPxEvX5ywC98X2NVX5a2Xqplc5P
         jyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761700733; x=1762305533;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZ0dkE57CzXrtY7YG1hMrab0ErgUeITbZ0Wp+cE4SHU=;
        b=jJF+0taovvFAvKv9y1jp1cp+CYHhwbGYudygBez/AFsk/pR+etA8EQzCMrXuLeNT2c
         rSjR//0OQbqVurwksQVNjcSIVzUCV22SFpqaaOO5DkJhY6dRMzuM9N49KMZXjIk5/NZo
         /zFXkS/yOfBJj5YkIqIliXQ4TKQOOclns0kkNgN/pFcdLjCQJuVVG5VFf6+UZ0ldhi01
         JuhhYAY27FcOuUdVWv978rdgCEYXiCNtsy2OESbAKirEszBaFcHATBfwyxjaLknHwBno
         c4z3aYXdvjpLayKO48lysmZH4yKFFo3w86zeeSnH+hGMzASbohB354JPu2rs0e5MTIzn
         xo/A==
X-Gm-Message-State: AOJu0YxgPvD5NsCvZogtJ2yK9tZuOGUQuqQ5wDGQQVHZk49KT3qVLT3T
	3AeiYvqIo5OFBpajQvl9NZ2AoGQazRtnm+wamqZPdDyuGGESgX+Qa9KuiPGve9LbFtQmNNLvzLH
	l7fBdRnPYxnpeM9mAyQgbkr0j4lQZxZTyOqBy
X-Gm-Gg: ASbGncv3MnTCQCDG8ACW4QNUvo6LFk7ATp5gZv55Hf+jirBL2407rkoGcFMGjJdcc1H
	KHpSyc1sxf3YW7yRQhaKI71DR2YeWShqpvNoz2yD9S/zABOhAZEec1gW5tE0LP1pqa5nIn7MqB7
	QV9q8LAx2CfHZXC1hpSQiejXdED0lrCWIQO8M+zNhH1giDt55pNvePlnQdXXjxRzBZD+pr/JH0O
	sREqpGA7DKj6+MmR/egVgSRdMNJlyNSfOLT1VeBDadIUgCWJJAl5l/fl8UlLk5Q
X-Google-Smtp-Source: AGHT+IEArkj9zm6+tQOQk8XhDO9DmHkIGpIyQBj/s+ykm5LBFmxeBxAJTyNLWQNO9Z/wLT7Z3P5RtvhuaGn+N6d+jTk=
X-Received: by 2002:a17:903:1ca:b0:25c:46cd:1dc1 with SMTP id
 d9443c01a7336-294def2d884mr11429625ad.33.1761700732615; Tue, 28 Oct 2025
 18:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bello Olamide <belkid98@gmail.com>
Date: Wed, 29 Oct 2025 02:18:53 +0100
X-Gm-Features: AWmQ_bkau6sSmA7DrQlacu7VMzx2kF-QCkU_Bf5HWno-4Doudfah_7T24rBTuW8
Message-ID: <CAD=f0L9anYu4LKWGDKrwzBBytMunJ3UjTehNN9m2DigG8yCNHA@mail.gmail.com>
Subject: =?UTF-8?Q?=5BOutreachy=5D=5BProposal=5D=3A_Refactor_in_order_to_reduce_G?=
	=?UTF-8?Q?it=E2=80=99s_global_state?=
To: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Christain Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
This is my proposal for the project
"Refactor in order to reduce Git=E2=80=99s global state" for the 2025 Outre=
achy
Internship program.

Personal Bio:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Full Name: Bello Caleb Olamide
Email: belkid98@gmail.com
Personal Blog: https://cloobtech.hashnode.dev/
GitHub: https://github.com/cloobtech

About Me:
=3D=3D=3D=3D=3D=3D=3D=3D=3D
I'm Bello Olamide. I am passionate about software engineering and
I love to figure out things. I like participating in tech
events such as hackathons but this will be my first open source experience
and I have relished the opportunity and experience so far.
I love being part of a community that strive to achieve a goal and one that
I found myself is a small albeit growing community that helps to guide and
mentor younger boys find their way into the tech ecosystem. I have develope=
d
my coding skill via various sources including personal learning, freelancin=
g,
collaboration with other developers and from the ALX Software Engineering
program.

Past Experience with Git:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I have been a Git user for sometime now majorly for collaborating with othe=
r
developers, tracking version changes to files and during this contribution
stage, I have understood the ropes of how to send patches to Git.

Contributions to the Git Community:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
I have been able to send some patches to the Git codebase with the guidance
and direction of community members.

Microproject:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Link: https://lore.kernel.org/git/cover.1761217100.git.belkid98@gmail.com/
Branch: ob/gpg-interface-cleanup
Status: Merged to next
Commit ID: ce6d041635
Description: strbuf_split*() to split a string into multiple strbufs
is often a wrong API to use.
A few uses of it have been removed by simplifying the code.

Project Overview
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Git uses a single global `struct repository` object called `the_repository`
which internal functions rely on to store, access and modify environment
and configuration variables.
With this approach, multi-repository instances running in the same process
can lead to inconsistent behaviours and race conditions.
By refactoring the code to stop storing repository-scoped
configurations in global variables in
`environment.c file`, that is by moving the appropriate global
variables into localised state
within the `struct repository` and `struct repo-settings`, the
codebase becomes more maintainable,
easier to test and future work such as libifying Git becomes feasible.

Internship Objectives and Plans
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The project aims to identify repository scoped global variables in
`environment.c`
and related files that can be moved to local scope within `struct
repository` and
`struct repo-settings`, find an appropriate strategy to move them to
local scope and implement the changes. This architectural improvement
will make the
codebase more maintainable and enable better multi-repository handling
in the future.

From a high level overview, environment.[ch] exposes some global
variables that reflect a per-repository state and examples of such include
git_work_tree_cfg, is_bare_repository_cfg, and core.* settings and function=
s
which also depend on `the_repository` such as have_git_dir(),
is_bare_repository().
After a brief study of some related work done on the project,
it is important to understand the purpose of the identified global variable
and how it is used across the code base, observing how it relates with othe=
r
subsystems and moving it to the `struct repository` or `struct
repo-settings` if its
use is repository specific, or specify an appropriate context based on its =
scope
and use this context in the accessor functions.
For example in [1], Patrick Steinhardt observes that `core.hooksPath`
is repository specific and is stored in the global variable `git_hooks_path=
`.
The variable is then moved into local scope in the repo-settings
struct and a new
accessor function `repo_settings_get_hooks_path()` is written and used to
set the `hooks_path` of the repo specific struct which the path subsystem
reads from.
Similarly in [2], `core.sharedRepository` is tracked via the global variabl=
es
`the_shared_repository ` and `need_shared_repository`. These are then
moved into the repo-settings struct, with new accessors functions
written to modify them,
and calls to the accessors in the path subsystem are then modified to
replace the old
accessors which modify the global variables.

I also studied [3], [4] by Ayush Chandeker,] and [5] by John Cai to broaden=
 my
understanding of the project.

Proposed Project Execution Timeline
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. Study Code Base To Identify Suitable Candidates (Now - December 8, 2025)=
:
------------------------------------------------------------------------
- The first step will be familiarising myself with the code base to
   understand how these global variables in environment.c are initialised,
   used and how they interact with other subsystems.

2. Community Feedback Bonding ( December 9 - December 15, 2025):
------------------------------------------------------------
- Discuss environment variables with mentors and community members
- Understand best refactoring approach based on feedback from mentors

3. Review Existing Patch and Define Criteria (December 16 - January 9, 2026=
):
-------------------------------------------------------------
- Thoroughly examine the existing patch series submitted to the mailing
    list  to understand;
    * What criteria makes a global variable a suitable candidate to be
       moved to the `struct repository` or `struct repo-settings`
    * What appropriate context it should be moved into based on its
       interactions with other subsystems.
    * If remaining a global variable is the best approach in its case.
- This information can be gotten by paying attention to the discussions
in the patches and also engaging with my mentors and the Git community.

4. Implement Candidates and Submit PRs ( January 10 - February 28, 2026):
--------------------------------------------------------------------------
- With collaboration from mentors and the Git community, identify
suitable candidates for relocation.
- Relocate them into `struct repository`, `struct repo-settings` and
other appropriate
contexts.
- Pass the repository parameter to accessor functions to replace the
global dependence
- Write new accessor functions if necessary
- Modify accessor callers to reflect the new changes while ensuring
all affected code paths works
  correctly
- Update tests and documentations
- Recursively submit patches for reviews, engaging in discussions and
implement suggestions

5. Final Report on Project (February 29 - March 6)
--------------------------------
- Document final report in my blog with details on my experience
- Finalize any pending tasks or reviews on any submitted patch

Availability
=3D=3D=3D=3D=3D=3D=3D=3D
I am currently not enrolled in any school or jobs, so I will be able to giv=
e
30 hours a week or more to make the project a success.

Blogging
=3D=3D=3D=3D=3D=3D=3D
I have set up my blog where i will document my progress, insights,
challenges and experience weekly.

Post Outreachy
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The welcoming and patient atmosphere during this short contribution
period with the Git
community has made me want to keep getting involved with the
community. I am committed to
continuously contributing to Git and become a part of of the next set
of contributors
to champion the continuous development of Git.

Appreciation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
To Junio and Christian, I really appreciate your guidance, patience
and direction while
reviewing and helping with my patches and to Usman for your inputs and to e=
very
member of the Git community, I thank you all.

References
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[1]: https://public-inbox.org/git/20250207-b4-pks-path-drop-the-repository-=
v2-14-13cad3c11b8a@pks.im/#Z31config.c
[2]: https://public-inbox.org/git/20250206-b4-pks-path-drop-the-repository-=
v1-15-4e77f0313206@pks.im/
[3]: https://lore.kernel.org/git/d0e2042b3061320fac8a8fdf9043c6ab4dbed5a2.1=
752882401.git.ayu.chandekar@gmail.com/
[4]: https://lore.kernel.org/git/c82620a1f54ea6760bff204fd2b5fe5c2df1896c.1=
753804956.git.ayu.chandekar@gmail.com/
[5]: https://public-inbox.org/git/pull.1826.git.git.1730926082.gitgitgadget=
@gmail.com/
