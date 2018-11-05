Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6074A1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 06:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbeKEQJr (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 11:09:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:40432 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729412AbeKEQJr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 11:09:47 -0500
Received: (qmail 22422 invoked by uid 109); 5 Nov 2018 06:51:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Nov 2018 06:51:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17355 invoked by uid 111); 5 Nov 2018 06:50:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Nov 2018 01:50:55 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2018 01:51:36 -0500
Date:   Mon, 5 Nov 2018 01:51:36 -0500
From:   Jeff King <peff@peff.net>
To:     Matthias Urlichs <matthias@urlichs.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: "git checkout" safety feature
Message-ID: <20181105065136.GN25864@sigill.intra.peff.net>
References: <6afef19d-08f6-9cce-a491-3a49808c57ec@urlichs.de>
 <xmqqk1lsl448.fsf@gitster-ct.c.googlers.com>
 <fdedc47b-8661-9451-b4ef-12ec6bd13c04@urlichs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fdedc47b-8661-9451-b4ef-12ec6bd13c04@urlichs.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 05, 2018 at 07:24:42AM +0100, Matthias Urlichs wrote:

> Hi,
> > "git checkout <commit> <pathspec>" is a feature to overwrite local
> > changes.  It is what you use when you make a mess editing the files
> > and want to go back to a known state.  Why should that feature be
> > destroyed?
> 
> Not destroyed, but optionally made finger-fumble-save – like "alias rm
> rm -i".

There are a couple of destructive commands left in Git (e.g., this one,
and "git reset --hard" is another). I didn't dig up archive references,
but the topic of safety valves has come up many times over the years.
The discussion usually ends with the notion that instead of warning
that the operation is destructive (because that gets annoying when its
purpose is to be destructive), we should make it possible to undo a
mistake.

So in this case, that would mean saving the working tree file to a blob
before we obliterate it.

See similar discussion in:

  https://public-inbox.org/git/CACsJy8C5QOLvg4pzy_pThQoyGh9ohdeVHXsuYwQHQypn3oBxkw@mail.gmail.com/

for example.

-Peff
