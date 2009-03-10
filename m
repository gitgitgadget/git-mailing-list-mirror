From: Jeff King <peff@peff.net>
Subject: Re: setting up tracking on push
Date: Tue, 10 Mar 2009 19:09:39 -0400
Message-ID: <20090310230939.GB14083@sigio.peff.net>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com> <76718490903052049k217e9c12gb7881f8904fdd9d@mail.gmail.com> <alpine.DEB.1.00.0903061144480.10279@pacific.mpi-cbg.de> <buoy6vi297q.fsf@dhlpc061.dev.necel.com> <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com> <76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com> <87d4cuobrc.fsf@catnip.gol.com> <49B6CCDB.8010305@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 00:11:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhB6I-0001d4-0p
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 00:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693AbZCJXJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 19:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754308AbZCJXJg
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 19:09:36 -0400
Received: from peff.net ([208.65.91.99]:60278 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753365AbZCJXJg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 19:09:36 -0400
Received: (qmail 14703 invoked by uid 1000); 10 Mar 2009 23:09:39 -0000
Content-Disposition: inline
In-Reply-To: <49B6CCDB.8010305@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112856>

On Tue, Mar 10, 2009 at 04:26:03PM -0400, Marc Branchaud wrote:

> It would be good if the branch command allowed modification of a
> branch's properties.  At the very least, branch-creation commands like
> "git branch --track foobranch origin/master" could offer to modify if
> the branch already exists, instead of just quitting.

I agree that it would be nice if an interface could be made around
"branch --track". However, the problem with

  git branch --track foobranch origin/master

is that it does two things: it sets up tracking, and it resets the
foobranch ref. Right now we complain if foobranch already exists. We
have a "-f" to override. But what you want to say is "set foobranch to
track origin/master, but _don't_ actually reset where it points". And I
don't see an intuitive way of doing that with that syntax. If you don't
require "-f", then you are silently ignoring half of what the user asked
you to do.

> BTW, I think the following (untested) incantation adds tracking to a branch:
>
> 	git config branch.foobranch.remote origin
> 	git config branch.foobranch.merge refs/heads/master

Yes, that is right. The only reason it is not a two-line script to
convert "git branch --track" into that is that you have to actually
resolve origin/master into "remote origin, branch refs/heads/master".

-Peff
