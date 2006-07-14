From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Kernel headers git tree
Date: Fri, 14 Jul 2006 18:58:09 +0100
Message-ID: <1152899889.3191.71.camel@pmac.infradead.org>
References: <1152835150.31372.23.camel@shinybook.infradead.org>
	 <7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0607131800520.5623@g5.osdl.org>
	 <1152840456.31372.75.camel@shinybook.infradead.org>
	 <Pine.LNX.4.64.0607132157370.5623@g5.osdl.org>
	 <1152872626.3191.56.camel@pmac.infradead.org>
	 <Pine.LNX.4.64.0607140843570.5623@g5.osdl.org>
	 <Pine.LNX.4.64.0607141256170.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 19:59:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1RwI-00018r-Aq
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 19:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669AbWGNR6d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 13:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422694AbWGNR6d
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 13:58:33 -0400
Received: from canuck.infradead.org ([205.233.218.70]:25734 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1422669AbWGNR6c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 13:58:32 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1G1Rvl-0003BZ-Cx; Fri, 14 Jul 2006 13:58:26 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0607141256170.9789@iabervon.org>
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23901>

On Fri, 2006-07-14 at 13:51 -0400, Daniel Barkalow wrote:
> I think that a program to generate a slave git tree based in some 
> user-modifiable way on a parent repository would be useful and 
> implementable. I'd thought a bunch about it a while ago, for extracting 
> separable parts of projects (e.g., make a kbuild project that's pulled out 
> of the kernel tree, but is still a regular git project to anyone who 
> doesn't know this). My conclusion was that you need a cache of mappings, 
> because otherwise you can't identify that you already have a transformed 
> version of a commit, because you don't know its transformed parents, 
> unless you've gone all the way back to the root (which doesn't have 
> parents).

Absolutely. You don't want to go all the way back to the root every time
-- it's an incremental process, and you have to cache the mappings from
objects in the 'master' tree to objects in the 'slave' tree.

My existing scripts already do that part -- I didn't think it was worth
commenting on.

http://david.woodhou.se/extract-jffs2-git.sh
http://david.woodhou.se/extract-khdrs-git.sh
http://david.woodhou.se/extract-khdrs-stage2.sh

And no, I don't do any further simplification of the graph of commits
other than what 'git-rev-list' does for me. I need to fully go over
Linus' last mail and understand it, but I think the conclusion is that
the above scripts are fine, and I can happily drop --topo-order from
them.

-- 
dwmw2
