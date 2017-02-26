Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79FA0201B0
	for <e@80x24.org>; Sun, 26 Feb 2017 01:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbdBZBO1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 20:14:27 -0500
Received: from outbound1.eu.mailhop.org ([52.28.251.132]:17258 "EHLO
        outbound1.eu.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbdBZBO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 20:14:26 -0500
X-MHO-User: df46b5d5-fbc0-11e6-95b5-6dfd7dbb0ee5
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 173.50.81.193
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [173.50.81.193])
        by outbound1.eu.mailhop.org (Halon) with ESMTPSA
        id df46b5d5-fbc0-11e6-95b5-6dfd7dbb0ee5;
        Sun, 26 Feb 2017 01:14:09 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id 2682C80018;
        Sun, 26 Feb 2017 01:13:59 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io 2682C80018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1488071639;
        bh=fVfG0o+i9Dgl+ZJsmKy1Eh1d/kJiJBAofvUgBuMfaWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gTgf30EFgPakK4m5iedBqlrOp7Iok4v9TpV4RCS4dHTn7KsQMGOzMoWJgpnW6cL+c
         7LQ1CUnAZKOjkIT/V86lFXCgexH7h4jxN5P64hkUKr8TIUSxaatX5petwKpytKEJ5J
         MTrHS1knHIcINR0aH+SR/LYk5r8ttk/xqOYkiEQ/c4TA96eEFRglhUVfUSS1mJlVug
         dWrPXAk5BS1QGcrAr57KNekmdVwd2+HipGzHoSxbBtU5ykVbeAl9v8L+E2tUROuIZP
         hFzNlZmpAoT1Xgo5pLkBoP12iVBYr72gdsUciMd0UEBWWztwZzj3MWNIxMve5dCgQD
         nF7EbVVkIDyyw==
Date:   Sun, 26 Feb 2017 01:13:59 +0000
From:   Jason Cooper <git@lakedaemon.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff King <peff@peff.net>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170226011359.GI11350@io.lakedaemon.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
 <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
 <xmqqinnyztqe.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqinnyztqe.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, Feb 24, 2017 at 10:10:01PM -0800, Junio C Hamano wrote:
> I was thinking we would need mixed mode support for smoother
> transition, but it now seems to me that the approach to stratify the
> history into old and new is workable.

As someone looking to deploy (and having previously deployed) git in
unconventional roles, I'd like to add one caveat.  The flag day in the
history is great, but I'd like to be able to confirm the integrity of
the old history.

"Counter-hashing" the blobs is easy enough, but the trees, commits and
tags would need to have, iiuc, some sort of cross-reference.  As in my
previous example, "git tag -v v3.16" also checks the counter hash to
further verify the integrity of the history (yes, it *really* needs to
check all of the old hashes, but I'd like to make sure I can do step one
first).

Would there be opposition to counter-hashing the old commits at the flag
day?

thx,

Jason.
