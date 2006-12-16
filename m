X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Can git be tweaked to work cross-platform, on FAT32?
Date: Sat, 16 Dec 2006 12:37:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612161227510.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <0MKwpI-1GuWVF2znk-0006fC@mrelayeu.kundenserver.de>
 <46a038f90612132155rc987a9cs6a4fa33dd4c882c6@mail.gmail.com>
 <0ML25U-1GvWC81sjR-0001UB@mrelayeu.kundenserver.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 16 Dec 2006 11:37:40 +0000 (UTC)
Cc: git@vger.kernel.org, martin.langhoff@gmail.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <0ML25U-1GvWC81sjR-0001UB@mrelayeu.kundenserver.de>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34607>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvXrF-0002zW-C8 for gcvg-git@gmane.org; Sat, 16 Dec
 2006 12:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753631AbWLPLhe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 06:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753636AbWLPLhd
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 06:37:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:48836 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1753631AbWLPLhd
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 06:37:33 -0500
Received: (qmail invoked by alias); 16 Dec 2006 11:37:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp048) with SMTP; 16 Dec 2006 12:37:31 +0100
To: "Florian v. Savigny" <lorian@fsavigny.de>
Sender: git-owner@vger.kernel.org

Hi,

On Sat, 16 Dec 2006, Florian v. Savigny wrote:

> DO your answers imply that it is NOT possible (by "possible", I mean of 
> course: possible without re-programming the source code ;-)) to compile 
> git in a way that would enable it to work DIRECTLY with a local 
> repository on FAT32 from both Windows and Linux (or, perhaps more 
> simple: to work directly with a repository on FAT32 under Linux)?

My answer was not so clear...

Question: Is it possible to use git on a FAT32 filesystem?

Answer: Yes.

Question: Is it possible to access such a repository from both Linux and 
Windows?

Answer: Yes.

Question: Is there anything that could cause problems?

Answer: Yes. The working directory is a problem.

	- Symlinks for example. Don't use them.
	- Umlauts: don't use them.
	- The index has to be updated, since the stat information is 
	  unlikely to match. A simple "git status" should suffice, though.
	- Permissions: the permission handling of Linux and Windows are
	  quite different. If you initialize the repository with Cygwin,
	  it automatically sets core.filemode=false, if you initalize(d) 
	  with Linux, you have to adjust manually.

Question: Are there other shortcomings to this approach?

Answer: Definitely. Most are only annoying (like the performance of FAT32, 
which literally sucks), but some are different: for example, if you 
compile things in the working directory, you will be unhappy.

> 3. ad Johannes: This does sound quite simple and straightforward. If I
>    got it right, it would involve having one repository on a, say,
>    ext2 partition to work with under Linux, and one on a FAT32
>    partition to work with under Windows, and syncing the two after
>    booting (fetching from FAT32) and before shutting down (pushing to
>    FAT32) Linux.

This is how I'd do it.

>    It is quite interesting, BTW, that git can /sync/ with a repository
>    on FAT32 under Linux, but not work with it.

You can. But I wouldn't. I like to keep separations clean and obvious.

Ciao,
