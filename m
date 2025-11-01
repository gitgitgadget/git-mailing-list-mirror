Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A762FB99F
	for <git@vger.kernel.org>; Sat,  1 Nov 2025 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762024430; cv=none; b=NpgXkylQDyh7XXN3JVqIrUfUz0uINGSXo33DHkXQ5VRxxO6DNNH+UHZwiy5AHzDrV5AXQd+Sv74Z2xOPZRMMtYil7OwYbffVpufx09wMHKSG/OA5wByHEC9y/cK6PAgE/3TCsvD/9G9PHw8T+ncWwrxEZOSXpEntBbHnfNey5eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762024430; c=relaxed/simple;
	bh=26l7fxKKPj4jB7B20nGtUNNMpgUnb/1fKOPN0ghF0LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRoZOiV6K3/2vAFgK+5l8teZFAGXjBUluyc/A/jzm8+c5cvyFT7Jf/BsJNKICm6M3yaBsjrzY2EFNJHpyDRZ5JLUA6RXSwPgnY/yOqWel1U5vGsaxQ3VfctKr9iyr1kkQV+2sWGnOEl6Zn8N9dNKJ/7/EeMAE6L418UnLR9lQgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ul2QvmQo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ul2QvmQo"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27c369f8986so32807565ad.3
        for <git@vger.kernel.org>; Sat, 01 Nov 2025 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762024428; x=1762629228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9rkpNmMjo5edSU2tAXTNNH1rdNuJSQc97Ngc63Miik=;
        b=Ul2QvmQopkAMvoOB8izGRJBf5mI8b96ejrqR+jMVyE+KBKL22cDBoo+DbxjftVEFyM
         au+VYJDtQKIPOVEgUVbailenNTPJ5cgrm/laHl6JMTc5bvjGHtIytIaa0M4kSTri4UA/
         Bp6Cj1Nrk+BYVPSaGj2jtvZOALWVK4gRuY6PG4ZtZds+b/SJl1r5B/1GK2EYvB7gQRSW
         JPRb+xrS1eei710orBZxGB788NiIQOqg4sVpAdLZq7wuUNtMFE5ApA+GMj/UA1747owG
         FoXhP60VIZmGrcTlVL0F3jiM/kZvOvMoZRxSnj3tUj7G+xCFHS5Q67Z6xd0cravBjM4M
         DRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762024428; x=1762629228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9rkpNmMjo5edSU2tAXTNNH1rdNuJSQc97Ngc63Miik=;
        b=gFA38tcFpgzf+Y4zpVuF9WZWMIGD4TmHUDqpjLMxsgwo0NhL3ppmZeANCFbG/fd5KY
         JDvcXH+CelSVSlq+yWUY1THhDt64wB+oegDsaFci8ohV1/nBxXRygNnie0pOkGmLikuO
         GikmDIR9SmCiPK+ZOM/PvMjmTdXWyrjM2UXC8lr8fJTEXxD6GRyzh+qTjbaYnzbdKCiv
         gXFjlwdoNoSu75b8GtzyiGX6K5uByjX34KNTDaEXbv+DEASiN8yb7ho+QqWarFq0mH2H
         OWCYbBi+d4myLrhHdQsGzOH6h71midKMx0lWFO9nyTJYlh8wUSjJTBA1ESjKDSuNaCb8
         rG+Q==
X-Gm-Message-State: AOJu0YwQN7hW+qNWKBQ1wcyx1UJe9SW2pzB6EALoN3gsBMFIhBH0EVja
	SsvFKBzGffAxkUVtv+eBuybYfM7/ZQctyexGyZhi8wbygHIp6bDTvjt34DGF0HA8ZW1fsYSyfvC
	Q/Pb3EIz77PwTyiXJeRayIaa46wz7oR9bkELu
X-Gm-Gg: ASbGnctEuqWrsAzIMl+yrOqNtpBJa+Q96oIMRJsXB7SpA0FtXXBw4C2J8tmbXnOFgG1
	mI6akDh40WhH5slXooicqu9gwhuBriyBYZMBi1UCb7sOqiMhevygBx1V2q8mPs9uU+RUh0nZ3XM
	M5kM/kLdu8DiLgrIu8BZGlNBFQ/6f0COvzjYLVg/yRq+81j6hSIyl7VaNzv9q1hR/LDwLcwMfy8
	kwEstxkebWiJlYaU/CHtikC3guHI6Tt05Lm5Na08SXI2s1vlUjhIVLhOOgmP8hPg3F6oizjUgM8
	VQ==
X-Google-Smtp-Source: AGHT+IEGMXQA+w8+jrgTo8CLbFwFsovjXL+Lj58tht/F1fXDLHg6c05cF5vn9A4uIHpDwgLrE4h5XBbDZ/HH2DmsbC0=
X-Received: by 2002:a17:902:db0e:b0:295:6c26:9348 with SMTP id
 d9443c01a7336-2956c2696d4mr24543385ad.59.1762024427614; Sat, 01 Nov 2025
 12:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=f0L9anYu4LKWGDKrwzBBytMunJ3UjTehNN9m2DigG8yCNHA@mail.gmail.com>
 <20251030144934.9689-1-belkid98@gmail.com>
In-Reply-To: <20251030144934.9689-1-belkid98@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Sat, 1 Nov 2025 20:13:49 +0100
X-Gm-Features: AWmQ_bn_-aERcOfi6flHe2WK2TvIsLlldxJ963BdTHdrgQG-qOiivoVvU80vqWQ
Message-ID: <CAD=f0L_dkfFam8fL24GV6r_yiVVARpMC_DH5Bem_yPeri1y7aA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BOutreachy=5D=5BProposal_v2=5D=3A_Refactor_in_order_to_r?=
	=?UTF-8?Q?educe_Git=E2=80=99s_global_state?=
To: git@vger.kernel.org
Cc: christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Oct 2025 at 15:49, Olamide Caleb Bello <belkid98@gmail.com> wrot=
e:
>
> Hello,
> This is the second iteration on my proposal for the project
> "Refactor in order to reduce Git=E2=80=99s global state" for the 2025 Out=
reachy
> Internship program.
>
> The changes from v1 includes answers to questions from Christian on other
> refactoring strategies used asides writing new accessors, unfinished prev=
ious
> works and the roadblocks encountered.
>
> Personal Bio:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Full Name: Bello Caleb Olamide
> Email: belkid98@gmail.com
> Personal Blog: https://cloobtech.hashnode.dev/
> GitHub: https://github.com/cloobtech
>
> About Me:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> I'm Bello Olamide. I am passionate about software engineering and
> I love to figure out things. I like participating in tech
> events such as hackathons but this will be my first open source experienc=
e
> and I have relished the opportunity and experience so far.
> I love being part of a community that strive to achieve a goal and one th=
at
> I found myself is a small albeit growing community that helps to guide an=
d
> mentor younger boys find their way into the tech ecosystem. I have develo=
ped
> my coding skill via various sources including personal learning, freelanc=
ing,
> collaboration with other developers and from the ALX Software Engineering
> program.
>
> Past Experience with Git:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I have been a Git user for sometime now majorly for collaborating with ot=
her
> developers, tracking version changes to files and during this contributio=
n
> stage, I have understood the ropes of how to send patches to Git.
>
> Contributions to the Git Community:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> I have been able to send some patches to the Git codebase with the guidan=
ce
> and direction of community members.
>
> Microproject:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Link: https://lore.kernel.org/git/cover.1761217100.git.belkid98@gmail.com=
/
> Branch: ob/gpg-interface-cleanup
> Status: Merged to next
> Commit ID: ce6d041635
> Description: strbuf_split*() to split a string into multiple strbufs
> is often a wrong API to use.
> A few uses of it have been removed by simplifying the code.
>
> Project Overview
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Git uses a single global `struct repository` object called `the_repositor=
y`
> which internal functions rely on to store, access and modify environment
> and configuration variables.
> With this approach, multi-repository instances running in the same proces=
s
> can lead to inconsistent behaviours and race conditions.
> By refactoring the code to stop storing repository-scoped
> configurations in global variables in
> `environment.c file`, that is by moving the appropriate global
> variables into localised state
> within the `struct repository` and `struct repo-settings`, the
> codebase becomes more maintainable,
> easier to test and future work such as libifying Git becomes feasible.
>
> Internship Objectives and Plans
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The project aims to identify repository scoped global variables in
> `environment.c` and related files that can be moved to local scope within
> `structrepository` and `struct repo-settings`, find an appropriate strate=
gy
> to move them to local scope and implement the changes. This architectural
> improvement will make the codebase more maintainable and enable better
> multi-repository handling in the future.
>
> From a high level overview, environment.[ch] exposes some global
> variables that reflect a per-repository state and examples of such includ=
e
> git_work_tree_cfg, is_bare_repository_cfg, and core.* settings and functi=
ons
> which also depend on `the_repository` such as have_git_dir(),
> is_bare_repository().
>
> Review of Previous Work and Refactor Stategies:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> After a brief study of some related work done on the project,
> it is important to understand the purpose of the identified global variab=
le
> and how it is used across the code base, observing how it relates with ot=
her
> subsystems and moving it to the `struct repository` or `struct
> repo-settings` if its use is repository specific, or specify an appropria=
te
> context based on its scopeand use this context in the accessor functions.
> For example in [1], Patrick Steinhardt observes that `core.hooksPath`
> is repository specific and is stored in the global variable `git_hooks_pa=
th`.
> The variable is then moved into local scope in the repo-settings
> struct and a new accessor function `repo_settings_get_hooks_path()` is wr=
itten
> and used to set the `hooks_path` of the repo specific struct which the pa=
th
> subsystem reads from.
>
> Similarly in [2], `core.sharedRepository` is tracked via the global varia=
bles
> `the_shared_repository ` and `need_shared_repository`. These are then
> moved into the repo-settings struct, with new accessors functions
> written to modify them, and calls to the accessors in the path subsystem =
are
> then modified to replace the old accessors which modify the global variab=
les.
>
> There were also cases where the functions were adapted to use exactly wha=
t it
> needs down the call chain rather than writing new accessor functions.
> An example is [3], where the global variable `the_hash_algo` is replaced =
with
> an explicit parameter `const struct git_hash_algo *algo` in low-level
> functions such as `static struct hashfile *hashfd_internal()` and the cal=
l
> sites adapted to use r->hash_algo or the_repository->hash_algo in places =
where
> the subsystem has not gotten rid of `the_repository`.
> This is also a strategy that can be used to replace global variables
>
>
> Completion of Previous Unfinished Works
> ---------------------------------------
> There were also some pieces of work that were started but not finished wh=
ich
> I plan to finish.
> * As an example, in [4], which attempts to move the `git_attributes_file`
>    global variable to the `struct repository`.
>    However because the global variable is used by the attributes subsyste=
m and
>    a single repository can have more than one set of attributes, that is
>    the work-tree attributes and the index attributes, placing the variabl=
e into
>    a repository instance and passing it around in the call chain will not=
 be
>    appropriate. Also most of the functions in the attributes subsystem pa=
ss the
>    `index_state` as a parameter and not the repository. This is because a=
n index
>    knows its repository but a repository only knows its primary index.
>    Therefore each repository for an index will need to be known from the =
index.
>
>    As Junio pointed out in the discussion on the thread:
>    "As the attribute system is all about giving extra information on the
>    paths that appear in the index and in the working tree, it may make
>    sense for the API to go from the index state which is about the
>    index and the working tree to access the attributes, rather than
>    from the repository structure, which controls a lot wider concept
>    and moving anything and everything there will easily and quickly
>    make it a messy kitchen sink."
>
>    So Given that the `index_state` struct has a repo member, we can move
>    'git_attributes_file' into the repo struct but access it through the
>    `index_state`. By doing that we know the index truly owns the attribut=
es.
>
> *  There is also `is_bare_repository_cfg` as seen in [5].
>    I have only skimmed through the discussions and patches to understand =
why it
>    was not finished.
>    But I will do an in depth study to understand why it was not completed=
 and what
>    it takes to finish it.
>
>
> Proposed Project Execution Timeline
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 1. Study Code Base To Identify Suitable Candidates (Now - December 8, 202=
5):
> ------------------------------------------------------------------------
> - The first step will be familiarising myself with the code base to
>    understand how these global variables in environment.c are initialised=
,
>    used and how they interact with other subsystems.
>
> 2. Community Feedback Bonding ( December 9 - December 15, 2025):
> ------------------------------------------------------------
> - Discuss environment variables with mentors and community members
> - Understand best refactoring approach based on feedback from mentors
>
> 3. Review Existing Patch and Define Criteria (December 16 - January 9, 20=
26):
> -------------------------------------------------------------
> - Thoroughly examine the existing patch series submitted to the mailing
>     list  to understand;
>     * What criteria makes a global variable a suitable candidate to be
>        moved to the `struct repository` or `struct repo-settings`
>     * What appropriate context it should be moved into based on its
>        interactions with other subsystems.
>     * If remaining a global variable is the best approach in its case.
> - This information can be gotten by paying attention to the discussions
>   in the patches and also engaging with my mentors and the Git community.
>
> To buttress the above points from my brief study of previous work,
> if the variable value is:
> i. meant to be different for different repositories, it is a candidate to=
 move,
>    if not then it is left as is, like the case of `local_repo_env[]`.
>
> ii. used during early startup, it cannot be moved blindly but will need
>     a closer inspection and refactoring of the startup code as is the cas=
e with
>     `have_git_dir()` noted by Patrick and Shejialuo in [7].
>
> Its relationship with other subsystems is also a criteria to define
> such as the case of `git_attributes_file mentioned` above
>
> 4. Implement Candidates and Submit PRs ( January 10 - February 28, 2026):
> -------------------------------------------------------------------------=
-
> - With collaboration from mentors and the Git community, identify
>   suitable candidates for relocation.
> - Relocate them into `struct repository`, `struct repo-settings` and
>   other appropriate contexts.
> - Pass the repository parameter to accessor functions to replace the
>   global dependence
> - Write new accessor functions if necessary else pass context directly to
>   functions.
> - Modify accessor callers to reflect the new changes while ensuring
>   all affected code paths works correctly
> - Update tests and documentations
> - Recursively submit patches for reviews, engaging in discussions and
>   implement suggestions
>
> 5. Final Report on Project (February 29 - March 6)
> --------------------------------
> - Document final report in my blog with details on my experience
> - Finalize any pending tasks or reviews on any submitted patch
>
> Availability
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I am currently not enrolled in any school or jobs, so I will be able to g=
ive
> 30 hours a week or more to make the project a success.
>
> Blogging
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> I have set up my blog where I will document my progress, insights,
> challenges and experience weekly.
>
> Post Outreachy
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The welcoming and patient atmosphere during this short contribution
> period with the Git
> community has made me want to keep getting involved with the
> community. I am committed to
> continuously contributing to Git and become a part of of the next set
> of contributors
> to champion the continuous development of Git.
>
> Appreciation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> To Junio and Christian, I really appreciate your guidance, patience
> and direction while
> reviewing and helping with my patches and to Usman for your inputs and to=
 every
> member of the Git community, I thank you all.
>
>
> References
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [1]: https://public-inbox.org/git/20250207-b4-pks-path-drop-the-repositor=
y-v2-14-13cad3c11b8a@pks.im/#Z31config.c
> [2]: https://public-inbox.org/git/20250206-b4-pks-path-drop-the-repositor=
y-v1-15-4e77f0313206@pks.im/
> [3]: https://public-inbox.org/git/20250306-b4-pks-objects-without-the-rep=
ository-v2-1-f3465327be69@pks.im/#Z31csum-file.h
> [4]: https://lore.kernel.org/git/20250309153321.254844-1-ayu.chandekar@gm=
ail.com/
> [5]: https://public-inbox.org/git/pull.1826.git.git.1730926082.gitgitgadg=
et@gmail.com/
> [6]: https://lore.kernel.org/git/d0e2042b3061320fac8a8fdf9043c6ab4dbed5a2=
.1752882401.git.ayu.chandekar@gmail.com/
> [7]: https://lore.kernel.org/git/c82620a1f54ea6760bff204fd2b5fe5c2df1896c=
.1753804956.git.ayu.chandekar@gmail.com/

Hello Christian
Please kindly refer to v3.
I noticed the subject did not have the correct format on the mailing list.
Something went wrong when I was used git send-email

Thanks
