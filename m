Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF1BF4ED
	for <git@vger.kernel.org>; Wed, 28 May 2025 00:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748393801; cv=none; b=lsX7H5JUmXfnDq+0qEMC4CTiwHxs80IxE+dxZrfnx4SQtznFN3B53tAult7wp908psXszULV3g/ug+5mCCeKiQZdMI30ziHW2igCpjV5ljkQBEmNaVn+Amuyrc956zToLxIxydf0TWf+GJD9UzT/nSpIc+soRGEIw4xpsyJEe1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748393801; c=relaxed/simple;
	bh=QVjkf63YjU6BVScbX5J+N7qkVdhVwtHJTiCE572KiDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSe1gK5fm8neq05gkQ7msnPk0TNiPRq27wi0jveVtw8Imhbnpn21UmEepfGLi3T/iiLYB0AKLK6CeJGOhNiENtZhyILVREdjewnG+RY5CdtNO9FRVJwut8UaSqVpbxD91PU+xbKwtC418vfhWsxnBDP6iTl4Kn2vba6geQIWbQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZ0XtGMk; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZ0XtGMk"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54acc0cd458so5012382e87.0
        for <git@vger.kernel.org>; Tue, 27 May 2025 17:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748393797; x=1748998597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1MOU7sm2OQPXCTtnGukxSsOT0AMjGRNEm/F0pKThiE=;
        b=aZ0XtGMkwFid1O24vj6NMFclb6bjaWpWI6IPSXcfJt+73QEw9+YNinBn13segakcKB
         n6NLo4026ZEy4F2EZpRSwsu/nS2AJQtbTGPngQDIKsSgTxsYK0Ch33agh/OWSf4kj8G3
         86FVTU7Y9nH3qsCxjJ5ZToVMq0NIg8jwADV08O9bO7iC6wgkkmE/yLjEdG/0+DRi+nuO
         TohhusLl44JjF5KdJOQkVJvkLBVBKswCZw5iLaoOzmu33uHOy0R7gc3M13upqrmyiU9S
         X6Enbpf9rtOvo/U0kS+OKvVpl6bJ89/o9PtJ8zUGjJnLpqm7/3KMk1a6LsHm6X6siILk
         hFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748393797; x=1748998597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1MOU7sm2OQPXCTtnGukxSsOT0AMjGRNEm/F0pKThiE=;
        b=M4JS3W3hK78k9pmo8JcS+fQoRlLg0vhYDzvS1+cgKU7fiqOQRbRGX5jyLFtEs8r5ap
         BszP8wziVmNKU8bE66d6LVkDlT60iYrCZbk8uS17LD9CfLSntJJCIV+2awsV6b9TY2QF
         NxgyS/xSF71dHYOM27isKEiCBPNBwQb7uNyuX+g/Nhdk0PP4AaAGXtFoYlJMNSb5h51m
         2qCvVJB4rNyspMBVbBEK4RLaSqRP5d+oNyMd2ldI7rp2BoHHvlj7tIwg8p4UTGrR/Wps
         ffP+yvXBZwmEl7tdF8KHoS9wvR28AUrHsTiO/E9QqIeaslyKGS3a3oLyurI/UrrHFY8+
         g77A==
X-Gm-Message-State: AOJu0YwiPwGeq8Kk+/89SDibxooRBwlIXo6xHOydD3IU1BSfdJYM3I7f
	iQBjtAzEsAbp9MLnPAPmPfrJcFLSGq354anOr40xeOzNnrKi8ARJ5G6M0k8iyRdnQhc4NX0+cZJ
	AlVz1xHLEiOrEDOSPEogwVIXEVwv0P7v+Sg==
X-Gm-Gg: ASbGncsocM/VHoCGxSKPF/1zg0n17ZxYzaf57vYAa3tKhgspQOwu2bJwHBM3wgqfjLa
	kl7fe0dR4rXtEyF2MhiwoB5RQ16cQ4951ONsjlMdSX4aJ3QONt7+rRLMmPmaf2KowrHo1Wj2pfV
	38RhrwKXFuWUgJ/R+FXNzNz3U+dx2f+rDNtKF39Md1ys8j
X-Google-Smtp-Source: AGHT+IH9vdBYaXK4DB3/HXLH7Cbp38PIil24ieIIAP6iRSZi6BAuMRcTBTTqdNGkqmGFHSB2E9HkQmG601G7jd6ciw0=
X-Received: by 2002:a05:6512:68b:b0:553:2cc1:2bb4 with SMTP id
 2adb3069b0e04-5532cc12d7amr941124e87.12.1748393796890; Tue, 27 May 2025
 17:56:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOWMAxwQacT=PcPrWiuEJzSH24ELDBxq2XMNX1X75KSp6cS6jw@mail.gmail.com>
In-Reply-To: <CAOWMAxwQacT=PcPrWiuEJzSH24ELDBxq2XMNX1X75KSp6cS6jw@mail.gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Tue, 27 May 2025 17:56:24 -0700
X-Gm-Features: AX0GCFupOPvsZxtBcwh8e7TgpVY8ziUj7UHh43CX-H5xGksgdxYlBvE8ddO9Y2w
Message-ID: <CAPx1GvdqVpmw2mjbSDyVqBii4y=_DpTpa3jXM4_1tg5h5BWF4w@mail.gmail.com>
Subject: Re: Feature request - optionally include merge conflicts in `git add -p`
To: Jarrad Whitaker <jarrad.whitaker@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 4:55=E2=80=AFPM Jarrad Whitaker
<jarrad.whitaker@gmail.com> wrote:
> Hey all,
>
> A small feature request (and hopefully not a small "tell me I misread
> the docs"!) -
>
> When fixing up conflicts from a rebase / cherry-pick / etc, files with
> conflicts are excluded from `git add`. This is very sensible in almost
> all cases.
>
> However, would it make sense to make a special case for `git add -p` /
> `git add --patch` / patch mode of `git add --interactive`? There seems
> no reason to exclude potentially unmerged files in mode, which goes
> through changes chunk by chunk.

There's a technical problem here. It's not that it's a bad idea, but rather
an issue with how the index / staging-area works combined with how
merging and merge conflicts work.

We'll assume you already know when and why a merge conflict occurs,
so we'll leap right into the internals here: *when* a merge conflict
occurs, Git records this by storing all three (well, technically, at least
two and usually three) versions of that particular file in the index.

Normally -- by which I mean, "when not in conflict state" -- the index
has a single copy of each file that will be in the *next* commit. Git
calls these "stage number zero" (well, in a few places, but usually
it's not called out at all).

Let's start by considering a fresh checkout of some particular commit,
in a newly made clone.  We pick some branch name (main, master,
whatever), which picks out the latest commit that's "on" that branch,
and that commit contains a full copy of every file that should get
checked out (assuming non-sparse mode etc). In order to extract
that commit, Git first copies each file to the index / staging-area,
from that particular commit.  It then copies each file from there to
your working tree.

(Aside: the "copies" inside commits and in the index are in a special,
compressed and de-duplicated form, and since the index copies are
exact duplicates of the committed copies, the index copies take zero
extra space. So while it seems profligate to keep *three* copies, there
are really only two using up disk space: the unchangeable one in the
current commit, and the changeable copy in your working tree. The
two copies are necessary if one is to be changeable.)

The three copies all match up, so `git diff --staged` and `git diff`
and `git status` and so on all claim there are no changes to add
or commit. But in principle, at least, there are these three copies,
and that's how Git likes it.

If we now do some work -- make some changes to a working file
copy -- and run `git add`, what Git does at this point is to replace
the index / staging-area copy with a new *not*-changeable, ready-
to-commit copy of the working tree version. There are still those
three active copies of each file, but now the index and working
tree versions match while both of those versions differ from the
current-commit version.

When you make a new commit, Git makes a new snapshot from
whatever is in the index / staging-area at that time. These copies
are all de-duplicated, so every file that exactly matches the previous
commit takes no space. Only files you changed-and-added take up
more space (which, technically, got allocated at the time you ran
`git add`). The new commit gets added to the current branch, and
the branch name now "means" the newest and latest commit, and
when all of this is done, all three copies of every file match again
(assuming you `git add`-ed all your changes, of course).

At some point though, you run `git merge` and hit a merge conflict.
Git needs to store the fact that there *is* a merge conflict, so that
you can't commit the result until you resolve the conflict. (Aside:
this *might* be a design mistake of sorts. But that's the design.)
And now we get into the *way* Git stores this fact: Git takes the
three versions of the to-be-merged but conflicted file, and stores
*all three* versions of that file in the index, under the name the
file will have once the merge is resolved.  These three versions
get numbered: stage 1 is the "merge base" copy, stage 2 is the
"ours" copy, and stage 3 is the "theirs" copy. (At most one of these
three higher-stage copies can be missing: in an add/add
conflict there's no stage-1 version, while a modify/delete conflict
means there's no stage-2 or stage-3 version.)

Git attempts the merge and stores the messy, conflict-ridden result
in the working tree. But let's go back to our earlier view, where there
were three copies of each file: the HEAD (current commit) version,
the staging/index "stage zero" version, and the working-tree version.
But now there are *three* index copies, so in the conflicted state,
there are now *five* versions of the file: HEAD (current commit),
merge base (from the merge base commit), "ours" (same as HEAD),
"theirs" (same as third commit), and working tree. Except for the
working tree copy, all are duplicates and take no space except for
the index entries and staging number.

Assuming you resolve the conflict manually as usual, you would then
run `git add`. When you `git add` the working tree copy, Git throws
out the stages 1, 2, and 3 entries entirely and makes a de-duplicated
copy of whatever is in the working tree and stuffs that into the index
as "stage zero".

This is the heart of our technical problem: the existence of a
"stage zero" entry means the file is not conflicted, and the existence
of stages 1, 2, and/or 3 entries means the file *is* conflicted and
`git commit` is forbidden. Git refuses to allow for *four* copies in
the index, i.e., having both stage zero *and* higher-numbered
stages is an error. But `git add -p` would need to do something like
that: have a partially-resolved copy (perhaps containing the same
conflicts that show up in the working tree?) along with the three
base/ours/theirs copies. You would also have to define how this
would interact with other existing Git commands (e.g., `git restore`).

Now, there is of course no technical reason these internal
technical details could not be *changed* in some way, so as
to accommodate your vision. But as things stand now, it's a
problem, and making any changes to the way the index works
is a very big job. If you're volunteering to do it... :-)

Chris

(Additional footnote: Git's original design alluded to the possibility
of having more than one "stage 1" index entry for a file, when there
is more than one merge base, or multiple "stage 3" entries when
doing octopus merges. But this has never been implemented.)
