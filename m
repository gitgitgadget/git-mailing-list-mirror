From: struggleyb.nku@gmail.com
Subject: [PATCH] diff.c: fix a graph output bug
Date: Thu,  8 Jul 2010 23:12:34 +0800
Message-ID: <4c35eb6c.21078e0a.1455.ffffe42d@mx.google.com>
References: <y>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 08 17:15:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWsoj-0007ci-Mr
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 17:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906Ab0GHPO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 11:14:59 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45527 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791Ab0GHPO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 11:14:58 -0400
Received: by pwi5 with SMTP id 5so354516pwi.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=o+NcZznMQ2CU32yxWuLn2h9GDqXA153L9V7v4Wxvzas=;
        b=e8ArV4O5h3WYsOIt/4JMrkoREObrCLiqWdc/zaCccAa1BZ9nC0TiPhPK9Ih2ugTVIN
         zTYDN8mTy8Lblp55nMmaSWcv86HrMBP6JKHunpxs5T6pxj0Ij/Z65Y1DZf2ox6C1+eOf
         OdrC13S8Le3LPmmwT8PjcjC4NOT+E9lAEE/2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MSs9+j3ZrXHodLSXTBoWg2B2t+yctEXK4vAirtKehtb1ibb3nJEvRb4/gRv+OfeqSu
         WOQE0TH4A2q7/c1uJJeG90gmMkqivh69o5IkN9H/rFHvrmobVe0sXYEM5hAd4MItzvnP
         COw3xZcVMmoRSv9OfQ+rimgU4cXTeTM2NRyDI=
Received: by 10.142.194.15 with SMTP id r15mr5731780wff.274.1278602094231;
        Thu, 08 Jul 2010 08:14:54 -0700 (PDT)
Received: from localhost.localdomain ([122.70.45.190])
        by mx.google.com with ESMTPS id 33sm8658373wfg.21.2010.07.08.08.14.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 08:14:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc1.33.gf29bc
In-Reply-To: <y>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150582>

From: Bo Yang <struggleyb.nku@gmail.com>

Ouput the line_prefix ahead of color sequence.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 diff.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 3aa695d..17873f3 100644
--- a/diff.c
+++ b/diff.c
@@ -2627,8 +2627,7 @@ static void fill_metainfo(struct strbuf *msg,
 			    (!fill_mmfile(&mf, two) && diff_filespec_is_binary(two)))
 				abbrev = 40;
 		}
-		strbuf_addf(msg, "%s%sindex %s..", set,
-			    line_prefix,
+		strbuf_addf(msg, "%s%sindex %s..", line_prefix, set,
 			    find_unique_abbrev(one->sha1, abbrev));
 		strbuf_addstr(msg, find_unique_abbrev(two->sha1, abbrev));
 		if (one->mode == two->mode)
-- 
1.7.0.2.273.gc2413.dirty
