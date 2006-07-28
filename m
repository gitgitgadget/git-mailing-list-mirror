From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Teach the git wrapper about --name-rev and --name-rev-by-tags
Date: Fri, 28 Jul 2006 09:59:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607280952200.4168@g5.osdl.org>
References: <20060524131022.GA11449@linux-mips.org> <Pine.LNX.4.64.0605240931480.5623@g5.osdl.org>
 <Pine.LNX.4.64.0605240947580.5623@g5.osdl.org> <7v64jv8fdx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605241200110.5623@g5.osdl.org> <Pine.LNX.4.64.0605241641250.5623@g5.osdl.org>
 <20060525131241.GA8443@linux-mips.org> <7v4px4osjv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607281308280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 28 18:59:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6VgN-0006fX-Gq
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 18:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbWG1Q7W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 12:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161181AbWG1Q7W
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 12:59:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64995 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161098AbWG1Q7W (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 12:59:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6SGxCnW019533
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 28 Jul 2006 09:59:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6SGxBKb011204;
	Fri, 28 Jul 2006 09:59:11 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607281308280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-2.551 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24396>



On Fri, 28 Jul 2006, Johannes Schindelin wrote:
> 
> Now you can say
> 
> 	git --name-rev log

I think this is wrong.

It may be a straightforward translation of

> 	git log | git name-rev --stdin | less

but that doesn't make it any more "correct".

>From a logical standpoint, it should be an argument to the _logging_, not 
to the main git binary, so it should be

	git log --name-rev

and you should do the parsing (and the output) inside revision.c.

Also, I doubt most people want every release named. I think the common 
case would be that you want those releases named that match heads (and 
tags in particular) _exactly_. If you want everything named, maybe you 
want to do "--name-rev-all" or something.

Hmm?

(That would also likely perform a lot better)

		Linus
