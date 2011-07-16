From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 01/23] transport-helper: fix minor leak in push_refs_with_export
Date: Sat, 16 Jul 2011 15:03:21 +0200
Message-ID: <1310821424-4750-2-git-send-email-srabbelier@gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:04:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4Xt-00056J-Lq
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700Ab1GPNEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:04:25 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57335 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446Ab1GPNEY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:04:24 -0400
Received: by ewy4 with SMTP id 4so996062ewy.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=s6qB4yHcZ7K2r66RT+mUv0+wT6LNYxUSBdck1tl3Rnc=;
        b=qfFrKF3CKPTpnQ+2bZLvD/nuYVvxs4adgwiYLFh4fgazOYL6F0kvZU/LXF6jfJXKmS
         NsqB/7OTEuND71WHF8g1rLNiwNsK9hhYEsDkRx5d3czczhO2E6veJoSCAFTocIICfkfu
         A04J76eNMgKd9Nui+xjf8lN9zWJvxh0UEycYg=
Received: by 10.14.96.16 with SMTP id q16mr1651699eef.35.1310821462848;
        Sat, 16 Jul 2011 06:04:22 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.04.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:04:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177254>

From: Jeff King <peff@peff.net>


Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged

 transport-helper.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 660147f..b560b64 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -728,6 +728,7 @@ static int push_refs_with_export(struct transport *transport,
 			strbuf_addf(&buf, "^%s", private);
 			string_list_append(&revlist_args, strbuf_detach(&buf, NULL));
 		}
+		free(private);
 
 		string_list_append(&revlist_args, ref->name);
 
-- 
1.7.5.1.292.g728120
