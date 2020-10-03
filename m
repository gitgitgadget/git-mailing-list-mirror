Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FB4C4363D
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 08:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFBE206CA
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 08:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="C7QYxjTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgJCIHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 04:07:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:40313 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgJCIHc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 04:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601712439;
        bh=dY2a8mx51xZS8G6H/kzTJJBSA24Tk0RSBjKPmK1sz0c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=C7QYxjTO1ZaudfLpkyHFDhD4hLFWovuC+RbCYCL/jVXHOJPcK2WTq/L0xtl9k6ZBY
         C4PHUaip88c922IIzkBlIZIY7Ai7ncADDVAkMu1QB0MN27BYDiwlzmtAD6+Yu2mWTO
         ANqfAD8nnammqZnTNj89xTgxMotprPbX4Ak+e0zI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.114]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJmF-1klX2y2TLv-00nR4c; Sat, 03
 Oct 2020 10:07:19 +0200
Date:   Sat, 3 Oct 2020 10:07:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
In-Reply-To: <xmqqh7rc8idd.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010030939020.50@tvgsbejvaqbjf.bet>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>        <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>        <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>        <nycvar.QRO.7.76.6.2010021557570.50@tvgsbejvaqbjf.bet>
 <xmqqh7rc8idd.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1oT96rHTCC56jCJfAV9PH55eJ83kvjC5S9T312gK4llEKAKWULv
 +m3aAFEjfvtC0HVVDliqmKa+TdPJHYplLsIDqLiqDSsXbHe+JmW9iS9XpDwpvoPBtou7i8X
 fLDI8Pm4eNSg2z+6wOn0rIBlHiiX9S4taO3LPE3Nih6tBpIB29j4vliP3btlDp6oNWlM8qw
 ZrZoAF9YzQ7/MMkQvzdkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0VBFcTXYcow=:d8Bo/oKQOtf9fR+7bvG4KD
 6dY947YnVh6l/IrlzRHAhpGM2GUyit8KFr/bCNa9nipbpKVClKtFrAX4G5Yne61MhHFiHozyQ
 GCfhUSmQopkybtqgwHO3TS6DbURKoWShMDMLy7FJ+yIBZY/aI7lvXYq5WhJcQYMk6rS3kzcNf
 KYYsZ9ewm6PX27StKdQlUgoU2ok9mU1cuwt9PCCerUj6PjvOZzxgqBYz0JPgELFX63LFKj3i5
 ywE7+AwuvT6gpnWLT4LHWcv5gtVHuJF2mmlaUrkDzdpU9Eq0Vs/hOnMTzyq1VITZpCakr458b
 yXuh6e0LwDC4vsiUiHX0oLOTlsRfmUGAzQfwx6l45Rx3OC+0WeFcIZZZ/O+5c/vt5uYAX4sCo
 BAoHonyRxeK/s2kgzEzsBsGT3j5ccuP9yJG2VrMftXA0SYCePTQXkFVprsbEUQ1B4dk+FAEJ7
 So4sVql6T3R86FJKZqoLm7+jZJLDU9/tBvWX9/1Y4T49vtp6HLsNQ8i3FgfVn8D6+FK+XvNr0
 ECCYUyKVEv7rTJLj14+qN41R0OmVpF521lszak0xRkFI4w3TASJvIC/jC+cG6UOykOHhUDRNi
 a55jgfcMepHKPqyBaIMhVX8VT8uTVn9uDSwnts985ra1yLH3KzwiDPEGubkbyhMTxb9EBDmIo
 TJy+cDmz/U0NbQ4jKsEUt6YcAF4Lx7Kr3GvSgP/PPODrmRfdUDl+yhpcuXUlHtdU07qqFmCrD
 NoKfYrVu1usyc2w1r8CTH6DjRb4GJk49ohf/PXQBjT2AhqyIKC8JA+6rZsqj8nRdZXV4FcKLc
 lKdWAX6Vn8lggEG5YHAc0Xo+hoXd9v4yVmnZzb7IJqrtecgQJntrpzKeQMd+Bti5VCZdajV0g
 V5mFQHqKiFsBNpS66a7Se4T+mYZRS8qdD0XHTHk/WMjo/dxI7JPYgfVsS/SkAS73BDae7RV0p
 d++tAVxRRxtxJLd5hDZ0lS01uhtNxvdHcfFXJaIu9BUijqntuv14v8tzFSdn5SJpi/kJjhjdK
 LrC7hvX0biS9ADR90IvZdvyw3Rw/f0rsxlmazvLXGPrxHWBazCJPG4RJJ6ANOuxM7D4d1LRad
 FbcMVKtQiD+N2MPPZDPQMYGCIvjUTw0i4s7sTS61M60q+7GLedi2facHE9xIJ/qg0t/0koRjn
 G6cGP5gg7aNLVUTonxQHjwSP4vhFK5QN+Xl9uDNC6LoiZai4Q3bBf9WFa1ZaA7tClGw9hw/Xs
 TKom8+PBOF5O/MQRSNRHVEnKqDMQyVLGvCIMlog==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 2 Oct 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> This commit provides basic utility classes for the reftable library.
> >>
> >> Since the reftable library must compile standalone, there may be some=
 overlap
> >> with git-core utility functions.
> >
> > My position on this idea to duplicate functionality in order to someho=
w
> > pretend that the reftable code is independent of Git's source code has=
 not
> > changed.
>
> The above may be sufficient between you and Han-Wen, and a few
> selected others who still remember, but please do not forget that we
> are collaborating in the open.  It would help those who are learning
> open source interactions by watching from sidelines, if you spelled
> out what your position is or at least left a pointer to a previous
> discussion.

You're right, sorry.

> FWIW, I think it is a mistake to try to make this directory so that
> it can be lifted out of our code base and used independently, as it
> has to create unnecessary friction to the code when used here.  It
> is not like other code that we are not their primary intended
> audience and we simply "borrow" from them (e.g. xdiff/ & sha1dc/).
>
> The previous paragraph agrees with my guess of your position, but
> perhaps you have something else in mind.  I dunno.

Yes, you were spot on.

I am rather strongly opposed to introducing duplicated functionality.
Rather than spending time on finding half a dozen links to conversations
in the past, let me try to make the case afresh:

I have a very concrete example of the undesirable consequences: the
commit-graph breakage Stolee and I debugged yesterday, where a bug hid in
`in_merge_bases_many()` for two years, hidden by the fact that there was
_duplicate logic_ in `get_reachable_subset()`.

Pretty much _all_ of the code in `reftable/` is _very_ new, has not seen
any real-world testing, and as such cannot really be trusted, in
particular the code that duplicates functionality already present in
libgit.a. Note that I do not claim that Han-Wen cannot be trusted: to the
contrary, I trust him very much (we have a history going all the way back
to Lilypond, the musical typesetter). The code, however, cannot be
trusted, and needs to be reviewed and tested in practice.

The simple fact is that even the thorough review that the commit-graph
patches received did not prevent the `min_generation`/`max_generation` bug
in `in_merge_bases_many()` from entering the code base, and if we had not
had _another_ function doing very, very similar things, that bug would
most likely not have lingered for _this_ long.

Likewise for the reimplementation of the convenient functionality like
`strbuf`. This kind of duplication (in the case of `struct strbuf`, quite
_literally_: there are now confusingly _two_ `strbuf.h` files that even
try to implement the _exact same_ API) is _prone_ to lead to stale, or
long undiscovered, bugs in one of the duplicated implementations.

Which means that we're likely to introduce bugs with those new functions
introduced in `reftable/`. For the reftable functionality, that has to be
accepted. For functions that do the same as equivalents in libgit.a, we do
not have to accept it.

In any case, duplicated functionality is a maintenance burden, and
especially in this case, an unnecessary one at that: unlike xdiff or
compat/regex/, the reftable functionality is co-dependent with `libgit.a`.
Yes, you can implement libreftable as a stand-alone library (including
duplicated functionality from libgit.a, as I pointed out), but you _cannot
use it independently of Git_.

The reftable concerns _Git_ refs.

This is not a compressor that could come in handy in a messenger app, or a
diff engine that could potentially help with a semantic merging tool.

It is code whose entire purpose is to manage boatloads of Git refs
efficiently. Therefore, I see no convincing reason to insist on
maintaining this code outside of git/git.

It would make more sense to maintain parse-options or strbuf or
t/test-lib.sh outside of git/git (because at least that functionality is
independent enough of Git to be potentially useful to other projects) and
we don't. We maintain them inside git/git, and for good reason: it makes
development and maintenance a hell of a lot easier.

And once we agree that reftable is intended to be so integral a part of
Git that it should absolutely have its home inside git/git, all of that
duplicated functionality (with almost totally untested implementations, at
least when it comes to "battle testing in production") can totally
evaporate and does not need to worry us any more.

And then we can start to spend reviewers' time on the actual code
revolving around the actual reftables rather than having to bother with
reviewing, say, a close, but non-identical `strbuf` that might even have
"borrowed" parts of the `strbuf` code and put it under a more permissive
license (I don't know, and I don't want to know, that's part of the reason
why I don't want to review the reftable patches in their current form).

In other words, we can then finally start to actually review the reftable
code on its merits of teaching Git a valuable new feature.

> > Be that as it may, the CI build failures impacted my notifications'
> > signal/noise ratio too much, so here goes (Junio, I would be delighted=
 if
> > you could apply this on top of your branch):
>
> Quite honestly, this close to the first preview release for 2.29,
> I'd rather drop this round from 'seen' and expect an updated topic,
> than piling fixup on top of fixups.

Sounds good to me.

Ciao,
Dscho
