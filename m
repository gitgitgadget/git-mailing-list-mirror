From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: cvsexportcommit dies when applying an (empty) merge commit
Date: Thu, 26 Nov 2009 07:51:05 +0100
Message-ID: <200911260751.06377.robin.rosenberg.lists@dewire.com>
References: <4B0D1C1A.60707@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nick Woolley <nickwoolley@yahoo.co.uk>
X-From: git-owner@vger.kernel.org Thu Nov 26 08:09:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDYTx-0004QK-3r
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 08:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758872AbZKZHJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 02:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758813AbZKZHJY
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 02:09:24 -0500
Received: from mail.dewire.com ([83.140.172.130]:26413 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438AbZKZHJX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 02:09:23 -0500
X-Greylist: delayed 1101 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Nov 2009 02:09:23 EST
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E3F9F800395;
	Thu, 26 Nov 2009 07:51:07 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r2RBgi703L8g; Thu, 26 Nov 2009 07:51:07 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 2DF30800386;
	Thu, 26 Nov 2009 07:51:07 +0100 (CET)
User-Agent: KMail/1.11.4 (Linux/2.6.28-11-generic; KDE/4.2.4; i686; ; )
In-Reply-To: <4B0D1C1A.60707@yahoo.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133772>

onsdag 25 november 2009 12:59:22 skrev  Nick Woolley:
> Hi,
>
> I have a git repository with a merge point on the master branch.  This
> merge commit is empty, and just contains a commit message:
>
>   Merge commit 'otherbranch'
>
> I'm trying to export this branch into CVS using git-cvsexportcommit (the
> latest version from the master branch). It's actually done in a wrapper
> script [1] but the command that gets invoked is essentially:
>
>  git cvsexportcommit -p -v -u -w  'cvscheckout/HEAD/my-cvs-module' -c \
>     <parent commit> <commit>
>
> Where <commit> is the empty merge commit.  However this invocation dies and
> aborts the process of exporting the branch half way.
>
> The fatal error I get is:
>
>  Applying to CVS commit <commit> from parent <parent commit>
>  Checking if patch will apply
>  Applying
>  error: No changes
>  cannot patch at /usr/lib/git-core/git-cvsexportcommit line 324.
>
[....]
> Is the existing behaviour deliberately fatal, or is this worth supplying a
> patch for?

I'm not the only contributor, but I'd say its a omission. cvsexportcommit 
doesn't export commits. It export deltas, that is the change relative to one
of the parents. It is reasonable that cvsexportcommit can "export" an
empty commit by doing nothing and exiting with 0. Printing some kind of 
warning seems reasonable too.

- robin
