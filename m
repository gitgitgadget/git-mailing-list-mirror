From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 28/31] rebase -m: don't print exit code 2 when merge fails
Date: Tue, 28 Dec 2010 10:30:45 +0100
Message-ID: <1293528648-21873-29-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYr-0005Wr-Tz
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab0L1Pda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:33:30 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43383 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab0L1PdM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:33:12 -0500
Received: by mail-qy0-f174.google.com with SMTP id 19so11285887qyj.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rvL6qMET3qpnzOHGTNqPculCjCf09XWtTDvaD9GTR8o=;
        b=UQafngsDaxkHeeG1q7bZPc4tSbAIAtUe0iI2wiu6kTJSiznA388XWf8Mcyz05cy7lZ
         RW4TZMg1quf+HeQmu5SFVp3wENpV3LmVZMItnp80ZpFSJBZv2ytPpYNujIaaio7dzmoI
         rENs4RgTz8tFB2LFpYaRHAXnNZLNZzXUjPywA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=snjzD6Dj67rrqshoA1KnNeMDVd7FYPGrrET7YzKSeiEXSP9P9BhWoDWH6VsG2aSHyJ
         DQ+vUcvjwTP5guiImDP4RfjFuEAXrvweb8bstYvXoLM5WJO36WG1b5UhVoO1ymdDH6io
         cfLCrVCP10ihYx4t2OeZKjvcwrkU0OgElQSeg=
Received: by 10.229.189.4 with SMTP id dc4mr12272198qcb.173.1293550391642;
        Tue, 28 Dec 2010 07:33:11 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.33.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:33:11 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164259>

When the merge strategy fails, a message suggesting the user to try
another strategy is displayed. Remove the "$rv" (which is always equal
to "2" in this case) from that message.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--merge.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 705d2f5..4ea3ca7 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -78,7 +78,7 @@ call_merge () {
 		die "$RESOLVEMSG"
 		;;
 	2)
-		echo "Strategy: $rv $strategy failed, try another" 1>&2
+		echo "Strategy: $strategy failed, try another" 1>&2
 		die "$RESOLVEMSG"
 		;;
 	*)
-- 
1.7.3.2.864.gbbb96
