From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: [PATCH 1/2] fsck.c: Change the type of fsck_ident()'s first argument
Date: Thu, 13 Mar 2014 02:18:23 +0800
Message-ID: <1394648304-19159-2-git-send-email-yshuiv7@gmail.com>
References: <1394648304-19159-1-git-send-email-yshuiv7@gmail.com>
Cc: Yuxuan Shui <yshuiv7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 19:19:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNnkI-0001z8-2K
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 19:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbaCLSTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 14:19:08 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:59756 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbaCLSTH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 14:19:07 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so1397316pdi.5
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 11:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mV5ReNTc70E8R7aUnSZT4Vet1bRsyebLbBOvtuoxLl4=;
        b=u4cAKE++HCQtQ+22vpytWpmqajaC9vIjreQf05AtcE94bIZsHpmhao+DoVGwXfOxkB
         ljLql5dwi5Rc+0SB9aBfvPxJTryTR2c7ldMdjsnQVRwKwS1PRhHuB3E61nn1hPxZPqpC
         Sy4sak1y95jEDjMIq6AUAQ1LoiWH+wO85UcwfSma1CS4AX9p4nXW30ok5R9c8H65WyEs
         4T/mw6dg4VFp1JD151CdnuULHQqqCA/UodcWzMeKZAvzQUrZHY2sZv1p/bT5Rleudyb+
         zPeab8r/V4m3ZS3BfC5PnXicARqZ/wmiZQBsCfMVAr+X0rbzaYzvWOn/dZe4iT5nV/IX
         DiiA==
X-Received: by 10.66.136.103 with SMTP id pz7mr6877950pab.140.1394648347049;
        Wed, 12 Mar 2014 11:19:07 -0700 (PDT)
Received: from localhost.localdomain ([123.151.32.162])
        by mx.google.com with ESMTPSA id pi1sm24592117pac.14.2014.03.12.11.19.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Mar 2014 11:19:06 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394648304-19159-1-git-send-email-yshuiv7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243953>

Since fsck_ident doesn't change the content of **ident, the type of
ident could be const char **.

This change is required to rewrite fsck_commit() to use skip_prefix().
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
