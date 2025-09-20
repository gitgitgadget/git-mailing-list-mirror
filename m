Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B75E1D416E
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758395652; cv=none; b=LEeomIstRC6ktr+gpu6ahnpco5KrPJTz1/q0ahaGH3ZryK0nmEn6TpPY3G72BHLhNSGvibeyKMfOz+ygDhN6VgKojjtrZYS7JUI0Am0KcKGK5JmbKbDGHleJkb89KZiSqbwjZM5g3dCvyNMHlDFZwotUXFOet7sBTi3q1fZh+fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758395652; c=relaxed/simple;
	bh=gkRZ39hDY3MZaYq9CCLKBmAH9LfgEBRUSnE82DtwoSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrRZ7ttfdLUc9Z5bS0rBmsB6951jqmKOskfnJiQCBXa2ejLbnd2IsoRoxey7dlMybZhPtJaydSFvnaRiLXcoiRMUfdYWpu8e/9d+y8F9EsCl2OH6OkZQgw9jVHD8ndZFcyOSt1NarwpQuk0p+E8Sp6av7yByMAauOyStpZqE9G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUvqKkDB; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUvqKkDB"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-4242bb22132so30814925ab.3
        for <git@vger.kernel.org>; Sat, 20 Sep 2025 12:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758395649; x=1759000449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTGbD3bF4r2QVkoSFYOxA9S1lwaDVf/6FAdeXhTVl4w=;
        b=AUvqKkDBsnpM6KrOOLCVLSvH4nhzpxfCWumsIZYafdMWLQWyMsudlI94kiXq2+leXr
         3KsV+FH4MKIrgUg3uzCZkk3/CTjaxx13rQGMJllEI2oGwEysUDwaw05dXDYrTINm34bK
         W4Phk+mTiBHTGwodlmVHMCCOLRSfoQ8wHqmDTctX4EDXqNF5GjWr+fz2tK8xCj3Uk23F
         CsAFMKOlAFJXmTwoeIDIYFRbr+46XMyApZqiUc+XL540Vc4IMA3D1pEhBwh76QrTuakO
         1eVeS0krDAdMmoxFU0EEnnruEPflQBprfqhZ2TgmaEARwBAwAwahaO0xE1HEyrJl6i9j
         pFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758395649; x=1759000449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTGbD3bF4r2QVkoSFYOxA9S1lwaDVf/6FAdeXhTVl4w=;
        b=sMYB7S/EhDP65TRmJ2SoiDzBmUV7BIG9Qf4/zVh2FBbo7Uz4O9sSIPImERDvyD6304
         H3s6XKKI+xT49sBNU6pySP7eIs8NPCCcOPAH2SMoxnxO3FQ5PYAp3CSCpR+8q39PAHYF
         JvMpN5oPUwjr+lUvIrAP7nzSTqckwG+GQcoGSxGL4oU0U+gVqntuHdNl/8kKy/+AcKf6
         /QOHeDhj/xXN38p7R2vzJi7qtTaIfOBMs0Z8pJXMaRG9ybKcjXPy8qbta1INtTSzvs6A
         wyYssnI65T4+gzQVZ3gQZGfQ0LtmsfTe9YoATE5L0n2Hd7EuTVj2BjA5pmBtRR7A4Vee
         CR7A==
X-Forwarded-Encrypted: i=1; AJvYcCUXdO5TYeSQEgY99l7zoxjRyxIJ1bnl1qSXVELDABaPwG4LwIEEaVm/FDR0zCaS8bADor8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY17xbk4BqigSNyXu+QIYxYtUv35Z2o3yEd8ereMTU02o+YHDL
	tM0mHjOHapV4Dv24s7b9q/3l7efaa+nvRMboNnIFfeGS7F7BfI/xBiKwvvdgz+yhE+5cxhcrhDy
	PX0xgvQEY+rwBl6jriEoFVcMX29X0tzXa6w==
X-Gm-Gg: ASbGncsh6GEtYoJ5fOK5UTUKJH2k/NVwdM+pkPTioBVuTPv+JWLNVeWyALByOZg91j8
	F5g4nL0BJI0NHtEhZ+ToRg+mAbMUKSOrb43AwIkbNqwU+olbEGG0WHkiIY8UVyTOqkDmWB+ovka
	5zLfK+t83579TrvnAyimsBLajNjxccRkygFtNUrEwqdLvsArPe85FrBhodugd0JmPyVTF64reYh
	wWRPy4ULZo1b/VKSvpZdW7GBLMigE9Bsjz0epc6
X-Google-Smtp-Source: AGHT+IH0Adw81jCSZj0+yXzeRgHmmwGwKi3mSAGSWpE9xlfN/Q7q+Svb9mG5M3hGT8F61Tmbhqxt2JGTQ9QfSqvuJ3g=
X-Received: by 2002:a05:6e02:1807:b0:424:6c1:a778 with SMTP id
 e9e14a558f8ab-424819800bamr109255815ab.20.1758395649050; Sat, 20 Sep 2025
 12:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACEPZDXGGn0S_8PpEc=BVHhvyuZhWfiDmbxNOK7iPWJOj1jrXg@mail.gmail.com>
 <aMnhSm5QSdRwiJds@fruit.crustytoothpaste.net> <CACEPZDU2Bu2c9RFBwD499-UUNyQGuRRXNbMx0aBrqwGoc=4EhQ@mail.gmail.com>
 <aMyGHriNpmekoqD5@fruit.crustytoothpaste.net> <CACEPZDWgoa18LAhzOzu__jy8ssgR8-PmZb6gmDzCS=q6f25=wA@mail.gmail.com>
In-Reply-To: <CACEPZDWgoa18LAhzOzu__jy8ssgR8-PmZb6gmDzCS=q6f25=wA@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 20 Sep 2025 12:13:57 -0700
X-Gm-Features: AS18NWB3d2pyDFKW9aB5qHWCj_O33U58uHU0KJk_qnG7Wtm70BPruKXVU8sUB4g
Message-ID: <CABPp-BEU-DzNtyeC0j9OKJhqnmOw18TXvCwmmPjZL33Hp=gSUQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BRFC=5D_git=2Drebase=2Dclean=3A_mitigating_a_=E2=80=9Csemantic?=
	=?UTF-8?Q?_conflict_cascade=E2=80=9D_during_rebase?=
To: Antonio Mennillo <antoniomennillo87@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 19, 2025 at 2:17=E2=80=AFPM Antonio Mennillo
<antoniomennillo87@gmail.com> wrote:
>
> Hi Brian,
>
> Thank you again for the feedback, it gave me a fundamental piece of
> puzzle about Git's design constraints that I hadn't fully considered.
>
> You're right about tree-sitter being inappropriate for Git core. That
> approach is too narrow, covering only specific languages. My v2.0.0
> already prioritizes Git's existing plumbing to track content changes
> universally, with tree-sitter as an optional enhancement. This stays
> content-agnostic and removes that which I can define as a source of
> nondeterminism and heuristic complexity that it's elegant to avoid.
>
> To summarize the mechanism:
>
> 1) Squash the feature branch into a single commit: temporarily
> compressing the branch makes all internal semantic dependencies
> visible at once, avoiding cascade conflicts during step-by-step rebase
> with non-atomic commits.
>
> 2) Resolve conflicts once with full context: the semantic issues are
> "suspended" in this unified state where everything is coherent.
>
> 3) Restore original commits by replaying saved diffs: using a
> hash-based approach with git's native diff/apply machinery, the tool
> remains file-type agnostic. The restored commits may still break
> individually (e.g., won't compile in isolation), but the branch is now
> rebased with granular history preserved.

I don't understand how this is possible, other than in trivial cases.
Lots of questions:

How exactly is replaying the saved diffs supposed to work?  Replaying
those diffs would run into conflicts, otherwise you wouldn't have been
trying to search for a modified strategy in the first place.  How do
you resolve those?  Are you assuming all conflicts are orthogonal,
i.e. that the conflicts from patches A and B are never on overlapping
or even nearby lines to each other?  In such a case, there wouldn't be
any "cascade of conflicts" to resolve anyway, so the approach would be
unnecessary.  And if this isn't true, then I don't see how you can
resolve all the conflicts at once and magically split them out into
separate commits and replay things in a way that doesn't have
conflicts -- at least not without further human intervention.

And that was focusing on content conflicts.  What do you do with
non-content conflicts, such as file mode differences, file/directory
conflicts, symlink/submodule conflicts, rename conflict, directory
rename conflict, etc.?

But going back to content conflicts, are you somehow sidestepping the
need to assume orthogonality?  Perhaps when you attempt to replay and
hit a conflict, you just take the end-result for that hunk range for
the first patch that touches it, and for any other patch that touches
that hunk range you simply discard the changes for those since they've
been squashed into the first patch?  Or something similar?

As another way to look at this problem, what about cases where
individual commits being replayed will conflict, but merging the end
result has no conflicts?  (In other words, only the intermediate
states had a conflict of some type -- a simple example of this is
someone making a change and then shortly later reverting it.)  In such
a case, by resolving conflicts only at the end, there was no
resolution of the conflicts experienced by those intermediate states.
What do you do there?

What about cases like
https://git-scm.com/docs/gitfaq#Documentation/gitfaq.txt-IfImakeachangeontw=
obranchesbutrevertitononewhydoesthemergeofthosebranchesincludethechange
(both sides of history make a change, and one side also reverts that
change) -- by merging the squashed result, you'd end up with the
change being applied, but when you try to split it out into separate
commits, you have "apply the change" followed by "revert the change"
-- how does that result in the change being applied in the end result?

Are there cases where your algorithm feels indistinguishable from
squashing all the commits, having the user resolve conflicts, and then
randomly assigning the hunks to a completely new set of commits
(beyond the obvious differences in commit messages and perhaps number
of commits)?  Every algorithm I can think of for automatically playing
existing commits while only resolving conflicts at the end would seem
to sometimes suffer from this kind of downside, but it's entirely
possible I'm only thinking of a few brute force algorithms and I'm
missing something clever that you might be doing.

> To address your header file example specifically: when common.h no
> longer includes stdlib.h after rebasing onto main, you would indeed
> need to add #include <stdlib.h> during conflict resolution. With my
> tool, you'd add this include once while resolving the squashed
> commit's conflicts. The fix then persists through all restored commits
> - so instead of potentially fixing the same missing header multiple
> times across commits during a normal rebase, you handle it once.
> You're correct that the tool cannot determine which specific commit
> should ideally contain this fix (that would require compilation
> testing), but it prevents the cascading resolution burden while
> preserving the granular history.

I think there may have been a misunderstanding here.  The purpose
wasn't granular history, it was meaningful logical commits; those tend
to come in granular sizes, but granularity was more of a side-effect
rather than the purpose. Having a disfigured granular history is quite
different than meaningful logical commits.

> The key point: this doesn't fix non-atomic commits. The semantic
> problems remain if you examine individual commits. But it prevents
> these issues from causing redundant conflict resolution during rebase
> by compressing the timeline of the branch in a single instant "t"
> where the semantic non-atomic misalignment appears simultaneously.
>
> The tool trades ideal per-commit correctness for efficiency in
> real-world scenarios where atomic commits aren't always achievable
> (junior developers, emergency fixes, legacy codebases).

I'm pretty biased here, but let me take exception with your wording
that these are not achievable cases.  I'm going to push back on that,
rather strongly.  In fact, I'd go further and say that legacy
codebases are where logical small commits make the *most* sense
(sometimes with small new projects the "why" and the "what" you're
doing is obvious and so there's not much to write in a commit message,
and anyone can follow along, whereas in a legacy codebase you need to
carefully document why you are making changes and ensure each change
in isolation makes sense so others can figure out why each line of
code does what it does).  In regards to junio developers, letting
junior developers develop bad habits (and even facilitating such) just
leads to them later being senior developers with bad habits; I think
it'd be better to take the time to coach them on proper practices
instead.  And in the remaining case, what you describe sounds to me
like a rushed emergency fix, and I feel like rushed emergency fixes
result in more emergencies later.

I understand that many are reluctant to put in the effort to make
clear, logical commits, but I feel that each of your cases are
examples of unwillingness or lack of training, not an actual
inability.

As noted above, I'm quite biased here, and would rather encourage
people to make clear, logical, easy-to-follow-and-review-years-later
steps that are documented as commits.  I think tools which encourage
or facilitate doing the opposite are things that should be shunned.
(I hate squash-merging in GitHub for this reason, and GitHub's lack of
focus on treating commit messages as important first-class material
for review has long bothered me deeply, as I've commented elsewhere.)
Others are free to disagree with me and pursue their own path, but
that's my position.

> Regarding expectations: documentation will be clear that this only
> reduces redundant conflict resolution. It doesn't make commits atomic
> or understand semantics. It manages semantic inconsistency by
> compression, intended as reduced dimensionality. The defects remain in
> history but no longer interfere with rebasing.
>
> I apologize if the code evolution seems rushed - v2.0.0 was developed
> quickly to establish a working implementation of the core concept. For
> v3.0.0, I plan to remove tree-sitter entirely to achieve complete
> language-agnosticism. I'll also need to properly evaluate edge cases
> like submodules and merge commits through integration testing, though
> the squash operation should hopefully be quite independent from these
> structures. My testing focus will be on ensuring determinism, proper
> rollback capabilities, and full idempotency across all supported
> scenarios.
>
> The current implementation is available at
> https://github.com/anthem87/clean-rebase/tree/v2.0.0 if you'd like to
> explore the approach.
>
> Thanks again for the patience and the attention.

I hope my email doesn't come across as too negative.  I'm a big fan of
exploring and attempting new things.  While I am biased against tools
that work against logical & bisectable changes, and I'm worried your
tool is going to face an awful lot of problematic cases if you
continue with it, hopefully my email provides more context for you and
alerts you to some cases you might need to investigate if you want to
push the tool further.

Even if I am not in the camp that'd be interested in using your tool,
I am very curious if you have clever ideas for any of the special
cases I listed above and how to handle them; sometimes any such ideas
might have ways of being wielded elsewhere.
