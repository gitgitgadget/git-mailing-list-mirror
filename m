From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK,GIT-GUI,DOCS) 0/7] Improve gui blame and gitk integration
Date: Sat, 23 Aug 2008 12:25:11 +0400
Organization: TEPKOM
Message-ID: <200808231225.12596.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 10:34:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWoZW-0004X0-9a
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 10:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbYHWIdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 04:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbYHWIdG
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 04:33:06 -0400
Received: from oak.tepkom.ru ([79.173.78.6]:46644 "EHLO oak.tepkom.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbYHWIdD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 04:33:03 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Aug 2008 04:33:03 EDT
Received: from localhost (localhost [127.0.0.1])
	by oak.tepkom.ru (Postfix) with ESMTP id A1F062CA5A8;
	Sat, 23 Aug 2008 12:25:27 +0400 (MSD)
X-Virus-Scanned: amavisd-new 2.5.2 (20070627) at tepkom.ru
Received: from oak.tepkom.ru ([127.0.0.1])
	by localhost (oak.tepkom.ru [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TFotbsg1RhwO; Sat, 23 Aug 2008 12:25:25 +0400 (MSD)
Received: from desktop2 (unknown [92.255.85.78])
	(Authenticated sender: agavrilov)
	by oak.tepkom.ru (Postfix) with ESMTP id 796A92C9CBE;
	Sat, 23 Aug 2008 12:25:24 +0400 (MSD)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93440>

This series improves git gui blame usability by providing
better integration with gitk, and thus supporting more ways
of navigating the history.

Viewing the history context is especially useful if the
repository is imported from a VCS without atomic commits,
and thus related changes are often fragmented into a sequence
of several commit objects.

Note: Show History Context won't work if gitk is unpatched.


Usage scenario:

	1. Start git gui blame from an IDE macro; use
	   --line=... to immediately scroll to the same
	   position as the IDE editor.

	2. Use 'Show History Context' to view the diff
	   and surrounding commits.
	   
	3. Use 'Blame parent commit' in gitk to explore
	   blame for other files touched by the same commit.
	
	4. If the change is irrelevant (e.g. some variable
	   was renamed), close gitk and use 'Blame Parent Commit'
	   in Gui Blame to restart search.


GITK:
	gitk: Allow overriding the default commit.
	---
	 gitk |   21 ++++++++++++++++++++-
	 1 files changed, 20 insertions(+), 1 deletions(-)
 
	gitk: Support calling git gui blame from gitk.
	---
	 gitk |   23 +++++++++++++++++++++++
	 1 files changed, 23 insertions(+), 0 deletions(-)
 
GIT-GUI: 
	git-gui: Support starting gitk from Gui Blame
	---
	 git-gui.sh     |    1 +
	 lib/blame.tcl  |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
	 lib/option.tcl |    1 +
	 3 files changed, 55 insertions(+), 2 deletions(-)
	 
	git-gui: Support passing blame to a parent commit.
	---
	 lib/blame.tcl |   48 ++++++++++++++++++++++++++++++++++++++----------
	 1 files changed, 38 insertions(+), 10 deletions(-)

	git-gui: Better positioning in Blame Parent Commit
	---
	 lib/blame.tcl |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
	 1 files changed, 61 insertions(+), 4 deletions(-)

	git-gui: Allow specifying an initial line for git gui blame.
	---
	 git-gui.sh      |   13 +++++++++++--
	 lib/blame.tcl   |    4 ++--
	 lib/browser.tcl |    2 +-
	 3 files changed, 14 insertions(+), 5 deletions(-)

DOCS:
	Document new options of gui tools.
	---
	 Documentation/config.txt  |   14 ++++++++++++++
	 Documentation/git-gui.txt |    5 +++++
	 Documentation/gitk.txt    |    5 +++++
	 3 files changed, 24 insertions(+), 0 deletions(-)
 
