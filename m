From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 3/3] doc/remote-helpers: document the gitdir feature
Date: Tue, 12 Jul 2011 21:10:28 +0600
Message-ID: <1310483428-29833-4-git-send-email-divanorama@gmail.com>
References: <1310483428-29833-1-git-send-email-divanorama@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johan Herland <johan@herland.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 17:10:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgebe-0005YJ-1G
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 17:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308Ab1GLPKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 11:10:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52328 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274Ab1GLPKS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 11:10:18 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so4115732bwd.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 08:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=A6mWsCOwMGXWutPNgoHlQg6F07kAZp1s4LjwhB4lnm8=;
        b=wjeS/CYEJbieP4baeCW8cUrgtmHfvbwWFS0vzwJWaZjJxAoljBiquBIaEFI3nwVrd9
         olVCo1SJ7YiM05xWxR1rsb6e9DL9HUHSU2XmyLCO8b+qnidIFoulBQ7vHWIo2PXtClle
         EUjSSX4qaIXoAouPbPUGwb7+qgE/bPRg3GaTY=
Received: by 10.205.65.9 with SMTP id xk9mr6944bkb.388.1310483417239;
        Tue, 12 Jul 2011 08:10:17 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id u32sm1398878bkk.49.2011.07.12.08.10.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 08:10:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310483428-29833-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176944>

The gitdir capability is recognized by git and can be used to tell
the helper where the .git directory is. But it is not mentioned in
the documentation.

Document the gitdir feature. Upon reading this capability
transport-helper sends out "gitdir path_to_dot_git" command to the
helper. Which looks exactly like sending a command. So let's call
this a command.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 Documentation/git-remote-helpers.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 58f6ad4..a16a5e5 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -159,6 +159,14 @@ Supported if the helper has the "import" capability.
 +
 Supported if the helper has the "connect" capability.
 
+'gitdir' <path>::
+	Tells helper the location of current repository .git
+	directory. The path is absolute. The command is issued
+	immediately after "gitdir" capability line is read by
+	the caller.
++
+Supported if the helper has the "gitdir" capability.
+
 If a fatal error occurs, the program writes the error message to
 stderr and exits. The caller should expect that a suitable error
 message has been printed if the child closes the connection without
@@ -175,6 +183,7 @@ CAPABILITIES
 'push'::
 'import'::
 'connect'::
+'gitdir'::
 	This helper supports the corresponding command with the same name.
 
 'refspec' 'spec'::
@@ -187,6 +196,12 @@ CAPABILITIES
 	all, it must cover all refs reported by the list command; if
 	it is not used, it is effectively "{asterisk}:{asterisk}"
 
+'gitdir'::
+	The helper wants to know .git directory location. The gitdir
+	command is sent immediately after reading this capability.
+	The helper can read it immediately too or it can proceed with
+	reporting other capabilities and read it as a next command.
+
 REF LIST ATTRIBUTES
 -------------------
 
-- 
1.7.3.4
