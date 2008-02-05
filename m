From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/9] Allow callers of unpack_trees() to handle failure
Date: Tue, 5 Feb 2008 15:38:26 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802051428180.13593@iabervon.org>
References: <alpine.LNX.1.00.0802041334450.13593@iabervon.org> <alpine.LSU.1.00.0802050107440.8543@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:39:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMUZT-0003vl-5b
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 21:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756329AbYBEUih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 15:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756280AbYBEUih
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 15:38:37 -0500
Received: from iabervon.org ([66.92.72.58]:48610 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbYBEUig (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 15:38:36 -0500
Received: (qmail 9416 invoked by uid 1000); 5 Feb 2008 20:38:26 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Feb 2008 20:38:26 -0000
In-Reply-To: <alpine.LSU.1.00.0802050107440.8543@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72690>

On Tue, 5 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 4 Feb 2008, Daniel Barkalow wrote:
> 
> > Return an error from unpack_trees() instead of calling die(), and exit
> > with an error in read-tree and builtin-commit.
> 
> Technically, there is still a possibility that an xcalloc() fails with a 
> die(), but I agree that it is a good change.

Right, this is just for the case of the data causing the operation 
requested to be unsafe or impossible.

> BTW after the whole series (was too lazy to check the individual 
> patches), I count one instance in builtin-checkout.c and two in diff-lib.c 
> where unpack_trees()' return value is not checked.  Is this intended?

I don't think any of them can fail (a diff really ought not abort due to 
the things you're comparing being incompatible, and the reset_clean_to_new 
similarly can't have any conflicts), but it's probably best to check and 
exit anyway, if only in the conversion commit. (If we remove the check 
afterward, there will be a change in the history that documents that we 
don't need to check)

	-Daniel
*This .sig left intentionally blank*
