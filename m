From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Handle commits with empty commit messages more reasonably
Date: Fri, 06 Oct 2006 18:55:04 +0200
Message-ID: <20061006165504.3934.97392.stgit@rover>
References: <20061006135508.GO20017@pasky.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 06 18:55:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVsyg-0006S8-2p
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 18:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422718AbWJFQzK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 12:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422719AbWJFQzK
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 12:55:10 -0400
Received: from rover.dkm.cz ([62.24.64.27]:11739 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S1422718AbWJFQzF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 12:55:05 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 48FF28B363;
	Fri,  6 Oct 2006 18:55:04 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20061006135508.GO20017@pasky.or.cz>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28420>

Currently those look very weird, you can't get easily at the commit view
etc. This patch makes their title '(no commit message)'.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ea159e9..56e5231 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1115,6 +1115,9 @@ sub parse_commit {
 			last;
 		}
 	}
+	if ($co{'title'} eq "") {
+		$co{'title'} = $co{'title_short'} = '(no commit message)';
+	}
 	# remove added spaces
 	foreach my $line (@commit_lines) {
 		$line =~ s/^    //;
