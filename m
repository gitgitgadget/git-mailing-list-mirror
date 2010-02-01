From: Jeff King <peff@peff.net>
Subject: Re: GIT_WORK_TREE environment variable not working
Date: Mon, 1 Feb 2010 00:19:42 -0500
Message-ID: <20100201051942.GA7761@coredump.intra.peff.net>
References: <ron1-8E7697.17334731012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 06:19:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbohS-0000A7-1B
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 06:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121Ab0BAFTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 00:19:44 -0500
Received: from peff.net ([208.65.91.99]:40345 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854Ab0BAFTo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 00:19:44 -0500
Received: (qmail 19633 invoked by uid 107); 1 Feb 2010 05:19:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 01 Feb 2010 00:19:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Feb 2010 00:19:42 -0500
Content-Disposition: inline
In-Reply-To: <ron1-8E7697.17334731012010@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138581>

On Sun, Jan 31, 2010 at 05:33:47PM -0800, Ron Garret wrote:

> What am I doing wrong here?
> 
> [ron@mickey:~/devel/gittest]$ pwd
> /Users/ron/devel/gittest
> [ron@mickey:~/devel/gittest]$ git status
> # On branch master
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #  git/
> nothing added to commit but untracked files present (use "git add" to 
> track)
> [ron@mickey:~/devel/gittest]$ cd
> [ron@mickey:~]$ export GIT_WORK_TREE=/Users/ron/devel/gittest
> [ron@mickey:~]$ git status
> fatal: Not a git repository (or any of the parent directories): .git
> [ron@mickey:~]$ git status --work-tree=/Users/ron/devel/gittest
> fatal: Not a git repository (or any of the parent directories): .git
> [ron@mickey:~]$

You haven't told git where to find the repository itself. GIT_WORK_TREE
is about saying "here are my work tree files", but it is explicitly not
about "here is where my .git directory is". That lets you keep the two
in totally separate locations. E.g., you could do something like
tracking /etc, but keep your .git directory in /var.

For your case above, you would want to also

  export GIT_DIR=/Users/ron/devel/gittest/.git

though since you have a fully formed repository, I don't think there is
really any advantage over just doing:

  cd /Users/ron/devel/gittest && git $whatever

though perhaps that is because this is not a real use case, but rather
just you trying to figure out the feature. :)

-Peff
