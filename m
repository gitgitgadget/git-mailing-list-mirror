From: Jeff King <peff@peff.net>
Subject: Re: Reverting an uncommitted revert
Date: Tue, 19 May 2009 23:38:48 -0400
Message-ID: <20090520033848.GA10581@coredump.intra.peff.net>
References: <4A136C40.6020808@workspacewhiz.com> <alpine.LFD.2.00.0905192300070.3906@xanadu.home> <20090520032139.GB10212@coredump.intra.peff.net> <alpine.LFD.2.00.0905192328310.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 20 05:39:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6cdy-0000QY-O1
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 05:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738AbZETDit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 23:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753717AbZETDis
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 23:38:48 -0400
Received: from peff.net ([208.65.91.99]:45002 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318AbZETDis (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 23:38:48 -0400
Received: (qmail 6568 invoked by uid 107); 20 May 2009 03:38:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 19 May 2009 23:38:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 May 2009 23:38:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0905192328310.3906@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119582>

On Tue, May 19, 2009 at 11:35:45PM -0400, Nicolas Pitre wrote:

> Having a "trash" reflog would solve this unambiguously.  That could also 
> include your index example above.


Yeah, I think combining the two in a single log makes sense.

> However, in the index case, I'd record a reflog entry only if you're
> about to discard a previously non committed entry.  If you do:
> 
> 	$ git add foo
> 	$ git add bar
> 	$ git commit
> 	$ hack hack hack
> 	$ git add foo
> 
> then in this case there is nothing to be lost hence no additional entry 
> in the "trash" reflog.

Good point. That both helps the performance and keeps the log less
cluttered.

-Peff
