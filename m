From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Properties of trees referencing commit objects (mode 160000)?
Date: Sun, 20 Mar 2016 15:43:01 -0700
Message-ID: <20160320224301.GA20803@x>
References: <20160319221348.GA5247@x>
 <20160320041803.GC18312@sigill.intra.peff.net>
 <20160320184524.GA16064@x>
 <xmqqk2kwok8s.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 23:43:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahm43-0003lD-3I
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 23:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbcCTWnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 18:43:10 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60535 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbcCTWnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 18:43:09 -0400
Received: from mfilter37-d.gandi.net (mfilter37-d.gandi.net [217.70.178.168])
	by relay2-d.mail.gandi.net (Postfix) with ESMTP id EF40CC5A53;
	Sun, 20 Mar 2016 23:43:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter37-d.gandi.net
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
	by mfilter37-d.gandi.net (mfilter37-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id OORRoPAX6Nb8; Sun, 20 Mar 2016 23:43:05 +0100 (CET)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 14916C5A56;
	Sun, 20 Mar 2016 23:43:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqk2kwok8s.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289389>

On Sun, Mar 20, 2016 at 03:30:27PM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > On Sun, Mar 20, 2016 at 12:18:04AM -0400, Jeff King wrote:
> >> On Sat, Mar 19, 2016 at 03:13:48PM -0700, Josh Triplett wrote:
> >> 
> >> > I'm building some tools to track commit objects, and I'm thinking of
> >> > using submodule-style references to commit objects in tree objects (mode
> >> > 160000) to do so.  I'm trying to figure out some of the properties of
> >> > that.
> >> > 
> >> > Can a commit object referenced that way live in the same repository,
> >> > rather than some external repository?
> >> 
> >> Yes, it can be in the same repository, but...
> >
> > Will git clone/checkout/etc handle it properly in that case, in the
> > absence of a .gitmodules file?  Or would it only work with custom tools?
> 
> That depends on the definition of "proper".  The default "proper"
> way for the core Git for submodules/gitlinks is to create an empty
> directory.  If you want to populate a working tree for that, you'd
> need "git submodule" support, but because you are writing "some
> tools" on your own, there probably is a reason why you do not want
> to use "git submodule", so I am guessing that your definition of
> "proper" does not match either core Git or "git submodule" considers
> "proper"?  In which case you would need to implement your own
> semantics (you may not even want to have an empty directory there,
> for example).

I can live with "creates an empty directory and doesn't choke or
complain".  I'd kinda hoped that git might notice it already has the
commit, and do something like checking out the files of that commit into
the working directory, but it isn't critical.

- Josh Triplett
