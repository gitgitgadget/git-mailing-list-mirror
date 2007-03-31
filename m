From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: SEGV in git-merge recursive:
Date: Fri, 30 Mar 2007 18:03:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703301754590.6730@woody.linux-foundation.org>
References: <20070329075010.GA3493@hermes> <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com>
 <20070329125803.GA16739@hermes> <81b0412b0703290634j6e62ba89tce3c8c963be3fb92@mail.gmail.com>
 <20070329141230.GB16739@hermes> <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com>
 <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com>
 <20070329183237.GB2809@steel.home> <Pine.LNX.4.64.0703291232190.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703291237240.6730@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703302239050.4045@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703301728510.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Tom Prince <tom.prince@ualberta.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 31 03:03:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXS0T-0003lQ-0E
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 03:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933235AbXCaBDp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 21:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933239AbXCaBDp
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 21:03:45 -0400
Received: from smtp.osdl.org ([65.172.181.24]:57931 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933235AbXCaBDo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 21:03:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2V13bod016791
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 30 Mar 2007 18:03:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2V13aGV012445;
	Fri, 30 Mar 2007 18:03:37 -0700
In-Reply-To: <Pine.LNX.4.64.0703301728510.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.461 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43518>



On Fri, 30 Mar 2007, Linus Torvalds wrote:
> 
> We're looking for a base version for a merge - think of a three-way merge 
> on a file level. And the easiest base version is actually an empty base 
> file (or, when it comes to a rename conflict, no base names at all).

Note that "easiest" isn't "best".

For data conflicts in intermediate merges, we use the conficted file, 
conflict markers and all, as the base.

I suspect we should do exactly the same for filename conflicts. Write the 
intermediate tree with *both* files, including conflict markers. I'd 
suggest writing out the conflicting names to the intermediate tree 
*exactly* the same way we do for the final tree in the working tree, but 
mayne we could just write them with the SHA of the content appended to the 
filename or something..)

		Linus
