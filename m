From: Andreas Ericsson <ae@op5.se>
Subject: Re: Project With Reusable Libraries
Date: Wed, 25 Mar 2009 09:13:39 +0100
Message-ID: <49C9E7B3.2090206@op5.se>
References: <450196A1AAAE4B42A00A8B27A59278E70A5597A8@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 09:15:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmOGx-0005C9-Oe
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 09:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486AbZCYINo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 04:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754246AbZCYINm
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 04:13:42 -0400
Received: from spsmtp02oc.mail2world.com ([74.202.142.148]:1984 "EHLO
	spsmtp02oc.mail2world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbZCYINk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 04:13:40 -0400
Received: from mail pickup service by spsmtp02oc.mail2world.com with Microsoft SMTPSVC;
	 Wed, 25 Mar 2009 01:12:00 -0700
auth-sender: exon@home.se
Received: from 212.112.174.166 unverified ([212.112.174.166]) by spsmtp02oc.mail2world.com with Mail2World SMTP Server; 
	Wed, 25 Mar 2009 01:11:59 -0700
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A5597A8@EXCHANGE.trad.tradestation.com>
X-OriginalArrivalTime: 25 Mar 2009 08:12:00.0626 (UTC) FILETIME=[5F9A8D20:01C9AD21]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114575>

John Dlugosz wrote:
> Consider a directory tree something like this:
> 
> 	...
> 	foo\
> 	  bar\
> 	   project-root\
> 	     app1\
> 	         contents of app1
> 	     app2\
> 	         contents of app2
> 	     lib1\
> 	         contents of library 1
> 	     lib2\
> 	         contents of library 2
> 
> 
> Each project, whether application or library, has its own git repository
> already.  A program, say app1, is now dependant on the libraries.  The
> libraries are meant to be used in multiple applications.
> 
> This is not like what is described under subprojects, since the libs are
> not "under" the application, but are peers in the directory structure.
> It would be wrong to put lib1 and lib2 as subdirectories of app1 because
> they are also used by app2, right?
> 
> Then again... if app1 and app2 are not always built as part of the same
> set, they might have different versions of the libs specified.  I
> understand that the newer versions of msysgit do hard linking so having
> multiple repositories for the same thing won't waste disk space, but
> still requires fetching to keep them in sync?
> 
> Anyway, how would you do it?
> 

If app1 and app2 requires different versions of the same library, I'd
make them separate git projects entirely.

If they have to stay in the same project, I'd put their respective
libraries as a submodule under each app. You could get away without
having to fetch them if you stash the lib projects in the super
project and then link the app project's lib-submodules to the one
in the super-project, but it gets messy when you try to explain
that without some simple means of drawing things, so if you can't
write a "sync-submodules" script, I guess it's not really worth
the problem. Especially if the lib-repositories aren't huge.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
