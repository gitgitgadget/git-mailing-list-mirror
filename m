From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation: do not treat reset --keep as a special case
Date: Fri, 21 Jan 2011 12:37:34 -0600
Message-ID: <20110121183734.GB16325@burratino>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <20110120195726.GA11702@burratino>
 <20110120200827.GB14184@vidovic>
 <201101202134.41911.trast@student.ethz.ch>
 <7vfwsnqn8c.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1101210801210.15247@pacific.mpi-cbg.de>
 <7vsjwmp5cs.fsf@alter.siamese.dyndns.org>
 <vpqmxmu2nm3.fsf@bauges.imag.fr>
 <4D39C923.20202@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 19:38:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgLs4-0003fx-WD
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 19:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab1AUSh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 13:37:57 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61933 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951Ab1AUSh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 13:37:56 -0500
Received: by wwa36 with SMTP id 36so2185418wwa.1
        for <git@vger.kernel.org>; Fri, 21 Jan 2011 10:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=sQyuwJW7CgIAIP8j4SCXi3eLF+BpznK3xrmE9iEDIhE=;
        b=xGxS0t4ct+xMHsKTQJN9Pp+lYWQ0VyoavuPIpO0NlfLP9fZ1nFn6S+m9cgGz4qD1gz
         0Ge8J0WhN/uPjMJUSkKyFDQIT5kT4w+7lJdFV1IxSjJ35GHVo0uNCTP4U1aryKZiZKcP
         MaOSFNpYBqkuEOibwcXw+/oe9r/IRH8iHJ+I0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Wvd2OWTwNjxO/v0MjetigYPbs2/wVeqbQ92DbLVHqczHx7wnoRR9ic1ombmHKOPLTj
         6ygdl1TTxJ5hdbRTSoIDbnxLdrcyWFRfRuc+PxdoaoGV14jolx0WmqnaODdUy0CPkz7p
         L3X8zkNFbKCMw1wkutI83D6ey9C1tzKlNO2cI=
Received: by 10.227.138.71 with SMTP id z7mr1225074wbt.51.1295635074919;
        Fri, 21 Jan 2011 10:37:54 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id q18sm7098477wbe.5.2011.01.21.10.37.51
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Jan 2011 10:37:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D39C923.20202@workspacewhiz.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165388>

The current treatment of "git reset --keep" emphasizes how it
differs from --hard (treatment of local changes) and how it breaks
down into plumbing (git read-tree -m -u HEAD <commit> followed by git
update-ref HEAD <commit>).  This can discourage people from using
it, since it might seem to be a complex or niche option.

Better to emphasize what the --keep flag is intended for --- moving
the index and worktree from one commit to another, like "git checkout"
would --- so the reader can make a more informed decision about the
appropriate situations in which to use it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Joshua Jensen wrote:

> I've always wished "git reset --hard" would tell me there are
> modified files and force me to type "git reset --hard --force" to
> overwrite them.  It is a dangerous command, and I stupidly run it
> sometimes without running "git status" first.

Have you tried "git reset --keep"?  How does it compare to your
wish?

 Documentation/git-reset.txt |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index fd72976..927ecee 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -76,15 +76,10 @@ In other words, --merge does something like a 'git read-tree -u -m <commit>',
 but carries forward unmerged index entries.
 
 --keep::
-	Resets the index, updates files in the working tree that are
-	different between <commit> and HEAD, but keeps those
-	which are different between HEAD and the working tree (i.e.
-	which have local changes).
+	Resets index entries and updates files in the working tree that are
+	different between <commit> and HEAD.
 	If a file that is different between <commit> and HEAD has local changes,
 	reset is aborted.
-+
-In other words, --keep does a 2-way merge between <commit> and HEAD followed by
-'git reset --mixed <commit>'.
 --
 
 If you want to undo a commit other than the latest on a branch,
-- 
1.7.4.rc2
