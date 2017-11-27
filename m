Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0922620C11
	for <e@80x24.org>; Mon, 27 Nov 2017 21:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbdK0VY5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 16:24:57 -0500
Received: from mout.gmx.net ([212.227.17.22]:60337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751686AbdK0VY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 16:24:56 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8qOm-1eOyo71LOG-00CDSO; Mon, 27
 Nov 2017 22:24:47 +0100
Date:   Mon, 27 Nov 2017 22:24:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Takuto Ikuta <tikuta@google.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] Use OBJECT_INFO_QUICK to speedup git fetch-pack
In-Reply-To: <CALNjmMo3KH4QXY00ViVaiHdy=pSZ5j0BWRueO1T=sC_r0=3c3g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711272222100.6482@virtualbox>
References: <0102015ffbbb2905-570eadd1-6b5c-46af-a3a9-bddfbd01c242-000000@eu-west-1.amazonses.com> <xmqqo9noe3u0.fsf@gitster.mtv.corp.google.com> <20171127043740.GA5994@sigill> <xmqqk1yce301.fsf@gitster.mtv.corp.google.com>
 <CALNjmMo3KH4QXY00ViVaiHdy=pSZ5j0BWRueO1T=sC_r0=3c3g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Qdw31980PrTsmJ6qEwLzweGFZ9YFVg+lf7dSjR0gI9HgvXOVSbY
 KVLS7AIcuJiBTqI2+/Igq8Z0ckLxmnWjc8wKBiZDefMk4guKzjCmgN69+lJs3+i8pPxAyLZ
 fJkQIrVoDBzUL1/3xJHrfwT63nPhyZYHlQaxUY26weWqTeJpLqo6l1Im3h9Z4p3M7MmEGK/
 bMDQLYaBZVbnPGH/iwqTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zo3ezdWxcOo=:uzdygNtT+jJS+EgDzS71Q8
 mnRrBJ1IzffAZvF3n9gVif5hxL8TsUnPJRej7OnonltKSkyRim62gqWnOnbaWf5R+E+KbBta8
 7z+a47oEGeBr4uA7IWkdm1O4URm6VFlE5PqZhSYzBssSXf36wNTrrHcy1LM10SyKW/FIY/o6Q
 luEB+YUedFDgpTE03PQaLyurhjwgvBz1EmJWp1gziGDqIt24gveDuMARWH8xDQNXVwY//d9eL
 vetA3kHJ5aoUzhrZwqD21PCk92JWPRNktv66xHnw3aeQ8o3GAYWhSMMsu1Fa6s7KXzU9WXE/K
 mBjfu7bYfqLHRddEAxk7oJBcAjoD8Zc3B2ReKBnHR9I7rz8nC8rXQf2/hPs4fe5GJOSgD30j1
 TtZacztMJyCeR14X28HPkvDmNyrLNrrFO0PpTvaYlGpcwbpvo2Tn/ABFLZ5+XW29ZoRyxMUpF
 4cODkb7X/mm3xU3NmWzN/WJZXE8Pm0SJ7qwU8MRyzAhUQ+np6P8egnjIe/ftxMmc76xjHP9Gj
 gQ49RFialmn9ZcYFNx5r6iPCkESxX5OO4zSsJEAvO9Cv6+y/LYqn9Q6I7IVdwAryr2f8gXMKV
 djvlvY+pwhtWJn+zfowSEaQVItbh3m3nKSDqVFymzfaqqqr51KcMLrB6bxO7MgXOvzpb2RYc3
 SfHuaI/HpxpyRzwPptQFgpiQ8t1F4/XQWeqIabIfaHvPPoCRMSgGKXLnGBHbpvjmF8dEraTsP
 yRQHwxOEdDIfP9xqt7EGds5v71pDSIRhCy5VGZTNP5LmHKIXScEPftwfhdZOUSGAYNpREzhaU
 X2qNkBrg8zFI6vEd6c0I09N0iHua7VChKtAFbk0Hw6mVPbsR4Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 27 Nov 2017, Takuto Ikuta wrote:

> 2017-11-27 13:53 GMT+09:00 Junio C Hamano <gitster@pobox.com>:
> > Jeff King <peff@peff.net> writes:
> >
> >>> The 5-patch series that contains the same change as this one is
> >>> cooking and will hopefully be in the released version before the end
> >>> of the year.
> >>
> >> I'd be curious if the 5th patch there provides an additional speedup
> >> for Takuto's case.
> >
> > Indeed, it is a very good point.
> >
> > IIUC, the 5th one is about fetching tons of refs that you have never
> > seen, right?  If a repository that has trouble with everything-local
> > is suffering because it right now has 300k remote-tracking branches,
> > I'd imagine that these remote-tracking branches are being added at a
> > considerable rate, so I'd not be surprised if these "new" refs
> > benefits from that patch.  And it would be nice to know how much a
> > real life scenario actually does improve.
> >
> > Thanks.
> 
> In chromium repository,  your 5th patch does not improve performance,
> took more than 5 minutes to run fetch on windows.
> 4th patch is very important for the repository in daily fetch.
> I hope your 4th patch will be merged.

If you want it in Git for Windows early (where performance is
traditionally worse than on Linux because Git is really optimized for
Linux), I would not mind a Pull Request at
https://github.com/git-for-windows/git.

My current plan is to release a new Git for Windows version on Wednesday,
to allow for a new cURL version to be bundled.

Ciao,
Johannes
