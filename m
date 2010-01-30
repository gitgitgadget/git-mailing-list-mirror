From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 7/8 v6] gitweb: Add optional extra parameter to die_error, for extended explanation
Date: Sat, 30 Jan 2010 23:30:44 +0100
Message-ID: <1264890645-28310-8-git-send-email-jnareb@gmail.com>
References: <1264890645-28310-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 23:31:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbLqo-0008Ua-8i
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 23:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886Ab0A3WbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 17:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754472Ab0A3WbQ
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 17:31:16 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:42269 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253Ab0A3WbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 17:31:09 -0500
Received: by mail-fx0-f220.google.com with SMTP id 20so3058028fxm.21
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 14:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KsUWE024T4Yp5MkhmsTQgLjStefvR5rP5sVdO6KdZXY=;
        b=kRamm/SUNlzl94CuPbNr7V4oYrslprEiinrRr89XcyQ8HWd7u0GXIwFLEBfZM0I68K
         zE+ZABMQVLcfC4QOaMWsIrQ4hMUU8F+3cFIglxSczCh3/7L9v3lI846SwETPvGL8VAuu
         FegpYOZDS61FX39nnUzo42xYotIaBsbIssi94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JlRNY8jR8Zo66rYskNbcTKoDsERQBi5VUWSqfEZhJ7YBBIRbU29lmPbAgcjSfzbwUa
         HdTwzyQVqh1tONDQ2t/ooor/5EBlMsTGZ2n5xXwpLPjxmh0NpfpPVcp+/vnHDEGAzSpW
         JK1ps+6TFS4tgiUWu5imn0Zd75k2+iceA2chM=
Received: by 10.223.76.142 with SMTP id c14mr2196194fak.92.1264890668875;
        Sat, 30 Jan 2010 14:31:08 -0800 (PST)
Received: from localhost.localdomain (abwu191.neoplus.adsl.tpnet.pl [83.8.244.191])
        by mx.google.com with ESMTPS id 15sm1157284fxm.6.2010.01.30.14.31.07
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Jan 2010 14:31:08 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1264890645-28310-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138510>

From: John 'Warthog9' Hawley <warthog9@kernel.org>

This is a small change that just adds a 3rd, optional, parameter to die_error
that allows for extended error information to be output along with what the
error was.

Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Changes from version from 'Gitweb caching v5' and
  git://git.kernel.org/pub/scm/git/warthog9/gitweb.git gitweb-ml-v5

* Slightly changed commit summary (commit description).
* Align with spaces, instead of indenting with tab

Those changes are purely cosmetic; the commit is practically unchanged
from the version by J.H.

 gitweb/gitweb.perl |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 466fa8a..d0c3ff2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3392,6 +3392,7 @@ sub git_footer_html {
 sub die_error {
 	my $status = shift || 500;
 	my $error = shift || "Internal server error";
+	my $extra = shift;
 
 	my %http_responses = (
 		400 => '400 Bad Request',
@@ -3406,8 +3407,13 @@ sub die_error {
 <br /><br />
 $status - $error
 <br />
-</div>
 EOF
+	if (defined $extra) {
+		print "<hr />\n" .
+		      "$extra\n";
+	}
+	print "</div>\n";
+
 	git_footer_html();
 	exit;
 }
-- 
1.6.6.1
