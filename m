From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 10/15] imap-send.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 00:33:51 +0900
Message-ID: <1401118436-66090-11-git-send-email-modocache@gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 26 17:35:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wowvf-0005AU-4u
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 17:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbaEZPfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 11:35:01 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:59060 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991AbaEZPfA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 11:35:00 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp16so7853967pbb.20
        for <git@vger.kernel.org>; Mon, 26 May 2014 08:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=liiL94B+ZWpAPDaONdIkTF6rQf8job2F6x393k8IwPw=;
        b=v6wLuWD8sa3PDqi8XVGBMutyzL1qnDoNvTu9ZIA6Vi4aT9qlFPYqIljU+gz/7qKuU2
         b4fhd2M/sbaVm5Jr2FWibL705QOB9aHeFFaL1yzSC0ImH//oHIdTn8xlX+PFm2rs7mRr
         l+ruBYCMRZvghYaJ+zN655TaQ4os07L20w290u/Pc2RFgaKFQgFyaqkcMcQyxb+yMqyj
         GUqa/JR+Lr7eNqTaTKHAdE9jhZXYu2sjc6tIiD1d/ZBSkILvigUGAN5Fpizxm5YhizHV
         u2M0cq9F/Hh/rco9je9WSpLKq6NQuPTp6FTXuSQXOqmDQueQinDZxNvvynjogX3s0Hja
         0hrA==
X-Received: by 10.66.163.135 with SMTP id yi7mr28365198pab.150.1401118499576;
        Mon, 26 May 2014 08:34:59 -0700 (PDT)
Received: from localhost.localdomain (p3080-ipbf5805marunouchi.tokyo.ocn.ne.jp. [60.46.42.80])
        by mx.google.com with ESMTPSA id mt1sm18850446pbb.31.2014.05.26.08.34.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 08:34:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.543.gc8042da
In-Reply-To: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250098>

xcalloc takes two arguments: the number of elements and their size.
imap_open_store passes the arguments in reverse order, passing the
size of an imap_store*, followed by the number to allocate.
Rearrgange them so they are in the correct order.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 0bc6f7f..45230e1 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -951,7 +951,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc)
 	char *arg, *rsp;
 	int s = -1, preauth;
 
-	ctx = xcalloc(sizeof(*ctx), 1);
+	ctx = xcalloc(1, sizeof(*ctx));
 
 	ctx->imap = imap = xcalloc(sizeof(*imap), 1);
 	imap->buf.sock.fd[0] = imap->buf.sock.fd[1] = -1;
-- 
2.0.0.rc1.543.gc8042da
