Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA364C6D
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449013; cv=none; b=ikCsNswZexlRe0EuTU8wNDSK6uhOSd3/THgOj7k8CMaMozxhh2HuapHTUDuyS5ugvI63ldS0qHZQtkxMouPsEphmZdbB78sJkQQMTUcc57fLiQ8lOfyAhnhFuYPgiuRHmZrzIpDKvZaswJtwRw1Y7Ct0uoOXe26sOkxHrGy207I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449013; c=relaxed/simple;
	bh=n6rmYtycxtq+JUJwACryeW2zc3I3Vj1SlP39eWMW2JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/f0ThFv3U/WEhJemQYOJfFUENHq5MTkM9CyIoTzFC15IRYwIUtpVo0Nx6qzDi9DcLaCtqzRt0VkZ7Cd7EmdpVbETwlPGdgqeGKZGstUCqom7PtOiMFKoQaxAQOnswldyngFZcT3JNXFIn1N4c2ItPnpYhfbFABiHHhWXACaLvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEGMg2hi; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEGMg2hi"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56c1922096cso2006948a12.0
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 03:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711449010; x=1712053810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2ANBhz3MttM5EL4vDgp/9uuKUKbBNh9N9t7Ogvx/fw=;
        b=VEGMg2hiTXXCpkztUlyuLRThX8p33gPA8xdCs9WfbvIFW7sQloD5CQunhzfOZOu417
         8/kIg8AwZIIr9q5SZ9PJUwJGOZUjDPgXQqaBKeNQnJOcseKe+tztQJolt1fllp7sEAl9
         G++nCaA+TDnr8WIazzdOsOg0/icPTT+OSlPz3t0oU1TzG+33r4bKod7z5+ZEHQoDGpsF
         0nG6DnDnhncaYkY14ArrySMDb7SvBCdJ1snSZmacJ7l36m5V/2mOEttCpVVVu+RAO67L
         z9WWMmuo3bw8zWS2GvvVMnVrWatLl/TK3rAp/cPLg3SxVj/CzRHybZmd9uoMVcNhy/38
         iczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711449010; x=1712053810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2ANBhz3MttM5EL4vDgp/9uuKUKbBNh9N9t7Ogvx/fw=;
        b=ZrOGH/yNBQWDBqZ2Zkw0d4RYIB9rQRArJ/BeSH3Fu/f2kD622LRrNT8EBB/jfjpg3U
         UsWPG3Jl/gFj5wDiC6AOB/URGOw4VQTejrJELR/cmPtqmNwdIEAw2b1fX8kvTnjDqHZg
         c5SYocWYhfVwDpvnhdrXa1RrLQnR1s2n5yEwfUApHwRirIJZb1xFyqLQUrppGBitqhYn
         z7oAKxOgrVFmPMnlYrN6RNk3wkGHqCsUrg6tYS5x4XeMReoxYF4aO2wiCycFATGWLWCR
         bFrYjX4EBhbUOQ00DfMx2MGiEolYoOa+xaOmIlHPSesKqC+DXPs0ZkJxR56FdbVSnu9H
         9rWw==
X-Gm-Message-State: AOJu0Yy3ovDmHvCb/Bb3CRZXZ2DSTUjONmcYsh93gEaa3Psyd/Ord+NO
	HIgjBbIA2gv38zx8bVP52iU+LeqrL3qNJWK8/C0oWJSA+B7TdlTLtnDorTWC2g2YwvUR/MaO8x9
	9CqoIg6YOHmIUG8pO7HPs2Q945Zc=
X-Google-Smtp-Source: AGHT+IF23Q8sjZ/4RV1NqdC/jNZwsmuWov/NPUJ6yuS//smlIZiy2UBLwwoIepc1OftfvY3NL1DaJDOdAvMt4VXiiWY=
X-Received: by 2002:a17:907:7ea7:b0:a47:31c8:81f5 with SMTP id
 qb39-20020a1709077ea700b00a4731c881f5mr711256ejc.47.1711449010197; Tue, 26
 Mar 2024 03:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMbn=B4HDXOAThvAmmyA5GEzG1nnvbGvc4yjpg7FHSHQQ-WQfw@mail.gmail.com>
 <CAP8UFD3qf1MW1PkCh7DvwmNoi51sLq4r0Z=K57OCa65WtorAKw@mail.gmail.com> <CAMbn=B58_KSvkEMEsCnrN6rGL61+qFv9NqcOO8adyU5A37=vjQ@mail.gmail.com>
In-Reply-To: <CAMbn=B58_KSvkEMEsCnrN6rGL61+qFv9NqcOO8adyU5A37=vjQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 26 Mar 2024 11:29:57 +0100
Message-ID: <CAP8UFD1U3j4tf3snk0qcDjHPRKxuaUVZOw7GuCEwAnXb-gRvHQ@mail.gmail.com>
Subject: Re: [GSoC][PROPOSAL v1] Refactor git-bisect(1) to make its state self-contained
To: Aryan Gupta <garyan447@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt [ ]" <ps@pks.im>, karthik nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aryan,

On Thu, Mar 21, 2024 at 2:21=E2=80=AFPM Aryan Gupta <garyan447@gmail.com> w=
rote:

> On Wed, Mar 20, 2024 at 12:06=E2=80=AFPM Christian Couder
> <christian.couder@gmail.com> wrote:

> > On Sat, Mar 16, 2024 at 7:58=E2=80=AFPM Aryan Gupta <garyan447@gmail.co=
m> wrote:

> > > -- About Me --
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > I have been enthusiastic about open source from the very beginning of
> > > my journey as a software developer. I=E2=80=99ve contributed to other
> > > open-source projects, though still a beginner, I=E2=80=99m generally =
familiar
> > > with the process of contribution. The related experiences are all in
> > > the contribution graph on my GitHub profile page [1]. In the ZAP
> > > Project[2] community, I=E2=80=99ve made over 50 PRs [3]. I also parti=
cipated
> > > in the Google Summer of Code 2023 with the OWASP Foundation and
> > > successfully completed it as well [4]. I have contributed to some
> > > other small projects as well on GitHub.
> >
> > It's interesting to know that you have already participated in a GSoC.
> > Is there a single blog post about this or more?
>
> Here it is: https://www.zaproxy.org/blog/2023-09-11-browser-recorder/

I saw that there is one blog post, but I wanted to ask if there are
more blog posts. That's because we ask GSoC contributors to post on
their blog at least every 2 weeks and if possible every week.

> > > -- Strategies for Handling Backward Compatibility --
> > > ---------------------------------------------------------
> > >
> > > 1. Before implementing any changes, a good understanding of how
> > > git-bisect works and how it is structured is very important. So, I
> > > will thoroughly analyze the existing usage patterns of git-bisect and
> > > list down all the potential areas of impact.
> > >
> > > 2. To validate the codebase changes and ensure the stability and the
> > > backward compatibility of git-bisect command. I will write unit tests
> > > for all the required changes.
> >
> > Do you mean unit tests using the new unit test framework in C. Could
> > you show an example?
> >
>
> Not sure about what is the standard way that git uses for writing unit te=
sts.
> Could you tell me a bit about this?

I was just asking if you planned to use the new unit test framework in
C. The "Move existing tests to a unit testing framework" project that
we propose on https://git.github.io/SoC-2024-Ideas/ is about moving
some unit tests to this new unit test framework. Please take a look at
that project to get more information about this subject.

> > > 3. I will also try to create some real scenarios where I will be
> > > manually testing the desired behavior.
> > >
> > > 4. We might also need some regression tests to test some of the
> > > functionality which can't be tested using unit tests.
> >
> > In which test script would you add them?
>
> I will be writing these in bash and will be adding it in a new test case =
file
> inside the git/t directory or maybe in "git\t\t6030-bisect-porcelain.sh"

It's better to always use the Unix notation for paths like
"t/t6030-bisect-porcelain.sh" starting at the root of the repo, rather
than mixing the Unix and Windows notations and adding "git/" before
the root.

> file. I will try mocking a scenario where we have the BISECT_* files avai=
lable
> in the .git directory and then run git bisect using the command line and =
then
> check the expected results.

The t/*.sh test scripts are the right place for end-to-end tests
(sometimes called "black box" tests), but not for unit tests that
would test some C functions. Both unit tests and end-to-end tests
could be regression tests or performance tests.

> > > 4. Adding Tests
> > >     - Through testing for backward compatibility is very very
> > > important so that the changes don=E2=80=99t break the existing change=
s.
> > >
> > > 5. Documenting the changes
> > >     - This might also go side by side if mentors need some weekly
> > > documentation of the tasks done.
> >
> > Tests and documentation should be part of the patches that change the
> > behavior. So it doesn't really make sense to list them separately in
> > the timeline.
>
> Okay. Maybe a blog post could be a part of this?

We ask GSoC contributors to post weekly on their blog, so except for a
final blog post, most of the blogging should be also part of the
regular work.

Thanks for updating your proposal.
