From: davetron5000 <davetron5000@gmail.com>
Subject: How does git store branchpoints?
Date: Mon, 9 Jun 2008 07:17:13 -0700 (PDT)
Message-ID: <beffea8c-fd2a-44d0-a566-3ded5d09a3d2@l42g2000hsc.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 16:18:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5iCO-0002mE-D5
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 16:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbYFIORP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 10:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbYFIORP
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 10:17:15 -0400
Received: from yx-out-2122.google.com ([74.125.44.24]:20175 "EHLO
	yx-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbYFIORO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 10:17:14 -0400
Received: by yx-out-2122.google.com with SMTP id 35so466935yxh.1
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 07:17:13 -0700 (PDT)
Received: by 10.150.12.10 with SMTP id 10mr39062ybl.13.1213021033735; Mon, 09 
	Jun 2008 07:17:13 -0700 (PDT)
X-IP: 98.218.223.189
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; 
	rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84385>

Following up this:

http://groups.google.com/group/git-version-control/browse_thread/thread/aa34d04120d0c361#

I'm trying to learn/examine the .git directory to see what Git thinks.

What I'm trying to determine is how Git knows the parent of a
particular commit, how I can change it, and how that affects merging.

My problem is that I have two branches, and a merge between the two
produces conflicts in files that are unchanged on one branch.  Since
my branches are linked to SVN branches, I'm thinking that Git is not
properly clear on their shared history.

Any ideas where to look?

.git/info/refs has some strange data in it:

5a3e01a8327c6139e9311b01548baf4a8876b5e3    refs/heads/local-FOO
71560b15ad6a2a7542556dfdf2d6c763625d5db4    refs/heads/local-trunk
efb2ff2ac363600a2aaae60718bc76b6c3db4228    refs/remotes/FOO

The SHA-1 for refs/heads/local-FOO (branch created via git checkout -b
local-FOO FOO) doesn't show in gitk --all, but a git log of that shows
it to be a somewhat old commit (not the head, nor the branch point).

The SHA-1 for local-trunk is a similarly old commit

The SHA-1 for refs/remotes/FOO is the commit right before the SHA-1
for refs/heads/local-FOO in my git log.
