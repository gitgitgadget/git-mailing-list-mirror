From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/9] mailmap: debug: fix out-of-order fprintf() arguments
Date: Mon, 15 Jul 2013 02:54:09 -0400
Message-ID: <1373871253-96480-6-git-send-email-sunshine@sunshineco.com>
References: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 08:55:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UycgT-00043H-QH
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 08:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133Ab3GOGyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 02:54:49 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35490 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3GOGys (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 02:54:48 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so17916149iee.20
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 23:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=fT7MsLBW/C/JPlyoIMQUHqiNdBMD3K1fi9KPLX5Sm2s=;
        b=ZeQahkqD/2RjN1fMP1jKLRpYCp3PBetD60IA6895i4ibUna1LK0I1d/nOSGpEBtQrC
         CiX92dVBpTmJz7BuJ8A+r+Mmb7IL/YnYwAY7+vt0QWGOUBHrv+UdrsWaNnsPtXIhmEEY
         tw9w4Oeq4vAS0RMb6v0HivfyvS+ipnnxMXH96EXiwB8MO5xRZFjNdEL6aFaX0lFrxRS8
         a7PC/fUNTqqaYLbXs25jPLTN2/7f0ePQm2U8dKJZuND1a/lJu3pk684vc0FAz95Zq4hh
         oK0xq6fwgQ27+Op2WfGd9FFrN93JH0OK+cVzPssoBNe/hPsaTQ94xfax+quvxGw/SrDN
         mz3A==
X-Received: by 10.42.109.15 with SMTP id j15mr16876121icp.116.1373871287555;
        Sun, 14 Jul 2013 23:54:47 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id y9sm16781487iga.9.2013.07.14.23.54.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 23:54:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.804.g0da7a53
In-Reply-To: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230431>

Resolve segmentation fault due to arguments passed in wrong order.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 mailmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mailmap.c b/mailmap.c
index a7e92db..0516354 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -309,7 +309,7 @@ int map_user(struct string_list *map,
 	struct mailmap_entry *me;
 
 	debug_mm("map_user: map '%.*s' <%.*s>\n",
-		 *name, *namelen, *emaillen, *email);
+		 *namelen, *name, *emaillen, *email);
 
 	item = lookup_prefix(map, *email, *emaillen);
 	if (item != NULL) {
-- 
1.8.3.2.804.g0da7a53
