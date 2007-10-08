From: Theodore Tso <tytso@mit.edu>
Subject: Re: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Mon, 8 Oct 2007 12:37:01 -0400
Message-ID: <20071008163701.GA5868@thunk.org>
References: <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com> <Pine.LNX.4.64.0710080018270.4174@racer.site> <51419b2c0710071624v79dc02d2g35a265add50dd46d@mail.gmail.com> <Pine.LNX.4.64.0710080028301.4174@racer.site> <51419b2c0710071638p6dcc0c7cm2a813c22758e6f32@mail.gmail.com> <Pine.LNX.4.64.0710080129480.4174@racer.site> <20071008010033.GA25654@fieldses.org> <Pine.LNX.4.64.0710080204140.4174@racer.site> <4709CCB2.4000202@viscovery.net> <20071008143650.GC2902@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 18:37:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ievbj-0006Vt-1Y
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 18:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbXJHQhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 12:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbXJHQhP
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 12:37:15 -0400
Received: from THUNK.ORG ([69.25.196.29]:37608 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbXJHQhN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 12:37:13 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Ievl2-0008Ge-7G; Mon, 08 Oct 2007 12:47:04 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IevbJ-0005wD-1u; Mon, 08 Oct 2007 12:37:01 -0400
Content-Disposition: inline
In-Reply-To: <20071008143650.GC2902@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60328>

On Mon, Oct 08, 2007 at 10:36:50AM -0400, J. Bruce Fields wrote:
> Having it by default leave these backups around, even when everything
> succeeds, makes for unnecessary cleanup work in the normal case, and is
> inconsistent with the behavior of other git commands that destroy or
> rewrite history.

I think what makes git-filter-branch different is that you can change
a large amount of history with git-filter-branch, including large
numbers of tags, etc.  The reflog is quite sufficient to recover from
a screwed up "git commit --amend".  But I don't think the reflog is
going to be sufficient given the kinds of changes that
git-filter-branch can potentially do to your repository.  Maybe
default of --backup vs --no-backup could be changed via a config
parameter, but I think the default is of backing up refs is a good
think....

Perhaps a solution would be to add "git-filter-branch --cleanup" that
that clears the reflog and wipes the backed up tags; perhaps first
asking interactively if the user is really sure he/she wants to do
this.

						- Ted
