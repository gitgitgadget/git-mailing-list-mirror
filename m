From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v6 07/16] When debug==1, start fast-import with "--stats" instead of "--quiet"
Date: Wed, 22 Aug 2012 21:15:52 +0200
Message-ID: <1345662961-9587-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345662961-9587-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 21:16:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4GQ8-0001Ql-Lk
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 21:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048Ab2HVTQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 15:16:48 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59577 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965012Ab2HVTQn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 15:16:43 -0400
Received: by bkwj10 with SMTP id j10so449742bkw.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 12:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SHYBBb9eJVC6ubjii3SRbkaozBrchg0+ExQYaICg+UU=;
        b=uvlaz4b14B2Uu5t9AOzcmSmOkXAmY2+84aqwdECV3ebLj5Vz4+w9T4zY3MtZkob7xC
         mO8W5oTVMTnDNLeiWYUOQsaV1woWes2W35rub2eUGXJXWp/WC8DS6muaXQDVeKJt+xYs
         +EJ6w0krhj4I/dD9aWRvVwgHywCrw8/Kmc5ENHO8w5o8VMGmgt4Pe3hKHHj/8c0CjpYD
         B1jdRrb39vL0fpsuffA0jn8jSXQU8ty24NAictmjOHt+iE+ZlcqvPqvlHcW+3hWHHvHV
         lt50iRlMQlG52JyXdFspRkBQn6SOVBjkbDT8OjL4drrM7DnmSQc6UBoe+6AWqaw2Y68m
         cpqA==
Received: by 10.204.154.214 with SMTP id p22mr7124144bkw.111.1345663002137;
        Wed, 22 Aug 2012 12:16:42 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id ht18sm3346763bkc.16.2012.08.22.12.16.40
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Aug 2012 12:16:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345662961-9587-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204070>

fast-import prints statistics that could be interesting to the
developer of remote helpers.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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
