From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Teach parse_commit_buffer about grafting.
Date: Thu, 18 Aug 2005 17:50:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508181737220.3412@g5.osdl.org>
References: <7vslxw4tb1.fsf_-_@assigned-by-dhcp.cox.net>
 <20050818003036.C53FD353BF9@atlas.denx.de> <7vd5ocouus.fsf@assigned-by-dhcp.cox.net>
 <17155.64070.264664.926461@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0508172209220.3412@g5.osdl.org>
 <17157.10227.296309.809074@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Wolfgang Denk <wd@denx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 02:51:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5v6I-0007on-ON
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 02:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVHSAvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 20:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbVHSAvM
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 20:51:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3779 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932544AbVHSAvL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2005 20:51:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7J0oujA026254
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 Aug 2005 17:50:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7J0oqZN019505;
	Thu, 18 Aug 2005 17:50:54 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17157.10227.296309.809074@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


On Fri, 19 Aug 2005, Paul Mackerras wrote:
> 
> > Umm. git-rev-list really does everything. Rule of thumb: if you _ever_
> > need to look at any other internal git information, you're probably doing
> > something wrong, or you've missed yet another flag ;)
> 
> I still look in [gitdir]/refs/tags/* and [gitdir]/refs/heads/*, what
> flag have I missed? :)  Junio wants me to look at everything under
> [gitdir]/refs, in fact.  Or are the refs not considered internal git
> information?

Ahh, ok, fair enough. git-rev-list won't give you that. 

And yes, the general rule is that anything under .git/refs/ is potentially 
a reference. If it's under "heads/" or "tags/" it's a branch/tag, and then 
the prefix "heads/" or "tags/" shouldn't be part of the name - you already 
show the difference with colors. Anything else is unusual, but bisection 
puts refs in the ".git/refs/bisect" directory for example, and if gitk 
were to show those, it should probably show them in yet another color, and 
_with_ the "bisect/" prefix..

		Linus
