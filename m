From: linux@horizon.com
Subject: Re: How to create & switch to a branch after changes have already been made?
Date: 2 Jul 2007 23:05:35 -0400
Message-ID: <20070703030535.2958.qmail@science.horizon.com>
Cc: git@vger.kernel.org
To: wpdster@gmail.com
X-From: git-owner@vger.kernel.org Tue Jul 03 05:05:51 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Yi4-0005xv-76
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 05:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbXGCDFh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 23:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752497AbXGCDFh
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 23:05:37 -0400
Received: from science.horizon.com ([192.35.100.1]:15235 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752353AbXGCDFg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 23:05:36 -0400
Received: (qmail 2959 invoked by uid 1000); 2 Jul 2007 23:05:35 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51443>

The magic you're looking for is "git checkout -b <branch>"

You can do that even with uncommitted changes hanging around.
Because you don't specify a commit to check out, it just "checks out
the HEAD again", which does nothing.  The only thing left is the
part that creates and switches to a new branch.

Now, if you've already created the branch, you can either do:
git checkout <newbranch>
which, since <newbranch> equals HEAD, just switches the HEAD symlink
without actually changing the checked-out commit.

Or, if you want to be really low-level,

git-update-ref HEAD <newbranch>

Which is the underlying tool that git checkout uses.
It bypasses all the safety checkes, but it might be easiest to understand.


Now, if you've already committed, you can just do:

git checkout -b <newbranch>
git branch -f <oldbranch> HEAD^


Admittedly, I sometimes with for a "git commit -b <branch>" shortcut.
