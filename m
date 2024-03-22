Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC738DDD
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103222; cv=none; b=uXnFNkPIgBVB82YgFBJSQaBZkrf/OeTo0RV72IxuIOAVq8fxbef8orT7w11EOmuHs8xhJ20BLpAuTGwKMKsGVD2/mkX3mk0x5n06P2WehRGLRODz/xt2gr1+USlEy3Yo6O0r8bFLCUSXQozSwPuQ2U6YDPvANISHRXxM3T6HV84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103222; c=relaxed/simple;
	bh=BmNeYKg8gDx9l6ebpxafsCYfQreD/hjWPL3a3hun5YY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dVBycQUp2g7FlLx4L/uyFO5bgEzpLBs0+yO+Q9q7NJteD5kWksT1+TIXTT9EmFbPIY5Sx8W36t7TJQHwqhhRwbOfOqZii5v8PMi62wzvCrzWJ7L9e5vN0ICOaKZOkYb0D7YD4jouz0ofyyi5zmgGCz5y+cAPnW7JpaW6HCeom7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHxtKWId; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHxtKWId"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc236729a2bso1840769276.0
        for <git@vger.kernel.org>; Fri, 22 Mar 2024 03:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711103219; x=1711708019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U2T4RV8vQF91ujL2JAEkb4pkXB3TFwKbdoeaiQj01tE=;
        b=aHxtKWIdiVxpTFLj2SvOsAL5wFeYo/Ljdt5PpC3HnMB1APYotH8gnv2a0wrPdsy8YA
         b7k/8n0SY3eKaXpMHqceCkpKFSp4L3mw99kKWano73ctQ7ZI0GNQF1hG0AKbxzZZUf8S
         njt1Oo8gyVKLP3/imay8wnUcTrAefWj6SBfPlEq2nRay33zO5Fz9eY+ynWsfn1/hIELl
         eNmb4o6onvSXhUUW16qYM3+lh6+JBfkBkFL5cx0rD5gK/iu4ZTbjWZ6v96JJpzpmCukm
         FkRgR1cdRinZG95H0Ko05ZZxYKocawIBcCWsVsRZVNx3k7wvFqcMCC9KbEJnXbmZ3i6F
         h0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711103219; x=1711708019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2T4RV8vQF91ujL2JAEkb4pkXB3TFwKbdoeaiQj01tE=;
        b=HmQXJmtLVCw5ml/zGmImBgEh886+VG0pe/RrrWsfPxJIpCD+yfUm1aF6Nk0/PBbOKU
         DPcEI1oE7eY2v+tgUgdG2iUCohndhnBtA2euK3mIYG9g5aLgfmVETN3ciF8by/KH7LVs
         gM+74spfSu2uMlJMO5PchkobZuGkpJYmNxKCMyzrr874fST3/n3okDsfw4cxol9q0ggx
         RLP0JJ8mdebWfc3QYRg5daWtKhu9BxJ4bmO7aKXi/qrBeANl/rKOHW/vvb0oC2jAe/Xo
         GouGvsdMHrVcuYWlPORmj+xY3bla11nEVp5Jn+/SWw8B4bYKSuD1PkWn9XwdH38tNnIZ
         DV7A==
X-Gm-Message-State: AOJu0YzoepWRva3BP9j5w1KCwazJ0lF+3EvpAD5HyUK/nbysnBi+4Tqk
	oD8tlxMItW8zLwfJaw3PQGHGo/hqTHnChtehLUAJQQuFT/dtpRdXVjxTwSv2cKUCCccL9G2mq28
	icvN4MaZ9f/eO8fzodM3qQswXs772G/lMd9VW8g==
X-Google-Smtp-Source: AGHT+IFsRkgf7M1QlVSWGUnbdehUcGjwEA+/cH2KxSi+V9bZxbz6zxXqJcpR/bP97pSbbf7iebkkCoiBAk2D/I5F2F4=
X-Received: by 2002:a25:8710:0:b0:dc7:464c:e979 with SMTP id
 a16-20020a258710000000b00dc7464ce979mr1722188ybl.28.1711103219263; Fri, 22
 Mar 2024 03:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: eugenio gigante <giganteeugenio2@gmail.com>
Date: Fri, 22 Mar 2024 11:26:48 +0100
Message-ID: <CAFJh0PS_VB8yv7B1uM5+Ts9PtMFtU5mL4y8UUDORKQcYHSoxPA@mail.gmail.com>
Subject: [RFC][GSoC] Proposal: Refactor git-bisect(1)
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, ps@pks.im, 
	Christian Couder <christian.couder@gmail.com>, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all, this is my proposal for the GSoC 2024.

---------------------------------------------------------------------------=
-------------------------

Refactor git-bisect(1) to make its state self-contained

Contacts
-------------------

Full Name: Eugenio Gigante
Email: giganteeugenio2@gmail.com
Github: www.github.com/EuGig


Synopsis
------------

The git-bisect(1) tool is employed to pinpoint the exact commit within a
series of commits that introduced a particular bug. When initiating a
bisection session,
it generates a collection of state files within the Git repository,
documenting diverse
parameters such as ".git/BISECT_START". Instead of having different
files scattered
in the =E2=80=98.git=E2=80=99 directory, it has been suggested by Patrick t=
o introduce
a new =E2=80=98.git/bisect-state=E2=80=99
directory which will contain the state files
(https://lore.kernel.org/git/Za-gF_Hp_lXViGWw@tanuki/).
The aim of the project is to implement this new layout for storing
git-bisect(1) related files.
The project will also handle backward compatibility issues that may
arise with such a change.
This is one of the project ideas suggested by the community of Git.
The difficulty for the project should be medium and it should take
somewhat between 175 to 350 hours.


Contributions
-------------------

add.c: use unsigned integral type for collection of bits
(https://lore.kernel.org/git/20240224112638.72257-2-giganteeugenio2@gmail.c=
om/)


Description:

Since the MSB of signed integral type=E2=80=99 is special, =E2=80=98flags=
=E2=80=99 fields should be
declared of type =E2=80=98unsigned integral=E2=80=99. builtin/add.c:refresh=
() declares
'flags' as signed,
and uses it  to call refresh_index() that expects an unsigned value.
Fix this by modifying its type =E2=80=98unsigned int=E2=80=99.

Although the code was easy, this patch gave me the opportunity to get
familiar with
the process of submitting patches. The lesson learned was not only
about understanding
git commands for formatting and sending patches to the mailing list;
but, most importantly,
was about how to interact with the community; i. e., how to interact
with reviewers,
to ask them questions and give them answers. That is why I chose a
micro-project idea
that explicitly required interaction with the community, before
writing any code.

Status:

Merged to master on: Thu Mar 7 15:59:41 2024
commit f46a3f143eba661b9eb2b1e741447d6709eb6e90


Deliverables
------------------

As soon as the acceptance to the program is communicated, I will start writ=
ing a
sort of Backlog of required changes which has to be shared with mentors.
This has the goal of better tracking progress and possible issues.
Already individuated changes and possible strategies are considered in
what follows:

1. First, one needs to inspect the possible impacts such a change could hav=
e
regarding Backward compatibility. There will be two possible situations in =
which
backward compatibility breaks:

a. (Noted by Junio (https://lore.kernel.org/git/xmqqwms0ndvu.fsf@gitster.g/=
)).
People switch versions in the middle of a git-bisect session. Even
though I think this
case would not be that common, one should take this into consideration
nonetheless.

b. (Noted by Patrick (https://lore.kernel.org/git/ZbDPqOnyLw4yhu--@tanuki/)=
).
Different implementations of Git could suffer backward
incompatibilities like Libgit2,
JGit and Dulwich. In this case, I will investigate if (and how) these
tools would suffer the change.

In this phase it is important to find an agreement with the community
if the refactoring
would be worth it, and in case it is, to find the best solution to
guarantee backward compatibility.
The simplest way seems to be to teach Git how to recognise the old
style layout and move
the files by following the new one. This can be achieved by checking
the presence of state files
inside =E2=80=98.git=E2=80=99, just after the starting of a bisect session =
and by
moving them accordingly.


2. After a strategy for backward compatibility is decided, I will
refactor the directory
where all the file states are created. This is done by changing the
function factory
=E2=80=98GIT_PATH_FUNC=E2=80=99 in =E2=80=98builtin/bisect.c=E2=80=98=E2=80=
=99. The following is an example
for =E2=80=98BISECT_START=E2=80=99:

- #static GIT_PATH_FUNC(git_path_bisect_start, =E2=80=9CBISECT_START=E2=80=
=9D)
+ #static GIT_PATH_FUNC(git_path_bisect_start, =E2=80=9Cbisect-state/start=
=E2=80=9D)

Similarly for =E2=80=98bisect-state/terms=E2=80=99, etc. This kind of chang=
es should
also be done in =E2=80=98bisect.c=E2=80=99
(which contains the binary searching algorithm git-bisect(1) uses).
Then, as noted by
Junio (https://lore.kernel.org/git/xmqqwms0ndvu.fsf@gitster.g/) this
path should be
marked per-worktree, since each worktree can have its own bisect sessions.
Probably, also files related to git-worktree use the directory of
state files somehow,
so one should also check them.

3. Write some tests for the new layout. The plan is to use the new
unit testing framework. First tests that come to mind are:

a. Check that the state files are inside =E2=80=98.git/bisect-state=E2=80=
=99.
b. Check if the path pertains to GIT_DIR and not COMMON_DIR.
c. Check that after adding a worktree which was being bisected does
not somehow spoil the session and the state files.

This can be taken as an example of test file for git-bisect(1) using
the new framework:

#include test-lib.h
#include bisect.h

// Write functions like:
// t_bisect_dir_init()
// t_worktree_init()
// t_test_layout()
// and include them in cmd_main

int cmd_main(int argc, const char **argv)
{
if (!TEST(t_bisect_dir_init(), =E2=80=9Cbisect directory initialized=E2=80=
=9D))
test_skip_all(=E2=80=9CBisect initialization failed=E2=80=9D);
if (!TEST(t_worktree_init(), =E2=80=9Cworktree initialized=E2=80=9D))
test_skip_all(=E2=80=9CWorktree initialization failed=E2=80=9D);
TEST(t_layout(), =E2=80=9Cnew laypout=E2=80=9D);

return test_done();
}

4. Implement strategy for backward compatibility and related tests such as:

a. Check if Git correctly recognizes the old layout and in case
correctly moves the files according to the new one.


Timeline
------------

May 1 - 26:
Community bounding Period.
Read Documentation.
Write Backlog.


May 27 - July 8:
Implement a new layout for state files.
Write tests.

July 12 - August 19:
Assess and implement backward compatibility.

August 19 - Deadline :
Write documentation for the project.

I can dedicate 3 hours a day during weekdays, and 5 hours during the weeken=
ds.


Benefits to the Community
-------------------------------------

How state files dedicated for git-bisect(1) are stored is not ideal.
Having a single directory dedicated to these files, instead of having diffe=
rent
files spread in the Git directory during the bisecting session, is
better and facilitates
even the removal of them after bisecting.  Moreover, as noted by
Phillip (https://lore.kernel.org/git/9c800cd5-8d20-4df7-8834-f74ab000695e@g=
mail.com/#t),
by aligning the organization of these files to that used for am,
rebase, cherry-pick, etc.,
the repo will have a more coherent and uniform layout.
This will enhance readability and maintainability in general.

Karthik [1] also expressed  the need of such refactoring as a prerequisite
to introduce new syntax checks for pseudoref in =E2=80=98is_pseudoref_synta=
x()=E2=80=99.


[1] See Karthik=E2=80=99s commit: 1eba2240f8ba9f05a47d488bb62041c42c5d4b9c


Biographical information
----------------------------------

I=E2=80=99m a former student of Logic and Philosophy who turned to coding
after graduating.
I have been working as a Developer for NTT Data Italia for a year.
I hold a full-time job, but I've seen that it doesn't conflict with
the rules of GSoC
since I'm an open source beginner. I am fully capable of managing my
workload independently,
including my working hours. I know it is not ideal, but I can
definitely work around
my schedule and dedicate time to the project.

Before, I have contributed small patches to two open source projects:
- Pydata/Sparse: https://github.com/pydata/sparse/pull/611
- Pennylane: https://github.com/PennyLaneAI/pennylane/pull/3959

---------------------------------------------------------------------------=
----------------------

Thanks,
Eugenio.
