From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 3/4] Cygwin 1.7 has thread-safe pread
Date: Fri, 19 Jul 2013 19:08:29 -0400
Message-ID: <1374275310-22388-3-git-send-email-mlevedahl@gmail.com>
References: <51E9C69F.7080309@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 20 01:08:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Jn7-0004g2-UD
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 01:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105Ab3GSXIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 19:08:40 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:35443 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab3GSXIj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 19:08:39 -0400
Received: by mail-qc0-f169.google.com with SMTP id c10so2661692qcz.28
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 16:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=r1+l6olGEcy4+pAglO6qPx92+KcJO3Vvvc9zdUL6w6s=;
        b=XeLE25Au1d8ajn70w0KN1k9lgFWHMaYSKSOQQJgjAUkNpQTnVIQKzcNoTl4KSZ3tml
         +RZerCuKxcWzjKY5ff60ckDLLctwH31kCnkuAss/xf2lS2sabnOI37uyESMmjSdh2pBo
         oC5NGMgZWlpyJz1q7Q8BzJtXQl5F4qacxtY5Ppm5GnXXwwmK3kYH7D5k3pugrWjmd3R9
         LKuZg/RNDp8bGyQmFXSTy2f3WdPBZJ4oOnB7nuMxjKDTT7IfuceuPXwF5aBIDgNSQKgL
         36hEsWyq77lW7+LwAdY3d7rPgKlAr1oCsmHQ3Cl4Q2Wa91NWlC9dcYt86ep2RVUf/02i
         GiNw==
X-Received: by 10.224.119.148 with SMTP id z20mr21065835qaq.111.1374275318641;
        Fri, 19 Jul 2013 16:08:38 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id s9sm22498999qeo.3.2013.07.19.16.08.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 16:08:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.0.13
In-Reply-To: <51E9C69F.7080309@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230861>

Per http://cygwin.com/ml/cygwin/2012-07/msg00331.html , cygwin 1.7
was modified to explicitly support git's use of pread, so make this
the default. Do not affect earlier cygwin versions.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 config.mak.uname | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 8652da9..048c252 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -160,10 +160,10 @@ ifeq ($(uname_O),Cygwin)
 		NO_IPV6 = YesPlease
 		NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
 		OLD_ICONV = UnfortunatelyYes
+		NO_THREAD_SAFE_PREAD = YesPlease
 	else
 		NO_REGEX = UnfortunatelyYes
 	endif
-	NO_THREAD_SAFE_PREAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
-- 
1.8.3.2.0.13
