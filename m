From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH] Describe the bug about handling non-Ascii filenames in 'git add -i'
Date: Wed, 2 Apr 2008 20:06:46 +0300
Message-ID: <20080402170646.GA12711@mithlond.arda.local>
References: <200804012232.03559.tlikonen@iki.fi> <m3y77xtk32.fsf@localhost.localdomain> <7v63v1ccmb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 19:08:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh6RK-0004o7-5P
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 19:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568AbYDBRHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 13:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754162AbYDBRHM
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 13:07:12 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:36461 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755272AbYDBRHL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Apr 2008 13:07:11 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout3-sn1.fre.skanova.net (7.3.129)
        id 47A7885700339AC5; Wed, 2 Apr 2008 19:06:48 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Jh6QA-0006zA-MM; Wed, 02 Apr 2008 20:06:46 +0300
Content-Disposition: inline
In-Reply-To: <7v63v1ccmb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78699>

The command 'git add -i' (i.e. the interactive mode) can't handle
files which have non-Ascii characters in their name unless the option
core.quotepath is set to false. This patch adds a description of the bug
to the git-add.txt manual.
---

Junio C Hamano kirjoitti (1.4.2008 klo 17.41):

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > git-config(1):
> >
> >   core.quotepath::
> > 	The commands that output paths (e.g. `ls-files`,
> > 	`diff`), when not given the `-z` option, will quote
> > 	"unusual" characters in the pathname by enclosing the
> > 	pathname in a double-quote pair and with backslashes the
> > 	same way strings in C source code are quoted.  If this
> > 	variable is set to false, the bytes higher than 0x80 are
> > 	not quoted but output as verbatim.  Note that double
> > 	quote, backslash and control characters are always
> > 	quoted without `-z` regardless of the setting of this
> > 	variable.
> 
> Yes, but I do not think "add -i" unwraps the path quoting.  I think it
> should, but I do not think I bothered to.  Because it is trivial to do
> by any aspiring git hacker wannabes, I left it as an exercise to
> readers when I did the "interactive" as a quick-and-dirty hack (aka
> "demonstration").
> 
> Somehow nobody found an itch to improve it until now, but it seems
> that we found a volunteer with the itch ;-)

Unfortunately we found a non-programmer :) My itch (both of them)
disappeared pretty much at the moment I set core.quotepath to false
(thanks Jakub). But this patch is the kind of contribution I can do at
the present moment.


 Documentation/git-add.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index c751a17..f085b15 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -226,6 +226,13 @@ diff::
   This lets you review what will be committed (i.e. between
   HEAD and index).
 
+Bugs
+----
+Files with non-Ascii characters in their name don't work in the interactive
+mode (see above) unless option 'core.quotepath' is set to false. Setting
+'core.quotepath' to false may be a good idea anyway if you need to handle
+non-Ascii filenames. See linkgit:git-config[1] for more information about this
+option.
 
 See Also
 --------
-- 
1.5.5.rc2.15.g4db6
