From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Configure test for FREAD_READS_DIRECTORIES
Date: Tue, 4 Mar 2008 13:43:42 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803041332580.22527@racer.site>
References: <200803041244.11315.michal.rokos@nextsoft.cz> <alpine.LSU.1.00.0803041204490.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Tue Mar 04 14:47:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWXSI-0002eQ-5n
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 14:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbYCDNoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 08:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbYCDNoa
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 08:44:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:57708 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750808AbYCDNo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 08:44:29 -0500
Received: (qmail invoked by alias); 04 Mar 2008 13:44:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 04 Mar 2008 14:44:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hgsdhlp9h2jZsyrnBZxXSs34oLWIkNQPXubLf7M
	TXCrB0nfqKc3cD
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803041204490.22527@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76084>

Hi,

On Tue, 4 Mar 2008, Johannes Schindelin wrote:

> I will test on msysGit in a moment.

Unfortunately, "autoconf" does not work in msysGit at the moment.

However, applying this patch on Linux, extracting the product of "make 
dist" on msysGit, and running "./configure" yields this:

...
checking whether system succeeds to read fopen'ed directory... yes
...

And indeed, FREAD_READS_DIRECTORIES is set in config.mak.autogen.  
However, "f" was NULL in your test, so I am not quite sure what is going 
wrong...

Besides, you miss a return 0 in the end, I think.  Or even better: you 
should

	return f && fread(&c, 1, 1, f);

BTW the commit message looks like this here... not nice (the commit log 
is not a mailing list):

commit 67418ff5d4f548f7de23e97bf165a8529ebf6a31
Author: Michal Rokos <michal.rokos@nextsoft.cz>
Date:   Tue Mar 4 12:44:11 2008 +0100

    Configure test for FREAD_READS_DIRECTORIES

    Hello,

    this patch adds missing tests for FREAD_READS_DIRECTORIES.

    Could anyone volunteer to test it on different platforms?
    So far I know it works well on Linux (no FREAD_READS_DIRECTORIES),
    HP-UXes 11.11 and 11.23 (FREAD_READS_DIRECTORIES defined).

    Thanks

    MR

    Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>


Ciao,
Dscho

