From: Jeff King <peff@peff.net>
Subject: Re: your mail
Date: Sat, 13 Oct 2007 00:07:12 -0400
Message-ID: <20071013040712.GA27227@coredump.intra.peff.net>
References: <30817A88-4313-4D38-95B0-FEC47C651CB0@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat Oct 13 06:07:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgYHh-0004JH-3o
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 06:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbXJMEHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 00:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbXJMEHQ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 00:07:16 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4418 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbXJMEHP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 00:07:15 -0400
Received: (qmail 21863 invoked by uid 111); 13 Oct 2007 04:07:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 13 Oct 2007 00:07:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Oct 2007 00:07:12 -0400
Content-Disposition: inline
In-Reply-To: <30817A88-4313-4D38-95B0-FEC47C651CB0@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60720>

On Sat, Oct 13, 2007 at 12:01:04AM -0400, Michael Witten wrote:

> Now that you mention it, I think the best approach would be to:
> 	
> 	(1) cvsexportcommit
> 	(2) git reset --hard LAST_CVS_IMPORT_AND_MERGE
> 	(3) git cvsimport ..... # and merge
>
> I think this is what you mean; it seems to me that rebasing isn't quite 
> that.

No, I mean rebasing instead of merge. As in, you have a history like
this:

    /--C---D  <-- your master
A--B
    \--C'--D' <-- cvsimport merge tip

where "C" and "D" are your commits in git, and C' and D' are pulled in
from cvsimport. You want to rebase your work like this:

A--B--C'--D'--C--D

except that git-rebase is smart enough to realize that C == C' and skip
it (so it's a "safe" way of moving forward).

> However, this will not preserve more complicated history such as merges
> from another git repository.

Correct. Rebasing doesn't really handle merges, but I assumed you were
just making simple commits on top of a cvs master.

> Basically, I want to treat my git repository as the official
> repository; the CVS repo is just their for the old farts to get the
> latest stuff ;-P

Then my suggestion doesn't really work. You might consider using git as
the official server and letting the old farts use git-cvsserver.

HTH,
-Peff
