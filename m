From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] Bisect: factorise "bisect_{bad,good,dunno}" into
 "bisect_state".
Date: Tue, 16 Oct 2007 12:20:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710161218260.25221@racer.site>
References: <20071014143003.23ae649f.chriscool@tuxfamily.org>
 <200710150542.17667.chriscool@tuxfamily.org> <Pine.LNX.4.64.0710151338000.25221@racer.site>
 <200710160828.05137.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 13:21:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhkTx-0007tJ-C8
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 13:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758578AbXJPLUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 07:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758943AbXJPLUz
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 07:20:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:46688 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758877AbXJPLUy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 07:20:54 -0400
Received: (qmail invoked by alias); 16 Oct 2007 11:20:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 16 Oct 2007 13:20:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/OA3wFOLPO+ytBg9DH2F5ksgd7roQK/rPeWAqut7
	r4XVzgI+BiUbV/
X-X-Sender: gene099@racer.site
In-Reply-To: <200710160828.05137.chriscool@tuxfamily.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61148>

Hi,

[finally, a technical argument on "dunno".  Maybe we really need 
git-bikeshed@vger.kernel.org? ;-)]

On Tue, 16 Oct 2007, Christian Couder wrote:

> Le lundi 15 octobre 2007, Johannes Schindelin a ?crit :
> >
> > On Mon, 15 Oct 2007, Christian Couder wrote:
> > >
> > > But the new "bisect_state" takes one more argument, because the first
> > > one must be "good" "bad" or "dunno".
> > >
> > > So when there is only one argument HEAD is used, and when there are 
> > > 2 arguments, $2 is used as the good|bad|dunno rev.
> >
> > Ah, that explains it!  But do you not need to do 
> > "2,bad|2,good|2,dunno" in that case?  Or even better: "2,*"?
> 
> Perhaps it would be an improvement at least in speed for "2,good" or 
> "2,dunno".

I see: the later case catches them.  Colour me satisfied with your patch.

> I wanted to keep exactly the same processing as there was before, in case 
> something like "git bisect good v1.5.3.3..v1.5.3.4" was supported. But it 
> seems it doesn't work. I don't know if it's a bug or a feature.

I think v1.5.3.3..v1.5.3.4 expands to ^v1.5.3.3 v1.5.3.4, which might 
explain what you are experiencing.

OTOH "git bisect good v1.5.3.3..v1.5.3.4" does not make sense.  bisect 
assumes that all ancestors of a good commit are good, too.

Ciao,
Dscho
