From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH] rebase -i optimization
Date: Fri, 27 Feb 2009 11:50:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902271146460.6600@intel-tinevez-2-302>
References: <fabb9a1e0902260655g53fa1e1fg7e4aa76b0f3a80fc@mail.gmail.com>  <alpine.DEB.1.00.0902261557300.6258@intel-tinevez-2-302> <fabb9a1e0902260733k26e5c02i75a7866f9a67530b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Haberman <stephen@exigencecorp.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 11:52:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld0Kp-0000PY-6H
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 11:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760246AbZB0Kuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 05:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760268AbZB0Kuu
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 05:50:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:42305 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760249AbZB0Kus (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 05:50:48 -0500
Received: (qmail invoked by alias); 27 Feb 2009 10:50:45 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 27 Feb 2009 11:50:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hobpH6Hqh4RK/4FUOVWX03oFBTWI9wWNqvxlZP7
	7q93R2WNilvC6z
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <fabb9a1e0902260733k26e5c02i75a7866f9a67530b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111660>

Hi,

On Thu, 26 Feb 2009, Sverre Rabbelier wrote:

> On Thu, Feb 26, 2009 at 15:59, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > This code is supposed to do exactly what you want:
> 
> Hmmm, I can't say I understand it 100%, but what I can see from
> reading the code and looking at the output of 'rebase -i -v' is that
> it does a 'git reset --hard' on each commit if it was already applied,
> instead of figuring out beforehand what to reset to? If that is the
> case, it might still take a long time to do the rebase if it takes
> long to do the 'reset --hard' between the patches (say, if a big
> change is made).

Right.

I am of two minds here:

On one hand, I could imagine that it is just a question of skipping those 
'pick' commands that do not contribute anything.  That would be a pretty 
simple function that would be called at the very beginning.

On the other hand, this very simple strategy would fail pretty quickly 
(and badly) with -i -p.  And that is the stuff I am mostly spending my Git 
time budget on these days.

Having said that, I think yours might be such a common case that it is 
worth optimizing for.

Ciao,
Dscho
