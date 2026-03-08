Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2180037649D
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772991502; cv=none; b=XTL4SWsCjVda3wU5m6E8lIHOWxZMuroaejzihOtFa5vgfPBIqO9mFOW1rroZ2wmhiyxuHp5+XUQnn+rdLTdPb4EIWc1hsLGJYSQzGrGaeDtkd2fsMEI5SfR3/Jx4x7GnVyFP1u1F6y0J3r9zoUtq++t4Kt+BAOFIJPtAo6Pp/ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772991502; c=relaxed/simple;
	bh=Pr2kpw3yqbqurU80AFBu89b6CNFLTaF4lA8V3vyjzbs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=luH7MLlalEtlkYboE17HG8WoQNOQBFDjeCv4Q6muliMK1kd2KodDA0qtTsM3sa/tZYokBGYaFxukA3u4JoH3jYfSWIyItFd6DIRjV5XEJwSjFDUpIdX79mkPLM57DVFLkF7rD+Gp+XN7+4MGR3WDnhh66mLcrjKhRAU4e+qarHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kykkURzP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kykkURzP"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae471aabdaso3304325ad.3
        for <git@vger.kernel.org>; Sun, 08 Mar 2026 10:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772991500; x=1773596300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qyLI+0cbYSBWDHDnwQ7k+xQ01jvu26ZF+dmPrN6OV78=;
        b=kykkURzPRVW4y7SCvvxgkvu4EC8mzslWC3HQBNmKt9kxeLYZA3Y/BF/cB0eIut4VQB
         py4cDiAUupa7VhQExks61EM1+dE3Vz0bEFyrdgHK+vSSH5R9QqkQscPn8aOiTKWX0CSP
         f8ut73uM8kasDuuKYEAnF1ye21OY1QSoeF+WeHFV46lFNwnxwe7zHYgRkitzTqqm+O87
         wag2+BW8ha23Bc8At6QTyiSlCCSFgWoK6iW+PxWpU3bpuHonepM2MZH4Fp7oaisBrsIU
         BYxXVL3ZHJxjGcmzsHF2War4GzveJfZuRb8Vb/l19AH/zLbASAA2RRQ45fOEoCpG+m95
         pfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772991500; x=1773596300;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyLI+0cbYSBWDHDnwQ7k+xQ01jvu26ZF+dmPrN6OV78=;
        b=TpOlNOKedcm1AvQw91E4euDs/cNdyyc7y2BJNzXe1rfjd+X9EVo8qVp9y1CwivQXVH
         xmsZa/14kY+lkODclb3UEIkXriTCkeDVhKzWljxN7aHfQfCGNVes52lIe7Aby8TGk/5b
         8LY4yIu6ZWfTqcGWpAzN1j6bjyNauHMCpc/HoLJR6BkXecAVi3mMWc8EKtYuPgH+VrAq
         JTGJDhcNIGuDEhoJH+QA/+BQLrh+XMssP9DAjFxgGmHYoJx26pMy3IBl7jeiDYqu4Lbo
         s3bIGT8MXv9DSRAs3xU72oh/bIOcRgCFG0vBv3QfIeSMqWmpq3eFZvJD9QhPqR9bxL4B
         l+gw==
X-Gm-Message-State: AOJu0YwWs5Okgm5olw0ucqDQlgH9GKCw/NfitZ/JsOnQWSaEA7VxCz2w
	LJ+1PhrWd/LsZ6KfQ71LX+7oXetFjLmfneZQe2MwpU7Rjh33vxPkaR2lq55B3UKk
X-Gm-Gg: ATEYQzywzMWzxUnrSLGJEGEbFDv809lCkEhPemHq4E52S2hi1+vgUJTO14WZgawL6Ft
	TBokFWxPVckomlLoMmDwBR4DG+FvlGUi/zraOYb4Su9NSv8yV8zO/+05GSypMO/r8wDLGtkRGoh
	JJIgDoMHL40SjCx8wG4PvJBUv+NDYdrRcyZflGR6Uw3C1qxmFwD9KFPQZJ8nVJ0IBNUMUv4xZWh
	Ty6lMh4GHcbETp/YWVBtjtr+gdZGn2k3aJVCiijrPJgy6Eipb86PrwMsmRWJGL5ME+NGEh4hLMe
	gRyD40q2TF9vxiDOYG/kXsDGPk4F54c6ogO0QtigG757QfHeW7ibh6TjFfsgLEPEhTcs+UNMaWz
	Fhi9tkB/2Pw2oPhFqKIdSQZgSZU1DW/1GfhykB3wU0J7T7knO5pAr6ez+Z71Brv2u6WTxXuP8zI
	jkmTGHgk5G0rObiiAIque69yiJk6bwpZv+eTNU8iwlRHoOdBWa6lkAhojh7rwv1PRWrR0xJS544
	X5qtojHpAz+
X-Received: by 2002:a17:902:e5ca:b0:2a0:992c:1ddd with SMTP id d9443c01a7336-2ae824f8e6bmr59307785ad.8.1772991499811;
        Sun, 08 Mar 2026 10:38:19 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e5c167sm83210905ad.1.2026.03.08.10.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2026 10:38:19 -0700 (PDT)
Message-ID: <a71b334d-95e1-4645-9877-f4a892f5a30a@gmail.com>
Date: Mon, 9 Mar 2026 01:38:15 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC][Draft Proposal v7] Refactoring in order to reduce Git's
 global state
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>, phillip.wood@dunelm.org.uk
References: <ab45758c-fbcf-42b2-96df-030eef8526c3@gmail.com>
 <b98780d7-3aa9-4838-9234-290b1d72ffd7@gmail.com>
 <5e5f07ec-72ba-46ee-812c-d6773a4bdbe7@gmail.com>
 <0a944142-7c51-4143-af00-2a5798ea68af@gmail.com>
 <f19c95fd-756e-4890-b718-10ccf09c31fa@gmail.com>
Content-Language: en-US
In-Reply-To: <f19c95fd-756e-4890-b718-10ccf09c31fa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

Here is the V7 Draft. Looking forward to hearing your feedback (ゝ∀･)

Refactoring in order to reduce Git's global state
=================================================

PERSONAL INFORMATION
--------------------
Name: Tian Yuchen
E-mail: a3205153416@gmail.com
Phone number: +65 98740318
Time-zone: UTC + 08:00
Github: https://github.com/malon7782

Education: NTU, Singapore
Year: Year 1 semester 2
Degree: Electrical and Electronic Engineering (EEE)


PRE GSOC
--------
I have always held a deep passion for the open-source community. 
Although I'm not a computer science major, I tinkered with open-source 
projects long before college. I have solid hands-on experience in C 
programming and system-level debugging.

I use Ubuntu 24.04 on a daily basis, so I am proficient in using the 
Linux command line and CLI tools.

I have contributed to the Git community by sending patches. Since my 
first commit (17/1/2026), I have maintained a nearly daily contribution. 
Here is the list of contributions I have made:

* [PATCH v1] t1005: modernize "! test -f" to "test_path_is_missing"

https://lore.kernel.org/git/20260117062515.319664-1-a3205153416@gmail.com/
   This patch is my microproject, the first contribution I made to the 
codebase.
   [Graduated to 'master']

* [PATCH v2] t2203: avoid masking exit codes in git status

https://lore.kernel.org/git/20260118043537.338769-1-a3205153416@gmail.com/#t

* [PATCH v2] symlinks: use unsigned int for flags

https://lore.kernel.org/git/20260120152219.398999-1-a3205153416@gmail.com/
   [Merged to 'next']

* [PATCH v4] t/perf/p3400: speed up setup using fast-import

https://lore.kernel.org/git/20260130170123.642344-1-a3205153416@gmail.com/
   [Will merge to 'master']

* Re: [PATCH] [RFC] attr: use local repository state in read_attr

https://lore.kernel.org/git/cc2f400e-49c2-4de0-9c51-9a5c0294735e@gmail.com/
   Code review. To verify the performance loss, I wrote a test script to
   measure the time difference before and after the modification.

* Re: Bug: git add :!x . exits with error when x is in .gitignore

https://lore.kernel.org/git/1d560aa1-d452-47f5-aaf2-4cb1ccdab100@gmail.com/
   Code review. Pointed out logical error.

* [PATCH v11] setup: allow cwd/.git to be a symlink to a directory

https://lore.kernel.org/git/20260220164512.216901-1-a3205153416@gmail.com/
   [Under review]
   After over half a month of discussions, repeated refactoring, and code
   reviews, I delved deep into setup.c. I gained insights into Git's 
design philosophy, and learned the art of striking a balance in 
developer communication. It took me a large amount of time and effort to 
thoroughly understand every line of the code. Throughout this process, I 
meticulously examined portions of the call chain in setup.c, the timing 
of die() usage, expected lookup/error handling behavior, external 
callers, and ran several full CI tests. I managed to correct my initial 
assumptions and it taught me why die() cannot be casually bypassed in 
libification without rigorous error propagation, as well as how to 
handle cross-platform CI edge cases.

* [PATCH v4 0/3] move encoding configs to repo_config_values()

https://lore.kernel.org/git/20260228190201.3684705-1-a3205153416@gmail.com/
   [In progress]
   A practice patch for working according to the workflow described in 
this proposal.

* Re: [PATCH 4/4] repo: add the field path.toplevel

https://lore.kernel.org/git/e6e7e272-4aec-461e-aebd-33ec0a324770@gmail.com/
   Code review. Questioned unreasonable designs.

* Re: [PATCH] Refactor 'trust_executable_bit' to repository-scoped setting

https://lore.kernel.org/git/24f40e5a-a5fd-49ec-86e7-921b44e4abd9@gmail.com/
   Code review. Clarify lazy-loading and eager-loading. Pointed out 
problems with the patch.

* [PATCH] patch-ids: achieve const correctness in patch_id_neq()
   https://lore.kernel.org/git/xmqqseaasuph.fsf@gitster.g/T/#t
   [In progress]
   Discuss and modify the items marked NEEDSWORK in patch-ids.c

To date, developing diverse patches across various domains has been a 
thoroughly enjoyable experience for me. I relish exploring different 
fields while maintaining the discipline to delve deeply into them. I 
never settle for superficial patches.


ABOUT THE PROJECT
-----------------

-- Synopsis

As far as I know, the Git community is actively working towards 
'libification' (laid by Patrick Steinhardt's config/path refactoring, 
and Olamide Bello's recent introduction of repo_config_values) - making 
Git's internal machinery reusable as a C library. The extensive reliance 
on global state is a major roadblock to this goal.

Many core functions implicitly read environment variables and store them 
in global static variables. This can cause several issues:

   1. When Git is called multiple times within the same process, global 
states can lead to memory leaks or incorrect behaviors.

   2. Unit testing becomes difficult because the environment must be 
artificially manipulated before calling functions.

   3. Global variables prevent Git's core functions from being executed 
safely in multi-threaded contexts. For example, when encountering 
unexpected states (e.g., a permission denied error when probing a 
directory), core functions often rely on the global state to decide 
whether to call die(), which internally calls exit(). It’s fine for a 
standalone CLI tool, but for a linked C library used by a long-running 
multi-threaded server, a single die() call will kill the entire host 
process. Structured status, instead of fatal exits, should be returned.

Take a look at this example from environment.c:

     206 const char *get_commit_output_encoding(void)
     207 {
     208     return git_commit_encoding ? git_commit_encoding : "UTF-8";
     209 }

If Git is invoked as a C library by a multi-threaded server:
- Thread A formats a commit for Repo A (using GBK);
- Thread B concurrently formats a commit for Repo B (using UTF-8);

Then they will race to read and overwrite the exact same global
`git_commit_encoding` pointer, which is not what we expect. Therefore,
we have to refactor these environment variables by moving them from
global scope into a well-defined and encapsulated context.

-- Trade-off?

A naive approach to achieve this is blindly moving every global variable 
into struct repository. For the previous encoding case, this approach 
does not seem entirely unfeasible. However, it is easy to cite another 
example:

“What if some variables are accessed before setup_git_directory() 
successfully initializes the repo struct?”

For instance, early discovery flags like is_bare_repository_cfg are 
assigned during the .git directory probe, long before a struct 
repository object can be safely instantiated. We create a 
chicken-and-egg initialization paradox if we force these early-startup 
variables into repo_settings. How can a variable dictate the discovery 
of a repository if it lives inside the repository it is trying to discover?

I believe the key point to note for this case is the boundary between 
Repository State and Process/Startup State. Encapsulating it within the 
early-boot context might be a viable option... but more importantly, 
this example illustrates that eliminating global variables is never a 
matter of blindly “moving … to …” Instead, it requires careful, 
multifaceted consideration and a thorough weighing of the trade-offs.


-- Approach

Therefore, the task at hand goes beyond simply repackaging the global 
variables into the struct repository structure. Based on my recent 
experience refactoring setup.c, I realized that libification requires 
careful management of variable lifecycles and api boundaries:

     [ Current ]
     Core functions --------reads-------> Global variables (via getenv)
                                          [Thread unsafe]

     [ Target ]
     Core functions ----passes context--> struct repository
                                                 | owns
                                                 v
                                      struct repo_settings(lazy)

                                 struct repo_config_values (eager) [1]

                                      other domain-specific structs

Although the principle is simple, the scope of changes is extensive. The 
following insights can serve a guiding principles (but not the absolute 
rules to obey):

   1. Identify isolated environment variables currently residing in the
      global scope. Conduct a case-by-case analysis to map each variable
      to its most appropriate existing home based on their lifecycles:

         Variables that are only parsed when needed will be safely mapped
     to struct repo_settings.

         Variables parsed at startup (e.g., editor_program) must not be
     moved to lazily parsed structs to ensure that invalid
     configurations can trigger early failures before execution
     proceeds too far, which is also for the sake of user experience.
     (Phillip Wood points out that the struct repo_config_values
     can serve as a good home to these variables, though this
     approach remains in its early stages and has not yet been fully
     confirmed and implemented. [2])

   2. Instead of blindly passing struct repository *repo down into every
      single low-level library function, bubbling the dependency up is
      the true goal. External callers of the functions must be carefully
      audited to prevent regressions.

   3. Safely remove the old global variables and macro definitions. Make
      full use of Git's existing GitLab/GitHub CI and utilize local
      Meson builds with AddressSanitizer enabled to ensure that the new
      lifecycle introduces zero memory leaks. [3]


Additionally, given the anticipated high volume of commits, we must 
ensure each patch is independent and atomic [4], preventing any 
user-untraceable or unexplainable bugs from occurring in the codebase at 
any state.


AVAILABILITY
------------
Fortunately, my summer vacation perfectly coincides with the GSoC work 
period. I will treat this project as my primary focus, dedicating a 
minimum of 35 hours per week. If needed, I can work a 9-to-5 schedule.

I will have a significant head start to draft RFC patches before the
official coding period even begins. Having this buffer period allows me
to go through the rigorous code review process within the Git community
with greater ease.

I've always kept up the habit of blogging (though previously it was 
mostly literary essays and musings). For this GSoC project, I'll provide 
regular progress updates (every week or every other week). I'll also 
occasionally share technical insights.


TIMELINE & MILESTONES
---------------------
I believe that outlining a rigid, day-by-day schedule months in advance 
is unrealistic for a breathing codebase like Git. I will employ a 
pipeline-driven workflow:

   1. Small refactoring every 3-5 days, major refactoring every 2-3 
weeks, alternating between the two.
   2. After gathering sufficient, well-directed review suggestions, 
revisit and modify the previous refactoring.
   3. Ensure these patches do not depend on one another to prevent a 
domino effect.


Below is the tentative schedule I have prepared for myself:

* Community Bonding (May 1 - May 25): Planning & RFC
   - May 1 - May 7: Wrap up university finals. Discuss and finalize the
     prioritized list of subsystems with my mentor.
   - May 8 - May 25: Categorize the targeted global variables and map out
     their intended destinations (e.g., repo_settings vs 
repo_config_values). Draft and submit
     the initial RFC patch series.

* Phase 1 (May 26 - July 10): Foundation

   - Weeks 1-3: Target straightforward boolean flags and integer configs 
in environment.c (e.g., is_bare_repository_cfg). Plumb the context 
pointer, adapt callers, and dispatch the first 2-3 patch series.
   - Weeks 4-6: Process mailing list feedback and iterate (v2/v3). 
Concurrently begin migrating the next batch of variables. By the midterm 
evaluation, a steady rhythm of proposing, reviewing, and merging should 
be established.

* Phase 2 (July 11 - August 18): Complex Migration & Cleanup

   - Weeks 7-8: Shift focus to higher-complexity variables and string 
configurations (e.g., editor_program, comment_line_str). Apply the 
repo_config_values API where eager loading is strictly required.
   - Weeks 9-10: Finalize the remaining targeted globals. Conduct a 
global audit for any dangling macro definitions (like 
USE_THE_REPOSITORY_VARIABLE in fully refactored subsystems) and 
eliminate them.
   - Weeks 11-12: Update internal documentation 
(Documentation/technical/), ensure all patch series are either merged or 
in a stable state on the next branch, and write the final GSoC report.


~$ git checkout HEAD@{postGSoC}
-------------------------------
I plan to stay active in the community long after the summer ends — 
reviewing related patches, mentoring future newcomers, and seeing the 
libification effort through to the end.

This past month since joining the Git community has been the most 
enjoyable month of my programming journey. To quote a close friend of 
mine (who is applying for the Neovim GSoC project):

   "Only fools chase trends; open source is the game for the brave."

The words may be blunt, but the logic holds true. This statement surely 
resonates with me (and maybe many other GSoC contributors): our passion 
for code and open-source drives us forward.

Even if I didn't make the cut, so what? ~$ git reset --hard…

Jokes aside, diving into Git's codebase this past month has been 
immensely rewarding. Win or lose, I'm here to stay and help.


REFERENCE
-------------------------------
[1]

https://lore.kernel.org/all/48821a3848bef25c13038be8377ad73e7c17a924.1771258573.git.belkid98@gmail.com/

[2]

https://lore.kernel.org/git/CAP8UFD2Q7gctwzGOe+rbgdXZSbDbV0dmM-cx4qt_d8nKi88=HA@mail.gmail.com/T/#t

[3]

https://lore.kernel.org/all/CAOLa=ZR=2B7yH+vtyiAPcCyU17yd2GZwonaj=JRo1f+LzSCoTg@mail.gmail.com/

[4]

https://lore.kernel.org/all/xmqqy0kp7wai.fsf@gitster.g/





-------------------------------------------------------------------------
Changes since V6:

  - Update recent contributions. Rewrite descriptions for some of the 
contributions.

  - Add a section on trade-offs, discussing insights gained from 
challenging scenarios I may encounter.

  - Completely rewrite the schedule.

  - Some expressions have been modified.

Regards,

Yuchen
