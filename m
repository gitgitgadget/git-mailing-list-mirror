From: Jeff King <peff@peff.net>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Fri, 17 Feb 2012 17:29:12 -0500
Message-ID: <20120217222912.GC31830@sigill.intra.peff.net>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
 <CAA01Csp6_9fP2rg4104UWUXwOxZmUVdQNDAaBe6fRou6agBz6g@mail.gmail.com>
 <8762f9k5sg.fsf@thomas.inf.ethz.ch>
 <CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
 <20120215190318.GA5992@sigill.intra.peff.net>
 <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
 <20120216192001.GB4348@sigill.intra.peff.net>
 <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net>
 <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 23:29:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyWIp-00012y-EF
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 23:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887Ab2BQW3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 17:29:14 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41259
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752977Ab2BQW3O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 17:29:14 -0500
Received: (qmail 12836 invoked by uid 107); 17 Feb 2012 22:29:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 17 Feb 2012 17:29:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2012 17:29:12 -0500
Content-Disposition: inline
In-Reply-To: <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190982>

On Fri, Feb 17, 2012 at 02:25:25PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > That being said, we do have an index extension to store the tree sha1 of
> > whole directories (i.e., we populate it when we write a whole tree or
> > subtree into the index from the object db, and it becomes invalidated
> > when a file becomes modified). This optimization is used by things like
> > "git commit" to avoid having to recreate the same sub-trees over and
> > over when creating tree objects from the index. But we could also use it
> > here to avoid having to even read the sub-tree objects from the object
> > db.
> 
> Like b65982b (Optimize "diff-index --cached" using cache-tree, 2009-05-20)
> perhaps?

That's what I get for speaking before running "git log".

So yeah, we may be about as reasonably fast as we can go. Or maybe that
optimization isn't kicking in for some reason. I think going further
would require Piotr to do more profiling.

-Peff
