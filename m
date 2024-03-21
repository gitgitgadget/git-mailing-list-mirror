Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41251332B8
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052562; cv=none; b=JJYhpkbhswep7fyquLWVCOY8ZfvjPHiqiW2Zw8HvtEHJBHGkKgaTq8PMK5ghA87XIEoC6dEq+wqN+FuSdftbrmj/UsEouWEZMB6YUMqm2gJUsAxMWvHciuKyuGnlfK3TY7/P8HLV8VZFyfb+qHdupaX4Z0jNfrShz/QsuzmOSFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052562; c=relaxed/simple;
	bh=shB5t8UYg+sfFEaJpixF+qG1V4FrLPJrSVwbwDuFMl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbEEVhN2K/nnF8yKHCEIxnfHu1OtuBBc6/WRLUoYgpopPlX1u8r9nKzhW/fs8uLTuwct89qaP/H6TDwxtJ1RT1pIKA0t7IEGeD8HbjlawVJNxoVDbYRYd0t6qpOi/sd1TvFQtqYN7cl98BVNecG6dmSzY3XOFgBjTAOOXNg4xWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVYjIgyr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVYjIgyr"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1def89f0cfdso19208765ad.0
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711052559; x=1711657359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ry3aM+wpBeTttEypAI+xLQ73/DYu4Q1jkDuEPPMO6Po=;
        b=ZVYjIgyrqZOTezhb+0vPlLnbmsySD6oXHEvsmkl9+Y5blURB78Bm5QDHtovOc5W0vV
         HD/Vvv+fvR9m4AvBOHKPJDUvIDzOg7+Mvb7hDinpX2YFEt1eqpXCQmktax/O08fAf9rO
         kn9tYKdd29EqXvFMLGZDsI6cHYdEGR61SE96aCTjw7D7zqOigME/V98lfhDxf2r84Zzd
         h8oKoZoKAcAn9aRZy8ePQkR/gTf9vlkhIZDfxykiZ+H+nVjJ5MPX75VNUd3Eb8uyJiBg
         su9DbFBeoagI12SKDYw2sO51X6wW3oYH7dTZgAxmbDcx9+L27fi14s2SQ2ffN0UPWQam
         08uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711052559; x=1711657359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ry3aM+wpBeTttEypAI+xLQ73/DYu4Q1jkDuEPPMO6Po=;
        b=RiLfvh+lmo3S5mn0gGLdo1pHuAUzVBn61f60E3cca3H6gbxWAXjhLjEp71QRm3Csfw
         GyZI9w6eZitfx317Qw6Ix2Py2ccz2jwig79E90Pi2zF0usCz5lh4IqR/9CHXGT2gHOhj
         AG7Bb6X4U+bOvukiP1V2Kkb07zD7OAyUgqG/N0wiXecM0YesCYGwnNbwoSsMXYJ3nj1K
         isVUv4+BzTYpkQrFD+D7CQAgN98rm4xtWY/W+BSzonkrGno9sp9JakWoab3VLIjfcZDY
         8pcHvU/jPwaXvqH+h/KXB6yIThomMes35a0Q7fL3VFrrhYcKrQBi3CZiuDnNFNootAy5
         z6jA==
X-Gm-Message-State: AOJu0YywuR609HXRC9ltPhJWTfAeH+PYlkNeVLsyItJY01XBYQVCDLHS
	NbBdqQprnw/PP1DTe8Alvz8SMcbFGOcEGxPZJpONbhu7+GJTuYOY/xvmkPmK47PsCg==
X-Google-Smtp-Source: AGHT+IGsRf+CGrPf1e29B0cmrbj1nMZDe0JmQRvJ10AyawMy/6HcwBqj+fGBMuGDZFqCBOupmLiSNQ==
X-Received: by 2002:a17:902:e5c4:b0:1e0:3b2f:7ab2 with SMTP id u4-20020a170902e5c400b001e03b2f7ab2mr95734plf.13.1711052558210;
        Thu, 21 Mar 2024 13:22:38 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b001dd95b5dd0fsm260221plf.69.2024.03.21.13.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 13:22:37 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im,
	karthik.188@gmail.com
Subject: [GSoC][RFC][Proposal v2] Move existing tests to a unit testing framework
Date: Fri, 22 Mar 2024 01:51:49 +0530
Message-ID: <20240321202218.13648-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <CAP8UFD2COoXfDdS1eg5DR_0NL8bOhCHvXUkqkfzLbSejRmgwSw@mail.gmail.com>
References: <CAP8UFD2COoXfDdS1eg5DR_0NL8bOhCHvXUkqkfzLbSejRmgwSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Christian,

Thank you for the review. I have made the changes as per your suggestions.
For your convenience, I have also attached the diff of the changes below.
The web version can be viewed at:
https://docs.google.com/document/d/1wmosedy-UKd_mhAAjccv1qETO1q00s-npYj2m6g-Hd0/edit?usp=sharing

I appreciate any feedback on this proposal.

Thanks.

---
diff --git a/proposal b/proposal
index de751da..6ed42e0 100644
--- a/proposal
+++ b/proposal
@@ -21,7 +21,7 @@ E-mail: shyamthakkar001@gmail.com
 Ph. No.: +91 7990974044
 
 Education: L.D. College of Engineering, Gujarat, India
-Year: IV
+Year: IV (Final Year)
 Degree: Bachelors in Electronics and
         Communications Engineering
 
@@ -34,9 +34,10 @@ Overview
 
 Initially Git used to only rely on shell scripts to test the functionality
 usually deemed to be internal (e.g. libraries, functions etc.) This was achieved
-through t/helper binaries which would take input via stdin and output through
-stdout and the test scripts would consume those outputs. This translation is
-costly due to the following reasons:
+through t/helper binaries which would take input via stdin or we can also invoke
+it from the command line via arguments and output through stdout and the test
+scripts would consume those outputs. This translation is costly due to the
+following reasons:
 
 - Each test script creates a new git repository which is many times not needed.
   See here[1] for example.
@@ -108,7 +109,9 @@ have made, in chronological order:
     This patch added functionality to assume an empty tree when on an unborn
     branch to be able to use ‘restore –staged’. However, this was discontinued
     due to lack of community interest. In hindsight, I think that this would
-    have been an acceptable patch, had I described it well.
+    have been an acceptable patch, had I described it well. However, I might
+    pick this up again during the empty period of present till the start of
+    GSoC.
     Mailing list thread:
     https://lore.kernel.org/git/20240206230357.1097505-2-shyamthakkar001@gmail.com/
 
@@ -250,6 +253,34 @@ per week during the Community Bonding and Coding Phase. This may fluctuate
 depending on the type of test. Some of those tests are already being worked on
 by Achu Luma.
 
+- Tests which might not be suitable for migration:
+  As already mentioned in the Additional Notes section, some tests are not worth
+  migrating. This is because some of these helper binaries provide general
+  purpose utilities which are used in not just unit tests, but used elsewhere
+  as well. An example of that would be test-ref-store.c. Just by grepping for
+  ‘test-tool ref-store’, we can see that it is used in many test scripts which
+  also include end-to-end tests. More examples of these would be test-genzeros
+  and test-genrandom.
+
+- Tests which might be suitable for migration:
+  On the other hand, a suitable candidate for the migration would generally just
+  provide a certain output and that output is compared against an expected
+  value. These would not include utility helpers as mentioned above. In these
+  cases, the test script is usually just a layer to compare the output with the
+  expected value, and has little test related logic in itself.
+  test-example-decorate.c seems like a good straight-forward choice as their
+  “BUG” calls can be replaced by test_msg calls in the new framework and their
+  corresponding if conditions can become checks in the new framework. Also, this
+  helper is not used anywhere besides a single call in t9004. Some more examples
+  would be test-revision-walking.c (t0062), and while 
+  test-{oidmap, oidtree, hashmap}.c can be considered a bit large, those are
+  very similar in nature to what I have already implemented for test-oidarray.c.
+  And the majority of these outlined tests have been stable for a long time and
+  have not had any meaningful change. Therefore, I would like to start with
+  these tests with mentors’ consensus. Some other tests can also be identified
+  with the help of mentors and those can also be done instead of the ones I
+  outlined.
+
 ----Timeline----
 
 Pre-GSoC
@@ -294,8 +325,28 @@ have not setup the blog yet, it will be at:
 ----Availability----
 
 My current semester ends on 30th April and my exam/viva is tentatively on 7th
-May. After that I have freed my summer for GSoC, therefore I will be able to
-give a minimum of 35-40 hours per week.
+Mayand I will graduate after the results are out in June. Therefore I will be
+able to give a minimum of 35-40 hours per week after 7th May as I have not taken
+up any responsibilities in the summer for the purpose of GSoC.
+
+----Stretch Goals----
+
+These goals may not be achieved during the GSoC period, however, these may come
+in handy if the migration is done ahead of the schedule or it is determined that
+the number of tests that need to be migrated are not sufficient to cover the
+allocated GSoC period further down the line. These can also be done after the
+GSoC period. (Note that these are just personal observations/ideas and may not
+be accepted by mentors, hence '_Stretch_ Goals'.)
+- Enhancement of the unit testing library. An example of the need of doing this
+  would be t-ctype, which bypasses top-level macros such as TEST(), in favor of
+  custom logic with the use of internal helper functions.
+- Add more helper functions in the unit testing library such as handling and use
+  of parameters defined by environment variables (which I personally faced in
+  implementing t-oidarray.) I am sure there are other such utilities which might
+  be worthwhile.
+- Adding support for performance related testing through unit tests.
+- Working in other areas of the codebase not related to unit testing or doing
+  other tasks as specified by mentors.
 
 Post-GSoC
 ---------
 

 Here is the full proposal:
-- >8 --
Move existing tests to a unit testing framework

Personal Information
--------------------

Name: Ghanshyam Thakkar
E-mail: shyamthakkar001@gmail.com
Ph. No.: +91 7990974044

Education: L.D. College of Engineering, Gujarat, India
Year: IV (Final Year)
Degree: Bachelors in Electronics and
        Communications Engineering

GitHub: https://github.com/spectre10
Time-zone: UTC +5:30 (IST)


Overview
--------

Initially Git used to only rely on shell scripts to test the functionality
usually deemed to be internal (e.g. libraries, functions etc.) This was achieved
through t/helper binaries which would take input via stdin or we can also invoke
it from the command line via arguments and output through stdout and the test
scripts would consume those outputs. This translation is costly due to the
following reasons:

- Each test script creates a new git repository which is many times not needed.
  See here[1] for example.
- These scripts spawn processes every time they need a certain output. And 
  spawning processes are expensive (especially on windows).
- Difficult setups: sometimes the functions or the libraries we are testing need
  some special setup such as defining flags for custom behavior etc. which
  cannot be done through the shell scripts, hence we might forego testing those
  conditions.

Moving to the unit testing framework would give us many benefits such as
increased runtime performance, and therefore lower test duration and solves all
of the above points. The choice of framework and the rationale behind it is
thoroughly described in Documentation/technical/unit-tests.txt. Therefore, the
goal of this project is to move existing unit tests from t/helper/* and its
corresponding scripts to the new unit testing framework. And there has been work
going on to do this by Outreachy intern Achu Luma.

The expected project difficulty is medium and the expected project size would be
350 hours.


Pre-GSoC
--------
I initially got into Git’s codebase in December, 2023 and started my
contribution journey in January, 2024. I worked on mostly what I found
interesting and within my reach. Following is the list of contributions that I
have made, in chronological order:

- [PATCH v6 0/2] t7501: add tests for --include, --only, --signoff
    Status: merged into master
    Merge Commit: 2be9ccf23e0592b83b78e719574e580e79db0375
    Description:
    This patch series added missing tests for --include, --only and --signoff
    options of git-commit. While working on this patch I accidentally reproduced
    a bug where in an untracked path provided to the commit command with -i
    would not error out. This was noticed by Junio. Therefore, this patch also
    included a TODO comment describing this bug.
    Mailing list thread:
    https://lore.kernel.org/git/20240109060417.1144647-2-shyamthakkar001@gmail.com

- [PATCH v3 1/2] t0024: avoid losing exit status to pipes
    Status: merged into master
    Merge Commit: 40225ba8b494080d7f90dd5e129daa7b11c613d1
    Description:
    Although this was not my first contribution, it was done to fulfill the
    microproject criteria from the list of micro-projects on Git Developer
    Pages. The first patch replaces the pipe to the redirection operator to
    store the output to a temporary file to avoid losing exit status of the git
    commands. And the second patch of the series fixes the style violations to
    adhere to the current standard described in CodingGuidelines.
    Mailing list thread:
    https://lore.kernel.org/git/20240118215407.8609-1-shyamthakkar001@gmail.com/

- [PATCH v6 0/2] add-patch: classify '@' as a synonym for 'HEAD'
    Status: merged into master
    Merge Commit: 65462776c2963b377968e580ace1590238bf79c1
    Description:
    The first patch of this series removed the disparity of command line output
    of using ‘HEAD’ vs ‘@’ in ‘git reset/restore/checkout -p’. And the second
    patch removed the perl prerequisites in the test scripts which use the patch
    mode functionality.
    Mailing list thread:
    https://lore.kernel.org/git/20240128181202.986753-2-shyamthakkar001@gmail.com/

- [PATCH] restore: allow --staged on unborn branch
    Status: Discontinued
    Description:
    This patch added functionality to assume an empty tree when on an unborn
    branch to be able to use ‘restore –staged’. However, this was discontinued
    due to lack of community interest. In hindsight, I think that this would
    have been an acceptable patch, had I described it well. However, I might
    pick this up again during the empty period of present till the start of
    GSoC.
    Mailing list thread:
    https://lore.kernel.org/git/20240206230357.1097505-2-shyamthakkar001@gmail.com/

- [PATCH] unit-tests: convert t/helper/test-oid-array.c to unit-tests
    Status: on hold until GSoC
    Description:
    This was used as a practice patch to the current project proposal. This will
    be used as a reference in the proposal ahead.
    Mailing list thread:
    https://lore.kernel.org/git/20240223193257.9222-1-shyamthakkar001@gmail.com/
 
- [PATCH v2] setup: remove unnecessary variable
    Status: Merged to master
    Merge Commit: 272fd9125aae215ece1c465a4b7d336cf81c3e62
    Description:
    I initially proposed the TODO comment removed through this patch as a
    micro-project for my first patch. However, the TODO comment was a result of
    misunderstanding, therefore this patch did some minor code simplifications
    along with the removal of the TODO comment.
    Mailing list thread:
    https://lore.kernel.org/git/20240304151811.511780-1-shyamthakkar001@gmail.com/

- [PATCH 0/2] commit, add: error out when passing untracked path 
    Status: WIP
    Description:
    This patch series would fix the potential bug discovered in the first patch
    that I sent (--include tests).
	Mailing list thread:
    https://lore.kernel.org/git/20240318155219.494206-2-shyamthakkar001@gmail.com/

- Helped a fellow contributor by reviewing their patches
    Thread links:
    - https://lore.kernel.org/git/CZG3HO25QLAG.3Q9V03SCO99HL@gmail.com/
    - https://lore.kernel.org/git/CZHJPF604DV9.X0A0VX1AB7P8@gmail.com/

Proposed Project
----------------

----What’s unit testing----

Unit testing is a method to test a specific unit of source code (i.e. a
function, a module etc.). This is very helpful in catching all of the corner
cases and possible scenarios.

----Steps to convert the existing unit tests to the new framework----

It can be thought of as a series of steps which are outlined below:
- Identify a suitable candidate from t/helper directory.
- Each t/helper unit test has a corresponding shell script which actually tests
  the output from the binary. Each test-case in that script would ideally become
  a separate function (and therefore a single test-case) in the migrated unit
  test.
- Convert the test logic from the shell script to C. This would involve
  understanding the underlying library/functionality which is being
  tested. Subsequently, make functions which would be ideally be a single
  testcase.
- These functions can be called via the TEST() macro in the cmd_main
  function which is the entry point to the test.
- Each of these functions contains a set of {check(), check_int() etc.} macro
  functions which check the condition provided to them and if it fails, prints
  a message to the stdout. If even a single check fails the whole test-case is
  considered a failure.
- Modify Makefile to add the reference of the new test to the UNIT_TEST_PROGRAMS
  variable.
- The skeleton of the new unit test would look something like this:

    #include "test-lib.h"

    static void testcase_1()
    {
	    ...
	    check(actual == expected);
	    ...
    }

    int cmd_main(int argc, const char **argv)
    {
	    TEST(testcase_1(), "test description");
	    return test_done();
    }

- After the migration remove the references of t/helper/{old-test-helper}.{c, o}
  from the Makefile and from the t/helper/test-tool.{c, h}. And subsequently
  remove the shell script which used to consume the old helper binary.

----Additional Notes along with a Reference Implementation----

These tests usually contain duplicate logic with variations in input and output.
In such cases, we can define macro functions to not duplicate such logic. I.e.
in t-ctype, we can see how a custom macro is defined to avoid duplication of
test logic, with variation only in the input being used. Also, some these
existing tests are not worth migrating. For example, test-tool binaries which
are also used outside of the corresponding shell script (i.e. used in other
tests for setup purposes) would be low on the priority list of possible
migrations.

I have made a reference implementation of t-oid-array.c which migrates
t/helper/test-oid-array.c and t/0064-oid-array.sh to the new framework, which
can be viewed here[2]. Note that the failing tests are not related to my
implementation and rather a known issue[3]. It may or may not to be good enough to
be merged into master, however it sufficiently showcases my abilities to
understand framework, the use of different macros and the ability to understand
different internal libraries and data-structures such oidarray itself.

This implementation was also reviewed by Christian Couder on the mailing list
and I have made some adjustments according to the feedback.

This implementation uses a macro to test the ordered enumeration of oidarray
with different inputs. And also tests the lookup capabilities of oidarray with
different queries and inputs with the help of a macro. There are also various
helper functions defined to help with printing debug output, generating
hexadecimal representations, etc.

----Previous Work----

TAP implementation along with t-basic and t-strbuf:
https://github.com/git/git/commit/e137fe3b

t-mempool: https://github.com/git/git/commit/6cbae640
t-ctype: https://github.com/git/git/commit/e875d451
t-prio-queue: https://github.com/git/git/commit/808b77e5

Achu Luma has been doing this migration as part of Outreachy internship. Their
branches can be seen here[4].

----Goal----

The end goal of this project would be to migrate as many unit tests as possible
according to the steps outlined above. In doing so, also enhance some of the
tests as needed to be extensible such as the ability to test different hash
algorithms on a single oidarray. This enhancement is not yet implemented in the
reference implementation due to the series which enables the use of different
hash algorithms on oidarray not yet merged into master (in next though).

Currently, there are 78 test-*.c files (not including test-tool.c) in t/helper/
directory according to the master branch. Of course, migrating all of them would
be a difficult task in 350 hours, therefore I plan to migrate around 1 unit test
per week during the Community Bonding and Coding Phase. This may fluctuate
depending on the type of test. Some of those tests are already being worked on
by Achu Luma.

- Tests which might not be suitable for migration:
  As already mentioned in the Additional Notes section, some tests are not worth
  migrating. This is because some of these helper binaries provide general
  purpose utilities which are used in not just unit tests, but used elsewhere
  as well. An example of that would be test-ref-store.c. Just by grepping for
  ‘test-tool ref-store’, we can see that it is used in many test scripts which
  also include end-to-end tests. More examples of these would be test-genzeros
  and test-genrandom.

- Tests which might be suitable for migration:
  On the other hand, a suitable candidate for the migration would generally just
  provide a certain output and that output is compared against an expected
  value. These would not include utility helpers as mentioned above. In these
  cases, the test script is usually just a layer to compare the output with the
  expected value, and has little test related logic in itself.
  test-example-decorate.c seems like a good straight-forward choice as their
  “BUG” calls can be replaced by test_msg calls in the new framework and their
  corresponding if conditions can become checks in the new framework. Also, this
  helper is not used anywhere besides a single call in t9004. Some more examples
  would be test-revision-walking.c (t0062), and while 
  test-{oidmap, oidtree, hashmap}.c can be considered a bit large, those are
  very similar in nature to what I have already implemented for test-oidarray.c.
  And the majority of these outlined tests have been stable for a long time and
  have not had any meaningful change. Therefore, I would like to start with
  these tests with mentors’ consensus. Some other tests can also be identified
  with the help of mentors and those can also be done instead of the ones I
  outlined.

----Timeline----

Pre-GSoC
(Until May 1)
- Continue to work on different things like solving the bug discovered in the
  first patch series that I sent. Be engaged in the community.

Community Bonding
(May 1 - May 26)
- Talk with mentors and identify the tests which are suitable for migration.
  Learn the libraries which are used for those tests and read up on the API.
  Look at Achu Luma’s branches to further familiarize myself with the migration
  process. Start the migration early with the mentors’ permission.
  
Phase I
(May 27 - July 11)
- Continue implementing the tests in the unit testing framework with the
  guidance of mentors and send out patches to the mailing list for community
  approval. Approximately 6-7 tests would be done/cooking for migration at
  the end of this Phase.

Phase II
(July 12 - Aug 18)
- Continue the migration and talk with the mentors about the pace, quality of
  patches and seek feedback. And enjoy the process. Another 5-6 tests would be
  done/cooking at the end of this Phase.
  
Final Week
(Aug 19 - Aug 26)
- Finish up any remaining tests.
- Fix any bugs and some final touches.
- Make a final report about the work accomplished and outline future work.

----Blogging----

I believe that writing about one’s work helps them track their progress from a
bird’s eye view. And also helps them realize if they are making mistakes from a
long term perspective. I plan to blog about the progress bi-weekly. Although I
have not setup the blog yet, it will be at:
                        https://spectre10.github.io
 
----Availability----

My current semester ends on 30th April and my exam/viva is tentatively on 7th
Mayand I will graduate after the results are out in June. Therefore I will be
able to give a minimum of 35-40 hours per week after 7th May as I have not taken
up any responsibilities in the summer for the purpose of GSoC.

----Stretch Goals----

These goals may not be achieved during the GSoC period, however, these may come
in handy if the migration is done ahead of the schedule or it is determined that
the number of tests that need to be migrated are not sufficient to cover the
allocated GSoC period further down the line. These can also be done after the
GSoC period. (Note that these are just personal observations/ideas and may not
be accepted by mentors, hence '_Stretch_ Goals'.)
- Enhancement of the unit testing library. An example of the need of doing this
  would be t-ctype, which bypasses top-level macros such as TEST(), in favor of
  custom logic with the use of internal helper functions.
- Add more helper functions in the unit testing library such as handling and use
  of parameters defined by environment variables (which I personally faced in
  implementing t-oidarray.) I am sure there are other such utilities which might
  be worthwhile.
- Adding support for performance related testing through unit tests.
- Working in other areas of the codebase not related to unit testing or doing
  other tasks as specified by mentors.

Post-GSoC
---------

The Git Community has helped me very much and tolerated my beginner mistakes.
I have grown as a developer since I started contributing to Git. I learned the
importance of writing good commit messages, benefits of splitting up patches,
effective programming style and good communication etiquettes. Therefore, I plan
to be involved even after my GSoC journey ends. I am very much involved in the
Git ecosystem and also contribute to another project in the Git ecosystem called
gittuf[5]. Also post-gsoc, I am planning to help out in aggregating for Git Rev
News, which I personally enjoy reading.

My Appreciation
---------------

I would like extend my thanks to all of the folks on the mailing list and
Discord who have helped me in contributing to the Git Project including Junio,
Christian Couder, Phillip Wood, Elijah Newren and many others. And I have also
taken some references of Achu Luma’s work for this proposal, so thanks to
her, too.

Thanks & Regards,
Ghanshyam

References:
[1], [2]: https://github.com/spectre10/git/commit/9bfbb22ced3c4d15a215a84aa40043a30dc1bac0
[3]: https://lore.kernel.org/git/20240318090848.GC602575@coredump.intra.peff.net/T/#mc32405849ac4265ad36670480709d744f1d9e495
[4]: https://github.com/achluma/git/branches
[5]: https://github.com/gittuf/gittuf

