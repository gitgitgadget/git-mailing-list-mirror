From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] revert: Hide '-r' option in default usage
Date: Sun, 10 Apr 2011 21:09:14 +0530
Message-ID: <1302449954-15353-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 10 17:40:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8wkZ-0005iE-3d
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 17:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608Ab1DJPkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 11:40:24 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64524 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257Ab1DJPkX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 11:40:23 -0400
Received: by iyb14 with SMTP id 14so4868744iyb.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 08:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:message-id:x-mailer;
        bh=cIsUmbYwU9yO47elscMNi3HE2vw1JMqoJ/se/QNjyQc=;
        b=pTHdDYOENnW24yUhVBM9pJKVTIPsz8xpjfbWCB2Hx9ex5a5PzQCmBf2lrCXXJg4aIM
         8yrqpB03AjpjQ4aWAPTiQDAjCpdTec64rKMS4iCVYvt2oL4v53cq2qE5/lQQF/wDFloZ
         Or8dnqZMeRJSxP0g4F17cB9E6egYEKDKk7IiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=DBo2bTnZ8Qp6DKlac2TocD9X/bJmvo9JKONyM+TlRjo7BgERqyaYHYiGzhH9HKvduq
         vBG5OiprzbgPOPz5rT05mPEOm+UJjSSxXpisnZfbSMq51nVB7ogIht7/bvseG8R6jnFh
         /hGMAejVbW7UX3aqYVoCTK/7DMzJYc0uiesNg=
Received: by 10.231.65.75 with SMTP id h11mr4365000ibi.149.1302450022593;
        Sun, 10 Apr 2011 08:40:22 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id i26sm2418997iby.7.2011.04.10.08.40.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 08:40:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171267>

Since the '-r' command-line option is a no-op provided only for
backward compatiblity, don't advertise it in the default usage.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
This is a minor detail I noticed while working on the sequencer.

 builtin/revert.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 2bb13eb..f697e66 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -76,7 +76,8 @@ static void parse_args(int argc, const char **argv)
 	struct option options[] = {
 		OPT_BOOLEAN('n', "no-commit", &no_commit, "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &edit, "edit the commit message"),
-		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
+		{ OPTION_BOOLEAN, 'r', NULL, &noop, NULL, "no-op (backward compatibility)",
+		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 0 },
 		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
-- 
1.7.4.rc1.7.g2cf08.dirty
