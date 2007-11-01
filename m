From: Bill Lear <rael@zopyra.com>
Subject: Question on git-filter-branch
Date: Thu, 1 Nov 2007 06:55:37 -0600
Message-ID: <18217.52425.655322.52338@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 13:56:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InZaa-0001Qp-OZ
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 13:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbXKAMzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 08:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753373AbXKAMzo
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 08:55:44 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60451 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753249AbXKAMzn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 08:55:43 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id lA1Ctgk07661;
	Thu, 1 Nov 2007 06:55:42 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62949>

In my repo, I have sensitive files A, C, and a directory full of
sensitive stuff I want to remove forever from the git repository.

% ls
A B C D sensitive_stuff

% git --version
git version 1.5.3.5

% git filter-branch --index-filter 'git update-index --remove A' HEAD
Rewrite 5dd7d5f2d7d3a5f43c242188ac96294628267673 (7/7)
Ref 'refs/heads/master' was rewritten

These refs were rewritten:
% ls
B  C  D  sensitive_stuff

% git status
# On branch master
nothing to commit (working directory clean)

Ok, so I guess it has done what I wanted.  So, I try to remove the
next file that has sensitive information in it:

% git filter-branch --index-filter 'git update-index --remove C' HEAD
Namespace refs/original/ not empty

And there I am stuck: what do I do now?

I did also try this (on a fresh clone of the original repo):

% git filter-branch --index-filter 'git update-index --remove A C sensitive_stuff/*' HEAD
Rewrite 5dd7d5f2d7d3a5f43c242188ac96294628267673 (7/7)
Ref 'refs/heads/master' was rewritten

These refs were rewritten:
% ls
B  D  sensitive_stuff/
% ls sensitive_stuff
E  F  G

So, that appears to have removed A and C, but it did nothing to the
files in the subdirectory.  Is there a way to remove the files in the
subdirectory --- or, better, to simply remove the entire subdirectory?

I did try reading the man page for this, and the first example is
essentially what I want.  It says "you will get the rewritten history
saved in HEAD", but I'm not sure what I'm supposed to do next.


Bill
