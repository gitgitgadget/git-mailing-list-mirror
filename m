Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF0B1A6825
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772539902; cv=none; b=FvAKE30GFCB69H0A6zpjBxRUTjbrDIc10ddmsgaNsTcIbhbhyBbSUwd366D4o3x4E3DxysxKuGKZqxvWrWnh14h7A4QIOxjNw9S8u/9jZf0AaBkUGqESUsFAKKGw+DUEk1gDKeMiUp65QbeN0tK+9Nn5sVI9qmk7FeHAq9n2U/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772539902; c=relaxed/simple;
	bh=kUSi9q0Br4VIzB9UsgRTRBi9gzS5NSOiECbpKsHR7i8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cLfHxdtt5BXHSoY1Ku4zJVBA8k25VqdqeylxfJj0CtmRvCxFtqta5zwW6U6bTz84anl4bIt/Qp/qVLzbLklkvuV4V3waEZADH5Q7TCNlaek57cJ50uUzritLuBXtj5reMORah4jm9DOsCs/BLwIg4u1wrDjnjSzizklxDEMVA4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbRP1uMA; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbRP1uMA"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c635d5d594dso1028847a12.2
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 04:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772539899; x=1773144699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+1P4I0JO4lU8M8UixdxCQ0zLuoWmZxVdKHaTA3ZSYpM=;
        b=bbRP1uMAOX6mUjASyg48Jh4qIpD2rAZo+gYMSxRp0jlqT+pMeeTQQ6xx8pwQpxo0se
         boqCHI8gSDE4x4qPKAi3Lrj7WFrDa50fc3vp5hfaX+Y/pdZP5gOaMmlvnaIVaKUAEDOb
         /MrTgsXwYtCXd3zuqhBYGbOQXfjDFAVIGM2FPf5//9aiDoRUbi/Dc1Q3xnsZxoJL3MrK
         YBMGVMzFf3ZjHjkZ4/UTcI6ZSXK9MOs9ccHLshR9Lyc+/OoGsLYM3It06vz4ohE9YSuL
         HftvzhoeJxKsamBgHOvtauRkloMtFm3XfeFV+zlbARPutijcSdF+A68uhuK4A0NiUcy9
         oeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772539899; x=1773144699;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1P4I0JO4lU8M8UixdxCQ0zLuoWmZxVdKHaTA3ZSYpM=;
        b=uswuL+q92SOv3tVdV6InGPFV2Tw1CX5cioh7aEaEJex+ZYJgDEoQuiHCemg5EMjteh
         Yf4yHEjd2KUnMLEUz+B9gKugj2TH0Vs43Y8ZE6FM/NUA1ZKwbv+o+r3A4mYL552BV0bQ
         BmBAWWvYn1QyuRr8S2ZdxZesB2wvW7c1uO1weptOwQIckBdLkZxpEg35YUcUJ11Fcu3i
         U0vknh/l9NMd4tn4i+gKZTqawF+tUz4vWPcz3sh5rZ8xkdbXQpkzpYyq9RH+qR+1v0zy
         VChahHxRcAkSTq/SNXYMNPK3Moyk7qe5P6z3JuykHNj6mF6QpuhjdSA0g390FaMk59/2
         x+bA==
X-Gm-Message-State: AOJu0YyHsAyhy/CpKsME70VjktdC3VINuuJhLSmWNs6QKUbembEnwlaC
	76eT4ZLX3qNgpEO1WPyYrc/6EeMxNTWKX2/Om41Qozdf4r3D5AOWVGdPX/zTAg==
X-Gm-Gg: ATEYQzzHgh9zM9bFNCRGYyQRG4dPDXeMLAgOIthsK01Qg9aFY/k4GEqaz1CmcOIiPwj
	LEypVBa3MooS/7BSvRHf4dhAJuXQECa84ORJ4hrUhGo3PHi2E/ucg2as4SuuopOGQAvKx3wB5Vf
	jY2nGmbJa1ivhd6qVBziG/Pc94W5PyTgZ4qsqyg1l4/sLn7/eM5Wlvzs/wpeunq/6nHcD4ugyPB
	t7LCSKmg0VfHBkFdMXPYVlMpDvaKoJIgD8AKrSzvcpTYESrr6HcrIszIJ1QL+Wg+orAj9inKAfa
	x9f6vF9jhK8BnHvzfN5HWaf2dsVcOdNr44gHqeVuL0XcytYxGkH/SAcjrh8JhKiKckNxjgZN7hA
	/+V6v6SuuDEXgW8J6f4omFG/CR4MTed7d/nLHRgR3rh4ZN5fUrC48Xa4Jw6AVNCqGBm6qXJj6cA
	yP5gTBe6nQ9OzojfkOfyDGeYLA0OHn5caoqhV62PC3fK+t5CFSLCaATW8RlSbmDuMR+NV09u1sR
	oGTCSEvyAQL
X-Received: by 2002:a05:6a00:a474:b0:821:84c3:845b with SMTP id d2e1a72fcca58-8274da89583mr7295761b3a.7.1772539899195;
        Tue, 03 Mar 2026 04:11:39 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a010996sm15436139b3a.44.2026.03.03.04.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 04:11:38 -0800 (PST)
Message-ID: <f19c95fd-756e-4890-b718-10ccf09c31fa@gmail.com>
Date: Tue, 3 Mar 2026 20:11:35 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [GSoC][Draft Proposal v6] Refactoring in order to reduce Git's global
 state
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
Content-Language: en-US
In-Reply-To: <0a944142-7c51-4143-af00-2a5798ea68af@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

Here is the V6 Draft. Looking forward to hearing your feedback (ゝ∀･)

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
thoroughly understand every line of the code. I often found myself 
poring over the call chain of a single function well into the night.... 
But I persevered until the end, and I believe my patience will see me 
through even larger projects.

* [PATCH v4 0/3] move encoding configs to repo_config_values()

https://lore.kernel.org/git/20260228190201.3684705-1-a3205153416@gmail.com/
   [In progress]
   A practice patch for working according to the workflow described in 
this proposal.

* Re: [PATCH 4/4] repo: add the field path.toplevel

https://lore.kernel.org/git/e6e7e272-4aec-461e-aebd-33ec0a324770@gmail.com/
   Code review. Question unreasonable designs.



ABOUT THE PROJECT
-----------------

-- Synopsis

As far as I know, the Git community is actively working towards 
'libification' - making Git's internal machinery reusable as a C 
library. The extensive reliance on global state is a major roadblock to 
this goal.

Many core functions implicitly read environment variables and store them 
in global static variables. This can cause several issues:

   1. When Git is called multiple times within the same process, global 
states can lead to memory leaks or incorrect behaviors.

   2. Unit testing becomes difficult because the environment must be 
artificially manipulated before calling functions.

   3. Global variables prevent Git's core functions from being executed 
safely in multi-threaded contexts. For example, When unexpected states 
(e.g., a permission denied error when probing a directory), they often 
rely on the global state to decide whether to call die(), which 
internally calls exit(). It’s fine for a standalone CLI tool, but for a 
linked C library used by a long-running multi-threaded server, a single 
die() call will kill the entire host process. Structured status, instead 
of fatal exits, should be returned.

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


-- Approach

The task at hand goes beyond simply repackaging the global variables 
into the struct repository structure. Based on my recent experience 
refactoring setup.c, I realized that libification requires careful 
management of variable lifecycles and api boundaries:

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
following insights can serve as a guiding principle for it:

   1. Identify isolated environment variables currently residing in the
      global scope. Conduct a case-by-case analysis to map each variable
      to its most appropriate existing home based on their lifecycles:

     	Variables that are only parsed when needed will be safely mapped
	to struct repo_settings.

     	Variables parsed at startup (e.g., editor_program) must not be
	moved to lazily parsed structs to ensure that invalid
	configurations can trigger early failures before execution
	proceeds too far, which is also for the sake of user experience.
	(Phillip Wood points out that the struct repo_config_values()
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


TIMELINE & MILESTONES
---------------------
Considering the differences between this project and other projects on 
the idea list, rather than hoarding massive changes, I will submit 
3-to-5-patch series frequently to respect reviewers' time and maintain a 
steady velocity.

Below is the tentative schedule I have prepared for myself:

* Community Bonding (May 1 - May 25): Planning & RFC
   - May 1 - May 7: Wrap up university finals. Discuss and finalize the
     prioritized list of subsystems with my mentor.
   - May 8 - May 25: Categorize the targeted global variables and map out
     their intended destinations (e.g., repo_settings vs 
repo_config_values). Draft and submit
     the initial RFC patch series.

* Phase 1 (May 26 - July 10): Foundation
   - Weeks 1-2: Plumb the context pointer ('struct repository *repo') 
through call chains for simple variables (e.g., boolean flags or integer 
configs).
   - Weeks 3-4: Audit and update external callers to use the new API.
   - Weeks 5-6: Submit the first major refactoring patch series. Address
     mailing list feedback and resolve merge conflicts. (Midterm Evaluation)

* Phase 2 (July 11 - August 18): Complex Migration & Cleanup
   - Weeks 7-8: Refactor higher-complexity variables (e.g., path-related 
globals).
   - Weeks 9-10: Compile the codebase with AddressSanitizer and run the 
full test suite to execute strict memory leak checks.
   - Weeks 11-12: Remove unused global macro definitions and static 
variables. Update internal documentation and write the final GSoC report.

(The above is for reference only. Personally, I always finish tasks 
faster than planned 😉)


~$ git checkout HEAD@{postGSoC}
-------------------------------
This past month since joining the Git community has been the most 
enjoyable month of my programming journey. To quote a close friend of 
mine (who is applying for the Neovim GSoC project):

   "Only fools chase trends; open source is the game for the brave."

The words may be blunt, but the logic holds true. This statement surely
resonates with me (and maybe many other GSoC contributors): our passion
for code and open-source drives us forward.

Even if I didn't make the cut, so what? ~$ git reset --hard...
Just kidding. The Git codebase is far too interesting to abandon now.


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
Changes since V5:

  - Once again, the diagram and approach sections emphasize 
distinguishing variables across different life cycles.

  - Modified the --Synopsis section. (issues with global variables)

  - Included recent contributions and updated progress.

  - Reference links has been added at the end to clarify the source of 
my viewpoint/plan.

Regards,

Yuchen
