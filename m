From: Johan Herland <johan@herland.net>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
 state
Date: Fri, 16 Jan 2009 10:50:13 +0100
Message-ID: <200901161050.13971.johan@herland.net>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
 <8035E52E-D202-4C42-BDFD-DC7A925580A3@wincent.com>
 <76718490901151226l704d119bh297db4e91a4da05b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 10:52:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNlMt-0003Cc-VL
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 10:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbZAPJuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 04:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbZAPJui
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 04:50:38 -0500
Received: from smtp.getmail.no ([84.208.20.33]:64461 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836AbZAPJuh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 04:50:37 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KDK00K1160BTW00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 16 Jan 2009 10:50:35 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KDK0013I5ZRTB40@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 16 Jan 2009 10:50:15 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KDK0025R5ZQZIU9@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 16 Jan 2009 10:50:15 +0100 (CET)
In-reply-to: <76718490901151226l704d119bh297db4e91a4da05b@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105933>

On Thursday 15 January 2009, Jay Soffian wrote:
> On Thu, Jan 15, 2009 at 2:27 PM, Wincent Colaiuta <win@wincent.com> wrote:
> > wait - best suggestion so far, seeing as we can't use "stop"
> This is a fun game. I like the color "halt".

Nice. I like this one as well.

After some more thinking (triggered by Junio's recent post in another 
subthread), it occured to me that the current behaviour (currently known 
as "edit") is not something that is applied to one of the commits in the 
rebase list per se, but rather something that affects the rebase machinery 
*between* commits. So instead of

	edit e8902c1 Foo

we should consider something like

	pick e8902c1 Foo
	halt

which I think better encapsulates the current behaviour. (IOW, insert "halt" 
wherever you'd like to muck about with the history; e.g. 
doing "commit --amend", inserting extra commits, etc.)

We can then make shortcuts for common actions:

	amend e8902c1 Foo

does a "pick" followed by "commit --amend" (for editing the commit message), 
followed by "rebase --continue". Finally, we implement Anders' suggestion:

	modify e8902c1 Foo

(or whatever synonym for "edit" we converge on) does a "pick" followed by 
a "reset --soft HEAD^", followed by a "halt".


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
