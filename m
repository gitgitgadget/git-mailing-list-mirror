From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v8 07/16] When debug==1, start fast-import with "--stats" instead of "--quiet"
Date: Wed, 19 Sep 2012 17:21:21 +0200
Message-ID: <1348068090-31988-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1348068090-31988-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 17:22:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEM77-00061k-33
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 17:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869Ab2ISPWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 11:22:42 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:32832 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755847Ab2ISPWj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 11:22:39 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so597401bkw.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Iw4Tgw0valp/uDHwz7yJFhdTAct2nDwohzcKOcLg2vI=;
        b=kInQQOD3c6xD4BwGAGLai1En0NX2cbaRevDLmh5JmYPJHycyLiTdWARXqaJOaGVHgB
         wos4TnKNjc7KKVQaqsEd2jELpJnB7Bh+9g1wcChIj7dtCvYU8PFeWo3semwE9nIZnNUX
         Lc7PzS+AxG66t2uMnxdu9ZaRlWYGxNqWiNWB2327YipLv8mMSWtyidVRNjyIhdmILm8g
         W79+mR+SELzcRCqcmLivbw4S9KDPHasVsVTH0ONVMzE41usyUZ9Tq/4mvXdA7y+WTGs2
         crs1Efk6cdZUycM2TTp7AoguOSO1q+RA4Hd2yayJQcazdXv6R9Rx3b8qa3leh5dsLmeD
         UcYA==
Received: by 10.204.152.19 with SMTP id e19mr1483709bkw.8.1348068157568;
        Wed, 19 Sep 2012 08:22:37 -0700 (PDT)
Received: from flobuntu.lan (91-115-94-56.adsl.highway.telekom.at. [91.115.94.56])
        by mx.google.com with ESMTPS id d13sm1570686bkw.12.2012.09.19.08.22.35
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 08:22:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1348068090-31988-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205934>

fast-import prints statistics that could be interesting to the
developer of remote helpers.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
no diff

 transport-helper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 3523f1f..4713b69 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -385,7 +385,7 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 	memset(fastimport, 0, sizeof(*fastimport));
 	fastimport->in = helper->out;
 	argv_array_push(&argv, "fast-import");
-	argv_array_push(&argv, "--quiet");
+	argv_array_push(&argv, debug ? "--stats" : "--quiet");
 
 	if (data->bidi_import) {
 		cat_blob_fd = xdup(helper->in);
-- 
1.7.9.5
