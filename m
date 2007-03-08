From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-bundle: Make thin packs
Date: Thu, 8 Mar 2007 14:07:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703081406570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45ECEB40.4000907@gmail.com> <7vejo2stlw.fsf@assigned-by-dhcp.cox.net>
 <45EE1242.8080405@gmail.com> <7vhcsxkb8n.fsf@assigned-by-dhcp.cox.net>
 <45EE2ECA.60403@gmail.com> <Pine.LNX.4.63.0703070419410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45EE36A1.30001@gmail.com> <Pine.LNX.4.63.0703070504140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <30e4a070703070834s3dd5bdd7x2e1639aa2979d1cf@mail.gmail.com>
 <Pine.LNX.4.63.0703072330200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703071516330.5963@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703080121210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4powebmr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 14:07:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPIL5-0004Mw-DU
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 14:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbXCHNHS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 08:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbXCHNHS
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 08:07:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:41327 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751784AbXCHNHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 08:07:16 -0500
Received: (qmail invoked by alias); 08 Mar 2007 13:07:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 08 Mar 2007 14:07:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qJ6prfspqA3CRFveOr/+DkTI9JavM4LIijrfunq
	cx0yGl1/CwdYgB
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v4powebmr.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41742>

Hi,

On Wed, 7 Mar 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This commit also changes behaviour slightly: since we now know early 
> > enough if a specified ref is _not_ contained in the pack, we can avoid 
> > putting that ref into the pack. So, we don't die() here, but warn() 
> > instead, and skip that ref.
> 
> I am a bit worried about that part.  
> 
> If somebody says "bundle create foo.bdl --since=1.day maint" and
> maint's tip hasn't changed for a month, we would end up having
> no refs and no pack in the bundle with just a warning.
> 
> "bundle create foo.bdl -20 master next" does _not_ mean "20 revs
> but at least have master and next tip", but it may surprise an
> uninitiated to find out that running "bundle list foo.bdl" on
> the resulting bundle did not talk about master at all.
> 
> I have a feeling that it would avoid confusion if we did not
> even start the pack generation and die early when we find the
> counting caused us not to include all the positive refs
> specified on the command line.

Fair enough.

Ciao,
Dscho
