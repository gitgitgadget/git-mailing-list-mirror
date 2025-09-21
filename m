Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC62BE7A1
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758463614; cv=none; b=GzyPSY8KXjxogK092VteUhiqxJgyz6Vqlma0QApXM7FbjQK3cUtOG7aRxfiUONDrTU1MtssQCokkMLL2PPhND1TEws21CbxKJ+zCobwzOB3Q1nRAqTkd10bXIzukp5cXEhHF18eXh4bESePwk9nuH+1HdM0ul9C3F92M/uYZooo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758463614; c=relaxed/simple;
	bh=7ZvrxewKSoCxWOPeYx3I0zQq37djJAAU9WchlvGK1vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2PC7824ImsRKOize4cFP1lULT4AJaEFGyav2zi9yXY9Ux3Y/fybCej39zfQzdoAJHb8+C+KyhPEgA8hQc8fUoHkMxgOZCh1FVfHqqGYF/zeILcbbTzh49kU09+tetm93P62MQi1HOsilyjFFCInWP6zv6dwpd0uSPpMAKXLLZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeQQ068O; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeQQ068O"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-367444a3e2aso11703371fa.2
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 07:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758463610; x=1759068410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mVk/tD9PcwCbcCb225UE74b0Mniy6/B3D64xvN6eNw=;
        b=eeQQ068OOL7ECvWAF9UYgtPvTY40uvss0yv+zzsWtvryrMSvPG3Lz/Df5/FU5yHm6h
         fClccFMYOcxcBvL+qHPdRMWRBRbXPRaXwCYtxJXSs26hGKdm5/5Ou8i/74q4bndOIKnN
         g/WqUHGjyZISH+ZuHv5E+7N4gqhsBmqfFRk1F6fkQElPbrfZJvhpGhyLE1PolVmd9xT7
         Ha6s31z4XlxFd5o7DjWM6VcP/58gWvbvFTcuZyiU+wA518CVVJQ3217/RRopUhOiXTxB
         3eGGgq2uTwrYno4axL0atXFIkxCpcwE9btExC6gTkO3bvXr1SN33W+APJ+nOkPvtSs39
         OR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758463610; x=1759068410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mVk/tD9PcwCbcCb225UE74b0Mniy6/B3D64xvN6eNw=;
        b=TE49vWUQXGZW4NB7kRQjeWH2QVqljHLIR+3BQ+/OMIHdpk7+Am09Qr9r6TX73ba4Bp
         zdXl51T3Lcy7m07flr2oNI6UAeygGDDVIYAZOiLxVboWKAe/OkyeUjwrbzWTOlJItqC0
         IDEEro6wYerLx8EGqIpn0yTl62kAicrEMN9B9JJed6NHBrOhKeOLs/0L92JbTHYG781J
         f/6dAk3sCIwYmW5pzRlpKxvL+lfIgQ+NK0ds8oP5TWATVZsV3R+xkLAd3ukCuqFEUjqY
         //6HqptH5+tfQgPH/Q+11n6rhXE6+XYPsmWxGqGi3x2HEy1VPLeIEs4oJLPYxdpNRvo6
         M7eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH9rv3XDSFDxY+NwBChNtoW2gB0Z59Dstr50F5p+H4jT+XgP8Z57wNxnWQQF5lwZ1QG+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEfsoBfob1OTvwa7nKMDbk8MofGGvcwfXBrWhPRO1ngvxRvpcB
	qCkmUO4GQyANhjZLCicUzl6Y14J5wCsRzw3PDw3ZmcrrXQQc+FB8woSyYBEim7DiQ7nkzFaGwK6
	XHILA3jHC9dcfMTzvdL9aO4J1q1nnIiVawDvx
X-Gm-Gg: ASbGnctBQLiUQUWugi4CEkwDZlcC2Hyxio03noORTjOq7Jlt4AvydQZMZnubv7js+25
	rzSAGV++FWkGIG99SPkiviXnUaJbOR4vi+4hAwQ33AYxHvfQca2t8Vdq0KFTudwQChMcgI+Ok7A
	T7ztBQF8f3yqwONRsB81ff6fV8bgier9Oe/lzudGxvFd3Z6Slg0swi3RqWnMADofcLiqv7gDK3t
	Dv5
X-Google-Smtp-Source: AGHT+IGTVj1IsgOqcYf/eDe2XPTsUndxiI33MyVxdtWnSFUA5Clvcbg/CyaQQkRWEozZCzV4kxeomIN68bYJ01GqWI4=
X-Received: by 2002:a05:651c:3051:b0:361:3594:2b2c with SMTP id
 38308e7fff4ca-3641a214c62mr22049211fa.21.1758463609890; Sun, 21 Sep 2025
 07:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACEPZDXGGn0S_8PpEc=BVHhvyuZhWfiDmbxNOK7iPWJOj1jrXg@mail.gmail.com>
 <aMnhSm5QSdRwiJds@fruit.crustytoothpaste.net> <CACEPZDU2Bu2c9RFBwD499-UUNyQGuRRXNbMx0aBrqwGoc=4EhQ@mail.gmail.com>
 <aMyGHriNpmekoqD5@fruit.crustytoothpaste.net> <CACEPZDWgoa18LAhzOzu__jy8ssgR8-PmZb6gmDzCS=q6f25=wA@mail.gmail.com>
 <CABPp-BEU-DzNtyeC0j9OKJhqnmOw18TXvCwmmPjZL33Hp=gSUQ@mail.gmail.com>
In-Reply-To: <CABPp-BEU-DzNtyeC0j9OKJhqnmOw18TXvCwmmPjZL33Hp=gSUQ@mail.gmail.com>
From: Antonio Mennillo <antoniomennillo87@gmail.com>
Date: Sun, 21 Sep 2025 16:06:12 +0200
X-Gm-Features: AS18NWDM7LwgC1fliKiBjRQh9i0g0GzdLcPUjQVNEe4Eh6aWr3QM0lhN0464ZmY
Message-ID: <CACEPZDUYKhRBB9Te+dn8fdgDtuo_gHdmxqGBMvp+xG+GEiYc3g@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BRFC=5D_git=2Drebase=2Dclean=3A_mitigating_a_=E2=80=9Csemantic?=
	=?UTF-8?Q?_conflict_cascade=E2=80=9D_during_rebase?=
To: Elijah Newren <newren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for the duplicate earlier, I realized my email was rejected by
the mailing list for being HTML, I have no pc available now. Resending
in plain text

Thank you again for your detailed and thoughtful response. I apologize
for my delayed reply. I'm currently traveling and away from my
development environment, which is making it difficult to properly
address all the important technical points you've raised.

I don't find your emails as negative, quite the opposite, I repeat:
it's precious insight and experience sharing.

Please expect my detailed response by Wednesday at the latest. I
appreciate your patience and the time you've taken to engage so deeply
with this proposal.

Best regards,
Antonio


Il giorno sab 20 set 2025 alle ore 21:14 Elijah Newren
<newren@gmail.com> ha scritto:
>
> Hi,
>
> On Fri, Sep 19, 2025 at 2:17=E2=80=AFPM Antonio Mennillo
> <antoniomennillo87@gmail.com> wrote:
> >
> > Hi Brian,
> >
> > Thank you again for the feedback, it gave me a fundamental piece of
> > puzzle about Git's design constraints that I hadn't fully considered.
> >
> > You're right about tree-sitter being inappropriate for Git core. That
> > approach is too narrow, covering only specific languages. My v2.0.0
> > already prioritizes Git's existing plumbing to track content changes
> > universally, with tree-sitter as an optional enhancement. This stays
> > content-agnostic and removes that which I can define as a source of
> > nondeterminism and heuristic complexity that it's elegant to avoid.
> >
> > To summarize the mechanism:
> >
> > 1) Squash the feature branch into a single commit: temporarily
> > compressing the branch makes all internal semantic dependencies
> > visible at once, avoiding cascade conflicts during step-by-step rebase
> > with non-atomic commits.
> >
> > 2) Resolve conflicts once with full context: the semantic issues are
> > "suspended" in this unified state where everything is coherent.
> >
> > 3) Restore original commits by replaying saved diffs: using a
> > hash-based approach with git's native diff/apply machinery, the tool
> > remains file-type agnostic. The restored commits may still break
> > individually (e.g., won't compile in isolation), but the branch is now
> > rebased with granular history preserved.
>
> I don't understand how this is possible, other than in trivial cases.
> Lots of questions:
>
> How exactly is replaying the saved diffs supposed to work?  Replaying
> those diffs would run into conflicts, otherwise you wouldn't have been
> trying to search for a modified strategy in the first place.  How do
> you resolve those?  Are you assuming all conflicts are orthogonal,
> i.e. that the conflicts from patches A and B are never on overlapping
> or even nearby lines to each other?  In such a case, there wouldn't be
> any "cascade of conflicts" to resolve anyway, so the approach would be
> unnecessary.  And if this isn't true, then I don't see how you can
> resolve all the conflicts at once and magically split them out into
> separate commits and replay things in a way that doesn't have
> conflicts -- at least not without further human intervention.
>
> And that was focusing on content conflicts.  What do you do with
> non-content conflicts, such as file mode differences, file/directory
> conflicts, symlink/submodule conflicts, rename conflict, directory
> rename conflict, etc.?
>
> But going back to content conflicts, are you somehow sidestepping the
> need to assume orthogonality?  Perhaps when you attempt to replay and
> hit a conflict, you just take the end-result for that hunk range for
> the first patch that touches it, and for any other patch that touches
> that hunk range you simply discard the changes for those since they've
> been squashed into the first patch?  Or something similar?
>
> As another way to look at this problem, what about cases where
> individual commits being replayed will conflict, but merging the end
> result has no conflicts?  (In other words, only the intermediate
> states had a conflict of some type -- a simple example of this is
> someone making a change and then shortly later reverting it.)  In such
> a case, by resolving conflicts only at the end, there was no
> resolution of the conflicts experienced by those intermediate states.
> What do you do there?
>
> What about cases like
> https://git-scm.com/docs/gitfaq#Documentation/gitfaq.txt-IfImakeachangeon=
twobranchesbutrevertitononewhydoesthemergeofthosebranchesincludethechange
> (both sides of history make a change, and one side also reverts that
> change) -- by merging the squashed result, you'd end up with the
> change being applied, but when you try to split it out into separate
> commits, you have "apply the change" followed by "revert the change"
> -- how does that result in the change being applied in the end result?
>
> Are there cases where your algorithm feels indistinguishable from
> squashing all the commits, having the user resolve conflicts, and then
> randomly assigning the hunks to a completely new set of commits
> (beyond the obvious differences in commit messages and perhaps number
> of commits)?  Every algorithm I can think of for automatically playing
> existing commits while only resolving conflicts at the end would seem
> to sometimes suffer from this kind of downside, but it's entirely
> possible I'm only thinking of a few brute force algorithms and I'm
> missing something clever that you might be doing.
>
> > To address your header file example specifically: when common.h no
> > longer includes stdlib.h after rebasing onto main, you would indeed
> > need to add #include <stdlib.h> during conflict resolution. With my
> > tool, you'd add this include once while resolving the squashed
> > commit's conflicts. The fix then persists through all restored commits
> > - so instead of potentially fixing the same missing header multiple
> > times across commits during a normal rebase, you handle it once.
> > You're correct that the tool cannot determine which specific commit
> > should ideally contain this fix (that would require compilation
> > testing), but it prevents the cascading resolution burden while
> > preserving the granular history.
>
> I think there may have been a misunderstanding here.  The purpose
> wasn't granular history, it was meaningful logical commits; those tend
> to come in granular sizes, but granularity was more of a side-effect
> rather than the purpose. Having a disfigured granular history is quite
> different than meaningful logical commits.
>
> > The key point: this doesn't fix non-atomic commits. The semantic
> > problems remain if you examine individual commits. But it prevents
> > these issues from causing redundant conflict resolution during rebase
> > by compressing the timeline of the branch in a single instant "t"
> > where the semantic non-atomic misalignment appears simultaneously.
> >
> > The tool trades ideal per-commit correctness for efficiency in
> > real-world scenarios where atomic commits aren't always achievable
> > (junior developers, emergency fixes, legacy codebases).
>
> I'm pretty biased here, but let me take exception with your wording
> that these are not achievable cases.  I'm going to push back on that,
> rather strongly.  In fact, I'd go further and say that legacy
> codebases are where logical small commits make the *most* sense
> (sometimes with small new projects the "why" and the "what" you're
> doing is obvious and so there's not much to write in a commit message,
> and anyone can follow along, whereas in a legacy codebase you need to
> carefully document why you are making changes and ensure each change
> in isolation makes sense so others can figure out why each line of
> code does what it does).  In regards to junio developers, letting
> junior developers develop bad habits (and even facilitating such) just
> leads to them later being senior developers with bad habits; I think
> it'd be better to take the time to coach them on proper practices
> instead.  And in the remaining case, what you describe sounds to me
> like a rushed emergency fix, and I feel like rushed emergency fixes
> result in more emergencies later.
>
> I understand that many are reluctant to put in the effort to make
> clear, logical commits, but I feel that each of your cases are
> examples of unwillingness or lack of training, not an actual
> inability.
>
> As noted above, I'm quite biased here, and would rather encourage
> people to make clear, logical, easy-to-follow-and-review-years-later
> steps that are documented as commits.  I think tools which encourage
> or facilitate doing the opposite are things that should be shunned.
> (I hate squash-merging in GitHub for this reason, and GitHub's lack of
> focus on treating commit messages as important first-class material
> for review has long bothered me deeply, as I've commented elsewhere.)
> Others are free to disagree with me and pursue their own path, but
> that's my position.
>
> > Regarding expectations: documentation will be clear that this only
> > reduces redundant conflict resolution. It doesn't make commits atomic
> > or understand semantics. It manages semantic inconsistency by
> > compression, intended as reduced dimensionality. The defects remain in
> > history but no longer interfere with rebasing.
> >
> > I apologize if the code evolution seems rushed - v2.0.0 was developed
> > quickly to establish a working implementation of the core concept. For
> > v3.0.0, I plan to remove tree-sitter entirely to achieve complete
> > language-agnosticism. I'll also need to properly evaluate edge cases
> > like submodules and merge commits through integration testing, though
> > the squash operation should hopefully be quite independent from these
> > structures. My testing focus will be on ensuring determinism, proper
> > rollback capabilities, and full idempotency across all supported
> > scenarios.
> >
> > The current implementation is available at
> > https://github.com/anthem87/clean-rebase/tree/v2.0.0 if you'd like to
> > explore the approach.
> >
> > Thanks again for the patience and the attention.
>
> I hope my email doesn't come across as too negative.  I'm a big fan of
> exploring and attempting new things.  While I am biased against tools
> that work against logical & bisectable changes, and I'm worried your
> tool is going to face an awful lot of problematic cases if you
> continue with it, hopefully my email provides more context for you and
> alerts you to some cases you might need to investigate if you want to
> push the tool further.
>
> Even if I am not in the camp that'd be interested in using your tool,
> I am very curious if you have clever ideas for any of the special
> cases I listed above and how to handle them; sometimes any such ideas
> might have ways of being wielded elsewhere.
