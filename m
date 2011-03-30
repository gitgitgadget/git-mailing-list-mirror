From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] parse-remote: replace unnecessary sed invocation
Date: Wed, 30 Mar 2011 01:48:40 -0700
Message-ID: <1301474920-6718-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 10:48:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4r5B-0005Wu-CJ
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 10:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604Ab1C3Iss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 04:48:48 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36713 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722Ab1C3Isr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 04:48:47 -0400
Received: by gxk21 with SMTP id 21so428496gxk.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=h8bwYoBN9BtIa3ucY5xV1Jtcdu4wY2FdPMJ6g9F2YM0=;
        b=QAbjnEdEVZGKD/H20942Q81E93s18TIf4YjOOGb9d9jX4IK/U9sLdXRVAx40tHMMDj
         hUfjrHWAbPv0mbWETl8v+XKc7uiZUm3VX4flQrgI74RfMcGulqyAdpANH4TXguDdXKz/
         6wm7krWw6JBPYdoVCI7vVGJ277WHbRhQuTo4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Y3GLMfHL06ELVeevyqZC9H7LNkeo+JZrdQ/ZSC7Yw/aAAqagcmjW2utZ6nykgeyvzM
         2rtWebvG8G7w7yFmlQpzWvzSer/Olmigr2kLl3hKwnbYLWWLnCFKUAE5LqH+b+2rL0Js
         gyP4Kr7XiJ3BSuU6LbZYt7HR0ijuh8C24dGxA=
Received: by 10.151.134.17 with SMTP id l17mr1259720ybn.376.1301474926423;
        Wed, 30 Mar 2011 01:48:46 -0700 (PDT)
Received: from earth ([75.85.182.25])
        by mx.google.com with ESMTPS id u37sm2294644yba.7.2011.03.30.01.48.43
        (version=SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 01:48:46 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Wed, 30 Mar 2011 01:48:40 -0700
X-Mailer: git-send-email 1.7.4.2.422.g537d99
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170367>

Just use parameter expansion instead.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Cleaning out the attic.

 git-parse-remote.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index e7013f7..9168879 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -5,7 +5,8 @@
 GIT_DIR=$(git rev-parse -q --git-dir) || :;
 
 get_default_remote () {
-	curr_branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
+	curr_branch=$(git symbolic-ref -q HEAD)
+	curr_branch="${cur_branch#refs/heads/}"
 	origin=$(git config --get "branch.$curr_branch.remote")
 	echo ${origin:-origin}
 }
-- 
1.7.4.2.422.g537d99
