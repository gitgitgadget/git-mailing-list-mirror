From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/3] do not search functions for patch ID
Date: Sun, 19 Sep 2010 11:59:28 +0200
Message-ID: <1284890369-4136-3-git-send-email-drizzd@aon.at>
References: <1284890369-4136-1-git-send-email-drizzd@aon.at>
Cc: gitster@pobox.com, Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 19 11:59:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxGgN-0005V2-Ca
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 11:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281Ab0ISJ7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 05:59:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44960 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab0ISJ7U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 05:59:20 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3701062bwz.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 02:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uCD7NWSOhk1OPpNQLKkbOTX8cKahIk2D4z3hDFykDLY=;
        b=E6YqSydULlLxb87DC05w7npVsDnggV3qrHmjhky0AGR20Gk9mhHAAtGN7heNRQwF80
         cY/QxH6ooU5fFQBckq4+eMmlu7ksz8SvAEQn04MmJU4V3PVzOr9/N42UQKAM3hm6nd1Q
         Md6/nPJlhJJluvXzTId7tytaa5Q6KmGij969Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=i6Ci9P0Jg2AykQu27Tki1VKxROAwmvZzUJFfxqgM87RU64eNsctkIG/YjzIlt/RYKr
         R6r9QdNezldEM8LG0JqNlfhcy5eq7takuR6NmZDH5wcZWbmDJgkOlYdtPvcqH93SmXsI
         Zbvxr+9cCIddwS9Ni4/lwksBBVfjzHokSQkHs=
Received: by 10.204.120.79 with SMTP id c15mr5427738bkr.188.1284890359933;
        Sun, 19 Sep 2010 02:59:19 -0700 (PDT)
Received: from darc.lan (p549A467A.dip.t-dialin.net [84.154.70.122])
        by mx.google.com with ESMTPS id x19sm5447155bkv.21.2010.09.19.02.59.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 02:59:19 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OxGgn-00015W-QP; Sun, 19 Sep 2010 12:00:05 +0200
X-Mailer: git-send-email 1.7.1.571.gba4d01
In-Reply-To: <1284890369-4136-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156490>

Visual aids, such as the function name in the hunk
header, are not necessary for the purposes of
computing a patch ID.

This is a performance optimization.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 9a5c77c..454b9c9 100644
--- a/diff.c
+++ b/diff.c
@@ -3865,7 +3865,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 
 		xpp.flags = 0;
 		xecfg.ctxlen = 3;
-		xecfg.flags = XDL_EMIT_FUNCNAMES;
+		xecfg.flags = 0;
 		xdi_diff_outf(&mf1, &mf2, patch_id_consume, &data,
 			      &xpp, &xecfg);
 	}
-- 
1.7.1.571.gba4d01
