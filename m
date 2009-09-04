From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH 2/2] git-completion.bash: prevent 'git help' from searching for git repository
Date: Fri, 4 Sep 2009 09:29:29 +0000
Message-ID: <20090904092929.23208.qmail@00cf3567a0e8b4.315fe32.mid.smarden.org>
References: <20090902095843.28914.qmail@3cd9dde586d86b.315fe32.mid.smarden.org> <fabb9a1e0909020447p212594cake8c6fe3a43b667ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 11:29:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjV78-0000qz-ST
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 11:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933340AbZIDJ33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 05:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933306AbZIDJ33
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 05:29:29 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:3977 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933302AbZIDJ32 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 05:29:28 -0400
Received: (qmail 23209 invoked by uid 1000); 4 Sep 2009 09:29:29 -0000
Content-Disposition: inline
In-Reply-To: <fabb9a1e0909020447p212594cake8c6fe3a43b667ec@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127700>

On 'git <TAB><TAB>' the bash completion runs 'git help -a'.  Since 'git
help' actually doesn't need to be run inside a git repository, this
commit uses the --no-git-dir option to prevent it from searching a git
directory.  Unnecessary searching for a git directory can be annoying in
auto-mount environments.

The annoying behavior and suggested fix has been reported by Vincent
Danjean through
 http://bugs.debian.org/539273

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bf688e1..a55e3cd 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -500,7 +500,7 @@ __git_all_commands ()
 		return
 	fi
 	local i IFS=" "$'\n'
-	for i in $(git help -a|egrep '^ ')
+	for i in $(git --no-git-dir help -a|egrep '^ ')
 	do
 		case $i in
 		*--*)             : helper pattern;;
-- 
1.6.0.3
