Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEFE31F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 20:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934181AbeGFUeU (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 16:34:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:60439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932884AbeGFUeT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 16:34:19 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ls8Qd-1gFFco2wTH-013yEc; Fri, 06
 Jul 2018 22:34:13 +0200
Date:   Fri, 6 Jul 2018 22:33:56 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Tiago Botelho <tiagonbotelho@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [RFC PATCH v5] Implement --first-parent for git rev-list
 --bisect
In-Reply-To: <xmqqwou8kz9b.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807062123280.75@tvgsbejvaqbjf.bet>
References: <20180622123945.68852-1-tiagonbotelho@hotmail.com> <xmqq4lhqpy80.fsf@gitster-ct.c.googlers.com> <CAP8UFD3oEjW75qsk4d_wqo2V8PmzMvZLshutw20CD7AU4b4ocg@mail.gmail.com> <nycvar.QRO.7.76.6.1806261540340.21419@tvgsbejvaqbjf.bet>
 <CAP8UFD1TeC4czp_8HCRw5CtjGO78A8gRezw_xspnm4MXuhQswg@mail.gmail.com> <xmqqa7rhi40f.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1806271254210.21419@tvgsbejvaqbjf.bet> <xmqqwoukgpr9.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1806281505160.73@tvgsbejvaqbjf.bet>
 <xmqqvaa2yjo1.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1806291317150.74@tvgsbejvaqbjf.bet> <CAADF+x3jd5G9+SP3UmhwqrR_T6BuD0PkQJ3x+NLpq2BJ_Ej-Sw@mail.gmail.com> <xmqq36x0ndza.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807041224460.75@tvgsbejvaqbjf.bet>
 <xmqqwou8kz9b.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qxl//GWPrPaZeypdhTBR1PoO79dMECRhmr8n/iHRk0kfXPWQOmt
 L4TXO/10v+ThjCXGSXDV2GYKsUHQMEfgmdEq7YsP4Leexr4qy9SS9DC8LYeRFqC4kHN0F7w
 gT7Lh+k5Dbgm1Lv4KBJdgI2F0a+TUZPw6AYy8eK6+321wfG6u3HQiVFCqsBNQRnE7Yil7qy
 TmcPN98Xc68CAKgAAdyhw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Xw4sfH/QLOE=:qIVrp8RNVGriRKAch71yUe
 VzFWpLp9YdMPhem9Wu5OtZOII22q4HrKAjA1evoVGUEPRCzTwNqJ/BmYOgyYP8F+aFB5yB2Z9
 cic8ps42olt0XNvS0LSCTXTkeTnM5LeGkpWKD/IvQzMjA2UvJtSnXNrB4ObSvQDEYxrsOPeV3
 ZACST+VqgHfZP4QJEUQvBqO8QcAmHAhzsCXv4P02aDZg5LSr6ECjheKQR/ZK6stLQHLCB7RlT
 raUdhdemZna/itMHKkxIgTJgHDhhZv0LWoAwxvMiFBT+Qc+ORbC42qHw+JtSo7sblO8t+7e3b
 7J7Hq1Lj8EqIjreXfYsPGnCkso5rdetqrxVxd2l8mkVMCGx/HwL6lKAwcmUJqz+cYCGvgGWQX
 Lr9hzj0JFBOA/4welevtNEt5MX5ti7OY/iU7Po55h37WJlfA6wS8A/YAIqinm5milTX4kMBjj
 05HV6TBm1iDkurd+6lJS/vWM8O8lpBHD4EvCeYIfJtjguQttj2jYkWzWir9NCFHGtaCVQ2FZE
 mesFnyHFk16HKNzulakzGdpBG03Rc8KjeoN5UWM86jWei3q5JVWNrLW7yksdP8BHtazU2G1p9
 vpI0tdXIA6eyVOmZj7uznedDqXZiR9pDQrjEZ75ZWkBr45Gbd4LYPw2qZvyUnKg4Evze+bYT0
 f4bCIseM7mwXWiPfIa/i6HPepuMMTB2MRgrZssuQaIBNfsAhFOcgQQhykC92dzsx2pDgqYfpV
 ai/Lu297cC8qrb2M2o2oBxniFh4ue6bktvz8KBaSpMieyMc1L1ia2lXhFeb3Vj230oDqhg1Sa
 W1/jNlv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 6 Jul 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > git rev-list --first-parent --bisect-all F..E >revs &&
> >> > test_line_count = 9 revs &&
> >> > for rev in E e1 e2 e3 e4 e5 e6 e7 e8
> >> > do
> >> >   grep "^$(git rev-parse $rev) " revs ||
> >> >   {
> >> >     echo "$rev not shown" >&2 &&
> >> >     return 1
> >> >   }
> >> > done &&
> >> > sed -e "s/.*(dist=\([0-9]*\)).*/\1/" revs >actual.dists &&
> >> > sort -r actual.dists >actual.dists.sorted &&
> >> > test_cmp actual.dists.sorted actual.dists
> >> 
> > From my point of view, this indicates that you want to set those exact
> > dist values in stone.
> 
> As I already said, I do not think it is absolutely necessary to
> declare that the minimum dist is 0 or 1, or how big one step of dist
> is.  For those reading from the sidelines, the history we are
> testing this new feature over looks like this
> 
> #     E		dist=0
> #    / \
> #   e1  |	dist=1
> #   |   |
> #   e2  |	dist=2
> #   |   |       ...
> #   |   |       ...
> #   e7  |	dist=2
> #   |   |
> #   e8  |	dist=1
> #    \ /
> #     F		dist=0
> 
> Current code will say dist=0 for E and F, dist=1 for e1 and e8,
> etc., and I am fine if the code suddenly start saying that E and F
> (i.e. those at the boundary of the graph) have dist=1 and one hop
> weighs 10 so dist=11 for e1 and e8 (i.e. those at one hop from the
> boundary).
> 
> But I am not fine if E and F get larger dist than e1 and e8, or e1
> and e8 get different ones.  I do not think the code quoted upfront
> would catch such future breakages.
> 
> And I also do not see a reason why somebody wants to make the dist
> computation to be 1-based (iow, changing the minimum from 0 to 1) or
> one step not to be 1 (iow, giving 11 to e1 and e8), so while I agree
> it is not strictly necessary to cast the concrete distance value in
> stone, I do not see much harm doing so *if* it helps to make it
> simpler the test that is necessary to make sure relative dist values
> assigned to these commits are in correct order.

I guess that you still want to misunderstand me.

Because it is not really hard to understand what I said: a good regression
test will verify precisely what you want to ensure, not precisely what the
command's output is.

So in this case, quite obviously what you want to do is to verify that E
and F get larger dist than e1 and e8. So that is what you test for. Not
some fixed text that might require adjusting in the future for any other
reason than a real bug.

Ciao,
Dscho
