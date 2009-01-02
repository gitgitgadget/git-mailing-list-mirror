From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: use href() when generating URLs in OPML
Date: Fri,  2 Jan 2009 13:15:28 +0100
Message-ID: <1230898528-24187-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 13:51:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIjVO-0002fZ-5q
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 13:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580AbZABMug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 07:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757500AbZABMug
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 07:50:36 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:43502 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbZABMuf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 07:50:35 -0500
Received: by bwz14 with SMTP id 14so20029477bwz.13
        for <git@vger.kernel.org>; Fri, 02 Jan 2009 04:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=aWDITDOOMT+h4hW5kjSTLy0ZOZomgPpXXuLJ9FZAjG0=;
        b=rRT3XxiNMSTGt+2nsyQmzgLBJ0m0KG53wNNTNMOovP/wdVbW3Lf8qJ9PjWRlLEwEOS
         NoZqaRGn4a7cjr/OdepZWEcEZaCam0CuICkF1dlFPp6fNky3zUz2cdoIYExxq/RudrJS
         ZBd12f6PRqvDxyJZKOyc9vi5arLSzvlHfjqyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=FjHwpDu1UT4/gZXHs6n//1Z45BDONJp+v7K/o33OKqAIcnNxOCHbAz8XmWtfFLDV++
         GPCSlGt+6y8cl53B9Ix9ZQBxjf4TbGk6Jn+3n7r5a5jmv0I/LOMWLEekvsd//R2AfvcS
         xp/5BYlGmH3xBKnmhFICJ3aF37PtIbRmWGweQ=
Received: by 10.103.226.10 with SMTP id d10mr6364831mur.35.1230900632586;
        Fri, 02 Jan 2009 04:50:32 -0800 (PST)
Received: from localhost ([78.13.52.22])
        by mx.google.com with ESMTPS id j10sm36930353muh.57.2009.01.02.04.50.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Jan 2009 04:50:32 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104378>

Since the OPML project list view was hand-coding the RSS and HTML URLs,
it didn't respect global options such as use_pathinfo. Make it use
href() to ensure consistency with the rest of the gitweb setup.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fa7d8ad..b164001 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6146,8 +6146,8 @@ XML
 		}
 
 		my $path = esc_html(chop_str($proj{'path'}, 25, 5));
-		my $rss  = "$my_url?p=$proj{'path'};a=rss";
-		my $html = "$my_url?p=$proj{'path'};a=summary";
+		my $rss  = href('project' => $proj{'path'}, 'action' => 'rss', -full => 1);
+		my $html = href('project' => $proj{'path'}, 'action' => 'summary', -full => 1);
 		print "<outline type=\"rss\" text=\"$path\" title=\"$path\" xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
 	}
 	print <<XML;
-- 
1.5.6.5
