From: Linus Torvalds <torvalds@osdl.org>
Subject: git-whatchanged: exit out early on errors
Date: Wed, 25 Jan 2006 17:02:10 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601251700540.2644@evo.osdl.org>
References: <Pine.LNX.4.64.0601251655580.2644@evo.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jan 25 23:02:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1sil-0000sM-3W
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 23:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWAYWCY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 17:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWAYWCY
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 17:02:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13275 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932166AbWAYWCX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jan 2006 17:02:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0PM2KDZ011368
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 25 Jan 2006 14:02:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0PM2Io0007388;
	Wed, 25 Jan 2006 14:02:19 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0601251655580.2644@evo.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.66__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15139>


If we get an error parsing the arguments, exit.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This goes together with the previous diff - it just makes git-whatchanged 
exit gracefully when git-rev-parse errors out.

diff --git a/git-whatchanged.sh b/git-whatchanged.sh
index 80e2500..d4f985b 100755
--- a/git-whatchanged.sh
+++ b/git-whatchanged.sh
@@ -4,7 +4,7 @@ USAGE='[-p] [--max-count=<n>] [<since>..
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
-diff_tree_flags=$(git-rev-parse --sq --no-revs --flags "$@")
+diff_tree_flags=$(git-rev-parse --sq --no-revs --flags "$@") || exit
 test -z "$diff_tree_flags" &&
 	diff_tree_flags=$(git-repo-config --get whatchanged.difftree)
 test -z "$diff_tree_flags" &&
