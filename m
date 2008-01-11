From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-clone - Set remotes.default config variable
Date: Thu, 10 Jan 2008 22:29:48 -0500
Message-ID: <1200022189-2400-4-git-send-email-mlevedahl@gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
 <1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
 <1200022189-2400-3-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 11 04:31:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDAbj-0004i8-Jg
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 04:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762AbYAKDaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 22:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755890AbYAKDaB
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 22:30:01 -0500
Received: from hs-out-0708.google.com ([64.233.178.241]:3059 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753762AbYAKD36 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 22:29:58 -0500
Received: by hs-out-2122.google.com with SMTP id 54so862397hsz.5
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 19:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5IdsK0eQ7CtrYolqpF/DCI09pr2X2Jjp1sWujeMQ/pE=;
        b=hRMp4lkfhIG3OfbpKzSAnSIg2lQV9X/7JyENceTefCk1HgnUuKnloYnawyfq2vsQarZNt5rFLQQSF4HUfTgbMqteReiY7P6HaXMZFQUAJfvBwmUFp69Fw/6fciJpiraSJiWHWFNVC2sybxkGep3ijvD8GBN0k/0h1r2N3cLRbuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hLEIe2wFTpQl/9pd4N/0wjs5tibvl4SeSNSWxbCzAkVWrjNeKI4j79cGdJ1Ygawb1vPhMiUo6TCzok5qrHgpy7QeSqfG09Lqz/b2xq33Z/Al0SD9Q/dQH0IYKM98XJyCzy2dW0dagL/aZoAIGmEn2HowDlMmPH5XwgeTxe+/GPg=
Received: by 10.150.211.19 with SMTP id j19mr1127214ybg.10.1200022198432;
        Thu, 10 Jan 2008 19:29:58 -0800 (PST)
Received: from localhost.localdomain ( [71.163.17.196])
        by mx.google.com with ESMTPS id h8sm4363197wxd.39.2008.01.10.19.29.56
        (version=SSLv3 cipher=OTHER);
        Thu, 10 Jan 2008 19:29:57 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc2.99.g3ef7-dirty
In-Reply-To: <1200022189-2400-3-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70120>

This records the users choice of default remote name (by default "origin")
as given by the -o option.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/git-clone.txt |    3 ++-
 git-clone.sh                |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index fdccbd4..7fd3ea1 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -95,7 +95,8 @@ OPTIONS
 --origin <name>::
 -o <name>::
 	Instead of using the remote name 'origin' to keep track
-	of the upstream repository, use <name> instead.
+	of the upstream repository, use <name> instead. The name
+        is recorded in the  remotes.default config variable.
 
 --upload-pack <upload-pack>::
 -u <upload-pack>::
diff --git a/git-clone.sh b/git-clone.sh
index b4e858c..efbcee2 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -242,6 +242,7 @@ fi &&
 export GIT_DIR &&
 GIT_CONFIG="$GIT_DIR/config" git-init $quiet ${template+"$template"} || usage
 
+git config remotes.default $origin
 if test -n "$bare"
 then
 	GIT_CONFIG="$GIT_DIR/config" git config core.bare true
-- 
1.5.4.rc2.99.g3ef7-dirty
