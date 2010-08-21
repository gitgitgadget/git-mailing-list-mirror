From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 3/5] fmt-merge-msg: Update fmt-merge-msg and merge-config documentation
Date: Sat, 21 Aug 2010 15:28:17 +0530
Message-ID: <1282384699-16477-4-git-send-email-artagnon@gmail.com>
References: <1282384699-16477-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 12:00:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omksc-0004zP-Rf
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 12:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815Ab0HUKAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 06:00:35 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39425 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab0HUKAd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 06:00:33 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so1588171pzk.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 03:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/SZg6PTFwbgmqTGdZuAUwpGMfDmuYul4d8lD/Rg4NVQ=;
        b=eAs4nTGR2JCOz6bPnvXUu3vi3jt/bEGg7OiGqvMwVZmtkjRHew2q9VhPR6PeDf3q4z
         6MiiI8Bp4z1yPam+3uu6IDYlKRgR9q3LJo5JBvuF2qJdIyvg32qVRTuL2g+hHWWPKOJy
         ji0lG5GYHnEA+QfVl/XDm+xI3HJLWTWMRiCJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=X0F1Ri7OTcAhnD1YPWuY5GkZWS8cAgHgMtSgFDxcieS+fvuvBohebyjpe39a8oZtxe
         dBb7LyqT4OCxXFFsMg3/giG04OTHh3IOz6zPQke/NkxvpENBP6+o2kis6nOBD6/Qpe0I
         3ZdXnRq1BGWVDvCdBnYGyb2m3q2cxNhlFL5dA=
Received: by 10.142.172.6 with SMTP id u6mr2138041wfe.52.1282384833026;
        Sat, 21 Aug 2010 03:00:33 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id b19sm4641270wff.7.2010.08.21.03.00.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 03:00:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282384699-16477-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154132>

Update the documentation of fmt-merge-msg and merge-config to reflect
the fact that `merge.log` can either be a boolean or integer option
now, instead of just a boolean.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt <at> viscovery.net>
Cc: Jonathan Nieder <jrnieder <at> gmail.com>
---
 Documentation/git-fmt-merge-msg.txt |   15 +++++++++------
 Documentation/merge-config.txt      |    8 ++++++--
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 302f56b..9499322 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -9,8 +9,8 @@ git-fmt-merge-msg - Produce a merge commit message
 SYNOPSIS
 --------
 [verse]
-'git fmt-merge-msg' [-m <message>] [--log | --no-log] <$GIT_DIR/FETCH_HEAD
-'git fmt-merge-msg' [-m <message>] [--log | --no-log] -F <file>
+'git fmt-merge-msg' [-m <message>] [--[no-]log[=<n>]] < $GIT_DIR/FETCH_HEAD
+'git fmt-merge-msg' [-m <message>] [--[no-]log[=<n>]] -F <file>
 
 DESCRIPTION
 -----------
@@ -24,10 +24,10 @@ automatically invoking 'git merge'.
 OPTIONS
 -------
 
---log::
+--log[=<n>]::
 	In addition to branch names, populate the log message with
-	one-line descriptions from the actual commits that are being
-	merged.
+	one-line descriptions from at most <n> actual commits that are
+	being merged. If omitted, <n> defaults to 20.
 
 --no-log::
 	Do not list one-line descriptions from the actual commits being
@@ -53,7 +53,10 @@ CONFIGURATION
 
 merge.log::
 	Whether to include summaries of merged commits in newly
-	merge commit messages. False by default.
+	created merge commit messages.  Optionally, an integer can be
+	used to specify how many merged commits to summarize (at
+	maxmium) in the merge message. Specifying "true" is equivalent
+	to specifying 20. Defaults to false.
 
 merge.summary::
 	Synonym to `merge.log`; this is deprecated and will be removed in
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index b72f533..f63f7cb 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -7,8 +7,12 @@ merge.conflictstyle::
 	marker and the original text before the `=======` marker.
 
 merge.log::
-	Whether to include summaries of merged commits in newly created
-	merge commit messages. False by default.
+	Whether to include summaries of merged commits in newly
+	created merge commit messages.  Optionally, an integer can be
+	used to specify how many merged commits to summarize (at
+	maxmium) in the merge message. Specifying "true" is equivalent
+	to specifying 20.  Defaults to false. See also
+	linkgit:git-fmt-merge-msg[1].
 
 merge.renameLimit::
 	The number of files to consider when performing rename detection
-- 
1.7.2.2.409.gdbb11.dirty
