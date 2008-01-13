From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-clone - Set remotes.origin config variable
Date: Sun, 13 Jan 2008 11:27:09 -0500
Message-ID: <1200241631-3300-3-git-send-email-mlevedahl@gmail.com>
References: <478A3284.1000102@gmail.com>
 <1200241631-3300-1-git-send-email-mlevedahl@gmail.com>
 <1200241631-3300-2-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.org
X-From: git-owner@vger.kernel.org Sun Jan 13 17:27:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE5gb-00016Z-J2
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 17:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbYAMQ1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 11:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752990AbYAMQ1W
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 11:27:22 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:2842 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbYAMQ1U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 11:27:20 -0500
Received: by wx-out-0506.google.com with SMTP id h31so976652wxd.4
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 08:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=e/fwJiitKRaWvC9DvywL6nk+o/p+3uWzlX+PDRtFuOM=;
        b=T9OVee/OMjlmts69xIf8MwQc/vdQux4G1sicRcAMxPpq3Ay8FXs8jk/NICOn0SP29u2+SGIkV1mN0t1FwbD5LEhAimVwGtnrF5FS//QgrP6ztULGKT+fRmSgCtqZjwmRMJilBcseSzUiCkgyFzEAoeTV+a7us7RmeniAQ2/u73s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AQ8uZjUZrvHW2f7fexcAqtByn997HylY1YfbChHSd1cQj+Dhpu0q1MEOUvypJZHeTgcvkcut1nBx8g0rmkoQSMJw8FagyWT91X/flvzkAhatoimbP9amnAe14kMzr87+AXX/1kz5+/cqJ9VUlmum526EGkk0TeGFqZe6ZYCBYLU=
Received: by 10.70.12.2 with SMTP id 2mr3759525wxl.16.1200241639462;
        Sun, 13 Jan 2008 08:27:19 -0800 (PST)
Received: from localhost.localdomain ( [71.163.17.196])
        by mx.google.com with ESMTPS id i18sm8324960wxd.0.2008.01.13.08.27.17
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Jan 2008 08:27:18 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc3.14.gc50f
In-Reply-To: <1200241631-3300-2-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70392>

This records the users choice of default remote name (by default "origin")
as given by the -o option.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/git-clone.txt |    3 ++-
 git-clone.sh                |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index fdccbd4..6c15fa4 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -95,7 +95,8 @@ OPTIONS
 --origin <name>::
 -o <name>::
 	Instead of using the remote name 'origin' to keep track
-	of the upstream repository, use <name> instead.
+	of the upstream repository, use <name> instead. The name
+	is recorded in the core.origin config variable.
 
 --upload-pack <upload-pack>::
 -u <upload-pack>::
diff --git a/git-clone.sh b/git-clone.sh
index b4e858c..7208d68 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -242,6 +242,7 @@ fi &&
 export GIT_DIR &&
 GIT_CONFIG="$GIT_DIR/config" git-init $quiet ${template+"$template"} || usage
 
+git config core.origin $origin
 if test -n "$bare"
 then
 	GIT_CONFIG="$GIT_DIR/config" git config core.bare true
-- 
1.5.4.rc3.14.gc50f
