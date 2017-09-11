Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25E3B202A4
	for <e@80x24.org>; Mon, 11 Sep 2017 11:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbdIKLP5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 07:15:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:55225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751605AbdIKLP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 07:15:56 -0400
Received: from virtualbox ([37.201.203.107]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MD9NE-1dfE8r3POW-00GccX; Mon, 11
 Sep 2017 13:15:37 +0200
Date:   Mon, 11 Sep 2017 13:15:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Kevin Willford <kewillf@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Subject: Re: [PATCH 1/1] reset: fix reset when using the sparse-checkout
 feature.
In-Reply-To: <xmqqh8w951ek.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1709111259430.4132@virtualbox>
References: <20170908180050.25188-1-kewillf@microsoft.com>        <20170908180050.25188-2-kewillf@microsoft.com>        <xmqqvaktxawk.fsf@gitster.mtv.corp.google.com>        <SN1PR21MB0014638E5D9CBFD0D9D85F10B7950@SN1PR21MB0014.namprd21.prod.outlook.com>  
      <xmqqr2vgy2yt.fsf@gitster.mtv.corp.google.com>        <SN1PR21MB00140C84DC02F3491F4E8469B76A0@SN1PR21MB0014.namprd21.prod.outlook.com> <xmqqh8w951ek.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bvylWoTNPCaro13ggw5b3Kdh8Li369TnnTTdEc0xuNEz5CGbPwt
 Hl2NOKy1Lourml6TvA27Wkx9OX2E2i/JiM1LX4ISumCWbkDY3OzHnSClithPsmeRSOyh0kf
 ZHvRiCg4jpOeL4xyHMgdBqKavTQkO4PUaUJJ4UG9XCWjoN5JMhjoUq0BEh5E2SwBI1qJjII
 zfgMuJp2HstR/yOsEp+KQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:35ITe5eYuCk=:ve/HiOSupZfzujUL4dJPeN
 4ych284UHWreowEPmJMbhSr6FJJkrFwkdxmiTHGAL1X9CJwxj1EYnLakQO9h4v37BTnuRpZ3A
 gFnsaGfXmZ2Y8VTBCtgUi6ybOXzdA1aLXJku/cygQWKrxPchunx8Poub0mDe9MQIVH1Df/7vu
 UqSkQlpqQqLBj+xtKC6y5jSIU2drCu959X1NDszWB2tXe5JTSFNDR1AFePojvvGcPz/a8QE3u
 zCWvLO2LHIJ8FmklVL4i68MfUQayKOViOmKiqtZO9rGQl0gJa3MADi+d26MYhXjO2ftfb5/xt
 Hmde/mXYdNcAC70knT0GeV1K64mjcpNcizJqKorOMuepbwWyIvnKivx5fZolNFLSlMq+rtmwA
 QDIAw8kO4dzYv6Q0j4vaJ97Htwhyg8AfP834dw0H4h5WdSpUa9ZN6bI40JTI9PYxsnbDWiR9U
 N3uStufOYj1mJh1M1grfhkHbuHEcjnUcTv0sNh2Kbn5kQRA9sLwOOjsjXKGWsxRqzg01NRBGd
 s6s63jip4yTdkj5QWxRbXvxkVmY0inuq1ATnSeNTuPDGI2RJcFY3S9qxQhkWcl06bJKtwv8nj
 p73jLwppqDfQylu3XSZWbfI27Z9wJ4azKEKsW7sTgj3wL1XlkXRATBzHOLJPE+IFUcK8rsSlp
 XpVjAElGLnBOA4FmXBogjuwseSvCxNohI0JiyL3drLCTs1rsFXp5M1LjTuJkBypLX9lp2ZW3z
 igytqmwEvDpQPc1Jgmz4MTseAqlzsa0ADxtSXICLl31ZjfcD8VPwyClQem8ldBwJKlqR9rFBJ
 BwYC5yiw1fKTT9CjMecrT9/h5GO0cVtnKdHnGkA0Yz1S2hSlUc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 11 Sep 2017, Junio C Hamano wrote:

> Stepping back a bit, I am not sure if it is sane or even valid for the
> end-user to modify paths outside sparse-checkout area, but that is
> probably a separate tangent.

That is not at all the scenario that Kevin fixed. Just have a quick look
at the regression test: in a sparse checkout, the user checked out a
branch, then called `reset` to switch to a different commit. No file was
touched by the user outside the sparse checkout.

Yet without Kevin's fix, `git status` would report that the user *deleted
files outside the sparse checkout*.

That is such an obvious bug, and Kevin's fix is such an obvious
improvement over the current upstream Git version, that I would think the
only thing worth discussing is whether the patch goes about it in a way of
which you approve.

For example, you mentioned that you would want to move the declaration of
`two` and `was_missing` into the conditional code block. That is a valid
suggestion for `was_missing` (but of course not for `two`, which is used
in the condition of the code block). That suggestion is more about code
style (and of course easily fixed by Kevin using Edit>Refactor>Move
Definition Location in VS), though, than about the correctness of the post
image.

Much more interesting would be a review of the conditional code block. And
I am not talking about the camelCasing of `ceBefore` (which will be fixed
as easily by Edit>Refactor>Rename). I am talking about the stuff where
tools cannot help, but where your experience is necessary: is it correct
to use make_cache_entry()/checkout_entry() in this case? Are the
parameters passed to those functions correct? Is the call to
cache_name_pos() followed by ce_skip_worktree() the best way to find out
whether the file that is absent was not actually deleted by the user, or
is there a less CPU-intensive way, seeing as we are already guaranteed to
iterate over the queue diff in alphabetical order?

I understand that those latter questions are a lot harder to answer, sorry
about that.

Ciao,
Dscho
