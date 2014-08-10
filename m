From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH 1/2] remote.c: don't leak the base branch name in format_tracking_info
Date: Sun, 10 Aug 2014 15:57:55 +0200
Message-ID: <1407679076-20300-1-git-send-email-stefanbeller@gmail.com>
Cc: Stefan Beller <stefanbeller@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 10 15:58:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGTdc-0001Gz-U1
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 15:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbaHJN6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 09:58:04 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:57802 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbaHJN6C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 09:58:02 -0400
Received: by mail-wi0-f170.google.com with SMTP id f8so4443029wiw.1
        for <git@vger.kernel.org>; Sun, 10 Aug 2014 06:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/a4xIy/bARUEXxXzkygOJa/sVNUUjESiYXJ0+yASr/8=;
        b=sWUUQZpJvPtpLjXUJiXWqqQL/9HC0ULAhMUwSc5zYj8CJdOLBK9PJ4Q0YpcBICTC26
         N9klfGgid9bxRoUBKr89OcmnFezXCeySnXxI4i6/oPN3/6Im+6nruiWwaUaghTd1RwEm
         0ydDk7DrGR/gz6UTBwlAtVozP5jviq7QNLG/acUn1Dio3T9otIJggJNFR/qGMZ5mrBDY
         7hjOGt6CgTbtS6uhXq2eCZ8zcD8dDcIhvv8Hzbp2K8ktVuw+8xwoPzup9pLmu/fpjznu
         7y+iT1MgDLBmf7QvFdQRBjJb+HrQecd64oAeFQC2OpDY8okFqqZiZX9pw3ZfJpZwUhyn
         Qvmg==
X-Received: by 10.194.20.230 with SMTP id q6mr47281502wje.43.1407679080387;
        Sun, 10 Aug 2014 06:58:00 -0700 (PDT)
Received: from localhost (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id h3sm32283562wjn.10.2014.08.10.06.57.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 10 Aug 2014 06:57:59 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255092>

Found by scan.coverity.com (Id: 1127809)

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---
 remote.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/remote.c b/remote.c
index 3d6c86a..2c1458f 100644
--- a/remote.c
+++ b/remote.c
@@ -1983,6 +1983,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 			strbuf_addf(sb,
 				_("  (use \"git pull\" to merge the remote branch into yours)\n"));
 	}
+	free(base);
 	return 1;
 }
 
-- 
2.1.0.rc2
