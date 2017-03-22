Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58A322095D
	for <e@80x24.org>; Wed, 22 Mar 2017 22:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751299AbdCVWEL (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:04:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:49750 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750867AbdCVWEK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:04:10 -0400
Received: (qmail 29472 invoked by uid 109); 22 Mar 2017 22:04:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 22:04:09 +0000
Received: (qmail 32489 invoked by uid 111); 22 Mar 2017 22:04:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 18:04:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Mar 2017 18:04:05 -0400
Date:   Wed, 22 Mar 2017 18:04:05 -0400
From:   Jeff King <peff@peff.net>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 3/3] t7004, t7030: fix here-doc syntax errors
Message-ID: <20170322220404.ierzftpw3liugguo@sigill.intra.peff.net>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
 <20170322200805.23837-1-gitster@pobox.com>
 <20170322200805.23837-4-gitster@pobox.com>
 <20170322211003.b52cql3iwig2xqcd@sigill.intra.peff.net>
 <20170322214356.5jj7dggtvgilreci@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170322214356.5jj7dggtvgilreci@LykOS.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 05:43:57PM -0400, Santiago Torres wrote:

> > Like 2/3, this one also produces test failures for me. It looks like
> > "verify-tag" does not show a tag which has been forged. I'm not sure if
> > that's intentional (and the test is wrong) or a bug. 
> 
> I see that offending code would be [1]. Changing this behavior should be
> trivial (dropping the continue), although I'm not sure if this is what
> we want?

I could see arguments for either behavior. The fact that v2.12 was
released with the skip-gpg-failures behavior makes me inclined to just
keep that and fix the test. But I don't feel strongly.

If we do change it, I think builtin/tag.c:verify_tag() would need a
similar fix (to avoid the early return).

-Peff
