Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32CDC433E0
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 20:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B98F206F5
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 20:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="U9flBHb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgGNUaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:30:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:39291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgGNUaT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 16:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594758613;
        bh=ygvw/LVBGdsIM5CcO5Q51bgjbkycBEEVkPe6FxjvcuA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=U9flBHb9aI9ISh496REJNXPe7JX5dofxa24Nvrllzn7AmVCTcj2f5doJDMMdnCfMl
         oN88Uw6gc5a5IgopUb21FhPtj+n29OfnheFwyXdIUjzJB0syfbNW2GHdK2u6rs9dPp
         ADcRtBY9Y6BHU16bK/nSlySSgj0GsHRhS0E5ghmA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.94.224] ([89.1.215.93]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHG8g-1k8eyz2xYO-00DKPz; Tue, 14
 Jul 2020 22:30:13 +0200
Date:   Tue, 14 Jul 2020 22:30:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH] setup: warn about un-enabled extensions
In-Reply-To: <18c65b85-2f2a-ff96-1ea7-e16befa6928f@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007142227280.52@tvgsbejvaqbjf.bet>
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com> <0bede821-139a-d805-934a-142004abaa4c@gmail.com> <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet> <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
 <18c65b85-2f2a-ff96-1ea7-e16befa6928f@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9nitv7rVJu2rxxkFY4m/eastDvWoORDYn6sWOIkxT6Iw8kvunPe
 tV0B3Lsimj1hjHut4OE64tJhB5DYWiSl+thja4jrB4Vn+222QoV3rbvhRoGdIRMsTTGYHdg
 +9eOBjrDXgUNpPVkbNjLSzLvwbT5tQ+u9f/aZMaOguMN14J6xFbE2mDgW6ksFYeOBT0yiSM
 YmKtqsOUwB1u7Hn5LFLtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IKTBpf0M1Aw=:ZFBJjd49fblDL5365gJxI4
 PI0SOIiSRZ5LoGXQPzrWSJOQgRIN/uFbVoN+EHt23Qq7hC+I077xFNAirNCyVUnIQLn0zCvrq
 /fXH4pgYZcxSK29RhJvJ1th2mP8dkkiLDIJOWKo4CYGS6rxhsRg52DG1bt7Ht3wyJYo3kPnmx
 VolvMYvmSQBk/hWNqSLJhAbrNAndz/wjGmO0orfR6TysYdX8YDiHOeBXO0gmTxszYVA3CdQNC
 9nugmcYTgu40RRtiyYHGQluWzdAoBbsz9fz7j275Xy9ObaNqUec1FsMCkRJ/Mjs5IDKmMZDau
 beg580Z3KEabt0U+PsLgONjyeMvWMbRHE4r9TM5mU+d+FUSlrXEPY5BRa6odKLIhzYG5u41Uk
 RXvnFiZwVHx47bE0zG1DPseZmri7sZ7qFp0EDeNUxjBxOffwEqQERBqMsKCgAKxbfMVlaLEod
 tJYwGuTDXtQUF6VAfQ9c2tCH7dJekisO6Qb7fziQQXRF0OEL1IJgbFu/sttvlQJnRtuIS+7rH
 6x5ucN1GrOayDl/6Kra9A803tggGW6e+FBMTc25A4zfVrf0yPM5VgnPPMk3UZADBkdpKznUBy
 jPuAVO/lGjUcmxFbhSXHphwHovSMaPcXUaYP0uLXTQqkPhivxPLmVhykEaNjDfq2HqSC3J5Tx
 BGKEk8reSxGjKTcgWPwPYb6QlOnvBhlV9wxgdwRETeQ6vLa36yKk/+4RNDTAPbkxSJJpVKq3B
 VZ7t6Ex93DvDlnNHcHlSGYK1488e4lQheHk2gwwzqaUSq3UomviAuhgyNuupFfDorWZtUVrk6
 uEmKWEFkjgkS0IPRkQWpys8pW3mnaok4hYi4K6Kvp+t+sWPc1b98Logbr4biHRYqJyf5hi0ix
 t0yU3czM4xKsUt77sa7T1vSLxRKVjVjIJjkwYQrBEDBNPLoDA3sKDdcyehtHBlkxMgfHW1NNP
 KmS9H/ZVHjGT4vvXWEm+xXKdhs44K+P2fjeDBotamnHmWcoUB9HVvvRHB5mNzaiT+I7MgDj3P
 YOubaT8ULYMrX3lswsPXOKxj1vdgLljQu9Nv5H8wdzbMwRYs9fmn9QMGcvL7JulXMk66qykfp
 7H4MWqEy+UpJt+RWufbKQdwUXsGZW5MAR4ceP7AD3r+wWbxrDptDrLatSWfAUA4ag+oGhiLCW
 d2k2EiEJOL0MQBouluWa3WxGO6NIvgV4hKjzYZpJtZNUZt2bWhLl3NRwbjUKLqYnlPAUuTiLV
 rZuPeVuDHSBLrPsMiNZQKEKvvzXXXfHB61CNOrQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 14 Jul 2020, Derrick Stolee wrote:

> On 7/14/2020 11:27 AM, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >>> If you don't mind, I was already going to squash Junio's commit into
> >>> mine (almost completely replacing mine) but I could add a small
> >>> commit on top that provides the following improvement to the error
> >>> message:
> >>
> >> I don't mind at all. I'd just like to know that v2.28.0 avoids confus=
ing
> >> users in the same was as v2.28.0-rc0 confused me.
> >
> > In a nearby thread, Jonathan Nieder raised an interesting approach
> > to avoid confusing users, which I think (if I am reading him
> > correctly) makes sense (cf. <20200714040616.GA2208896@google.com>)
> >
> > What if we accept the extensions the code before the topic in
> > question that was merged in -rc0 introduced the "confusion" accepts
> > even in v0?  If we see extensions other than those handpicked and
> > grandfathered ones (which are presumably the ones we add later and
> > support in v1 and later repository versions) in a v0 repository, we
> > keep ignoring.  Also we'd loosen the overly strict code that
> > prevents upgrading from v0 to v1 in the presence of any extensions
> > in -rc0, so that the grandfathered ones will not prevent the
> > upgrading.
> >
> > The original reasoning behind the strict check was because the users
> > could have used extensions.frotz for their own use with their own
> > meaning, trusting that Git would simply ignore it, and an upgrade to
> > later version in which Git uses extensions.frotz for a purpose that
> > is unrelated to the reason why these users used would just break the
> > repository.
> >
> > But the ones that were (accidentally) honored in v0 couldn't have
> > been used by the users for the purposes other than how Git would use
> > them anyway, so there is no point to make them prevent the upgrade
> > of the repository version from v0 to v1.
> >
> > At least, that is how I understood the world would look like in
> > Jonathan's "different endgame".
> >
> > What do you three (Dscho, Derrick and Jonathan) think?
>
> If "v0" includes "core.repositoryFormatVersion is unset" then I
> would consider this to be a way to avoid all user pain, which is
> positive.

I concur.

> I'd be happy to test and review a patch that accomplishes this
> goal.

Wouldn't that just be a matter of extending your patch to re-set
`has_unhandled_extensions` also for `preciousObjects` and `partialClone`?

Ciao,
Dscho

>
> CC'ing Ed Thomson because this extension stuff affects other tools,
> like libgit2.
>
> Thanks,
> -Stolee
>
>
