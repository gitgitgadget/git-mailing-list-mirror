Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77612C4742C
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 22:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2007206B2
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 22:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ghA5sfiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbgKJW26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 17:28:58 -0500
Received: from mout.gmx.net ([212.227.15.18]:58963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbgKJW26 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 17:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605047331;
        bh=oNXH/ZqshAX9mkf+6WMG08rZ3XYpEP/lB3pZRvSFhCU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ghA5sfiGpix9vOXl11PoYKqX3J9AWJZcnIVTyWk/opJCMx6tV3lHQDSmp/InufkWs
         vsv+uVvDcVNHbl8vhIYrL2rlg3OrxhuWIlWfOVr7YH+SmCWU14X+ZYLRPiMHfYfU1u
         3O0O8IO1QZVNpFokCzHUX4aqEmjTWDwB265Hy9Iw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDysg-1kUwcR02TM-009zpy; Tue, 10
 Nov 2020 23:28:51 +0100
Date:   Tue, 10 Nov 2020 23:28:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eugen Konkov <kes-kes@yandex.ru>, Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: git rebase/git rebase --abort cause inconsistent state
In-Reply-To: <xmqqft5icsd9.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011102312020.18437@tvgsbejvaqbjf.bet>
References: <1526558917.20201106203213@yandex.ru> <CABPp-BGAJiaU5aeC3sGvp3znQw1esrn9c19gyOZQBymYvNFCaw@mail.gmail.com> <43de6950-a33c-f3da-2a76-72719fef5af3@kdbg.org> <16910030549.20201109134640@yandex.ru> <xmqqft5icsd9.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:W1i+RRdw4t7croIjxNohuYErZygg1VBng14Q2jWef+dTrG6ETYO
 szfL4mBulHOu2Pg5WImkNlQG8/meqOoLY+GL9PZhGvfKzy7moSIJq/himN6Kvs3SSyuMcwB
 2vIfHjdAJ9s5GoY1VgasbXZYzJIKssFpMATTEf0s7wk4zVlqupLhgUCVevNLz2jwOzn1Kj0
 aH20QRRaawyKXqYRP3IGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i7fHL0Csd2Q=:euYqMk8hYegsBoSV7B2iYj
 GeMgG6vCw/hzmzmL3nFUjNdyWg/seplXvIu56h7N9twjhf8ZXfbFtuICdf5OPgAy/K6bJtsWQ
 YWIR0mSzjvClpAarnvc9RS3y19CuuFzy4HJBJj4030gu8z9q1Z/7uFwg+Kzy0cmXmxVSVp7TR
 1isHpN2WG/zmMD1+dimDStZWqvg5y/gfWx/0+nyO9aFEKBZf5f39u6dAF+cNagppW8El2Sjcr
 X/KfVaVTq9N6kKQ/H/oS8X977Ph7Lve0Eii8Fy0m8jnnTqdb/MSjbGd757NWHobnKCBwHOe6g
 ksVnghRlxbKIg/44YKdY479ttbJT/J7LXMBEBvjPvft95raSuhM+qv/5wjOc6Ef5NlzsqgTeX
 gR4PMLDdlMxoYUWYN36LBEfsvaG3rtsW8SpuAQeQ6h2ucTW9q7mxuHm7iRjBlyLVp2f/bdG97
 Ck7pvF+nGYaGWSWmfPh/qeYY4yOfclRFUQpThhJbTWoww1dNay9G1HbbbeUBAJzTC+HRCY2SX
 fjp4OqyXbK4Fe7IH5Pb9I4z/Bw2FgzW+1lc7t1yhdMg9t0UpuxyWOLAv9+ilHsGE62vkUGiw4
 zQOJ9Zfa1b8EuvG2Hc4oUifjsALbMuxt1QMH/eR7YVNCHVeObv3VubcC5rMcAhLungNsEPcG4
 W/8TD0DNI2rB2xP2FSEKDq7IlWjLMLJ9zb+KXDFaNQPcScc1sRwqTirVq6sq4grKRM3BFSgSx
 re/PWhQZtimfYdsJ+UO6Eb7RaNtIc6+6uP/y/5FBaI4i2/SyFp/eDtL4Uinv6f9VvHaZm/KwE
 GcnYYQZMfGlEZMI2fTOcReYo26RMzxSgT/6biK+EPLmMni3h+E2W4JUVvAZh+jXkCtRGvg2yu
 Koq6SsEgg56reWJfyz4nDZq90lfVZvENpDGhNrIa8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 9 Nov 2020, Junio C Hamano wrote:

> Eugen Konkov <kes-kes@yandex.ru> writes:
>
> >> You start at branch dev. Then you use the two argument form
> >
> >>      git rebase dev local/dev
> >
> >> and when you later
> >
> >>      git rebase --abort
> >
> >> then you are not warped back to dev, but to local/dev:
> >
> > I suppose `git rebase --abort` should return me back to `dev`, because
> > this is the state I was before the command. hmm... suppose it will not
> > return to original branch when [branch] parameter is specified for git
> > rebase
>
> Yes, "git rebase [--onto C] A B" has always been a short-hand for
>
> 	git checkout B
> 	git rebase [--onto C] A
>
> which means that if the second rebase step aborts, rebase wants to
> go back to the state before the rebase started, i.e. immediately
> after "checkout B" was done.
>
> I think the root cause of the problem is that addition of the
> "--autostash" feature (which came much later than the two-arg form)
> was designed poorly.  If it wanted to keep the "two-arg form is a
> mere short-hand for checkout followed by rebase" semantics to avoid
> confusing existing users (which is probably a good thing and that
> seems to be what the code does), then the auto-stash should have
> been added _after_ we switch to the branch we rebase, i.e. B.  That
> way, the stash would be applicable if the rebase gets aborted and
> goes back to the original B, where the stash was taken from.

That makes a ton of sense to me.

> Of course, that would also mean that the original modification in
> the working tree and the index may not allow you to move to branch B
> (i.e. starting from your original branch O, and editing files in the
> working tree, "git checkout B" may notice that you edited files that
> are different between O and B and refuse to check out branch B to
> prevent you from losing your local modifications), but that probably
> is a good thing, if "two-arg form is a mere short-hand" paradigm is
> to be kept.  So, "use autostash and you can always rebase in a clean
> state" would no longer hold.

I agree with that, too.

> Another thing we could have done when adding "--autostash", was to
> redefine the meaning of the two-arg form.  Then it starts to make
> sense to take a stash _before_ switching to the branch to be rebased
> (i.e.  B), to go back to the original branch before switching to B,
> and then to unstash on the working tree of the original branch that
> is checked out after aborting.
>
> Note that such an alternative design would have had its own issues.
> With such a different semantics of two-arg form, if a rebase cleanly
> finishes, instead of staying on the rebased branch B, we MUST go
> back to the original branch to unstash what was autostashed.
> Usually people expect after a rebase to play with the rebased state
> (e.g. test build), so staying on branch B that was just rebased
> would be far more usable than going back to unrelated original
> branch (and possibly unstashing).
>
> In any case, the ship has long sailed, so ...

Right. I think by now, the sanest way out of this fix is to do as you say,
stash only _after_ switching to the branch (if that was asked for).

Unfortunately, it is not that trivial to change `git rebase` to autostash
_after_ switching branches: we actually do skip the actual _checkout_
part, for performance reasons, as of 767a9c417eb (rebase -i: stop checking
out the tip of the branch to rebase, 2020-01-24).

My wishful thinking part wants Elijah's merge-ort work to be complete
already so that we can implement a purely in-memory, throw-away
cherry-pick of the autostashed changes on top of the branch to switch to,
and add that as a mandatory check _right after_ autostashing in `git
rebase`. I guess at some stage that will happen.

In the meantime, we might need to disallow `--autostash` with implicit
branch switching.

Ciao,
Dscho
