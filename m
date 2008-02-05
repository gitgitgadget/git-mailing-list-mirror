From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/9] Discard "deleted" cache entries after using them to
 update the working tree
Date: Tue, 5 Feb 2008 01:25:52 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802050123330.8543@racer.site>
References: <alpine.LNX.1.00.0802041335470.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 02:27:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMCaX-00031f-Cg
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 02:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725AbYBEB0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 20:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755044AbYBEB0d
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 20:26:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:57723 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754810AbYBEB0c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 20:26:32 -0500
Received: (qmail invoked by alias); 05 Feb 2008 01:26:30 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp022) with SMTP; 05 Feb 2008 02:26:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Qc+I5XfhQ7zfabQVKAb50mRdfcptUL7duU59qgz
	J4Kq1CMTvhb58A
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802041335470.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72608>

Hi,

On Mon, 4 Feb 2008, Daniel Barkalow wrote:

> Way back in read-tree.c, we used a mode 0 cache entry to indicate that 
> an entry had been deleted, so that the update code would remove the 
> working tree file, and we would just skip it when writing out the index 
> file afterward.
> 
> These days, unpack_trees is a library function, and it is still leaving 
> these entries in the active cache. Furthermore, unpack_trees doesn't 
> correctly ignore those entries, and who knows what other code wouldn't 
> expect them to be there, but just isn't yet called after a call to 
> unpack_trees. To avoid having other code trip over these entries, have 
> check_updates() remove them after it removes the working tree files.
> 
> While we're at it, make the loop more obvious and skip passing in 
> globals to a static function with only one caller.

After reading the code I understand what you mean.  How about

	While at it, make the loop removing those entries more obvious, 
	and avoid passing global variables as parameters to 
	check_updates(): there is only one call site anyway.

Ciao,
Dscho
