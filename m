Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34F1E20958
	for <e@80x24.org>; Mon, 27 Mar 2017 02:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbdC0C7S (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 22:59:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:52199 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751811AbdC0C7R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 22:59:17 -0400
Received: (qmail 4504 invoked by uid 109); 27 Mar 2017 02:58:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Mar 2017 02:58:21 +0000
Received: (qmail 19186 invoked by uid 111); 27 Mar 2017 02:58:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Mar 2017 22:58:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Mar 2017 22:58:18 -0400
Date:   Sun, 26 Mar 2017 22:58:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 3/3] rev-parse: match ^{<type>} case-insensitively
Message-ID: <20170327025818.pbm4nwqrfolyto7g@sigill.intra.peff.net>
References: <20170326121654.22035-1-avarab@gmail.com>
 <xmqq1stszxn4.fsf@gitster.mtv.corp.google.com>
 <20170326121654.22035-4-avarab@gmail.com>
 <xmqq60iv4ku2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60iv4ku2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 26, 2017 at 05:36:21PM -0700, Junio C Hamano wrote:

> It's not "potential confusion".  This closes the door for us to
> introduce "TREE" as a separate object type in the future.
> 
> If we agree to make a declaration that all typenames are officially
> spelled in lowercase [*1*] and at the UI level we accept typenames
> spelled in any case, then we can adopt this change (and then we need
> to update "cat-file -t" etc. to match it).
> 
> I do not at all mind to see if the list concensus is to make such a
> declaration and permanently close the door for typenames that are
> not lowercase, and after seeing such a concensus I'd gladly
> appreciate this patch, but I do not want to see a change like this
> that decides the future of the system, pretending as an innocuous
> change, sneaked in without making sure that everybody is aware of
> its implications.

FWIW, I cannot see us ever adding TREE (or Tree) as a separate type.
It's too confusing for no gain. We'd call it "tree2" or something more
obvious.

So I don't mind closing that door, but I'm not sure if a partial
conversion (where some commands are case-insensitive but others aren't
yet) might not leave us in a more confusing place.

I dunno. I guess I have never wanted to type "^{Tree}" in the first
place, so I do not personally see the _benefit_. Which makes it easy to
see even small negatives as a net loss.

-Peff
