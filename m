Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D19520196
	for <e@80x24.org>; Thu, 14 Jul 2016 13:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbcGNNPi (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 09:15:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:63753 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbcGNNPh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 09:15:37 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MC8iq-1bWWAt3SiW-008svB; Thu, 14 Jul 2016 15:15:31
 +0200
Date:	Thu, 14 Jul 2016 15:15:13 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2016, #05; Wed, 13)
In-Reply-To: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607141505160.6426@virtualbox>
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:BxrX7yQx4q7l/hrdlxfwO/4Z1Dawb2A/8IRah08bCvj4kzRwK7d
 r8/EsCm3pSohEPeKKEa/aT/fMffOcFoipR8MpApBZf5RjLxrwIKe9udL6m1tIywD877E+OV
 SQFQ1cRbAxgUsWW/QFSczSi/VTX3TtHUxfMgv7meN7U39w+B7p9PMoRCkOolK7iWzWiM1Wk
 eG5PeBoshKQ6IXq263NSg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:iiJnPGiyEiA=:MQCDJyotYqbL/nbkjlj4i6
 BRNDJ/5Qgt7SUC0gGTV73DMSNRh+jLp+Io84bS/bLS02OwQidKJUq3573Iir3FehWke3M8HpW
 qRFH09RHlnL7w6M+24zEf+kIf9S5wl5OC3YVQnlIyaigTShHPThTdEotUUzKsW07X1YU6qBpu
 CA++jzqSSvDI7KITJrptW95AL5kdXfS+W3g7VB6Ll6WcHkFNAVWC0JsxczPeUE1xVvlabSdu4
 qNaM8TqFNtwh+9AU/hd3JSPxXBPxPxEW7SXU2BqzRxMLfwSkUupeLlbkAvZxbEqdJmDiDv9tW
 oRkFdHq/H3SMM+1UhLwIibdcAo3xbfNuhgLFbha63y3v7/H3tl1zdc/fiZfb/kjOoANBsXhHt
 8/bnbqVRfDa0k8mKO0Myp+mRyHtt798roaLWj8gyYWQlbp5PmLZf7uThrYxF/cEUN0SC8ou5Y
 hZp9Y9M0zZK5/H1H4HaP1YHUp7O6bivY1DkXBKWLeF10DWBN77K6W+XJLNGg87G5WzCyqo98O
 EORav9Cq+lcvWcmtfva8l+CVmlQ03SmlijS/tPnwxgOgN3DTWCxIgNZdv9/vvfU25eLtL7x33
 8iLxQV+k4Wtzj9ppFWBq4wePdiSlKgZBkx/X32WwbOmxr/sAZvzSxCzH6BHD0dtKh9qaBY/nQ
 vYz6YxICjR2Ccikd9v/nOs2UJZvITfxbEgh/ryNP4rZuAUTHTDxYk5ywMd+Y8GQBSS93SEiud
 GvmMiN0Oca/E7UNh8uzhycn9CfBDmAowQqsakm+qt/c8vp7lr4SW91OsUilg3iCDE3ppc5uZl
 PxKGeXV
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 13 Jul 2016, Junio C Hamano wrote:

> * jc/renormalize-merge-kill-safer-crlf (2016-07-12) 2 commits
>  - merge: avoid "safer crlf" during recording of merge results

I like the verbose commit message, it really makes it easier to understand
the issue as well as the solution. As to the diff:

+       ret = add_cache_entry(ce, options);
+       if (refresh) {

Should we really refresh, even if ret < 0?

+               struct cache_entry *nce;
+
+               nce = refresh_cache_entry(ce, CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSING);

This line is overly long, but there is a *lot* of precedent for that in
merge-recursive.c, unfortunately. So this is just a remark, not an
objection.

>  - convert: unify the "auto" handling of CRLF

I *think* this is a good thing to do. And I also have to admit that the
only thing I can say about that test matrix in t0027 (both pre- and
post-image) is that it is visually mesmerizing. So I cannot even say
whether those changes make sense to me because I cannot wrap my head
around the changes in the tests.

Ciao,
Dscho
