From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/3] show-branch: Fix die message in parse_reflog_param()
Date: Sun, 17 May 2009 03:47:02 -0700
Message-ID: <1242557224-8411-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 17 12:47:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5dtp-0005YO-1g
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 12:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837AbZEQKrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 06:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755666AbZEQKrK
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 06:47:10 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:45672 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbZEQKrG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 06:47:06 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1644212wfd.4
        for <git@vger.kernel.org>; Sun, 17 May 2009 03:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=yuA6kiYutoW6lQBrYs3dPVQ3m6XXX3zbTuprE14eoEI=;
        b=uwdGeUi1L/y9oRbsBvVWlxLp6bpt/VWF3CMfU74RfMGJinIxdwQKHzhQnFfM+B2XmX
         xFUMgOwBSKwgElaMOnX1brzvjAKATcE4WszoBgXzAq0iVjw06CqaKKUYiYYEX6MVDxyP
         L4JH7mbnliTN3M1/UHjeN07aFP0cVBkmlMuXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=M4Ptr8WXc/G2oyh8t+hML+RkE/sBDYsLUH0zuTkNdEdu19MT5r+h+/ZwQsDBeF0KTY
         XlRLOpOWfjI1Y3iXtmMENH8gafV04knEeKYBeaPayfNx8bHHjyr2A3NfvXBnxY1wlLjr
         zkWviyB32v+C4YfEfRgl6URZb9XzWmc+8OrA4=
Received: by 10.142.155.8 with SMTP id c8mr1631992wfe.324.1242557227567;
        Sun, 17 May 2009 03:47:07 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 32sm6193086wfa.13.2009.05.17.03.47.05
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 17 May 2009 03:47:07 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 17 May 2009 03:47:04 -0700
X-Mailer: git-send-email 1.6.3.1.30.g55524
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119389>

Commit 76a44c5 (show-branch --reflog: show the reflog message at the
top, 2007-01-19) introduced parse_reflog_param(). The die() call was
incorrectly passed arg + 9, when it should have been passed arg.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin-show-branch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 828e6f8..c3afabb 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -576,7 +576,7 @@ static void parse_reflog_param(const char *arg, int *cnt, const char **base)
 	if (*ep == ',')
 		*base = ep + 1;
 	else if (*ep)
-		die("unrecognized reflog param '%s'", arg + 9);
+		die("unrecognized reflog param '%s'", arg);
 	else
 		*base = NULL;
 	if (*cnt <= 0)
-- 
1.6.3.1.30.g55524
