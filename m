Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8124E5223
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710615484; cv=none; b=icTHmBWdMGqgqqgp2b7pWSJMMfKNAfnDcXMATfEgFNlGAzaLLoeKJuSItSykf4nW/fFUsVRr4Kl7wwwQKxIwFUWzYVnO6Gu0/Ib1G1DGM1QeHjBuxeupcWvZCSWysGKFdK2kevcmc/+0wfV/t2ng1ssgZ1B/eJMyv+Rg7wF9k1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710615484; c=relaxed/simple;
	bh=5TggWwFsrVdvAXqUKoIlTHw6XhXi4ffe/i0EI9Z26VU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=asrj+FrVg/+egMWgL4mdYIDaxKm8wu6t+wUXQrkYflCEx8Fj39LOMnEj7A0+IAlTsRSLVvWZ4lU4T0UAawub6W7801RkgagCy5flLMmCOCgAQQ6IbnIhoww9cqD5lnBrYup4aqk6PFZigpEUZwY+Vm83tUfXCQxheIo5bY915UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3c2uVUT; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3c2uVUT"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5684073ab38so5990768a12.0
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710615480; x=1711220280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kkR4UdAoPnV6xlklTcfrw4NzMOJAPOSIlZEAQEYzojU=;
        b=d3c2uVUTK08r8MHMglr68ngsDsC0rV6oKDBwvvPC99UGlu+xPECk14D6yC1eUcY6WY
         iObCrsrZuGccozA9yDsgFTvne/09m8vYAiskg5veCz965HtnidmVEfAZCoiIHLyMODEC
         PKk/VsBmrA8GEk/I+w7u9gN3BV9Wc7bJ4im1ZgxhPyA5yUvs6lT7u4xXsZ7poeOG0FKG
         ToRtEOVCabewp5NmOS+oZ9ZCwJNT2ty/Ksulq6r89NcUxCZouIJi+V+hMOLXABH853rV
         hfkD7FUqJ18LTVxwwfhQLzmZqoSrOufryqKVnis4m3Kb7h4kGFRaAt5Jd744mR7v8vzs
         ndhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710615480; x=1711220280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkR4UdAoPnV6xlklTcfrw4NzMOJAPOSIlZEAQEYzojU=;
        b=b4EMavpqt20wW1LH5UhDDSajaQsq5dPclL0jBtcgBUVgny4LPWo5sVVwgKKWqXjI+t
         M1SNEVARaA5gJ1YlsOhKlA7G0sfNRm1F2rWE3Q3VsqSxKQh3kfpjDXtRtFgwqY4QTv61
         kVMUZUvn66iybFGGQ53cboBdrV2Kms7KfL9CXpX4vV8YI0pzmfAdRStpmuz3OMiYtACp
         A+hzOkvGlno6MnUD8m/7DzhfnsEiH97FhaGK1Ph7g57ORz2VuvtU8VHDTyV84e2mOJK7
         2HLMEwolwgZxpoAnkW/jraHYCiKpI1fQ8Ctmd4emhGIzMwNvqtNjH2S3g9nFVue/aMz9
         b10A==
X-Gm-Message-State: AOJu0Yz/L4Htb54FyTWGZalYDCRTHVhgiW+X8sQMuXGy11BhvCQyHEiv
	QnmA2DR+9Q1P8ayVYjYUIT2DjpyQA14umdWnsFCZoAyUJMf410S5fqBrLyHp1oD0b9DTWfHew/C
	DjDOleRvoaGX9vMToxnAyT/svBo9nO2Ncuitg0A==
X-Google-Smtp-Source: AGHT+IH5sb3PqZMxAa84CTvo6n9krUY1srfLtzTBN5ler8nrlzoNIfEPewsUzkKc87zb6kk0+HP7tMJ98Peq5BCbmbI=
X-Received: by 2002:a05:6402:550b:b0:568:14e4:12a4 with SMTP id
 fi11-20020a056402550b00b0056814e412a4mr8269395edb.11.1710615479985; Sat, 16
 Mar 2024 11:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aryan Gupta <garyan447@gmail.com>
Date: Sat, 16 Mar 2024 19:57:49 +0100
Message-ID: <CAMbn=B4HDXOAThvAmmyA5GEzG1nnvbGvc4yjpg7FHSHQQ-WQfw@mail.gmail.com>
Subject: [GSoC][PROPOSAL v1] Refactor git-bisect(1) to make its state self-contained
To: git@vger.kernel.org
Cc: "Patrick Steinhardt [ ]" <ps@pks.im>, karthik nayak <karthik.188@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone.

I hope you are doing well. I am writing this email to get a review for
my GSoC proposal.

Thanks in advance.

Regards
Aryan

Here it goes:

-- Refactor git-bisect(1) to make its state self-contained --
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

-- Personal Info --
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Full name :     Aryan Gupta
E-mail    :     garyan447@gmail.com
Tel       :     (+91) 7018273899
Education :     Graphic Era University, Dehradun, India
Year      :     Final Year
Major     :     Computer Science and Engineering
GitHub    :     [1]

-- About Me --
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have been enthusiastic about open source from the very beginning of
my journey as a software developer. I=E2=80=99ve contributed to other
open-source projects, though still a beginner, I=E2=80=99m generally famili=
ar
with the process of contribution. The related experiences are all in
the contribution graph on my GitHub profile page [1]. In the ZAP
Project[2] community, I=E2=80=99ve made over 50 PRs [3]. I also participate=
d
in the Google Summer of Code 2023 with the OWASP Foundation and
successfully completed it as well [4]. I have contributed to some
other small projects as well on GitHub.

I came to participate in the Git community this year (around
February). I got myself rather comfortable with the contribution
process by writing, replying, and auditing different sorts of patches
in the community.

With the patches done so far, I=E2=80=99m getting more familiar with the Gi=
t
internals, project structures, commonly used APIs, test suites,
required tech stacks, and coding guidelines. For understanding better
about Git, I read and reread the documentation a few times, including
=E2=80=98MyFirstContribution.txt=E2=80=99, =E2=80=98MyFirstObjectWalk.txt=
=E2=80=99, and =E2=80=98Hacking Git=E2=80=99.
The book Pro Git also helped me to understand the Git internals
better.

Effective communication with mentors is a very important part of
Google Summer of Code Program. I know when to ask the right questions
and I do every possible thing I can do before asking any question.
This trait of mine always proved to be very useful and I believe it
will be really beneficial for me for the completion of this GSoC
project as well.


-- Before GSoC --
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

-- Synopsis --
-----------------------

I=E2=80=99m picking the project idea =E2=80=9CRefactor git-bisect(1) to mak=
e its state
self-contained=E2=80=9D from the SoC 2024 Ideas page [5]. This idea aims to
make git-bisect(1) self-contained. Its difficulty should be medium,
and the expected project size takes somewhere between 175 hours to 350
hours.

The git-bisect(1) command is used to find a commit in a range of
commits that introduced a specific bug. Starting a bisection run
creates a set of state files into the Git repository which record
various different parameters like =E2=80=9C.git/BISECT_START=E2=80=9D. Thes=
e files
look almost like refs due to their names being all-uppercase. This has
led to confusion with the new =E2=80=9Creftable=E2=80=9D backend because it=
 wasn=E2=80=99t
quite clear whether those files are in fact refs or not.

As it turns out they are not refs and should never be treated like
one. Overall, it has been concluded that the way those files are
currently stored is not ideal. Instead of having a proliferation of
files in the Git directory, it was discussed whether the bisect state
should be moved into its own =E2=80=9Cbisect-state=E2=80=9D subdirectory. T=
his would
make it more self-contained and thereby avoid future confusion. It is
also aligned with the sequencer state used by rebases, which is neatly
contained in the =E2=80=9Crebase-apply=E2=80=9D and =E2=80=9Crebase-merge=
=E2=80=9D directories.

The goal of this project would be to realize this change. While
rearchitecting the layout should be comparatively easy to do, the
harder part will be to hash out how to handle backwards compatibility.

-- Benefits to Community --
--------------------------------

By joining the community and working on this idea, I can collaborate
with my mentors and fellow community members to enhance the user
experience for those who use git-bisect(1). Additionally, creating a
clear distinction between the refs and the git-bisect state files
through this project would be highly beneficial for the community.

-- Why? --
-----------------

For me, the biggest question is always why I am doing something. So to
answer why I want to contribute to Git in this Google Summer of Code
is the learning I will get while communicating with the mentors and
the git community. I want to learn as much as I could in this phrase.
Also, I want a kick start to begin my journey of contributing to git
for a long term. Why I chose git was mainly because I wanted to
explore something which is being used by almost every software
developer.

-- Microproject --
------------------------------

- Modernize a test script [6]
  - Status: merged into master
  - Description: Modernize the formatting of the test script to align
with current standards and improve its overall readability.
  - Remarks: This was my first patch in git which helped me to
understand a lot about how the process of submitting a patch and
review works.

-- Other Patches --
----------------------------

Other than the required microproject, I=E2=80=99ve submitted a few other
patches when I stumbled upon potential modifications, these patches
are:

- Zero Count Optimization [7]
  - Status: Under Review
  - Description: Optimize for efficiency using trailing zeros for set
bit iteration
  - Remarks: This was a great learning task. I learned how tiny things
matter and small optimizations might make a big impact on performance.


-- In GSoC --
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

-- Plan --
----------------

What is Git Bisect?

Git Bisect is a git command which helps to find which commit
introduced the bug into the codebase at a faster rate by leveraging
the power of binary search.


The project idea is relatively easy to understand by the description
itself. Git bisect stores some state files such as BISECT_START,
BISECT_FIRST_PARENT etc which looks very similar to the naming
convention used for creating the refs file. Due to this similar naming
convention it sometimes causes unexpected results when these state
files are confused as the ref files.

In order to fix this problem we can create a new ".git/bisect-state"
directory and store all the state files which belong to the
git-bisect(1) command in that directory as proposed by Patrick and
store all the files as follows.


- BISECT_TERMS -> bisect-state/terms
- BISECT_LOG -> bisect-state/log
- BISECT_START -> bisect-state/start
- BISECT_RUN -> bisect-state/run
- BISECT_FIRST_PARENT -> bisect-state/first-parent
- BISECT_ANCESTORS_OK -> bisect-state/ancestors-ok

While the change looks very simple, it actually is. We will just
update all the paths from where these files are being accessed. When I
went through the code of bisect.c file I found that the path is pretty
easy to configure we just need to modify it at a few places. The main
problem is to efficiently handle the backward compatibility and
implement proper test cases to not let the existing things break. I
have already gone through the bisect.c file a couple of times just
reading and trying to understand all the functions and was able to
understand a lot of things about how it works.

-- Challenges with Backward Compatibility --
--------------------------------------------

I plan to implement a migration mechanism that will detect whether the
legacy stat file like BISECT_* are present or not during the
initialization of git bisect. This migration phase will automatically
move these files to the new =E2=80=9C.git/bisect-state=E2=80=9D directory, =
ensuring a
seamless transition for users while maintaining the compatibility with
existing scripts and tools. The biggest challenge is not to let the
existing functionality break.


-- Strategies for Handling Backward Compatibility --
---------------------------------------------------------

1. Before implementing any changes, a good understanding of how
git-bisect works and how it is structured is very important. So, I
will thoroughly analyze the existing usage patterns of git-bisect and
list down all the potential areas of impact.

2. To validate the codebase changes and ensure the stability and the
backward compatibility of git-bisect command. I will write unit tests
for all the required changes.

3. I will also try to create some real scenarios where I will be
manually testing the desired behavior.

4. We might also need some regression tests to test some of the
functionality which can't be tested using unit tests.

Here is a list of a few tests which I am able to think of as of now:

1. Verify correct relocation of state files during initialization.
2. Test compatibility with existing bisect scripts and tools.
3. Validate handling of edge cases, such as empty or corrupted state
files, to prevent unexpected behavior

I am pretty sure I am still missing some of the problems which I may
face in the future but I will figure them out too when they arrive.

-- Timeline --
------------------

I will be starting the project as soon as I receive the confirmation
of my proposal getting selected for GSoC.

Here is a list of phases during the GSoC period for this project.
While these are just the approximations, the actual timeline may vary
because of the review iterations or unpredictable scenarios.

1. Understanding the existing implementation of Bisect command
    - This includes understanding how to test the changes locally
which are made in the bisect command efficiently
    - Get more familiar with the style of writing the code

2. Start working on the task to add the directory
    - Updating all the references wherever these bisect files are used
    - Writing/Updating tests to test all the changes made

3. Start with supporting backward compatibility
    - For this phase what I am thinking is of adding a stage just
after the initialization of git bisect command which will detect if
there exist some files by the name BISECT_* and migrate all those
files into the =E2=80=9C.git/bisect=E2=80=9D directory.

4. Adding Tests
    - Through testing for backward compatibility is very very
important so that the changes don=E2=80=99t break the existing changes.

5. Documenting the changes
    - This might also go side by side if mentors need some weekly
documentation of the tasks done.


-- Availability --
----------------------

I will be able to contribute 2-3 hours on weekdays and minimum 6 hours
on weekends. Which gives me around 22-27 hours per week to work on the
project. I will work till a minimum span of 14 weeks (can be extended)
during the GSoC. I will try my best to keep this time commitment and
be always available through the community=E2=80=99s mailing list. Also, I h=
ave
exams in the first week of June so I will have limited availability
during that period. The project might take somewhere around 175-350
hours.

-- After GSoC --
---------------------

After GSoC I intend to be a part of the community and keep
contributing to the git=E2=80=99s codebase. I eagerly want to learn a lot f=
rom
the git community and enhance my skills. I also see myself making
important contributions to git in the future.

When I first joined the community 2 months ago, the ancient way of
collaborating through a mailing list by sending diff patches was
really puzzling (GitHub was the only means that I knew about for
open-source collaboration). After sending a patch I got a little
comfortable with it and started loving it.

-- Closing remarks --
----------------------------

I am really enthusiastic to contribute to git. I really want to learn
a lot from my mentors and the whole git community. Everyone
contributes using git, why not contribute to git :).

In the end I really want to thank the whole community, especially
Christian and Junio, for their valuable time in reviewing my patches
and guiding me with the problems I faced.

-- References --
---------------------

[1]  Github Link - https://github.com/aryangupta701
[2]  ZAP Project - https://github.com/zaproxy
[3]  Pull Requests -
https://github.com/search?q=3Dorg%3Azaproxy+type%3Apr+sort%3Aupdated-asc++a=
uthor%3Aaryangupta701&type=3Dpullrequests
[4]  GSoC 2023 Project -
https://www.zaproxy.org/blog/2023-09-11-browser-recorder/
[5]  SoC Ideas - https://git.github.io/SoC-2024-Ideas/
[6]  Migrate Test Script -
https://lore.kernel.org/git/pull.1675.v2.git.1709243831190.gitgitgadget@gma=
il.com/T/#t
[7]  Zero Count Optimization-
https://lore.kernel.org/git/20240310162614.62691-2-garyan447@gmail.com/T/#u
[8]  Issue Raised - https://lore.kernel.org/git/Za-gF_Hp_lXViGWw@tanuki/
[9]  Git References -
https://git-scm.com/book/en/v2/Git-Internals-Git-References
[10] Git bisect - https://git-scm.com/docs/git-bisect
[11] Reftables - https://git-scm.com/docs/reftable


Thanks & Regards,
Aryan
