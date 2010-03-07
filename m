From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: core.autocrlf considered half-assed
Date: Sun, 7 Mar 2010 15:45:13 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1003071538350.30214@localhost.localdomain>
References: <alpine.DEB.1.00.1003060018170.20986@pacific.mpi-cbg.de> <20100307092701.GC31105@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 00:45:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoQA3-0005vX-Tx
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 00:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320Ab0CGXpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 18:45:22 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59157 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751289Ab0CGXpV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Mar 2010 18:45:21 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o27NjEgg011690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 7 Mar 2010 15:45:15 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o27NjD26016880;
	Sun, 7 Mar 2010 15:45:13 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20100307092701.GC31105@dpotapov.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141747>



On Sun, 7 Mar 2010, Dmitry Potapov wrote:
> 
> Well, I agree there are some issues with it. In particularly, when
> someone changes core.autocrlf in his/her repository, and then git
> behavior is outright confusing. IMHO, the nuts of the problem is that
> does not store in the index how files were checkout. Instead it uses
> core.autocrlf, which specifies how the user _wants_ files to be check-
> out. So, when the autocrlf option changes, things get very confusing.

I do agree. It would probably have been a good idea to mark the CRLF 
status in the index, but we didn't. And crlf isn't actually the _only_ 
thing that can cause confusion, the 'ident' and 'filter' can do the same 
thing.

One option might be to have "git config" know about crlf, so that if you 
change crlf state with 'git config' rather than manually, we could at 
least _warn_ about the effects and tell people that they may need to do a 
full new checkout (or reset the stat info in the index, or whatever). But 
I like editing config files by hand, and I don't think I'm the only one.

			Linus
