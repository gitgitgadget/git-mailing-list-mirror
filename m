From: Jeff King <peff@peff.net>
Subject: Re: An alternate model for preparing partial commits
Date: Tue, 8 Jul 2008 00:58:56 -0400
Message-ID: <20080708045855.GA2037@sigill.intra.peff.net>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com> <alpine.DEB.1.00.0806271408290.9925@racer> <7vprq2rbfz.fsf@gitster.siamese.dyndns.org> <20080628050317.GE9451@sigill.intra.peff.net> <alpine.DEB.1.00.0806281549060.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 08 07:00:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG5J5-0001xB-BA
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 07:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbYGHE7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 00:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbYGHE7H
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 00:59:07 -0400
Received: from peff.net ([208.65.91.99]:3043 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbYGHE7G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 00:59:06 -0400
Received: (qmail 28357 invoked by uid 111); 8 Jul 2008 04:59:05 -0000
Received: from c-75-75-1-159.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (75.75.1.159)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 08 Jul 2008 00:59:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Jul 2008 00:58:56 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806281549060.9925@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87713>

On Sat, Jun 28, 2008 at 03:51:12PM +0100, Johannes Schindelin wrote:

> > Here's a somewhat hackish implementation of "git stash -i" that just 
> > relies on "add -i":
> 
> I like it.

Thinking about this some more, it seems to me to lack one really
important feature that "git add -i" has: you must stash all in one go.

That is, I may do some of the adds as "git add <file1> <file2>" and then
pick out the rest of the changes with "git add -p". And traditionally,
stashing has been about dumping all changes, so everything happened at
once.

But I think what I would really like here is to say "now I don't want to
stage for a commit; I want to stage into some bucket, so that I can
clear my workspace for making the commit". And then proceed to use "add"
or "add -i" in the usual way, except that they go into my bucket. And at
the end, I switch back to staging for a commit, make the commit, and
then start picking things out of my bucket.

And that workflow is not too hard to imagine by just pointing
GIT_INDEX_FILE to the bucket.

But I am still thinking on this, so I'll let it percolate and then maybe
try to implement something once I have a better sense of exactly what
workflow I want. I just thought I would throw it out there for others to
ponder.

-Peff
