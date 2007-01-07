From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/5] gitweb: Fix error in "rename to"/"copy to" git diff header output
Date: Sun,  7 Jan 2007 02:52:24 +0100
Message-ID: <11681347522258-git-send-email-jnareb@gmail.com>
References: <100171.86639.qm@web31814.mail.mud.yahoo.com>
Cc: Luben Tuikov <ltuikov@yahoo.com>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 07 02:52:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3NDJ-0001C8-Q1
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 02:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbXAGBwg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 20:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbXAGBwg
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 20:52:36 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:5735 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312AbXAGBwc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 20:52:32 -0500
Received: by nf-out-0910.google.com with SMTP id o25so8960305nfa
        for <git@vger.kernel.org>; Sat, 06 Jan 2007 17:52:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=azGH4lgxI/A0qZ3is0qZX6T0V3SZ4pgdBSHRWSDEY2u2mBqwtWtWb1QHSgsni2b+uZfURwKZcSMFflh9NOQ5NOmtCyRn26IegyAo0FFF07bYZftlz9s9cDF6vzaH05XtKr+wSOOjj+U+O2RQaaxzc0wZMRtpooJ5wb032b03m/8=
Received: by 10.49.54.3 with SMTP id g3mr8939004nfk.1168134750418;
        Sat, 06 Jan 2007 17:52:30 -0800 (PST)
Received: from roke.D-201 ( [81.190.18.145])
        by mx.google.com with ESMTP id i1sm20922039nfe.2007.01.06.17.52.29;
        Sat, 06 Jan 2007 17:52:30 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l071qXMw007258;
	Sun, 7 Jan 2007 02:52:33 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l071qWnf007254;
	Sun, 7 Jan 2007 02:52:32 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <100171.86639.qm@web31814.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36111>

Fix error in git_patchset_body subroutine, which caused "rename to"/"copy
to" line in extended diff header to be displayed incorrectly.

While at it, fix align.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Stupid typu: was '=' instead of '.='.

 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 04c8015..1b4a4c0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2479,11 +2479,11 @@ sub git_patchset_body {
 			# match <path>
 			if ($patch_line =~ s!^((copy|rename) from ).*$!$1! && $from{'href'}) {
 				$patch_line .= $cgi->a({-href=>$from{'href'}, -class=>"path"},
-				                        esc_path($from{'file'}));
+				                       esc_path($from{'file'}));
 			}
 			if ($patch_line =~ s!^((copy|rename) to ).*$!$1! && $to{'href'}) {
-				$patch_line = $cgi->a({-href=>$to{'href'}, -class=>"path"},
-				                      esc_path($to{'file'}));
+				$patch_line .= $cgi->a({-href=>$to{'href'}, -class=>"path"},
+				                       esc_path($to{'file'}));
 			}
 			# match <mode>
 			if ($patch_line =~ m/\s(\d{6})$/) {
-- 
1.4.4.3
