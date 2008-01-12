From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-clone - Set remotes.origin config variable
Date: Sat, 12 Jan 2008 00:54:32 -0500
Message-ID: <1200117273-3524-3-git-send-email-mlevedahl@gmail.com>
References: <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <1200117273-3524-1-git-send-email-mlevedahl@gmail.com>
 <1200117273-3524-2-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 12 06:55:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDZKl-0003KA-UB
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 06:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758582AbYALFym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 00:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757702AbYALFym
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 00:54:42 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:2935 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbYALFyk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 00:54:40 -0500
Received: by an-out-0708.google.com with SMTP id d31so299153and.103
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 21:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0V6VIatI5QXULJD0Dfcy5EyOT/hj4I1rB8TsUVabNdE=;
        b=AQ8i/0cGLPV+ugbyXoUfMMJTBy/9Zu64ISWtI+okDpOB6KEo8opy16uNZA6Q7qV+2ngQdlsFGhcyB8yy8njP5ozzIGDq3V96Eq4BkGinMdw0h5GXtFSlsE4u2Wjypy8J8toRDlhKuv/r3BhGexgRrUzt4f/nQhYvgOXpD87zWWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AY1k4SaESVsCVoI4qBoqMIMCkKhsSajIDVmTFaKYvDYU7lE74Lez0F4WCytd7xZYiWfdM5TIqSxz3EMyABT1Hy8kT1jB7B+kpmYcU04W7HUxOvyLpZZUUaiAb6A73e76e/QP+V449TrtoumFIBd+rVN1k0hDQkLskX4HqBlxHXg=
Received: by 10.100.167.3 with SMTP id p3mr8592176ane.69.1200117279859;
        Fri, 11 Jan 2008 21:54:39 -0800 (PST)
Received: from localhost.localdomain ( [71.163.17.196])
        by mx.google.com with ESMTPS id c37sm6069027ana.9.2008.01.11.21.54.38
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Jan 2008 21:54:38 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc2.98.g1f3d5
In-Reply-To: <1200117273-3524-2-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70269>

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
1.5.4.rc2.98.g1f3d5
