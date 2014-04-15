From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH v2 2/2] Makefile: allow static linking against libcurl
Date: Tue, 15 Apr 2014 03:40:31 -0700
Message-ID: <1397558431-22417-2-git-send-email-dborowitz@google.com>
References: <1397558431-22417-1-git-send-email-dborowitz@google.com>
Cc: gitster@pobox.com, Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 15 12:41:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wa0nw-00067V-VV
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 12:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbaDOKlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 06:41:21 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36662 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbaDOKlN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 06:41:13 -0400
Received: by mail-pd0-f175.google.com with SMTP id x10so9189841pdj.6
        for <git@vger.kernel.org>; Tue, 15 Apr 2014 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PgHxzwy4ZFVcYaTpbgXan8moBg3jnEmagjGx6OfZTCA=;
        b=G2W18puCwz6bVFxbDPtvCYV1EfG3/zQQZoQvPUzEH91jBSWODEjIkg54voPYr9KeBu
         vts0smxF8EDc3D+xQB3OvWDTXOq4ZMJSmMrWLAyJynx3rmY6U5aBKQempfUJ+FJSQ3+g
         f0gOkvGun5xVgJtvHRtdiyFJa4rpbfZUElCQrM03QGQmjn8GZETCc0vJqnOfxrHrOR2R
         lOGuMURQLSq3g8yNqExqhiDZhGRZuuP9hOAweXzPlPKfaghUllrY3LP8xiCne7uMWKFn
         eyo/JrA1ld5qBqI63ycKcmdE7n3GNJNnAG0OwWZdoKrN5TiJ2oaPF+wEnha6FlbG02pj
         MX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PgHxzwy4ZFVcYaTpbgXan8moBg3jnEmagjGx6OfZTCA=;
        b=TmbpfS63oECzNEWZXx1vzCMuAO857O13JFIlvz1m5ohK/goQm/gAS0ewlKLvDFyAhg
         34d4lq2ms66shjm9/iNDJwOaqiS6S2I5+tF1uHppb4ovE3LqY4R4w0lvSg5UY2lqVqNb
         JKz7xlZvQFrbf7DlYDLMkluXvCBOWyQ7SmtWwuBN9DdtLmFleUCwbNL9zFp5FmphG4N+
         Ql34S1nAzAlzXEa+6Mr1MlntIc5KbDUOkeyj0gMDPF/hJya3BkAsB8tChf9XnxGiOugS
         fgPUTno0c29CRYLKDtVV5UGV6Eg5KreTk9rCv4sIu5Ro/zXnUs/YpPdoXlqhMVpUfDIA
         Lm3A==
X-Gm-Message-State: ALoCoQnIkfv8BL3XRTOJk7KIqRFL3NOrugzcL+UvU0q17KAn6h9mSNsJS+LhMLyROMGfmIEy3JabjMW8YEYrNPOT6UmpDVrHd3V8/ai9t9WlqOBN2tLYuupyuAFpaWdMjQGJ58UCHVzL0NU3PjokTXkFw5NblHU/PLY/PoO5yPP2KtJkge2HpRlrJRG19uajT5sMXWomFaWSQ1qI2mxNFhJdcjWHOHb9TmxJH3QJHe00IIqrB2UOKPA=
X-Received: by 10.68.221.42 with SMTP id qb10mr1026325pbc.65.1397558473124;
        Tue, 15 Apr 2014 03:41:13 -0700 (PDT)
Received: from serval.mtv.corp.google.com (serval.mtv.corp.google.com [172.27.69.27])
        by mx.google.com with ESMTPSA id 10sm16416353pbo.51.2014.04.15.03.41.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Apr 2014 03:41:11 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.423.g4596e3a
In-Reply-To: <1397558431-22417-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246283>

This requires more flags than can be guessed with the old-style
CURLDIR and related options, so is only supported when curl-config is
present.

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Makefile | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index d6330bc..e4c93f6 100644
--- a/Makefile
+++ b/Makefile
@@ -37,6 +37,9 @@ all::
 # Define CURL_CONFIG to the path to a curl-config binary other than the
 # default 'curl-config'.
 #
+# Define CURL_STATIC to statically link libcurl.  Only applies if
+# CURL_CONFIG is used.
+#
 # Define CURLDIR=/foo/bar if your curl header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.  This overrides CURL_CONFIG,
 # but is less robust.
@@ -1139,9 +1142,16 @@ else
 	else
 		CURL_CONFIG ?= curl-config
 		BASIC_CFLAGS += $(shell $(CURL_CONFIG) --cflags)
-		CURL_LIBCURL = $(shell $(CURL_CONFIG) --libs)
-		ifeq "$(CURL_LIBCURL)" ""
-			$(error curl not detected; try setting CURLDIR)
+		ifdef CURL_STATIC
+			CURL_LIBCURL = $(shell $(CURL_CONFIG) --static-libs)
+			ifeq "$(CURL_LIBCURL)" ""
+				$(error libcurl not detected or not compiled with static support)
+			endif
+		else
+			CURL_LIBCURL = $(shell $(CURL_CONFIG) --libs)
+			ifeq "$(CURL_LIBCURL)" ""
+				$(error libcurl not detected; try setting CURLDIR)
+			endif
 		endif
 	endif
 
-- 
1.9.1.423.g4596e3a
