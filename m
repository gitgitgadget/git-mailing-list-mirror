Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FC4DDAB
	for <git@vger.kernel.org>; Sat,  1 Nov 2025 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762024112; cv=none; b=Cqy5UIhGYi59PnE03h98GX40E6QEiOI3Ir6/5e0S+YfGabDvXZQ/YlMlHk2aL6qmIWdKBXYoMmUOlQBFpMv3b0EMkTqPuUnf0eLjlXy8T8YfJIHYpzT7Pf79kLmjkPMYstpPruoe35Fgv867U1Hm6xuXBH4umbxrMzidTdluhcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762024112; c=relaxed/simple;
	bh=0BZ+B81K4q7/0inTWVskzw9gl1EnkE5QKWZRniwVvl0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nnMJMqkWTUU0MlhK0l45Jn+uZ+V17G9Ciktyj6RcxQijpZm2sTllMLP4IKETYyaP+P5GbHAsjBapEw+CU3GyGc9Qw4t8ngCGgvgbKmIUEYE4BLg1X3aft2arniKP4wLlefMvUFhGJDfkEpVfNjNiJvm2vsFEsqWJXuKjMFxDvjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAiT+4xQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAiT+4xQ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4283be7df63so1673604f8f.1
        for <git@vger.kernel.org>; Sat, 01 Nov 2025 12:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762024109; x=1762628909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CF2Fd2C4rUgLqLiFNsq+NGvbDnEVXFzjKrbZ+VN7/2c=;
        b=nAiT+4xQZmfjycXMIbr8sA2UzS46Y5wNK2wdQoQg+tEn03tFL7JIPZ5mnCEtoK1ftZ
         4omeff/R0VZmIxAlTxbyltRZCoFL6ZuPDQdRnbmTFyPKm/91kkqAMB8AipA6hl33xuGy
         75jhbYSyUgt+xAmcbQLI7yVhYUuJUcQgakolr8ssBzu+TMoCRo153JO9QCA5cFXoWZkv
         gFoVBgSFAPQNfh46EZW6Lc0+YfbRB4+azOty/fDPWRI8CoXP7DUjxAwhlBcHA96aosyT
         fXrslMx/BE8a5NFwQaj3F4SRwsDGn3RyBdLix1QaaY6XFlbUm0+wXFqane5KCxvqv9We
         0ElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762024109; x=1762628909;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CF2Fd2C4rUgLqLiFNsq+NGvbDnEVXFzjKrbZ+VN7/2c=;
        b=dvQTR/lCe8rLK9ddvcmzKl4BlzV4UIa7jFjI9016q1hymib9IRWyoTwjN/lWcFGU2b
         /AXVQtnDIqtg7CXiJ/5J9jsMZLu/4VfBkD5eUDNAx3AzZI+26jf2G3PJqwdLxlyzjc3l
         GURPsdxFQ0+lBXTscbdgnKBnCDDmn/IpTFSVS/XsO5nI6R96+0vaJ7q0eZUWd1fyjz3/
         xEUTlYm/INT8YRlCSgLctEhIEYs15DBdoz5nUEpqRL1cf8svCfPCiV/LRzJnczepxzwU
         J5JxvzPt1itE0o5QC/QVMNuUUxxQwmh2WWMq2sl3bTZfq6binL+n1gRaiB5yvVDPm7LZ
         Ygqg==
X-Gm-Message-State: AOJu0Yy3iX0uWfyV+NOgc0Irk8YvkxH4omIs9JUkYT29wF/fw3IjMLL7
	b2Gj3a6O7ueUgmkwzbDfOhxTJTqQaHP21bzOsp1lMojPb1RlMln7PTMO
X-Gm-Gg: ASbGnctIY3v3Xocjdb6PiJ8TuF6cN1EC0o55TlfRRhgqPtFMXuS3P6zIAgEOOdNMhDU
	0RnjtbvAxqOZJVZLZk3jcBcddxJaX85LhapzSquylvqHQJ0IgXczGB1owGEXu43F3dLup/1NnXK
	C4g+Tot6XDHAFb/5fGiEuY1fITLqmUdTJdT7DzHTZYri8IZc4MJXKX93ve5hWK7vhtcS8yp+VcU
	7zx5BOgHx9BkAbhAxC1kSleM+Wal1UznWj0rozZi32jmndP/Ch+qVNqMGIYH2laC4MeHgzDzzmp
	FFPu0sWUPVnYRo7MTc9+fp4RS/X9Aol+i0Weeu1VMIalszFQEsf0x7Nk+bxBv2mpJAuo5pHjCpt
	Di8JpD1ehLu+dLU53Ugm3J23L8ASmjtdlVr3v7uBEq+L7qioWUexs0k5f+02gak6XZ0yd3VSBK0
	hiSvJoj2w=
X-Google-Smtp-Source: AGHT+IEheUzAX7qBFvUB/0sNsCZqPKwjiCtOo97OuEtY2gEw+Q8RjmnN9zEWqIOtRpeKoLGa3oylvg==
X-Received: by 2002:a05:6000:430d:b0:3ee:154e:4f9 with SMTP id ffacd0b85a97d-429bd67c44cmr7171716f8f.20.1762024108486;
        Sat, 01 Nov 2025 12:08:28 -0700 (PDT)
Received: from ubuntu ([105.112.227.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c44de707sm8475484f8f.14.2025.11.01.12.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 12:08:27 -0700 (PDT)
Date: Sat, 1 Nov 2025 19:08:24 +0000
From: Bello Caleb Olamide <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [Outreachy][Proposal v3]: =?utf-8?Q?Refact?=
 =?utf-8?Q?or_in_order_to_reduce_Git=E2=80=99s?= global state
Message-ID: <aQZaqG6t4F6XE0nt@ubuntu>
Reply-To: 20251030144934.9689-1-belkid98@gmail.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,
This is the third iteration on my proposal for the project
"Refactor in order to reduce Git’s global state" for the 2025 Outreachy
Internship program.

The change from v2 includes correction to the subject line to have the
correct encoding on the mailing list.

Personal Bio:
===========
Full Name: Bello Caleb Olamide
Email: belkid98@gmail.com
Personal Blog: https://cloobtech.hashnode.dev/
GitHub: https://github.com/cloobtech

About Me:
=========
I'm Bello Olamide. I am passionate about software engineering and
I love to figure out things. I like participating in tech
events such as hackathons but this will be my first open source experience
and I have relished the opportunity and experience so far.
I love being part of a community that strive to achieve a goal and one that
I found myself is a small albeit growing community that helps to guide and
mentor younger boys find their way into the tech ecosystem. I have developed
my coding skill via various sources including personal learning, freelancing,
collaboration with other developers and from the ALX Software Engineering
program.

Past Experience with Git:
===================
I have been a Git user for sometime now majorly for collaborating with other
developers, tracking version changes to files and during this contribution
stage, I have understood the ropes of how to send patches to Git.

Contributions to the Git Community:
==========================
I have been able to send some patches to the Git codebase with the guidance
and direction of community members.

Microproject:
=============
Link: https://lore.kernel.org/git/cover.1761217100.git.belkid98@gmail.com/
Branch: ob/gpg-interface-cleanup
Status: Merged to master
Commit ID: ce6d041635
Description: strbuf_split*() to split a string into multiple strbufs
is often a wrong API to use.
A few uses of it have been removed by simplifying the code.

Project Overview
================
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
========================
The project aims to identify repository scoped global variables in
`environment.c` and related files that can be moved to local scope within
`struct repository` and `struct repo-settings`, find an appropriate strategy
to move them to local scope and implement the changes. This architectural
improvement will make the codebase more maintainable and enable better
multi-repository handling in the future.

From a high level overview, environment.[ch] exposes some global
variables that reflect a per-repository state and examples of such include
git_work_tree_cfg, is_bare_repository_cfg, and core.* settings and functions
which also depend on `the_repository` such as have_git_dir(),
is_bare_repository().

Review of Previous Work and Refactor Stategies:
===============================================
After a brief study of some related work done on the project,
it is important to understand the purpose of the identified global variable
and how it is used across the code base, observing how it relates with other
subsystems and moving it to the `struct repository` or `struct
repo-settings` if its use is repository specific, or specify an appropriate
context based on its scopeand use this context in the accessor functions.
For example in [1], Patrick Steinhardt observes that `core.hooksPath`
is repository specific and is stored in the global variable `git_hooks_path`.
The variable is then moved into local scope in the repo-settings
struct and a new accessor function `repo_settings_get_hooks_path()` is written
and used to set the `hooks_path` of the repo specific struct which the path
subsystem reads from.

Similarly in [2], `core.sharedRepository` is tracked via the global variables
`the_shared_repository ` and `need_shared_repository`. These are then
moved into the repo-settings struct, with new accessors functions
written to modify them, and calls to the accessors in the path subsystem are
then modified to replace the old accessors which modify the global variables.

There were also cases where the functions were adapted to use exactly what it
needs down the call chain rather than writing new accessor functions.
An example is [3], where the global variable `the_hash_algo` is replaced with
an explicit parameter `const struct git_hash_algo *algo` in low-level
functions such as `static struct hashfile *hashfd_internal()` and the call
sites adapted to use r->hash_algo or the_repository->hash_algo in places where
the subsystem has not gotten rid of `the_repository`.
This is also a strategy that can be used to replace global variables


Completion of Previous Unfinished Works
---------------------------------------
There were also some pieces of work that were started but not finished which
I plan to finish.
1) [4] attempts to move the `git_attributes_file` global variable to the `struct repository`.
   However because the global variable is used by the attributes subsystem and
   a single repository can have more than one set of attributes, that is
   the work-tree attributes and the index attributes, placing the variable into
   a repository instance and passing it around in the call chain will not be
   appropriate. Also most of the functions in the attributes subsystem pass the
   `index_state` as a parameter and not the repository. This is because an index
   knows its repository but a repository only knows its primary index.
   Therefore each repository for an index will need to be known from the index.

   As Junio pointed out in the discussion on the thread:
   "As the attribute system is all about giving extra information on the
   paths that appear in the index and in the working tree, it may make
   sense for the API to go from the index state which is about the
   index and the working tree to access the attributes, rather than
   from the repository structure, which controls a lot wider concept
   and moving anything and everything there will easily and quickly
   make it a messy kitchen sink."

   So Given that the `index_state` struct has a repo member, we can move
   'git_attributes_file' into the repo struct but access it through the
   `index_state`. By doing that we know the index truly owns the attributes.

2) There is also `is_bare_repository_cfg` as seen in [5].
   I have only skimmed through the discussions and patches to understand why it
   was not finished.
   But I will do an in depth study to understand why it was not completed and what
   it takes to finish it.


Proposed Project Execution Timeline
===================================

1. Study Code Base To Identify Suitable Candidates (Now - December 8, 2025):
------------------------------------------------------------------------
- The first step will be familiarising myself with the code base to
   understand how these global variables in environment.c are initialised,
   used and how they interact with other subsystems.

2. Community Feedback Bonding ( December 9 - December 15, 2025):
------------------------------------------------------------
- Discuss environment variables with mentors and community members
- Understand best refactoring approach based on feedback from mentors

3. Review Existing Patch and Define Criteria (December 16 - January 9, 2026):
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

To buttress the above points from my brief study of previous work,
if the variable value is:
i. meant to be different for different repositories, it is a candidate to move,
   if not then it is left as is, like the case of `local_repo_env[]`.

ii. used during early startup, it cannot be moved blindly but will need
    a closer inspection and refactoring of the startup code as is the case with
    `have_git_dir()` noted by Patrick and Shejialuo in [7].

Its relationship with other subsystems is also a criteria to define
such as the case of `git_attributes_file mentioned` above

4. Implement Candidates and Submit PRs ( January 10 - February 28, 2026):
--------------------------------------------------------------------------
- With collaboration from mentors and the Git community, identify
  suitable candidates for relocation.
- Relocate them into `struct repository`, `struct repo-settings` and
  other appropriate contexts.
- Pass the repository parameter to accessor functions to replace the
  global dependence
- Write new accessor functions if necessary else pass context directly to
  functions.
- Modify accessor callers to reflect the new changes while ensuring
  all affected code paths works correctly
- Update tests and documentations
- Recursively submit patches for reviews, engaging in discussions and
  implement suggestions

5. Final Report on Project (February 29 - March 6)
--------------------------------
- Document final report in my blog with details on my experience
- Finalize any pending tasks or reviews on any submitted patch

Availability
============
I am currently not enrolled in any school or jobs, so I will be able to give
30 hours a week or more to make the project a success.

Blogging
=========
I have set up my blog where I will document my progress, insights,
challenges and experience weekly.

Post Outreachy
==============
The welcoming and patient atmosphere during this short contribution
period with the Git
community has made me want to keep getting involved with the
community. I am committed to
continuously contributing to Git and become a part of of the next set
of contributors
to champion the continuous development of Git.

Appreciation
============
To Junio and Christian, I really appreciate your guidance, patience
and direction while
reviewing and helping with my patches and to Usman for your inputs and to every
member of the Git community, I thank you all.

References
==========
[1]: https://public-inbox.org/git/20250207-b4-pks-path-drop-the-repository-v2-14-13cad3c11b8a@pks.im/#Z31config.c
[2]: https://public-inbox.org/git/20250206-b4-pks-path-drop-the-repository-v1-15-4e77f0313206@pks.im/
[3]: https://public-inbox.org/git/20250306-b4-pks-objects-without-the-repository-v2-1-f3465327be69@pks.im/#Z31csum-file.h
[4]: https://lore.kernel.org/git/20250309153321.254844-1-ayu.chandekar@gmail.com/
[5]: https://public-inbox.org/git/pull.1826.git.git.1730926082.gitgitgadget@gmail.com/
[6]: https://lore.kernel.org/git/d0e2042b3061320fac8a8fdf9043c6ab4dbed5a2.1752882401.git.ayu.chandekar@gmail.com/
[7]: https://lore.kernel.org/git/c82620a1f54ea6760bff204fd2b5fe5c2df1896c.1753804956.git.ayu.chandekar@gmail.com/
