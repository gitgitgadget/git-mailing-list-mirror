Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4DCC433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321DE2067C
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="N7VEBdYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbgJLTBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 15:01:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:52591 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728702AbgJLTBl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 15:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602529292;
        bh=tCPezd0g4sI0a3siloqq2lHqOZ0KNKhP5CZeEDZ+I/4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=N7VEBdYXWL6TyzjgSgDeM0vfHlHz9AOXu0LOxRxPocyTM+HrMqCx9onO4rGlEihjG
         KI/2WWTbaQYVkwpWfEW7g3Qwm4bdBfiKsppzCe6RIOJ+hTIvl2KumO8KOVMvs+Jd++
         GkQtJBFYFcbwqi/QllZuASTVCazCyfYZJUN+5CNg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.212.188]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Hdq-1kUnA13EC2-002l9W; Mon, 12
 Oct 2020 21:01:31 +0200
Date:   Mon, 12 Oct 2020 21:01:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
In-Reply-To: <xmqqeem3qttu.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010122058100.50@tvgsbejvaqbjf.bet>
References: <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com> <20201008014855.1416580-1-jonathantanmy@google.com> <CAFQ2z_MRzz41x0Osvf6unvQ4Bk-RsA9NxbWZWpfwwJ2D=4Pv7A@mail.gmail.com> <nycvar.QRO.7.76.6.2010111247450.50@tvgsbejvaqbjf.bet>
 <xmqqeem3qttu.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:u+RIWapXEJLzTFfOWfcyxDlMjksshDYuzNPlETXhMdweVecnMd0
 dutrHyOsqijQuW9S2o2aNVZ7JILhbFULsZ0sW6k7omLQq8F7yVo7/omTtwnbIQL6U7IqVNX
 JDzIYEkkv/cR91arONDxPzc9lv5UOOczZf7Dx1BJLYpX0SaLxLMYqepjlEXxvCYO5J3hYsR
 ovjiepfc29wt1k1ziLBAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uKRxaQoyXT4=:hSjPMtcGJ3f/aju5ZUjZ9e
 twZetveQckXFzSG2xFQNbXvbxWkeZ60C7VRarSQV+/vIa4MxyBMm8kd+ruA/PveFlGg0Dnv6Z
 nPpl/chjtwAn7+dVV/UtRVqbvUtuI6Jfhe5kRi+JxZDIh1F/CyH8bs+yQ09uZwcVVkmI23WXu
 dwvsqvj6ydJVsG9slIA36J9VGEw4LYbSr2UBPPMqNzLOSzn4hbf3++qV/PB7EWdCrXWSqWFcZ
 S+DsF6icEqQAaBEY2YIissidsgsC+M0d/HtZ5umDh1nDsVAteoMvRXIccOxVnBU7MiHdwrQIl
 itNADRZrllDgb96eIBtHYtY3tAvGT99yUTO9uFO59i6h/SlnsxbC3OyX57R1wjwDhPp/D/za7
 E4wDlg/xc6vZiLx9/zyV8dIK+hDtVALSEj37aYvooC+qAwhyKM5wSWOfOZnT2Ix7rz39acO7J
 paiXcotmcDj6x8Jhh4bCBBmdLDRQgBDg5pY7lICDd0Q/laKUyiDdrNd0b/hcUXhoFQQQzlprI
 peSmJ/xhrwUjRsJ6AYs2Tq/Jsn2mTGbDIGJLxbytITiJ9IdHb8VGSB1Pzob5gQi3YeV+tpS5q
 p7ivTLic7PGahbF6JlsPmg/uIn+pZmIB5RilmUii+TgRIq2sy1asnxBtO7x1fhUgvhtLCVmjg
 ioAmjn7o6dimB0MPfgWPhYSr+noAuALM8l+SldrRmXwzN6+a3Cu908nQyjabNES+C+MEb0i45
 8RPESh0Dc+T+jevmM0cINWT1F6VsHOpLChiOmBaRQJ3iu6jgmJp9McX/SFFIJvlJWsjYaCECD
 BZiE3FjW+mH+3D3CWba80xSbm+Psy101NfNi8zteE/ZYsGb3uwvY1KO3SwUKhwh5TbhWTO90H
 23fok3X6Lx/Gb4jb00m2hOWJ4iHm/ys4NdY7/9dv/lE5ekB9lrYpcjLEUyzhmcrQvCIOqCfkA
 QY+JdWxlNHsRaRsJNzNAlrZO7/HgQXcdgMEInxIugjJUjfHDL+PmlLKYxPUKudN4oChQ+L5KK
 Z/LapDouUgk3ki6VixRoh+P5Qroop5l55G5kbrvWnQoPXmgVNLvWnSzZfWOEo25UY8jLcUNWG
 f28HCorg+9hwqpHtEVBDBD8NiXmk2uEy3ditZgz5mwQkwDhyPggxmlepH7FmlkA+CyJcJ+PXi
 zNBbWFF6vQp8bMB70ChqBiZXd2zHhnK/P4vk6JgRpA8Z/mZZwbsYF97aYPS3KDvicwAOvn9y7
 0/tmDad3OxiOWPBiFrHHX3uGIJCEX5JoY9hBrmg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 12 Oct 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> FWIW, the duplication is really tiny: according to
> >>
> >>  $ wc $(grep -l REFTABLE_STANDALONE *[ch])
> >>
> >> it's just 431 lines of code.
> >
> > The `merge_bases_many()` function has only 33 lines of code, partially
> > duplicating `get_reachable_subset()`. Yet, it had a bug in it for two
> > years that was not found.
>
> It does not affect the current discussion, but what you are giving
> is a revisionist view of the world.  The latter function came MUCH
> later to do a bit more than the former.  The bug was caused by the
> fact that those that added the latter neglected the responsibility
> of maintaining the former to the same degree when new feature like
> commit-graph were added to the latter.

You're right, I mixed up the direction: by introducing new code, the old
code became under-tested and a bug creeped in that was not detected for
two years.

> The root cause was that the latter one did not share the code with
> the former one when it was introduced.  That does make it appear
> similar to the situation we have at hand with duplicated utility
> functions.

Indeed, and even if this is just one concrete example, experience (and
teachers and instructors and mentors) repeat the lesson that code
duplication should be avoided because it _does_ cause problems.

Thanks for setting the record straight,
Dscho

>
> > How much worse will the situation be with your 431 lines of code.
> >
> > Even more so when you consider the fact that you intend to shove the s=
ame
> > duplication down libgit2's throat. It's "triplicating" code.
> >
> > So I find the argument you made above quite unconvincing.
> >
> > Ciao,
> > Dscho
>
