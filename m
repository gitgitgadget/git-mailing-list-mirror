Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B691AC433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348508AbiA1MfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:35:09 -0500
Received: from mout.gmx.net ([212.227.17.21]:50443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236511AbiA1MfF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643373299;
        bh=XxcuwxFWxSSQ3bwADtwka+5tDfbqjR/p1XXBfRQUTxw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JmLIe8NVdTtqm/Nulmbo8+qOuxLYOBlQ8T757S/cbKqZOdR6SJuVgJYJXypoZ2tvq
         7Y3q1yEot+5VrSr3HHFv+tJrCwhdMH+q3BGpvXggaQRoLRdzJKLPvURMU2ZcbwbKPT
         hJovpB1cXFJoWkcno7n6wEecWXRslcBWAd/hIqYM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.213.181]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MyKDU-1mLLuJ2wSy-00yfbs; Fri, 28
 Jan 2022 13:34:59 +0100
Date:   Fri, 28 Jan 2022 13:34:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] fetch --prune: exit with error if pruning fails
In-Reply-To: <87lez0p1db.fsf@coati.i-did-not-set--mail-host-address--so-tickle-me>
Message-ID: <nycvar.QRO.7.76.6.2201281333410.347@tvgsbejvaqbjf.bet>
References: <20220127153714.1190894-1-t.gummerer@gmail.com> <xmqqmtjh0x5f.fsf@gitster.g> <87lez0p1db.fsf@coati.i-did-not-set--mail-host-address--so-tickle-me>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SQM1BkNzFQ2Lj0Jr8p7SRiOLGIwuyXM6c3zWg0biAyab+e0XOt9
 MJYrzaJsxuJ0unwIMQWxVsHvvEtDCjH9psZQHT8Uf31QB3CGsx4EXI5YQlexpfOfS0WGaK3
 gOTn6PNJQmdiZygulL/0M1jIyvmEnkYhmLQrsQUL5W/xRllo4rOL2VHvUwuhjQUab9mFTDW
 /dzX2pKBJSijgR05vFnxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Oo8sy0MUVfY=:Isx1uOOH8QKFj9u/WLeo6n
 nmenGnRdPFFvaqJsbvZ6sFZPBZE9ZXh2nXCLLEJszjwvhB/xl/6CWicnHNoHwbgPvu5KkNNfL
 nrqlpxSdHiCqU5wkhJ5+CcqnRdyEG+pMEpBdEt3JqyWGFrAlUCY6R32HgaY/EgepaOD0Eod4h
 WkZv14E0hkHBtkHRqw1UiWN/ho34I1xAj+bCq3WXKIaAHWgMAQRCHEAbdTalwafBQFs/V1enk
 O95tegYZ5aiLw0/5FSRheBksCT0fTJU+1QPg63lHjL7jhl1CQ6Hw20967JaeNwXnnVI2N0Hb8
 8awnxnAUmr6jA1Y4s6m1ja+EZCxNqsRFUCbUNKpQFzagvqntqgyNACzh2RAmv49eJR4GT5fH5
 bXLNEoo7yTF6T+rkR4O99EoasOoOoKbuDkjqkV6EmdqbzTy55ierrccJ1lBqR0TX1JE3zrXVh
 bRzAnYLl0CzxMfOOQ77xLeIxO6GhCYVz2ehTT8biVCQL/HljWAD2nvZYkJ34FsWfPyiVec06s
 SfXkG73MgyItVoLSGE1jpQ79TKyqZgMqUwAbZ8U6KgTy6SAM/xoQkDI7j0HHUmA59y03msp1Z
 MCM/NnC28xoKVPqkCMJLDzjlI3F8JzD6RFrgH17XLBesSUGZuyZNqCYBiUlSsBsgUtMQJUnW9
 HpBQDSA6IQdgNXOJ78d9Y2uF+OKZICyJEIXxzn1QZSpipj7QGyIjuV//3AQOLKMddzZhkANxO
 zcT4hnacXtzx4OWiQmt7Fazyhqjtb1pTsTXLaf5nBOxorjaNUKXZExqkLfiG89826KaOmgvct
 RJ68y2G0wLTion/SjwWcpasvEwY3kEDPtiWhgBJWOVnLThNwuD5LG/YGrzqjAge/AQgPZ+iMk
 Nny7xGCKRfddrlqsBWytALKQHwJvzNRCEtAvZbNggIJunhmuitOjnIynkXkl0W2fosXwWv+Ry
 u46uJMuwAwxf6A72grDrlmNlxAjAvfgTqg3hJCjDXv/gXIzZ+YYDI1Nz1tKIVQ3ifEGZqytkL
 vIjr4QNMdgNBjucK+TJOrHm8GOIMHI2iKmwVivMLckOLDlF5OA8rene2aCZtNvs8Ly3oy6dhx
 ePNauAGitDdYxQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Fri, 28 Jan 2022, Thomas Gummerer wrote:

> Junio C Hamano writes:
>
> > Thomas Gummerer <t.gummerer@gmail.com> writes:
> >
> >> +test_expect_success REFFILES 'fetch --prune fails to delete branches=
' '
> >> +	cd "$D" &&
> >> +	git clone . prune-fail &&
> >> +	cd prune-fail &&
> >> +	git update-ref refs/remotes/origin/extrabranch main &&
> >> +	>.git/packed-refs.new &&
> >> +	test_must_fail git fetch --prune origin
> >
> > Is it because the lockfile ".new" on packed-refs prevents deletion
> > of refs but does not block creation and updates to existing refs
> > that it is an effective test for the "--prune" issue?  If we somehow
> > "locked" the whole ref updates, then the fetch would fail even
> > without "--prune", so it may be "effective", but smells like knowing
> > too much implementation detail.  Yuck, but I do not offhand think of
> > any better way (it is easier to think of worse ways), so without
> > further input, I would say that this is the best (or "least bad") we
> > can do.
>
> Yes, that's correct.  New refs will be created as loose refs, so they
> don't care about packed-refs.  However deletions can potentially be
> happening in packed-refs, and that's why it fails when 'packed-refs.new'
> exists.
>
> I don't love the test either, but I also can't think of a better way to
> do this.

Maybe add a code comment about it? Something like:

	[...]
	: this will prevent --prune from locking packed-refs &&
	>.git/packed-refs.new &&
	[...]

Ciao,
Dscho
