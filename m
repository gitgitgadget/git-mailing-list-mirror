From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 08/23] Introduce --branch-exists
Date: Sat, 23 Apr 2011 17:22:37 +1000
Message-ID: <1303543372-77843-9-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:24:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXCS-0004jf-Uf
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259Ab1DWHYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:13 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39715 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab1DWHYI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:24:08 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so584380pzk.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=qkICXcurajQmggfeTjXG+SMHn5WdKtHT+HYYCkrj7Aw=;
        b=tXjNpVTDZtADpB+aK9OYvgQVA4rKWd/WcwhgPNFwqTMzws3eRx6vFFEML4PulK4oIE
         CV3IWgDHuKK3TpwQnFC8Flt4+s1VCQ7bkVVuqn8z8nBxyIezi5Ye8EzDCIcDy7cgy1UF
         5DpYw1HrEGt7/vIOao6ZP+NUkx3n2rNaCNkn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ck1H6EPmM8gsvRouvJCL4LnbxkvegJNYIDmLZYjbbNif3q6QcHnFqKi9eGgrvmd7mz
         //09eC7RdVRIPyjyQI3adUJjBlzD5IcXqYiRFTRNjm6CQOBD+KxSUXUIk9A7qyR4DIUo
         VMD+uLKGno6Alh0K7vZ532+VVZczSSx7xXb9c=
Received: by 10.68.54.102 with SMTP id i6mr2987119pbp.111.1303543448518;
        Sat, 23 Apr 2011 00:24:08 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.24.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:24:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171961>

tweak branch

tweak branch
---
 Documentation/git-test.txt |    2 ++
 git-conditions-lib.sh      |   12 ++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-test.txt b/Documentation/git-test.txt
index 501725c..ea54d20 100644
--- a/Documentation/git-test.txt
+++ b/Documentation/git-test.txt
@@ -76,6 +76,8 @@ CONDITIONS
         Tests if a rebase is (not) in progress.
 '--detached'|'--not-detached'::
 	Tests if the head is (not) detached.
+'--branch-exists'|'--not-branch-exists branch'::
+        Tests if the specified branch does (not) exist.				    
 
 EXTENDING THE CONDITION LIBRARY
 -------------------------------
diff --git a/git-conditions-lib.sh b/git-conditions-lib.sh
index 34de896..5d7a7f8 100644
--- a/git-conditions-lib.sh
+++ b/git-conditions-lib.sh
@@ -75,5 +75,17 @@ check_detached_0()
 	fi
 }
 
+check_branch_exists_1()
+{
+	symbolic=$(git rev-parse --quiet --symbolic-full-name --verify "$1")
+ 	if test "${symbolic#refs/heads/}" != "${symbolic}"
+	then
+		echo "Branch '$1' exists."
+	else
+		echo "Branch '$1' does not exist."
+		false
+	fi
+}
+
 
 fi
-- 
1.7.5.rc1.23.g7f622
