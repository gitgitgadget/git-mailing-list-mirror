From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 04/12] git submodule update: Announce outcome of submodule operation to stderr
Date: Thu, 15 Oct 2015 18:52:05 -0700
Message-ID: <1444960333-16003-5-git-send-email-sbeller@google.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 03:52:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmuCN-0002W9-4x
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 03:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbbJPBwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 21:52:24 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35682 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbbJPBwW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 21:52:22 -0400
Received: by pabws5 with SMTP id ws5so6575544pab.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 18:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cF3SbcVa0wxkhXqL1+dWz+EQriNVlqT7dOjPwMzAhWs=;
        b=nmxbm94JKGCCrtAhW0xVeXY8cPG9dFSQfhsUX4u0odx7aAGY+dn+lyPmpn5QkqPtwI
         PgNb5u/YBS9DNkRFu7xbfu+DW2yfX4EzpC468gzyX2S2rHTbjtuJ9XVsZS6mh7MisIyM
         Q5LKDAb6Th+uMbCA1dRrmJ5XOvXfWO6stL6xP94GiekxvNhimfeaWVYSW8Pv9iyTE/NK
         lvQVp/vDCWFk8n4Hj6rRTyoR8FwoWqDjpKWbnJNjFz7FjgutuIJXcWtrfdntQvkpFMjk
         nSWTxbT6yBM+1FdWkAfu0TDjmsXgVKhocubm94AdWuiftdq8KuYoHkGtd49aj2IoYITH
         aLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cF3SbcVa0wxkhXqL1+dWz+EQriNVlqT7dOjPwMzAhWs=;
        b=dtrlWZ95RQ9j7m2NunCguuV1v78cM94X8X+/EZNtERFdQF9O8bU7nFlbw/t1ep2vY+
         HMeoyXNENHDpzlNWwcZKpW3/phySBkz3VGzPBP2OSU50sdyPGucO/0H5ilcxvZhVtdra
         XIorI2ZXsXq1Pm0I582EOtlbpZTo2BmF9HCKWXrF5ch5FY3nkXxl3gZK3C3tR95kfCMB
         DzTwYMjkAyVsbqvfRU7MbzCenq3DHprPqS9+Avl3ehKToth9lO/zPHBItfDZFKlAK/R3
         8/1LLLiNEE2z8qq+qEC1K8UJc6XrrUV+MmuU7nJSobY6y4Kna7J3QpT5YTOZ09Rpm8et
         ux3A==
X-Gm-Message-State: ALoCoQkRr2Y78gfaqNUisIqhD5kPUaImvJ2l7Ktk9ooQZ+zeo4GjBZnYautayrg2ftb/wQhI6slj
X-Received: by 10.68.111.129 with SMTP id ii1mr13513748pbb.1.1444960341002;
        Thu, 15 Oct 2015 18:52:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8909:dd69:53c0:2cb6])
        by smtp.gmail.com with ESMTPSA id qk7sm12158207pbb.80.2015.10.15.18.52.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 18:52:20 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.277.gfdc362b.dirty
In-Reply-To: <1444960333-16003-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279725>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh            |  2 +-
 t/t7406-submodule-update.sh | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 56a0524..bb8b2c7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -780,7 +780,7 @@ Maybe you want to use 'update --init'?")"
 
 			if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
 			then
-				say "$say_msg"
+				say >&2 "$say_msg"
 			elif test -n "$must_die_on_failure"
 			then
 				die_with_status 2 "$die_msg"
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index dda3929..f65b81c 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -111,8 +111,8 @@ test_expect_success 'submodule update does not fetch already present commits' '
 	(cd super &&
 	  git submodule update > ../actual 2> ../actual.err
 	) &&
-	test_i18ncmp expected actual &&
-	! test -s actual.err
+	test_i18ncmp expected actual.err &&
+	! test -s actual
 '
 
 test_expect_success 'submodule update should fail due to local changes' '
@@ -702,8 +702,8 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir re
 	rm -rf super_update_r2 &&
 	git clone super_update_r super_update_r2 &&
 	(cd super_update_r2 &&
-	 git submodule update --init --recursive >actual &&
-	 test_i18ngrep "Submodule path .submodule/subsubmodule.: checked out" actual &&
+	 git submodule update --init --recursive 2>actual.err &&
+	 test_i18ngrep "Submodule path .submodule/subsubmodule.: checked out" actual.err &&
 	 (cd submodule/subsubmodule &&
 	  git log > ../../expected
 	 ) &&
@@ -770,8 +770,8 @@ test_expect_success 'submodule update --recursive drops module name before recur
 	 (cd deeper/submodule/subsubmodule &&
 	  git checkout HEAD^
 	 ) &&
-	 git submodule update --recursive deeper/submodule >actual &&
-	 test_i18ngrep "Submodule path .deeper/submodule/subsubmodule.: checked out" actual
+	 git submodule update --recursive deeper/submodule 2>actual.err &&
+	 test_i18ngrep "Submodule path .deeper/submodule/subsubmodule.: checked out" actual.err
 	)
 '
 test_done
-- 
2.5.0.277.gfdc362b.dirty
