From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] git.c: treat RUN_SETUP_GENTLY and RUN_SETUP as mutually exclusive
Date: Mon, 21 Apr 2014 17:47:56 -0700
Message-ID: <1398127676-12311-1-git-send-email-mcgrof@do-not-panic.com>
Cc: "Luis R. Rodriguez" <mcgrof@suse.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 02:48:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcOsf-00083f-60
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 02:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583AbaDVAsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 20:48:09 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:64205 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbaDVAsI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 20:48:08 -0400
Received: by mail-pa0-f42.google.com with SMTP id fb1so4338852pad.1
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 17:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=7V/cuj+/jy2cS0b0Hd8A9WrIPS5907AH1+H7jHje7fQ=;
        b=eRHZgqg6DDrjrrVAslNrz85tb6Z33gLUElV9EaXrBaPs/OpBFPjajtUqWZXp7/XYi0
         NzFhIyzIvpR0jBAN137RRhZnkrMGC08a36Sf6kf3Ysiwc8O/CYz+KojHgjFoiaPbzk19
         JTSh/QY9ArZ69oSX58qQ4EW8TuEe23CrSgV4Lrqv++gw8W/nJ4f2xc8BJ0425KbUGqy9
         vwQcUJxUHDKcWZ+H+yZeb8V/KmrU6PgkQV0YEbVT1Mk3Viuh9HwHrw8Z/2hnbNlQUi1J
         MzZdfnaIos6XbgRpjWronbUUBin+U4Itb97tTw2ejlCDRb9SUX8bZ6Zlqcebc+sqD5dM
         7I0A==
X-Received: by 10.66.148.98 with SMTP id tr2mr41087935pab.33.1398127687637;
        Mon, 21 Apr 2014 17:48:07 -0700 (PDT)
Received: from mcgrof@gmail.com (c-98-234-145-61.hsd1.ca.comcast.net. [98.234.145.61])
        by mx.google.com with ESMTPSA id my6sm80776719pbc.36.2014.04.21.17.48.04
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 21 Apr 2014 17:48:06 -0700 (PDT)
Received: by mcgrof@gmail.com (sSMTP sendmail emulation); Mon, 21 Apr 2014 17:48:02 -0700
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246683>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This saves us a few branches when RUN_SETUP is set up.

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 git.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 9efd1a3..7780572 100644
--- a/git.c
+++ b/git.c
@@ -290,7 +290,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	if (!help) {
 		if (p->option & RUN_SETUP)
 			prefix = setup_git_directory();
-		if (p->option & RUN_SETUP_GENTLY) {
+		else if (p->option & RUN_SETUP_GENTLY) {
 			int nongit_ok;
 			prefix = setup_git_directory_gently(&nongit_ok);
 		}
-- 
1.9.0
