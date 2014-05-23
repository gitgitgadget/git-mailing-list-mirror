From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] git-remote-testgit.sh: cleaned up the logic for setting the refspec variable
Date: Fri, 23 May 2014 09:17:42 -0700
Message-ID: <1400861862-6963-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 18:17:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnsAI-0001LJ-1x
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 18:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbaEWQRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 12:17:46 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:57190 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbaEWQRp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 12:17:45 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so4369753pbc.15
        for <git@vger.kernel.org>; Fri, 23 May 2014 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tUJuvSgxx7Pqiuw9ui8brLYiXN4qnWdXc2h/417jsbw=;
        b=kmk3vJ/Ytm1C0yQIZwVwOge4OLkpbvB6XTaDyKW5ikLZ86eyknW6aQECQnrwRheiyZ
         Uzzz87JUirRTMtcOjEEqICtM8FDJqxh/9HzyNTjnkZlTk1v+1y9rE1VwgHVoV/0H0XPf
         zjfGD4bVLOCkjDGbZagZMWhMyVZTgE8GlDDfOrLTqEK/cvNDsU+GmiWkajP/0RqCtfHX
         91QLhzc2LFVJsuiD2hm4hiPlVSR2WFDcnfQ9V7vXepM8MabyZH8LwQPp0d7ZI2A2Dkr+
         KJyCQ5KVqFkZENQiUJ43YvBN4gJpv7Z94h/jaDQYIjWHIiQOLje9jnsFyCRK6gksZHhs
         5efg==
X-Received: by 10.66.102.39 with SMTP id fl7mr7180347pab.43.1400861865466;
        Fri, 23 May 2014 09:17:45 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id zv3sm16151465pab.20.2014.05.23.09.17.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 May 2014 09:17:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249994>

This patch makes the code more readable for setting
the refspec variable

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 git-remote-testgit.sh |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
index 1c006a0..fb8a003 100755
--- a/git-remote-testgit.sh
+++ b/git-remote-testgit.sh
@@ -4,18 +4,20 @@
 alias=$1
 url=$2
 
+if test -z "${GIT_REMOTE_TESTGIT_REFSPEC-notEmpty}"
+then
+	# only if it is explicitly set to an empty string...
+	prefix=refs
+else
+	prefix="refs/testgit/$alias"
+fi
 dir="$GIT_DIR/testgit/$alias"
-prefix="refs/testgit/$alias"
-
 default_refspec="refs/heads/*:${prefix}/heads/*"
-
 refspec="${GIT_REMOTE_TESTGIT_REFSPEC-$default_refspec}"
-
-test -z "$refspec" && prefix="refs"
+force=
 
 export GIT_DIR="$url/.git"
 
-force=
 
 mkdir -p "$dir"
 
-- 
1.7.10.4
