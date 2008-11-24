From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Confusion with git rebase -i
Date: Tue, 25 Nov 2008 00:02:05 +0100
Message-ID: <492B326D.1050901@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 25 00:03:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4kSq-000897-Md
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 00:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbYKXXCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 18:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752801AbYKXXCK
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 18:02:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:59926 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752367AbYKXXCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 18:02:09 -0500
Received: (qmail invoked by alias); 24 Nov 2008 23:02:06 -0000
Received: from 68-13.78-83.cust.bluewin.ch (EHLO [192.168.123.204]) [83.78.13.68]
  by mail.gmx.net (mp048) with SMTP; 25 Nov 2008 00:02:06 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX19NF2J9pZdNu9AZzGktIKqlUjwTijBiWlgxVcEv+u
	SNs5/OLVbZ4m/z
User-Agent: Thunderbird 2.0.0.18 (X11/20081123)
X-Enigmail-Version: 0.95.7
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101631>

Hi list!

I often edit recent commits I haven't pushed out yet using "git
rebase -i HEAD~5".  And it's very helpful that whenever "git
rebase" stops, it tells me what to do next.  So normally it stops
and tells me that I can now ammend the commit and then run "git
rebase --continue", or if a conflict happens, it tells to fix
that, "git add", "git rebase --continue".  But I stumbled over a
situation where doing what it says doesn't do what I want.

Let's say my HEAD commit is fine, but I want to edit HEAD~1 and
HEAD~2, so I run "git rebase -i HEAD~3" and change 'pick' to
'edit' on the two lines I'm interested in.  It stops after the
first commit, letting me amend it and then I do "git rebase
--continue".  Unfortunately my fix to the first commit conflicts
with the second commit, and I get this:

    Auto-merged filename
    CONFLICT (content): Merge conflict in filename
    Automatic cherry-pick failed.  After resolving the conflicts,
    mark the corrected paths with 'git add <paths>', and
    run 'git rebase --continue'
    Could not apply abcdefa... Commit message

Reading this message, I understand this isn't yet my chance to
amend the second commit, this is merely a rebase conflict I need
to fix before I can proceed.  So I do what it says and fix only
the conflict and do "git add" and "git rebase --continue", but
then to my surprise I now won't get a chance to edit the second
commit.

What I have to do instead in that situation, is to resolve the
conflict *and also* add my fix to the second commit, and then
remember to do "git add" and "git commit" *without the --amend*.
And then finally "git rebase --continue".  But it doesn't tell me
any of that...

I don't know if the message above is wrong, or if there's a bug
that just prevents it to stop again after a conflict of a commit
that has been marked "edit".  Though stopping twice (once to
resolve conflict, once to amend the commit) at almost the same
place can be just as confusing, so fixing the conflict *and*
introduce my change to the commit at once is fine, but then it
should say so, or I'll be confused.

Or am I missing something?  Using git 1.6.0.4.

Thanks,
jlh
