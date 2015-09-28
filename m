From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 03/43] refs-be-files.c: rename refs to refs-be-files
Date: Mon, 28 Sep 2015 18:01:38 -0400
Message-ID: <1443477738-32023-4-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:03:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggVp-0000Zd-LO
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbbI1WDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:03 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34444 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbbI1WDA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:00 -0400
Received: by qkfq186 with SMTP id q186so74133337qkf.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B7IAkExvSvfoKSrGL+3ErbpYyyFB7IFSquPZsCqStLI=;
        b=jNOSgT2032q8v6jLhxsc2ZW/KDJbAyNy7HPy6yIZ1AorEO/29l6TcpQh/NgG406Tli
         D2iijrtNyP3fSTuEQ1wPNPmmol3FI0WlWbOTXxDfQNvBGz8dGmzNLVroIiD9pT0pKgAo
         5SCu8WJUxeOncxWabCR6uhlncky1jrQ+SRhw6ifn2K6DKyTDW7xSyPC4JFZh1kccgBTw
         JduMmaqn0QT8U2WSA604yjFoe2cS522GlcIIiSmgSCKq3t+JjUK9vZ12T7rOq+S6H82E
         csns6kBrt6Ba2UmCjo15Z1Uf/7fyaf4HhGXYh4UTD57GslWu8VOGzjb4Wd1w17OxWH0l
         2Dlw==
X-Gm-Message-State: ALoCoQlMCKMKuJj5mv0EdwTQ72YXDnNxRZbLa0EEY845a6S+mH+Q1N+RPeXL9I05CRGo98aqJtVu
X-Received: by 10.55.20.164 with SMTP id 36mr21600902qku.54.1443477779295;
        Mon, 28 Sep 2015 15:02:59 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.02.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:02:58 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278755>

From: Ronnie Sahlberg <sahlberg@google.com>

Rename refs.c to refs-be-files.c to indicate that this file now
holds the implementation for the files based refs backend.
A smaller portion of the code in this file is backend agnostic and will
be moved to a a new refs.c file that will hold all the common refs code
that is shared across all backends.

A second reason for first moving all the code to the new file and then
move the backend agnostic code back to refs.c instead of the other way
around is because the code that will eventually remain in this new
refs-be-files.c file is so entangled that it would then be very
difficult to break the split up into small independent patches/chunks.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 Makefile                  | 2 +-
 refs.c => refs-be-files.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename refs.c => refs-be-files.c (100%)

diff --git a/Makefile b/Makefile
index 46d0ca7..19036de 100644
--- a/Makefile
+++ b/Makefile
@@ -766,7 +766,7 @@ LIB_OBJS += quote.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += reflog-walk.o
-LIB_OBJS += refs.o
+LIB_OBJS += refs-be-files.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
diff --git a/refs.c b/refs-be-files.c
similarity index 100%
rename from refs.c
rename to refs-be-files.c
-- 
2.4.2.644.g97b850b-twtrsrc
