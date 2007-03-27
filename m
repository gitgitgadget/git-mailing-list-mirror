From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Cleanup and uniquify die_error calls
Date: Tue, 27 Mar 2007 02:07:11 +0200
Message-ID: <11749540314189-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 02:04:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVzAf-0008Jy-6B
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 02:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933823AbXC0AEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 20:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933834AbXC0AEN
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 20:04:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:15336 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933823AbXC0AEM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 20:04:12 -0400
Received: by nf-out-0910.google.com with SMTP id o25so3068643nfa
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 17:04:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=RVh2mof1lKRDS7fnwoMnhCbWsEbja70RskUlwcsVFqGbUR0oVVUQid7MqeGgzAgE841CosdYV7nTBDFWMGscghw/+uWpM2zC4pNNVufD65mYDnVacNt6VQ4DW8LiGfFvy8sfe0gyuDU+KvOtGPiXVbLQTZSLq+xx42YArzqte4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=gcwLJyxu22/8u/8sbALWQ47kKmldh2jIyTiDusUymF5Ap0uxuzrbPIFWpqVPPNCSJrvGlaO3mWOZohvYBTNZ3ZKv+W00gsa15g9KxMsDxHfdvrAljfLlz+J2RLdF9kjmXY9VoRZYQVnKPNzKT9JznSajYEbK/TZ1TOqKkg2wj0k=
Received: by 10.82.162.14 with SMTP id k14mr14889207bue.1174953850966;
        Mon, 26 Mar 2007 17:04:10 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id u9sm22187455muf.2007.03.26.17.04.08;
        Mon, 26 Mar 2007 17:04:09 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l2R07Chd000419;
	Tue, 27 Mar 2007 02:07:14 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l2R07Bjb000418;
	Tue, 27 Mar 2007 02:07:11 +0200
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43212>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c79bfeb..3786955 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3154,7 +3154,7 @@ sub git_blame2 {
 	}
 	$ftype = git_get_type($hash);
 	if ($ftype !~ "blob") {
-		die_error("400 Bad Request", "Object is not a blob");
+		die_error('400 Bad Request', "Object is not a blob");
 	}
 	open ($fd, "-|", git_cmd(), "blame", '-p', '--',
 	      $file_name, $hash_base)
@@ -3220,7 +3220,7 @@ HTML
 			print "</td>\n";
 		}
 		open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
-			or die_error("could not open git-rev-parse");
+			or die_error(undef, "Open git-rev-parse failed");
 		my $parent_commit = <$dd>;
 		close $dd;
 		chomp($parent_commit);
@@ -3622,7 +3622,7 @@ sub git_snapshot {
 	$name =~ s/\047/\047\\\047\047/g;
 	open my $fd, "-|",
 	"$git archive --format=tar --prefix=\'$name\'/ $hash | $command"
-		or die_error(undef, "Execute git-tar-tree failed.");
+		or die_error(undef, "Execute git-tar-tree failed");
 	binmode STDOUT, ':raw';
 	print <$fd>;
 	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
-- 
1.5.0.5
