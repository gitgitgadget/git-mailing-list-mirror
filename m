Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8433EC2BA16
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 12:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D884206CC
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 12:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KwnZ+DBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgDDMjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 08:39:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:44917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgDDMjc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 08:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586003966;
        bh=EO5MQYu82thmbNEynqmNgvxF1t8enmnCD5YSzvPXx/s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KwnZ+DBeDXK1jKcWk19TpGODb9ECpU9hMJaFuAV4teDQhTGLpzMc2qb2PjulUus93
         j1Zu5QpRKAXRC4gUPyjI7hDQ98k7VWrzwvGTuOm4jXBJdVN1xGdGvagdYrt5NMb6IX
         uJWkclo/M5XZyZUhpRtd8GeIx1bUeQ0iCCZcHrf4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.7]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MrQJ5-1j0iKH0ULf-00oWiW; Sat, 04 Apr 2020 14:39:26 +0200
Date:   Sat, 4 Apr 2020 14:39:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     George Spelvin <lkml@SDF.ORG>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Feature request: rebase -i inside of rebase -i
In-Reply-To: <20200328163024.GA26885@SDF.ORG>
Message-ID: <nycvar.QRO.7.76.6.2004041417420.46@tvgsbejvaqbjf.bet>
References: <20200320223015.GA19579@SDF.ORG> <xmqq36a2bpxz.fsf@gitster.c.googlers.com> <20200320233528.GB19579@SDF.ORG> <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet> <20200321175612.GC19579@SDF.ORG> <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
 <20200326001821.GB8865@SDF.ORG> <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet> <20200328163024.GA26885@SDF.ORG>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yfBjdzrlNFxspikOwLG7HHGhw/++JuA59P0zr0lmWOD9dxFSUp9
 8V0N4hun4jRzcC4pxIE9SeyYDQmOXmWHC03YgHREdtV5shWhsvPuJq5Vc4Gv/L+68IWB3xB
 AQvTKumrVe/hV0GIj7/Hs+Te5P7ITyrgVAAQh/TXuBmIyuVgkMiw7/FJ3Z8hWjFpVmsXkej
 pmlipJi1IjQIfgvAhycGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BD2hjSup+RY=:Kvh+JKGunf/Cpig4LVIprW
 koNanrHggh7qIPbmahAlHxKeSDvkctv5yD6Uc4DcrPKqRHbNXkTeH22FQuiOC1HTdsTXK998B
 uCwuvFsBKHT0zS0+1L5YKlZ4EValzLz9WVmPNrrnRgAGxWx/Qnuk4GqTF0M5Ga5ZqKQtuI2Cb
 DyWn3KAIL0B4l9bfnOhqkDFJ4FxjBMeYh7a1lDkKoVKyWsGYlal4EXdCT5u6JAsQQIF1V4Wps
 pNARyeBggCQ5lcSh20Fx1+XOcXVuXBVPSh+2udE1gfTX+R6aP3ADtxzN9BAuiezgex2tJLuPO
 GV8O1s49sv3zoM6xnoRe2tesGd7ik2NHuIjicmZcrfplLNU4jdbfsN3b7KXEZmPBqtCcc+DUe
 DGAl1FPIeHb244OVvvPMLKUWrTY6cJ12TPcAJBpZENiKR2eZW1PrdYv1nG9psPNHPdF8TBLjg
 qzQmwO5UxgoLjTqhA2aeWrl+XT33EnTcoQjb0JTr5EMrHfBl+LqWD1aoTgQ95x0TTRWPeqzok
 iZ5zaew+0QNgNxIXdnFioLMkD5UIoVKY10IlpQ5OcuFyVNJWVC4JfkEcRDNX1ZX9H0FgPVhzk
 5TQzJtkGEHmxALiO+eqF/VWmYoI+yo9CPHP17gaZOrjSnL5jBhmeKDBNtvxT+5SXSxhlSCSNA
 1rNnoIrbD+5uzoRejyWAtvQDEoJiC8jAPI1xDuURNNgRIplIbhViOofQv0jQ5iStE0eqPJdOS
 DJbdGMv6JkMRXr2bqM21d+mPmxvOTi6MW0dt/aOlEFemvjf/T+oSDNH1L+cyxrFHO/QaAs8vE
 isLaZS8Nj17O7dqhJ4RqKVnLylo8EcGXnl8UzwVuofOO9W2Tc09jzJSAqqWIrA/z5i5p5yy52
 xwRvIGIcdgnZT851PP0RZpO49VRJfrUSAvuLNZqXuBK7sY1gtyh2dt9v/ubPHQAvx0y8evlvn
 sowVD5JYNWcO3tY6U5sdzBWGs9dOPtdMwaRxjmBf7zJ2UUxaHP9mHYZH7bJzlD093dK71+GO7
 x1QKlAdp9EU5ABrEsMzzY4P53C6gJSq4GBTKfZ8AmmSbbSMS4qxfDcgYlKX4dTkQcfTZ3uzfj
 ObNdPJ8TMLh/kkhlhV2K/lDmVgrVDHu+rUDSFx6nQzFdYdllHXeyMIsCsHrIxFN6iJzA6Rjre
 l8lFys5tclbFxWTpeWu9yXXEraZOxGMurIWlAQesgn828dIbsV4N9iQmOZT5+WeU7+0XTC2uv
 ZLOMEQkhm0ej+1sxa
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi George,

On Sat, 28 Mar 2020, George Spelvin wrote:

> On Sat, Mar 28, 2020 at 03:25:06PM +0100, Johannes Schindelin wrote:
> > There are _many_ ways to mess up a nested rebase, including (but not
> > limited to) `--onto`, forgetting `-r`, editing the todo list too much =
in
> > an editor without undo.
> >
> > If you are suggesting that a nested `git rebase -i` would not need a w=
ay
> > to abort _just_ the nested rebase, then I fear we must stop the
> > conversation right here. That's not going to fly.
>
> Yes, I'm seriously suggesting that.  My arguments are:
>
> * The benefit is limited, because you can do pretty much all the
>   same things with just plain --edit-todo, and I don't see the
>   point of handing the user a loaded gun and ensuring they can't
>   shoot themselves in their *left* foot.

No, the benefit is in getting out of a fix without having to know
implementation details.

We do allow aborting rebases, so users will rightfully expect to be able
to abort nested rebases, too.

> * The cost in implementation complexity is considerable.  Even the
>   *semantics* are awkward.  In particular, if you reorder patches
>   between the outer and inner rebases, how do you define the end of
>   the inner rebase?

The cost of Git's implementation complexity is also considerable. That on
its own is not a reason not to do it.

Besides, there are quite a few ways to achieve this on the cheap, so I
would even context that it is too complex.

One very trivial idea, for example, would be to rename `rebase-merge` to
`rebase-nested-1` (and if that exists, find the next `rebase-nested-<n>`
name and use that instead). Then run the nested rebase as per usual. Upon
conclusion of the rebase (or if the user aborts it), rename back and
continue.

That approach has the advantage that nested rebases can use different
options (such as a different merge strategy) than the enclosing rebase.

> Now, I *did* agree that being able to abort just the nested rebase
> *from the initial todo edit* is useful and achievable.  That can
> be handled as a special case.  It's allowing "git rebase --abort"
> from halfway throuigh the nested rebasethat introduces all kinds
> of hair.

This is too narrow a view. If I run a rebase, in the middle decide to try
a nested rebase, and half-way through realize that the nested rebase was a
bad idea, you want to _not_ give me a way to return to the enclosing
rebase.

That is a bad idea.

> >> The main problem with a full nested rebase is that you need to define=
 when
> >> the inner rebase completes and the outer rebase resumes.  I very much
> >> want the ability to move commits around between the outer rebase and =
the
> >> inner one, which makes that distinction ill-defined.
> >
> > That probably means that we have not thought through the problem, at l=
east
> > not enough. If we have nested levels, then we might need to record tho=
se
> > nested levels, including the equivalent of `ORIG_HEAD`, `onto` and the
> > todo list. And of course make them accessible to the user.
>
> I worry that's too much conceptual complexity being foisted on the user.
>
> > Mind you: I do not necessarily request a perfect design. I just don't =
want
> > to slam the door shut when it comes to more sophisticated use cases. I
> > _really_ would like to have a way to "just redo the latest 5 commands"=
,
> > for example, but I have no illusion about getting that any time soon.
>
> The big use cases I see are:
> - Wanting to back up in the current rebase, "quilt pop" style.
>   Many times I've found a hunk in patch #4 that should have been
>   part of patch #2.
> - Wanting to move the base back a bit further than originally
>   planned.  (This is often an alternate form of the preceeding;
>   I find a hunk that should have been in patch #-2.)
> - Wanting to rearrange commits across the current commit.  I've
>   gone and edited patch #4 and introduced a dependency on patch #7.
>   I want to move patch #7 back so that my revised #4 can be tested.
>
> I think of the feature as an "edit-todo" that includes some already-
> applied patches.
>
> >> The thing is, it's already quite possible to make a mess of a rebase
> >> halfway through and need to abort after you've put a lot of work in.
> >
> > Tell me about it!
>
> Thus, my comment above about protecting the user's left foot.  If
> they still need to be careful to not shoot off their right foot,
> are we saving them any mental effort?
>
> My goal for the nested-rebase feature is that it can be useful for
> *recovering* from such messes.  Back up a few steps to before the
> trouble started, but *not* a full abort.

That might actually be better accomplished as a `--rewind` as suggested by
Phillip. It does not necessarily need a full-blown nested rebase.

But as Philip hinted at, this might be quite complicated in the
`--rebase-merges` case, as you cannot necessarily infer the correct
labels. Example:

	label onto

	# Branch: one
	reset onto
	pick first
	label one

	# Branch: two
	reset one
	pick second
	label two

If you try to redo both `first` and `second`, how on Earth should a nested
(or rewinding) rebase figure out that it has to re-label `one`?

Done right, this will be a super useful feature. I will use it all the
time. It has to be done right, though, and not limit me in annoying ways.

> >> I think a more general-purpose recovery mechanism might be more
> >> useful.
> >>
> >> For example, if the --edit-todo included a (commented-out) list of wh=
at
> >> had already been done, then after realizing that you screwed up
> >> conflict resolve b' and have now committed bad resolutions c' and d'
> >> on top of it, you could easily rebase --nested and replace b', c' and=
 d'
> >> with the original b, c and d.
> >>
> >> Without aborting and throwing away a' as well, which was perhaps a lo=
t of
> >> work.
> >
> > We do have the `done` file, but that does not discern between commands
> > in the todo list that have been there in the first place and commands =
that
> > have been added by the user _during_ the rebase. And of course it does=
 not
> > reflect any commands that have been removed/changed by the user during=
 the
> > rebase.
> >
> > So yeah, something like a journal, maybe.
>
> I was thinking of the "done" file.

The `done` file will not record what commands were rescheduled, so you can
end up with "double entries".

> At a low level, we already have the reflog, and giving the user yet
> another transaction log to remember is undesirable.

The reflog does not record `label` commands.

In other words, neither will give you what you need.

If you want to have a record what the todo list looked like, and what
`HEAD` was, at the beginning of a nested rebase, you will have to actually
record both.

> If we just added the original commit ID to the automatically
> generated reflog entry, si it also records the higher-level intention,
> that might do it.  I.e. change
>
> bc56134cfe278 HEAD@{3}: rebase (pick): wilc1000: Use crc7 in lib/ rather=
 than a private copy
> 	to
> bc56134cfe278 HEAD@{3}: rebase (pick 01cb7b5b7851): wilc1000: Use crc7 i=
n lib/ rather than a private copy
>
> Oh!  What if we recorded, for the duration of the rebase, the todo
> list state corresponding to reflog entries?  (Or, equivalently,
> the reflog state at each step through the todo list.)  Then we
> could back up the rebase with just a reflog entry pointer.
>
> I like this precisely because it doesn't give the user a new entity
> to keep track of; it just makes an existing entity more useful.
>
> > Thank you for thinking about this feature, and for discussing it with =
me.
> > I think it will be a really nice feature to have, and I want to avoid
> > problems with a design that simply won't allow for certain use cases
> > (remember how `git rebase --preserve-merges` does not allow for reorde=
ring
> > commits, and how the design of that feature simply made this bug
> > unfixable? I _dearly_ regret not thinking that through).
>
> Definitely, let's think it through.  But remember that "perfection
> is achieved, not when there is nothing more to add, but when there
> is nothing left to take away."  KISS is a design *goal*, not just
> a necessary compromise.

Right. I am not even talking about adding features. I am talking about not
chiseling away the features that I _need_.

Ciao,
Dscho
