From: Shawn Pearce <spearce@spearce.org>
Subject: git-add + git-reset --hard = Arrrggh!
Date: Wed, 17 May 2006 05:45:26 -0400
Message-ID: <20060517094526.GA8563@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 17 11:45:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgIb2-0002qR-FZ
	for gcvg-git@gmane.org; Wed, 17 May 2006 11:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWEQJpb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 05:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWEQJpb
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 05:45:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48335 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932508AbWEQJpa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 05:45:30 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FgIas-0000ja-8B
	for git@vger.kernel.org; Wed, 17 May 2006 05:45:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D5255212667; Wed, 17 May 2006 05:45:26 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20177>

After spending an hour writing and testing a new test case for GIT
I do the foolish:

	$ git add t/t1400-update-ref.sh
	# Hmm, maybe I should amend this into the prior commit.
	$ git format-patch -o .. next
	$ git reset --hard
	$ git update-ref HEAD~1
	# Uhhohh...
	$ ls t/t1400-update-ref.sh

All I can say is I'm very happy that update-index does a lot more
than just update the index.  I was easily able to find the deleted
test by finding the most recently modified object in my .git/objects
directory and pulling it back out with git cat-file.  :-)

Oh, and I totally agree with that discussion about GIT not clobbering
files the user is working on which the user can't easily recover.
I just wish recovery from the above stupidity didn't require going
through .git/objects looking for the newest file.  :-)

Yes, I know that git reset --hard was brutal and yes, I didn't
really need to use git-update-ref when git-reset would have also
done the job for me.  Arrgh.  Its early and I wasn't thinking.

-- 
Shawn.
