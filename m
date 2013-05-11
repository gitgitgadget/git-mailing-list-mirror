From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 1/3] Makefile: fix default regex settings on Darwin
Date: Sat, 11 May 2013 01:22:26 -0700
Message-ID: <1368260548-52612-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 11 10:22:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub54z-0000ju-2L
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 10:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786Ab3EKIWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 04:22:51 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35328 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222Ab3EKIWt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 04:22:49 -0400
Received: by mail-pd0-f175.google.com with SMTP id y14so3284304pdi.20
        for <git@vger.kernel.org>; Sat, 11 May 2013 01:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=1ghG+nahc6yd2JqghRT5S+/kY3Agd840Y7nCA8jGpVk=;
        b=Y6QoajN6oBZyMIhwX6KOPQwScABcJuvDsvlGeSueVEXK8q0bV1jq0jVE3EMYqrVoqc
         xICBkknpq2a4FEtCIv/FNbmVStAYlYslRHJhlwrFHc4hetVcK2AmqvkxE6ISSnJkSgsf
         mMbDiDkorWHTRbt5FXLuehO62g/jcJS8WRz0RgSctS3No/7GvMpStaMvP7xEpquzqFnr
         v+G/2f2R3MfA7EkyxYa+NtIWmnR6JZfeldVRiEIjMCdodYEbXP3q0OLkMwBlxiw3EFQ2
         a8Awn3Bva9U082fC6R8DsanhOdh/Q1N2reHlbbH8z8RawqtN54QM5jvE+kpY209czN/S
         AXRQ==
X-Received: by 10.66.228.233 with SMTP id sl9mr21036515pac.38.1368260569233;
        Sat, 11 May 2013 01:22:49 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id dr6sm6154774pac.11.2013.05.11.01.22.47
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 11 May 2013 01:22:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.47.g41936fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223941>

t0070-fundamental.sh fails on Mac OS X 10.8:

	$ uname -a
	Darwin lustrous 12.2.0 Darwin Kernel Version 12.2.0:
	Sat Aug 25 00:48:52 PDT 2012;
	root:xnu-2050.18.24~1/RELEASE_X86_64 x86_64

	$ ./t0070-fundamental.sh -v
	fatal: regex bug confirmed: re-build git with NO_REGEX=1

Fix it by using Git's regex library.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Added uname output and Jonathan's review tag.

 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 0f931a2..f698c1a 100644
--- a/Makefile
+++ b/Makefile
@@ -1054,6 +1054,7 @@ ifeq ($(uname_S),Darwin)
 			BASIC_LDFLAGS += -L/opt/local/lib
 		endif
 	endif
+	NO_REGEX = YesPlease
 	PTHREAD_LIBS =
 endif
 
-- 
1.8.3.rc1.47.g41936fa
