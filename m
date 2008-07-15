From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [PATCH 3/3] gitweb: use new Git::Repo API, and add optional
	caching
Date: Mon, 14 Jul 2008 18:44:44 -0700
Message-ID: <1216086284.18836.5.camel@localhost.localdomain>
References: <4876B223.4070707@gmail.com>
	 <200807150114.44402.jnareb@gmail.com> <487BE7C4.2050207@gmail.com>
	 <200807150252.52604.jnareb@gmail.com> <487BFA67.3020304@gmail.com>
	 <alpine.LSU.1.00.0807150326050.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Lea Wiemann <lewiemann@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 15 03:46:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIZcA-0006dU-8j
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 03:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740AbYGOBo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 21:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754702AbYGOBo7
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 21:44:59 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:54936 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494AbYGOBo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 21:44:58 -0400
Received: from [10.255.255.200] (65-115-68-195.dia.static.qwest.net [65.115.68.195])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id m6F1iovR024572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Jul 2008 18:44:50 -0700
In-Reply-To: <alpine.LSU.1.00.0807150326050.3486@wbgn129.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.12.3 (2.12.3-4.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/7713/Mon Jul 14 14:59:25 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.1.12 (shards.monkeyblade.net [198.137.202.13]); Mon, 14 Jul 2008 18:44:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88495>

On Tue, 2008-07-15 at 03:28 +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 15 Jul 2008, Lea Wiemann wrote:
> 
> > Jakub Narebski wrote:
> > > On Tue, 15 July 2008, Lea Wiemann wrote:
> > >> # Transient cache entries (like get_sha1('HEAD')) are automatically
> > >> # invalidated when an mtime [...] changes.
> > > 
> > > Nice idea... for project pages.  I'm not so sure about projects_list 
> > > page, if wouldn't be better to have expire time for *this* page.  You 
> > > would have/have to stat a lot of files/directories to detect changes.
> > 
> > It doesn't seem to be too much of a performance issue (it takes ~500ms
> > to generate the project list on kernel.org), and project lists aren't
> > requested often enough to be a good optimization target.
> 
> Wasn't the main page (i.e. the projects list) the reason why kernel.org 
> has its own little caching mechanism in the first place?
> 

Partially - it was by *far* the biggest problem we were facing, and it
likely has gotten a lot better since I went on a rampage and did
gitweb-caching.

That said there's a relatively small sample-set of files that gets hit
more than others it seems (from stuff I was looking at a while ago) and
limiting the general disk i/o on the kernel.org machines is *always* a
good thing (the less we go to disk the better) so while it started that
way it has been very beneficial, if it does chew up something like
15-20G of disk on those machines.)

- John 'Warthog9' Hawley

> And did Pasky not report recently that repo.or.cz got substantially less 
> loaded with some caching of its own?
> 
> warthog?  Pasky?
> 
> Ciao,
> Dscho
