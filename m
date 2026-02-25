Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF0629BD90
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039491; cv=none; b=tS2EpXTeosQZ+TG/zp+BtkhqvbNCPQwObOsC72J9nVB29tWEvSa2376IDmMPts0Ux9AoDc8NOVve6mYKwYr4v6jqpS43N+DdhhxnDfxQlP5IxP6rk7DFM5OAdw9BpHfwYja1RBzvv66vRqP118sjmTcx8YYhJhYPqrPlYCS0pdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039491; c=relaxed/simple;
	bh=P+uIj2rt6yHBrsSmyrEfoDGiYjgkZ/1gJIZq7cnvWBc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=levlAtr0FymA/WnbDSmGS81Vzhoi3pT+WazRZbBXBD49VyS3flUu6Wo/tYIbEivJ484OHotUwF+GKtk/m8jNLUhL0bIlpnqqRXPkGk8X8Xn1eRUy+/ehCfzLlr3rGQusg7rDDpbQs5JUvqWTPelyKSpTwtltvDX/t9O0iwF+6z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aq1R9ZkZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq1R9ZkZ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aae38670daso5848245ad.3
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 09:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772039488; x=1772644288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DE3TIU67/c/fFud8J4B4IVG9IC09k2thdfBnEUjGoUU=;
        b=Aq1R9ZkZkAOGpBptzP884dyjBVgLVnIr+CO+sL7NbDmZPiSR+kVFXFreIEUp+J0Q6Y
         Qy93bJswWSazmjzuJYrt8z2yRNqLYHcqcR+44WYpdzvIDCmZ9nPxHmc90mb/fEbaL5x/
         TeMqg+aXWfJVNb4gmG1JukJgjFJBLFbV21sikyCrEmc3GTqFh5tj9jwBnrxAGBvLwfCj
         mVglKKcMH3jzLY+Bgvy30VBAqYfwRNjV4ynYbdlKHyeDgzh8O7p6QnK0p8bT5Fphajzd
         5ZCXqqejXI2l1CpYGErqODGISVn9T1TotWnaUbAXzrgbMuWoQFWHdsNpKmHtDFvBmkeU
         0cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772039488; x=1772644288;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DE3TIU67/c/fFud8J4B4IVG9IC09k2thdfBnEUjGoUU=;
        b=nG8VvNDF15VLNf1rJCap/OdhIfjpaxHTAkGE5XODFLwMdEcqxakvO2OVsPagqKzFuh
         EhBQelA/2XDlX1EfLLm2Ch00w4p5pS4VWyLoFcoxfhuTH62OhAjNkm80B0Da7d8haVu4
         hwj8B1IewvjpX8Ah6QgW0g+Zu5Yx14nvdX5vzLDQqViv/Vk0uz48YHki5aHFR32VDWbX
         XGXWwnEN9pzE6LrOMZqFpzKBlBe+gkPzk68dk7CVund2VJNHScv/IY9CfiBimor1XsOl
         vMVuFBjIxqVl08y0YIjgN28W2B//vaj/92pdsEqyZ8U6UZCaKEdSypIRchkRpEIl4vox
         VglA==
X-Gm-Message-State: AOJu0YyQm9jrZdVjFaskYB+F2NQhgKnzkTkG3u1duUXXA7E3UkgcRiCV
	oOPz3oZQtrDwEYyMExdIlQsW+otmBhUkDUAn2wMSin7YWlY6RbOpqVePFFouhw==
X-Gm-Gg: ATEYQzyWe9kDweRBr/5fpn063CJvOzATO7buMBMFT6EfnwTfJqV8P0QdmxJjqJ85ycj
	a61HiNLhnE9FUvf+SzNZGuEfT0YefhjulmcUhMNUnTU46IpJoqEAgGGKnY/ZqLhoH0Npbkaqg+a
	Osi2ZmnruGr7j91VrMowXlkfxWSc4PHQnT9BE1CI97FNyFSV4HoQ/mlzPWrPd6TpYxb0DcdDWco
	2QJX+m2k+BbWJ3MFoDppC5q4C9C+b9qthbIjBNijo33GE9weAhnK2OdvrGTg9CJzcExWo7BC7a3
	e1wW6qcAqVhGK41Sbsr8Rt3ajW/OD+W0UyEfVmTW6SeQL2sQ++yMWO4MDi0MIzeugPwOcJrDZu2
	hhGYhu26NmX5uQdezkABpTnqhE8JtB+DyEPfA37Fnq56ZEOheiviHCEai9zvEa2UPBkionj+gua
	vZGVY9pMnGHuVt8PRPfxSn6d0dYxw=
X-Received: by 2002:a17:902:d2c6:b0:2aa:d5fe:6d27 with SMTP id d9443c01a7336-2ad743cd942mr122490785ad.2.1772039487752;
        Wed, 25 Feb 2026 09:11:27 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2addf2a3d7dsm18870105ad.55.2026.02.25.09.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 09:11:27 -0800 (PST)
Message-ID: <b98780d7-3aa9-4838-9234-290b1d72ffd7@gmail.com>
Date: Thu, 26 Feb 2026 01:11:23 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC][Draft Proposal v3] Refactoring in order to reduce Git's
 global state
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
Content-Transfer-Encoding: 8bit

Hi mentors and the git community,

Here is the proposal V3.


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
   [Under review]
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
safely in multi-threaded contexts. For example, When unexpected states 
(e.g., a permission denied error when probing a directory), they often 
rely on the global state to decide whether to call die(), which 
internally calls exit(). It’s fine for a standalone CLI tool, but for a 
linked C library used by a long-running multi-threaded server, a single 
die() call will kill the entire host process. Structured status, instead 
of fatal exits, should be returned.
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
                                          struct git_env

Although the principle is simple, the scope of changes is extensive. The
following three-step approach can serve as a guiding principle for it:

   1. Identify isolated environment variables currently residing in the
      global scope. Introduce a dedicated structure to hold these states,
      e.g. `struct git_env` within the `struct repository`.
   2. Instead of blindly passing struct repository *repo down into every
      single low-level library function, bubbling the dependency up is
      the true goal. External callers of the functions must be carefully
      audited to prevent regressions.
   3. Safely remove the old global variables and macro definitions. Tools
      such as AddressSanitizer can be helpful to ensure that the new
      struct-based lifecycle introduces zero memory leaks.
   4. Many globals like are parsed once and remain available globally.
      New data flow might need to be designed to maintain the lazy-
      loading efficiency.

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

-------------------------------------------------------------------------
Changes since V3:

  - Based on reviewing last year's contributors' changes and recent 
experience modifying setup.c, additional descriptions have been added to 
the synopsis & approach section.
