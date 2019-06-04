Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92B911F462
	for <e@80x24.org>; Tue,  4 Jun 2019 13:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfFDNdA (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 09:33:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:59467 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbfFDNdA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 09:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559655169;
        bh=PVL4hH/1812rGyjTJgWbmNG5HU/g8Lf8wjMLhP5vHOI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KScOmQfoyJjyWm/ZN2WSlP92hE+fWmaJhQsb0eW0NDxSqXKxaqk+MsOVL6x9pLwdD
         MVXPrkYXNfNEAVDTPHzs5N86yw7NGpIcyiD4ONizL26DK1s98At0LJF4mIOxRCrQYz
         xqOdbM4ilOS5Xvi68ejdgqOYlxv6vbqEy9KRlPrg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6ux-1gnm021Qcd-00pfvr; Tue, 04
 Jun 2019 15:32:49 +0200
Date:   Tue, 4 Jun 2019 15:32:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Jochen Sprickerhof <jochen@sprickerhof.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] add -p: coalesce hunks before testing applicability
In-Reply-To: <3ac6c94c-edd5-b376-4d44-cbf7aebf37a0@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906041532000.1775@tvgsbejvaqbjf.bet>
References: <20180828085858.3933-1-git@jochen.sprickerhof.de> <xmqq36uygyau.fsf@gitster-ct.c.googlers.com> <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net> <20180903190114.GC17416@vis> <d6a8f77b-0a83-90ae-a7fb-a3954ac3b346@talktalk.net>
 <nycvar.QRO.7.76.6.1903221453360.41@tvgsbejvaqbjf.bet> <a23789e9-ee99-d23b-ee25-1acef8d8d114@gmail.com> <nycvar.QRO.7.76.6.1906031229110.48@tvgsbejvaqbjf.bet> <3ac6c94c-edd5-b376-4d44-cbf7aebf37a0@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7JtiTQza0F+yNmv62DQ7prHRnbtfnL14nV5XzDom2kKPU7NuVle
 d3C8j6u8ZnmDow8JZC9+nplJZGZ2j68fnJvf6XlYCJerS4nRg763AWqrJ8opD2cGb6NRmTr
 IZ0q/HXY+e8o0e7MZuyQV94NuBi6f4EbXl10SyLKcDMOhZACTNpX8ZuiltZtf7VpUdO4mqf
 1cDI4nGejCgwyeCKFTh0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4QNLtWaPAoI=:ZoVGUUQe03dl22F0ya91e4
 TCIZ2/z6zXkORxtC8/naYFwHQqYohhSaLHuwdEfXy5gQNYeN5n4rbugnuhm7bgmSHWrrOIev7
 sIeJSWzTI/c/jcf0XPX3GDrt1sUF7yPyNCsnW3H/d7BqzRPAGeX5dfJyUxcgcuT/arAzdps2N
 If4uD2JjTmzW/8oFNEUq5cfEVZUx7ZCX6TqeFOmtO6coComAA4r2I6mMU0kw5LjlKjxExJ4U+
 P1mK+1a4eCkyeH0OtK2FLoBc/67qOJbDNNDgX1q8EbHBs09goJs7KuyDfxPvNNN0nKM8ZMJpu
 ieHO9Hb/tgycntWWrm97JdM/0w8+arYpQNabFjNriDdehP6UDWgONlQYJjwHmXUPp6NteKhOC
 7F20h/5I3RNcWLd+uflSYCd10QTiHRv/FZfAW1+idsn6LIFbE5G5C7kNgwYhFMrcTtBz6oVi6
 rcP2mZ5alRY0aBBlLLyhXyVJhKILI6DyrsQE2K/MvwUGPiiK8EYOGNWxFN2/uKo9tv+mHykxT
 JVkrgceu/aOxRonMv7QP6qb/PQ6bngXcM7fZ2PunlIQT6rCPrJCsuZWW+tf38eyFax60LLmDX
 QSKJgKBPgFB7t2RX10GZ1gLVjPt2o8RjMlQWRJprTczPGNj3tNN+nZAamuUN99ktYzyfCALX7
 UOJAypXo1y94XXNYMdNbkqRj35kXJqcSDxrfNP3uiICnK2lDpGOgKuOhuTrl5q6ADYgAf/Z61
 Ctq65VqUDMVElEVKQTFel9JWIe/yz7lPlB8A8eote3YoCFD+ZrEFngW7djyhO83c/Gj9f9uBY
 3ddZF4SBmKoRTI2cVZeidBr8EoPa5YB69kO/3ThSAUBT35MWiMaHD1BlasoWan4wnaNdhSBd3
 rgwpBo3Ei3fEoKvPB2t9QPNCwzUVQKkVSRwuoMlq/cLObYDBsbvmOfqb3k4E0b4E3t+jWXATS
 yeTR1y7f7Fv03ICgYdQjwzCni5/oIE1lNConqm6wE0EiKjEk9ujp0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 3 Jun 2019, Phillip Wood wrote:

> On 03/06/2019 14:40, Johannes Schindelin wrote:
> >
> > On Sun, 2 Jun 2019, Phillip Wood wrote:
> >
> > > On 22/03/2019 14:06, Johannes Schindelin wrote:
> > >
> > > > On Thu, 13 Sep 2018, Phillip Wood wrote:
> > > >
> > > > > On 03/09/2018 20:01, Jochen Sprickerhof wrote:
> > > > >
> > > > > > * Phillip Wood <phillip.wood@talktalk.net> [2018-08-30 14:47]:
> > > > > >
> > > > > > > We could restore the old test condition and coalesce the
> > > > > > > hunks by copying all the hunks and setting $hunk->{USE}=3D1
> > > > > > > when creating the test patch if that turns out to be useful
> > > > > > > (it would be interesting to see if the test still passes
> > > > > > > with that change).
> > > > > >
> > > > > > We set USE=3D1 for $newhunk already, or where would you set it=
?
> > > > >
> > > > > To match the old test it needs to be set on the hunks we've
> > > > > skipped or haven't got to yet so they're all in the patch that's
> > > > > tested after editing a hunk.
> > > >
> > > > The way I fixed this in the C code is by teaching the equivalent
> > > > of the `coalesce_overlapping_hunks()` function to simply ignore
> > > > the equivalent of `$hunk->{USE}`: the function signature takes an
> > > > additional `use_all` parameter, which will override the `use`
> > > > field.
> > >
> > > That sounds like a good solution. Thanks for working on the
> > > conversion to C, I'll try and find time look at the code on github.
> >
> > Please note that I did not update the Pull Requests on GitGitGadget
> > lately, as I had no reviewer feedback on #170 and did not want to
> > waste too much time on synchronizing my work between those PRs and Git
> > for Windows (which now has the built-in `git add -i` as an opt-in
> > feature).
> >
> > So: the latest patches (as of time of writing) can be found here:
> > https://github.com/git-for-windows/git/compare/9f09372011%5E...9f09372=
011%5E2
>
> Thanks, I left some comments on the commits on the add-p-in-c branch at
> https://github.com/dscho [1,2] before I saw your email. I've still got
> quite a few commits to look at so I'll leave any further comments on the
> git-for-windows repo instead.

Thank you so much! I hope to get to your comments very soon ;-)

Ciao,
Dscho

> [1]
> https://github.com/dscho/git/commit/9b7d0fbb095e9e14491d4344981ae346c97e=
1692
>
> [2]
> https://github.com/dscho/git/commit/74e058179ae7743a8a99e5a20d5362bf5556=
3505
>
>
