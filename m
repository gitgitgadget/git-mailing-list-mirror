Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5793920756
	for <e@80x24.org>; Tue, 17 Jan 2017 23:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbdAQXjC (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 18:39:02 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36735 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbdAQXhb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 18:37:31 -0500
Received: by mail-qk0-f195.google.com with SMTP id a20so17393618qkc.3
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 15:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L9pTUSxhSFAnaBnu4W6ny9V2hvmph+6SD7wi+DKjw30=;
        b=mVZFhcowTL8g6GZxWoyFz/Pw/0uTTrm+k2ciN6hKAKUyYxmVAFmheimWST41YAc9Vo
         2EVi28ptstoKVUqR+uty6swnIRvsJ1kJWNK0MRYt/x3t1uE2TuHwpdWM9Sdgo78sInLu
         HTAYzafTBOZQoqnOvl7V8mtfBQuZv1sbVDA0PlCTgbx5TAOvWrio9io2REOCwgYW0NoR
         xDl+WnCZgVQcGr39P6ZByZ+FTyDiL+8yf8PVn1CmyBmSzCBGzOmsYnk18zLokURcljI4
         dQmMxgUaHsRnu5jBgR70Tjw8zREMM7X41Rc/YlfMYEJcB6TBqohpNFFmz4lagYCsKhqg
         w6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L9pTUSxhSFAnaBnu4W6ny9V2hvmph+6SD7wi+DKjw30=;
        b=QGNZe3ad/JnSStNlI9VuOmhd/QMpkj8SfH3yqnrRrj3q7V6Ae/XFq/Ov/J0jZ17WLK
         CEAxHhPYm7BcjX5Re86Y32AepFRFnEbbQ5xsH8HzfedkyBQaYyrTv5PnEEgql5aQGpVr
         aXOnt7YJBqooZGoDPFVlM0toAbR77BJPEkx0i3J7CMQ6RWV3/+P+9+llgcCr34ynA+y6
         J0GcSnaerWyBvmyLeGbGxRiaiXkh0LDmvnW5Cv3SlkhR5BFSKAQIzR5zi/a3glACgxUu
         rsZZnHWpnskYmpQKLcN3QX9OzJpWlJKyI48Zosoknps9yXYIyoaX+xVvY/iQAkTbiJ84
         pjSQ==
X-Gm-Message-State: AIkVDXKxhLo4RqvWzOrCKta+ahMZDzYOm5uEvx6WQzDT1eIVOEdQDH7H6r8bb6xbF2AwrB7a
X-Received: by 10.55.204.197 with SMTP id n66mr216805qkl.205.1484696250954;
        Tue, 17 Jan 2017 15:37:30 -0800 (PST)
Received: from localhost.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id c1sm3405814qke.36.2017.01.17.15.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2017 15:37:30 -0800 (PST)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: [PATCH v6 1/6] gpg-interface,tag: add GPG_VERIFY_OMIT_STATUS flag
Date:   Tue, 17 Jan 2017 18:37:18 -0500
Message-Id: <20170117233723.23897-2-santiago@nyu.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170117233723.23897-1-santiago@nyu.edu>
References: <20170117233723.23897-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas Puehringer <luk.puehringer@gmail.com>

Functions that print git object information may require that the
gpg-interface functions be silent. Add GPG_VERIFY_OMIT_STATUS flag and
prevent print_signature_buffer from being called if flag is set.

Signed-off-by: Lukas Puehringer <luk.puehringer@gmail.com>
---
 gpg-interface.h | 5 +++--
 tag.c           | 5 ++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/gpg-interface.h b/gpg-interface.h
index ea68885ad..d2d4fd3a6 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -1,8 +1,9 @@
 #ifndef GPG_INTERFACE_H
 #define GPG_INTERFACE_H
 
-#define GPG_VERIFY_VERBOSE	1
-#define GPG_VERIFY_RAW		2
+#define GPG_VERIFY_VERBOSE		1
+#define GPG_VERIFY_RAW			2
+#define GPG_VERIFY_OMIT_STATUS	4
 
 struct signature_check {
 	char *payload;
diff --git a/tag.c b/tag.c
index d1dcd18cd..243d1fdbb 100644
--- a/tag.c
+++ b/tag.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "tree.h"
 #include "blob.h"
+#include "gpg-interface.h"
 
 const char *tag_type = "tag";
 
@@ -24,7 +25,9 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 
 	ret = check_signature(buf, payload_size, buf + payload_size,
 				size - payload_size, &sigc);
-	print_signature_buffer(&sigc, flags);
+
+	if (!(flags & GPG_VERIFY_OMIT_STATUS))
+		print_signature_buffer(&sigc, flags);
 
 	signature_check_clear(&sigc);
 	return ret;
-- 
2.11.0

