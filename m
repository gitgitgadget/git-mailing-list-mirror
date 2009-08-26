From: Ximin Luo <xl269@cam.ac.uk>
Subject: Re: [git-svn] [BUG] merge-tracking inconsistencies; Was: [FEATURE-REQ]
 track merges from git
Date: Wed, 26 Aug 2009 22:13:55 +0100
Message-ID: <4A95A593.4070002@cam.ac.uk>
References: <4A9565ED.4010608@cam.ac.uk> <3e8340490908261206xc4156c4mb46e4c7de264df11@mail.gmail.com> <4A95A032.3000801@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 23:12:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgPnQ-00027X-43
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 23:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703AbZHZVMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 17:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753629AbZHZVMf
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 17:12:35 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:34697 "EHLO
	ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbZHZVMe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 17:12:34 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from 94-192-233-202.zone6.bethere.co.uk ([94.192.233.202]:65373 helo=[192.168.1.64])
	by ppsw-7.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:587)
	with esmtpsa (PLAIN:xl269) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1MgPnH-0006nZ-PJ (Exim 4.70)
	(return-path <xl269@cam.ac.uk>); Wed, 26 Aug 2009 22:12:35 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <4A95A032.3000801@cam.ac.uk>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127118>

Ximin Luo wrote:
> The only difference between the two runs is that in the unfucked version, we
> run "git svn dcommit" after every git commit.

Hmm, now that I think about it, the "bug" would be quite hard to "fix"...

Basically, it happens if you try to dcommit a commit A which has two parents, B
and X, where X is in a different branch, and hasn't already been dcommited. It
would seem that there isn't (in general) a way to detect whether X would become
(ie. in the future) a dcommitted svn commit - and actually this might not even
be the case, if eg. someone "svn commited" before we could get that dcommit in.

However about having git-svn outputting a warning when it detects merge
commits, one of whose parents is *not* a dcommitted commit, but does belongs to
a branch that is also being tracked by git-svn?

Something like "Warning: commit aaaa has parent bbbb; however, parent bbbb has
not been dcommited to the remote svn yet. If you proceed with this dcommit, the
merge history will be lost; to preserve the history, dcommit the branch
containing bbbb instead and then continue to dcommit this branch"?

X
