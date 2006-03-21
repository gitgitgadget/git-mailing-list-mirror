From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bad merging with stgit or git
Date: Tue, 21 Mar 2006 12:37:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603211219230.3622@g5.osdl.org>
References: <1142969653.4749.109.camel@praia> <20060321200847.GS18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 21 21:38:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLncB-00074b-LD
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 21:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbWCUUiA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 15:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWCUUiA
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 15:38:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2955 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751772AbWCUUh7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Mar 2006 15:37:59 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2LKbpDZ022754
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 21 Mar 2006 12:37:51 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2LKboSg030887;
	Tue, 21 Mar 2006 12:37:50 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060321200847.GS18185@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17787>



On Tue, 21 Mar 2006, Petr Baudis wrote:
> 
> With the old Git version (probably v1.1.4, but I'm not so sure when
> looking at 1.1.4's git-commit.sh), git-commit would happily do the
> commit, but wouldn't record the commit as a merge.

I considered that, but as far as I can tell, Mauro is actually using a 
fairly recent version of "git". How do I know? The second merge (the 
_real_ one) says

	commit 86d720ef82ca09e75fac06be15da7cbe2721863a
	Merge: e338b73... 8fce4d8...
	Author: Mauro Carvalho Chehab <mchehab@infradead.org>
	Date:   Fri Mar 10 01:32:32 2006 -0300

	    Merge branch 'origin'
    
	    Conflicts:
	    
	        drivers/media/video/saa7134/saa7134-dvb.c
	    nothing to commit

and that "Conflicts:" thing from git is actually reasonably recent (it's 
from end of January), and almost certainly doesn't exist in v1.1.4 (I 
don't think it exists in any 1.1.x version).

So it's 1.2.0 or newer (or some random build, of course).

And I _hope_ that no git that recent will commit a merge in progress. 

However, it does look like the 

	case "$all,$also" in
	,t)

case doesn't check for MERGE_HEAD. That could be the bug. Junio?

		Linus
