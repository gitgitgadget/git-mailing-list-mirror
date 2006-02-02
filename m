From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitview 0.3
Date: Wed, 01 Feb 2006 22:13:34 -0800
Message-ID: <7vzmlauw35.fsf@assigned-by-dhcp.cox.net>
References: <cc723f590602012033w41b49b2ao4423707702086739@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 07:13:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Xj0-0005Yb-QN
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 07:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423011AbWBBGNh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 01:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423003AbWBBGNh
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 01:13:37 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:55290 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1423011AbWBBGNg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2006 01:13:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060202061231.YCS15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Feb 2006 01:12:31 -0500
To: Aneesh Kumar <aneesh.kumar@gmail.com>
In-Reply-To: <cc723f590602012033w41b49b2ao4423707702086739@mail.gmail.com>
	(Aneesh Kumar's message of "Thu, 2 Feb 2006 10:03:14 +0530")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15485>

Nice work for 0.low-number version.

On my notebook, I felt really miserable to see that the middle
band taking so much space to show rev committer timestamp and
parents.  The bottom window starts with the same information
repeated (worse, with unreadable timestamp format) and I had to
scroll all the way down to view the rest of the commit message.

If you absolutely want the middle band, maybe instead of showing
object names in "Parents" "Children" part, you can show the
one-line commit logs from them there, and pop-up the object
names along with the rest of commit log message as mouse hovers
over.

I missed "this commit is branch head of X" and "this commit is
tagged with T" markers gitk has.

Needs a bit more compact layout to be useful for me.  In short,
gitk's display does everything I want it to show in a compact
enough way and I think there is no reason not to imitate it.

Do colors of nodes have any significance?  I couldn't tell from
the UI (and I tried to figure it out without reading code --
otherwise I cannot tell if the choice of colors is intuitive).

It might match more people's expectation if --with-diff were the
default.

This patch might make merges easier to read.

-- >8 --
[PATCH] Use "diff-tree -c" to display merges a bit more readably.

--- a/gitview	2006-02-01 21:16:43.000000000 -0800
+++ b/gitview	2006-02-01 21:46:24.000000000 -0800
@@ -305,7 +305,7 @@
 		return message
 
 	def diff_tree(self):
-		fp = os.popen("git diff-tree --pretty -m -v -p " + " " + self.commit_sha1)
+		fp = os.popen("git diff-tree --pretty -c -v -p " + " " + self.commit_sha1)
 		diff = fp.read()
 		fp.close()
 
