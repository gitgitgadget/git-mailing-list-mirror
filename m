Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E333547A6F
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711211877; cv=none; b=ssAe6F94ZqTRFrDjqN4+MjCp/iP1olY3EXtU3GHMXucoTElNiDEux4FoNX9kpuh4h0fhNSJL4cq73cbxQtkgfBAm4gT4Vhc2fj2+yat+VBA4r9PF/BrsjIbnMKidGOajbOMUY8sNYUPJhmc9VX5oFQs6qFn3zpbxyniagPADlCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711211877; c=relaxed/simple;
	bh=tRJeBRcN6t5HlaG5KMagnNYT7F/EGcEt0wbtkBLTlNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bq8Wd3FmIlrj/4rkgsqZzujKpB6m5PMvml0dhWyJSam8ebxDVUCQujf2A9cD5sPW+gZAoTJC7ClugkXx4/vy43NKqS1zGsKlZbw6RECYNJ/6muwSIqYCYOZHFS7aMznBr4G3h6BwYZTXU322T+LgRUbfHqkRZoXyByhCoLVotTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbvrCu7Y; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbvrCu7Y"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56c04e23c46so205668a12.2
        for <git@vger.kernel.org>; Sat, 23 Mar 2024 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711211873; x=1711816673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vWO/cb05AZyEGgU5r+XOvyXwL4mqo5ZDOYxkzg3Biw=;
        b=AbvrCu7YpKPUUBuxeX3bMYuQlJ6WZDWl7ZzRjXq5Rqqoh7mLzpYjYdf6MEj6BJj/dB
         1irT0wwJ/s2ORKVcLff5o8qQPePTwABRO481CFbohpEMOkC0+Z5hrTuLcbQ1sEc36swz
         DmMVI20QUgEkl7gZeh2YL0EJC2eAwBawVE5Kkq2W5/nADg8aNBJmYvGbYyg9Xp9bSrWM
         V7m1sJ7CgEjJbBI+kmECoB6OSNQ//QYDZLwSwFwOUeRVh8ppRFhP3BrhgDY0Htzrp9Ee
         x4VULeEm5qmNTjF99fknDXp/SHEOMsjR3kPAAtyYjTQKdbJYut0SJ7DzNds5EUNQ/PMj
         vmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711211873; x=1711816673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vWO/cb05AZyEGgU5r+XOvyXwL4mqo5ZDOYxkzg3Biw=;
        b=A4AS6iuxsT8foLCS02I0YJunpIx8+WWNIPYMZ2N2C05rgdohKdzJXgYapIFpE9iEmh
         sr7Bam8aD+yNIR2FCPYj7nXUPPnotrS57GcJ/n4C0PQiYdPI2i18cyHS9TknkOPX5HC5
         aNB2/hL8YaMxR0V0XLGh+T74nHNE9HvWL4z4LajVo+wL3g0uiYwMGu3mKqBm2Y4nH1hW
         OkKf26dNdZt6bGAfAtJyhUOwXTGiCJnayo8KsGCoQp2+8B30mR2RqDCrJytnM1bojPyX
         yasMmeDFgWkJr5FWRlEqclDFtujXCwAB9Usi4m19TXB/1eLkk271+uspWuIAQQVhuK62
         uCqA==
X-Gm-Message-State: AOJu0Yyzx9ZaKiHja2+RIrwfVPZmzxH1574NQvjPTnlx43CxiaPNmzm7
	SbvV05GvaJonSDH2iwu0dAAGlDrvwLwjpCseR9LakY4J3iFigEayjOQerZm6bF31ZyaVj5U9yvs
	QhUxskOxixO091tsIW/xyz42K6I4=
X-Google-Smtp-Source: AGHT+IGHYpNaXVKAm0MMTgRohSKAMOxB3Ukn6h72eyg70qd0lLdU9abA5nNz1IXpiSuqs9foRlKzxrf1vLw8c92vuQw=
X-Received: by 2002:a50:ab51:0:b0:56b:dcdc:6fad with SMTP id
 t17-20020a50ab51000000b0056bdcdc6fadmr1715309edc.13.1711211872587; Sat, 23
 Mar 2024 09:37:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMbn=B4HDXOAThvAmmyA5GEzG1nnvbGvc4yjpg7FHSHQQ-WQfw@mail.gmail.com>
 <CAP8UFD3qf1MW1PkCh7DvwmNoi51sLq4r0Z=K57OCa65WtorAKw@mail.gmail.com>
In-Reply-To: <CAP8UFD3qf1MW1PkCh7DvwmNoi51sLq4r0Z=K57OCa65WtorAKw@mail.gmail.com>
From: Aryan Gupta <garyan447@gmail.com>
Date: Sat, 23 Mar 2024 17:37:41 +0100
Message-ID: <CAMbn=B6ScMB32uds-OK9uRCfVHy7nx9=J8R9=J8Jink3m38-zQ@mail.gmail.com>
Subject: Re: [GSoC][PROPOSAL v1] Refactor git-bisect(1) to make its state self-contained
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt [ ]" <ps@pks.im>, karthik nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello mentors

Here is the next version of my proposal. I had a problem changing the
subject of the mail while keeping the email in the same thread. So sending
it here only.
Google doc link:
https://docs.google.com/document/d/1MRmGpJeUdrp1HfizyI7p1oSGVuOUQL2WEmV7x6
YZ0Is/edit?usp=3Dsharing

GSoC Proposal V2

*******************************************************
Refactor git-bisect(1) to make its state self-contained
******************************************************


*************
Personal Info
*************

Full name    :     Aryan Gupta
E-mail        :     garyan447@gmail.com
Tel        :     (+91) 7018273899
Education    :     Graphic Era University, Dehradun, India
Year        :     Final Year
Major        :     Computer Science and Engineering
GitHub        :     https://github.com/aryangupta701


********
About Me
********

I have been enthusiastic about open source from the very beginning of my
journey as a software developer. I=E2=80=99ve contributed to other open-sou=
rce
projects, though still a beginner, I=E2=80=99m generally familiar with the =
process
of contribution. The related experiences are all in the contribution graph
on my GitHub profile page[1]. In the ZAP Project[2] community, I=E2=80=99ve=
 made
over 50 PRs[3]. I also participated in the Google Summer of Code 2023 with
the OWASP Foundation and successfully completed it as well (Project Link
[4]). I am still one of the active extended team members to contribute to
the ZAP. I have contributed to some small projects as well on github.

I came to participate in the Git community this year (around February). I
got myself rather comfortable with the contribution process by writing,
replying, and auditing different sorts of patches in the community.

With the patches done so far, I=E2=80=99m getting more familiar with the Gi=
t
internals, project structures, commonly used APIs, test suites, required
tech stacks, and coding guidelines. For understanding better about Git, I
read and reread the documentation a few times, including
=E2=80=98MyFirstContribution.txt=E2=80=99, =E2=80=98MyFirstObjectWalk.txt=
=E2=80=99, and =E2=80=98Hacking Git=E2=80=99. The
book Pro Git also helped me to understand the Git internals better.

Effective communication with mentors is a very important part of Google
Summer of Code Program. I know when to ask the right questions and I do
every possible thing I can do before asking any question. This trait of
mine always proves to be very useful and I believe it will be really
beneficial for me for completing this GSoC project as well.


***********
Before GSoC
***********

Synopsis (copied from the idea lists page)
*****************************************

I=E2=80=99m picking the project idea =E2=80=9CRefactor git-bisect(1) to mak=
e its state
self-contained=E2=80=9D from the SoC 2024 Ideas[5] page. This idea aims to =
make
git-bisect(1) self contained. Its difficulty should be medium, and the
expected project size takes somewhere between 175 hours to 350 hours.

The git-bisect(1) command is used to find a commit in a range of commits
that introduced a specific bug. Starting a bisection run creates a set of
state files into the Git repository which record various different
parameters like =E2=80=9C.git/BISECT_START=E2=80=9D. These files look almos=
t like refs due
to their names being all-uppercase. This has led to confusion with the new
=E2=80=9Creftable=E2=80=9D backend because it wasn=E2=80=99t quite clear wh=
ether those files are
in fact refs or not.

As it turns out they are not refs and should never be treated like one.
Overall, it has been concluded that the way those files are currently
stored is not ideal. Instead of having a proliferation of files in the Git
directory, it was discussed whether the bisect state should be moved into
its own =E2=80=9Cbisect-state=E2=80=9D subdirectory. This would make it mor=
e
self-contained and thereby avoid future confusion. It is also aligned with
the sequencer state used by rebases, which is neatly contained in the
=E2=80=9Crebase-apply=E2=80=9D and =E2=80=9Crebase-merge=E2=80=9D directori=
es.

The goal of this project would be to realize this change. While
rearchitecting the layout should be comparatively easy to do, the harder
part will be to hash out how to handle backwards compatibility.

Benefits to Community
********************

By joining the community and working on this idea, I can collaborate with
my mentors and fellow community members to enhance the user experience for
those who use git-bisect(1). Additionally, creating a clear distinction
between the refs and the git-bisect state files through this project would
be highly beneficial for the community.

Why?
***

For me the biggest question is always why I am doing something. So to
answer why I want to contribute to Git in this Google summer of code is
the learning I will get while communicating with the mentors and the git
community. I was to learn as much as I could in this phrase. Also, I want
a kick start to begin my journey of contributing to git for a long term.
Why I chose git was mainly because I wanted to explore something which is
being used by almost every software developer.

Microproject
***********

Modernize a test script [6]
Status: merged into master (Hash Link [7])
Description: Modernize the formatting of the test script to align with
current
standards and improve its overall readability.
Remarks: This was my first patch in git which helped me to understand a
lot about how the process of submitting a patch and review works.

Other Patches
*************

Other than the required microproject, I=E2=80=99ve submitted a few other pa=
tches
when I stumbled upon potential modifications, these patches are:

Zero Count Optimization [8]
Status: Work in Progress for second version
Description: Optimize for efficiency using trailing zeros for set bit
iteration
Remarks: This was a great learning task. I learned how tiny things matter
and small optimizations might make a big impact on performance.


*******
In GSoC
*******

Plan
****

What is Git Bisect?

Git Bisect is a git command which helps to find which commit introduced
the bug into the codebase at a faster rate by leveraging the power of
binary search.


The project idea is relatively easy to understand by the description
itself. Git bisect stores some state files such as BISECT_START,
BISECT_FIRST_PARENT etc which looks very similar to the naming convention
used for creating the refs file.These files, resembling refs with their
all-uppercase naming convention, have caused confusion, particularly with
the introduction of the new =E2=80=9Creftable=E2=80=9D backend. It's unclea=
r whether these
files are indeed refs. Hence, this project seeks to redefine the storage
approach for these files within the git repository.

In order to fix this problem we can create a new ".git/bisect-state"
directory and store all the state files which belong to the git-bisect(1)
command in that directory as proposed by Patrick (issue link [9]) and
store all the files as follows.



- BISECT_TERMS -> bisect-state/terms
- BISECT_LOG -> bisect-state/log
- BISECT_START -> bisect-state/start
- BISECT_RUN -> bisect-state/run
- BISECT_FIRST_PARENT -> bisect-state/first-parent
- BISECT_ANCESTORS_OK -> bisect-state/ancestors-ok

While the change looks very simple, it actually is. We will just update
all the paths from where these files are being accessed. When I went
through the code of =E2=80=9Cbisect.c=E2=80=9D and =E2=80=9Cbuiltin/bisect.=
c=E2=80=9D files. I found that
the path is pretty easy to configure; we just need to modify it in a few
places. Also, I found that these paths are being used at some other places
as well such as the test files,=E2=80=9Dwt-status.c=E2=80=9D file and a few=
 more. The main
problem is to efficiently handle the backward compatibility and implement
proper test cases to not let the existing things break. I have already
gone through the bisect.c file a couple of times just reading and trying
to understand all the functions and was able to understand a lot of things
about how it works. Here is an example of the code changes which I am
talking about.


    diff --git a/bisect.c b/bisect.c
index 60aae2fe50..d615113c73 100644
--- a/bisect.c
+++ b/bisect.c
@@ -472,13 +472,13 @@ static int read_bisect_refs(void)
        return for_each_ref_in("refs/bisect/"
, register_ref, NULL);
 }

-static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
-static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
-static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
-static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
-static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
-static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
-static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
+static GIT_PATH_FUNC(git_path_bisect_names, "bisect-state/BISECT_NAMES")
+static GIT_PATH_FUNC(git_path_bisect_ancestors_ok,
"bisect-state/BISECT_ANCESTORS_OK")
+static GIT_PATH_FUNC(git_path_bisect_run, "bisect-state/BISECT_RUN")
+static GIT_PATH_FUNC(git_path_bisect_start, "bisect-state/BISECT_START")
+static GIT_PATH_FUNC(git_path_bisect_log, "bisect-state/BISECT_LOG")
+static GIT_PATH_FUNC(git_path_bisect_terms, "bisect-state/BISECT_TERMS")
+static GIT_PATH_FUNC(git_path_bisect_first_parent,
"bisect-state/BISECT_FIRST_PARENT")


Note that this is just an example. I will not be removing the existing
paths instead I will be adding new paths to keep both backward and forward
compatibility. I will update all the writes in state files with both the
paths and all the reads with first a check for bisect_state directory and
then read from bisect state directory if it is present else first migrate
from .git directory and then read.


***************************************
Challenges with Backward Compatibility
***************************************

I plan to implement a migration mechanism that will detect whether the
legacy bisect state directory =E2=80=9Cbisect-state=E2=80=9D is present or =
not during
every access for the state file of git bisect. This migration phase will
automatically copy the state files (BISECT_*) from =E2=80=9C./git=E2=80=9D =
directory to
the new =E2=80=9C.git/bisect-state=E2=80=9D directory, ensuring a seamless =
transition for
users while maintaining the compatibility with existing scripts and tools.
The biggest challenge is not to let the existing functionality break.

Thinking about the scenario that a user can upgrade while bisecting. I
think it won't be enough. So do you think we can add this migration step
every time the bisect state files are accessed. Also to address the issue
of switching back to an older version, we will not delete the older files?
And instead what I am thinking is that we will end up maintaining the
state files at two places one in .git directory and other in
.git/bisect-state.

As a solution for this I think we can start by managing the BISECT_* files
at both the places and at a later stage when we deprecate the current
version of git we can entirely remove the management of BISECT_* files in
the =E2=80=9C.git=E2=80=9D directory. And we can also provide a backward co=
mpatibility
note in the release version note for this to let the user know about the
particular change.

***********************************************
Strategies for Handling Backward Compatibility:
***********************************************

Before implementing any changes, a good understanding of how git-bisect
works and how it is structured is very important. So, I will thoroughly
analyze the existing usage patterns of git-bisect and list down all the
potential areas of impact.

To validate the codebase changes and ensure the stability and the backward
compatibility of git-bisect command. I will write unit tests and
integration tests for all the required changes.

   3. I will also try to create some real scenarios where I will be
manually testing the desired behavior.

   4. We might also need some regression tests to test some of the
functionality which can't be tested using unit tests. I will be writing
these in bash and will be adding it in a new test case file inside the
git/t directory or maybe in the "git\t\t6030-bisect-porcelain.sh" file. I
will try mocking a scenario where we have the BISECT_* files available in
the .git directory and then run git bisect using the command line and then
check the expected results.


Here is a list of a few tests which I am able to think of as of now:

1. Verify correct relocation of state files during initialization.
2. Test compatibility with existing bisect scripts and tools.
3. Validate handling of edge cases, such as empty or corrupted stat files,
to prevent unexpected behavior

I am pretty sure I am still missing some of the problems which I may face
in the future but I will figure them out too when they arrive.


********
Timeline
********

I will be starting the project as soon as I receive the confirmation of my
proposal getting selected for GSoC.


Here is a list of phases during the GSoC period for this project. While
these are just the approximations, actual timeline may vary because of the
review iterations or unpredictable scenarios.

1. Understanding the existing implementation of Bisect command
- This includes understanding how to test the changes locally which are
made in the bisect command efficiently
- Get more familiar with the style of writing the code

2. Start working on the task to add the directory
- Updating all the references wherever these bisect files are used
- Writing/Updating tests to test all the changes made

3. Start with supporting backward compatibility
- For this phase what I am thinking is of adding a stage just after the
initialization of git bisect command which will detect if there exists
some files by the name BISECT_* and migrate all those files into the
=E2=80=9C.git/bisect=E2=80=9D directory.

4. Adding Tests
- Through testing for backward compatibility is very very important so
that the changes don=E2=80=99t break the existing changes.


Availability

I will be able to contribute 2-3 hours on weekdays and minimum 6 hours on
weekends. Which gives me around 22-27 hours per week to work on the
project. I will work till a minimum span of 14 weeks (can be extended)
during the GSoC. I will try my best to keep this time commitment and be
always available through the community=E2=80=99s mailing list. Also, I have=
 exams
in the first week of June so I will have limited availability during that
period. The project might take somewhere around 175-350 hours. I have
taken all the factors into factor including my graduation month which is
July 2024 to calculate the timings I will be able to contribute.

After GSoC

After GSoC I intend to be a part of the community and keep contributing to
the git=E2=80=99s codebase. I eagerly want to learn a lot from the git comm=
unity
and enhance my skills. I also see myself making important contributions to
git in the future.

When I first joined the community 2 months ago, the ancient way of
collaborating through a mailing list by sending diff patches was really
puzzling (GitHub was the only means that I knew about for open-source
collaboration). After sending a patch I got a little comfortable with it
and started loving it.
Closing remarks

I am really enthusiastic to contribute to git. I really want to learn a
lot from my mentors and the whole git community. Everyone contributes
using git, why not contribute to git :).

In the end I really want to thank the whole community, especially
Christian and Junio, for their valuable time in reviewing my patches and
guiding me with the problems I faced.

References

[1]  Github Profile - https://github.com/aryangupta701
[2]  ZAP Project - https://github.com/zaproxy
[3]  Pull Requests -
https://github.com/search?q=3Dorg%3Azaproxy+type%3Apr+sort%3Aupdated-asc++a=
u
thor%3Aaryangupta701&type=3Dpullrequests
[4]  GSoC 2023 Project -
https://www.zaproxy.org/blog/2023-09-11-browser-recorder/
[5]  SoC Ideas - https://git.github.io/SoC-2024-Ideas/
[6]  Migrate Test Script -
https://lore.kernel.org/git/pull.1675.v2.git.1709243831190.gitgitgadget@gm
ail.com/T/#t
[7] Migrate Test Script Hash Link:
https://github.com/gitgitgadget/git/commit/06ac51898156b7bba0a42d36731285e
[8]  Zero Count Optimization-
https://lore.kernel.org/git/20240310162614.62691-2-garyan447@gmail.com/T/#
u
[9]  Issue Raised - https://lore.kernel.org/git/Za-gF_Hp_lXViGWw@tanuki/
[10]  Git References -
https://git-scm.com/book/en/v2/Git-Internals-Git-References
[11] Git bisect - https://git-scm.com/docs/git-bisect
[12]  Reftables - https://git-scm.com/docs/reftable

Thanks & Regards,
Aryan
> Hi,
>
> On Sat, Mar 16, 2024 at 7:58=E2=80=AFPM Aryan Gupta <garyan447@gmail.com>=
 wrote:
> >
> > Hello everyone.
> >
> > I hope you are doing well. I am writing this email to get a review for
> > my GSoC proposal.
> >
> > Thanks in advance.
> >
> > Regards
> > Aryan
> >
> > Here it goes:
> >
> > -- Refactor git-bisect(1) to make its state self-contained --
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -- Personal Info --
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Full name :     Aryan Gupta
> > E-mail    :     garyan447@gmail.com
> > Tel       :     (+91) 7018273899
> > Education :     Graphic Era University, Dehradun, India
> > Year      :     Final Year
> > Major     :     Computer Science and Engineering
> > GitHub    :     [1]
> >
> > -- About Me --
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > I have been enthusiastic about open source from the very beginning of
> > my journey as a software developer. I=E2=80=99ve contributed to other
> > open-source projects, though still a beginner, I=E2=80=99m generally fa=
miliar
> > with the process of contribution. The related experiences are all in
> > the contribution graph on my GitHub profile page [1]. In the ZAP
> > Project[2] community, I=E2=80=99ve made over 50 PRs [3]. I also partici=
pated
> > in the Google Summer of Code 2023 with the OWASP Foundation and
> > successfully completed it as well [4]. I have contributed to some
> > other small projects as well on GitHub.
>
> It's interesting to know that you have already participated in a GSoC.
> Is there a single blog post about this or more?
>
> > I came to participate in the Git community this year (around
> > February). I got myself rather comfortable with the contribution
> > process by writing, replying, and auditing different sorts of patches
> > in the community.
> >
> > With the patches done so far, I=E2=80=99m getting more familiar with th=
e Git
> > internals, project structures, commonly used APIs, test suites,
> > required tech stacks, and coding guidelines. For understanding better
> > about Git, I read and reread the documentation a few times, including
> > =E2=80=98MyFirstContribution.txt=E2=80=99, =E2=80=98MyFirstObjectWalk.t=
xt=E2=80=99, and =E2=80=98Hacking Git=E2=80=99.
> > The book Pro Git also helped me to understand the Git internals
> > better.
> >
> > Effective communication with mentors is a very important part of
> > Google Summer of Code Program. I know when to ask the right questions
> > and I do every possible thing I can do before asking any question.
> > This trait of mine always proved to be very useful and I believe it
> > will be really beneficial for me for the completion of this GSoC
> > project as well.
>
> Ok.
>
> > -- Before GSoC --
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -- Synopsis --
> > -----------------------
> >
> > I=E2=80=99m picking the project idea =E2=80=9CRefactor git-bisect(1) to=
 make its state
> > self-contained=E2=80=9D from the SoC 2024 Ideas page [5]. This idea aim=
s to
> > make git-bisect(1) self-contained. Its difficulty should be medium,
> > and the expected project size takes somewhere between 175 hours to 350
> > hours.
> >
> > The git-bisect(1) command is used to find a commit in a range of
> > commits that introduced a specific bug. Starting a bisection run
> > creates a set of state files into the Git repository which record
> > various different parameters like =E2=80=9C.git/BISECT_START=E2=80=9D. =
These files
> > look almost like refs due to their names being all-uppercase. This has
> > led to confusion with the new =E2=80=9Creftable=E2=80=9D backend becaus=
e it wasn=E2=80=99t
> > quite clear whether those files are in fact refs or not.
> >
> > As it turns out they are not refs and should never be treated like
> > one. Overall, it has been concluded that the way those files are
> > currently stored is not ideal. Instead of having a proliferation of
> > files in the Git directory, it was discussed whether the bisect state
> > should be moved into its own =E2=80=9Cbisect-state=E2=80=9D subdirector=
y. This would
> > make it more self-contained and thereby avoid future confusion. It is
> > also aligned with the sequencer state used by rebases, which is neatly
> > contained in the =E2=80=9Crebase-apply=E2=80=9D and =E2=80=9Crebase-mer=
ge=E2=80=9D directories.
> >
> > The goal of this project would be to realize this change. While
> > rearchitecting the layout should be comparatively easy to do, the
> > harder part will be to hash out how to handle backwards compatibility.
>
> It's Ok to copy the project description, or parts of it, from the idea
> page, but please say that you have done so. This way we can just skip
> this when we read your proposal.
>
> > -- Benefits to Community --
> > --------------------------------
> >
> > By joining the community and working on this idea, I can collaborate
> > with my mentors and fellow community members to enhance the user
> > experience for those who use git-bisect(1). Additionally, creating a
> > clear distinction between the refs and the git-bisect state files
> > through this project would be highly beneficial for the community.
> >
> > -- Why? --
> > -----------------
> >
> > For me, the biggest question is always why I am doing something. So to
> > answer why I want to contribute to Git in this Google Summer of Code
> > is the learning I will get while communicating with the mentors and
> > the git community. I want to learn as much as I could in this phrase.
> > Also, I want a kick start to begin my journey of contributing to git
> > for a long term. Why I chose git was mainly because I wanted to
> > explore something which is being used by almost every software
> > developer.
> >
> > -- Microproject --
> > ------------------------------
> >
> > - Modernize a test script [6]
> >   - Status: merged into master
>
> Please add a link to (or the hash of) the commit that merges your
> commit(s) into the master branch.
>
> >   - Description: Modernize the formatting of the test script to align
> > with current standards and improve its overall readability.
> >   - Remarks: This was my first patch in git which helped me to
> > understand a lot about how the process of submitting a patch and
> > review works.
> >
> > -- Other Patches --
> > ----------------------------
> >
> > Other than the required microproject, I=E2=80=99ve submitted a few othe=
r
> > patches when I stumbled upon potential modifications, these patches
> > are:
> >
> > - Zero Count Optimization [7]
> >   - Status: Under Review
>
> Looking at the thread, it seems to me that it has been reviewed and we
> are expecting a reroll from you with at least a better commit message.
>
> >   - Description: Optimize for efficiency using trailing zeros for set
> > bit iteration
> >   - Remarks: This was a great learning task. I learned how tiny things
> > matter and small optimizations might make a big impact on performance.
> >
> >
> > -- In GSoC --
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -- Plan --
> > ----------------
> >
> > What is Git Bisect?
> >
> > Git Bisect is a git command which helps to find which commit
> > introduced the bug into the codebase at a faster rate by leveraging
> > the power of binary search.
> >
> >
> > The project idea is relatively easy to understand by the description
> > itself. Git bisect stores some state files such as BISECT_START,
> > BISECT_FIRST_PARENT etc which looks very similar to the naming
> > convention used for creating the refs file. Due to this similar naming
> > convention it sometimes causes unexpected results when these state
> > files are confused as the ref files.
>
> I don't think there are unexpected results. I think it's mostly a
> clarification, standardization and cleanup issue.
>
> > In order to fix this problem we can create a new ".git/bisect-state"
> > directory and store all the state files which belong to the
> > git-bisect(1) command in that directory as proposed by Patrick and
> > store all the files as follows.
> >
> >
> > - BISECT_TERMS -> bisect-state/terms
> > - BISECT_LOG -> bisect-state/log
> > - BISECT_START -> bisect-state/start
> > - BISECT_RUN -> bisect-state/run
> > - BISECT_FIRST_PARENT -> bisect-state/first-parent
> > - BISECT_ANCESTORS_OK -> bisect-state/ancestors-ok
>
> Yeah, please link to Patrick's email where he suggests this. And
> please clarify what is quoted verbatim from his email. It is Ok to
> copy paste from existing emails, but it helps reviewing proposals if
> you are clear about this as we can then skip those parts.
>
> > While the change looks very simple, it actually is. We will just
> > update all the paths from where these files are being accessed. When I
> > went through the code of bisect.c file I found that the path is pretty
> > easy to configure we just need to modify it at a few places. The main
> > problem is to efficiently handle the backward compatibility and
> > implement proper test cases to not let the existing things break. I
> > have already gone through the bisect.c file a couple of times just
> > reading and trying to understand all the functions and was able to
> > understand a lot of things about how it works.
>
> There is "bisect.c" and there is "builtin/bisect.c". Please make it
> clearer which file(s) you are talking about. Also code examples of how
> you would update things could be useful.
>
> > -- Challenges with Backward Compatibility --
> > --------------------------------------------
> >
> > I plan to implement a migration mechanism that will detect whether the
> > legacy stat file like BISECT_* are present or not during the
>
> Maybe: s/stat file/status files/
>
> > initialization of git bisect.
>
> What do you mean by "initialization of git bisect". Does that take
> into account the fact that users could upgrade while they are
> bisecting? What if they switch back to an older version after
> upgrading?
>
> Do you plan to always check for any "BISECT_*" file or would a check
> for the "bisect-state" first would help?
>
> > This migration phase will automatically
> > move these files to the new =E2=80=9C.git/bisect-state=E2=80=9D directo=
ry, ensuring a
> > seamless transition for users while maintaining the compatibility with
> > existing scripts and tools. The biggest challenge is not to let the
> > existing functionality break.
> >
> >
> > -- Strategies for Handling Backward Compatibility --
> > ---------------------------------------------------------
> >
> > 1. Before implementing any changes, a good understanding of how
> > git-bisect works and how it is structured is very important. So, I
> > will thoroughly analyze the existing usage patterns of git-bisect and
> > list down all the potential areas of impact.
> >
> > 2. To validate the codebase changes and ensure the stability and the
> > backward compatibility of git-bisect command. I will write unit tests
> > for all the required changes.
>
> Do you mean unit tests using the new unit test framework in C. Could
> you show an example?
>
> > 3. I will also try to create some real scenarios where I will be
> > manually testing the desired behavior.
> >
> > 4. We might also need some regression tests to test some of the
> > functionality which can't be tested using unit tests.
>
> In which test script would you add them?
>
> > Here is a list of a few tests which I am able to think of as of now:
> >
> > 1. Verify correct relocation of state files during initialization.
> > 2. Test compatibility with existing bisect scripts and tools.
> > 3. Validate handling of edge cases, such as empty or corrupted state
> > files, to prevent unexpected behavior
> >
> > I am pretty sure I am still missing some of the problems which I may
> > face in the future but I will figure them out too when they arrive.
> >
> > -- Timeline --
> > ------------------
> >
> > I will be starting the project as soon as I receive the confirmation
> > of my proposal getting selected for GSoC.
> >
> > Here is a list of phases during the GSoC period for this project.
> > While these are just the approximations, the actual timeline may vary
> > because of the review iterations or unpredictable scenarios.
> >
> > 1. Understanding the existing implementation of Bisect command
> >     - This includes understanding how to test the changes locally
> > which are made in the bisect command efficiently
> >     - Get more familiar with the style of writing the code
> >
> > 2. Start working on the task to add the directory
> >     - Updating all the references wherever these bisect files are used
> >     - Writing/Updating tests to test all the changes made
> >
> > 3. Start with supporting backward compatibility
> >     - For this phase what I am thinking is of adding a stage just
> > after the initialization of git bisect command which will detect if
> > there exist some files by the name BISECT_* and migrate all those
> > files into the =E2=80=9C.git/bisect=E2=80=9D directory.
> >
> > 4. Adding Tests
> >     - Through testing for backward compatibility is very very
> > important so that the changes don=E2=80=99t break the existing changes.
> >
> > 5. Documenting the changes
> >     - This might also go side by side if mentors need some weekly
> > documentation of the tasks done.
>
> Tests and documentation should be part of the patches that change the
> behavior. So it doesn't really make sense to list them separately in
> the timeline.
>
> > -- Availability --
> > ----------------------
> >
> > I will be able to contribute 2-3 hours on weekdays and minimum 6 hours
> > on weekends. Which gives me around 22-27 hours per week to work on the
> > project. I will work till a minimum span of 14 weeks (can be extended)
> > during the GSoC. I will try my best to keep this time commitment and
> > be always available through the community=E2=80=99s mailing list. Also,=
 I have
> > exams in the first week of June so I will have limited availability
> > during that period. The project might take somewhere around 175-350
> > hours.
>
> Thanks for these details related to your availability. As this is your
> final year, when are you expecting to graduate?
>
> > -- After GSoC --
> > ---------------------
> >
> > After GSoC I intend to be a part of the community and keep
> > contributing to the git=E2=80=99s codebase. I eagerly want to learn a l=
ot from
> > the git community and enhance my skills. I also see myself making
> > important contributions to git in the future.
> >
> > When I first joined the community 2 months ago, the ancient way of
> > collaborating through a mailing list by sending diff patches was
> > really puzzling (GitHub was the only means that I knew about for
> > open-source collaboration). After sending a patch I got a little
> > comfortable with it and started loving it.
> >
> > -- Closing remarks --
> > ----------------------------
> >
> > I am really enthusiastic to contribute to git. I really want to learn
> > a lot from my mentors and the whole git community. Everyone
> > contributes using git, why not contribute to git :).
> >
> > In the end I really want to thank the whole community, especially
> > Christian and Junio, for their valuable time in reviewing my patches
> > and guiding me with the problems I faced.
>
> Thanks for your proposal. Please make sure you submit it soon as a pdf
> file to the GSoC website. It can then be updated by uploading a new
> pdf until the April 2 1800 UTC deadline.
