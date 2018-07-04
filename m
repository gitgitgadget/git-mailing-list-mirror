Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B9EB1F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 10:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753520AbeGDK04 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 06:26:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:53943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753262AbeGDK0z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jul 2018 06:26:55 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MexaL-1fm1ui0ITB-00OVhX; Wed, 04
 Jul 2018 12:26:49 +0200
Date:   Wed, 4 Jul 2018 12:26:32 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Tiago Botelho <tiagonbotelho@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [RFC PATCH v5] Implement --first-parent for git rev-list
 --bisect
In-Reply-To: <xmqq36x0ndza.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807041224460.75@tvgsbejvaqbjf.bet>
References: <20180622123945.68852-1-tiagonbotelho@hotmail.com> <xmqq4lhqpy80.fsf@gitster-ct.c.googlers.com> <CAP8UFD3oEjW75qsk4d_wqo2V8PmzMvZLshutw20CD7AU4b4ocg@mail.gmail.com> <nycvar.QRO.7.76.6.1806261540340.21419@tvgsbejvaqbjf.bet>
 <CAP8UFD1TeC4czp_8HCRw5CtjGO78A8gRezw_xspnm4MXuhQswg@mail.gmail.com> <xmqqa7rhi40f.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1806271254210.21419@tvgsbejvaqbjf.bet> <xmqqwoukgpr9.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1806281505160.73@tvgsbejvaqbjf.bet>
 <xmqqvaa2yjo1.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1806291317150.74@tvgsbejvaqbjf.bet> <CAADF+x3jd5G9+SP3UmhwqrR_T6BuD0PkQJ3x+NLpq2BJ_Ej-Sw@mail.gmail.com> <xmqq36x0ndza.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oBxukxxT+Or39rD1YOuPoJF56HU1K0uUNsFzhj+08v2wdTUJGun
 eF0u74zizvhqVqs562SQKqxfYlJ7DsSMAlUC715JskzfUGo+VCVPRnAXjKjA4g8l3KozX3f
 mFUujLPDsO6PdVoGC/obb59waiDKr0Gp36VyWkWio9/AALggg316Vn6zScKwGTsKh+3hWIu
 EwzF01lApQ3vdFVLCcYSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8X97EauUndI=:dARSaIPR940pry8tZw9Zt8
 Cqgb5tYhavRnoxbhgLgigB30Al3NMP6piznpXmTlEA+6gTCNHJQaZ7nh+0GC8xgZI/xkbvvFL
 U74QZyJeyVFT2Io1dQeiKIt+ZmEGsjs+oVu4YzpalD/YBdJMumEYP03zsYuFetlpIbQKZ533B
 huOSgBuVDzJeFWDZyuXWtoOlV5I1TTg0yJ2X1g6ha5rAKRd6K6FjfY4Sh9QNrWOonkctltXJ+
 96yjqTp1oEhAgrxVPX2zond5FM91f3qhP6kkLH2AuGW992FQDuA+BobkFCu7AvjYBiRziEqtS
 tV62fP6W2I9B2BB6S8YZy7EW51GYE3vOO7MB6CiRlAjCY/AFMtoQPY6Vijy7E4rs8dxqJ/nE0
 TJEYk425E2uWZRQJWEjGSGgkQYHBQZWVrC3iFIZPw8CbkOJtH4nUBVNUXQWC00wz8N39BHLDb
 vcGzW62iiLk1afmmrFHpzpJcbhknBzQ7fXJXioau2s1g87tnQT0tPur0ZzxprWwGImco9tt12
 HcUI20r0Kv/3saqGw2Up0I9vpFbdgo4vHZzxxqquD00f8esyPlOAaPtBLifFxFtWDY513yzMV
 1XHhv9Xmavu9kYPKjkFKaZ1OpJNorQfgtZ3zUJoJGUFq8j6K7RFtD1jDW8F6KfL/kATroeyYJ
 hELCL6FPGkcWiAbygSn3YUQshTwBOn18tNRKJE/QgWB+/ruWZa9/HRqAOy3dT/gzBtBhYN86p
 840DfzAGO06yAyUJEktkspjKCk3Qp3alUumohYaSMPPIARK+RyQ3WnqNYf6ZsEiDV1GwQbU5i
 BlAuTxx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 3 Jul 2018, Junio C Hamano wrote:

> Tiago Botelho <tiagonbotelho@gmail.com> writes:
> 
> > git rev-list --first-parent --bisect-all F..E >revs &&
> > test_line_count = 9 revs &&
> > for rev in E e1 e2 e3 e4 e5 e6 e7 e8
> > do
> >   grep "^$(git rev-parse $rev) " revs ||
> >   {
> >     echo "$rev not shown" >&2 &&
> >     return 1
> >   }
> > done &&
> > sed -e "s/.*(dist=\([0-9]*\)).*/\1/" revs >actual.dists &&
> > sort -r actual.dists >actual.dists.sorted &&
> > test_cmp actual.dists.sorted actual.dists
> 
> The distance in the current graph might be all lower single-digits,
> but you need "sort -n -r" to be future-proof, as dist=10 would sort
> next to dist=1, perhaps in between dist=1 and dist=2.
> 
> Another thing you missed in my message is that the above does not
> say what distance value each commit should be assigned in the
> history.  Even though the grep loop makes sure that each of E, e1,
> ... e8 appears at least once, and line-count before that ensures
> that the output has 9 entries (and taken together, it guarantees
> that each of these appears not just "at least once", but also
> exactly once), nothing guarantees if they are getting relative
> distance correctly, as the sed strips a bit too much (and that
> relates to my earlier point why starting from a concrete expected
> output and explicitly discard the aspect of the output we do not
> care about before comparison---that way, we can easily tell when the
> code is _designed to_ discard too much).

From my point of view, this indicates that you want to set those exact
dist values in stone. I am not sure I follow that reasoning, as this
particular test case's purpose is to ensure that the `--first-parent`
option works with `--bisect`, not that the distance values match a fixed
expectation.

In short: I disagree that the *exact* values (beyond testing the order)
should be tested *here*.

Ciao,
Dscho
