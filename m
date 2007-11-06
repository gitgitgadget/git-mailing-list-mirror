From: =?utf-8?q?Ask=20Bj=C3=B8rn=20Hansen?= <ask@develooper.com>
Subject: [PATCH] When exec() fails include the failing command in the error message
Date: Tue,  6 Nov 2007 02:54:01 -0800
Message-ID: <1194346441-20292-1-git-send-email-ask@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Ask=20Bj=C3=B8rn=20Hansen?= <ask@develooper.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 12:01:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpMBF-0008TQ-Tj
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 12:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367AbXKFLA6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Nov 2007 06:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754942AbXKFLA6
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 06:00:58 -0500
Received: from gw.develooper.com ([64.81.84.140]:56234 "EHLO
	freja.develooper.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754833AbXKFLA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 06:00:58 -0500
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Nov 2007 06:00:58 EST
Received: by freja.develooper.com (Postfix, from userid 500)
	id 5A6B617D028; Tue,  6 Nov 2007 02:54:01 -0800 (PST)
X-Mailer: git-send-email 1.5.3.5.561.g140d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63658>

git-svn occasionally fails with no details as to what went wrong - this=
 should help debug those situations.

Signed-off-by: Ask Bj=C3=B8rn Hansen <ask@develooper.com>
---
 perl/Git.pm |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 3f4080c..dca92c8 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -812,7 +812,7 @@ sub _cmd_exec {
 		$self->wc_subdir() and chdir($self->wc_subdir());
 	}
 	_execv_git_cmd(@args);
-	die "exec failed: $!";
+	die qq[exec "@args" failed: $!];
 }
=20
 # Execute the given Git command ($_[0]) with arguments ($_[1..])
--=20
1.5.3.5.561.g140d
