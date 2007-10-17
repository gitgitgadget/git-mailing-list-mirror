From: Bill Lear <rael@zopyra.com>
Subject: Question on git-filter-branch
Date: Tue, 16 Oct 2007 19:57:23 -0500
Message-ID: <18197.24051.863751.436705@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 02:57:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhxED-0003iH-Li
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 02:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759457AbXJQA5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 20:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbXJQA5b
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 20:57:31 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61407 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761766AbXJQA5a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 20:57:30 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l9H0vTX07207;
	Tue, 16 Oct 2007 18:57:29 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61296>

I'm testing out git-filter-branch, as I would like to use it to remove
proprietary information from our repository.

I created a test repo with "sensitive information" in a file 'A', some
other "plain" information, more sensitive stuff in file 'D', a subdirectory
of sensitive information (some of this added on a branch 'branch_1',
some added on master):

% ls -F sensitive
A  B  C  D  sensitive_stuff/

I then cloned this repo and tried the filter:

% git clone sensitive sensitive.clone
% cd sensitive.clone
% git filter-branch --index-filter 'git update-index --remove A' HEAD
Rewrite 5dd7d5f2d7d3a5f43c242188ac96294628267673 (7/7)
Ref 'refs/heads/master' was rewritten

These refs were rewritten:
% ls
A  B  C  D  sensitive_stuff

Ok, so it doesn't list the refs, so I do git status:

% git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file:   A
#

So, it seems to have done something to A, but I don't know what to do
next.

The man page says: "Now, you will get the rewritten history saved in
the branch newbranch (your current branch is left untouched)."  Well,
I don't see any new branch created:

% git branch -a
* master
  origin/HEAD
  origin/branch_1
  origin/master

Then next part of the man page counsels that "To set a commit ...",
but I'm not sure if that is what I want to do (I think it is).
However, I'm not sure what the 'graft-id' refers to, or if I'm
supposed to type in the command as specified, especially since this is
followed by this caution: "if the parent string is empty - which
happens when we are dealing with the initial commit - add graftcommit
as a parent".  Here, I'm unsure what graftcommit is, most especially
since the use of 'graft' first appears as 'graft-id'...

Could someone help, please?


Bill
