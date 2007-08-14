From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch -
 scripts/get_maintainer.pl
Date: Tue, 14 Aug 2007 11:40:09 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708141131140.30176@woody.linux-foundation.org>
References: <1186984174.10249.7.camel@localhost>  <200708131933.10125.m.kozlowski@tuxland.pl>
  <1187026955.2688.4.camel@laptopd505.fenrus.org>  <1187037445.6628.98.camel@heimdal.trondhjem.org>
  <1187054366.2757.0.camel@laptopd505.fenrus.org>  <46C10AA8.3090505@gmail.com>
 <20070814102033.604c8695@the-village.bc.nu>  <46C1CFFE.4000001@gmail.com>
 <1187110824.32555.76.camel@localhost>  <46C1EE6F.2080807@gmail.com>
 <1187116082.32555.122.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Rene Herman <rene.herman@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 20:43:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL1MC-0003oq-8N
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 20:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761573AbXHNSm7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 14:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759317AbXHNSm7
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 14:42:59 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37564 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753499AbXHNSm5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Aug 2007 14:42:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7EIeFGO012044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 14 Aug 2007 11:40:16 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7EIe9Vl015179;
	Tue, 14 Aug 2007 11:40:09 -0700
In-Reply-To: <1187116082.32555.122.camel@localhost>
X-Spam-Status: No, hits=-4.748 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55846>



On Tue, 14 Aug 2007, Joe Perches wrote:

> On Tue, 2007-08-14 at 20:03 +0200, Rene Herman wrote:
> > "git info --maintainer drivers/ide/ide-cd.c" or some such would say "Alan 
> > Cox <alan@...>".
> 
> Perhaps maintainer(s), approver(s), listener(s)?
> 
> I think something like this should be a git-goal.
> What do the git-wranglers think?

The thing is, if you have git, you can basically already do this.

Do a script like this:

	#!/bin/sh
	git log --since=6.months.ago -- "$@" |
		grep -i '^    [-a-z]*by:.*@' |
		sort | uniq -c |
		sort -r -n | head

and it gives you a rather good picture of who is involved with a 
particular subdirectory or file.

A much *better* picture than some manually maintained thing, in fact, 
because it tells you who really does the work, and which way patches go...

(Maybe you want to add a

	grep -v '\(Linus Torvalds\)\|\(Andrew Morton\)'

to avoid seeing the normal chain too much, but hey, we probably want to 
know too. Anyway - the script can certainly be tweaked, the point is 
really just that the git tree _already_ contains the relevant 
information).

		Linus
