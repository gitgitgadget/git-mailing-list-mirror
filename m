From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] Makefile: describe XMALLOC_POISON
Date: Wed, 13 Jan 2016 22:56:44 +0600
Message-ID: <1452704204-1928-1-git-send-email-kuleshovmail@gmail.com>
References: <1452686255-8757-1-git-send-email-kuleshovmail@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:00:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJOmV-0000ey-36
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149AbcAMRAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:00:17 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36439 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbcAMRAP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:00:15 -0500
Received: by mail-lf0-f52.google.com with SMTP id h129so64353930lfh.3
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 09:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4R3VNDJxiqs8LJDM7Ubnz3A7Hk1meY7ErFU3UGuuJ4k=;
        b=TR66p8ftdgjuq/TnWopKDAoRfKsQNSiZVdrjcvvDJfevJ6WQJQb3okuXkq8fgYbUZU
         +iTGnej9H/2geoaoyz+OAFqnxStVISVnUdkdRQhNVRmb9pfVfGlJigvvOaoay8Vomr2a
         HoV7krVpySbWC0vTxnwwISCPDOZzBC6BPjM81YfSYgKtfc3hWtnzW53O95fZHUKtKhks
         8yvpfMINoYmur4LNj//BxczvvFnhTzxnK3mQDzkrU9dOD7HV4u93PuuZUJIe2EQPE+nn
         H11D89cx/PztEnXwnHUopotkHQZD0NDtC7mp6OsZ7IxbkYHmCEJ7GlYu5VHUcaheZoGj
         dHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4R3VNDJxiqs8LJDM7Ubnz3A7Hk1meY7ErFU3UGuuJ4k=;
        b=GXHAN/Bsm5zTS8tOIiyByBvS+ZQXj/ixYhzLNZgUpIh7XKKaDncXfOlp50XswJn9hn
         QZWvprgQbvXheGSmc0Lz5ft0sW3dwmFU7ayjUQSDycKR1OWHnp2cPu+KY9hyA7jrBSsJ
         /bp5LAvYRASRdTR/5F0CpVq7tJNncuqDIIOX1tUa4Z43NZ6NxPsiDOBOBFDCcPH5709G
         /1WbWxauDAEeNOeAoMKEu6TqX7gUXJ3Dp/9MNzEgwrkl7rkV9uKtTtpOzDKR5FNzV1sh
         ZA43fNuit5N8x4s+pXrEQjNvexrwp0bxJlPc5iH9cJzRnO2hqhhxgzP4Yyh8t0hkLgVG
         DovQ==
X-Gm-Message-State: ALoCoQk2IdkbXChZIhRWv14xNEZUQ5w7kTifh3l2jJLIHwC6KQm1gPMcdUBKbzQo2WFMMfLjQBTJT4y1HK6sEYcUOPJB+QcdXw==
X-Received: by 10.25.30.5 with SMTP id e5mr40576317lfe.48.1452704413399;
        Wed, 13 Jan 2016 09:00:13 -0800 (PST)
Received: from localhost.localhost ([2.133.27.66])
        by smtp.gmail.com with ESMTPSA id l8sm290644lfe.24.2016.01.13.09.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jan 2016 09:00:12 -0800 (PST)
X-Mailer: git-send-email 2.7.0.25.gfc10eb5
In-Reply-To: <1452686255-8757-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283935>

The do_xmalloc() functions may fill an allocated buffer with the
known value (0xA5) for debugging if we will pass the XMALLOC_POISON
option during build.

This patch adds description of this option to the Makefile and
adds it to BASIC_CFLAGS if it was provided.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index f3325de..3f942b5 100644
--- a/Makefile
+++ b/Makefile
@@ -367,6 +367,10 @@ all::
 # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl function.
 #
 # Define HAVE_GETDELIM if your system has the getdelim() function.
+#
+# Define XMALLOC_POISON if you are debugging the xmalloc(). In a XMALLOC_POISON
+# build, each allocated buffer by the xmalloc() will be in known state. After
+# memory allocation, a buffer will be filled with '0xA5' values.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1481,6 +1485,10 @@ ifdef HAVE_GETDELIM
 	BASIC_CFLAGS += -DHAVE_GETDELIM
 endif
 
+ifdef XMALLOC_POISON
+	BASIC_CFLAGS += -DXMALLOC_POISON
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
-- 
2.7.0.25.gfc10eb5
