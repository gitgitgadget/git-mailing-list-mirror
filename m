Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77E42701B1
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745448133; cv=none; b=W4hdFaaU8ulALKrcL1Wajr3qM+OMUWQ8tq34TfKDQGRp0YfxttA0+3s3UXItuIPdywjuwj9mjkWvIq2l9Kk1AJynTkR9rLCNFtTJHW+FtB+bja6SOR7sCCpH/A9KFgD00rGCFFoghPxKCmdfMEoxKFiCPHO5B9w1GoU2mqHgJBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745448133; c=relaxed/simple;
	bh=HOgUHJ7iQNP4I0TLZ9w3ZUwH5KWvIYQHf/qLIWgMZBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUeQbt4S/3kwHn44/9+AcPpTduDuB0yYdir3vpfb0CJmLVkOF517BjMPg0iyISyeRxSkggLGYHwX8b4XyvCWhVL/rJt2LcYq6WAp7Zy4hGD0/Xr3vjWs8a79t/+s3ebrgET+rOFQlaeQ8Hg50a/EEePbdbbL3C1AVyzKGxCEuVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqoDt0yO; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqoDt0yO"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85e15dc801aso32330439f.2
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 15:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745448131; x=1746052931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RsuN2XJH2Y3XxcUFsExpCgCEiH4fYv6orknQfwO7oI=;
        b=aqoDt0yOjDETW+CzqqMdRa6qhduyL4FZH2Rxr0AUDoKZxlnaMLcjSE1hkjqhNE8Vin
         l+zJD42JO4uoaWW0VznNzS7gvMRye0VO3JnXSNqo1hNyb6lbUeHgneJJirHorvYzX5/5
         oX0fPBCmnxMorr+oPdmO6emzq4rim6jVEwvr7/uus8474065rEccBpAKneBkuEItIoQn
         H4WRCfdZoe7C5k8pW6A7XzvFYj0XboTFcFUVo9GFrekTjVfS9h0CjatAANUnabBIt+Qw
         U73r9IFo+ROmCsx4bPVcixCAje9gz6idPrE+MRzyNF8kWOvGELMotGVukuQ/TflYip27
         w5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745448131; x=1746052931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RsuN2XJH2Y3XxcUFsExpCgCEiH4fYv6orknQfwO7oI=;
        b=bFG4tU5ey3psp4XJfKF35JDnF1oe6k5B8l7r5Rg5sBc49GGEMZl1QfxujbCXtIpuQb
         V/lMUWSJUKH0yuGX1HRr8+RTlXaqeh7Oo4nNqG8cZQw5tGg58qVvrx0P6ZA1X9IoLpxH
         quA2OByREegDhdsrTQNprMWIB9MpgqIiB5YN5obuoNXXD+3mOpn3MwgHznfENxYG8nTb
         1pl7h7zZh1ZQsi8ZpiZckep8LEUZPIncb7rAG+gOdvDbA+xVXQ89nkXt5PtYeldwMtRt
         iF2BtyLSxCM4sdKk+UHvpQ6Xksr4+K37X7K7x+OilEIJksk/r8lJ55XqqzA6y2I/0VvA
         z47w==
X-Gm-Message-State: AOJu0YxPH7RgeJGbowcNa8GhVBoHmXYLtcik8Qa4yWlIU0lWU1NMgP77
	IbQV9Bq00QcHjZDvGaiS0SdRkvVP3+d1XWcvxOqnx/NPWlUlxQTF//3NrreANEuC17VydO7LSg9
	Q4w8ZzxmEULK5AG/FnIyua1xvU4o=
X-Gm-Gg: ASbGncu6Ge8FpiUwIQzn3ZKqOroM/ZI6OXdMrmRNDEi0HgYVteZbXlkN/6uTnB1Buuk
	xJ3TSe3F08X1Q6lK9pc/Od70/9YCCVTpIJWc80zgSTAfucEkRxY+kPvq1LTtX1bUC2N2+4ilOnj
	Dlh0sFGChyZ2RLpKW9HG32agVYog7zMRRsikemnCpDwHWwl3dNj44OhUZP/wMyWzge
X-Google-Smtp-Source: AGHT+IFgF2jCLRuQ3XBNDqIP1htCV7U5PSyV3oodOvPIi7NocQd7aBXgyzV6lIhTYieVpSi3G0QOV9oW58LoBfw//XU=
X-Received: by 2002:a05:6e02:1c08:b0:3a7:88f2:cfa9 with SMTP id
 e9e14a558f8ab-3d9303c94f9mr3980015ab.11.1745448130661; Wed, 23 Apr 2025
 15:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85ea4aa0-c595-4f0b-a2ac-d0113aca464a@gmail.com>
In-Reply-To: <85ea4aa0-c595-4f0b-a2ac-d0113aca464a@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 23 Apr 2025 15:41:59 -0700
X-Gm-Features: ATxdqUEtZ8wyGiAq5YFMVntaMdgt5RF6PzlzJIsMPwUtESjgHTPs4toJHrGzAOw
Message-ID: <CABPp-BH2yH4iJ28Bo7Q=uryu68LLk7a0Tvb2SzAbAiHK8QpRug@mail.gmail.com>
Subject: Re: Collaborative community interview for Git's 20th anniversary
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Christian Couder <christian.couder@gmail.com>, Markus Jansen <mja@jansen-preisler.de>, 
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 5:31=E2=80=AFAM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> Hello all,
>
> As part of the Git's 20th year anniversary, we from the Git Rev News
> team are thinking of doing a community interview where we would share a
> list of questions that we've prepared and we would like to welcome
> answers from anyone in the community for them. We could gather the
> answers for them upto a particular time (like 25/April or so) and begin
> curating the answers into a special interview for this month's edition.
> The questions are below. Feel free to respond with your answers to this
> mail thread. Let me know if I've missed to include any particularly
> compelling question.
>
>    - What's your favorite Git trick or workflow that you wish more people
>      knew about?

range-diff.  The ideas behind it ought to be the basis for code
review, IMO.  Commits should be the unit of review (including commit
messages as a fundamental and primary thing to be reviewed), and a
series of commits should be the unit of merging.  I dislike most code
review tools, because they get one or both of those things wrong.
Getting both of those things right naturally leads to range-diff or
something like it being a very important part of the workflow, at a
minimum for detecting which commits in a series are unmodified and
which have been updated and need to be further reviewed.

>    - What was your worst Git disaster, and how did you recover from it?

My worst Git-related disaster wasn't with Git directly but with our
Git hosting software we used at a prior job, Gerrit.  'twas a
"startup" that was still forming good practices.  We had both a
production and a staging instance.  The staging instance was seeded
with a copy of production data so we could do scale testing...but that
seeding process was a multi-step manual thing; it hadn't been
automated.  One step was, as best I recall, "drop database gerrit",
followed by loading the production copy of the mysql database (this
was long before NoteDB arrived).  And as many readers probably have
guessed by now, I was on the wrong host one day when I ran that
command.

The actual git repositories were still intact, but the review metadata
was toast.  Luckily, we had a backup from about 7 hours earlier, so we
could recover the older review metadata and with some hackery fix the
mysql metadata mismatch with the newer repository contents.  And since
Gerrit emailed folks comments from reviews as they were posted, we
could tell people to look at their emails for the pieces we couldn't
recover.

It was a really long night trying to fix things.  Some folks told me
they thought I was going to throw up just looking at me.  But I
learned how wonderful it was to be at a company with blameless
post-mortems, and I appreciated the many folks who reached out to tell
me stories of mistakes they had made.  They were more interested in
whether we learned our lesson and put processes into place to prevent
repeats, and I definitely did both.

I did, of course, also get some good-natured ribbing, such as people
saying I got to play the part of little Bobby Tables once (see
https://xkcd.com/327/ if you don't know that reference).  I kindly
reminded them that I didn't drop a table -- I dropped the whole
database (plus, it wasn't injection, it was just running a command in
the wrong location) .  Also, one of my colleagues helpfully modified
the prompt on production to be red and bold, "This is PROD Gerrit",
and the prompt on staging to be green, "This is staging Gerrit; it's
okay to drop database here!"  The prompts ended up not mattering since
I automated the process, and made sure the process just error'ed out
if run on prod instead of staging.  But the prompt persisted for many
years anyway, because I thought it was a hilarious way to poke fun at
my blunder.

>    - If you could go back in time and change one design decision in Git,
>      what would it be?

The index.  For a few reasons.

1) Performance.

1a) The index is pervasive throughout the codebase, and while it works
great for small repositories, it means that many operations are O(size
of repository) instead of O(size of changes).  sparse indices help,
but the code has to be carefully audited for sparse indices to work
with each codepath, and even then there tends to be a fallback of
just-load-everything-anyway because the data structure doesn't lend
nicely to just expanding a little more.

1b) An under-appreciated aspect of the performance improvements that
came from our new merge strategy, merge-ort, were due to dispensing
with the index as the primary data structure.  The index had two
problems:
1b-1) first of all it meant loading every path in the repository,
which would have prevented ort's optimization to avoid recursing into
subtrees when unnecessary (an optimization that often made merges e.g.
50x faster).  Sparse indices didn't exist back then, but even if they
had we would have had to complicate them significantly in order to
have their sparseness be determined by renames and the intersection of
modified paths on the two sides of history instead of having
sparseness determined by user-defined path rules; I think that'd have
been much more complicated than just dispensing with the index as the
data structure, but we didn't even have sparse indices back then
anyway.
1b-2) Second, the use of the index as done in the old merge strategy,
merge-recursive, resulted in O(N^2) behavior since entries (including
conflicted higher order stages) had to be inserted in sorted order.
Deleting entries didn't have the same O(N^2) problem due to some
tricks to queue the deletion for later, but attempting to do the same
for insertions was far from straightforward and I believe would have
required making some other data structure primary and then forming the
index at the end. (Note that the primary data structure used, whatever
it is, cannot just have a list of things to insert, it also needs to
be checked for various properties intermingled with insertions...and
those sometimes relied on the fact that the index was sorted for quick
lookups.)

(Note that a tree-structured index rather than a linear index would
resolve these problems.  But retrofitting the entire codebase is
probably never going to happen...)

2) Cognitive Complexity.

The funny thing is, although I say this, I use the index all the time.
I use `git add -p` a lot.  I very much need to slice and dice my
changes into different commits, and tend to have dirty changes that I
don't want pushed.

But slicing and dicing before things are committed, as opposed to
being able to slice and dice after, is a choice that adds a lot of
complexity to the user interface and does so even for users who aren't
interested in slicing and dicing commits.  We don't have a
sufficiently flexible set of tooling for slicing and dicing commits
after-the-fact within git to switch to a post-commit-slice-and-dice
workflow even today, but I suspect that some of the ideas from JJ
would or could be much better than the methods I use today in git to
slice and dice commits.

>    - Which Git feature or improvement over the past 20 years do you think
>      had the biggest impact on your workflow?

Speed.

Being able to instantly switch branches (in smaller repos, sure, but
CVS and SVN couldn't pull it off even in small repos) was a game
changer.

>    - What Git problem that existed 10 years ago has been most
>      successfully solved?

Merging and rebasing with lots of renames (and generally merging
without a worktree or index).  I'm obviously a bit biased on this
point, but that doesn't mean I'm wrong.  ;-)  It used to be awful and
works great now.

Relatedly, merging without a worktree or index was problematic; you
had to either use an alternative merge strategy with limited
capabilities, or use something other than git (e.g. libgit2).  But now
git handles it well with its default merge strategy.

>    - Which Git commands or workflows do you think are still misunderstood
>      or underutilized today?

range-diff is very under-utilized, but I already discussed that above.

>    - What's one Git based project, tool, or extension you think deserves
>      more recognition from the community?
>
>    - What Git feature or capability surprised you most when you first
>      discovered it?
>
>    - What's your boldest prediction about how version control might look
>      in another 20 years?

I'm more interested in what storms might be brewing along that path,
and what we might be able to do to avoid them.  In particular, some
questions and observations in that area:

  * With monorepos growing ever larger, do we have
hard-to-workaround-or-fix design decisions that pose scaling
challenges?  e.g.
    * the index data structure
    * per-directory .gitignore files, per-directory .gitattribute files, et=
c.
  * ...or do the prominent Git forges have hard-to-workaround-or-fix
design decisions that'll give Git a reputation for not scaling?  e.g.
    * making refs/pull/NNN/merge a public ref and excessively
implicitly updating it
  * Will we face a crisis of interest?  e.g.
    * git is currently written in C.  Even if that's not a liability
already, coupled with "decades" I think it is.  Young developers
probably don't want to learn C, and older ones who already know C may
worry about C becoming a Fortran or Cobol.
    * Companies employing git developers think "git already won" and
redeploy those engineers on other problems
  * Will the combination of issues above result in folks who want
improvements deciding their best bet is not improving git but in
creating/funding an alternative?  Will that snowball?

To me, the entry of new projects like jj and sapling suggest the above
are real concerns already rather than just theoretical.  Both projects
have compelling things that git lacks.  I like the friendly
competition, and the jj and sapling developers are awesome to talk to
at Git Merge conferences.  But there is a risk that this friendly
competition mirrors that of Git and Mercurial from years past, and
that Git at some future point down the road ends up on the other side
of that history and gets largely displaced by the alternatives.  I'd
rather not see that happen, but I sometimes wonder if we're taking
enough measures to avoid marching towards such an outcome.
