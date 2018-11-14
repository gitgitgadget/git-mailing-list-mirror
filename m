Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 195851F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 07:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeKNR1I (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 12:27:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:38648 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731549AbeKNR1I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 12:27:08 -0500
Received: (qmail 3203 invoked by uid 109); 14 Nov 2018 07:25:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Nov 2018 07:25:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31407 invoked by uid 111); 14 Nov 2018 07:24:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Nov 2018 02:24:28 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2018 02:25:06 -0500
Date:   Wed, 14 Nov 2018 02:25:06 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com,
        sandals@crustytoothpaste.net, me@ttaylorr.com, jrnieder@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH v2 00/11] fast export and import fixes and features
Message-ID: <20181114072505.GC19904@sigill.intra.peff.net>
References: <20181111062312.16342-1-newren@gmail.com>
 <20181114002600.29233-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114002600.29233-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 04:25:49PM -0800, Elijah Newren wrote:

> This is a series of small fixes and features for fast-export and
> fast-import, mostly on the fast-export side.

I looked over this, and I think you've addressed all of my questions.

A few quick comments:

> Changes since v1 (full range-diff below):
>   - used {tilde} in asciidoc documentation to avoid subscripting and
>     escaping problems

I think just using backticks would make the source more readable, as
well as make the output prettier. But that's pretty minor.

>   - renamed ABORT/ERROR enum values to help avoid further misusage

This is an improvement, I think. It's a little funny that we still have
bare names for the non-ABORT bits, though (there's less semantic
overlap, but if it's a good practice to use qualified enum names, we
should probably just do so consistently).

>   - multiple small testcase cleanups (use $ZERO_OID, remove grep -A, etc.)

Looks good.

>   - add FIXME comment to code about string_list usage

Makes sense.

>   - record Peff's idea for a future optimization in patch 8 commit message
>     (is there a better place to put that??)

Seems like a reasonable place (though you are welcome to restate it if
you like).

>   - New patch (9/11): remove the unmaintained copy of fast-import stream
>     format documentation at the beginning of fast-import.c

Looks good. I wondered if there might be bits that need migrated, but
given the length of time that comment has been there, it's unlikely. And
in the worst case, if somebody finds some information missing from
git-fast-import.txt, they can still consult the history.

>   - Rewrite commit message for 10/11 to match the wording Peff liked
>     better, s/originally/original-oid/, and add documentation to
>     git-fast-import.txt

Looks good.

>   - Rewrite commit message for 11/11; the last one didn't make sense to
>     Peff.  I hope this one does.

Thanks for your patience in getting me to understand what you're trying
to do. At this point I still think that using rev-list and diff-tree is
probably the right solution for your use case.

-Peff
