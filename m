From: David Michael <fedora.dm0@gmail.com>
Subject: [PATCH 1/3] git-compat-util.h: Support variadic macros with the XL C compiler
Date: Sun, 26 Oct 2014 13:33:12 -0400
Message-ID: <87ppdeag87.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 26 18:33:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiRgp-0006Ur-7P
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 18:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbaJZRdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 13:33:11 -0400
Received: from mail-qa0-f47.google.com ([209.85.216.47]:53785 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbaJZRdK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 13:33:10 -0400
Received: by mail-qa0-f47.google.com with SMTP id dc16so2906839qab.34
        for <git@vger.kernel.org>; Sun, 26 Oct 2014 10:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:mime-version:content-type;
        bh=RsIrhV03mJnff9oc4yR3+Ej2KV7A1MbjnnrmCWcvuls=;
        b=JGvsrfDJ5g7wWW+55pupAG+lCsDMXo0McesGJ48E7T9nHJEZCg4tZ9RK5PKe3Hkr5m
         wJ9WuUaDfFWeN+GdJZpFJ7Gh1+w0wQcSrezeUMM1Sz2OSSPHIH9hj0c2cGDPTjjnU6Q9
         Tdpnhnp+Pj3kbzBbbqbWQceGupMzXY0oUUA6Z7o/nq1Qpf+Fok96VV6JXbnlcvbPE1H9
         tJyLrr3gI2z+Ubd4YDZa2DfR/hPT9S0Gpl1lcnwSvFmg3+O9KK//PyYkfd+qMaVoahDq
         QBppAbZTmgV/DSBU7bY6c/fexqUiMf+oNwReXVzKuiw76tMdIYlTF1Cf27dfP5XHpB5g
         pY9g==
X-Received: by 10.229.79.132 with SMTP id p4mr6483833qck.14.1414344788956;
        Sun, 26 Oct 2014 10:33:08 -0700 (PDT)
Received: from callisto (c-68-81-204-146.hsd1.pa.comcast.net. [68.81.204.146])
        by mx.google.com with ESMTPSA id m6sm9262702qai.13.2014.10.26.10.33.08
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Oct 2014 10:33:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the XL C compiler is run with an appropriate language level or
suboption, it defines a feature test macro to indicate support for
variadic macros.

This was tested on z/OS, but it should also work on AIX according
to IBM documentation.

Signed-off-by: David Michael <fedora.dm0@gmail.com>
---
 git-compat-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 2107127..b31cfdd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -778,7 +778,7 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #endif
 #endif
 
-#if defined(__GNUC__) || (_MSC_VER >= 1400)
+#if defined(__GNUC__) || (_MSC_VER >= 1400) || defined(__C99_MACRO_WITH_VA_ARGS)
 #define HAVE_VARIADIC_MACROS 1
 #endif
 
-- 
1.9.3
