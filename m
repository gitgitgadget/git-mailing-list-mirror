Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D44901FBEC
	for <e@80x24.org>; Thu,  9 Mar 2017 11:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbdCILon (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 06:44:43 -0500
Received: from mout.gmx.net ([212.227.17.20]:61139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753450AbdCILon (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 06:44:43 -0500
Received: from virtualbox ([95.208.58.21]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lz3JU-1c8Ui833Oi-0149DK; Thu, 09
 Mar 2017 12:26:16 +0100
Date:   Thu, 9 Mar 2017 12:26:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/2] Fix crashes due to real_pathdup() potentially
 returning NULL
In-Reply-To: <20170308161742.lpbf6gn6qhoex7et@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1703091224360.3767@virtualbox>
References: <cover.1488987786.git.johannes.schindelin@gmx.de> <20170308161742.lpbf6gn6qhoex7et@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IOxJ95AJX9695EpryqoqKNE9fPZvpHyYRxnKRZi3PQgcSA9b3mH
 3ILjsHJAR/pF2JKLMVcbLGqlP8jTExfztKUQ7fWwZ/ifbHJHPZGrHK3P1wscJK1S4wg3q5A
 Vvkw31HtTwndWUyGniEkdQDFxsaDGF5tqEaXuTN8jnKmor/qEUCCcIoaQOb5BIYUZXuxQHd
 L5GFxky8HL68pu4GP3Nng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KmjHgIMXTYc=:487xp9nNSLPmzkebx3oi0Z
 DYJyjG1KHsqOTMoJC23dP3LRan8UIk6W2v6MQZBH08Kxu7LPsN126P6oZbzcy0YQGMmmxLkJb
 ZAiYoFFyOgc+cP8YL2SmtqSSqgXwZF5Tli90P1Zv3iYLRlB3KPqvTV6T+CWZQFNsKFM87Zney
 nvKluwKCbe4Ie/deVLMO3nD2b5Kix43wWmZ1ZexO3e/qoPBKFRCEssbdJEM/oF11n8sbXklB4
 tVTqFRrhSeQ8nD5kKN66VXk7rGrtLlaN/lwMGXeC/0okRgeDfr3ICZUomt7D6WNVafxDtt3If
 9rx7UX6hFwrOsRbtw4yShPhHMJH7rbM4I7pZvYO3yJJvZXD0Ukw4L6CWqj/qJzDx7C/2OXmYV
 x/np2GS1qRRaBJbbz721Oyd/ucu3x4sjIfzsmGHRdxBWZ2PGmKcl+/abrG3qAvFx3gMt7+E6i
 Rfab6JSlYzCpBbnnLzplvPZawIUTkmL8S+1LkkkvQJaip9kwgrxwtiBW9sUBw/S4kCEGm0exm
 PrhwfS39MN2L0jFYNL9/E9XTnOfszPovDNWY9v3RnyYHG4AAOmGAt51pMV8v4QiDNZ5/LacIw
 WUZJ31F1JkevFYiGke6PhDr/UjNWDJ9teIYP1R9jWTzFtV42Enp43JY12+4uEIAwSBNGc/j1u
 Kzn3LcynbB/zTL6O+Pyy1VcbHPvBFvRWPYol+0VigClqnDtZuuB6WBAdBgSbDdJ+FdE8Cdl5P
 Qo0SIhgvCfOoPgRkFuVMFzLZGZGPuTC5wRXgkwPNNzRZl5UcqL2YIMtIqOfZf07V1foBHmFku
 7F/Ruxj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 8 Mar 2017, Jeff King wrote:

> On Wed, Mar 08, 2017 at 04:43:27PM +0100, Johannes Schindelin wrote:
> 
> > We may want to consider fast-tracking this into v2.12.1, and to that
> > end, I would appreciate code reviews that focus on the correctness of
> > this patch and that try to consider undesired side effects.
> 
> I don't see how it could be not-correct, in the sense that every caller
> now passes the die_on_error flag (restoring the original behavior)
> except for the one which clearly checks for a NULL return immediately
> afterward.

Indeed. The principal reason why I extended the function signature was so
that any bugs would become obvious.

> The only exception would be if there were new calls to real_pathdup()
> that did not originally use real_path(). But:
> 
>   # 7241764076 introduced real_pathdup
>   git log -Sreal_pathdup 7241764076..
> 
> shows only one other introduction, and it's just duplicating an existing
> call.

Thanks for digging that up. I really only looked at the existing code in
`master` to figure out whether the return values were checked against NULL
or not.

> It's possible that some of these _could_ handle the error case more
> gracefully (I already fixed one such case in 3a1345af2). But even if
> we wanted to do so, that should come separately on top of this patch.
> This can go to 'maint' as a regression fix, and then that gives a stable
> base for making potential improvements.

Fully agree.

Thank you for the thorough review,
Johannes
