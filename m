From: John Tapsell <johnflux@gmail.com>
Subject: [PATCH 5/6] Change output "error: " to "Error: " etc
Date: Thu, 19 Feb 2009 07:36:49 +0000
Message-ID: <200902190736.49161.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 08:38:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La3UE-00031H-IJ
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 08:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbZBSHgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 02:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752777AbZBSHgy
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 02:36:54 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:17251 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbZBSHgx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 02:36:53 -0500
Received: by rv-out-0506.google.com with SMTP id g37so298246rvb.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 23:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:date:to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=M/ocGD6jvAYuBPPQ7fzDj6TMixe7yqmzMtNlK9yX4a8=;
        b=ONJfp5n+IMkgcQyoQIMl05HfHlduS2uuGK5mER8BlV/y2qS5/L1/VOf8h5ki2iOSb7
         F7kU1Q0QDJmyz55+S4bKpX7bvzBmsJ4P4H1WY+EJGIlUhYVb4UOZykXe0Y63mSaEwakB
         kK1WD7L0ZM0Xojl8W60KUs+bt/YuFF2t/ZpeA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:date:to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=WC74ipVytYKOTmJK6PBmy0MOA3BrN35nWt8T1Lx5AnJocDLjBW/f2jmS/6RPXKalUc
         E8tyIjVCrJvt04HEx7Gya3v6sNOzLdwBA/r1HR9IsROgzTtbJwYXY9nP6GJ0IJ8S0A5u
         BTD/6dxvsT7eizxKcD097JiAbA45GHuolpv5Y=
Received: by 10.143.3.7 with SMTP id f7mr3487859wfi.65.1235029012732;
        Wed, 18 Feb 2009 23:36:52 -0800 (PST)
Received: from johnflux-desktop.localnet (58-190-81-184.eonet.ne.jp [58.190.81.184])
        by mx.google.com with ESMTPS id 28sm2510875wfg.51.2009.02.18.23.36.50
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 23:36:52 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110639>

All the error messages starting "Error: " begin with a captial E, except
in one place.  This commit fixes this, making the output look more
consistent.  At the moment a failed push, say, looks like:

Error: cannot lock existing info/refs
error: failed to push some refs to 'some repository'

Signed-off-by: John Tapsell <johnflux@gmail.com>
---
 usage.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/usage.c b/usage.c
index 24f5fc0..acc4ee1 100644
--- a/usage.c
+++ b/usage.c
@@ -14,24 +14,24 @@ static void report(const char *prefix, const char *err, va_list params)
 
 static NORETURN void usage_builtin(const char *err)
 {
-	fprintf(stderr, "usage: %s\n", err);
+	fprintf(stderr, "Usage: %s\n", err);
 	exit(129);
 }
 
 static NORETURN void die_builtin(const char *err, va_list params)
 {
-	report("fatal: ", err, params);
+	report("Fatal: ", err, params);
 	exit(128);
 }
 
 static void error_builtin(const char *err, va_list params)
 {
-	report("error: ", err, params);
+	report("Error: ", err, params);
 }
 
 static void warn_builtin(const char *warn, va_list params)
 {
-	report("warning: ", warn, params);
+	report("Warning: ", warn, params);
 }
 
 /* If we are in a dlopen()ed .so write to a global variable would segfault
-- 
1.6.2.rc1.3.g7d31b.dirty
