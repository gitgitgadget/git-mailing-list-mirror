Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DB7F1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 20:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756174AbdCGUIc (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 15:08:32 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:45968 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756171AbdCGUIb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 15:08:31 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1clKIq-0006rU-VL; Tue, 07 Mar 2017 18:57:45 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22719.680.730866.781688@chiark.greenend.org.uk>
Date:   Tue, 7 Mar 2017 18:57:44 +0000
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, bmwill@google.com,
        jonathantanmy@google.com, peff@peff.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: RFC: Another proposed hash function transition plan
Newsgroups: chiark.mail.linux-rutgers.git
In-Reply-To: <20170304011251.GA26789@aiede.mtv.corp.google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder writes ("RFC: Another proposed hash function transition plan"):
> This past week we came up with this idea for what a transition to a new
> hash function for Git would look like.  I'd be interested in your
> thoughts (especially if you can make them as comments on the document,
> which makes it easier to address them and update the document).

Thanks for this.

This is a reasonable plan.  It corresponds to approaches (2) and (B)
of my survey mail from the other day.  Ie, two parallel homogeneous
hash trees, rather than a unified but heterogeneous hash tree, with
old vs new object names distinguished by length.

I still prefer my proposal with the mixed hash tree, mostly because
the handling of signatures here is very awkward, and because my
proposal does not involve altering object ids stored other than in the
git object graph (eg CI system databases, etc.)

One thing you've missed, I think, is notes: notes have to be dealt
with in a more complicated way.  Do you intend to rewrite the tree
objects for notes commits so that the notes are annotations for the
new names for the annotated objects ?  And if so, when ?

Also I think you need to specify how abbreviated object names are
interpreted.

Regards,
Ian.
