From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-feed-mail-list.sh
Date: Mon, 8 May 2006 18:27:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605081822140.3718@g5.osdl.org>
References: <1146678513.20773.45.camel@pmac.infradead.org> 
 <7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>  <1147131877.2694.37.camel@shinybook.infradead.org>
  <Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>  <1147134522.2694.45.camel@shinybook.infradead.org>
  <Pine.LNX.4.64.0605081742330.3718@g5.osdl.org> <1147136467.2694.53.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 03:28:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdH1B-000496-L1
	for gcvg-git@gmane.org; Tue, 09 May 2006 03:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWEIB15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 21:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWEIB15
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 21:27:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9347 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751337AbWEIB15 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 21:27:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k491RotH009979
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 May 2006 18:27:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k491Ro5e027727;
	Mon, 8 May 2006 18:27:50 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1147136467.2694.53.camel@shinybook.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19806>



On Tue, 9 May 2006, David Woodhouse wrote:
> 
> Ah, right. Those are _commit_ IDs in that strange first line. I'll
> reformat those to 'Commit:' and 'Parent:' for the mailing list.

Right. That first line (that starts with "commit") lists the commit ID, 
and if you say "--parents", the commit ID's of the parents will be 
appended.

So if you want to turn that into "Commit: <id>" and "Parent: <id>", you'll 
want to do something like this:

  git show --no-abbrev -C --patch-with-stat --pretty=fuller --parents $commit |
	sed '1 s/commit \([0-9a-f]*\)/Commit:     \1\nParent:    /'

which should look pretty (count the spaces to make sure it lines up 
right with the other fields).

(And if you ever want to report on merges, you'll want to change that a 
bit, but it should be reasonably close to the above)

		Linus
