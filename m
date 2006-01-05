From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: use GIT_DIR instead of /var/tmp
Date: Thu, 5 Jan 2006 08:42:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601050840010.3169@g5.osdl.org>
References: <81b0412b0601050352n386505bfjd40e515809e3c862@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 17:44:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuYCb-00037K-NT
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 17:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbWAEQmw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 11:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbWAEQmw
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 11:42:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43996 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750722AbWAEQmv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 11:42:51 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k05GgbDZ018802
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 5 Jan 2006 08:42:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k05GgXug004530;
	Thu, 5 Jan 2006 08:42:35 -0800
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0601050352n386505bfjd40e515809e3c862@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14203>



On Thu, 5 Jan 2006, Alex Riesen wrote:
>
> Not every system (will not one microsoft windows system) have /var/tmp,
> whereas using GIT_DIR for random temporary files is more or less established.

Note that in this case it might be appropriate, but in general you should 
be careful. You may want to access a git directory without actually having 
write permissions to it. 

Of course, for "git reset" that's not an issue (since it needs write 
permissions anyway), but just in general.. git programs mostly use pipes 
to communicate, and temporary files are pretty rare, so we hopefully don't 
have that issue much, but let's make sure that things that just look at a 
repository can work even with a read-only repo.

		Linus
