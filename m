From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 12/15] pack-revindex.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 00:33:53 +0900
Message-ID: <1401118436-66090-13-git-send-email-modocache@gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 26 17:35:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Woww0-0005n4-Hx
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 17:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbaEZPf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 11:35:26 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:53869 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034AbaEZPfE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 11:35:04 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp16so7846502pbb.34
        for <git@vger.kernel.org>; Mon, 26 May 2014 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dTQLztDjiWsOoUDTw7IP63+DRzQLRnKFD9WcAgsNeQs=;
        b=gjBaclC1I5pew0R2k02BXZoUXMbP39X0qoq4J2ikTnR1LFqFIQXSqUk5QqukbU03W/
         bQHeTIrksHgBRcqfYX1upHRCwt/gj5wpnHV7O4HGFeCmFGHMOm6z1HXZ8T2OCnHF98fw
         B8Zt5oCCnTujFh2N5tTq8VFDzOIfU4VzksrekUoWhgri1clHWrvY0piNIwrXnvyvh8Pe
         7JfgD6u5cl8a7ro/8moq1kIctd+p6+HuzTqdwwp5AX8PrMYTmyGbkmCnTbvKcEXu57n7
         t8KNjzd7ss7aYeNH2jJR0GzSOe6I8EHJ8iH/KvWoGvPSV5/9B+ror/TR0525OSL8rkSK
         /zEg==
X-Received: by 10.66.161.69 with SMTP id xq5mr28788569pab.62.1401118503988;
        Mon, 26 May 2014 08:35:03 -0700 (PDT)
Received: from localhost.localdomain (p3080-ipbf5805marunouchi.tokyo.ocn.ne.jp. [60.46.42.80])
        by mx.google.com with ESMTPSA id mt1sm18850446pbb.31.2014.05.26.08.35.00
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 08:35:02 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.543.gc8042da
In-Reply-To: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250104>

xcalloc takes two arguments: the number of elements and their size.
init_pack_revindex passes the arguments in reverse order, passing the
size of a pack_revindex, followed by the number to allocate.
Rearrgange them so they are in the correct order.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 pack-revindex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index b4d2b35..f84979b 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -50,7 +50,7 @@ static void init_pack_revindex(void)
 	if (!num)
 		return;
 	pack_revindex_hashsz = num * 11;
-	pack_revindex = xcalloc(sizeof(*pack_revindex), pack_revindex_hashsz);
+	pack_revindex = xcalloc(pack_revindex_hashsz, sizeof(*pack_revindex));
 	for (p = packed_git; p; p = p->next) {
 		num = pack_revindex_ix(p);
 		num = - 1 - num;
-- 
2.0.0.rc1.543.gc8042da
