From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: Alternates and push
Date: Sat, 6 Sep 2008 12:20:30 -0400
Message-ID: <20080906162030.GT9129@mit.edu>
References: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 18:21:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc0Xe-0003ZP-4f
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 18:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbYIFQUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 12:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752377AbYIFQUf
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 12:20:35 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:51026 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752367AbYIFQUf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2008 12:20:35 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m86GKWuD015508;
	Sat, 6 Sep 2008 12:20:32 -0400 (EDT)
Received: from closure.thunk.org (c-67-184-102-120.hsd1.il.comcast.net [67.184.102.120])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m86GKUfb015847
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 6 Sep 2008 12:20:32 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1Kc0WU-0007Vj-Kc; Sat, 06 Sep 2008 12:20:30 -0400
Content-Disposition: inline
In-Reply-To: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95079>

On Sat, Sep 06, 2008 at 08:42:50AM -0400, Jon Smirl wrote:
> At github my repo, digispeaker, has an alternate pointing to github's
> local copy of Linus' tree. I ignored my tree for a month and then
> pushed to it including 200MB of objects from Linus' tree. These 200MB
> of objects were pushed up to the server, but these objects were
> already in the alternates repository.
> 
> What's supposed to happen? Is something broken in github's setup, or
> does pushing not take into account alternates?

Long-standing mis-feature in git's logic in deciding what to push.
It's been reported a few times, but apparently it's hard to fix, or at
least it never hsa been fixed as far as I know.

I work around it by ssh'ing into master.kernel.org and doing a "git
branch -f origin <commit-id-of-master-on-linus's-tree>".  As long as
there is one branch which is up-to-date, git will avoid pushing a huge
number of objects to master.kernel.org.  Of course, this workaround
only works if you have shell access....

						- Ted
