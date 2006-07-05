From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Additional merge-base tests
Date: Wed, 5 Jul 2006 09:56:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607050952140.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44A9E6AE.10508@gmail.com> <7v3bdhoraa.fsf@assigned-by-dhcp.cox.net>
 <44AA0DAE.1060308@gmail.com> <7vpsgllsnp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xn9gjh5.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607050021330.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <44AAF49F.6090008@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jul 05 09:56:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fy2F7-0004Ql-Qp
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 09:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWGEH4K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 03:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWGEH4K
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 03:56:10 -0400
Received: from mail.gmx.net ([213.165.64.21]:17337 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932356AbWGEH4J (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jul 2006 03:56:09 -0400
Received: (qmail invoked by alias); 05 Jul 2006 07:56:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 05 Jul 2006 09:56:07 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <44AAF49F.6090008@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23340>

Hi,

On Tue, 4 Jul 2006, A Large Angry SCM wrote:

> Johannes Schindelin wrote:
> > Hi,
> > 
> > On Tue, 4 Jul 2006, Junio C Hamano wrote:
> > 
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > 
> > > > We could introduce a time.maximumSkew variable, and just walk only that
> > > > much further when traversing the commits.
> > > We could have had "commit generation number" in the commit
> > > object header, and use that instead of commit timestamps for
> > > these traversal purposes.  The generation number for a commit is
> > > defined to be max(generation number of its parents)+1 and we
> > > prime the recursive this definition by defining the generation
> > > number for the root commit to be one.
> > 
> > Are you really, really sure this is a remedy? I, for one, am quite sure of
> > the opposite. What you propose is just another time scale, only this time,
> > it is not universally true (not even minus local incompetence to keep the
> > clock accurate).
> 
> It works[*] and it does what using the timestamp was trying to do. Namely,
> work from "more recent" (or "closer") commits toward "older" (or "farther")
> commits until you've gone past the point you care about.
> 
> It's a little late to be changing the structure of a commit and you'd have to
> deal with some size/scale issues, but it's do-able. A better idea may be to
> generate and keep the generation number on a per repository basis, and you'd
> be able to work around changing grafts.

Like, inside the cache? I dunno. IMHO it is way too late to change the 
structure of a commit in that particular manner, _plus_ you would get 
overflow issues.

> [*] Grafts do _really_ nasty things to this. Just like clock skew does now.

Grafts can do much nastier things to you, for example having a circular 
history. _But_ they cannot do that nasty thing outside of your repo. Clock 
skews can.

Ciao,
Dscho
