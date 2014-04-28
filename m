From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH v3 2/2] Makefile: allow static linking against libcurl
Date: Mon, 28 Apr 2014 12:35:04 -0700
Message-ID: <1398713704-15428-2-git-send-email-dborowitz@google.com>
References: <1398713704-15428-1-git-send-email-dborowitz@google.com>
Cc: kusmabite@gmail.com, gitster@pobox.com,
	Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 21:35:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerL6-0002pR-Ef
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756682AbaD1Tfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:35:36 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44045 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756562AbaD1Tfc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:35:32 -0400
Received: by mail-pa0-f46.google.com with SMTP id kp14so6176672pab.33
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zzwVCtQzTMzF1xVobrE1nAqVT+hySMKkdqY8KNE6IDs=;
        b=oI5t+PQ6JFrI1ZNuGJkPgAHljUQURxcbTSvLW6DWvLMJO/CiZVae2lhI4DCKYTzMmz
         YQnoLj0nY4IO/UzkVTqWDf7k8H2/YU51L0x/vjrQKaSroP6qh1KYza3w7E1Vg6pjoY9i
         5sN9FBwiGsS0eyeEXEAlVLfmCNXY6svjX1QSuzcl8VW3t3yP6VWeBb1Tdq1DxCGJtfPs
         CNSIsWzSps+AORTG8QeyKfSluUOihiDXle2/auPLiz5Q4wofTQUh2I72tv8RQtH51Hj8
         dhdtmzFfVcgbsBNkiEEzgWtrQHD4HnOn4RrwUj1NA9n4gsfonmHa7VuGRDVZY8tsLw7d
         U4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zzwVCtQzTMzF1xVobrE1nAqVT+hySMKkdqY8KNE6IDs=;
        b=LUKFCkvQGWchN7eEJtuySZ15hYYrfMguHATrLZcCPuvcnvgNHMxTrfTqilo1bWJKH9
         YrgU0cmP7658zxr1Bwf5dPHCylUpeUrpiOVhCWWq9x/5UbUZOBOyo2/FsgXqAmfsULF8
         G+nA0h6e3JlxI569WMt+JYMGFuBVBvgKD1LXKblo1aubpa7D3CTZv2QNo8gmJveWywFi
         9+RproibX6TEZWfH6pBBU2j0c1JMZo6qU1fwFmqpT4UQJUp/0inGZUjWrsm2U7pCZH5c
         YIfaA6cvhjRRRp8uzCLrZSuRaEBfx+wZcA47pluZzHVpsHn0iGWmq2ZbOlHgu8/FLfhy
         IlgA==
X-Gm-Message-State: ALoCoQmHIrUmTcOrrPB79XDYGr4wM4u0w5wkllx7OSW3lN0Y59kLqxe6LVwRULaqMpJ/rri4FYES9SrENtlOVo7lhBJRGR4LHsFx4byppF3sod0dwdtPOvEhDyJpNPA1KyIZXHcRGpHkJUmvBDUrcdr4T9GYP7wg2OOR+tRyWH+8/ibdteO2oZsgq2sM/Y/4YegL7OQHAx8+4MjEVaS6nj83q+Wnv8+sKJZzXJJEVdxrMvWUyl67KV0=
X-Received: by 10.68.216.101 with SMTP id op5mr5506650pbc.148.1398713731636;
        Mon, 28 Apr 2014 12:35:31 -0700 (PDT)
Received: from serval.mtv.corp.google.com (serval.mtv.corp.google.com [172.27.69.27])
        by mx.google.com with ESMTPSA id ss2sm96327791pab.8.2014.04.28.12.35.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 12:35:29 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.423.g4596e3a
In-Reply-To: <1398713704-15428-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247414>

This requires more flags than can be guessed with the old-style
CURLDIR and related options, so is only supported when curl-config is
present.

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Makefile b/Makefile
index cb4ee37..360d427 100644
--- a/Makefile
+++ b/Makefile
@@ -39,6 +39,9 @@ all::
 # is not found, defaults to the CURLDIR behavior, or if CURLDIR is not set,
 # uses -lcurl with no additional library detection.
 #
+# Define CURL_STATIC to statically link libcurl.  Only applies if
+# CURL_CONFIG is used.
+#
 # Define CURLDIR=/foo/bar if your curl header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.  This overrides CURL_CONFIG,
 # but is less robust.
@@ -1137,6 +1140,9 @@ else
 	endif
 
 	ifeq "$(CURL_LIBCURL)" ""
+		ifdef CURL_STATIC
+                        $(error "CURL_STATIC must be used with CURL_CONFIG")
+		endif
 		ifdef CURLDIR
 			# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
 			BASIC_CFLAGS += -I$(CURLDIR)/include
@@ -1155,6 +1161,12 @@ else
 		endif
 	else
 		BASIC_CFLAGS += $(shell $(CURL_CONFIG) --cflags)
+		ifdef CURL_STATIC
+			CURL_LIBCURL = $(shell $(CURL_CONFIG) --static-libs)
+			ifeq "$(CURL_LIBCURL)" ""
+                                $(error libcurl not detected or not compiled with static support)
+			endif
+		endif
 	endif
 
 	REMOTE_CURL_PRIMARY = git-remote-http$X
-- 
1.9.1.423.g4596e3a
