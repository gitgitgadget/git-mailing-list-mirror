Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43CE9202BB
	for <e@80x24.org>; Tue, 19 Mar 2019 06:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfCSG1r (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 02:27:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:56052 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726020AbfCSG1r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 02:27:47 -0400
Received: (qmail 7206 invoked by uid 109); 19 Mar 2019 06:27:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Mar 2019 06:27:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27100 invoked by uid 111); 19 Mar 2019 06:28:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 19 Mar 2019 02:28:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2019 02:27:45 -0400
Date:   Tue, 19 Mar 2019 02:27:45 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/7] gc: minor code cleanup + contention fixes
Message-ID: <20190319062745.GB31801@sigill.intra.peff.net>
References: <20190313235439.30439-1-avarab@gmail.com>
 <20190314123439.4347-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190314123439.4347-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 01:34:32PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Addresse Peff's comments to v1. For a couple of patches I've faked up
> his SOB where I copy/pasted a comment or code from a v1 comment
> verbatim. Will see if he acks that.

Yep, for the record, those are fine (actually, I guess one of them got
axed in v3).

> The main change is a better commit message in the last patch (now
> 7/7), and 2x new "reflog" patches to make it early exit in addition to
> "gc" when there's nothing to do.
> 
> There was the "why do it at all in gc" feedback on 6/7 in v1. I've
> adjusted the commit message there to justify it, but we'll see what
> Peff things about it this time around...

Even after reading your v3 reasoning, I still think it would probably be
OK for git-reflog to treat the "never" case as a noop. But frankly it's
not worth even spending any more brain cycles on. I can't imagine why
somebody would bother to run "reflog expire" without any expiration,
outside of git-gc.

The improved commit messages all made sense to me (including the NULL
oid bits in the final one), with the exception of one nit I pointed out
in one of the v3 messages.

-Peff
