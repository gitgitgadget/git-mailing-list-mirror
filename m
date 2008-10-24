From: Jeff King <peff@peff.net>
Subject: Re: git performance
Date: Fri, 24 Oct 2008 14:20:31 -0400
Message-ID: <20081024182031.GA11287@coredump.intra.peff.net>
References: <000901c93490$e0c40ed0$a24c2c70$@com> <20081023163912.GA11489@coredump.intra.peff.net> <000001c9358f$232bac70$69830550$@com> <20081024142947.GB11568@coredump.intra.peff.net> <alpine.LFD.2.00.0810241050310.3287@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Edward Ned Harvey <git@nedharvey.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Oct 24 20:21:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtRID-0001BP-6i
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 20:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbYJXSUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 14:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbYJXSUf
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 14:20:35 -0400
Received: from peff.net ([208.65.91.99]:4152 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135AbYJXSUf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 14:20:35 -0400
Received: (qmail 23499 invoked by uid 111); 24 Oct 2008 18:20:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 24 Oct 2008 14:20:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Oct 2008 14:20:31 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810241050310.3287@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99048>

On Fri, Oct 24, 2008 at 10:53:20AM -0700, Linus Torvalds wrote:

> >   echo 1 >/proc/sys/vm/drop_caches
> 
> Use "echo 3" instead of "1".
> 
> It's actually a bitmask, with bit 0 being "data" (pagecache) and bit 1 
> being "metadata" (inodes and directory caches).
> 
> And since git (or any SCM) is very metadata-intensive, you really should 
> make sure to drop metadata too, otherwise your caches won't be really very 
> cold at all.
> 
> (But it obviously depends on the operation you're testing - some are more 
> about the inodes and directories, others are about file data access).

Ah, thanks. In this case, he was interested in walking the directory
tree, so the metadata caching was indeed very important.

-Peff
