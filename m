From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce light weight commit annotations
Date: Mon, 11 Jun 2007 11:25:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706111122470.4059@racer.site>
References: <Pine.LNX.4.64.0706091854330.4059@racer.site>
 <7v4plf7948.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0706102333050.4059@racer.site>
 <7v4plf5qxp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 12:29:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxh9D-00013i-Rz
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 12:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757100AbXFKK3O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 06:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758622AbXFKK3O
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 06:29:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:52122 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757100AbXFKK3N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 06:29:13 -0400
Received: (qmail invoked by alias); 11 Jun 2007 10:29:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 11 Jun 2007 12:29:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+wzORzN7awKGgrZlmcO3JQ7yv9TnNcFfV9hrNorN
	tZT9ulNK1l9Dj0
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4plf5qxp.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49843>

Hi,

On Sun, 10 Jun 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I do not understand... the entries of a tree object are sorted 
> > alphabetically, right? Including the convention that if one is a 
> > prefix of another, it is "smaller".
> >
> > While I think that the length would not be any problem, the entries' 
> > names of refs/annotations/commit^{tree} are _all_ of length two, and 
> > point to other tree objects. _Those_ tree objects contain _only_ 
> > entries whose names contain exactly 38 characters.
> 
> That is ONLY true if you are introducing a specialized tree
> object parser that knows it is dealing with the tree used in
> your annotation scheme that has entries of uniform size.  In
> such a tree parser, you could bisect or Newton-Raphson a tree
> object data to find an entry more efficiently than for normal
> trees with enries of variable size.

Ouch. That is a real flaw in my proposal. It completely destroys my "I 
think this will scale just fine" argument.

> If that happens, "refs/annotations/commit:?{40}" format would let you 
> look up an annotation for a given commit much more efficiently than 
> "refs/annotations/commit:??/?{38}", because it would have to open only 
> one tree object, instead of two.

Let me think that one through. At the moment I cannot think of an easy 
fix.

Ciao,
Dscho
