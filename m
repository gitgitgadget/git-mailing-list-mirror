From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/9] grep: add --staged option
Date: Thu, 29 Aug 2013 13:14:33 -0500
Message-ID: <1377800080-5309-3-git-send-email-felipe.contreras@gmail.com>
References: <20130829180129.GA4880@nysa>
 <1377800080-5309-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 20:19:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6p2-0004XT-0Z
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756487Ab3H2STw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:19:52 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:50683 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756449Ab3H2STv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:19:51 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so852831obc.26
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UIdvBSn4Is8qAm3qcPwEf3WNN7J0O/sZOcL2cL44RP4=;
        b=sC41OGW7yjIrFT9qIb2FB4ElE1KI5y9NiGY/LhsipvOIyTXAdHMwn/6tSTIEOj1hvf
         Bl9uGupzNEssi28v2WBkvetGRtQ7Zv8gpGrOfg8IgUryiJf5V2Fh7l6pLlazWeT2gd5A
         KGej5bQsPfiHgvdf1Gk0ySaPEbigpIIC3IdycWEgc1Vdm5/6DeYr7Pic90du1ZJOzbuQ
         r826J4iplWiwT0oHQ/4QSvYoOYuIqFyk8K3HxPoQExTNClYMH2nuGScTc9DtpkVqHGYd
         wL2XoE2X++pzFJypEQZV+ac6epP5ayItsWKrhV2Qnln92vPa3nKbF0fl7E74LiSmmAC1
         qiUg==
X-Received: by 10.182.70.102 with SMTP id l6mr3511081obu.78.1377800390961;
        Thu, 29 Aug 2013 11:19:50 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rl1sm33806757oeb.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:19:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377800080-5309-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233311>

Synonym for --cached.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-grep.txt | 5 ++++-
 builtin/grep.c             | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 8497aa4..9f7899c 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -25,7 +25,7 @@ SYNOPSIS
 	   [-W | --function-context]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
-	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
+	   [ [--[no-]exclude-standard] [--cached | --staged | --no-index | --untracked] | <tree>...]
 	   [--] [<pathspec>...]
 
 DESCRIPTION
@@ -60,6 +60,9 @@ OPTIONS
 	Instead of searching tracked files in the working tree, search
 	blobs registered in the index file.
 
+--staged::
+	Synonym for `--cached`.
+
 --no-index::
 	Search files in the current directory that is not managed by Git.
 
diff --git a/builtin/grep.c b/builtin/grep.c
index d3b3b1d..b953911 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -640,6 +640,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOLEAN(0, "cached", &cached,
 			N_("search in index instead of in the work tree")),
+		OPT_BOOLEAN(0, "staged", &cached,
+			N_("search in index instead of in the work tree")),
 		OPT_NEGBIT(0, "no-index", &use_index,
 			 N_("find in contents not managed by git"), 1),
 		OPT_BOOLEAN(0, "untracked", &untracked,
-- 
1.8.4-fc
