From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6] Add a new test for using a custom merge strategy
Date: Mon, 28 Jul 2008 15:12:59 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807281506510.2725@eeepc-johanness>
References: <cover.1217207602.git.vmiklos@frugalware.org> <fd19583955e9cea5b78a465d23bc127a51940048.1217207602.git.vmiklos@frugalware.org> <5a003a0e20d0942c946680e4eade8e9d19f0036b.1217207602.git.vmiklos@frugalware.org>
 <9cc2813166c8b20ffb411c3a28ad86665e60033b.1217207602.git.vmiklos@frugalware.org> <10c4292de30b5868bd9fb54b557e8dae827f1241.1217207602.git.vmiklos@frugalware.org> <42e8615f6cbd236e40b19f2a754807f08e4b85a6.1217207602.git.vmiklos@frugalware.org>
 <03fa2187a72957d98d63ab899b39e9adc2edfe99.1217207602.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 15:13:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNSXS-0004UW-KB
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 15:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbYG1NL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 09:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754494AbYG1NLz
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 09:11:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:36347 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751209AbYG1NLz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 09:11:55 -0400
Received: (qmail invoked by alias); 28 Jul 2008 13:11:52 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp026) with SMTP; 28 Jul 2008 15:11:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+UPxQiV3yUiyun5TgrrdiT5RrLifePlg+IgSJqFb
	4TuaiGG6MzcCtD
X-X-Sender: user@eeepc-johanness
In-Reply-To: <03fa2187a72957d98d63ab899b39e9adc2edfe99.1217207602.git.vmiklos@frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90457>

Hi,

On Mon, 28 Jul 2008, Miklos Vajna wrote:

> Testing is done by creating a simple git-merge-theirs strategy which is 
> the opposite of ours. Using this in real merges is not recommended but 
> it's perfect for our testing needs.

Note that what was asked for, and what Junio implemented before deciding 
that it would do more harm than good in git.git, is not the same as what 
you provide.

Your -theirs is a strict opposite of -ours, i.e. the tree after the 
merge will be identical to the "merged" branch's tip's.

The -theirs which was asked for (and which I truly think is insane) wanted 
to do a merge, and in case of merge conflicts take the "upstream" version 
_only of the conflicting hunks_.

Just to make sure everyone grasps why this is bad:

- there is not only a real chance, but a high probability that a merge 
  conflict means that some related, unconflicting change relies on _one_ 
  version of the conflicting hunk which might very well be "ours", and

- since we have a _recursive_ merge, the notion of "upstream" is 
  completely bogus when working on any merge that has more than one merge 
  base.  This merge would succeed, but actively be wrong.

Just to make sure people do not have to ask for that version of 
"-theirs" again,
Dscho
