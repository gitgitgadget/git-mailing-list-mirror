Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFA836C5AE
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772970042; cv=none; b=uJ1C6iD/LYxsWH1LcPjY3YMtgFIawyIAedflmY8Lf7641X/KtNKYlX63zQ/PdHWSZZPvsWLgmgTW/ewLIWO14OulwIDWK3QJnuq78MWk5q9TIrEqklArV7Ib7atWiaH81INxDSLkSZr3LxNw1QcLLONOpKISOihLkrMGlaenuZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772970042; c=relaxed/simple;
	bh=5944vVnX8ao/oMyxgW6h5WoTtqYtka797X6hy7FA2Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MW9cevzQpeP7qvInX2oLSvy92ZS5Ac+OHC/ZNrLw3+Rf6Jq08dLGonwyO1ghORSk0gjah6m3UNj+8PchvQCraVpZ5Us4PkJqZJrL78JLAtlmuxlu3yeosUUMXILqWyXqboqX5diOBfyyEdzyusP1YLiZwevdj88Ov+0qgElFBKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPIRsEyz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPIRsEyz"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483abed83b6so87936405e9.0
        for <git@vger.kernel.org>; Sun, 08 Mar 2026 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772970039; x=1773574839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGZWlVBk5aZEakbXfF6jvCRzOfBFyE3tVsSkExk/1j4=;
        b=cPIRsEyzshUzHqfhiqkwEGZ3Shrp0FeA/NQZx2ePO9dTtUeyZefoxXWvszVLN4NSuy
         C0Ba+EbCRvUzvR2MInpoZ2ZuYQD197gvF9PIQSRBBtu84UotB2HC6zFqstMq3lvpb291
         e4mMtKlPdeEbQQwNs4RnPC+/TT041x1FsHhvGFgKLFAlvzmMv2floZp541+3DwMRDXCo
         Hsc62THBROJaV1UeWD/t8JTSogGNBFWuT7ZiQmlQUhQ9jvrG/f9c+gnyWO8zdJcRGPSx
         i/CAWpS8NddrAML6GNs0vGLdsXtv9tbTi/5xKXUQjuPOPplVWa12+iDp1t6t8/govYJX
         BMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772970039; x=1773574839;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KGZWlVBk5aZEakbXfF6jvCRzOfBFyE3tVsSkExk/1j4=;
        b=nBq/Bh8doqhus4OdGvQk36byMjZmAGxjYsqFiG/AHthEl+/zNyOIj7g+vPxZ4w52pt
         SEyCgxrQ5/HlueW8vFcQHxNslg0n6ZbzNoMGg3U8ubDv+84swHREIrqfvO6vhto5OTiG
         k9BldSWf+rth82F/yDdDL0+1ve/SL/Ad/B5CW/oTWThFp/QzkHOKMEPC5amnBjy/eZyH
         VoG8lj1fG7czStjb23cSc2v3oquPq5CVy7ykoWkCVkU1R7t53YrX7Uh82It8pKadQ/T8
         p9Lu6rMz1aZPRVzfEIni0uLEUfSvVOWtIeNw+D/FccPLqeYsKqg9afx+IjL5QzqfQh8e
         1H4A==
X-Gm-Message-State: AOJu0YzNVzNQiu6TD4XLZ0hfkOUwl/TsCe7Ex97FYhfgpZMoCaBdgvYn
	m6KCyd1BOOUxpS0lioMf6/lYuZOb0C/gbiy3SYNbCE1jTunnEQRNAp2jxBMldg==
X-Gm-Gg: ATEYQzzD4lPZOaRzQqSor2MhX7M0d4ASEgwT+RZB96gJtEnzkPj89E3ZyoBLESTdh0M
	AYPdJCuupbQOMrBapqqHChm/mcnxSm8DDy/UtGV9PEdoLrPfcvbnx+SSUMwq9YeTIPwOT1K6s2Y
	VDAQLXhQo5nEyz3pIaAqU1JxOKPI/2CvQtS2QaL7eQygJN/Xycm+67xD/pYo1kS3/QTgdmoLyzG
	C2aiFUvBhg9MnDoRICMOeRH7LIbL8bBZDCdbB8hPgAaasWnsCQPibMuFwMG4SXz7L+rRwF677xw
	rbQWDXXFG4eqtHCkQBUefXB3XN2sxnm0Tir7FvX8Ni2a8vao8g1wns3+TG7TQu6vbflBRcDLLUr
	nEPD/wouq6hBbSA6pRvl06+YmcwYphHF7F6p+ppaGTRDuk6jDGMRQypVUEw5b2u8PdfXvRgv3R7
	rxh/J7lZ7qLq+uqho9/RY=
X-Received: by 2002:a05:600c:a12:b0:482:df17:bbbc with SMTP id 5b1f17b1804b1-48526969710mr125181725e9.20.1772970039222;
        Sun, 08 Mar 2026 04:40:39 -0700 (PDT)
Received: from gmail.com ([159.146.43.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485245dbcffsm63278375e9.18.2026.03.08.04.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 04:40:38 -0700 (PDT)
Date: Sun, 8 Mar 2026 14:40:35 +0300
From: Burak Kaan =?utf-8?Q?Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com, karthik.188@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com
Subject: [GSoC Draft Proposal] Refactoring in order to reduce Git's global
 state
Message-ID: <aa1cn0_ATfh-uRE4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

=================================================
Refactoring in order to reduce Git’s global state
=================================================

Personal Info:
--------------

Name: Burak Kaan Karaçay (he/him)
Email: bkkaracay@gmail.com 
Education: UG Sophomore, Marmara University
GitHub: https://github.com/bkkaracay
Timezone: UTC+3 (Istanbul, Turkey)


My Patches:
-----------

+ (Microproject) t2003: modernize path existence checks using test
helpers
   - Thread:
     https://lore.kernel.org/git/20260208202809.270523-1-bkkaracay@gmail.com/T/
   - Thread v2:
     https://lore.kernel.org/git/20260209112444.1268765-1-bkkaracay@gmail.com/T/
   - Status: Merged to master
   - Commit Hash: 168d575719d944759964e004d17a3282b0f883d5

+ [PATCH 0/2] mailmap: reduce global state
   - Thread:
     https://lore.kernel.org/git/20260219125954.3539324-1-bkkaracay@gmail.com/T/
   - Status: Merged to master
   - Commit Hash: 2d843a2d3d6c2d5e7861e6aa99743d15d36746b9


Relevant Experience:
--------------------

I am currently developing my own programming language as a hobby
project, writing a zero-dependency interpreter for it in C. While it is
still a work in progress, I have completed the core front-end pipeline.
Building this project has given me practical experience with C
programming, data structures and modular software architecture.

+ To support potential future multithreading, I avoided global variables
in my own project. Instead, I pass state via local contexts.

+ I implemented an arena allocator (memory pool) to reduce malloc system
call overhead, prevent memory fragmentation and ensure cache locality.

+ I used techniques like string interning and Pratt parsing.

My project is available on my GitHub profile [1]. If you would like to
take a look at the code, 'src/main.c' is a good starting point.


Project Abstract:
-----------------

Git was originally designed as a short-lived CLI tool, where relying on
global variables was highly practical. Over time, the need to embed Git
into other projects and applications emerged. Today, these global
variables are a huge roadblock to the libification of git, as they make
it impossible to properly handle multiple repositories within a single
process or safely support multi-threading.

This project aims to reduce this reliance by migrating global variables
from 'environment.c' into appropriate locations. This effort will
support the libification goal and modernize Git's internal structure.


Technical Approach:
-------------------

The core challenge of this project is choosing the correct parsing
strategy more than relocating globals. The codebase currently offers two
migration strategies for global state removal.

Currently, globals are loaded eagerly via 'repo_config()'. The modern
'repo_config_values()' API provides a safe and straightforward way to
eagerly load variables and reduce global count. However, eager-loading
parses all configurations upfront, including unnecessary ones. Users may
encounter fatal configuration errors that are entirely unrelated to the
command they are executing [2].

On the contrary, lazy-loading postpones the parsing process until the
variable is strictly required, preventing unrelated configuration
errors. However, it is significantly trickier to migrate. If a
misformatted configuration triggers a 'die()' in the middle of the
execution, it risks causing data corruption. Moreover, lazy-loading
changes the timing of error reporting and struggles to replicate
eager-loading behavior when multiple configuration keys affect a single
variable [3].

If lazy-loading is considered safe for variable, git provides two APIs
depending on the performance requirements:

   * The 'repo_config_get*' function set is suitable for variables
   * accessed infrequently because of underlying string hashing costs. It
   * is important to use this API to not bloat the 'struct repo_settings'
   * [2].
   
   * For frequently accessed variables, caching them within 'struct
   * repo_settings' is preferred, as it amortizes hash costs and provides
   * direct memory access speed.

There is no silver bullet solution for migrating globals. Because
transitioning these variables require a deep understanding about the
codebase, communication with mentors and the community is essential.


About Gentle Reading:
---------------------

Current config readers rely on 'die()' to handle error cases. While
pragmatic for cli-tools, fatal exits are unacceptable for a library, as
they will crash the host process. Building upon Derrick Stolee's recent
introduction of gentle parsing functions [4], I propose implementing
'_maybe' variants for core configuration readers. Since removing all
'die()' calls is inevitable for libification, sooner or later config
readers will be purged from 'die()' calls. Utilizing the gentle
functions for newly migrated global variables will reduce the future
amount of work.

Applying this gentle API to widely used functions risks creating
unreviewable patches and merge conflicts. To solve this, I plan to use a
function wrapper approach, similar to the strategy used in early
the_repository migrations [5]. However, the_repository changes are more
mechanical work compared to the gentle transition. In complex call
stacks, a gentle transition risks causing a regression or a scope creep.
Utilizing the "normal" config helpers will be helpful in these
conditions.

Another possible roadblock in the transition is the magic numbers in
error reporting. Some of the functions in Git use -1 and 1 to inform
callers about two different error cases or situations. Introducing a
third hard-coded number to tell callers to stop the Git process for a
misformatted config would be a poor design choice. Furthermore, adopting
a standardized error structure like enum git_error_code is a step toward
git's ongoing libification efforts, as it enables external callers
consuming the API to handle errors programmatically.


Availability:
-------------

I plan to dedicate 40+ hours per week to this project during my active
coding period. However, I want to be completely transparent about my
university's academic calendar to set realistic expectations.

In Turkey, the university summer break begins in July and ends in late
September. During May and June, my schedule will be heavily occupied by
final exams and major group project deadlines. For this reason, my
availability during these two months will be limited to around 10-15
hours per week. I will use this time to stay active on the mailing list,
participate in architectural discussions and submit smaller, preparatory
patches.

To ensure the highest quality of work, I propose utilizing GSoC's
officially supported flexible timeline. I am completely free during
July, August, and September (with no summer school or internships).
During these three months, I will dedicate 40+ hours per week entirely
to git.


Community Bonding (May 1 - May 24):
- Analyze environment.c and create a detailed mitigation plan for each
   variable.
- Discuss the plan with mentors to identify potential roadblocks or edge
   cases.
- Submit a patch about 'enum git_error_code' to start community
   discussion.
- Set up a blog to share bi-weekly updates throughout the project.

Phase 1 (May 25 - June 28):
- Introduce the '_maybe' versions of the config readers and write tests
   for them.
- Begin mitigating "low-hanging" globals. To avoid wasting time while
   waiting for reviews, start drafting subsequent patches concurrently.
- Publish the first progress reports on the blog.

Phase 2 (June 29 - September 15):
- Discuss globals with mentors where mitigations might cause behavioral
   changes.
- Shift focus to the more complex cases, specifically those involving
   eager-lazy or '_maybe' transitions.
- Continue publishing regular blog updates.

Phase 3 (September 16 - September 30):
- Act as a buffer period to respond to final feedback on patches
   currently under review.
- Complete the final project report and publish it on the blog.

References:
-----------

[1] https://github.com/bkkaracay/caret
[2] https://lore.kernel.org/git/xmqq1pk3lmu3.fsf@gitster.g/
[3] https://lore.kernel.org/git/23428022-ab13-4a3e-90ed-ff91ef93f051@gmail.com/
[4] https://lore.kernel.org/all/pull.2044.v3.git.1771849615.gitgitgadget@gmail.com/
[5] https://lore.kernel.org/git/20260109213021.2546-2-l.s.r@web.de/

---

Thanks to everyone for their time and guidance. I'm really excited about
the possibility of working on this project, and any feedback to make
this proposal better is deeply appreciated.
