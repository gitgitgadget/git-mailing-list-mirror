From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: Submodules and rewind
Date: Tue, 19 Feb 2008 18:25:47 -0800
Organization: Vyatta
Message-ID: <20080219182547.57ac6cc7@extreme>
References: <20080219140604.04afc91f@extreme>
	<20080219223201.GE4703MdfPADPa@greensroom.kotnet.org>
	<20080219152357.5ab397cf@extreme>
	<alpine.LSU.1.00.0802200033530.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<20080219161517.34fd5878@extreme>
	<alpine.LSU.1.00.0802200203440.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<20080219171301.53893f2c@extreme>
	<alpine.LSU.1.00.0802200217080.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: skimo@liacs.nl, skimo@kotnet.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 20 03:26:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRefF-0001dP-Ex
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 03:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153AbYBTCZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 21:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755027AbYBTCZz
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 21:25:55 -0500
Received: from mail.vyatta.com ([216.93.170.194]:48372 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226AbYBTCZx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 21:25:53 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.vyatta.com (Postfix) with ESMTP id 3B2F04F804E;
	Tue, 19 Feb 2008 18:25:53 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.33
X-Spam-Level: 
X-Spam-Status: No, score=-2.33 tagged_above=-10 required=5 tests=[AWL=0.169,
	BAYES_00=-2.599, RDNS_DYNAMIC=0.1]
Received: from mail.vyatta.com ([127.0.0.1])
	by localhost (mail.vyatta.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DdGRoSSrk4b5; Tue, 19 Feb 2008 18:25:49 -0800 (PST)
Received: from extreme (75-175-36-117.ptld.qwest.net [75.175.36.117])
	by mail.vyatta.com (Postfix) with ESMTP id 4FDAF4F804D;
	Tue, 19 Feb 2008 18:25:49 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802200217080.8333@wbgn129.biozentrum.uni-wuerzburg.de>
X-Mailer: Claws Mail 3.3.0 (GTK+ 2.12.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74499>

On Wed, 20 Feb 2008 02:22:14 +0100 (CET)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Tue, 19 Feb 2008, Stephen Hemminger wrote:
> 
> > On Wed, 20 Feb 2008 02:06:36 +0100 (CET)
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > > On Tue, 19 Feb 2008, Stephen Hemminger wrote:
> > > 
> > > > $ git-submodule init
> > > > Submodule 'pkgs/linux-image-2.6.23-1-486-vyatta' (http://git.vyatta.com/linux-vyatta.git) registered for path 'pkgs/linux-image-2.6.23-1-486-vyatta'
> > > 
> > > AFAICT this is your problem.  Your urls are http:// url, and do not 
> > > end in a slash.
> > > 
> > > Yes, there was a fix recently, but apparently it was not enough.  
> > > With the slash, it should even work on older git.
> > 
> > That is a different issue.  It worked before my messing around with the 
> > vyatta-iproute.git repository.
> 
> From your description:
> 
> -- snip --
> In old repository
> $ git-submodule update
> ...
> Getting pack list for
> http://git.vyatta.com/home/shemminger/vyatta-iproute/.git/
> error: The requested URL returned error: 403
> error: Unable to find 8d971aff46015fc156d5b74254d21831d275963c under
> http://git.vyatta.com/vyatta-iproute.git
> Cannot obtain needed object 8d971aff46015fc156d5b74254d21831d275963c
> Unable to checkout '79b4dbe51b84fdf37fdc9cb8b17819526508a60c' in submodule
> path 'pkgs/vyatta-iproute'
> -- snap --
> 
> So there was some type of invalid HTTP request, and then the hin tat 8d971 
> was not found under http://.../vyatta-iproute.git (note the absence of the 
> trailing slash).  Of course, since it is 403 ("forbidden"), and not 30x 
> (which I thought I read), it could be a different error altogether.
> 
> In any case, this means that your submodule is not at all fine.
> 
> Ciao,
> Dscho
> 

The problem was that the rebuilt repository had an alternate file pointing to a
different and inaccessible location.  Rebuilding again fixed the problem.

Thanks for your help.
