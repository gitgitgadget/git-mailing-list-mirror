From: Lars Vogel <lars.vogel@gmail.com>
Subject: [PATCH] Use "working tree" instead of "working directory" for git status
Date: Thu,  9 Jun 2016 20:19:30 +0200
Message-ID: <1465496370-11664-1-git-send-email-Lars.Vogel@vogella.com>
Cc: Lars Vogel <Lars.Vogel@vogella.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 20:21:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB4ZX-0004dg-MF
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 20:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932907AbcFISUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 14:20:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34047 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249AbcFISUS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 14:20:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id n184so12658644wmn.1
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 11:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3BOaM2gtFQcP51vforMBe06mj6tSRpZYV24NoZ+SfHo=;
        b=Tdk++jhdOnnSrlThAJoPFNIseCSueY7PmaWr4K46j5BS35IiXD5SGtfwnvlhM8iK4i
         JDkMRXyxmNOkH1E7/S7DKpNrD03Y9y2QFDMEWyT+zi0z50vzqp7hrbWWQGN6Cho2nIDW
         2I6E+16cchoq9XzOcWjb3XaXhZrapv+EOY8jVmarSwrboxmnGhK7uyOxZWZAZP4zi/ZI
         1LpftNdAELbP7LbY+ROGYSa1etMynJdg3/qj1IFZdwGs5Qely6arteb/Z22SkLPv67if
         nTe7pR8O5BUmxhxDdZo7ZeRxCqQ7bqI+0H0HJYO1FOwquN9OYZSwnON/y8XiE7i+57n+
         R51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3BOaM2gtFQcP51vforMBe06mj6tSRpZYV24NoZ+SfHo=;
        b=IMfEBcTcG/OPVgpVpRTOHiOutdT3EdRPGt8imSWeoVf2wjsMHXrBMBMUBzrDsERdN1
         hd9gI/9TyUd8wJUJMKHMEfGV5pxbENA5j7l7zsbJNsuCE9Ne5wcUqKq6ckb/8aP6pVv0
         Xity6TggohBWqgtoto0EnqilvDwrjqLF4rD7ljbyYVDels36ZSx+MbVgwsdt+nMxqF0D
         CpRgnzBEfpRCx903dUrnWqAA6C0T27VqFWht4YXUqDPF60H3qFPjDOY2lAP4h0mtPeH1
         XOqZ5AkBJ6FHDewMxZMX91TYPQzarryW/rRZyYE+DhBW1H/LFFvo8D9MQ15046aIU4z5
         bYQA==
X-Gm-Message-State: ALyK8tJa6rVvAzE2LeN5zzSMi83lEkfVVZ/gI6lJzyfny7yBfgBJLwJlsI1CHk/Kx9d6aA==
X-Received: by 10.194.123.170 with SMTP id mb10mr10888633wjb.39.1465496416372;
        Thu, 09 Jun 2016 11:20:16 -0700 (PDT)
Received: from Frodo.railnet.train ([88.128.80.6])
        by smtp.gmail.com with ESMTPSA id y6sm31570051wmy.8.2016.06.09.11.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Jun 2016 11:20:14 -0700 (PDT)
X-Google-Original-From: Lars Vogel <Lars.Vogel@vogella.com>
X-Mailer: git-send-email 2.8.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296912>

Working directory can be easily confused with the current directory.
In one of my patches I already updated the usage of working directory
with working tree for the man page but I noticed that git status also
uses this incorrect term.

Signed-off-by: Lars Vogel <Lars.Vogel@vogella.com>
---
 wt-status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 4f27bd6..4ce4e35 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1554,7 +1554,7 @@ void wt_status_print(struct wt_status *s)
 			else
 				printf(_("nothing to commit\n"));
 		} else
-			printf(_("nothing to commit, working directory clean\n"));
+			printf(_("nothing to commit, working tree clean\n"));
 	}
 }
 
-- 
2.8.1
