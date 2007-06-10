From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Silence error messages unless 'thorough_verify' is set
Date: Sun, 10 Jun 2007 19:51:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706101943350.4059@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vwsyc8bt3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0706101103160.4059@racer.site>
 <200706101410.17771.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 20:54:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxSYl-0006h7-FI
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 20:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbXFJSyj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 14:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753765AbXFJSyj
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 14:54:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:56311 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753278AbXFJSyj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 14:54:39 -0400
Received: (qmail invoked by alias); 10 Jun 2007 18:54:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 10 Jun 2007 20:54:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/aehhqcMPaEuz1n1hciB1Lk/6J7gbYL6zDolONB1
	H7GRIi5aj+Y59b
X-X-Sender: gene099@racer.site
In-Reply-To: <200706101410.17771.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49755>

Hi,

On Sun, 10 Jun 2007, Johan Herland wrote:

> On Sunday 10 June 2007, Johannes Schindelin wrote:
>
> > As for the general direction of implementing notes as tags: If you 
> > want to make them fetchable, you have to deal with conflicts. If you 
> > want to be able to amend notes, _especially_ when they should be 
> > fetchable, you want a history on them.
> 
> I'm not sure what kind of notes you're talking about here. If you're 
> talking about my git-note concept, I designed notes to be immutable 
> (thus not amendable) and there is therefore _no_ merging or potential 
> for conflicts between notes.

Okay, that is one way you can go about implementing notes.

> The only resolution needed is to figure out which order the notes for a 
> given object should be presented. The default here is chronological 
> sorting.

There are several problems with that approach I'd like to point out:

- In distributed environments, you can not rely on timestamps. Ever.

- If a note is deleted, you will fetch it again as long as the other side 
  did not delete it.

- You cannot undo a typo (since the notes are immutable, you would see 
  both versions), once the typoed note was fetched.

Basically, everything I see as a problem here suggests that note writing 
is very much like working on a branch. That's why I suggest to treat it 
exactly like a branch to begin with.

Ciao,
Dscho
