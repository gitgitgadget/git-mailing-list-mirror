From: Marcin Cieslak <saper@saper.info>
Subject: Re: [PATCH] fix display overlap between remote and local progress
Date: Fri, 30 Mar 2012 14:56:03 +0000 (UTC)
Organization: http://saper.info
Message-ID: <slrnjnbic3.30f0.saper@saper.info>
References: <alpine.LFD.0.9999.0711032328490.21255@xanadu.home>
 <Pine.LNX.4.64.0711041331520.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 17:15:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDdXl-0006py-QW
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 17:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691Ab2C3PPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 11:15:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:35844 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571Ab2C3PPI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 11:15:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SDdXe-0006i3-EJ
	for git@vger.kernel.org; Fri, 30 Mar 2012 17:15:06 +0200
Received: from l.saper.info ([91.121.203.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 17:15:06 +0200
Received: from saper by l.saper.info with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 17:15:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: l.saper.info
User-Agent: slrn/0.9.9p1 (FreeBSD)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194365>

(This is about ANSI clear-eol sequence introduced to sideline.c in commit
 ebe8fa738dcf6911fe520adce0cfa0cb26dee5e2)

>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 4 Nov 2007, Nicolas Pitre wrote:
>
>> +#define SUFFIX "\e[K"  /* change to "        " if ANSI sequences don't work */ 
>
> I am almost certain (without even testing) that cmd.exe has problems with 
> that.  It does not even understand colorisation.
>
> My vote is to let it be for the moment, and us msysGit people will 
> probably add something like NO_ANSI_TERM=YesPlease later.

Hi,

We are using script(1) to record the workflow and troubleshoot problems.
script utility records all control codes as well (actually everything
that passes via pseudoterminal it creates.

We managed to get git quiet on most control codes with color.ui=false
and pager set to nothing, but we still get ESC [ K codes from the
remote output (we are using gerrit and it generates some). 

While I can live with git progress output lines in the log, it's
quite annoying to edit those ANSI sequences out of the script.
One has to remember to set TERM=dumb before invoking _some_ git
operations.

Is there any better solution possible?

//Marcin
