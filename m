Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A8B61F453
	for <e@80x24.org>; Tue, 23 Oct 2018 19:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeJXEUg (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 00:20:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:54711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725740AbeJXEUg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 00:20:36 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCfcc-1gNGEb20LS-009NH7; Tue, 23
 Oct 2018 21:55:31 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCfcc-1gNGEb20LS-009NH7; Tue, 23
 Oct 2018 21:55:31 +0200
Date:   Tue, 23 Oct 2018 21:55:34 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/3] reset: don't compute unstaged changes after reset
 when --quiet
In-Reply-To: <CACsJy8C+9f3hFxmrqAN2hi1AeBTa1yZdnwX6iJtsy_OrEfTWpQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810232153120.4546@tvgsbejvaqbjf.bet>
References: <20181017164021.15204-1-peartben@gmail.com> <20181022131828.21348-1-peartben@gmail.com> <20181022131828.21348-2-peartben@gmail.com> <nycvar.QRO.7.76.6.1810222244150.4546@tvgsbejvaqbjf.bet> <MW2PR2101MB0970EF1065717A38CF581C64F4F40@MW2PR2101MB0970.namprd21.prod.outlook.com>
 <CACsJy8C+9f3hFxmrqAN2hi1AeBTa1yZdnwX6iJtsy_OrEfTWpQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:x9D1k1XQsXmxE261fM9IYTIPHS7po5jiWL+8AjM7h9AUVt62U6L
 ZpkxfVwHqJhUASxe3Aldl6DYb0z14jZUOMlt4j7h9puTHyS6UqmAYkQAbmlvxFkhUYAOgR/
 y29Zn1yIhVMd5PmGstwLCoZzlp/qx7LNWSvam6J1WDMwpNev6GSMCZhZ/8RsRU6lE3QDVhI
 P3qWhGRLQ6v/GSFpOPanQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:81cq+mj+qT4=:bZjPMLCmZtMvv27B1f84CZ
 Ojz51GGoudGGN0ZdDrxWSZhq+9y7DDGqFdeOv5P82YaOoymJzp+zCn4Tw2oWGbF5UHIbuheKu
 kQp3njncsNLsl9EUppRievrIBx71xikjFjgNQbKfguD4ZEAY1wPhU8r7wSRw7wWiJssB4eeb/
 bi8BCqn2T/03+818a7psnphKA+rVhlFVC0qSl8qBSSrKwsVRZUJkFrIAKo8Ss6N9rfHCrDOt/
 b1S69pIrMcfZPe5wvf5eqd0cMpfay1QzAdPUl4f7CkXRhO3kDj0Q3atAGVJjh6yrTyz5pWABq
 ZI4AJmWJlESFWS7SmemJt5y5Rujqtd3aq21hcAmvQfWwDNanLL8O8Slg1vdR3pvKXTnfKfSto
 TnDpr1IS8ExYryXQDm0qc08v7EI6NOUc5RkcWqpbKYhjkjEkjHKszIoI7Umqc1PE7cV12Z51Q
 G8FrAmGRx+2ZeaOzfUkgSHZgmXjU02v1CcM77hDX55oD542HLGjBPC2vNrAQLFHA0UkQtijbp
 uKoi7/sD81la52CsGT+CyPbNT1mI+spwBn1Bg9aUjy2DKqVZBUVHHISbsxLPgtfjdWPBFMrbM
 y+r/K6slqcC9oR4Iwo0qx8eM2ROFH6CrV/ykDWtGEEr7+gpF89bslCq8Ppc4z0PQnN03H8nTy
 uJADiQ9RGlGvRR4orxF7DN8o/RkIoGPYJ8EUZeXB3t9dNOYEg45SZug0wS3S3EeUo7X0CKQXU
 iy+yEtKXw3ZCQwBDC/5rfZr6P+R/V078DPoGckmED0IybglnO417teVdYeow/Fesm8QEgscU4
 dNBhxegVjEotOPwjEqPjM7ZkpLkACjEun8tlZ9Oy84bwceod4M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Tue, 23 Oct 2018, Duy Nguyen wrote:

> On Tue, Oct 23, 2018 at 1:01 AM Ben Peart <Ben.Peart@microsoft.com> wrote:
> >
> > > -----Original Message-----
> > > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > > Sent: Monday, October 22, 2018 4:45 PM
> > > To: Ben Peart <peartben@gmail.com>
> > > Cc: git@vger.kernel.org; gitster@pobox.com; Ben Peart
> > > <Ben.Peart@microsoft.com>; peff@peff.net; sunshine@sunshineco.com
> > > Subject: Re: [PATCH v3 1/3] reset: don't compute unstaged changes after
> > > reset when --quiet
> > >
> > > Hi Ben,
> > >
> > > On Mon, 22 Oct 2018, Ben Peart wrote:
> > >
> > > > From: Ben Peart <benpeart@microsoft.com>
> > > >
> > > > When git reset is run with the --quiet flag, don't bother finding any
> > > > additional unstaged changes as they won't be output anyway.  This speeds
> > > up
> > > > the git reset command by avoiding having to lstat() every file looking for
> > > > changes that aren't going to be reported anyway.
> > > >
> > > > The savings can be significant.  In a repo with 200K files "git reset"
> > > > drops from 7.16 seconds to 0.32 seconds for a savings of 96%.
> > >
> > > That's very nice!
> > >
> > > Those numbers, just out of curiosity, are they on Windows? Or on Linux?
> > >
> >
> > It's safe to assume all my numbers are on Windows. :-)
> 
> It does bug me about this. Next time please mention the platform you
> tested on in the commit message. Not all platforms behave the same way
> especially when it comes to performance.

And pretty much all different testing scenarios behave differently, too.
And at some stage, we're asking for too many fries.

In other words: we always accepted performance improvements when it could
be demonstrated that they improved a certain not too uncommon scenario,
and I do not think it would make sense to change this stance now. Not
unless you can demonstrate a good reason why we should.

Ciao,
Johannes
