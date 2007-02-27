From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: Patch editing
Date: Tue, 27 Feb 2007 12:54:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702271247000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702252156190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702270205540.6485@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 12:55:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM0v7-0007v0-Hh
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 12:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933047AbXB0Ly6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 06:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933051AbXB0Ly6
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 06:54:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:35703 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933047AbXB0Ly6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 06:54:58 -0500
Received: (qmail invoked by alias); 27 Feb 2007 11:54:56 -0000
X-Provags-ID: V01U2FsdGVkX1+3tdVwL7+3SVE7SQJtD3s3pVyDOtGZ1X8l9KAgEU
	UeOA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702270205540.6485@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40714>

Hi,

On Tue, 27 Feb 2007, Daniel Barkalow wrote:

> For much the same reason, I wrote a script that entirely ignores the 
> intermediate commits in a throw-away head, and lets you trim down the 
> diff between the mainline and your head, and arrange it into a new patch 
> series.

It looks to me like you just start a new branch, get the state of an 
existing commit *1*, and then "git add -i" your way through that diff.

This is slightly different from my work flow:

- I can have overlapping changes (i.e. one commit fixes something which 
  gets refactored in the next), and

- I try not to touch the code when editing the patch series. Only in the 
  conflicting case, I _have_ to edit it.

The latter means, of course, that the commits in the throwaway branch 
_must_ be a superset of the commits I want to have in the cleaned up 
branch. (Meaning that I never commit two unrelated things with the same 
commit.)

To achieve that, I use my own version of "git add -i" quite often while 
composing the throwaway branch. For example, when I found a bug with an 
easy fix, in the middle of something different, and the fix touches a file 
that is already changed, I only commit the appropriate hunks of that file.

Ciao,
Dscho

*1* It is not really as easy as "git diff ..other-branch | git apply", 
since you would lose valuable information about added files, so you have 
to be very careful there.
