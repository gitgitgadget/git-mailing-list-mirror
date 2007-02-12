From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how to speed up "git log"?
Date: Mon, 12 Feb 2007 12:19:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702121215190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702111252.28393.bruno@clisp.org> <200702120041.27419.bruno@clisp.org>
 <200702120059.17676.robin.rosenberg.lists@dewire.com> <200702120302.00576.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 12:19:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGZDa-0007Vx-Lx
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 12:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbXBLLT3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 06:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbXBLLT3
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 06:19:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:32932 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964824AbXBLLT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 06:19:28 -0500
Received: (qmail invoked by alias); 12 Feb 2007 11:19:26 -0000
X-Provags-ID: V01U2FsdGVkX19K/9dStUxKs+O4cZM3a4drX7SkxsmMqqO2FRc9hq
	E+6g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702120302.00576.bruno@clisp.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39391>

Hi,

On Mon, 12 Feb 2007, Bruno Haible wrote:

> Robin Rosenberg wrote:
> > Since you know that you are not interested in the whole history, you can limit your scan.
> > 
> > git log COREUTILS-5_2_1..COREUTILS-6_4 src/tr.c
> 
> Thanks, that indeed does the trick: it reduces the time from 33 sec to 11 sec.
> 
> To reduce the time even more, and to allow more flexibility among the 
> search criteria (e.g. "I need the commits from date X to date Y, on this 
> file set, from anyone except me"), I would need to connect git to a 
> database. git cannot store all kinds of indices and reverse mappings to 
> allow all kinds of queries; that's really a classical database 
> application area.

[in the following paragraph, "index" means the index on a classical 
database table]

And -- as everywhere else with classical databases -- you have to ask if 
it is worth it. Given the fact that a one-time use of such an index is 
_worse_ than doing it without index at all (building and writing the 
index is _at least_ as expensive as searching once without an index), I'd 
rather doubt it.

However, if you do similar kinds of searches quite often, it makes tons of 
sense to connect to a database. We already use sqlite in cvsserver, so I'd 
try that.

Ciao,
Dscho
