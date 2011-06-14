From: Johan Herland <johan@herland.net>
Subject: Re: Commit notes workflow
Date: Tue, 14 Jun 2011 12:15:50 +0200
Message-ID: <201106141215.50689.johan@herland.net>
References: <20110613090940.664b1b97@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Tue Jun 14 12:16:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWQfM-0007OB-2x
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 12:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994Ab1FNKP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 06:15:58 -0400
Received: from smtp.getmail.no ([84.208.15.66]:64912 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753764Ab1FNKPy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 06:15:54 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LMR005K7Z6FBS20@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 14 Jun 2011 12:15:53 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 643581EA5840_DF734D9B	for <git@vger.kernel.org>; Tue,
 14 Jun 2011 10:15:53 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id F27C71EA3D48_DF734D6F	for <git@vger.kernel.org>; Tue,
 14 Jun 2011 10:15:50 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LMR007F8Z6E1030@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 14 Jun 2011 12:15:50 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.39-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <20110613090940.664b1b97@chalon.bertin.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175758>

On Monday 13 June 2011, Yann Dirson wrote:
> We have notes merge support since a couple of releases now, but no real
> example in the docs of how best to use that.  That is, no suggested
> mapping of remote notes, let alone automatic setup of refspecs at clone
> time.

True. I think this has been held up, partly because I (or anyone else) 
haven't found the time to work on this, and partly because we want to add 
some kind of default refspec to easily share notes between repos; the latter 
has been caught up in the discussion you refer to in [1].

> Trying to setup such refspecs, I find myself puzzled:
> 
> * if I store remote notes under refs/notes (eg.
> refs/notes/*:refs/notes/origin/* as fetch refspec), then a
> refs/notes/*:refs/notes/origin/* push refspec will include
> refs/notes/origin/*, which we obviously don't want
> 
> * if I store them outside of refs/notes (eg.
> refs/notes/*:refs/remote-notes/origin/* ), then "git notes" silently
> ignores them: no output nor any error message from "notes list" or
> "notes merge".
> 
> Do we really want to "git notes" to ignore everything not in refs/notes/
> ?  I can think of 2 possibilities out of this situation:
> 
> * remove that limitation
> * decide on a naming convention for remote notes, and teach "git notes"
> not to ignore it

The naming convention I have proposed (in the discussion for [1]) is 

  refs/notes/*:refs/remotes/$remote/notes/*

(but it obviously depends on reorganizing the entire remote refs hierarchy)

> A (minor) problem with the second possibility is that this naming
> convention could evolve, eg. if we end up with something like was
> proposed in [1] for 1.8.0.  Is there any real drawback with the first
> suggestion ?
> 
> [1] http://marc.info/?l=git&m=129661334011986&w=4

My gut feeling is to keep some sort of limit notes refs, and if/when we get 
around to implementing my proposal in [1] (or some variation thereof), we 
will of course extend the limit to put "refs/remotes/$remote/notes/*" (or 
whatever is decided) in the same category as "refs/notes/*".

In the meantime, I'm unsure if it's a good idea to remove the limitation 
altogether (allowing notes refs everywhere), since re-introducing a limit at 
a later point will then be MUCH harder...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
