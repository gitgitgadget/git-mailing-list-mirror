From: Mark Plaksin <happy@usg.edu>
Subject: Re: Syntax check via update hook?
Date: Tue, 12 May 2009 15:16:50 -0400
Message-ID: <wsd4aem8rh.fsf@usg.edu>
References: <wsprejtm71.fsf@usg.edu>
	<20090509144711.GA3926@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 21:17:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3xTd-00036V-JK
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 21:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbZELTRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 15:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbZELTRK
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 15:17:10 -0400
Received: from main.gmane.org ([80.91.229.2]:36143 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860AbZELTRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 15:17:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M3xTO-0007c4-Oq
	for git@vger.kernel.org; Tue, 12 May 2009 19:17:06 +0000
Received: from stone.tss.usg.edu ([168.24.82.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 May 2009 19:17:06 +0000
Received: from happy by stone.tss.usg.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 May 2009 19:17:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: stone.tss.usg.edu
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.93 (gnu/linux)
Cancel-Lock: sha1:+p+HPQDOlHx6LEhOTZUillVlaXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118947>

Jeff King <peff@peff.net> writes:

> That sounds like a reasonable goal. In the hook itself, you can do one
> of:

>   2. Check out the whole tree to a temp directory and run your full
>      syntax check there. The simplest way would be by using "git
>      archive" to generate the tree. You can make this a bit more
>      efficient by keeping the temp directory between runs and using
>      git to just update the changed files. Off the top of my head, that
>      would look something like:
>
>         $ cat <<EOF >.git/hooks/update
>         #!/bin/sh
>         GIT_INDEX_FILE=/path/to/tempdir/index; export GIT_INDEX_FILE
>         cd /path/to/tempdir/tree &&
>         mkdir -p tree &&
>         git read-tree "$3" &&
>         git checkout-index &&
>         your_syntax_check
>         EOF
>         $ chmod +x .git/hooks/update

Thanks for helping! :)

Unfortunately we don't quite get it.  Can you flesh out your example a
bit and explain the concepts involved?  We're relative git newbies.  We
tried reading the man pages to the commands you use to no avail.  One
big stumbling block seems to be how we create/set-up tempdir.  Is that
supposed to be a pre-created git checkout, or created via git-archive,
or .. ?

Also, we actually just want to check the syntax of the files that were
changed in the commit, not the whole tree.  Will your method give us
access to the path names of the files that changed?

Thanks again!
