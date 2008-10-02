From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] format-patch: autonumber by default
Date: Thu,  2 Oct 2008 13:27:40 +0200
Message-ID: <1222946860-15518-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 13:28:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlMM0-00030U-64
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 13:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbYJBL1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 07:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753360AbYJBL1G
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 07:27:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:1992 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbYJBL1D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 07:27:03 -0400
Received: by ug-out-1314.google.com with SMTP id k3so991839ugf.37
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 04:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=e1YlhK4yQGqUHqREQDyqloyukg0z5UmSGISDJATQkr0=;
        b=rPDqTTBCEr10ZosyOBWPR9rJAsmM/WwazJbDe2DYSf2wQxs5aFhmEdW9ek6DpYRhS3
         JynFBuH9U4MIuVjPAwfUZDarxqJzFIlDwIs7tS3hwYAOGtPSb9Slw3rvBJW5i0g4xZ6M
         w5iMCsV3qed0vie62isLVkV1KHnJWIRjXnvLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=VJKLPzHyMgjuBMycxfDOWFBJVL6siJWACknXGkbj+xYFHcRsnaboqTrwHcsiC4kMc1
         EQRnOj+WTmjlIxwjld3lea/fYXDxl3/oLnOXovWKGtXbUfTGTJhF2rkvXBRwchQckC6c
         c1HgUl0BbLq47rHToqF7u3khs9zd1vhlaNWvg=
Received: by 10.66.232.9 with SMTP id e9mr3841765ugh.17.1222946821416;
        Thu, 02 Oct 2008 04:27:01 -0700 (PDT)
Received: from localhost ([78.15.6.228])
        by mx.google.com with ESMTPS id k1sm11606228ugf.15.2008.10.02.04.26.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 04:27:00 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set auto-number true by default, allowing the format.number key to be
set to 'noauto' to override this.
---
 builtin-log.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index fc5e4da..5187dc2 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -426,7 +426,7 @@ static int istitlechar(char c)
 
 static const char *fmt_patch_suffix = ".patch";
 static int numbered = 0;
-static int auto_number = 0;
+static int auto_number = 1;
 
 static char **extra_hdr;
 static int extra_hdr_nr;
@@ -484,6 +484,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
 			auto_number = 1;
 			return 0;
 		}
+		if (value && !strcasecmp(value, "noauto")) {
+			auto_number = 0;
+			return 0;
+		}
 		numbered = git_config_bool(var, value);
 		return 0;
 	}
-- 
1.5.6.5
