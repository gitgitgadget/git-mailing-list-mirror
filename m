From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: gitweb/test/Marchen always untracked?
Date: Sat, 8 Jul 2006 21:36:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607082131450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060708185322.GA17708@spearce.org>
 <Pine.LNX.4.63.0607082058340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 21:36:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzIb7-0002nx-7i
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 21:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWGHTgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 15:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWGHTgJ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 15:36:09 -0400
Received: from mail.gmx.de ([213.165.64.21]:30921 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030245AbWGHTgI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 15:36:08 -0400
Received: (qmail invoked by alias); 08 Jul 2006 19:36:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 08 Jul 2006 21:36:07 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <Pine.LNX.4.63.0607082058340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23500>

Hi,

On Sat, 8 Jul 2006, Johannes Schindelin wrote:

> On Sat, 8 Jul 2006, Shawn Pearce wrote:
> 
> > I'm not sure what is going on here but on my Mac OS X system
> > the file `gitweb/test/Marchen` is always untracked:
> 
> Will investigate,

And so I did. It seems the problem is not reading, but _writing_.

> touch $(echo -e 'M\xc3\xa4rchen')
> ls *en|hexdump -C
00000000  4d 61 cc 88 72 63 68 65  6e 0a                    |Ma..rchen.|
0000000a

So, instead of writing "4d c3 a4 72 63 68 65 6e" it actually writes "4d 61 
cc 88 72 63 68 65 6e". It might be possible that this is some 
"intelligent" encoding mapping, but ...

> echo $LC_ALL
de-DE.utf-8

... so I think Mac OS X is wrong.

Ciao,
Dscho
