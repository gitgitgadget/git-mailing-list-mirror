Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601EAC10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 22:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E05F2080C
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 22:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ISgxVrZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgCXW0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:26:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:46267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727747AbgCXW0m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 18:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585088796;
        bh=/ofF2jbMFIS+oxaPyh2uaBGUNxNDqIwnkEXP6Qa2f4Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ISgxVrZFEP7QIYXmz0kRkVB3teX2xJplTvXAqfZ8ZOIp4i17iPqDPfI20uNcVSh20
         7e4+Nw+kzJMTbMnu8udc6Zhv+9hAVQpphYW4fO6xiZkcLOyrw9mnxKYLVY82tCU/8h
         pZpB6VbGm/XGkNzo9o5uEIwcoq3rZYlWz6bj9Ew4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.32]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MSt8Q-1iovIY1WrW-00UG27; Tue, 24 Mar 2020 23:26:36 +0100
Date:   Tue, 24 Mar 2020 23:26:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] tests(gpg): allow the gpg-agent to start on
 Windows
In-Reply-To: <xmqqh7yd1nbh.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2003242326190.46@tvgsbejvaqbjf.bet>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>        <287a21f1033b2a74420029c529ad4db956051a85.1584968990.git.gitgitgadget@gmail.com>        <xmqqd09355h7.fsf@gitster.c.googlers.com>        <nycvar.QRO.7.76.6.2003242043050.46@tvgsbejvaqbjf.bet>
 <xmqqh7yd1nbh.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:l6XUpkSpv0j/thZ4kOTSSGcYzptA+V6u/ibO+lcUn182qMFTXiU
 JoLdffew1ZZ5nx+Ux76ZS95XZBh8EY9IpIB/9UQ6bKlZkmdjnLZXVUpczuPoWRGIP4NLLvJ
 Djk8v3bS8wi/AuxTyy/2WPr1Q7rWx96P0tNRCumUKQ4FvvnkL898jm+BMH2h4cTjRib6v3m
 DppwBsBZuIFmIe6DDSRwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JFF2cHuscwM=:sHrliNDQ2IjMX3qQMb9l2C
 5rfX/Y+KFeaDWEP+gEqo50UjU3lJHoAtpqBKiyISGrzv3+HJqZQswZf8e6RNxjOBYLTF1uoWW
 lak3kBzauLhOh9lyvj9CnilJYMT8OfjelaQaYbvqeNXHhsfCM2NS4Ic4NCkOjlspZcwm6r8R9
 wQHLXoFoqbeF3rvK/+YoaIQfVvRU7ksbFBcIkyJ+bo1Jy9HNWgR5NAn3evRzyH5ANUyg+glai
 PKq+6kZ07ASf0fikqVQSsuhbrsq5Mp2Ee4Cb7r0YABnFpZfEgEbmhWXI5+gnUzNs9Znef5Vvb
 4rPZh5bOthCMKw6kewtoE3OuXMK7iveiLu2v5410DfhELbanZydMUqwvx1+CWsfLY7WQ7gv3O
 HyeH6x+NykzzFynDvaNXo2jtPICIWdYddqNu3uI6NUJo8Fo7mKgyBU9EqfmrKC05do8A0IDdk
 MsubCD1DDn5KbBkvBkj0afQjMvCjsymxPlsoxmbp6Y3ZyruNYsLfrLsIlju0i6xA3Bm+TwC/6
 Kl7PmEjMMqazKdQ6ACgao6+iUJFruVakbA+HqCq8Je5wxyzYEoZCM4jYLuzuS5aLDUyb2EABl
 MvzScb20TPg1L4nS9jSe7xW3jTnpsNyE2+P+zcDRksbAwx3noATk6FcYDbXmaa560GGEXQajT
 0Ogk/0JPWFYxawnZejBUz051OzO+08puXJoVfD4WuQHrQu4ZhxW3FYqyKJjwsSJZx139Vq+Mg
 dYNRDnDxK1zPgnXx9n0r4BkYC/AaD3BgprA9JG/OoqEPKoF5RSH6OHGtcxcGZy6Xy+NQ6KtBp
 ZLHPnugpjmhojcUknckgy/WVe520R8jrJYHPLGwhfLdZBYbJUk4pKNhZ54ADjJuvn1UkM+LIE
 +Jmd+MTircMj3aOzwB5Wt8pZvCYqTybYY/b44gBD4N0LiaEUQPDXgtrAsatpkLT4qg2vug06t
 zCYZYzP5uq4fjpizy9vtXM9lCuQBJ9jf8MHaPsfYwJOB17Ina3Zl+KaNs9lveid7FYf45yTJZ
 T7IGCCKgPxylqT0KYAsJm6I8V2HKq0F1Bo1FN+iApwKMtx5+P+NBWoLrOHtToeFqm7+WeQv3s
 y2jfXzjpZcwwWlz2O2KynxLq9mDEYpeSPvIBxi//ks49wpaFHiTjDemFwKVwjXNxfsu9OoHdP
 fyhfa59OOgDvDu6GwkXXcsB96Zfqd08eZTf2F+BbyEDDpJCA+0mYhT3bGUgz4sU+uYnNsOAGv
 emnoesH7SfZQr1Flr
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 24 Mar 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I fear that this distinction really is lost on anybody who does not ha=
ve
> > to deal with MSYS2 on Windows.
> > ...
> > In short: I am convinced that this is a subtlety in our test suite tha=
t we
> > cannot reasonably expect any contributors other than Windows-based one=
s to
> > get right, and I am fairly certain that we will just have to keep
> > monitoring the CI/PR builds for similar issues and then help the
> > contributors by suggesting the appropriate fixes.
>
> IOW, this cannot be made an engineering problem and has to stay a
> black art? ;-)
>
> That's somewhat sad, but I guess we have to live with it.

I am afraid so.

Ciao,
Dscho

>
> Thanks.
>
>
>
