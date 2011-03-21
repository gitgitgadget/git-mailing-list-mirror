From: Elijah Newren <newren@gmail.com>
Subject: [WIP PATCH 02/10] Reminder to fix o->call_depth handling in conflict_rename_rename_1to2
Date: Mon, 21 Mar 2011 12:30:56 -0600
Message-ID: <1300732264-9638-3-git-send-email-newren@gmail.com>
References: <1300732264-9638-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 19:24:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1jmj-0000RW-Ma
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118Ab1CUSYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 14:24:42 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62978 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab1CUSYk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 14:24:40 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so5291756vws.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=inbSeeqZIUCu/d8x181daMiOMT0Zl3c1zdYY6yiEnhw=;
        b=DiRH04a2yotW1XkwHiePLtkJ5g+F4NZ5cdk/EWSNqWH5uWN1JYAp1qdW8xUcq/XwCm
         /zU5LTbxTocitoaAcZBJwIoapHp1pOUIby6/w5o0vx3P8nR26yBzpsUcIokkaRup4t7/
         /hHTuLnHfdAY50CH7VaCeq1jUojY/0G3dT2SU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=x0Rmv2VMHun3ZE4LPgl4xe++msU0rfuv/tNcpmolo2aH/oDtaF+UDK/tI5r6i2RPKD
         t84i2UwjyWiXPArf0nVxTVyQPg86HJd3K7ivetNtbBS+uFrxZ+apLTK95ulyUNk8tb06
         J3y9tD10SVn62nXmhW/fPOva7dWxecsS5GNr0=
Received: by 10.220.125.74 with SMTP id x10mr1299175vcr.61.1300731880349;
        Mon, 21 Mar 2011 11:24:40 -0700 (PDT)
Received: from localhost6.localdomain6 (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id b6sm1507291vci.0.2011.03.21.11.24.38
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 11:24:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.120.g38a18
In-Reply-To: <1300732264-9638-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169624>

---
 merge-recursive.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 6dc74dc..8d28a54 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -908,6 +908,10 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		       ren2_dst, branch1, dst_name2);
 	}
 	if (o->call_depth) {
+		/*
+		 * FIXME: This is bogus.  dst_nameX are not in cache in
+		 * case of D/F conflict.
+		 */
 		remove_file_from_cache(dst_name1);
 		remove_file_from_cache(dst_name2);
 		/*
-- 
1.7.4
