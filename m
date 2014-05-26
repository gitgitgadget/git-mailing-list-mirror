From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 15/15] transport-helper.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 00:33:56 +0900
Message-ID: <1401118436-66090-16-git-send-email-modocache@gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 26 17:35:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wowvr-0005bS-WC
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 17:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbaEZPfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 11:35:15 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:62177 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbaEZPfI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 11:35:08 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so7852642pbc.15
        for <git@vger.kernel.org>; Mon, 26 May 2014 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OIFbyY29YC72TuJ+RHvc9OKTFUPT1XnQDRnPvjGk5P8=;
        b=uTSzy5zx4QRnkIlE/QAuTalMhJfwF+on6/4PR6D7Zzl1MuTMigcpKN44HU5w9oUUZ5
         oG1oAy3BInnK7OPDPRM6vol5r9p0d3+2kRccGfLSDNUkb9//er34rhUImb5P+xmCEweC
         xE0utL/AAQxyoMX6azJwfmGj5SCx+KsIds+CjU/hqlb0S3bONeHNsuiBRsf8ZRtbmtx3
         AnHwiLT3IM3K96bhIkQZmdEIfIE72CsbpwEcPSz8N0ASovtYrDdC1gRFy1RJgDlp9FgP
         CbVh26bWq/HP5j0J+882NgTUVHSEW+L1nAMyL70UL+mr5NxrW7iGjHvNW1Kjrpg3DcVj
         5mGg==
X-Received: by 10.66.227.33 with SMTP id rx1mr28127412pac.133.1401118508141;
        Mon, 26 May 2014 08:35:08 -0700 (PDT)
Received: from localhost.localdomain (p3080-ipbf5805marunouchi.tokyo.ocn.ne.jp. [60.46.42.80])
        by mx.google.com with ESMTPSA id mt1sm18850446pbb.31.2014.05.26.08.35.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 08:35:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.543.gc8042da
In-Reply-To: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250102>

xcalloc takes two arguments: the number of elements and their size.
transport_helper_init passes the arguments in reverse order, passing the
size of a helper_data*, followed by the number to allocate. Rearrgange
them so they are in the correct order.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index ad72fbd..cf48913 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1002,7 +1002,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 
 int transport_helper_init(struct transport *transport, const char *name)
 {
-	struct helper_data *data = xcalloc(sizeof(*data), 1);
+	struct helper_data *data = xcalloc(1, sizeof(*data));
 	data->name = name;
 
 	if (getenv("GIT_TRANSPORT_HELPER_DEBUG"))
-- 
2.0.0.rc1.543.gc8042da
