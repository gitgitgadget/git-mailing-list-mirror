From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Submodules and rewind
Date: Wed, 20 Feb 2008 02:22:14 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0802200217080.8333@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20080219140604.04afc91f@extreme> <20080219223201.GE4703MdfPADPa@greensroom.kotnet.org> <20080219152357.5ab397cf@extreme> <alpine.LSU.1.00.0802200033530.8333@wbgn129.biozentrum.uni-wuerzburg.de> <20080219161517.34fd5878@extreme>
 <alpine.LSU.1.00.0802200203440.8333@wbgn129.biozentrum.uni-wuerzburg.de> <20080219171301.53893f2c@extreme>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: skimo@liacs.nl, skimo@kotnet.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Stephen Hemminger <shemminger@vyatta.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 02:22:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRdfh-0003xj-9p
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 02:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756340AbYBTBWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 20:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754303AbYBTBWS
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 20:22:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:35490 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752382AbYBTBWR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 20:22:17 -0500
Received: (qmail invoked by alias); 20 Feb 2008 01:22:15 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp008) with SMTP; 20 Feb 2008 02:22:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19TpsxPklhTcidqJYw5/csJ+Rwdwu3bh4uGXY6o6r
	T0ovGCttp/6IKm
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20080219171301.53893f2c@extreme>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74497>

Hi,

On Tue, 19 Feb 2008, Stephen Hemminger wrote:

> On Wed, 20 Feb 2008 02:06:36 +0100 (CET)
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > On Tue, 19 Feb 2008, Stephen Hemminger wrote:
> > 
> > > $ git-submodule init
> > > Submodule 'pkgs/linux-image-2.6.23-1-486-vyatta' (http://git.vyatta.com/linux-vyatta.git) registered for path 'pkgs/linux-image-2.6.23-1-486-vyatta'
> > 
> > AFAICT this is your problem.  Your urls are http:// url, and do not 
> > end in a slash.
> > 
> > Yes, there was a fix recently, but apparently it was not enough.  
> > With the slash, it should even work on older git.
> 
> That is a different issue.  It worked before my messing around with the 
> vyatta-iproute.git repository.

>From your description:

-- snip --
In old repository
$ git-submodule update
...
Getting pack list for
http://git.vyatta.com/home/shemminger/vyatta-iproute/.git/
error: The requested URL returned error: 403
error: Unable to find 8d971aff46015fc156d5b74254d21831d275963c under
http://git.vyatta.com/vyatta-iproute.git
Cannot obtain needed object 8d971aff46015fc156d5b74254d21831d275963c
Unable to checkout '79b4dbe51b84fdf37fdc9cb8b17819526508a60c' in submodule
path 'pkgs/vyatta-iproute'
-- snap --

So there was some type of invalid HTTP request, and then the hin tat 8d971 
was not found under http://.../vyatta-iproute.git (note the absence of the 
trailing slash).  Of course, since it is 403 ("forbidden"), and not 30x 
(which I thought I read), it could be a different error altogether.

In any case, this means that your submodule is not at all fine.

Ciao,
Dscho
