From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v6 9/9] detached-stash: update Documentation
Date: Sat, 21 Aug 2010 14:09:04 +1000
Message-ID: <1282363744-4924-10-git-send-email-jon.seymour@gmail.com>
References: <1282363744-4924-1-git-send-email-jon.seymour@gmail.com>
Cc: j6t@kdbg.org, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 06:10:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmfPO-0006qB-8R
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 06:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408Ab0HUEKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 00:10:13 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37067 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab0HUEKM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 00:10:12 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1481994pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 21:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8gqpvOx0V2OTSe4IraBeT8/ciamFdYZ8SnuV+VsQIOY=;
        b=EFYXpVO12wYn3MRWw044fyczQpLzpNkDiPUTumrZhv8TTWpi0REoB/ENlRdR8jDufW
         LL2KVPfKgyrdjYeZAA55Y8URcb0H2v86uix656QDn3TVziUfkUu7G1NwVtuXJ3DEIk53
         e1XfXVbyuVFKYZm6OBrFqTQiXM/5w9uRcSh94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AnfXGjGeio3Xz4MF5LCVZ7+jjTnUT7Z4pdTEask/Wi/9xevj4zH3pU+SZ7ON4l8gKv
         mFxIxdmmaGElQTEVsPgt1ZySFPmy6202TvbOluJKDE9tFOuhAqs8hHuaml4x5bYb6a9A
         65uHbLxjtJoZIX5MJRC4LlnYC0yvvxBVH8gPI=
Received: by 10.142.223.14 with SMTP id v14mr1723414wfg.238.1282363812066;
        Fri, 20 Aug 2010 21:10:12 -0700 (PDT)
Received: from localhost.localdomain (124-169-98-91.dyn.iinet.net.au [124.169.98.91])
        by mx.google.com with ESMTPS id z1sm4208931wfd.3.2010.08.20.21.10.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 21:10:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.110.g34f32
In-Reply-To: <1282363744-4924-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154103>

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
1.7.2.1.110.g34f32
