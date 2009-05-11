From: Daniel Pittman <daniel@rimspace.net>
Subject: git branch -a now reports 'remotes/foo' rather than 'foo'?
Date: Mon, 11 May 2009 12:16:43 +1000
Organization: I know I put it down here, somewhere.
Message-ID: <87skjcpeno.fsf@rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 04:18:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3L5s-0007ve-6t
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 04:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbZEKCSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 22:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753229AbZEKCSH
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 22:18:07 -0400
Received: from main.gmane.org ([80.91.229.2]:34031 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752929AbZEKCSG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 22:18:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M3L5d-0003Km-Ma
	for git@vger.kernel.org; Mon, 11 May 2009 02:18:01 +0000
Received: from sdcarl02.strategicdata.com.au ([203.214.67.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 May 2009 02:18:01 +0000
Received: from daniel by sdcarl02.strategicdata.com.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 May 2009 02:18:01 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sdcarl02.strategicdata.com.au
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:kiyItuxsOp7KOeejuvGaInWbutI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118769>

G'day.  Debian recently released git 1.6.3 to unstable, so it has just
landed on my desk, and a change in the output of 'git branch' listings
is causing one of the front-ends I use to fail.

In previous versions, in a git-svn repository, I got this output to
'git branch -a':

,----[ git 1.6.2 and earlier ]
| ] git branch -a
| * master
|   tags/16-1
|   tags/18-1
|   tags/19-2
|   trunk
`----

Now, in 1.6.3, I see two different output formats:

,----[ git 1.6.3 ]
| ] git branch -a
| * master
|   remotes/tags/16-1
|   remotes/tags/18-1
|   remotes/tags/19-2
|   remotes/trunk
| ] git branch -r
|   tags/16-1
|   tags/18-1
|   tags/19-2
|   trunk
`----

The front-end I am using looks for a 'trunk' branch by name in the
output of 'git branch -a', which historically worked.  Now, though, it
shows that fully qualified.

Looking at the release notes it looks like this was a deliberate change,
from this entry:

* "git-branch -r" shows HEAD symref that points at a remote branch in
  interest of each tracked remote repository.

However, that isn't unambiguously clear about the change, and is pretty
light on the "why" parts.  Worse, the only discussion I can find about
the change suggests that this was noticed, and there wasn't real clarity
about the background.

(See Jeff King under "[PATCH 1/2] add basic branch display tests" at [1]
 for the details.)


I confess, to me, that having 'git branch -a' and 'git branch -r' emit
different values doesn't make much sense, but I suppose the upstream
code can be adapted.

I wanted to confirm that this was a deliberate change before I went to
the trouble or rewriting the front-end code however.

Regards,
        Daniel

Footnotes: 
[1]  http://thread.gmane.org/gmane.comp.version-control.git/110564/focus=110616
