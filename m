From: Don Zickus <dzickus@redhat.com>
Subject: using git-blame with patches as input
Date: Mon, 16 Jun 2008 17:35:17 -0400
Message-ID: <20080616213517.GE20727@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 23:36:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8MNF-0001c9-8l
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 23:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962AbYFPVfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 17:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755902AbYFPVfa
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 17:35:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54112 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755844AbYFPVf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 17:35:29 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5GLZLtp031073
	for <git@vger.kernel.org>; Mon, 16 Jun 2008 17:35:28 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5GLZKUJ003646
	for <git@vger.kernel.org>; Mon, 16 Jun 2008 17:35:20 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m5GLZIfG013136
	for <git@vger.kernel.org>; Mon, 16 Jun 2008 17:35:18 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m5GLZIfF000972
	for <git@vger.kernel.org>; Mon, 16 Jun 2008 17:35:18 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m5GLZIH8000971
	for git@vger.kernel.org; Mon, 16 Jun 2008 17:35:18 -0400
X-Authentication-Warning: drseuss.usersys.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85235>

I deal with a lot of backported patches that are a combination of multiple
commits.  I was looking to develop a tool that would help me determine
which chunks of the patch are upstream (not necessarily currently in HEAD
but at some point in the file's history).

For example, if I took the top three commits from HEAD and appended them
into one patch file and then ran this tool with the patch as input, I
would hope that it gave as output the three original commits.

git-blame seem to handle a lot of the pieces I would need but my little
brain can't follow all the logic behind some of the mechanisms.

Seeing that git-blame can take patch chunks and traverse through commit
history to see if a particular chunk can be blamed on a parent, I feel
like I am most of the way there.  Unfortunately, I don't quite understand
some of the algorithms git-blame does when it splits the patch chunks into
smaller pieces to determine which pieces are blame-able on the parents.

Is there anyone who can help explain some of the low level logic to me?

What I would like to do is take a patch as input, split it into chunks and
traverse through the commit history looking for a match (or something of
high similarity) and output that commit id for each patch chunk.

git-cherry does something close but patches have to be exact whereas my
situation has a combination of patches.  I also understand there are
plenty of normal scenerios where my approach falls flat on its face (but I
have ideas for those).  I just wanted to get a simple common case going
first.

Thanks in advance.

Cheers,
Don
