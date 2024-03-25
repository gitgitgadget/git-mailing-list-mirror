Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9625C902
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 11:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364473; cv=none; b=Scq6N7pZDrVnPHOq3K4TwNNaIN2ceojKPuR0y8Lv+/8DvL736gUwqixLueFUxgKHOrNbtnvM4olDH7nzmaxokp9+oDv6Z3OazL6Hw+EY9dfkAN9A76dXpIxOdArn3D1mCNqy3zhAKxHye0lu+8XSC1xpdXOy5NOlWsw+vaEzd6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364473; c=relaxed/simple;
	bh=ASnKz4nYWZ53Sq1KX10ASvApkmWdXNd6Bdq3f9vqyso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8gK7cFMKM/vlbjKvWk5aGtzH7AcvBfFUyz3OY5vj+2gQUpI5+Obx2flODrLhKtaIzUwgQppMm1PFqGv4QOK3s3KEZ6OWeagfetFuLm6ieY1CdlxUAQkA4lhRoJr/RU2OGsPJAVXZqH0mzH/oo6d8IxHmmzMdk54CMG/PxCh3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRcIKuNL; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRcIKuNL"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso4218466276.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 04:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711364470; x=1711969270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXDH6RdCI/T+rPpmOjkUsWZCrnNGCIqz0XLJrkc9md0=;
        b=QRcIKuNL1rTSQQQX9G2kV/xNlvE1yM4EU9x9orm1gl1D2s+epZDX4vsHrNqzQsYNjX
         HsFoC3b/gQu2KIa1LoI8fhz6k0v6ZtfOhGEBGXRzuxtwEYMxLa5W77wVIsZiTC6s5My8
         k10qBMtx+WgMfshb4o3O5AIxfro/ER//eA2iQti7QOBveddQqFr4+s1lRmjytReaB23S
         YaXL77sVQfdr7EYcwg2U4f6YErXNfRS8mPDtoFNjaL/hlAsj0EgtjyyxmkbKMK60qJ4F
         9knnUMAAhG04lWredrmc0j8QdEJMTSgDaY79karY6ht0TO71+3lsWEhYjw4/6gtvgn5w
         8ANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711364470; x=1711969270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXDH6RdCI/T+rPpmOjkUsWZCrnNGCIqz0XLJrkc9md0=;
        b=tu7yIYVeO88zD1vX4L0vDH5N+bseG2tZzWbKExxWCJmJy6S4cgmuwA1noYGEhcEMvl
         CLxVTd5sC/ZEHw2BqQshRvPCtm6rCgZVRHsKIqIPhR3ZaghzNZ64tceqi3gVUhPyO+jN
         JaBgpEM6uYfauqKi5IIA52AaK58Vy0OtnYK+G5ZdCfmeJDxSMzqazajHiOL9QVAgPbmw
         UIriDUMN0FLVc6r3qH0349IobtTtHGKnuIHFdAXxm4peflS0lvcgLhkjrKq7TilVxUVT
         MYO0pvNQ8AMCpoYPJ/WddcR4kX9PVHwh1KwlBAOLMUSOPV6blLWwRkI5Nl+stUVUbtiS
         cItg==
X-Gm-Message-State: AOJu0YyKc+R7FAwzPPVVQeHzuGJs1LciWrkFHRxi7o0ndATenHF/YXnd
	/oB8LZYZ63dRMFbU0VPtqJF5XdohYILjVMyvdk5A/0C8+J/80JaMybdnfxXWLgXjMG9N0Ed89uL
	RzQglJohzkLzLvph/k6d/z1AtVVa+V+JKFfT4fA==
X-Google-Smtp-Source: AGHT+IFf6kRtrlBdVfJY5meQg0wGTT2a5XG5VQLi1CsLeyvMg8CLtQWwcYGion69yljhU6sWLl03Tncy0gi7fJUvBsE=
X-Received: by 2002:a25:d88c:0:b0:dcd:2aa3:d73b with SMTP id
 p134-20020a25d88c000000b00dcd2aa3d73bmr4524003ybg.50.1711364469434; Mon, 25
 Mar 2024 04:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJh0PS_VB8yv7B1uM5+Ts9PtMFtU5mL4y8UUDORKQcYHSoxPA@mail.gmail.com>
 <ZgE1fxIFFQIdtIyN@tanuki>
In-Reply-To: <ZgE1fxIFFQIdtIyN@tanuki>
From: eugenio gigante <giganteeugenio2@gmail.com>
Date: Mon, 25 Mar 2024 12:00:58 +0100
Message-ID: <CAFJh0PTxhDSW1qsnVRrDxmMnp5k16nPGe6RAgrmWow0rgYV+dw@mail.gmail.com>
Subject: Re: [RFC][GSoC] Proposal: Refactor git-bisect(1)
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> To further stress the point: the biggest challenge of this project is
> indeed to find an agreement with the community whether this refactoring
> will ultimately be worth it. This will require some good arguing on your
> part why exactly you think this is fine and how exactly this will
> interact with other implementations of Git like libgit2/JGit/Dulwich. It
> may very well happen that ultimately the community decides that this
> whole endeavour is not worth it.

Yeah, I'll try to expand a bit in this direction. Meanwhile, if you think
there are others tools to look into, besides the already cited
(libgit2/JGit/Dulwich),
like UI interfaces or something else, please let me know.
(Maybe GitLab is something to keep in mind?)

> I don't think that the unit testing framework would be a good fit. The
> intent of that new framework is mostly to test low-level functionality
> that otherwise cannot be easily tested. But here it should actually be
> quite easy to test things as part of our regular integration-style tests
> in "t/t*.sh", so it would be preferable to write those instead.

Oh ok, I thought the testing framework should have been used for all tests.
I'll change that.

> Thanks for your proposal. Please make sure you submit it as a PDF file
> to the GSoC website soonish, unless you already did that.

Thanks for the review!

Il giorno lun 25 mar 2024 alle ore 09:27 Patrick Steinhardt
<ps@pks.im> ha scritto:
>
> On Fri, Mar 22, 2024 at 11:26:48AM +0100, eugenio gigante wrote:
> > Hi all, this is my proposal for the GSoC 2024.
> >
> > -----------------------------------------------------------------------=
-----------------------------
> >
> > Refactor git-bisect(1) to make its state self-contained
> >
> > Contacts
> > -------------------
> >
> > Full Name: Eugenio Gigante
> > Email: giganteeugenio2@gmail.com
> > Github: www.github.com/EuGig
> >
> >
> > Synopsis
> > ------------
> >
> > The git-bisect(1) tool is employed to pinpoint the exact commit within =
a
> > series of commits that introduced a particular bug. When initiating a
> > bisection session,
> > it generates a collection of state files within the Git repository,
> > documenting diverse
> > parameters such as ".git/BISECT_START". Instead of having different
> > files scattered
> > in the =E2=80=98.git=E2=80=99 directory, it has been suggested by Patri=
ck to introduce
> > a new =E2=80=98.git/bisect-state=E2=80=99
> > directory which will contain the state files
> > (https://lore.kernel.org/git/Za-gF_Hp_lXViGWw@tanuki/).
> > The aim of the project is to implement this new layout for storing
> > git-bisect(1) related files.
> > The project will also handle backward compatibility issues that may
> > arise with such a change.
> > This is one of the project ideas suggested by the community of Git.
> > The difficulty for the project should be medium and it should take
> > somewhat between 175 to 350 hours.
> >
> >
> > Contributions
> > -------------------
> >
> > add.c: use unsigned integral type for collection of bits
> > (https://lore.kernel.org/git/20240224112638.72257-2-giganteeugenio2@gma=
il.com/)
> >
> >
> > Description:
> >
> > Since the MSB of signed integral type=E2=80=99 is special, =E2=80=98fla=
gs=E2=80=99 fields should be
> > declared of type =E2=80=98unsigned integral=E2=80=99. builtin/add.c:ref=
resh() declares
> > 'flags' as signed,
> > and uses it  to call refresh_index() that expects an unsigned value.
> > Fix this by modifying its type =E2=80=98unsigned int=E2=80=99.
> >
> > Although the code was easy, this patch gave me the opportunity to get
> > familiar with
> > the process of submitting patches. The lesson learned was not only
> > about understanding
> > git commands for formatting and sending patches to the mailing list;
> > but, most importantly,
> > was about how to interact with the community; i. e., how to interact
> > with reviewers,
> > to ask them questions and give them answers. That is why I chose a
> > micro-project idea
> > that explicitly required interaction with the community, before
> > writing any code.
> >
> > Status:
> >
> > Merged to master on: Thu Mar 7 15:59:41 2024
> > commit f46a3f143eba661b9eb2b1e741447d6709eb6e90
> >
> >
> > Deliverables
> > ------------------
> >
> > As soon as the acceptance to the program is communicated, I will start =
writing a
> > sort of Backlog of required changes which has to be shared with mentors=
.
> > This has the goal of better tracking progress and possible issues.
> > Already individuated changes and possible strategies are considered in
> > what follows:
> >
> > 1. First, one needs to inspect the possible impacts such a change could=
 have
> > regarding Backward compatibility. There will be two possible situations=
 in which
> > backward compatibility breaks:
> >
> > a. (Noted by Junio (https://lore.kernel.org/git/xmqqwms0ndvu.fsf@gitste=
r.g/)).
> > People switch versions in the middle of a git-bisect session. Even
> > though I think this
> > case would not be that common, one should take this into consideration
> > nonetheless.
> >
> > b. (Noted by Patrick (https://lore.kernel.org/git/ZbDPqOnyLw4yhu--@tanu=
ki/)).
> > Different implementations of Git could suffer backward
> > incompatibilities like Libgit2,
> > JGit and Dulwich. In this case, I will investigate if (and how) these
> > tools would suffer the change.
> >
> > In this phase it is important to find an agreement with the community
> > if the refactoring
> > would be worth it, and in case it is, to find the best solution to
> > guarantee backward compatibility.
> > The simplest way seems to be to teach Git how to recognise the old
> > style layout and move
> > the files by following the new one. This can be achieved by checking
> > the presence of state files
> > inside =E2=80=98.git=E2=80=99, just after the starting of a bisect sess=
ion and by
> > moving them accordingly.
>
> To further stress the point: the biggest challenge of this project is
> indeed to find an agreement with the community whether this refactoring
> will ultimately be worth it. This will require some good arguing on your
> part why exactly you think this is fine and how exactly this will
> interact with other implementations of Git like libgit2/JGit/Dulwich. It
> may very well happen that ultimately the community decides that this
> whole endeavour is not worth it.
>
> > 2. After a strategy for backward compatibility is decided, I will
> > refactor the directory
> > where all the file states are created. This is done by changing the
> > function factory
> > =E2=80=98GIT_PATH_FUNC=E2=80=99 in =E2=80=98builtin/bisect.c=E2=80=98=
=E2=80=99. The following is an example
> > for =E2=80=98BISECT_START=E2=80=99:
> >
> > - #static GIT_PATH_FUNC(git_path_bisect_start, =E2=80=9CBISECT_START=E2=
=80=9D)
> > + #static GIT_PATH_FUNC(git_path_bisect_start, =E2=80=9Cbisect-state/st=
art=E2=80=9D)
> >
> > Similarly for =E2=80=98bisect-state/terms=E2=80=99, etc. This kind of c=
hanges should
> > also be done in =E2=80=98bisect.c=E2=80=99
> > (which contains the binary searching algorithm git-bisect(1) uses).
> > Then, as noted by
> > Junio (https://lore.kernel.org/git/xmqqwms0ndvu.fsf@gitster.g/) this
> > path should be
> > marked per-worktree, since each worktree can have its own bisect sessio=
ns.
> > Probably, also files related to git-worktree use the directory of
> > state files somehow,
> > so one should also check them.
> >
> > 3. Write some tests for the new layout. The plan is to use the new
> > unit testing framework. First tests that come to mind are:
> >
> > a. Check that the state files are inside =E2=80=98.git/bisect-state=E2=
=80=99.
> > b. Check if the path pertains to GIT_DIR and not COMMON_DIR.
> > c. Check that after adding a worktree which was being bisected does
> > not somehow spoil the session and the state files.
> >
> > This can be taken as an example of test file for git-bisect(1) using
> > the new framework:
> >
> > #include test-lib.h
> > #include bisect.h
> >
> > // Write functions like:
> > // t_bisect_dir_init()
> > // t_worktree_init()
> > // t_test_layout()
> > // and include them in cmd_main
> >
> > int cmd_main(int argc, const char **argv)
> > {
> > if (!TEST(t_bisect_dir_init(), =E2=80=9Cbisect directory initialized=E2=
=80=9D))
> > test_skip_all(=E2=80=9CBisect initialization failed=E2=80=9D);
> > if (!TEST(t_worktree_init(), =E2=80=9Cworktree initialized=E2=80=9D))
> > test_skip_all(=E2=80=9CWorktree initialization failed=E2=80=9D);
> > TEST(t_layout(), =E2=80=9Cnew laypout=E2=80=9D);
> >
> > return test_done();
> > }
>
> I don't think that the unit testing framework would be a good fit. The
> intent of that new framework is mostly to test low-level functionality
> that otherwise cannot be easily tested. But here it should actually be
> quite easy to test things as part of our regular integration-style tests
> in "t/t*.sh", so it would be preferable to write those instead.
>
> > 4. Implement strategy for backward compatibility and related tests such=
 as:
> >
> > a. Check if Git correctly recognizes the old layout and in case
> > correctly moves the files according to the new one.
> >
> >
> > Timeline
> > ------------
> >
> > May 1 - 26:
> > Community bounding Period.
> > Read Documentation.
> > Write Backlog.
> >
> >
> > May 27 - July 8:
> > Implement a new layout for state files.
> > Write tests.
> >
> > July 12 - August 19:
> > Assess and implement backward compatibility.
> >
> > August 19 - Deadline :
> > Write documentation for the project.
> >
> > I can dedicate 3 hours a day during weekdays, and 5 hours during the we=
ekends.
> >
> >
> > Benefits to the Community
> > -------------------------------------
> >
> > How state files dedicated for git-bisect(1) are stored is not ideal.
> > Having a single directory dedicated to these files, instead of having d=
ifferent
> > files spread in the Git directory during the bisecting session, is
> > better and facilitates
> > even the removal of them after bisecting.  Moreover, as noted by
> > Phillip (https://lore.kernel.org/git/9c800cd5-8d20-4df7-8834-f74ab00069=
5e@gmail.com/#t),
> > by aligning the organization of these files to that used for am,
> > rebase, cherry-pick, etc.,
> > the repo will have a more coherent and uniform layout.
> > This will enhance readability and maintainability in general.
> >
> > Karthik [1] also expressed  the need of such refactoring as a prerequis=
ite
> > to introduce new syntax checks for pseudoref in =E2=80=98is_pseudoref_s=
yntax()=E2=80=99.
> >
> >
> > [1] See Karthik=E2=80=99s commit: 1eba2240f8ba9f05a47d488bb62041c42c5d4=
b9c
>
> Nicely summarized.
>
> >
> > Biographical information
> > ----------------------------------
> >
> > I=E2=80=99m a former student of Logic and Philosophy who turned to codi=
ng
> > after graduating.
> > I have been working as a Developer for NTT Data Italia for a year.
> > I hold a full-time job, but I've seen that it doesn't conflict with
> > the rules of GSoC
> > since I'm an open source beginner. I am fully capable of managing my
> > workload independently,
> > including my working hours. I know it is not ideal, but I can
> > definitely work around
> > my schedule and dedicate time to the project.
> >
> > Before, I have contributed small patches to two open source projects:
> > - Pydata/Sparse: https://github.com/pydata/sparse/pull/611
> > - Pennylane: https://github.com/PennyLaneAI/pennylane/pull/3959
>
> Thanks for your proposal. Please make sure you submit it as a PDF file
> to the GSoC website soonish, unless you already did that.
>
> Patrick
