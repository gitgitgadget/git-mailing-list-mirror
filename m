Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FFE13959D
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 01:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771808850; cv=none; b=iYpkolsM95gltaDRwA5OdcAcIKQU15Qw7+zR0DX6db/lCxVen5PB2FJoLF5T3DhP9W+5YfHR6UEHt3n0z43E86VIRXfVfpXdgGI232QMlBZyJOIHWTCM60eS3RqepSnYjlH5pCN4tzxc2l27qM+MZRW8+EcI3MDyj0CkCLaOyIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771808850; c=relaxed/simple;
	bh=rCM2eYdTAAtmHZouMdRpgGUxueqVHWz1dXh6JRvP1+Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sVhuMKqyHVmnPIeglfos4EIk8f/miN/sY/mY2vPio5zmLiN1DNd45gZKZgFkwtIEDAxGTSyDzGIlQV4ANE17FI+S9MSMCl+r2l+uxfTvNSQ/IXDmrnfU86h4G6zJ5P22zcpDtcEnrsPtP1RUDb7AAlP8w1VhDgXwusbicjhYCGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjeTAq5D; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjeTAq5D"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c6dbfab1b73so142894a12.0
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 17:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771808848; x=1772413648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XUx6HkiJAWNhrzxV7V5kk0QEyElS8ZxzJ5fEPkGYMAs=;
        b=OjeTAq5DRwxs3YW5uvsSFkn9UIDZdkVfvu5A+cZbNqRaIF2ZEgQ4Ed7uxtDoQE/KYB
         P5dO7MtBB4eAfVv6VUxiJsoUgcPumnvclDh3xFpMwNQ6fwoKjWYuIdeaA9gWxu7R5j17
         eTF4pYTDf8e1nKBgaV7n7RzuwLBuV2zFfAoV9QpaJJmxoAA2f5J9513elVzJs2mK1NXL
         IVOi8gOmWnB+5d8s9uV40v05nOBtCf5zY71+hpBD/8mar1Yzg5ifabmOR00a4ir8/YPE
         5NS7xf7xvKgSdNTVtwBHkIgkeSq6Gj3a8G/gYybcOYfp8eEfi++HOYM3RA0aH+hbnfh+
         bgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771808848; x=1772413648;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUx6HkiJAWNhrzxV7V5kk0QEyElS8ZxzJ5fEPkGYMAs=;
        b=vyfQPULsXdeBBTI18+YwEQED6phJa9BQh2jf9qqckda1Paqqc8h8X0p7zmVysaGw3S
         jbmXKMxZGgVMDmjA3FeTP0YKBclz3bppIyh4LBSNJBq61ETIBoFERBk5bww55qXz6F36
         w5EEXiUKEYLqkER98WXODTYGqskauMr+uVkUB7YKQcXSWKUv0cp28nZFEzs7wZ/KzoVd
         tlcq5w+YTHGk4bLtrlhRFAjSE63DblRXS1htr+hQMIAF8m3wWH8eIEHiJc8nrQjSJkV8
         VWQP8YMx0EaMCbyP3eweemdKqN5XYwyv9rK4v7Nd6XliZo2A8gmYkflruXWRQwrnpv8X
         4Rmg==
X-Gm-Message-State: AOJu0YzuMWGcUd5c6MKybL1RknrpA+VVSGJWPF4NDUtuAJoJXKf/xHcd
	WVuXNMCGb1jukfds24FYb/BaUvZXRiv78WZ76llcjvnhOYD24DFabkajePgptw==
X-Gm-Gg: AZuq6aIfgc6vCpLG4axgJveznFgRjfFBwYmF+OKGU3C/PmwHVXjhEqRvgctSy/N6pSX
	RFZQnwAJdsCb7qf2suKJ5f5d0scDY4dpK8DoFIrCDzLTJ5MmH1mP+qIcafYJUt3qLmnumgdJba/
	ufOzB+pEvIkj7Dv3iVnNt5Wa09GQGZlNSFbnmUveRi82heUeCSy46RHrldQr6btvbVRj/0ZIs0h
	a1UJc82fVJfNBfSsLSjUvB2vNoAo45Czpt5QvxTbXPy6AR5KL9l8Hki07ECcg/Y2keH52rvBnNP
	dunMzAjQCvjP1fjjH67ebDSPDRA8tk+mekIMw+Bo1EYKdbzKdjbQlTlf5Bu1A9e36uOYhcgejmB
	ZdZVGDzQAU3caWj2ss8O1qELtz8sUVbMkJhKal5BVc21ypKOy/Zwof7kpg+0/iF6h+/WDUIYH5Q
	rszWkIGCD6ddzePC8O7EpVbZ+Fd2A=
X-Received: by 2002:a05:6a20:939e:b0:38e:9479:8a4e with SMTP id adf61e73a8af0-39545f47ef7mr4181517637.4.1771808847571;
        Sun, 22 Feb 2026 17:07:27 -0800 (PST)
Received: from [192.168.0.104] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd86ca41sm6033885b3a.36.2026.02.22.17.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 17:07:27 -0800 (PST)
Message-ID: <1bbafedb-b87b-4f1c-bce3-59089ac1ff8b@gmail.com>
Date: Mon, 23 Feb 2026 09:07:23 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [GSoC][Draft Proposal V2] Refactoring in order to reduce Git's global
 state
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>
References: <ab45758c-fbcf-42b2-96df-030eef8526c3@gmail.com>
Content-Language: en-US
In-Reply-To: <ab45758c-fbcf-42b2-96df-030eef8526c3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello everyone,

I'm Tian Yuchen and I'm planning to apply for GSoC project this year. I 
hope you can take the time to review my proposal.

Please feel free to leave feedback!

Google Docs link:

https://docs.google.com/document/d/1t2sznOvnPz-9tOzVMH--pLxzRqYSJCFzqVWBVfL_NP8/edit?tab=t.0#heading=h.c3c40ftj1ilv




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
Although I wasn't a computer science major, I tinkered with open-source 
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
   [Will merge to 'next']

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

* [PATCH v10] setup: allow cwd/.git to be a symlink to a directory
  
https://lore.kernel.org/git/20260220164512.216901-1-a3205153416@gmail.com/
   In progress.
   After over half a month of discussions, repeated refactoring, and code
   reviews, I delved deep into setup.c. I gained insights into Git's 
design philosophy, and learned the art of striking a balance in 
developer communication. It took me a large amount of time and effort to 
thoroughly understand every line of the code. I often found myself 
poring over the call chain of a single function well into the night.... 
But I persevered until the end, and I believe my patience will see me 
through even larger projects.


ABOUT THE PROJECT
-----------------

-- Synopsis

As far as I know, the Git community is actively working towards 
'libification' - making Git's internal machinery reusable as a C 
library. The extensive reliance on global state is a major roadblock to 
this goal.

Many core functions implicitly read environment variables and store them 
in global static variables. This can cause several issues:

   1. Global variables prevent Git's core functions from being executed 
safely in multi-threaded contexts.
   2. When Git is called multiple times within the same process, global 
states can lead to memory leaks or incorrect behaviors.
   3. Unit testing becomes difficult because the environment must be 
artificially manipulated before calling functions.

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

The task at hand can be summed up in one sentence: repackage the global
variables into the `struct repository` structure. In other words:

     [ Current ]
     Core functions --------reads-------> Global variables (via getenv)
                                          [Thread unsafe]

     [ Target ]
     Core functions ----passes context--> struct repository
                                                 | owns
                                                 v
                                          struct git_env

Although the principle is simple, the scope of changes is extensive. The
following three-step approach can serve as a guiding principle for it:

   1. Identify isolated environment variables currently residing in the
      global scope. Introduce a dedicated structure to hold these states,
      e.g. `struct git_env` within the `struct repository`.
   2. Modify the function signatures within the call chain to accept the
      context, e.g., `struct repository *repo`, instead of relying on
      implicit globals. External callers of the functions must be
      carefully audited to prevent regressions.
   3. Safely remove the old global variables and macro definitions. Tools
      such as AddressSanitizer can be helpful to ensure that the new
      struct-based lifecycle introduces zero memory leaks.

Additionally, given the anticipated high volume of commits, we must 
ensure each patch is independent and atomic, preventing any 
user-untraceable or unexplainable bugs from occurring in the codebase at 
any state.


AVAILABILITY
------------
Fortunately, my summer vacation coincides with the GSoC work period.
I will treat this project as my primary focus, dedicating a minimum of
35 hours per week. If needed, I can work a 9-to-5 schedule.

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
   - May 8 - May 25: Define the core context container. Draft and submit
     the initial RFC patch series for this new data structure.

* Phase 1 (May 26 - July 10): Foundation
   - Weeks 1-2: Plumb the context pointer (`struct repository *repo`) 
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
faster than planned ;)


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

-------------------------------------------------------------------------
Changes since V1:

  - Transfer the text from Google Docs to here.



Regards,

Yuchen
