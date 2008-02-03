From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb: Make feed entries point to commitdiff view
Date: Sun,  3 Feb 2008 12:38:46 +0100
Message-ID: <1202038726-4221-1-git-send-email-jnareb@gmail.com>
Cc: Florian La Roche <laroche@redhat.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 12:39:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLdC8-00071w-Lj
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 12:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288AbYBCLjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 06:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756516AbYBCLjA
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 06:39:00 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:33125 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267AbYBCLi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 06:38:59 -0500
Received: by py-out-1112.google.com with SMTP id u52so2614847pyb.10
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 03:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=H/MPSUjMbOWcBG6xeMllsSpQHml+dMTt30vze7tb7VE=;
        b=Ksc44DofcxwSdSHthvbaannpRJ654SJzdgt94BP7OKG6FTxam0dej2h3Y7EYsuq4z3W5g8X9hSiqEBEKU+S7XGXsoZmbwY+VEU8GfRoH4Hw8I9MNBWqEOvJ+jA96RbIBmGGsBe9HOLaNHcyPm+bC1DHjAixnzUiTtQfoDT5o2AA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kRd7g+9GCpy75dAb9+9K76J8kBu+DvRgxJ/d8PO6l9VgixwZN37oml/GDoX5xbBtZShA8OsHS31ySaptfMNHUnD0HNgWfitJaK6nMwlEU5JEKPyBObHAhOcRvhqJpm99wY37xvFhJB9ezM75e87MdAma/yack85wjACj9sdgYeU=
Received: by 10.65.180.9 with SMTP id h9mr10030602qbp.41.1202038737297;
        Sun, 03 Feb 2008 03:38:57 -0800 (PST)
Received: from localhost.localdomain ( [83.8.194.189])
        by mx.google.com with ESMTPS id k5sm15951090nfd.23.2008.02.03.03.38.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 03:38:56 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m13BcoPG004242;
	Sun, 3 Feb 2008 12:38:51 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m13BckSF004240;
	Sun, 3 Feb 2008 12:38:46 +0100
X-Mailer: git-send-email 1.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72352>

From: Florian La Roche <laroche@redhat.com>

Change feeds entries (feeds items) from pointing (linking) to 'commit'
view to pointing to 'commitdiff' view.

First, feed entries have whatchanged-like list of files which were
modified in a commit, so 'commitdiff' view more naturally reflects
feed entry (in more naturally alternate / extended version of a feed
item). Second, this way the patches are shown directly and code review
is done more easily via watching feeds.

[jn: Rewritten commit message]

Signed-off-by: Florian La Roche <laroche@redhat.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch was originally send by Florian La Roche in
  "[PATCH] gitweb: Change feeds from commit to commitdiff output"

  Message-ID: <20080110130900.GA9395%40dudweiler.stuttgart.redhat.com>
  http://thread.gmane.org/gmane.comp.version-control.git/70068

As requested, Junio, I have marged this patch as an RFC, although
I think that with the improved commit message the reason for this
change is more obvious, and it is a go.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ae2d057..8ef2735 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5565,7 +5565,7 @@ XML
 			or next;
 
 		# print element (entry, item)
-		my $co_url = href(-full=>1, action=>"commit", hash=>$commit);
+		my $co_url = href(-full=>1, action=>"commitdiff", hash=>$commit);
 		if ($format eq 'rss') {
 			print "<item>\n" .
 			      "<title>" . esc_html($co{'title'}) . "</title>\n" .
-- 
1.5.4
