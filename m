Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357FE20330
	for <git@vger.kernel.org>; Sat, 27 Jan 2024 23:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706398243; cv=none; b=qzgGB4JwbwodNW4LZs3Fq7hXJwagqBGpHxJdleqqUK6SVkC6uMjWN9BS3sg43PVlk51bjpoVsiOWT7wJsTV2xiIJmGqZO15ypGzbK2jufYFyu85VrV2TTcVmZUSBitv8XCnYmJatzBsO6Ror1148Zzr4R93iC3W6G1EbD/10/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706398243; c=relaxed/simple;
	bh=7E0dKVz+MwNcR4cIZIWddk3e1ch+PLHaQ1vjH2YSpTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZA93zAMUTwks7RFX0inCwhA4/bk5+pVBJlK2Vs3sjZdQz04pT5C/xyCLmjtpQ6/p3Ki5kgqs/MQeYS3hEG/92zjjqdUF+89PIpoqTmwuxCNO83lgt4ceTkaaA0hVwqfH+bEdmx1HsWLtWi/22SBnHvy1UR4XrEohjvnUax0OWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPq8M/XL; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPq8M/XL"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf1524cb17so19339081fa.2
        for <git@vger.kernel.org>; Sat, 27 Jan 2024 15:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706398239; x=1707003039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BunjFK5j70y1ZZy7wEJNb5bZ3hkP2fRfSajrIw3NNHo=;
        b=lPq8M/XL3bLtv+RJqdeNUceMXkfj2p/Vgcf4OyY5qPX8kSI8ICHmlUo4kBbtQlgKOD
         FI+neRodcGI1I4GUbMyeLLrjj1qKRczgD81td96ov2Ll8ALOFC4WRTh/Sw7qfuleVLyL
         5TCkB4cL1PiyRq43Iihb+etbbW+PRXCc5uGhKBX4CJiGWDIC330vZauVzfG3pxj/qL2S
         LP2E65tioaXS98wkQOgP7cPyQLK2OoRg1MIuycEd49TdYeWGFNjkRM79RnlXxt/36BNI
         cWtWdL8kdSse/4us2a+Mpvn3d9DEKqYXWerLLdUC5ENu6oUYuBnUmAdZsiODRkgO6SW1
         SF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706398239; x=1707003039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BunjFK5j70y1ZZy7wEJNb5bZ3hkP2fRfSajrIw3NNHo=;
        b=RV8zUvWl4GkFQi30R+C7eCbqcjG5eZAdR652jRUY0LIrqUwrxKbBu6LjjmFWAiUrcE
         sfMMAXENb6H1pjoHN6WLkjc2wMFXF8+1L/DzdcGpIyn3QlDpOdGNLJcrsdVGqrrtVlDD
         wIHtMwgitdLIeXsbgOQSQmkuWZ5frQaDN2QUlngwFqw8twlFgdOhyciV5tYsrKwOlcLU
         J/dpvVvixigQNmNM950sjC/k+pItAZnvCsr13Rkq/cMUD1RLDLFOiac3fzFOX96M4AHV
         U3qoB6ehblynpwbidNj/ObyI7W+5TtnN8t/WhcQTXBJsuU/mJR+qnwc/WdoUVvGW54nI
         aB2A==
X-Gm-Message-State: AOJu0YyBsS8VMK1BU8iq0u8DBEtRp129VbXDWpViG1dt+p6ZDjZYheum
	Po8BqNMNFqMEF6Uc0J/kQVvSLLMYlN54jeo34pUeoHMjRrEkfOfbrhlBOGe0t9z6UAw+vlkYcKh
	gPX/fmtmUs9VWr72JhcOIXGXqEic=
X-Google-Smtp-Source: AGHT+IFuQBmgn/DmKOY7q4HZ4b9l+lsTAl6S1bAT905Y2XgZAlCbQNVO6+VoRFRiPlvnikJ9C9UoRcw1wmyhu94OHSA=
X-Received: by 2002:a05:651c:1c6:b0:2cf:4df2:609a with SMTP id
 d6-20020a05651c01c600b002cf4df2609amr2268227ljn.7.1706398238830; Sat, 27 Jan
 2024 15:30:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119060721.3734775-2-brianmlyles@gmail.com> <7229fe62-cf9b-4829-80ec-c6b44c52163e@gmail.com>
In-Reply-To: <7229fe62-cf9b-4829-80ec-c6b44c52163e@gmail.com>
From: Brian Lyles <brianmlyles@gmail.com>
Date: Sat, 27 Jan 2024 17:30:02 -0600
Message-ID: <CAHPHrSeKY2Ou9VCq6rtADTOwycc0KCTPaCCwtqf94yLi0wj0OQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] sequencer: Do not require `allow_empty` for redundant
 commit options
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[+cc Junio]

Hi Phillip

On Tue, Jan 23, 2024 at 8:23=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Brian
>
> Let me start by saying that overall I'm impressed with the quality of
> this submission. I've left quite a few comments but for a first patch
> series it is very good.

Thank you for the kind words!

> On 19/01/2024 05:59, brianmlyles@gmail.com wrote:
> > From: Brian Lyles <brianmlyles@gmail.com>
> >
> > Previously, a consumer of the sequencer that wishes to take advantage o=
f
> > either the `keep_redundant_commits` or `drop_redundant_commits` feature
> > must also specify `allow_empty`.
> >
> > The only consumer of `drop_redundant_commits` is `git-rebase`, which
> > already allows empty commits by default and simply always enables
> > `allow_empty`. `keep_redundant_commits` was also consumed by
> > `git-cherry-pick`, which had to specify `allow-empty` when
> > `keep_redundant_commits` was specified in order for the sequencer's
> > `allow_empty()` to actually respect `keep_redundant_commits`.
>
> I think it might be more persuasive to start the commit message by
> explaining what user visible change you're trying to make and why rather
> than concentrating on the implementation details.

I struggled a bit with this initially because the motivation behind the
change in this particular commit was driven by a technical issue in my
mind. The side-effect with git-cherry-pick(s) `--allow-empty` and
`--keep-redundant-commits` was mildly problematic, but less concerning
that the future problem that we'd have once git-cherry-pick(1) got the
more robust `--empty` option in a later commit in this series.

I think my problem came down to this commit trying to solve two problems
at once -- the underlying technical concern _and_ the git-cherry-pick(1)
behavior.

In v2, I intend to break this commit into two:

- Update `allow_empty()` to not require `allow_empty`, but without
  actually changing any consumers (and thus without making any
  functional change)
- Update git-cherry-pick(1) such that `--keep-redundant-commits` no
  longer implies `--allow-empty`.

This allows me to better justify the technical change technically and
the functional change functionally, while also making it easier to drop
the functional change if we decide that a breaking change is not
warranted to address this.

> Do you have a practical example of where you want to keep the commits
> that become empty but not the ones that start empty? I agree there is a
> distinction but I think the common case is that the user wants to keep
> both types of empty commit or none. I'm not against giving the user the
> option to keep one or the other if it is useful but I'm wary of changing
> the default.

That practical example is documented in the initial discussion[1], which
I should have ought to have linked in a cover letter for this series
(and will do so in v2). I'll avoid copying the details here, but we'd
very much like to be able to programmatically drop the commits that
become empty when doing the automated cherry-pick described there.

[1]: https://lore.kernel.org/git/CAHPHrSevBdQF0BisR8VK=3DjM=3Dwj1dTUYEVrv31=
gLerAzL9=3DCd8Q@mail.gmail.com/

> rebase always sets "opts->allow_empty =3D 1" in
> builtin/rebase.c:get_replay_opts() and if the user passes
> --no-keep-empty drops commits that start empty from the list of commits
> to be picked. This is slightly confusing but is more efficient as we
> don't do waste time trying to pick a commit we're going to drop. Can we
> do something similar for "git cherry-pick"? When cherry-picking a
> sequence of commits I think it should just work because the code is
> shared with rebase, for a single commit we'd need to add a test to see
> if it is empty in single_pick() before calling pick_commits().

Just noting here for future readers here that you sent a followup email
indicating this was not viable:

> On Wed, Jan 24, 2024 at 5:01=E2=80=AFAM Phillip Wood <phillip.wood123@gma=
il.com> wrote:
>
> Having thought about this again I don't think we can reuse the same
> approach as rebase because cherry-pick and rebase have different
> behaviors. "git rebase --no-keep-empty" drops empty commits whereas "git
> cherry-pick" wants to error out if it sees an empty commit. So I think
> your approach of reworking allow_empty() in the sequencer is the right
> approach.
>
> Sorry for the confusion

No worries. If you have any suggestions for how I might better explain
these changes in the commit message, please let me know.

> > For some amount of backwards compatibility with the existing code and
> > tests, I have opted to preserve the behavior of returning 0 when:
> >
> > - `allow_empty` is specified, and
> > - either `is_index_unchanged` or `is_original_commit_empty` indicates a=
n
> >    error
>
> I'm not sure that is a good idea as it is hiding an error that we didn't
> hit before because we returned early.

I think you're right -- Previously the error could not have been hit,
but now it can. An error is still an error, and we should handle it
regardless of how `allow_empty` was set. I'll address this in v2 by
simply returning the error.

> > Note that this commit is a breaking change: `--keep-redundant-commits`
> > will no longer imply `--allow-empty`. It would be possible to maintain
> > the current behavior of `--keep-redundant-commits` implying
> > `--allow-empty` if it were needed to avoid a breaking change, but I
> > believe that decoupling them entirely is the correct behavior.
>
> Thank you for being clear about the change in behavior, as I said above
> I'm wary of changing the default unless there is a compelling reason but
> I'm happy to support
>
>      git cherry-pick --keep-redundant-commits --no-allow-empty
>
> if it is needed.

I totally understand being wary here.

I've certainly convinced myself that having the future `--empty=3Ddrop`
behavior introduced later in this patch should not imply
`--allow-empty`.

I also _think_ that the existing behavior of `--keep-redundant-commits`
is probably technically not ideal or correct, but could be convinced
that changing it now is not worthwhile. I will defer to group consensus
here.

> > Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
> > ---
> >
> > Disclaimer: This is my first contribution to the git project, and thus
> > my first attempt at submitting a patch via `git-send-email`. It is also
> > the first time I've touched worked in C in over a decade, and I really
> > didn't work with it much before that either. I welcome any and all
> > feedback on what I may have gotten wrong regarding the patch submission
> > process, the code changes, or my commit messages.
>
> As others have mentioned I think it would be useful to have a
> cover-letter where we can discuss the aim of the patch series
> independently of the individual patches.

Absolutely, will do in v2.

>  > [...]> +test_expect_success 'cherry pick an empty non-ff commit with
> --keep-redundant-commits' '
> > +     git checkout main &&
> > +     test_must_fail git cherry-pick --keep-redundant-commits empty-cha=
nge-branch
>
> When using test_must_fail it is a good idea to check the error message
> to make sure that it's failing for the reason we expect (see patch 4).

Thanks for the tip, I'll add this in v2.

On Wed, Jan 24, 2024 at 5:01=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:

> Here are some code comments now I've realized why we need to change it
>
> On 19/01/2024 05:59, brianmlyles@gmail.com wrote:
> > From: Brian Lyles <brianmlyles@gmail.com>
>  >   Documentation/git-cherry-pick.txt | 10 +++++++---
>  >   builtin/revert.c                  |  4 ----
>  >   sequencer.c                       | 18 ++++++++++--------
>  >   t/t3505-cherry-pick-empty.sh      |  5 +++++
>  >   4 files changed, 22 insertions(+), 15 deletions(-)
>  >
>  > diff --git a/Documentation/git-cherry-pick.txt
> b/Documentation/git-cherry-pick.txt
>  > index fdcad3d200..806295a730 100644
>  > --- a/Documentation/git-cherry-pick.txt
>  > +++ b/Documentation/git-cherry-pick.txt
>  > @@ -131,8 +131,8 @@ effect to your index in a row.
>  >       even without this option.  Note also, that use of this option on=
ly
>  >       keeps commits that were initially empty (i.e. the commit
> recorded the
>  >       same tree as its parent).  Commits which are made empty due to a
>  > -    previous commit are dropped.  To force the inclusion of those
> commits
>  > -    use `--keep-redundant-commits`.
>  > +    previous commit will cause the cherry-pick to fail.  To force the
>  > +    inclusion of those commits use `--keep-redundant-commits`.
>  >
>  >   --allow-empty-message::
>  >       By default, cherry-picking a commit with an empty message will
> fail.
>  > @@ -144,7 +144,11 @@ effect to your index in a row.
>  >       current history, it will become empty.  By default these
>  >       redundant commits cause `cherry-pick` to stop so the user can
>  >       examine the commit. This option overrides that behavior and
>  > -    creates an empty commit object.  Implies `--allow-empty`.
>  > +    creates an empty commit object. Note that use of this option only
>  > +    results in an empty commit when the commit was not initially empt=
y,
>  > +    but rather became empty due to a previous commit. Commits that we=
re
>  > +    initially empty will cause the cherry-pick to fail. To force the
>  > +    inclusion of those commits use `--allow-empty`.
>  >
>  >   --strategy=3D<strategy>::
>  >       Use the given merge strategy.  Should only be used once.
>  > diff --git a/builtin/revert.c b/builtin/revert.c
>  > index e6f9a1ad26..b2cfde7a87 100644
>  > --- a/builtin/revert.c
>  > +++ b/builtin/revert.c
>  > @@ -136,10 +136,6 @@ static int run_sequencer(int argc, const char
> **argv, const char *prefix,
>  >       prepare_repo_settings(the_repository);
>  >       the_repository->settings.command_requires_full_index =3D 0;
>  >
>  > -    /* implies allow_empty */
>  > -    if (opts->keep_redundant_commits)
>  > -        opts->allow_empty =3D 1;
>
> I'm wary of this, especially after Juino's comments in
> https://lore.kernel.org/git/xmqqy1cfnca7.fsf@gitster.g/

As noted above, I've split this commit into two, and am open to
discussing dropping the functional change to `--keep-redundant-commits`

>  >       if (cleanup_arg) {
>  >           opts->default_msg_cleanup =3D get_cleanup_mode(cleanup_arg, =
1);
>  >           opts->explicit_cleanup =3D 1;
>  > diff --git a/sequencer.c b/sequencer.c
>  > index d584cac8ed..582bde8d46 100644
>  > --- a/sequencer.c
>  > +++ b/sequencer.c
>  > @@ -1739,22 +1739,24 @@ static int allow_empty(struct repository *r,
>  >        *
>  >        * (4) we allow both.
>  >        */
>
> The comment above should be updated if we change the behavior of this
> function.

Of course, good catch.

> I don't think we want to hide the error here or below from
> originally_empty()
>
>  >       if (!index_unchanged)
>  >           return 0; /* we do not have to say --allow-empty */
>  >
>  > -    if (opts->keep_redundant_commits)
>  > -        return 1;
>  > -

Agreed, will address in v2 as mentioned above.

Thanks,
Brian Lyles
