From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [RFC/PATCH] gitweb: Paginate project list
Date: Sat, 10 May 2008 22:53:30 -0700
Message-ID: <1210485210.11526.145.camel@localhost.localdomain>
References: <200805011220.58871.jnareb@gmail.com>
	 <200805101128.59313.jnareb@gmail.com>
	 <1210444108.11526.139.camel@localhost.localdomain>
	 <200805110032.39729.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 07:55:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv4WR-00027n-MA
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 07:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbYEKFxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 01:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbYEKFxs
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 01:53:48 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:58066 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbYEKFxr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 01:53:47 -0400
Received: from [172.19.0.93] ([76.21.83.184])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id m4B5rfsu021141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 10 May 2008 22:53:42 -0700
In-Reply-To: <200805110032.39729.jnareb@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-3.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/7083/Sat May 10 08:55:11 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.1.12 (shards.monkeyblade.net [198.137.202.13]); Sat, 10 May 2008 22:53:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81740>


On Sun, 2008-05-11 at 00:32 +0200, Jakub Narebski wrote:
> On Sun, 10 May 2008, J.H. <warthog19@eaglescrag.net> wrote:
> 
> > $page_size should be moved to a configuration directive, with a possible
> > default of 100, and there should be an option to turn it off completely
> > (I.E. kernel.org will likely have it turned off).
> 
> If it would be configurable (and I agree that it is probably a good
> idea), it should be per gitweb instance (i.e. global variable), and
> should perhaps be named $project_list_page_size to distinguish it from
> number of items shown (page size) for 'shortlog', 'log' and 'history'
> views.
> 
> I guess that value of 0, or perhaps of undef would mean to not divide
> projects list, or project search results, into pages.
> 
> BTW. why do you think that kernel.org would be better to have project
> list pagination turned off?

If we have caching on I'd rather leave it as a single page, much easier
to search on and with firefox /<project or name> then <ctrl>+g a couple
of times is really fast to find what I need.  Also means less to cache
(good for us) and faster access for most.  I'm going to guess leaving it
as a single page, unless it gets *very* unwieldy, will be how we leave
it.

>  
> > It might also be advantageous to generate the entire list and stash that
> > somewhere, (session on the host side?) and run the pagination out of
> > that.
> 
> First, when using $projectslist file with new (second patch in series,
> "gitweb: Allow project description in project_index file" most of data
> (well, all except age) would be filled by parsing single file.
> 
> Second, the idea is to cache results of filled in @$projlist e.g. using
> Storable, i.e. cache Perl data and not final HTML output.

I approve of that plan, caching all the html is kinda expensive *hides
the 20G of gitweb cache he has*

> 
> > Would even allow the user to choose how many items they wish to 
> > see from a drop down maybe?
> 
> I think it is also a good idea, at least for search results.
> 
> 
> NOTE that this was an RFC patch, meant mainly to provide comments on
> what to improve...

I know, that's why I'm chiming in with my thoughts, I like the idea and
bonus points go to the user configurable display on that.  There are
definitely sites that can benefit from this and likely at some point
k.org is going to need have to paginate - just not sure when that point
is going to get hit.

- John 'Warthog9' Hawley
