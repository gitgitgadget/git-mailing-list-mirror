From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 20:30:05 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901252016590.14855@racer>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0901251916010.14855@racer> <alpine.GSO.2.00.0901251033160.12651@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Sun Jan 25 20:34:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRAkE-0004ha-OP
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 20:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbZAYT3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 14:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbZAYT3q
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 14:29:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:52635 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750854AbZAYT3p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 14:29:45 -0500
Received: (qmail invoked by alias); 25 Jan 2009 19:29:40 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp038) with SMTP; 25 Jan 2009 20:29:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+OiM9L06yO0NHF5WM5l2ZIseUjNL9Shf0xuI904k
	GO/v5QeL0JNTx9
X-X-Sender: gene099@racer
In-Reply-To: <alpine.GSO.2.00.0901251033160.12651@kiwi.cs.ucla.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107087>

Hi,

On Sun, 25 Jan 2009, Keith Cascio wrote:

> On Sun, 25 Jan 2009, Johannes Schindelin wrote:
> 
> > That would break existing scripts using "git diff" rather badly.  We 
> > already did not allow something like "git config alias.diff ..." from 
> > changing the behavior of "git diff", so I cannot find a reason why we 
> > should let diff.primer (a misnomer BTW) override the behavior.
> 
> I took special care to protect all core scripts from the effects.

What about my scripts I have here locally?  Do you want to change them, 
too?

> I fact, by introducing the cpp macro DIFF_MACHINE_FRIENDLY() and the 
> command-line options "--machine-friendly" and "--no-primer", I made such 
> protection declarative.  Don't you find it preferable that existing 
> programs and scripts would explicitly declare their desire for 
> machine-friendly output?

No.  We made a promise long time ago that plumbing (and "git diff" is 
pretty much plumbing, except for the configurable colorness) would not 
change behind scripts' backs.

And since Shawn uses plumbing for that very reason, your diff.primer patch 
would not be allowed to make a difference.  Ever.

Now, if you would have changed only the UI diff things (i.e. git diff, but 
not git diff-files), I could have accepted the diff.primer patch for 
different applications than "git gui", but from cursory reading of your 
patch it does not appear so.

Speaking of appearance (or for that matter, explaining why it was only a 
cursory reading): did it not occur to you that your coding style is 
utterly different from the surrounding code?

Just to number a few things that would definitely prohibit this patch from 
being applied:

- space instead of tabs,

- horrible lengths of spaces within the line,

- no space after if, but after the parenthesis.

Now, this could be good explanation why you need the patch (to ignore 
white-space), but that is not a reason of letting us suffer, too.

Besides, it seems you did a lot of "fixes" on the side that I do not like 
at all.  Simple example: if the original code cleared the 
DIRSTAT_CUMULATIVE flag, it is not acceptable for you to introduce an 
unnecessary if(), testing if the CUMULATIVE flag was set to begin with.

Ciao,
Dscho
