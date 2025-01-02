Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADAE1AD418
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735818026; cv=none; b=G+w0XSAUR4nBxWOgZHMGVXQ1uQu8oGBpXpH6Kk7DckF2LhNn3fOfMoXkmsoltuGyy+Y+taL+99pVEzGJJ3YHpDPHrSAPQXWVJ/yqFo3AGqcau4HM58IMuV7vW/o8y7RsCzzwb+g6x8zPYPeut89VO7V+hrTj9q279h9k2MLJN0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735818026; c=relaxed/simple;
	bh=s8l4VW1o94jMxuq/ddH+FMmYxMrRClX9io1vib4Ku1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJIQJlYs4Crhqj3LS9RaDoj+y4FzHGry2/P5KIk5bwdN2uW/PI/i6+6lIQAK14M9vA1V+VFJApSH9zf2YNVAp+xHLkkbskF4twF3lsMv7vfzp/ZBslkl5sBV2iOou9UCbYfEY6uI35hJKNYYtgkF4Qn1NzS1JLIJao5YPZGJZ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuvV03sr; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuvV03sr"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-540215984f0so11974829e87.1
        for <git@vger.kernel.org>; Thu, 02 Jan 2025 03:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735818023; x=1736422823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcZPl73f9mxwFDAE1aNc/YxMSDZDOB+WjsB288U+3pA=;
        b=NuvV03srnMHf+SLLCqeQbQacMY3sf6u+tn/TBtxGQ+sgnCIzqu7gVRnwPcwuVv5O2X
         AMX/aAH9Vq3dSwfNU7lvBMvLHWZpAb/lb5BDNZv7vDYjPAxJkFKtYykaO0jjiApiSt+M
         uq/fh3/fwmj0Md/DQi7GFON17JbX1s3f8PI1vm+P/quIZXvSDCf7oreh8cXaI/iHCgIp
         oeTFVMypZp6UsiCbKsl33dbX9HDd8hJ7DcwPWSAz+aSQ0PsQ3k4lQGdvgicDFDSIBTMs
         M9XcjH3kQUeMGAXpcKznbtXCk+A0pA0H2XAimEJ9Zj3FYN2fOsjuoGyI3aY9TtzUMlUV
         v0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735818023; x=1736422823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcZPl73f9mxwFDAE1aNc/YxMSDZDOB+WjsB288U+3pA=;
        b=P9F4Y69pV0HRCFCp9KLQw/KQYEFOci8k8kJilEUugGhbWinKni0r1plCkc/EesyUuQ
         xf5mx8VMw3o0s69+KEbGz6WnWo8pfzTmUIgSWqzM/zGTXKqoUSfz5ACV2nMaPpP9piRH
         LhfXpzF/favkO8qKsPwXWcXtWkPWiZ2Z2ImYAp0N+bc4u5hmiuo0p3Xzj62H6dicDSnz
         IGpHlhm5mxT1xlFcryu0WqHa6JOm7kn4Pln7BM1DTn2Qb+80kfFVu+TWqr/8dZLKOyKL
         9QfMIIfOQBwsYTBs5rvLRzyK1OypPWRcUYd0+GjBr90TMg3jIo5OB2O/4IdXwTToks+j
         8zNA==
X-Forwarded-Encrypted: i=1; AJvYcCVfiC1k5O8QRkt8ghxPCALSGYImj4KFcG+a3p7WaBqzMnIcSnuKEUSi2YjPQHxLXyCi170=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX2vOwx9EP5HWP3lvXdKsMIqxS6AooYJUpFae9yoDr4+rXOfEs
	U3Z8JCvkoRXL6f1oW2mGjT0aquVUdvQfSDLmtv/IEO3KMXNsKlvgaWvpviyQAKZ6EfRy96OVXlF
	X/8TW5syo54x0EvI9VZ4vRoa6AMk=
X-Gm-Gg: ASbGncuVCRAGtavakNOhS8IWPWowzahT9gGaOQBPkQDSFeoKNyeB9EPQtvQ2Q8R6zaH
	oLME0yUz0q92J92jCpphA8EfkyzMQ/mmAtI1ss60=
X-Google-Smtp-Source: AGHT+IHHV2gomWnSD8FxxwaX7VrDZA9E4Gft/Bxck+nuStUXWpXVjWFRM+rYubi1Y00TQe/mN4/Sr9WJTOGTfG+uoRE=
X-Received: by 2002:a05:6512:ba4:b0:542:2166:44cb with SMTP id
 2adb3069b0e04-5422959111amr14671398e87.35.1735818022310; Thu, 02 Jan 2025
 03:40:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1964163554.5326830.1735643984559.ref@mail.yahoo.com>
 <1964163554.5326830.1735643984559@mail.yahoo.com> <xmqq1pxmxyoo.fsf@gitster.g>
 <2075804114.5670956.1735812672910@mail.yahoo.com>
In-Reply-To: <2075804114.5670956.1735812672910@mail.yahoo.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Thu, 2 Jan 2025 03:40:10 -0800
Message-ID: <CAPx1GvdmrTn0x-F8yOoGrSrhXPN6At54svch=Wf=9rcz9Ri=7Q@mail.gmail.com>
Subject: Re: File missing from git branch
To: Prasad Pandit <pj.pandit@yahoo.in>
Cc: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 2:11=E2=80=AFAM Prasad Pandit <pjp@fedoraproject.org=
> wrote:
> * Generally committed local changes are visible across _new_ branches cre=
ated from the local branch, right?

The answer here is both no and yes. [1]

Your issue here lies in a misunderstanding of how Git (mis?)uses
the word "branch".

 ** branches **

In some other version control system, a branch is a very real,
concrete thing.  Creating a branch makes something permanent.
New commits, once made, are on *that* branch, and those commits
are *only* that branch.

Git is different.  A branch is -- depending on your point of
view -- simply a *temporary name* for *one particular commit*.
From another point of view, it is *that commit and every
commit reachable by working backwards from that commit's
history*.

I find that to really get people to understand this, it helps
to start them out by having them forget about the word "branch"
entirely.  They should instead think of commits -- which in
Git, are found by their big ugly hash IDs -- as the unit of
storage in Git.  (This is *mostly* accurate, though we can get
picky about other units of storage, but let's not do that here.)
So given a hash ID like 0f2ec7a4eeeec3045d7680e98f958740cd29bd77
-- which is too big and ugly for people to deal with, but we
can shorten it to say 0f2ec7a4eee -- we've found one specific
commit, assuming it exists.  That commit contains a complete
snapshot of every file that Git "knew about" at the time you
(or whoever) made that commit.  That's most of what most people
care about.

But that commit also contains some metadata: information such
as the name and email address of the person who made the commit,
and some date-and-time stamps, and so forth.  One of these
metadata items is a list of raw hash IDs of *previous* commits,
usually exactly one entry long.  We call that hash ID the
parent, or parents if it's longer than one entry, of the
commit.

The way Git stores "history" is precisely through these parent
IDs.  That is, given one commit ID like 0f2ec7a4eee, Git can
find *that* commit.  But that commit tells which commit comes
before it: 114193fd391, for instance.  Git can then find *that*
commit, which has another parent, which Git can find, which
has yet another parent, and so on.  By working backwards, one
commit at a time, Git finds the history of the repository.

And *now* it's time to consider the word "branch".  This word
has two meanings: it means both 0f2ec7a4eee, the *last* commit
on the branch, and also 0f2ec7a4eee, plus 114193fd391, plus
whatever comes before that, plus everything all the way back
in time to the very first commit ever.  So if this is "br-1",
then "br-1" means both "0f2ec7a4eee" and "everything leading up
to 0f2ec7a4eee".  Which meaning gets used depends on context.

But there's another funny thing here.  When you're on "br-1"
and you make a *new* commit, two things happen:

 1. The new commit gets 0f2ec7a4eee as its list-of-previous
    commit hash IDs.  That means whatever hash ID the new
    commit has -- let's say a5678xxx... -- Git will be able to
    work backwards to 0f2ec7a4eee and 114193fd391 and so on.

2. The branch name, "br-1", is rewritten to mean a5678xxx.

No *existing* commit changes at all.  In fact, it's impossible
to change a commit.  When you use "git commit --amend", you're
participating in a lie (a useful little lie to be sure, but a
lie): you don't change the existing commit, you just make a new
and improved commit, whose parent is the same as the parent of
the current commit.  The current commit then gets shoved out
of the way so that the new commit links to the current commit's
parent, instead of the current commit itself.  Graphically,
Git might replace this:

     ... <- 114193fd391 <- 0f2ec7a4eee   <-- br-1

with this:

                        0f2ec7a4eee  [lost / abandoned]
                       /
     ... <- 114193fd391 <- b0123456789   <-- br-1

If there's any *other* way to find 0f2ec7a4eee, however, well,
it's still there, still holding (forever) all the files that
it holds.

Anyway, once you grasp this, it becomes possible to understand
what happens with files when you make commits.  But now we have
to dive into another aspect of Git.

 ** your working tree **
The files stored under a commit's hash ID are permanent and
unchanging.  This is just what we want for revision control: we
*want* to get the old files back, even if there are mistakes in
them.  But it's not what we want to do *new work*: we need to be
able to rewrite files to correct mistakes and/or add new stuff.

To enable this, Git will "check out" a commit by copying, from
the permanent store, the contents of all the committed files.
These copies to into your "working tree" or "work-tree", and
here they take the form of ordinary files, which you can modify
to your heart's content.

In other version control systems, that's the end of the story
because you make new commits from your working tree.  Git again
differs here, as it has a thing it calls the "index" or "staging
area", but we won't get into these details here other than to
mention that "git add" is mostly necessary.  You "git add" any
updates and then run "git commit" and Git makes a new commit:

     ... <- 114193fd391 <- 0f2ec7a4eee <- a1234567890 <-- br-1

If you added a totally-new file to commit a1234567890, well,
it's there in that commit.  If you check out that commit,
that file comes out into your working tree.  If you make
a new branch name *now*, well, let's draw that:

     ... <- 114193fd391 <- 0f2ec7a4eee <- a1234567890 <-- br-1
                                                     \
                                                      `- br-2

Your new branch name *also identifies the new commit* by its
hash ID, so it will contain the new file.  But suppose you make
the new branch name *before* this point?  That is, you have:

     ... <- 114193fd391 <- 0f2ec7a4eee <-- br-1
                                      \
                                       `- br-2

If you now make a new commit while "on" branch br-1, you get:


     ... <- 114193fd391 <- 0f2ec7a4eee <- a1234567890 <-- br-1
                                      \
                                       `- br-2

The name br-2 still identifies commit 0f2ec7a4eee, which does
not have the new file in it.

To make things still-more-confusing, if you create new files in
your working tree, but *do not* commit them, Git doesn't "know
about" the files and does not store them in the commits.  (This
is where "git add" comes in again: if you didn't use it, Git
treats this as an "untracked file".)  Any such file just hangs
around in your working tree: Git neither modifies nor removes
the untracked file.[2]

 ** that's why this is a bit messy **

Given the dual meaning of the word "branch" and the fact that
we don't know whether you meant one specific commit hash ID,
or some other specific commit hash ID, or a chain of commits
ending in a specific hash ID, we can't really say what "should"
happen.  But you can find out by use of this principle.  Use

    git rev-parse main

to find out which commit hash ID "main" means right now, and use
similar "git rev-parse" commands to find out which specific commit
hash IDs other names mean right now.  Or: use "git log --graph
--decorate --oneline --branches" to help you visualize the
chain(s) of commit(s) reachable by starting at any particular
branch label and working backwards.

  ** footnotes **

[1]: https://www.reddit.com/r/lotr/comments/1608zdc/question_on_advices_fro=
m_elves/

[2] There's an exception to this rule.  Suppose some historical
commit has a file with the same name as some existing untracked
file, and you ask Git to check out the historical commit.  Git
must replace the untracked file with the historically-tracked file
in that old commit.  If you then switch *back* to the newest
commit, in which the file doesn't exist, Git has to remove the
historical-commit-copy that it copied out to the working tree,
which in turn destroyed the unsaved work that was hanging around
as an untracked file.  Git has a number of precautions against
this kind of clobbering unsaved work, but there are some corner
cases here that are problematic.  If you need to work with a
historical commit *and* a more recent commit that might have files
with colliding names, consider using "git worktree" to make a
place to examine the historical commits.

Chris
