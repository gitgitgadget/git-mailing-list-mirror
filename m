From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add hg-to-git conversion utility.
Date: Fri, 12 Jan 2007 17:15:25 -0500
Message-ID: <20070112221525.GA20956@spearce.org>
References: <1168537766.22649.19.camel@localhost.localdomain> <eo8ngk$ja$1@sea.gmane.org> <1168632860.29218.5.camel@voyager.dsnet> <1168639023.13640.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 23:15:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5UgO-0007a2-QA
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 23:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbXALWPa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 17:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbXALWPa
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 17:15:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53814 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161135AbXALWP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 17:15:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5UgA-00062i-Js; Fri, 12 Jan 2007 17:15:18 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A807820FBAE; Fri, 12 Jan 2007 17:15:25 -0500 (EST)
To: Stelian Pop <stelian@popies.net>
Content-Disposition: inline
In-Reply-To: <1168639023.13640.2.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36720>

Stelian Pop <stelian@popies.net> wrote:
> hg-to-git.py  is able to convert a Mercurial repository into a git one,
> and preserves the branches in the process (unlike tailor)

Cool!

You've already written the converter, but you may want to look at
using git-fast-import as the backend interface to Git.  I think
your code may come out shorter, be clearer, and will run faster.

For example Simon Schubert's cvs -> git converter was written in
one night (last night) in Ruby using git-fast-import as the backend
(Simon already had the heavy lifting CVS portions done).  I peeked
at his source and its quite readable, though maybe that's just the
Ruby talking.  ;-) Simon is apparently trying to import FreeBSD's
CVS repository to Git.  A non-trivial task.

Chris Lee also has an svn -> git converter that uses gfi as its
backend. Its only 150 or so lines of Python and is also quite
readable.  Chris is apparently trying to import KDE to Git.
An equally non-trivial task.

I think the common thread between the two implementations is
that there's less process forking and less manipulation of ugly
environment variables.  So the import runs faster and its a little
easier to organize the code.


The gitweb (and mirror URLs) for gfi is available here:

  http://repo.or.cz/w/git/fastimport.git

Post 1.5.0 I'm going to nudge Junio to get gfi added to the main
git.git repository.  (Right now I don't want to distract him from
the release.)

-- 
Shawn.
