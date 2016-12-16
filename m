Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CB801FF6D
	for <e@80x24.org>; Fri, 16 Dec 2016 02:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758960AbcLPClF (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 21:41:05 -0500
Received: from smtprelay0026.hostedemail.com ([216.40.44.26]:40657 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753911AbcLPClD (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Dec 2016 21:41:03 -0500
X-Greylist: delayed 612 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Dec 2016 21:41:03 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id A86875C720
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 02:30:51 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E9737C1F73;
        Fri, 16 Dec 2016 02:30:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: clam18_4134cb12b7501
X-Filterd-Recvd-Size: 3770
Received: from XPS-9350 (unknown [47.151.132.55])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri, 16 Dec 2016 02:30:47 +0000 (UTC)
Message-ID: <1481855446.29291.80.camel@perches.com>
Subject: Re: [PATCH] printk: Remove no longer used second struct cont
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 15 Dec 2016 18:30:46 -0800
In-Reply-To: <CA+55aFxaOFoh+Zrm5tNhU4hWu4Z032+nqV3vXK=QPJyhZsU3_A@mail.gmail.com>
References: <1481806438-30185-1-git-send-email-geert@linux-m68k.org>
         <20161215162336.GA18152@pathway.suse.cz>
         <20161216013706.GA20445@jagdpanzerIV.localdomain>
         <CA+55aFz3B2BfjG54z7ALOwezCHSdQp+YbFaHcJkCg=fzoKtfNg@mail.gmail.com>
         <1481853432.29291.76.camel@perches.com>
         <CA+55aFxaOFoh+Zrm5tNhU4hWu4Z032+nqV3vXK=QPJyhZsU3_A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.22.1-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2016-12-15 at 18:10 -0800, Linus Torvalds wrote:
> On Thu, Dec 15, 2016 at 5:57 PM, Joe Perches <joe@perches.com> wrote:
> > > 
> > > In fact, I thought we already upped the check-patch limit to 100?
> > 
> > Nope, CodingStyle neither.
> > 
> > Last time I tried was awhile ago.
> 
> Ok, it must have been just talked about, and with the exceptions for
> strings etc I may not have seen as many of the really annoying line
> breaks lately.
> 
> I don't mind a 80-column "soft limit" per se: if some code
> consistently goes over 80 columns, there really is something seriously
> wrong there. So 80 columns may well be the right limit for that kind
> of check (or even less).

Newspaper column widths were relatively small for a good reason.

I think most of the uses of simple statements should be on a single
line.  I'd rather see just a few arguments on a single line than a
dozen though.  Especially those with long identifiers, functions
with many arguments are just difficult to visually scan.

> But if we have just a couple of lines that are longer (in a file that
> is 3k+ lines), I'd rather not break those.
> 
> I tend use "git grep" a lot, and it's much easier to see function
> argument use if it's all on one line.
> 
> Of course, some function calls really are *so* long that they have to
> be broken up, but that's where the "if it's a couple of lines that go
> a bit over the 80 column limit..." exception basically comes in.
> 
> Put another way: long lines definitely aren't good. But breaking long
> lines has some downsides too, so there should be a balance between the
> two, rather than some black-and-white limit.
> 
> In fact, we've seldom had cases where black-and-white limits work well.

One thing that _would_ be useful is some enhancement to git grep
that would look for multi-line statements more easily.

The git grep -P option doesn't span lines.

grep 2.5.4 was the last version that supported the -P option to
grep through for multiple lines.

It'd be nice to have something like
	git grep --code_style=c90 --function <foo>

that'd show all multiple line uses/definitions/declarations of a
particular function.

I played with extending git grep a bit once, mostly to get the \s
mechanism to span lines.  It kinda worked.

Still, it seems like real work to implement well.
