From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v5 8/8] detached-stash: update Documentation
Date: Wed, 18 Aug 2010 23:48:53 +1000
Message-ID: <1282139333-5150-5-git-send-email-jon.seymour@gmail.com>
References: <1282139333-5150-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 15:49:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olj1a-0005IP-72
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 15:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040Ab0HRNtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 09:49:33 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62298 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021Ab0HRNtc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 09:49:32 -0400
Received: by pzk26 with SMTP id 26so232431pzk.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 06:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2uGj6dysB/4OtU11oAPQp7WRGlzQ1SG1KtKMvrX4NaU=;
        b=XiJ5vMQ7bn1DHqaoqQhXMaTCqB0E26dlsVDWyKnroUu7VCWgsC9rvgag9kG4xRVQac
         4p7YMkoLsmqZm+nj6OKw7KI5ANLL0lm8B9CzLVrnV31+AXTV4DaPJE7wLUb+XG6oSWUT
         BLo2pRhx7+FHPsZWG/T5fhsdg7J6xPSKP9yiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=s6bExYJ8PNG1W7rctML4dT1bk65/t1dJlrUTcoSiStGpthmdeRVDy0bNRSsCrE9j/8
         AcEGbJcCTaDrZADcrJewqvQLvDAkeV2ztDTssrvHVzkQMTK/us6YS2uh4k9yLUgmVrtE
         179j3uQuYEajyB0e6oAwj5cpJmBqWnjpzk09o=
Received: by 10.114.208.20 with SMTP id f20mr9620748wag.69.1282139372339;
        Wed, 18 Aug 2010 06:49:32 -0700 (PDT)
Received: from localhost.localdomain (203-158-55-26.dyn.iinet.net.au [203.158.55.26])
        by mx.google.com with ESMTPS id s5sm538803wak.12.2010.08.18.06.49.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 06:49:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.88.g3dbe5
In-Reply-To: <1282139333-5150-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153854>

Update the documentation to indicate that git stash branch only attempts
to drop the specified stash if it looks like stash reference.

Also changed the synopsis to more clearly indicate which commands require
a stash entry reference as opposed to merely a stash-like commit.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-stash.txt |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 473889a..8728f7a 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -104,18 +104,22 @@ tree's changes, but also the index's ones. However, this can fail, when you
 have conflicts (which are stored in the index, where you therefore can no
 longer apply the changes as they were originally).
 +
-When no `<stash>` is given, `stash@\{0}` is assumed.
+When no `<stash>` is given, `stash@\{0}` is assumed, otherwise `<stash>` must
+be a reference of the form `stash@\{<revision>}`.
 
 apply [--index] [-q|--quiet] [<stash>]::
 
-	Like `pop`, but do not remove the state from the stash list.
+	Like `pop`, but do not remove the state from the stash list. Unlike `pop`,
+	`<stash>` may be any commit that looks like a commit created by
+	`stash save` or `stash create`.
 
 branch <branchname> [<stash>]::
 
 	Creates and checks out a new branch named `<branchname>` starting from
 	the commit at which the `<stash>` was originally created, applies the
-	changes recorded in `<stash>` to the new working tree and index, then
-	drops the `<stash>` if that completes successfully. When no `<stash>`
+	changes recorded in `<stash>` to the new working tree and index.
+	If that succeeds, and `<stash>` is a reference of the form
+	`stash@{<revision>}`, it then drops the `<stash>`. When no `<stash>`
 	is given, applies the latest one.
 +
 This is useful if the branch on which you ran `git stash save` has
@@ -132,7 +136,9 @@ clear::
 drop [-q|--quiet] [<stash>]::
 
 	Remove a single stashed state from the stash list. When no `<stash>`
-	is given, it removes the latest one. i.e. `stash@\{0}`
+	is given, it removes the latest one. i.e. `stash@\{0}`, otherwise
+	`<stash>` must a valid stash log reference of the form
+	`stash@\{<revision>}`.
 
 create::
 
-- 
1.7.2.1.95.g4fabf
