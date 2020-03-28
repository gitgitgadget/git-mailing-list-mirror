Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26FFC43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 14:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D5D206F6
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 14:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Fcm3zn8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgC1OZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 10:25:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:55377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgC1OZN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 10:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585405508;
        bh=ZofKPEDh6vtV0xow/IBwTcf2aKk8diWJGktx6DNwC6o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Fcm3zn8ux5FSNxfy3bB3icrZiUwbyy+fAId+4F+ouG/ljdRUezkVbaGWeZ1nFqLAe
         nYcKFtMYfmPktdwef0ItkVF7bPJmUHk3JEzfA+8TJM7ANvFTvmmsRDAvIJKrI0+0JB
         9TXq0S+tfwbYq9s1EM9i8cpwbnTK1QyUf6utNf/4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.192]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MEV3I-1j2FyQ0XNa-00G39I; Sat, 28 Mar 2020 15:25:08 +0100
Date:   Sat, 28 Mar 2020 15:25:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     George Spelvin <lkml@SDF.ORG>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Feature request: rebase -i inside of rebase -i
In-Reply-To: <20200326001821.GB8865@SDF.ORG>
Message-ID: <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet>
References: <20200320223015.GA19579@SDF.ORG> <xmqq36a2bpxz.fsf@gitster.c.googlers.com> <20200320233528.GB19579@SDF.ORG> <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet> <20200321175612.GC19579@SDF.ORG> <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
 <20200326001821.GB8865@SDF.ORG>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OzDN3ksBBWCLtETc/8xV4h3IAkkaiGoB+Onl1Ii5KcbfiuhnMsV
 wVx+sbf3jspcfQsCYY5ax6Fk1wza5tiLR1O6DhwmuXq+xvjYhs1gf/3Bo6A2DjrET50SZG0
 /lkSqtawI73NqNeq9IeSi5IGUmOFNd96XYKG+Ju8Rn+HmqqULztJbAijnb1PVe0I56qE/Uy
 pT7Rt82VANs/nKvLz+c4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w6sLPQZL2V0=:iUp8LOvftgomOQqswr3TCb
 ZYRx2yISU8fIILvaCd+1vV443J4IE6A6fkPBU4QIOJ9xiyzlyeH9F0NdUvmSubnA2ffv+ilvf
 SdyJ4zYg2gp+CJfCuFqTWAeIWAFxG8AfP2x36su8hBVe9WYwKZKwIZQlSKB0puCYeQVr+b+UK
 LixUn84J1j13ByV9MKYE1D947YeeJD24H5kWOGhHPHMIcQCurOJ0ik08ALwlD7Yzzd5arrmbb
 mGbrr5zNbHoCKsz5sZ4/MbdHJHueHJcc3cw/0oB5pG2RDwFagrnpjyuii1vqxLtGdxr7kcIRS
 AKGnPE5rJAS7frNOfGpG4F3M9j49v/zv5ZtO9dNeMSLFIEUYvQLU52w5ROGlCrda68QgyzDD8
 CD2d22tiwudbieNVIBiwckjhx4H8yVLTcpC0/zSibpFmD/qu0dtpvVmOlrld6jMRewosn8NYH
 tS/TLsB56LnYfQTnGpMU2Bxb5ZOm8s+Xw8L+674vdZPGzs87MdZthK1MIwQJFydJPbctJbQeV
 B8p7oUslHW1OBB1fj99vS8+O6r8slJ1a959kiFLNm78IgOT4jv5strFdVO/P4JE9DzJnNwsiH
 Zw8doT3J0TSMGAlDTDX2Lix+XJO8PEHmXU5Ny7zPZYIxLP7SlzP0jw74kPyiomUa6+Yy15r6K
 xCYYjb18lfjYIAGRXh5t1QymqaFI8rzg/oPgCxthTPf8UgpX5u2xmgZyhrFF7muGn8QCzG08x
 3qAceX7kLFobgoplTzygzNzd9hilkf9FHZlXGtQwG8f5QMywTsjfYwviA6uOY06N7LuqwM3zw
 gzANMvDc6x6/jRmVCK9VW3gB4bGghC5GXEMiCiXFd4xTShDFqlM7hbjBM9R5UTju7asD2zx6/
 Pzdq/4SufVScOuXe3ry6B95SmNB8sMRCbqbDVeHYFUJl93k7nLbGEYc8kf9IeoVk9qv3z5kT/
 OuNzmIz4VlDBbn1x1Dpx8Yw0NfCl3pDG963GxXVp+2RfJ7RiFAVgMLAjXtkoa9dSeCSX4ATBy
 API5TFkIFaMmadwz8WU09z1UbB8ZBuvvx2nkxXBoQPoBG8vxsWccrm2U5Z/e7jcxjTniM+stW
 3EBK8AAimKdzeMqX0qcI5W98GkOM3Etc9kzXVF7V7/og4EfDCc81PPi8z3VkYFXi9j0GQwOHB
 YhLxsbAsTER3I9c+N0XaPl3ePwTCxu3RRE6r3kMQy1Yd8xBCyLJT7D9hZQPQrTuPeGZminLK+
 Qg+T+71J+svME4M81
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi George,

On Thu, 26 Mar 2020, George Spelvin wrote:

> On Wed, Mar 25, 2020 at 08:26:48PM +0100, Johannes Schindelin wrote:
> > On Sat, 21 Mar 2020, George Spelvin wrote:
> >> My assumption has been that, for simplicity, there would only be one
> >> commit in progress, and aborting it aborts everything.
> >
> > But that does not necessarily make sense. Imagine that you rebase the
> > latest three commits, interactively. Then a merge conflict in the thir=
d
> > makes you realize that the first commit is no longer needed.
> >
> > Enter the nested rebase. You manually re-schedule the failed `pick` vi=
a
> > `git rebase --edit-todo` and then run the nested rebase: `git reset --=
hard
> > && git rebase -i --nested HEAD~2`.
> >
> > Except that you made a typo and said `HEAD~3` instead of `HEAD~2`. You
> > delete the entire todo list to get a chance to restart the nested reba=
se.
> >
> > But now the entire rebase gets aborted?
>
> Um, this example is not persuasive.  If I just leave the excess commit a=
t
> the front of the to-do list, then it will be recreated without change.

There are _many_ ways to mess up a nested rebase, including (but not
limited to) `--onto`, forgetting `-r`, editing the todo list too much in
an editor without undo.

If you are suggesting that a nested `git rebase -i` would not need a way
to abort _just_ the nested rebase, then I fear we must stop the
conversation right here. That's not going to fly.

> (Note that if I choose too *small* a nubmer by accident, I can insert a
> "break" at the front of the list and then rebase --nested starting from
> there.)

There are many ways how a savvy user would be able to work around the
absence of a proper way to abort a nested rebase. The common theme for all
of those is:

- they are all quite involved and require knowledge of internals

- they won't change the fact that it would be seriously negligent for us
  to _not_ offer a way to abort nested rebases.

> Okay, but what if I screw up worse and type HEAD^55 instead of HEAD^5?
> nd that includes multiple merges and other messy stuff?

And Ctrl+C while the nested rebase tries to generate the todo list.

> Well, perhaps a general-purpose optimization could be applied: for the
> first, mandatory, edit-todo, don't actually check out the tree until the
> edit is complete.  When it is, chop off any prefix of unaltered commits
> and start the rebase at the first change.
>
> That would make inadvertently specifying a start point too far back
> reasonably harmless.
>
> It would also provide one level of nested abort in the case of a nested
> rebase.  Until you save the initial todo, the rebase doesn't do anything
> except some bookkeeping.  So you could have that be a special case,
> without providing a more general nested --abort.
>
> The main problem with a full nested rebase is that you need to define wh=
en
> the inner rebase completes and the outer rebase resumes.  I very much
> want the ability to move commits around between the outer rebase and the
> inner one, which makes that distinction ill-defined.

That probably means that we have not thought through the problem, at least
not enough. If we have nested levels, then we might need to record those
nested levels, including the equivalent of `ORIG_HEAD`, `onto` and the
todo list. And of course make them accessible to the user.

By default, we can still work on the "inner-most" rebase. The output of
`git status` can hint at the nested level, to give an indication, as can
the prompt.

We should strive to make this as easy to use as possible, while still
supporting more involved use cases (for power users such as myself, at the
least).

Mind you: I do not necessarily request a perfect design. I just don't want
to slam the door shut when it comes to more sophisticated use cases. I
_really_ would like to have a way to "just redo the latest 5 commands",
for example, but I have no illusion about getting that any time soon.

> > If that would happen to me, I would unleash a whole slew of rarely use=
d
> > words in the vague direction of whoever implemented the nested rebase
> > feature...
>
> The thing is, it's already quite possible to make a mess of a rebase
> halfway through and need to abort after you've put a lot of work in.

Tell me about it!

> I think a more general-purpose recovery mechanism might be more
> useful.
>
> For example, if the --edit-todo included a (commented-out) list of what
> had already been done, then after realizing that you screwed up
> conflict resolve b' and have now committed bad resolutions c' and d'
> on top of it, you could easily rebase --nested and replace b', c' and d'
> with the original b, c and d.
>
> Without aborting and throwing away a' as well, which was perhaps a lot o=
f
> work.

We do have the `done` file, but that does not discern between commands
in the todo list that have been there in the first place and commands that
have been added by the user _during_ the rebase. And of course it does not
reflect any commands that have been removed/changed by the user during the
rebase.

So yeah, something like a journal, maybe.

> >> If I delete any of those five commits, then rebase.missingCommitsChec=
k
> >> will trigger.  If I put y in the list, save it, then change my mind a=
nd
> >> --edit-todo and delete y, it will also trigger.
> >
> > As I said, I am not using that feature myself, so I do not even know w=
hat
> > "trigger" means in this context. It might totally be okay to use the
> > existing code as-is in the context of a nested rebase. That remains to=
 be
> > verified, though, I think.
>
> What I mean by "trigger" is thatthe check would notice a missing commit
> and produce a warning or error, as configured.

I guess `missingCOmmitsCheck` really only kicks in right before/after the
user edits the todo list. So maybe I was worried for nothing in this
instance.

Thank you for thinking about this feature, and for discussing it with me.
I think it will be a really nice feature to have, and I want to avoid
problems with a design that simply won't allow for certain use cases
(remember how `git rebase --preserve-merges` does not allow for reordering
commits, and how the design of that feature simply made this bug
unfixable? I _dearly_ regret not thinking that through).

Ciao,
Dscho
