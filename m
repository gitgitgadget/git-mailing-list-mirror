From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] Use compat/regex on Cygwin
Date: Mon, 15 Jul 2013 10:10:53 -0400
Message-ID: <1373897453-18799-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 16:11:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyjUb-0006r5-VL
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 16:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757293Ab3GOOLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 10:11:05 -0400
Received: from mail-qe0-f49.google.com ([209.85.128.49]:60449 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757136Ab3GOOLE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 10:11:04 -0400
Received: by mail-qe0-f49.google.com with SMTP id cz11so6354370qeb.22
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 07:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=T2hY6UwAoGRisP0j3tCk+B99C9Dc8YfjvGwaoxOMeXQ=;
        b=R2Vb76DQ8GCNyS5ZJ/1FLTg4tLGGDSv9B03d/VqvVJWWbXYr/NTH03G2NqiHDY2amu
         XjBjp+0TdNBPWtKZZSEor4QkvxKgq1t8ahwAw2mXJyqFTNo8ai5GvR+G5VU+mmvcvhFp
         mGccd4vUHWrLjUNvTv1By7TM1bkYJDanZOUj4DZS10YVtY74nmksLXBCCJofjDwKorcL
         zH+uXzuWlSt/L0MZNR6M59vT8ddlc8ZhnUy3DCLxrwXonti82VCY5J6K4hNqBwcewYRH
         wZckLA4fdYOLmVOYX7iXoNiiKM1pVp889GrJsjW9HeTBOTwin9FhUdp4Nrj81IccQKq9
         +TGw==
X-Received: by 10.224.57.83 with SMTP id b19mr42828478qah.78.1373897463155;
        Mon, 15 Jul 2013 07:11:03 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id l2sm55480942qez.2.2013.07.15.07.11.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 07:11:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230470>

Cygwin's regex library does not pass git's tests, so don't use it. This
fixes failures in t4018 and t4034.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 7ac541e..6901597 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -165,6 +165,7 @@ ifeq ($(uname_O),Cygwin)
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
 	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
+	NO_REGEX = UnfortunatelyYes
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
 	# Try commenting this out if you suspect MMAP is more efficient
-- 
1.8.3.2.0.13
