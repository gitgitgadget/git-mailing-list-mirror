From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/5] diff --quiet
Date: Wed, 14 Mar 2007 17:33:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703141728350.9690@woody.linux-foundation.org>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net> <7vodmv7bza.fsf@assigned-by-dhcp.cox.net>
 <81b0412b0703141614m70f4a565qc001e06e60b0ffd5@mail.gmail.com>
 <7v8xdz5qn0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 01:33:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRduS-0006Hc-B9
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 01:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422785AbXCOAdc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 20:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422782AbXCOAdc
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 20:33:32 -0400
Received: from smtp.osdl.org ([65.172.181.24]:35119 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422785AbXCOAdb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 20:33:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2F0XQOb021199
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Mar 2007 17:33:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2F0XPO7006126;
	Wed, 14 Mar 2007 16:33:25 -0800
In-Reply-To: <7v8xdz5qn0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.989 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42266>



On Wed, 14 Mar 2007, Junio C Hamano wrote:

> "Alex Riesen" <raa.lkml@gmail.com> writes:
> 
> > Now I'm happy :)
> >
> > ~/linux$ time git diff-tree -r -s v2.6.16 v2.6.20
> >
> > real    0m0.137s
> > user    0m0.117s
> > sys     0m0.020s
> > ~/linux$ time ~/projects/git-diff/git-diff-tree -r --quiet v2.6.16 v2.6.20
> >
> > real    0m0.006s
> > user    0m0.000s
> > sys     0m0.007s
> 
> You do not need diff-tree --quiet to do that!
> 
> 	$ git-rev-parse v2.6.16^{tree} v2.6.20^{tree}

Well, if you have a path-spec, it can certainly matter.

Personally, I think it's more interesting if this can make a difference 
for something like

	git log v2.6.12.. -- drivers/ > /dev/null

but that would require that we actually understand that we can stop early 
if we ever get to REV_TREE_DIFFERENT. I didn't check if you actually did 
that optimization.

		Linus
