From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: kernel cherry UN-picking?
Date: Mon, 14 May 2007 22:39:41 -0400
Message-ID: <20070515023941.GA20340@filer.fsl.cs.sunysb.edu>
References: <4644E0A2.90008@garzik.org> <20070511145509.09f3c354.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 15 04:40:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnmxe-0007QD-As
	for gcvg-git@gmane.org; Tue, 15 May 2007 04:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbXEOCkU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 22:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754943AbXEOCkU
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 22:40:20 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:50037 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526AbXEOCkU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 22:40:20 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l4F2dfuj021103;
	Mon, 14 May 2007 22:39:41 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l4F2dfEH021101;
	Mon, 14 May 2007 22:39:41 -0400
Content-Disposition: inline
In-Reply-To: <20070511145509.09f3c354.akpm@linux-foundation.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47308>

On Fri, May 11, 2007 at 02:55:09PM -0700, Andrew Morton wrote:
> On Fri, 11 May 2007 17:31:14 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
> > So, I merge the next batch of net driver patches.  After I merge a PPP 
> > patch, deep in the pile-o-patches, Andrew says "I shouldn't have sent 
> > that to you, don't apply it"  ;-)
> 
> I'm bad.
> 
> > Right now, my process for reversing this damage is to start over: 
> > create a new branch, manually double-click the mouse on each commit in 
> > the "damaged" branch, and git-cherrypick it.  Very, very time consuming 
> > when you have more than a couple commits.
> > 
> > Is there a better way?
> > Is there any way to say "cherrypick all commits except <these>"?
> 
> Let me refactor your question more usefully.  What we want is quilt-export
> and quilt-import.  And I really mean that: commands called git-quilt-export
> and git-quilt-import.
> 
> coz then, your problem becomes
> 
> 	git-quilt-export
> 	<delete one line from the series file>
> 	git-quilt-import

<shameless plug>

You can use Guilt:

$ guilt-init
$ guilt-import-commit <the bad commit hash>^..
$ $EDITOR .git/patches/$branch/series
	# remove the offending line from the series file
$ guilt-push -a
$ rm -rf .git/patches/$branch

</shameless plug>


Josef "Jeff" Sipek.

-- 
All science is either physics or stamp collecting.
		- Ernest Rutherford
