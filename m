From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Tue, 29 Jul 2008 14:32:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0807291339580.6791@localhost.localdomain>
References: <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org>
 <200807260512.40088.zippel@linux-m68k.org>
 <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
 <20080729053108.GH26997@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 14:34:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNoP3-0000pA-9w
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 14:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbYG2MdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 08:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbYG2MdI
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 08:33:08 -0400
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:4615 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbYG2MdG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 08:33:06 -0400
Received: from squid.home (linux-m68k.xs4all.nl [82.95.193.92])
	(authenticated bits=0)
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6TCWElA002805
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jul 2008 14:32:15 +0200 (CEST)
	(envelope-from zippel@linux-m68k.org)
X-X-Sender: roman@localhost.localdomain
In-Reply-To: <20080729053108.GH26997@sigill.intra.peff.net>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90625>

Hi,

On Tue, 29 Jul 2008, Jeff King wrote:

> > Can we please get past this and look at what is required to produce the 
> > correct history?
> 
> You seem to be indicating here (and elsewhere in the thread) that there
> exists some history graph for which neither "git log" nor "git log
> --full-history" produces the output you want, but that there is some
> better output (even if it might take more time to compute).
> 
> Perhaps I am just slow, but I haven't been able to figure out what that
> history is, or what the "correct" output should be. Can you try to state
> more clearly what it is you are looking for?

Most frequently this involves changes where the same change is merged 
twice. Another interesting example is kernel/printk.c where a change is 
added and later removed again before it's merged.
With "git-log --full-history" you see these changes, but it lacks the 
necessary merges to produce a full graph. As consequence none of the 
graphical front ends produce a useful history graph.

This problem now hits me now more seriously in a repository conversion, 
where it frequently happened, that changes were applied both locally and 
upstream, so that I have relatively many of these empty merges and the 
default git-log output is useless. --full-history is more of a workaround 
than a real solution and again the history graph in _all_ graphical front 
ends is useless.

More generally this means in any kind of situation where you maintain your 
own repository and it takes a while until upstream accepts your changes, 
so that you frequently have duplicated changes (because upstream doesn't 
use git or doesn't pull directly), you have to be careful to get the right 
history out of git.

The point is now that I think the problem is solvable even within Linus' 
constraints, so that git-log produces the right output by default and a 
workaround like --full-history isn't needed anymore.

bye, Roman
