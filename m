Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E66107A8
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711696118; cv=none; b=UwiVkCF0/uKT01IvSCvlgrmYyeLsYPaP4wDq5M5PL/GbrxtYm38VstZ6X30mNp575viR/0fBycSUimuVgwiUjDrxVSEuDJdsJsevNsUr8wLuRT2O0gpGTp4Eq4aIZOylJRYtADM27VEsP53jxjrKVnzNjVISy6EyytusWWByI58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711696118; c=relaxed/simple;
	bh=56pOnfRtRkAz7uFcSJc0EniDm2G21ZZVW4xn8qRG02k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mYC8vngSOipgrPdhcEu0SqE7iMpiM7jDBj6pu6ZGmnY/zRZvEZbE4DVfRZp5CiicWrapLvY6O6EsCSysaWTIJonZNoExMGnUbP32fnerMX8Bga3KQQVdusfTP5YJZU/q541n76RGjVqb2YYKk4Apb/BjsOeSTGiUG9iJQ0PoDoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIlUmjRo; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIlUmjRo"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e740fff1d8so1511114b3a.1
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 00:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711696115; x=1712300915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j4eo4iipb3tFGb9si20EbEoawljaldQKKlRJLRHIhxU=;
        b=GIlUmjRok5FpoJOS0YzKX8HPNU1yVaeHnyBhmgEsxka8EO7noot0weElFqnj38e45D
         Kjwd4Ri9gYXqvpTGdTgyiB0P/ZjpXXksq/WU054v4Xc2tfXNXFk1T1qTGzL3k8cZxqpw
         ak5DIcRTD2p8azwNP+06eY07jXJAza47P4H1bqVMb17DGrXRNCFpc+oBN5u+RKThLmbJ
         KGiOF0o0O77TD4Y8xClj6OWd7F2MP030VBfSBjk83MavMXLjpQOH8YiE9aj+CQc3atGX
         IXMUXXURHoDmJzaTcWwzI/KGu2KLxkIodOzk4WGhh/eR/1Qv4nyteiX0jYZjOpURYaqw
         KBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711696115; x=1712300915;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4eo4iipb3tFGb9si20EbEoawljaldQKKlRJLRHIhxU=;
        b=Z+8G+uwrKvZ4S4u7MHWOU6o4RHuCNT050nbv2rusuL5vALfbshUXQImItreF/+idwk
         BcEWzklZugq4mkD1SlzpqeK+ke75hEYmnfEDXdQ+b2GAmkBp3JZ/lmvKCQn91DI8/Fkr
         QNO5EzpMp7ReK/MCGbLbc+HD0JU+ujaJq9WAuHaer5iCiX9uGMM8EuH4W1lWysQJnNlU
         FFe0QjaThtcwVQIAUFoMo/AMRv/xIYJ71JFl6/eyjCZH3mZfCyUn9XwvVShX6FIWRlSs
         zLOyEvaElD6GJtWqf7DlhpvOXgpcXt4kwsZYDfS0BZMezHT4PBkFFk/7gXOYR0BC1UcW
         gMiQ==
X-Gm-Message-State: AOJu0YywKC804HVa3htC/KDWU0km3G5sl06G/cHooRIAQOevDnsX6dyx
	9sCNDueesDY4o9Mre9U4rgNLYy5gyodb2mMTSwlOmgF8GZl3MFBqbHN5CzS+QQI=
X-Google-Smtp-Source: AGHT+IG/zm5KspRXu7zRUYjYHnNKwk8S1g+eljuRrgFmxppuDbuSHDRXjJWzAFB4Y8fXqvMHHDod0g==
X-Received: by 2002:a05:6a20:1591:b0:1a3:c43b:2c2c with SMTP id h17-20020a056a20159100b001a3c43b2c2cmr1465018pzj.47.1711696115029;
        Fri, 29 Mar 2024 00:08:35 -0700 (PDT)
Received: from [10.0.2.15] ([160.202.10.71])
        by smtp.gmail.com with ESMTPSA id lm10-20020a056a003c8a00b006e6b180d87asm2454082pfb.35.2024.03.29.00.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 00:08:34 -0700 (PDT)
Message-ID: <63059d3b-e883-4fa2-8364-64f7bbd064f7@gmail.com>
Date: Fri, 29 Mar 2024 12:38:31 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [RFC][GSoC] Proposal v2: Move and improve reftable tests in the
 unit testing framework
To: Patrick Steinhardt <ps@pks.im>,
 Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, kaartic.sivaraam@gmail.com
References: <6f0a3c13-c8d9-4f89-8c62-9c031f0a064e@gmail.com>
 <CAP8UFD3Rb0kN=g=EPcSqYBb3U=OgW_06jqwafF=vRYhetZ9hdQ@mail.gmail.com>
 <ZfwnrL6Zl_lcV09y@tanuki>
Content-Language: en-US
In-Reply-To: <ZfwnrL6Zl_lcV09y@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for the feedback, Christian and Patrick! With your advice, I
decided to split my original proposal into two to conform to what was
suggested by the SoC 2024 Ideas page.

This is the proposal for the reftable tests migration project. However,
I am unsure of what would be a good project size for this project.
I have quite a long summer vacation and don't really have any other
plans other than GSoC as of now so I decided to go with large project
size on GSoC's website but please let me know if another size would
be more appropriate.

---------<8----------<8----------<8----------<8----------<8----------<8

Personal Info
-------------

Full name: Chandra Pratap
Preferred name: Chand

E-mail: chandrapratap3519@gmail.com
Phone: (+91)77618-24030

Education: SV National Institute of Technology, Surat, India
Year: Sophomore (2nd)
Major: Mathematics

GitHub: https://github.com/Chand-ra

Before GSoC
-----------

-----Synopsis-----

A new unit testing framework was introduced to the Git mailing list last
year with the aim of simplifying testing and improving maintainability
by moving the current testing setup from shell scripts and helper files
to a framework written wholly in C. The idea was accepted and merged
into master on 09/11/2023. The choice of testing framework and the
rationale behind the choice is thoroughly described in
Documentation/technical/unit-tests.txt.

This project aims to extend that work by moving the reftable tests from
the current setup to the new unit testing framework and improving the
tests themselves. The difficulty for the project should be medium
and it should take somewhat around 175-350 hours.

-----Contributions-----

• apply.c: make git apply respect core.fileMode settings
-> Status: merged into master
-> link: https://public-inbox.org/git/20231226233218.472054-1-gitster@pobox.com/
-> Merge commit: cf47fb7ec7e183a1a1e521a540862fba3c2a89eb

-> Description: When applying a patch that adds an executable file, git 
apply ignores the core.fileMode setting (core.fileMode specifies whether
the executable bit on files in the working tree are to be honored or not)
resulting in false warnings. Fix this by inferring the correct file mode 
from the existing index entry when core.filemode is set to false. Add a
test case that verifies the change and prevents future regression.

-> Remarks: This was the first patch I worked on as a contributor to Git.
Served me as an essential intro lesson to the community’s working flow and
general practices.

• tests: Move t0032-reftable-unittest.sh to the unit testing framework
-> Status: WIP (GitGitGadget PR)
-> link: https://github.com/gitgitgadget/git/pull/1698

-> Description: t/t0032-reftable-unittest.sh along with t/helper/test-reftable.c
unit test Git’s reftable framework. Migrate the test over to the new
unit testing framework to simplify debugging and reduce test run-time.

-> Remarks: An infant version as of now, I tinkered with this after seeing
the project list on Git’s SoC 2024 Ideas page to get an idea of the kind of
work that will be involved in this project. Probably the most relevant
patch out of all the ones mentioned here.

• tests: Move t0009-prio-queue.sh to the unit testing framework
-> Status: merged into master
-> link: https://public-inbox.org/git/pull.1642.v4.git.1705865326185.gitgitgadget@gmail.com/
-> Merge commit: 107023e1c9f981476c505e73eab319db6534a536

-> Description: t/t0009-prio-queue.sh along with t/helper/test-prio-queue.c
unit test Git's implementation of a priority queue. Migrate the test
over to the new unit testing framework to simplify debugging and reduce
test run-time.

• write-or-die: make GIT_FLUSH a Boolean environment variable
-> Status: merged into master
-> link: https://public-inbox.org/git/pull.1628.v3.git.1704363617842.gitgitgadget@gmail.com/
-> Merge commit: b3049bbb97c9c0d0292bc9239e976cc661961f39

-> Description: Among Git's environment variables, the ones marked as
"Boolean" accept values like Boolean configuration variables, i.e. 
values like 'yes', 'on', 'true' and positive numbers are taken as "on"
and  values like 'no', 'off','false' are taken as "off". Make GIT_FLUSH 
accept more values besides '0' and '1' by turning it into a Boolean 
environment variable & update the related documentation.

• sideband.c: remove redundant NEEDSWORK tag
-> Status: merged into master
-> link: https://public-inbox.org/git/pull.1625.v4.git.1703750460527.gitgitgadget@gmail.com/
-> Merge commit: 6484eb9a97fe3cd81a2d5711183b93494e6ddefa

-> Description: Replace a misleading NEEDSWORK tag in sideband.c that
reads ‘replace int with size_t’ with another comment explaining why it
is fine to use ‘int’ and the replacement isn’t necessary.

• make tig callable from PowerShell/Command Prompt
-> Status: merged into main (Git for Windows)
-> link: https://github.com/git-for-windows/MINGW-packages/pull/104
-> Merge commit: 8eb71eb31c6a1b5d41b253c1ab66d981cc448cb0

-> Description: Tig is a text mode interface for Git that ships with the
standard Git for Windows package but isn’t callable from PowerShell/
Command Prompt by default. Fix this by updating the relevant Makefiles
and resource scripts.

• fix broken link on Git for Windows’ GitHub wiki
-> Status: merged (Git for Windows)
-> link: https://github.com/git-for-windows/git/wiki/Home/_history
-> Merge commit: 0df663304bce986da6571cca48b34508d4823a11

-> Remarks: A simple fix for a broken link that I stumbled upon while
browsing Git for Windows’ wiki looking for some help with the patch 
mentioned just before this one.

• t4129: prevent loss of exit codes due to the use of pipes
-> Status: merged into master
-> link: https://public-inbox.org/git/pull.1636.git.1704891257544.gitgitgadget@gmail.com/
-> Merge commit: 1b095626937a858e3a68e9c7d1de11b71117bb42

-> Description: Piping the output of git commands like git-ls-files to
another command (grep in this case) in t4129 hides the exit code returned
by these commands. Prevent this by storing the output of git-ls-files to
a temporary file and then "grep-ping" from that file. Replace grep with
test_grep as the latter is more verbose when it fails.

• t9146: replace test -d/-f with appropriate test_path_is_* function
-> Status: merged into master
-> link: https://public-inbox.org/git/pull.1661.v3.git.1707933048210.gitgitgadget@gmail.com/
-> Merge commit: 90c0c15e56fa761ae8c4cf5f5fe09b329c0a5dc5

-> Description: The helper functions test_path_is_* provide better debugging
information than test -d/-e/-f.
Replace tests -d/-e/-f with their respective ‘test_path_is_foo’ calls.

• regex: update relevant files in compat/regex
-> Status: WIP (GitGitGadget PR)
-> link: https://github.com/gitgitgadget/git/pull/1641

-> Description: The RegEx code in compat/regex has been vendored from 
gawk and was last updated in 2010. This may lead to performance issues 
like high CPU usage. Fix this by synchronizing the relevant files in 
compat/regex with the latest version from GNULib and then replaying any
changes we made to gawk’s version on top of the new files.

-> Remarks: When I started working on this patch, I thought it was an
easy fix but the work turned out to be more involved than I anticipated.
I had to seek help from the other community members, and we have made
some good progress, but there is still a lot of cleaning and changes that
need to be done. I haven’t found enough time to commit to this again,
but it’s surely something that I want to get done soon.

• commit.c: ensure find_header_mem() doesn't scan beyond given range
-> Status: Dropped

-> Remarks: This was a patch addressing a NEEDSWORK comment in commit.c.
It was dropped because René Scharfe found out a better way to fix the
issue at hand than my approach or what the NEEDSWORK comment suggested.


-----Related Work-----

Prior work regarding tests migrations have been performed by other
community members and previous interns which form a good guiding path
for my own approach. Some previous example work:

i) Port helper/test-ctype.c to unit-tests/t-ctype.c
-> link: https://lore.kernel.org/git/20240112102743.1440-1-ach.lumap@gmail.com/

ii) Port test-sha256.c and test-sha1.c to unit-tests/t-hash.c
-> link: https://lore.kernel.org/git/20240229054004.3807-2-ach.lumap@gmail.com/

iii) Port helper/test-date.c to unit-tests/t-date.c
-> link: https://lore.kernel.org/git/20240205162506.1835-2-ach.lumap@gmail.com/

iv) Port test-strcmp-offset.c to unit-tests/t-strcmp-offset.c
-> link: https://lore.kernel.org/git/20240310144819.4379-1-ach.lumap@gmail.com/

v) Integrate a simple strbuf unit test with Git's Makefiles
-> link: https://lore.kernel.org/git/20230517-unit-tests-v2-v2-4-21b5b60f4b32@google.com/

vi) t0080: turn t-basic unit test into a helper
-> link: https://lore.kernel.org/git/a9f67ed703c8314f0f0507ffb83b503717b846b3.1705443632.git.steadmon@google.com/

In GSoC
-------

-----Background for reftable-----

Git’s internals consist of mainly three objects: blobs, tree objects and
commit objects. The blobs and tree objects are responsible for storing a
repository’s content while the commit objects store information about
commits in the repo and are responsible for capturing the repo’s
history. Every one of these objects can be accessed through a unique key
generated by a SHA-256 (previously SHA-1) algorithm. To make life
easier, instead of remembering the hash key for commit objects, we can
assign a simple name to them, store these names in a file and use that
file whenever we need access to the commits. These names are called
‘references’ or ‘refs’.

Since a repository can contain a lot of commits and branches and hence,
a lot of refs, Git used packed-refs to save space by storing unused refs
in a single file. However, this arrangement doesn’t scale well in terms
of both space and performance. This is where reftable comes in. A
reftable file is a portable binary file format customized for storing
references. Some objectives of reftable are:
-  Sorted references enabling advanced scans like binary search.
-  Near constant time lookup for any single reference.
-  Efficient enumeration of an entire namespace like refs/tags/
-  Combined reflog storage with ref storage for small transactions and
   separate reflog storage for base refs and historical logs.
-  Near constant time verification if an object name is referred to by at
   least one reference.

-----Plan-----

The reftable tests are different from other tests in the test directory
because they perform unit testing with the help of a custom test framework
rather than the usual ‘helper file + shell script’ combination.
Reftable tests do have a helper file and a shell script invoking the
helper file, but rather than performing the tests, this combination is
used to invoke tests defined in the reftable directory.
The reftable directory consists of nine tests:

•  basics test
•  record test
•  block test
•  tree test
•  pq test
•  stack test
•  merged test
•  refname test
•  read-write test

Each of these tests is written in C using a custom reftable testing 
framework defined by reftable/test_framework (also written in C). The
framework has four major features utilized in performing the tests:

•  EXPECT_ERR(c): A function-like macro that takes as input an integer
‘c’ (generally the return value of a function call), compares it against
0 and spits an error message if equality doesn’t hold. The error message
itself contains information about the file where this macro was used,
the line in this file where the macro was called and the error code ‘c’
causing the error.

•  EXPECT_STREQ(a, b): A function-like macro that takes as input two 
strings ‘a’ and ‘b’, compares them for equality via strcmp() and throws an
error if equality doesn’t hold. The error message thrown contains information
regarding the file where this macro was invoked, the line in this
file where the macro was called and the mismatched strings ‘a’ and ‘b’.

•  EXPECT(c): A function-like macro that takes as input an integer ‘c’
(generally the result of a Boolean expression like a == b) and throws an
error message if c == 0. The error message is similar to EXPECT_ERR(c).

•  RUN_TEST(f): A function-like macro that takes as input the name of a
function ‘f’ (a test function that exercises a part of reftable’s code),
prints to stdout the message ‘running f’ and then calls the function with f().

Other than these, the framework consists of two additional functions,
set_test_hash() and strbuf_add_void() which are used  exclusively in the
stack tests and refname tests respectively.

Since the reftable test framework is written in C like the unit testing
framework, we can create a direct translation of the features mentioned
above using the existing tools in the unit testing framework with the
following plan:

•  EXPECT_ERR(c): Can be replaced by check(!c) or check_int(c, “==”, 0).

•  EXPECT_STREQ(a, b): Can be replaced by check_str(a, b). 

•  EXPECT(c): Can be replaced by check_int(), similar to EXPECT_ERR.
   E.g. expect(a >= b) --> check_int(a, “>=”, b)

•  RUN_TEST(f): Can be replaced by TEST(f(), “message explaining the test”).

The information contained in the diagnostic messages of these macros is
replicated in the unit testing framework by default. Any additional 
information can be displayed using the test_msg() functionality in the
framework. The additional functions set_test_hash() and strbuf_add_void()
may be moved to reftable/stack.c and reftable/refname.c respectively.

The plan itself is basic and does need improvements, but using this plan,
I have already created a working albeit primitive copy for two out of the
nine tests (basics test and tree test) as can be seen here:
(link: https://github.com/gitgitgadget/git/pull/1698)

-----Improvements-----

As Patrick Steinhardt mentioned in this mail (link: https://public-inbox.org/git/ZfwnrL6Zl_lcV09y@tanuki/),
apart from the port to the unit testing framework, the reftable tests
could use some more refinement. This can be done alongside the test
migration efforts and can involve:

• Improving documentation for the tests:

The reftable tests suffer from a lack of documentation. This might be
fine for the simpler tests like basics tests and tree tests but for the
more complex tests, more documentation means easier on-boarding to the
reftable sub-project for newer people as well as ease of maintenance.
This is something that could be worked on during this project.

• Match coding style with rest of the project:

There are parts of reftable’s code not in accordance with Git’s coding
style. As a simple example, this snippet in reftable/basics_test.c
(lines 41-48) doesn’t follow the coding conventions:

if (res < sz) {
	foo;
	if (res > 0) {
		bar;
	}
} else {
	baz;
}

And should be re-written as:

if (res < sz) {
	foo;
	if (res > 0)
		bar;
}
else
	baz;

It should be well worth it to refactor other parts of the tests to align
with Git’s coding standards through this project.

• Increase test coverage:

There may be parts of reftable’s code that are not currently exercised
by the existing tests, or edge cases being overlooked by the current
setup. This could also be improved upon during this project. As an
example, while working on the t-prio-queue migration patch, I discovered
that prio-queue’s reverse stack functionality was not tested by the
existing setup, which I improved upon by adding a new test case to the
prio-queue test in the unit testing framework.

• Other than these, working on the tests might uncover bugs or there might
exist issues within the vicinity of this project that could be worked upon.

Timeline
--------

-----Pre-GSoC (Until May 1)-----

My end-semester examinations take place during this period, so it would
be difficult for me to allocate time to much else. Nevertheless, I wish
to keep working on my [WIP] patches and finish reading the reftable
documentation (link: https://git-scm.com/docs/reftable) during this period.

-----Community Bonding (May 1 - May 26)-----

Continue learning in-depth about the reftable sub-project with the help
of mentors, contribute a few patches related to reftable to familiarize
myself with the code. Finish the first iteration of the test migration
project using the plan outlined prior.

-----Phase I (May 27 - July 11)-----

Polish the new tests in the unit testing framework using the points
mentioned above and mentors’ advice. Send the resulting tests to the
mailing list and work on the feedback received from the community. At
the very least, get the ported tests merged to ‘seen’ before the end of
this period. Continue learning and experimenting with the rest of
reftable’s codebase.

-----Phase II (July 12 - Aug 18)-----

Continue working on refining the tests until merge with ‘master’. If
that is already within sight, focus on extending the reftable tests and
improving documentation. Work on other reftable related tasks in the
vicinity of this project.

-----Final Week (Aug 19 - Aug 26)-----

Finish up the final touches on any of the work done during the project,
this involves ensuring the said work is merged with upstream. Write a
final report on the work accomplished during the project and outline
future goals.

Blogging
--------

I plan on writing weekly blogs on the weekends summarizing my work and
outlining future plans here (link: https://chand-ra.github.io/)
(I have yet to set up the blog). This is because I believe jotting ideas
down help you understand them better while simultaneously serving as a
guiding path for new contributors to get started with the Git project.
I learnt quite a lot from previous intern’s blogs like Shaoxuan Yuan’s
GSoC 2022 Blog (link: https://ffyuanda.github.io/), Shuqi Lang’s GSoC
2023 blog (link: https://cheskaqiqi.github.io/) and Achu Luma’s Outreachy
2023 Blog (link: https://gitlab.com/lumap/lumap.gitlab.io) and plan on
leaving something similar for other newcomers.

Availability
------------

My summertime is reserved for GSoC, so I expect that I can work on the
project 5 days per week, 6 - 8 hours per day, that is 30 - 40 hours a week.
Certainly, something unexpected may arise, but I will try my best to
adhere to this time commitment and be always available through the
community’s mailing list.

Post GSoC & Closing Remarks
---------------------------

When I first started contributing to the Git project in October of 2023,
I had no idea about programs like GSoC. I was advised by a senior of
mine to contribute to open-source projects and hence, my aim of contribution
was to apply what I had learnt in college to solve real-world problems
and learn from more experienced peers. However, most of what I have
contributed to Git has been trivial owing to my lack of skills and
inexperience with the project.

Seeing how I need to do an internship in summer, with GSoC, I hope to be
able to dedicate this internship time and effort to a cool project like
Git while simultaneously learning skills to be able to make more useful
contributions in the future. It’s two birds with one stone. I would also
like to keep contributing to reftable after GSoC and help mentor other
newcomers get started with the Git project.

Thanks & Regards,
Chandra

References
----------

-  The Pro Git book: https://git-scm.com/book/en/v2
-  Git’s reftable documentation: https://git-scm.com/docs/reftable
-  Shaoxuan Yuan’s 2022 GSoC proposal: https://docs.google.com/document/d/1VZq0XGl-wCxECxJamKN9PGVPXaBhszQWV1jaIIvlFjE/edit
