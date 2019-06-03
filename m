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
	by dcvr.yhbt.net (Postfix) with ESMTP id E53FD1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 13:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfFCNko (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 09:40:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:39375 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727506AbfFCNkn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 09:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559569233;
        bh=2C8KbR57lprhHA0ECswCvvA1Nuxq6GZBb7N2mZYUEOU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Q9E/x3hBmjtRLTKDxgy7GIgfWz9R4/VtyHGq/MNAl5BXGSYB4ZjENkdK5e/aFL4JW
         EoZg1si5yzHgNMJFPtAkJ57Sg3i2xLkPn9YJytVfA8tAPkTw3wZkkZ+LYUaCs7Y7bw
         +V5K88M/jVLN7YfOn4TRYer0B82cxzJoYYSBUf0o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8eAd-1gd5k20RUZ-00wFsz; Mon, 03
 Jun 2019 15:40:33 +0200
Date:   Mon, 3 Jun 2019 15:40:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Jochen Sprickerhof <jochen@sprickerhof.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] add -p: coalesce hunks before testing applicability
In-Reply-To: <a23789e9-ee99-d23b-ee25-1acef8d8d114@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906031229110.48@tvgsbejvaqbjf.bet>
References: <20180828085858.3933-1-git@jochen.sprickerhof.de> <xmqq36uygyau.fsf@gitster-ct.c.googlers.com> <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net> <20180903190114.GC17416@vis> <d6a8f77b-0a83-90ae-a7fb-a3954ac3b346@talktalk.net>
 <nycvar.QRO.7.76.6.1903221453360.41@tvgsbejvaqbjf.bet> <a23789e9-ee99-d23b-ee25-1acef8d8d114@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:L1GoWIteO1vJzDAEZ5vhTFZgRf2fRSduN0whdb527BdurnEEHEE
 QwwFZSYLzs7sv2HTdJRapyAwBvWFigVnKGWUVAzQBmY7byftc0GRX+a3+PikDMRIWs73ZdG
 iRohHDRlKSLQGW2Jm6/QDnRM4TzDWL6B1odBIc7sD0i1xj3+VnZg53W0fMQFhPch5h5BnO2
 yfAnN5oODa8aUpLS5KIHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6pXrL5IvK4g=:KRJ+LLGN/aCVsPpoH2OqWz
 jH1ecWhr9Up3VfWFngB8Y+dbYGVWI/psWCuoi6jo5+K4eGYaEuvIkoWumOxSFyvUSaDIBSQie
 XjAXt/UNKqgmCfRD+FXi6Bl87sT6b4/y6GqLISummU20jXkO+GcjAJAdDPtMS5q4zTY+4NzF4
 VvEPK7UZ1wlFf7cW11InLsu11THVEwkkgxHv+65ePf7n4fQwNJv8iW5q7ZYKp9bNARgNQdIwv
 DMau06vCJKyKyqk3iSCi8PZBAm/ELGieOva+Cjasnp5/YlScvuMgQgr7hSXkhCjzd6eKS8h6X
 0xyU4rLEVbL5dvBQltzMwcf4Jn4tM27oZde0Y1KTwWwBQ5Ba3Hyp+ZpSQm56OqLc84fIN1hua
 ExuYUGdKUiJmpqrgi93UG0BmzVuFteHOZuBebAbFcHiLsWGU/o/v34d5D59R2GhMmP4Kf4UOH
 dLilHJhXKAW2pJ78oZAp/gYM7sqBPE/HwJgNx2syV4BSH91UMRejg20X+sUZ7YWHLixn9X+tm
 qNTtpBxJlrgq7l9w/+GJZx3gC7L18DbKbFrkPpZrxUhHXO0fLHPJkLIrMl9brqPcUPJvc2CoC
 af2jkVVFomyprKcSn6INMh4qr48k2Y9Mrxz64PG29hfpMkq1Wz1vYOnaWkQHMoowUBAD5ghZX
 SZRh5o+CY65bUiCUvr2ROv9aksf+zHq9cl/qqoG3qQ416GT+ZIDI491qrF+6UOgchR9XSp/bF
 rsBThEXrKT/3uHjPR2sT6ZEaPpV6N5WhcqHt6dKc/FswPMhc/nAF1VSzv0X7W/k5RPY8mGGUO
 jbDVi6HZ5VJ4vpV1xjG/dmCpO+CIi3uN5n9Cw/jHMoBJ7FHL20HxssKg2JtV4ZyNlSfXc777H
 xiwTNRisPMpYAh15n44eyHpHWt1XfkP3aujt45u+TdWEqtbLp8Adq692Db+gUIV7TrtRhSpOP
 1RZ0gV7hdgNTkP0jO8J2CYegrX5Kolk/j0qTYrFGtZXlZJCmV5ajC
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Sun, 2 Jun 2019, Phillip Wood wrote:

> On 22/03/2019 14:06, Johannes Schindelin wrote:
>
> > On Thu, 13 Sep 2018, Phillip Wood wrote:
> >
> > > On 03/09/2018 20:01, Jochen Sprickerhof wrote:
> > >
> > > > * Phillip Wood <phillip.wood@talktalk.net> [2018-08-30 14:47]:
> > > >
> > > > > We could restore the old test condition and coalesce the hunks
> > > > > by copying all the hunks and setting $hunk->{USE}=3D1 when
> > > > > creating the test patch if that turns out to be useful (it would
> > > > > be interesting to see if the test still passes with that
> > > > > change).
> > > >
> > > > We set USE=3D1 for $newhunk already, or where would you set it?
> > >
> > > To match the old test it needs to be set on the hunks we've skipped
> > > or haven't got to yet so they're all in the patch that's tested
> > > after editing a hunk.
> >
> > The way I fixed this in the C code is by teaching the equivalent of
> > the `coalesce_overlapping_hunks()` function to simply ignore the
> > equivalent of `$hunk->{USE}`: the function signature takes an
> > additional `use_all` parameter, which will override the `use` field.
>
> That sounds like a good solution. Thanks for working on the conversion
> to C, I'll try and find time look at the code on github.

Please note that I did not update the Pull Requests on GitGitGadget
lately, as I had no reviewer feedback on #170 and did not want to waste
too much time on synchronizing my work between those PRs and Git for Windo=
ws
(which now has the built-in `git add -i` as an opt-in feature).

So: the latest patches (as of time of writing) can be found here:
https://github.com/git-for-windows/git/compare/9f09372011%5E...9f09372011%=
5E2

Thanks,
Dscho
