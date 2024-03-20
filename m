Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB843B2A6
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932777; cv=none; b=VOoMf3w7BRpKhMyf/nDuYnPdzfNh57UzCeebyhhdRgSzyOkXfgIaThqny0aLWRJNmy9GGOIt5jvKThylNMkXHOxHZt1nVqlwMWiRW/nNsd323hX/crgnDkQV4eyEs+fpMiQu+k1jvP23avoIJHMlZlRZv1O+p3H9ZmJr3h5djUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932777; c=relaxed/simple;
	bh=oJwYQL9n/ZNjf0H/26o6sH1gLbJlhBFVn0Nv67xJXDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/EgVKPzgJnY0KyDgkz5V4Pb7A7EMwIP8VzUNBW5kWD19YGnoT/jfmjeFjhlgaD4SV7umDlcnhE2RaNbWmDZ8Skuy17qP5MLrBiGdoVZ2dMVQ6Y267Ifb5rH0+EOexs4DIcQc+iuCLr5Fm2gPvJwS10bTF2lrffhU6dv/UerG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mM9NMyvY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM9NMyvY"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so902720966b.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 04:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710932774; x=1711537574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paYV2yOFBQxoY+A22bK2nEtvCM6ulOGX4JOuHiFaqfo=;
        b=mM9NMyvYkjxExZ4tTvOdjtG5h2BR7vwUF1tgG1o6R52lgUo0K76Zbrfn90ThErgr7A
         JhTQQM8doZwK6lvHFFaHNkhgyaPvnpuRlFUGNuxoEYnZwpISa+9kZpGwLxOH52g5MoyI
         0V7zHEsnGsuzlliHcITDWTFemNXL47dQqEt/vcuO1n+JaIrCKX9coYh3ZqwXZ/BaGg7Y
         08ILLWfB8URwJvkxa9sSrYMzZ644IIwgZQPpdC7tfq5BoF5DY+xtVyYubSqJF7hooh0L
         Yt0jWbWDrCND2sjsvl6E1v0x8sfw68SeMoEsj+M7OvtiGBfuRAZ6l5z4X0o2ZhjMwRyX
         heag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710932774; x=1711537574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paYV2yOFBQxoY+A22bK2nEtvCM6ulOGX4JOuHiFaqfo=;
        b=wcoke9TeJtyNZo9eCf393Bp02Uqh49xkItrdbELQ/LqCW3dKyMqCmdAfQfaQ/2WJrR
         cYRjIL+reudB66MUgGtSfPJa+MNR3TJoH25gWHZjCfL8QIvD/p4fTkOqBy/G3KXp/wsN
         n/4jA7V4XuOF5iTtSq6+A/aDpp5/mJJXfcduzyXJcfgMwsxJeiyDUnqSUwyOhP9EeJEU
         ctLOwz1F2RAuH1PNq+bBJ4mRIps8yAoZI4aEzqh4yLXZ2xnrwsYWS6ATg4nCD6ntUWZW
         B1NmRIRtAdESc6qjBXqgla9HQJfX65ns+KWGdLWYaafuhCaz/J9r7Djz1xL4f4Wc9pZ/
         bdbQ==
X-Gm-Message-State: AOJu0YwSRDcou8XU1OtOC2A3hYtHoyfVTMD7oF6CS9GaI8STrmHBIcGy
	D2PwE6jQodoqssBvSMVn+kQpvUoRGOpDBTLb7406cPwgxzB4BnjHP9E8oiYcsMp6TeLHLf+M2Ph
	t/xRJx+BqrdBrKB9Dnwbpw/3jfJY=
X-Google-Smtp-Source: AGHT+IFuICQ2LT6uMS4svAn2GlsrUyohxMTDACeuG5IzY0JckiNOh9KnCGP8HPxGFNvf3gbMMtWk/QM3YoLTkzKuw3o=
X-Received: by 2002:a17:906:c9d4:b0:a46:a712:3972 with SMTP id
 hk20-20020a170906c9d400b00a46a7123972mr3339204ejb.11.1710932773708; Wed, 20
 Mar 2024 04:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMbn=B4HDXOAThvAmmyA5GEzG1nnvbGvc4yjpg7FHSHQQ-WQfw@mail.gmail.com>
In-Reply-To: <CAMbn=B4HDXOAThvAmmyA5GEzG1nnvbGvc4yjpg7FHSHQQ-WQfw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 20 Mar 2024 12:06:00 +0100
Message-ID: <CAP8UFD3qf1MW1PkCh7DvwmNoi51sLq4r0Z=K57OCa65WtorAKw@mail.gmail.com>
Subject: Re: [GSoC][PROPOSAL v1] Refactor git-bisect(1) to make its state self-contained
To: Aryan Gupta <garyan447@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt [ ]" <ps@pks.im>, karthik nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 16, 2024 at 7:58=E2=80=AFPM Aryan Gupta <garyan447@gmail.com> w=
rote:
>
> Hello everyone.
>
> I hope you are doing well. I am writing this email to get a review for
> my GSoC proposal.
>
> Thanks in advance.
>
> Regards
> Aryan
>
> Here it goes:
>
> -- Refactor git-bisect(1) to make its state self-contained --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -- Personal Info --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Full name :     Aryan Gupta
> E-mail    :     garyan447@gmail.com
> Tel       :     (+91) 7018273899
> Education :     Graphic Era University, Dehradun, India
> Year      :     Final Year
> Major     :     Computer Science and Engineering
> GitHub    :     [1]
>
> -- About Me --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I have been enthusiastic about open source from the very beginning of
> my journey as a software developer. I=E2=80=99ve contributed to other
> open-source projects, though still a beginner, I=E2=80=99m generally fami=
liar
> with the process of contribution. The related experiences are all in
> the contribution graph on my GitHub profile page [1]. In the ZAP
> Project[2] community, I=E2=80=99ve made over 50 PRs [3]. I also participa=
ted
> in the Google Summer of Code 2023 with the OWASP Foundation and
> successfully completed it as well [4]. I have contributed to some
> other small projects as well on GitHub.

It's interesting to know that you have already participated in a GSoC.
Is there a single blog post about this or more?

> I came to participate in the Git community this year (around
> February). I got myself rather comfortable with the contribution
> process by writing, replying, and auditing different sorts of patches
> in the community.
>
> With the patches done so far, I=E2=80=99m getting more familiar with the =
Git
> internals, project structures, commonly used APIs, test suites,
> required tech stacks, and coding guidelines. For understanding better
> about Git, I read and reread the documentation a few times, including
> =E2=80=98MyFirstContribution.txt=E2=80=99, =E2=80=98MyFirstObjectWalk.txt=
=E2=80=99, and =E2=80=98Hacking Git=E2=80=99.
> The book Pro Git also helped me to understand the Git internals
> better.
>
> Effective communication with mentors is a very important part of
> Google Summer of Code Program. I know when to ask the right questions
> and I do every possible thing I can do before asking any question.
> This trait of mine always proved to be very useful and I believe it
> will be really beneficial for me for the completion of this GSoC
> project as well.

Ok.

> -- Before GSoC --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -- Synopsis --
> -----------------------
>
> I=E2=80=99m picking the project idea =E2=80=9CRefactor git-bisect(1) to m=
ake its state
> self-contained=E2=80=9D from the SoC 2024 Ideas page [5]. This idea aims =
to
> make git-bisect(1) self-contained. Its difficulty should be medium,
> and the expected project size takes somewhere between 175 hours to 350
> hours.
>
> The git-bisect(1) command is used to find a commit in a range of
> commits that introduced a specific bug. Starting a bisection run
> creates a set of state files into the Git repository which record
> various different parameters like =E2=80=9C.git/BISECT_START=E2=80=9D. Th=
ese files
> look almost like refs due to their names being all-uppercase. This has
> led to confusion with the new =E2=80=9Creftable=E2=80=9D backend because =
it wasn=E2=80=99t
> quite clear whether those files are in fact refs or not.
>
> As it turns out they are not refs and should never be treated like
> one. Overall, it has been concluded that the way those files are
> currently stored is not ideal. Instead of having a proliferation of
> files in the Git directory, it was discussed whether the bisect state
> should be moved into its own =E2=80=9Cbisect-state=E2=80=9D subdirectory.=
 This would
> make it more self-contained and thereby avoid future confusion. It is
> also aligned with the sequencer state used by rebases, which is neatly
> contained in the =E2=80=9Crebase-apply=E2=80=9D and =E2=80=9Crebase-merge=
=E2=80=9D directories.
>
> The goal of this project would be to realize this change. While
> rearchitecting the layout should be comparatively easy to do, the
> harder part will be to hash out how to handle backwards compatibility.

It's Ok to copy the project description, or parts of it, from the idea
page, but please say that you have done so. This way we can just skip
this when we read your proposal.

> -- Benefits to Community --
> --------------------------------
>
> By joining the community and working on this idea, I can collaborate
> with my mentors and fellow community members to enhance the user
> experience for those who use git-bisect(1). Additionally, creating a
> clear distinction between the refs and the git-bisect state files
> through this project would be highly beneficial for the community.
>
> -- Why? --
> -----------------
>
> For me, the biggest question is always why I am doing something. So to
> answer why I want to contribute to Git in this Google Summer of Code
> is the learning I will get while communicating with the mentors and
> the git community. I want to learn as much as I could in this phrase.
> Also, I want a kick start to begin my journey of contributing to git
> for a long term. Why I chose git was mainly because I wanted to
> explore something which is being used by almost every software
> developer.
>
> -- Microproject --
> ------------------------------
>
> - Modernize a test script [6]
>   - Status: merged into master

Please add a link to (or the hash of) the commit that merges your
commit(s) into the master branch.

>   - Description: Modernize the formatting of the test script to align
> with current standards and improve its overall readability.
>   - Remarks: This was my first patch in git which helped me to
> understand a lot about how the process of submitting a patch and
> review works.
>
> -- Other Patches --
> ----------------------------
>
> Other than the required microproject, I=E2=80=99ve submitted a few other
> patches when I stumbled upon potential modifications, these patches
> are:
>
> - Zero Count Optimization [7]
>   - Status: Under Review

Looking at the thread, it seems to me that it has been reviewed and we
are expecting a reroll from you with at least a better commit message.

>   - Description: Optimize for efficiency using trailing zeros for set
> bit iteration
>   - Remarks: This was a great learning task. I learned how tiny things
> matter and small optimizations might make a big impact on performance.
>
>
> -- In GSoC --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -- Plan --
> ----------------
>
> What is Git Bisect?
>
> Git Bisect is a git command which helps to find which commit
> introduced the bug into the codebase at a faster rate by leveraging
> the power of binary search.
>
>
> The project idea is relatively easy to understand by the description
> itself. Git bisect stores some state files such as BISECT_START,
> BISECT_FIRST_PARENT etc which looks very similar to the naming
> convention used for creating the refs file. Due to this similar naming
> convention it sometimes causes unexpected results when these state
> files are confused as the ref files.

I don't think there are unexpected results. I think it's mostly a
clarification, standardization and cleanup issue.

> In order to fix this problem we can create a new ".git/bisect-state"
> directory and store all the state files which belong to the
> git-bisect(1) command in that directory as proposed by Patrick and
> store all the files as follows.
>
>
> - BISECT_TERMS -> bisect-state/terms
> - BISECT_LOG -> bisect-state/log
> - BISECT_START -> bisect-state/start
> - BISECT_RUN -> bisect-state/run
> - BISECT_FIRST_PARENT -> bisect-state/first-parent
> - BISECT_ANCESTORS_OK -> bisect-state/ancestors-ok

Yeah, please link to Patrick's email where he suggests this. And
please clarify what is quoted verbatim from his email. It is Ok to
copy paste from existing emails, but it helps reviewing proposals if
you are clear about this as we can then skip those parts.

> While the change looks very simple, it actually is. We will just
> update all the paths from where these files are being accessed. When I
> went through the code of bisect.c file I found that the path is pretty
> easy to configure we just need to modify it at a few places. The main
> problem is to efficiently handle the backward compatibility and
> implement proper test cases to not let the existing things break. I
> have already gone through the bisect.c file a couple of times just
> reading and trying to understand all the functions and was able to
> understand a lot of things about how it works.

There is "bisect.c" and there is "builtin/bisect.c". Please make it
clearer which file(s) you are talking about. Also code examples of how
you would update things could be useful.

> -- Challenges with Backward Compatibility --
> --------------------------------------------
>
> I plan to implement a migration mechanism that will detect whether the
> legacy stat file like BISECT_* are present or not during the

Maybe: s/stat file/status files/

> initialization of git bisect.

What do you mean by "initialization of git bisect". Does that take
into account the fact that users could upgrade while they are
bisecting? What if they switch back to an older version after
upgrading?

Do you plan to always check for any "BISECT_*" file or would a check
for the "bisect-state" first would help?

> This migration phase will automatically
> move these files to the new =E2=80=9C.git/bisect-state=E2=80=9D directory=
, ensuring a
> seamless transition for users while maintaining the compatibility with
> existing scripts and tools. The biggest challenge is not to let the
> existing functionality break.
>
>
> -- Strategies for Handling Backward Compatibility --
> ---------------------------------------------------------
>
> 1. Before implementing any changes, a good understanding of how
> git-bisect works and how it is structured is very important. So, I
> will thoroughly analyze the existing usage patterns of git-bisect and
> list down all the potential areas of impact.
>
> 2. To validate the codebase changes and ensure the stability and the
> backward compatibility of git-bisect command. I will write unit tests
> for all the required changes.

Do you mean unit tests using the new unit test framework in C. Could
you show an example?

> 3. I will also try to create some real scenarios where I will be
> manually testing the desired behavior.
>
> 4. We might also need some regression tests to test some of the
> functionality which can't be tested using unit tests.

In which test script would you add them?

> Here is a list of a few tests which I am able to think of as of now:
>
> 1. Verify correct relocation of state files during initialization.
> 2. Test compatibility with existing bisect scripts and tools.
> 3. Validate handling of edge cases, such as empty or corrupted state
> files, to prevent unexpected behavior
>
> I am pretty sure I am still missing some of the problems which I may
> face in the future but I will figure them out too when they arrive.
>
> -- Timeline --
> ------------------
>
> I will be starting the project as soon as I receive the confirmation
> of my proposal getting selected for GSoC.
>
> Here is a list of phases during the GSoC period for this project.
> While these are just the approximations, the actual timeline may vary
> because of the review iterations or unpredictable scenarios.
>
> 1. Understanding the existing implementation of Bisect command
>     - This includes understanding how to test the changes locally
> which are made in the bisect command efficiently
>     - Get more familiar with the style of writing the code
>
> 2. Start working on the task to add the directory
>     - Updating all the references wherever these bisect files are used
>     - Writing/Updating tests to test all the changes made
>
> 3. Start with supporting backward compatibility
>     - For this phase what I am thinking is of adding a stage just
> after the initialization of git bisect command which will detect if
> there exist some files by the name BISECT_* and migrate all those
> files into the =E2=80=9C.git/bisect=E2=80=9D directory.
>
> 4. Adding Tests
>     - Through testing for backward compatibility is very very
> important so that the changes don=E2=80=99t break the existing changes.
>
> 5. Documenting the changes
>     - This might also go side by side if mentors need some weekly
> documentation of the tasks done.

Tests and documentation should be part of the patches that change the
behavior. So it doesn't really make sense to list them separately in
the timeline.

> -- Availability --
> ----------------------
>
> I will be able to contribute 2-3 hours on weekdays and minimum 6 hours
> on weekends. Which gives me around 22-27 hours per week to work on the
> project. I will work till a minimum span of 14 weeks (can be extended)
> during the GSoC. I will try my best to keep this time commitment and
> be always available through the community=E2=80=99s mailing list. Also, I=
 have
> exams in the first week of June so I will have limited availability
> during that period. The project might take somewhere around 175-350
> hours.

Thanks for these details related to your availability. As this is your
final year, when are you expecting to graduate?

> -- After GSoC --
> ---------------------
>
> After GSoC I intend to be a part of the community and keep
> contributing to the git=E2=80=99s codebase. I eagerly want to learn a lot=
 from
> the git community and enhance my skills. I also see myself making
> important contributions to git in the future.
>
> When I first joined the community 2 months ago, the ancient way of
> collaborating through a mailing list by sending diff patches was
> really puzzling (GitHub was the only means that I knew about for
> open-source collaboration). After sending a patch I got a little
> comfortable with it and started loving it.
>
> -- Closing remarks --
> ----------------------------
>
> I am really enthusiastic to contribute to git. I really want to learn
> a lot from my mentors and the whole git community. Everyone
> contributes using git, why not contribute to git :).
>
> In the end I really want to thank the whole community, especially
> Christian and Junio, for their valuable time in reviewing my patches
> and guiding me with the problems I faced.

Thanks for your proposal. Please make sure you submit it soon as a pdf
file to the GSoC website. It can then be updated by uploading a new
pdf until the April 2 1800 UTC deadline.
