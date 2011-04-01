From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH 1/2] blame: add --abbrev command line option
Date: Fri,  1 Apr 2011 10:54:55 +0900
Message-ID: <1301622896-5836-1-git-send-email-namhyung@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 03:55:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Ta2-00089g-8H
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 03:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930Ab1DABzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 21:55:04 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63019 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab1DABzD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 21:55:03 -0400
Received: by iyb14 with SMTP id 14so2980946iyb.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 18:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=ZSLiNFlBXAFA/2FFX2kxzqQfyD2FodsAzIYvrKb7tX8=;
        b=iFrsuXk2VXmXZ0QikH4qcprj98Hn+vsK5M8fF67TZY2zC7vUSBLv4mmT5Ec7tPWej/
         fdKlvc7lzI/W3S//v1eWA+VSMDeMN9llh+GoXHSsTx57VeVIUo6joJ0H5A0NkDjkt00S
         FtMfkn5lCeZjDaNy4XVlER9pVFYNpuaNuzdeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=b6deV4Z3T1VXmveGbGqnduRGUY1WkiW2eMYQIZh5KjpfqStdxMFGE/9YZORymaDU4U
         +N2UY7dkeBE02u3871Ph6ahpNgLWcf+NeH/p+ag96TnpKeTbW7/aaS3jgswxOjJqM/v/
         BHMXUCRWWOVRgg0BQ5ZaOFa82n8K0sdADBgB4=
Received: by 10.42.176.201 with SMTP id bf9mr825293icb.224.1301622902826;
        Thu, 31 Mar 2011 18:55:02 -0700 (PDT)
Received: from localhost.localdomain ([118.176.72.144])
        by mx.google.com with ESMTPS id i26sm1101359iby.58.2011.03.31.18.54.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 Mar 2011 18:55:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170549>

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 builtin/blame.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index f6b03f7..253b480 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -41,6 +41,7 @@ static int reverse;
 static int blank_boundary;
 static int incremental;
 static int xdl_opts;
+static int abbrev = 8;
 
 static enum date_mode blame_date_mode = DATE_ISO8601;
 static size_t blame_date_width;
@@ -1670,7 +1671,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	cp = nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
-		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? 40 : 8;
+		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? 40 : abbrev;
 
 		if (suspect->commit->object.flags & UNINTERESTING) {
 			if (blank_boundary)
@@ -2310,6 +2311,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'C', NULL, &opt, "score", "Find line copies within and across files", PARSE_OPT_OPTARG, blame_copy_callback },
 		{ OPTION_CALLBACK, 'M', NULL, &opt, "score", "Find line movements within and across files", PARSE_OPT_OPTARG, blame_move_callback },
 		OPT_CALLBACK('L', NULL, &bottomtop, "n,m", "Process only line range n,m, counting from 1", blame_bottomtop_callback),
+		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
 
-- 
1.7.4
