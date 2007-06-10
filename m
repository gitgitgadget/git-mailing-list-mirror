From: Jonas Fonseca <fonseca@diku.dk>
Subject: Adding empty directory gives bogus error message
Date: Sun, 10 Jun 2007 22:46:48 +0200
Message-ID: <20070610204648.GA32214@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 22:47:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxUJm-0006ya-G3
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 22:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041AbXFJUqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 16:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755089AbXFJUqw
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 16:46:52 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:36700 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755041AbXFJUqw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 16:46:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 65D14F0049
	for <git@vger.kernel.org>; Sun, 10 Jun 2007 22:46:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y4BK4qBJxYgX for <git@vger.kernel.org>;
	Sun, 10 Jun 2007 22:46:49 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 2F39CF0042
	for <git@vger.kernel.org>; Sun, 10 Jun 2007 22:46:49 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id ABD8A6DF845
	for <git@vger.kernel.org>; Sun, 10 Jun 2007 22:44:30 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 1312A62A5D; Sun, 10 Jun 2007 22:46:49 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49763>

Hello,

During a talk with madduck on #git today, we stumbled upon this
confusing error message:

  $ mkdir repo
  $ cd repo/
  $ git init
  Initialized empty Git repository in .git/
  $ mkdir empty
  $ git add empty/
  The following paths are ignored by one of your .gitignore files:
  empty/ (directory)
  Use -f if you really want to add them.
  $ git add -f empty/
  fatal: unable to index file empty/

First, it misleads the user by assuming that something was added to
.gitignore or another exclude file, and the second error message is not
very helpful.

Looking at the code, I am not sure how this can be fixed. Simply
printing a warning when finding "some" empty directory might do, but it
is not the best way to help somebody new to git. Refusing to add
anything when finding an empty directory deep in some hierarchy is not a
good option either.

Git 1.4 silently did nothing, so 1.5 at least tries to be more clueful.
Anyway, I thought I would mention it and see what happens. ;)

-- 
Jonas Fonseca
