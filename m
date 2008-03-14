From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [PATCH] gitweb: Support caching projects list
Date: Thu, 13 Mar 2008 17:36:39 -0700
Message-ID: <1205454999.2758.14.camel@localhost.localdomain>
References: <20080313231413.27966.3383.stgit@rover>
	 <76718490803131707g34fd40d4q21c69391c2597bc@mail.gmail.com>
	 <20080314002205.GL10335@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Mar 14 01:37:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZxvI-0003Ni-U5
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 01:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbYCNAgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 20:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbYCNAgq
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 20:36:46 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:60692 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbYCNAgp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 20:36:45 -0400
Received: from [10.255.255.198] (65-115-68-195.dia.static.qwest.net [65.115.68.195])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.13.8) with ESMTP id m2E0aZNs002043
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Mar 2008 17:36:35 -0700
In-Reply-To: <20080314002205.GL10335@machine.or.cz>
X-Mailer: Evolution 2.12.3 (2.12.3-1.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/6225/Thu Mar 13 07:52:37 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77160>


> You are of course right - I wanted to do the rename, but forgot to write
> it in the actual code. :-)
> 
> There is a more conceptual problem though - in case of such big sites,
> it really makes more sense to explicitly regenerate the cache
> periodically instead of making random clients to have to wait it out.
> We could add a 'force_update' parameter to accept from localhost only
> that will always regenerate the cache, but that feels rather kludgy -
> can anyone think of a more elegant solution? (I don't think taking the
> @projects generating code out of gitweb and then having to worry during
> gitweb upgrades is any better.)

You could do something similar to the gitweb caching I'm doing,
basically if a file isn't generated you make a user wait (no good way
around this really).  If a cache exists show it to the user unless the
cache is older than $foo.  If a re-generation needs to happen it happens
in the background so the user who triggers the regeneration sees
something immediately vs. having to wait (at the cost of showing out of
date data)

> > Out of curiosity, repo.or.cz isn't running this as a CGI is it? If so, wouldn't
> > running it as a FastCGI or modperl be a vast improvement?
> 
> Unlikely. Currently the machine is mostly IO-bound and only small
> portion of CPU usage comes from gitweb itself.

Thats about the same as what I saw, it's disk bound vs. cpu/memory
bound.

- John 'Warthog9' Hawley
