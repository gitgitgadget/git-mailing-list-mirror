From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] bash completion: add basic support for git-reflog
Date: Sun, 21 Nov 2010 01:32:48 +0800
Message-ID: <1290274368-3212-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 20 18:33:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJrJF-0005f5-LF
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 18:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569Ab0KTRdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 12:33:03 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53690 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549Ab0KTRdC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 12:33:02 -0500
Received: by pzk28 with SMTP id 28so1201426pzk.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 09:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=z78RkqM1NJojkp+PfYrOha/tfDC/rgBpsNMZQb/eaIc=;
        b=sNfIwRnAffLmi7+vE1EzS5Fh/4kowMhVrQ49FdSbJ7/EDb4EinWzTU42Ebxmp4wADI
         EivAFFL6eM/p9iwTw1qI4dwGrP9krUVjsVmIiu4YWyWrncomxIa/OzNl6kq2etZx2WxA
         wH9zYQB8r4bLz6YIpxW1+49rNVGEJFGsjheKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=LAYJVQUyXtUUSjz9hHNfWKO2l8sY5wTF65udDf8GXXJy9k1zDfRs2LNq7lA1aWuLgE
         FcG1oUy9aPIZka96MHkU2r9+Nx2Fqcr6DL3562iaquF6FKjhUU6wwgODR2++rVksmS6u
         8f/PUyHKCa0CcDYCsm6Ak1g/8AUFXnQEzXfwI=
Received: by 10.143.43.11 with SMTP id v11mr2969412wfj.388.1290274381339;
        Sat, 20 Nov 2010 09:33:01 -0800 (PST)
Received: from localhost.localdomain (cm69.zeta153.maxonline.com.sg [116.87.153.69])
        by mx.google.com with ESMTPS id y42sm3624773wfd.22.2010.11.20.09.32.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 09:33:00 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161829>

Add basic completion for the three subcommands - show, expire, delete.
Try completing refs for these too.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 contrib/completion/git-completion.bash |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f710469..4007ca1 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1632,6 +1632,22 @@ _git_rebase ()
 	__gitcomp "$(__git_refs)"
 }
 
+_git_reflog ()
+{
+	local SUB_CMDS=(show delete expire)
+	local cur="${COMP_WORDS[COMP_CWORD-1]}"
+
+	for val in ${SUB_CMDS[*]}; do
+		if [[ "$val" == "$cur" ]]; then
+			# this is a subcommand
+			__gitcomp "$(__git_refs)"
+			return
+		fi
+	done
+
+	__gitcomp "${SUB_CMDS[*]}"
+}
+
 __git_send_email_confirm_options="always never auto cc compose"
 __git_send_email_suppresscc_options="author self cc bodycc sob cccmd body all"
 
-- 
1.7.3.2.496.g9c54
