From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix "next" link in commit view
Date: Fri, 23 Mar 2007 21:04:31 +0100
Message-ID: <11746802714024-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 21:02:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUpxx-0001w0-TE
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 21:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934296AbXCWUBh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 16:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934303AbXCWUBg
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 16:01:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:7719 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934296AbXCWUBf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 16:01:35 -0400
Received: by nf-out-0910.google.com with SMTP id o25so2168609nfa
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 13:01:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=cZQIeDiXiurRMkSES1RnD/2eRMtHcHc2oZAWe4ZaYxZHLncdLLTPdPDKIclPWCmSSMgDW5b5/oyLb3tGlCDgLjfPaLPE+TJw+dO61Z8W1C1erkdpbegY56vWD+dBT/EXxg27fbzSPGHVlr3AUNqgP6qpfDJMXP44TUawByV1blI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=pqwNLM7jgkOGTksEZBmXBZcTbCyZXkLn6djU3bS1EaBU7s7WToKYtbb2TyZ05sVCCVP/EU1lZmu2S1wxnnhDhmk34jWv/KFhqtWVZNs2GsZutId0wztal2tu2AZoitR3ebeNyz+p3xgtwz9FpRrDduQHOoa8tdqd2o/ugJmiSeA=
Received: by 10.82.108.9 with SMTP id g9mr7418677buc.1174680093857;
        Fri, 23 Mar 2007 13:01:33 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id g1sm16693217muf.2007.03.23.13.01.31;
        Fri, 23 Mar 2007 13:01:32 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l2NK4WYF026434;
	Fri, 23 Mar 2007 21:04:32 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l2NK4V9f026433;
	Fri, 23 Mar 2007 21:04:31 +0100
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42958>

Fix copy'n'paste error in commit c9d193df which caused that "next"
link for merge commits in "commit" view
  (merge: _commit_ _commit_ ...)
was to "commitdiff" view instead of being to "commit" view.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 27b5970..5214050 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3719,7 +3719,7 @@ sub git_commit {
 		$formats_nav .=
 			'(merge: ' .
 			join(' ', map {
-				$cgi->a({-href => href(action=>"commitdiff",
+				$cgi->a({-href => href(action=>"commit",
 				                       hash=>$_)},
 				        esc_html(substr($_, 0, 7)));
 			} @$parents ) .
-- 
1.5.0.5
