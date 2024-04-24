Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DBB1772F
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 22:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997077; cv=none; b=FSzWST/hltHZo4tQYdwLHdDSKXvxIqXAN7fdUZZMCuMFhwQuPoBLu0PzUr8Syh2EmVmqC+fXEmohrYO3K8GUIVu/QoXaYu89dNOk78YokYrcYVEax0Ppx7XoQCc+zgzdFJdAevP7T2+DsYH/CHRsEEfar75QJZD6vVW95jMz4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997077; c=relaxed/simple;
	bh=PA/qrNUYYOForWFWPfHTMPgCHDv+e9xvjB0cWUYM808=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVuzszfUHTEMr+GFUbWLKfK2467pgCEkRya6UmrcGzOdsoXsF3FlcFFr93dx3ZRzE5KJD/6BUzC/OtiBvO3/ohD52Y6TF5s3J85hr77CGw6XoCYq0Sk9lhf+ggLUWz5p7xvQHP2089ZVt/fDf2Ph/3+UJVWg5gHclkLsyWLb92A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoIGDHRu; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoIGDHRu"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so370226e87.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 15:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713997073; x=1714601873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yE2fKKhI2AJobfE9MBLy/ezsnL/VLA45r0BV6OzyjU=;
        b=UoIGDHRuwp/JyoHXgYLKvj2U2S+PncFeZlJJ+d755Z+tTpeUeHssSxLY2q8otfMcl8
         fJEE1+awOF3EpbBkpKibzTeq04rV4qgMTlbb7KItYqmBrknvYeAvj5G9/cDuE3jwNS7l
         eRCMe3u3Ocss4IxauQ/8yhoccoE14xXVxx/g/bbNdRBPVZyrKh5uDf+CFYob1zEB2SHJ
         sEYTzbvHIwEYWbGaMW6HQadPC6TxYEs2PPomRSxHb20LPhi35hU5/S3NHVpWMywMzhBW
         QdbL1d3C02IGMPdHZqaZfQ5gD7Fp+teKJLQHvZ7gHsGPvRmpK5LIlZaZaBOJas2kcmpv
         5JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713997073; x=1714601873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yE2fKKhI2AJobfE9MBLy/ezsnL/VLA45r0BV6OzyjU=;
        b=F8Sl1l89VCoPaE6SBUL54bsuizOYgoQovBvMx0sS8DP8EV5UdiOPN1WHO/KjDh8nhP
         gi+xYmc/zbTn9Y2qEwNiPj9RowC41syY/OXKOT7bdKkhBysyyNuIjQckqLQQLZIjNCzv
         9OHKFQXJmKGfxq170BWy4y89hmBGWLbzXCitJL0T1b2saZ+rsFgbpL7LDOb33pgDWN6f
         qxQCgqrPW2juWEqAL37zpOutgQ2WIS3bmKhIU70a9JR4Eofo/mrV53Tsi+d36SkLzhyi
         D3KUwRZ38i4XTAaHiNLngQZiUzBSOHR1b88Sww8K+T++R8wJO/IaIeAEMcx2H02DnVP/
         Owbw==
X-Gm-Message-State: AOJu0YzHQ1AilgDbA0TDP87leHBBvU5SokuADqwtPA7gBkj2v1b2FCZu
	7P5TteijU/l3pZVsjVn1lI0OIeoqZcGCnR/zZrGZDfiHNo2BYJylTqQM0c/ZvLGTpbwSbr0LYIe
	4AoskmgLskGd6XTJjupHWFHI+Vop/aZWP
X-Google-Smtp-Source: AGHT+IEQvnCqg2W0f9d9ENwKGLPtLGQ2FzhvOUz4OgAmlgqNX7a4X3mVImMyR9+GztwDkwkAOC6fiNLF9fmFr5JURy0=
X-Received: by 2002:ac2:4a6f:0:b0:518:b069:3b7d with SMTP id
 q15-20020ac24a6f000000b00518b0693b7dmr2384460lfp.6.1713997073088; Wed, 24 Apr
 2024 15:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZikMqXeDnOqK_wlq@thechases.com>
In-Reply-To: <ZikMqXeDnOqK_wlq@thechases.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Wed, 24 Apr 2024 15:17:41 -0700
Message-ID: <CAPx1GvcxyDDQmCssMjEnt6JoV6qPc5ZUpgPLX3mpUC_4PNYA1w@mail.gmail.com>
Subject: Re: Stashing just index..working-copy rather than HEAD..working-copy?
To: Tim Chase <git@tim.thechases.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 6:51=E2=80=AFAM Tim Chase <git@tim.thechases.com> w=
rote:
> ... However, I was wondering if there was
> a better way to instruct git-stash to stash index..working-copy
> instead of HEAD..working-copy (and leave the index alone in the
> process) in the first place.

Let me start by just providing a simple BUT A BIT DANGEROUS
recipe:

    git stash --keep-index
    [test, and assuming good, proceed with]
    git reset --hard
    git stash pop --index

which will accomplish what you intended originally. But now, let
me go on to tell you what you really need to know here, and some
of the pitfalls you might encounter.

Let's start with revisiting the subject line here:

> Stashing just index..working-copy rather than HEAD..working-copy?

This implies that you're thinking about Git as storing diffs.
This is not the case!  Git stores *snapshots*.

Now, as it happens, storing diffs vs storing snapshots ends up
equivalent in a way.  But that's a bit like saying that writing
a number (say 15 for instance), then a delta (say 7), is the same
as writing the number and then the sum (15 and then 22).  They
are obviously *different*; it's just that if you apply the right
process *in between each step*, you get the same *answer*.

Git "likes" to show you differences because that's how humans like
to think.  We don't want "I had this full snapshot of everything,
then later, I had this other full snapshot of everything" but
rather: "I had a snapshot, but I changed a bit of it.  Let me see
what I changed."

Now, the way `git stash` works is that it saves not one but
*two* snapshots, both as commits, but with neither one being
"on" any *branch*.  Git can do this because in Git it's the
commits, not the branch names, that actually matter -- branch
names are pretty much irrelevant, except of course to those
pesky humans. :-)

The two commits that `git stash` saves are:

 1. the complete contents of the index; and
 2. the complete contents of the working tree that you'd
    have gotten *in* the index if you had run `git add -u`,
    more or less.

(There is in fact an optional *third* commit, from `git stash -a`
or `git stash -u`, but let's just ignore that here.  If you ask
for this, it makes things trickier.)  Let's call commit #1 here
the "I" (for Index) commit, and commit #2 the "W" (for Work-tree)
commit.

Every commit, in Git, has a parent commit, or a list of parent
commits.  The parent of the "I" commit is the `HEAD` commit, and
for various internal reasons, the "W" commit has two parents,
both `HEAD` and the new "I" commit.  So Git can always find the
original `HEAD` commit from the stash commits, and can find
the "I" commit from the "W" commit.

Having made the two commits, `git stash` normally then runs
the equivalent of `git reset --hard`, which puts both the index
and the working tree back to the state saved in the `HEAD`
commit.  When you run `git stash --keep-index`, Git modifies
this to do the equivalent of "reset to whatever's in the index"
(rather than "reset to whatever's in the HEAD commit").

That's why `git stash --keep-index` lets you test what's in
the index.  This is an obvious practical use for `git stash
--keep-index`.

The problem with this comes in later: both `git stash apply` and
`git stash pop` run into it.  They run into it whether you use
`--index` or not.  **Here's the root of the problem: `git stash`
made two commits, not one.**

Again, `git stash` made two commits.  You can't put two commits
into one place!  Whoever invented `git stash` chose to solve this
problem in a kind of strange way.

Let's start with `git stash apply`.  Whoever first wrote the stash
code was thinking about `git apply` here.  How does `git apply`
work?  Well, it takes, as its input, a diff.  We get a diff by
comparing *two things*.  So `git stash apply` compares two things:
the commit that you had as `HEAD` when you ran `git stash`, and
the commit that `git stash` saved as "W".

`git stash apply` therefore runs:

    git diff [various options if needed] <W's HEAD-parent> <W>

which gets it a diff that it can then, in effect, feed to
`git apply`.  The apply code then tries to apply that diff to
your *current working tree*.

If your current working tree matches W's HEAD-parent, this
application proceeds smoothly, and you're all set.  But what
if, for whatever reason, your current working tree *doesn't*
match W's HEAD-parent?  What if instead if matches W's I-parent,
aka the "I" commit?  In that case, some lines try to apply
twice and/or cause a conflict -- and that's exactly what you
have been running into.

If `git stash` had a way to do:

    git diff [options] <W's I-parent> <W>

and apply that, *that* would be what you would want here.  But
alas, it lacks any such option.

What `git stash` *does* have is `git stash apply --index`.  This
tells Git to run *two* `git diff`s:

    git diff [options] <original HEAD-parent> <I>
    git diff [options] <I> <W>

Git then tries to apply the first diff to both the index and the
working tree (a la `git apply --index`), and then apply the second
diff to the working tree only (`git apply` without options).

If your working tree matches the original `HEAD`, you get just
what you want: the index is restored to the way it was when you
ran `git stash --keep-index`, and then the working tree is also
restored to the way it was at that time.

**The biggest pitfall here is that you might forget `--index`.**

If you use `git stash pop`, this can be pretty terrible!

The W-and-I commit pair that `git stash` makes is, as mentioned
earlier, on *no* branch.  This means Git can't find it directly
by a branch name.  The way Git finds these commits is through a
special name, `refs/stash`, that's not a *branch* name at all.

The `git stash apply` command means *apply a stash*.  By default,
it applies the topmost stash in the stash-stack.  It then *leaves
that stash around* so you can still access it by the same name.

The `git stash pop` command essentially means: *run `git stash
apply`, then if it says it worked, run `git stash drop`.*  It's
the `drop` command that discards the name for the stash.  Once
the *name* is gone, the only way you can get to the two stash
commits is to find the big ugly hash ID for the W commit.

(Finding the W commit gets you all three -- then-HEAD, I, and W
-- via the two parents in the W commit.  Finding the I commit is
not as useful as it gets you just the then-HEAD as its parent.
That's why the special `refs/stash` name stores just the W commit
hash ID: that's all you need.)

Now, if you use the "DANGEROUS" recipe, suppose you run:

    git stash --keep-index
    [test and find that it's all good]
    git reset --hard
    git stash pop       [OOPS FORGOT TO USE --index]

The `git reset --hard` puts everything back to the `HEAD` commit
state, losing the carefully-`git add`-ed parts that you just
tested and intend to commit.  Then `git stash pop` applies *only
the W commit diffs*, which is not awful on its own but doesn't
save the carefully-staged stuff as staged.  Then it drops *both
stash commits*.  You now have to re-create the carefully-`add`-ed
parts.

If you catch the mistake right away, you'll usually have the hash
ID of the dropped stash handy in your Terminal window or wherever,
and be able to snag it, which can save a lot of work.  But if not,
well, that's why I call this "dangerous".

To reduce the danger, you can simply avoid `git stash pop`. Run
`git stash apply` instead, remembering or maybe forgetting the
`--index`.  Then check your work and if you goofed it up and
forgot `--index`, you can `git reset --hard` and `git apply
--index` this time, because the topmost stash is still the topmost
stash.

To help remember all of the above, let's revisit the subject
line once more:

> Stashing just index..working-copy rather than HEAD..working-copy?

`git stash` *already saves everything you want*.  It's actually
the *application* step that goes awry here.

   *  *  *

With all that said, I'd like to make one last suggestion, which
I think is a lot simpler: *stop using `git stash`*.  Just make
a commit!  If you want to test it, consider making a new branch
first:

    [do a bunch of careful `git add`s or whatever]
    [realize "I need to test this"]
    git switch -c test-my-index
    git commit -m message1
    git switch -c save-additional-work
    git add -u
    git commit -m message2

You can now check out the "test-my-index" branch, as a branch, and
test it and if it doesn't work, keep fixing it up until it *does*
work.  Once it's ready to go, smash it all down to a single commit
with `git rebase` if needed, maybe fix up the commit message(s),
and then you have it ready to go into the original branch as a
single good commit.

Meanwhile, the "save-additional-work" branch is there for you to
get the working-tree changes back whenever you want them.  Not
only that, but that branch has the original to-be-tested index
changes as its parent commit, and then the commit-before-that as
its parent's parent, so you can easily see what you were thinking.

Chris
