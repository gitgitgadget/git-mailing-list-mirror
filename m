From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (amend)] gitweb: Require project for almost all actions
Date: Tue, 19 Sep 2006 21:53:22 +0200
Message-ID: <200609192153.22618.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 19 21:52:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPle0-0005bx-BZ
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 21:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbWISTwd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 15:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbWISTwd
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 15:52:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:39984 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752022AbWISTwd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 15:52:33 -0400
Received: by ug-out-1314.google.com with SMTP id o38so499625ugd
        for <git@vger.kernel.org>; Tue, 19 Sep 2006 12:52:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:user-agent:mime-version:content-disposition:date:content-type:content-transfer-encoding:message-id;
        b=lBMwEk0CpyOm85KBipmsUySwMHtESe2cHPEe4fFwNwoVqm2ceCeoZ3Y2YyfIaNht0AYvnTCsgKB1v8CV8o4h+OntnRPj99pOIai8KsM/uUmRp3iAJumc91LL1lRJOVN2Vcr4EUI6snHly56Sa9/iuspSCl97enzEUcpP3rjfpCk=
Received: by 10.78.196.10 with SMTP id t10mr4108971huf;
        Tue, 19 Sep 2006 12:52:31 -0700 (PDT)
Received: from host-81-190-31-133.torun.mm.pl ( [81.190.31.133])
        by mx.gmail.com with ESMTP id 36sm13688844huc.2006.09.19.12.52.30;
        Tue, 19 Sep 2006 12:52:30 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27281>

Require that project (repository) is given for all actions except
project_list, project_index and opml.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 034cdf1..34311ee 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -341,6 +341,10 @@ if (defined $project) {
 if (!defined($actions{$action})) {
 	die_error(undef, "Unknown action");
 }
+if ($action !~ m/^(opml|project_list|project_index)$/ &&
+    !$project) {
+	die_error(undef, "Project needed");
+}
 $actions{$action}->();
 exit;
 
-- 
1.4.2.1
