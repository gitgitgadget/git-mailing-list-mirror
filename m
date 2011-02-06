From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 20/31] rebase: show consistent conflict resolution hint
Date: Sun,  6 Feb 2011 13:43:49 -0500
Message-ID: <1297017841-20678-21-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9eC-0005ZO-Rc
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717Ab1BFSqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:24 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58585 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab1BFSqW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:22 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so3014077qwa.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=dgfX/BcoN/T54lZ+UhcUqzo1Y4MGYqFUI5DBRiXckYQ=;
        b=A+SSTBE/lDjSRJ7ZKOYH9R8/pxrR1/nOOJSyelNHHxTTCw0PdfE2iAJD1cEyKE1RkJ
         3qwRdrDxah1De70ebxDfuklzgwQGHPkOZ8vVqAQ8k0jf6q9ghQ5TU8gFgO+4fI5FIsf5
         /6XqH9J8vd9sMe8VnQAiFspLkKJFQRM+EZOBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cyYhwsAiQzWBwdO3ULif5nLq8w3JBia5ZGk/Zhq6EbKnqj4B8UdVk74+nGtftAYlvt
         WeL4SvIjARRIbEFxV3iKcX8v9eUwWVr2wqtDoGQHzMjNY26prQa0Ortw2mEJW5S0hGhf
         HwmgbJJ3k+VqIXFfxr5oZczTbtdycawgCKegk=
Received: by 10.224.28.213 with SMTP id n21mr13421449qac.64.1297017982043;
        Sun, 06 Feb 2011 10:46:22 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:21 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166178>

When rebase stops due to conflict, interactive rebase currently
displays a different hint to the user than non-interactive rebase
does. Use the same message for both types of rebase.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
Should we include the "mark the corrected paths with 'git add
<paths>'" part?


 git-rebase--interactive.sh |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f94f057..0499f9e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -81,9 +81,7 @@ amend="$dotest"/amend
 rewritten_list="$dotest"/rewritten-list
 rewritten_pending="$dotest"/rewritten-pending
 
-GIT_CHERRY_PICK_HELP="\
-hint: after resolving the conflicts, mark the corrected paths
-hint: with 'git add <paths>' and run 'git rebase --continue'"
+GIT_CHERRY_PICK_HELP="$resolvemsg"
 export GIT_CHERRY_PICK_HELP
 
 warn () {
-- 
1.7.4.rc2.33.g8a14f
