From: Mike Gant <mwgant@gmail.com>
Subject: git clone operation
Date: Sun, 17 Aug 2008 12:44:43 -0600
Message-ID: <20080817184443.GA11782@mg1.gantsfort.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 17 20:52:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUnMP-000730-Th
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 20:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbYHQSvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 14:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbYHQSvO
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 14:51:14 -0400
Received: from gantsfort.com ([64.66.245.199]:39170 "EHLO mail.gantsfort.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbYHQSvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 14:51:14 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Aug 2008 14:51:14 EDT
Received: from mg1.gantsfort.com (mg1.gantsfort.com [192.168.0.10])
	by mail.gantsfort.com (Postfix) with SMTP id 3966D17DF9
	for <git@vger.kernel.org>; Sun, 17 Aug 2008 12:44:45 -0600 (MDT)
Received: by mg1.gantsfort.com (sSMTP sendmail emulation); Sun, 17 Aug 2008 12:44:43 -0600
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92619>

I'm trying to understand git-clone and what to expect when I clone a
repository. Disclaimer, I am a newbie :).

Assume I have a repo with the following branches:

  cpu-intfc
  gige_mux
  improve-build
  main-devel
* master

According to the man page, git-clone "creates and checks out an initial
branch equal to the cloned repository's currently active branch."

So, when I clone this repo and run 'git-branch -a' I will have the
following:

  origin/HEAD
  origin/cpu-intfc
  origin/gige_mux
  origin/improve-build
  origin/main-devel
  origin/master
* master

All the origin/* branches are remote.

And, .git/refs/remotes/origin/HEAD is, 

$ cat .git/refs/remotes/origin/HEAD
ref: refs/remotes/origin/master

So far, this makes sense to me.

Now, let's say that I am working in the cpu-intfc branch of the original
repository and I clone the repository.

Running git-branch -a returns the following

  origin/HEAD
  origin/cpu-intfc
  origin/gige_mux
  origin/improve-build
  origin/main-devel
  origin/master
* cpu-intfc

And this,

$ cat .git/refs/remotes/origin/HEAD
ref: refs/remotes/origin/cpu-intfc

I was expecting to have a local branch named master (that is equal to
the remote branch origin/cpu-intfc) instead of cpu-intfc. Am I wrong to
expect this? Also, as a newbie user, it seems odd that I cannot specify
which branch of repo that I am cloning should be the default (master)
branch of the cloned repo? To put it another way, when cloning a repo I
have no way of controlling which branch I get as the default. It just
happens to depend on which branch the developer is working in at the
time I clone.  I've read through the man-page and there doesn't seem to
be any way around this.

I realize that I can create a new local branch that is based off the
desired branch:

$ git-checkout -b master origin/master

Is this the accepted method for obtaining the desired branch?


Thanks,
Mike
