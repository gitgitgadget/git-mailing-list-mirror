From: "Lars Hjemli" <hjemli@gmail.com>
Subject: [PATCH 1/5] t7400: barf if git-submodule removes or replaces a file
Date: Mon, 11 Jun 2007 02:00:17 +0200
Message-ID: <op.ttqcyrco9pspc6@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 01:58:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxXIF-0000Fb-OE
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 01:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760651AbXFJX5x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 19:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760591AbXFJX5x
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 19:57:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:19006 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760651AbXFJX5x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2007 19:57:53 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1357361ugf
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 16:57:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:subject:from:content-type:mime-version:content-transfer-encoding:date:message-id:user-agent;
        b=Jazuk+zj97S/K40SVXfDd/YmPN4dkZEtHQgQCQ1ZznPF3l+3Te5a6Jxt87N+/x/aF+zEX6WDIesJWmJZDZY+jfVffuBjURvXtaijmDLDCuQhyaiwE9ziSBq9CTgYrs4Z1I/J9EZf9nyxZlmq79bImwq1M26IXi2GIezCmG7cWDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:subject:from:content-type:mime-version:content-transfer-encoding:date:message-id:user-agent;
        b=GYCpYa3dnYjYdFLYeAGratp1SJcj0WD2KhpjrlOFJcnOq5Gs3uPS0tKEBfjJCDeP8ZiYdROeVhN7NLi+eAXIebrnllBlWqOc9FShZtMzsL3K+mm174pahXJSB4gu1DBNAA1GQ6lpQA9KNix7OUVQn0UgFVKbDdW+LQdgz14lG9w=
Received: by 10.66.249.8 with SMTP id w8mr3861729ugh.1181519871523;
        Sun, 10 Jun 2007 16:57:51 -0700 (PDT)
Received: from localhost ( [88.88.169.227])
        by mx.google.com with ESMTP id z37sm12180330ikz.2007.06.10.16.57.50
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Jun 2007 16:57:50 -0700 (PDT)
User-Agent: Opera Mail/9.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49796>

The test for an unmolested file wouldn't fail properly if the file had been
removed or replaced by something other than a regular file. This fixes it.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
  t/t7400-submodule-basic.sh |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 3940433..74fafce 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -72,7 +72,7 @@ test_expect_success 'update should fail when path is used by a file' '
  	then
  		echo "[OOPS] update should have failed"
  		false
-	elif test -f lib && test "$(cat lib)" != "hello"
+	elif test "$(cat lib)" != "hello"
  	then
  		echo "[OOPS] update failed but lib file was molested"
  		false
-- 
1.5.2.1.914.gbd3a7
