From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: Another bench on gitweb (also on gitweb caching)
Date: Tue, 12 Feb 2008 16:57:30 -0800
Message-ID: <1202864250.17207.22.camel@localhost.localdomain>
References: <20080210030919.GA32733@c3sl.ufpr.br>
	 <m363wvdmxr.fsf@localhost.localdomain>
	 <20080213004528.GB31455@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Wed Feb 13 02:53:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP6oE-0004pU-F9
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 02:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008AbYBMBwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 20:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752497AbYBMBwm
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 20:52:42 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:34880 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbYBMBwk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 20:52:40 -0500
X-Greylist: delayed 3287 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Feb 2008 20:52:40 EST
Received: from [10.255.255.198] (65-115-68-195.dia.static.qwest.net [65.115.68.195])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.13.8) with ESMTP id m1D0vUcD024662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2008 16:57:30 -0800
In-Reply-To: <20080213004528.GB31455@c3sl.ufpr.br>
X-Mailer: Evolution 2.12.3 (2.12.3-1.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/5794/Tue Feb 12 12:49:27 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73735>

 
> > > I found out those VERY interesting, so instead of trying to think a
> > > new way to store gitweb config, we should think a way to cache those
> > > information.
> > 
> > Below there are my thoughts about caching information for gitweb:
> > 
> > First, the basis of each otimisation is checking the bottlenecks.
> > I think it was posted sometime there that the pages taking most load
> > are projects list and feeds. 
> > 
> > Kernel.org even run modified version of gitweb, with some caching
> > support; Cgit (git web interface in C) also has caching support.
> 
> Is this gitweb version for kernel.org available somewhere?
> > 
> > 

It's available from my git tree on kernel.org
http://git.kernel.org/?p=git/warthog9/gitweb.git;a=summary

or

git://git.kernel.org/pub/scm/git/warthog9/gitweb.git

Mind you my performance on the non-cache state is not going to be any
better than normal gitweb, however the performance on a cache-hit is
orders of magnitude faster - though at a rather expensive cost - disk
space.  There is currently something like 20G of disk being used on one
of kernel.org's machines providing the cache (this does get flushed on
occasion - I think) but that is providing caching for everything that
kernel.org has in it's git trees (or 255188 unique urls currently).  My
code base is now, horribly, out of date with respect to mainline but it
works and it's been solid and reasonably reliable (though I do know of
two bugs in it right now I need to track down - one with respect to a
failure of the script - and one that is an array out of bounds error)

- John
