From: Theodore Tso <tytso@mit.edu>
Subject: Re: What commands can and can not be used with bare repositories?
Date: Sat, 30 Dec 2006 21:12:49 -0500
Message-ID: <20061231021248.GA26067@thunk.org>
References: <E1H0poE-0000qd-Ee@candygram.thunk.org> <20061231015732.GB5082@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 03:13:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0qC5-00012O-S1
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 03:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbWLaCMv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 21:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbWLaCMv
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 21:12:51 -0500
Received: from thunk.org ([69.25.196.29]:35585 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932665AbWLaCMv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 21:12:51 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1H0qGD-0008V7-2O; Sat, 30 Dec 2006 21:17:17 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1H0qBt-0000t7-7u; Sat, 30 Dec 2006 21:12:49 -0500
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20061231015732.GB5082@spearce.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35650>

On Sat, Dec 30, 2006 at 08:57:32PM -0500, Shawn Pearce wrote:
> Try "git --bare log".  Or "git --git-dir=/path/to log".
>
> Actually most commands work on a bare repository.
> Very few don't: the ones that require a working directory.
> E.g. status/revert/cherry-pick/commit/am/merge/pull.  (You can
> pull from a bare repository, but you cannot run pull *in* a bare
> repository.)

Ah, right.  Thanks, I missed the --bare option.  It should probably be
mentioned in the git-clone man page, instead of only in the top-level
git manpage.

> > confused, but maybe we could fix that.  What if we were to change "git
> > clone --bare" to create the .git -> . symlink, and then add a check to
> > commands that require a working directory to see if ".git" is a symlink
> > to ., and if so, give an error message, "operation not supported on bare
> > repository"?
> 
> No.  Better would be to make git's repository setup logic
> automatically detect if "." is a Git repository, and if so let the
> commands that work without a working directory run.

That makes sense, although the hueristic for determining whether or
not "." is a Git repository might be a little interesting.  Say, if
there is no containing directory which has a .git directory, and the
directories "objects", "info", and "refs" are present?

						- Ted
