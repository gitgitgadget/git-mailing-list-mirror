From: Jeff King <peff@peff.net>
Subject: Re: git merge remote branch says "Merge commit ..."?
Date: Fri, 22 May 2009 13:54:01 -0400
Message-ID: <20090522175401.GB11640@coredump.intra.peff.net>
References: <2729632a0905211250v4e7537caybe9e703c14361b5f@mail.gmail.com> <20090522074927.GB1409@coredump.intra.peff.net> <loom.20090522T172429-73@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 19:54:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Ywf-0006sR-VU
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 19:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757225AbZEVRyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 13:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757201AbZEVRyE
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 13:54:04 -0400
Received: from peff.net ([208.65.91.99]:58415 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756903AbZEVRyE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 13:54:04 -0400
Received: (qmail 20773 invoked by uid 107); 22 May 2009 17:54:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 22 May 2009 13:54:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 22 May 2009 13:54:01 -0400
Content-Disposition: inline
In-Reply-To: <loom.20090522T172429-73@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119745>

On Fri, May 22, 2009 at 05:29:41PM +0000, Eric Raible wrote:

> Jeff King <peff <at> peff.net> writes:
> 
> > I think doing a "git merge origin/master" is perfectly normal for some
> > workflows. For example:
> > 
> >   $ git fetch origin ;# grab it
> >   $ gitk origin/master...master ;# check if it is good to merge
> >   $ git merge origin/master ;# and merge it
> > 
> > The final step _could_ be a pull, but there is no point in repeating the
> > fetch (which might be costly).
> 
> My understanding is that if the objects already exist
> locally then this is not going to be costly at all.
> The negotiation of what is needed is cheap, isn't it?

No, it is not terribly expensive. But you do have to talk to the server,
which may mean making an ssh connection, or the server may be overloaded
and slow. So it can take a few seconds instead of a few microseconds.

There is actually another reason not to pull, though: you just inspected
what is in origin/master, so that is what you are expecting to merge.
If there is new stuff on the remote, you probably don't want to merge it
without similarly inspecting it.

-Peff
