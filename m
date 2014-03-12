From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: [PATCH v2 1/2] fsck.c: Change the type of fsck_ident()'s first argument
Date: Thu, 13 Mar 2014 02:51:29 +0800
Message-ID: <1394650290-3750-2-git-send-email-yshuiv7@gmail.com>
References: <1394650290-3750-1-git-send-email-yshuiv7@gmail.com>
Cc: Yuxuan Shui <yshuiv7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 19:51:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNoFv-0007ID-Tg
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 19:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbaCLSvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 14:51:46 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:43451 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbaCLSvp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 14:51:45 -0400
Received: by mail-pb0-f42.google.com with SMTP id rr13so1497125pbb.29
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 11:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1LqjKRQKiw82pteiwln1Wj/uO7LxtC1R3StCdDuzRE4=;
        b=rLWmXRCGsASSOkgUzLRabqSyKA1+nfnm65pamVqENVeApe9xw9+ldCSotHHRW5njlK
         XR4kAp/Y3ButEohvkAnNAUCcRT+F7r2TPbrelNcOaOvMag1y4+gsgK9MvEBYqhgM1M4w
         1oWg/2FvZfmvd8/icIAi9kQy6fgohUFkRG14xX1w32qfKaf+EBtO20xO1o2rfqKEnvG2
         AfaLeKG2LBVKgWtSopnDrGbXXV2RBu/TYbTwZa2ZzpGU3uDoZjzc3sSnMigLRXJqoxO7
         8uMhPNFTjgi0qBQPkOCtx4KPVuOI0dUoLUZPd3S8zipT1SQAYrOBQZflVPO/AU9/ErFN
         ll2g==
X-Received: by 10.68.66.1 with SMTP id b1mr6914874pbt.43.1394650304668;
        Wed, 12 Mar 2014 11:51:44 -0700 (PDT)
Received: from localhost.localdomain ([123.151.32.162])
        by mx.google.com with ESMTPSA id tu3sm25142283pab.1.2014.03.12.11.51.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Mar 2014 11:51:44 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394650290-3750-1-git-send-email-yshuiv7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243962>

Since fsck_ident doesn't change the content of **ident, the type of
ident could be const char **.

This change is required to rewrite fsck_commit() to use skip_prefix().

Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
---
 fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index 99c0497..1789c34 100644
--- a/fsck.c
+++ b/fsck.c
@@ -243,7 +243,7 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 	return retval;
 }
 
-static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
+static int fsck_ident(const char **ident, struct object *obj, fsck_error error_func)
 {
 	if (**ident == '<')
 		return error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before email");
-- 
1.9.0
