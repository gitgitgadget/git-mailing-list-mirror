Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BD058AA8
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027309; cv=none; b=guc32pZ+UtHpfwB+q6RCYeZOCmDzP14VbzY+JPY2Aw1gAAZTZicUAIRd+dcN2nyy5odMEa1LOT2vOn0a4jM7eae8faXfP0/R7or7WXD0VaG+S+KrZzgl7YoweveartlHqhwLbIZW7aX3N1gCWav7rmqPWsJD+BXlPQN7lLJxCFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027309; c=relaxed/simple;
	bh=wIR4StQgsj1J6J3t3Rhnjlgta1NMp3lpJIn+vulvAdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvODZ/WQzgeFFQKUaSJhB5CikQE5sP+ZXMG0QZcPEC6/fSMpNFqaq1EKjlTXWV6w0FNQQZlMnn3n17jPWPQWVrOb/jK+qPBQG2Q2WLUfvGl6CV99o4152csBmSdhF7/zwu8aBjksXEq5F8aZnKRaIf7d7tbvm5XA/h0ax36XCr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh9CgaTb; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh9CgaTb"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5688eaf1165so1346424a12.1
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 06:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711027305; x=1711632105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cj91fFnwZIm0EwPCjkjjGmJGXRf6shfPeLVBVW30w4=;
        b=Gh9CgaTbba+6bFZIXSIw+5yCKyWX5RgndiU2gljqGwRQj+x5Y/pqKqtz1OY5d1yxTS
         lAcsDz59a5f5SLIyr6BcuUS7lRPhSprzvKn0sfRt2iSYVk003QXVNN3j4wL9/UEvwmVa
         9nmixAQExdY2BqWkurZXwcXlwzDPjvtLxxsPElvX0D3WHP7F55FOTlSiCUqYLupYFhhz
         u7eADpWZE0tT/H6HIQOxjsc/Y2OyzFPuF4yGG7rOrWdYurZluaMdOH9V3fkONdWR/R8/
         XIYxIf0/P9jyRHTEJ7P2XY1wJ8Z8j15g/ARJzasuSzD95NDvWB+JEdnscD+L0z3ToTvf
         XLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711027305; x=1711632105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cj91fFnwZIm0EwPCjkjjGmJGXRf6shfPeLVBVW30w4=;
        b=hMOqWVh3pt5Gq9mh3A8HYuy3GC6pkHKVyrKIAidwt1X/zlVTRtgRKQ6y6AshgcZq/F
         EuOJtYBCeQYQoyfOSmmCMQzB8jXoohbd9+pv82fKjJz+WakadKzTWEZiFFMF8AilvXUE
         +uGvafWUcXpIv6TxvWe8j5fXxoToyGTzSzd+VpSSQ/Q7tDWpwML7a4cvkMZCj2O/Yx3j
         x4qKISUDi0DADARqQOghkDXCwcvH3I6oThvF9hRT1o09RZsT+PYTEdgNlydmHGQ2oCwk
         1zLnKIEn+2tkDMT3psNJfADLH7WF8mwymeVNz7awEXLe4uVtR1LP6MUJ8YL/NxY32EHN
         CG1A==
X-Gm-Message-State: AOJu0YxAhEKQuQXO/sSYkm+Hrx7vfV6Jg3wYPv6fBEyjE43HeKUVJ1dG
	IYqwOovfRvPbsVedJdDAFLuW5gT9IARFitF/E6RXSg0we2T6BsG3tPwPqik25IQAwj2uUh8sJgo
	kFylpY+X6lBy6ITnLtTsw+6e7z3c=
X-Google-Smtp-Source: AGHT+IFR3ghiCbbe9jUEXE21w4hwQWrlt6YPO1TVg/iGt3BUebR+ybRHk9NxEeFY7cL8/rv505uwcf6J0d3p4cusB2g=
X-Received: by 2002:a05:6402:1f4a:b0:568:cdf3:5cb2 with SMTP id
 10-20020a0564021f4a00b00568cdf35cb2mr7117346edz.30.1711027304638; Thu, 21 Mar
 2024 06:21:44 -0700 (PDT)
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
Date: Thu, 21 Mar 2024 14:21:33 +0100
Message-ID: <CAMbn=B58_KSvkEMEsCnrN6rGL61+qFv9NqcOO8adyU5A37=vjQ@mail.gmail.com>
Subject: Re: [GSoC][PROPOSAL v1] Refactor git-bisect(1) to make its state self-contained
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt [ ]" <ps@pks.im>, karthik nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Christian

Thank you for reviewing the proposal.

On Wed, Mar 20, 2024 at 12:06=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
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

Here it is: https://www.zaproxy.org/blog/2023-09-11-browser-recorder/

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
> > self-contained=E2=80=9D from the SoC 2024 Ideasb page [5]. This idea ai=
ms to
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
Okay.

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
Here it is: https://github.com/gitgitgadget/git/commit/06ac51898156b7bba0a4=
2d36731285ec3c1975aa
will add it the next version as well.
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

Yeah I am still working on the task which Junio suggested to me to do,
which is to only use the builtin function if there is support for it
on the machine.
.
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

Okay. Thank you for the clarification.
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
Okay sure.

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
I am talking about "bisect.c" here. But this path update needs to be
done in both of the files i.e. "bisect.c" and "builtin/bisect.c" as shown
below. Also, As I again went through the codebase I found that these
paths are being used at some other places as well such as the test files,
wt-status.c file and a few more.

diff --git a/bisect.c b/bisect.c
index 60aae2fe50..d615113c73 100644
--- a/bisect.c
+++ b/bisect.c
@@ -472,13 +472,13 @@ static int read_bisect_refs(void)
        return for_each_ref_in("refs/bisect/", register_ref, NULL);
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

Note that this is just an example I will not be removing the existing paths
instead I will be adding new paths to keep both backward and forward
compatibility. I will update all the writes in state files with both the pa=
ths
and all the reads with first a check for bisect_state directory and then
read from bisect state directory if it is present else first migrate from
.git directory and then read.

> > -- Challenges with Backward Compatibility --
> > --------------------------------------------
> >
> > I plan to implement a migration mechanism that will detect whether the
> > legacy stat file like BISECT_* are present or not during the
>
> Maybe: s/stat file/status files/
>
Oops, I mean state files used to store bisect state which can be find in
.git directory

> > initialization of git bisect.
>
> What do you mean by "initialization of git bisect". Does that take
> into account the fact that users could upgrade while they are
> bisecting? What if they switch back to an older version after
> upgrading?
>

"Initialization" for now is an abstract concept for me in my mind,
which I think is the phase just after when the git bisect command
is run by the user and before the actual execution of git bisect. But
thinking about the scenario that a user can upgrade while bisecting.
I think it won't be enough. So do you think we can add this migration
step every time the bisect state files are accessed. Also to address
the issue of switching back to an older version, we will not delete
the older files? And instead what I am thinking is that we will end up
maintaining the state files at two places one in .git directory and other
in .git/bisect-state.

And do you have a solution for when we will be able to completely
remove the state files in the .git directory?

> Do you plan to always check for any "BISECT_*" file or would a check
> for the "bisect-state" first would help?
>

I think checking for bisect-state will be better because we will be maintai=
ning
the files in both the directories.

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

Not sure about what is the standard way that git uses for writing unit test=
s.
Could you tell me a bit about this?

> > 3. I will also try to create some real scenarios where I will be
> > manually testing the desired behavior.
> >
> > 4. We might also need some regression tests to test some of the
> > functionality which can't be tested using unit tests.
>
> In which test script would you add them?

I will be writing these in bash and will be adding it in a new test case fi=
le
inside the git/t directory or maybe in "git\t\t6030-bisect-porcelain.sh"
file. I will try mocking a scenario where we have the BISECT_* files availa=
ble
in the .git directory and then run git bisect using the command line and th=
en
check the expected results.

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

Okay. Maybe a blog post could be a part of this?

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

I will be graduating in July this year.

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

Okay. Sure, I will share an updated proposal as soon as possible.
