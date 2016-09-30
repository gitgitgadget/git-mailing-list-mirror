Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86CAF207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 22:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932805AbcI3WSQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 18:18:16 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32856 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbcI3WSN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 18:18:13 -0400
Received: by mail-qk0-f194.google.com with SMTP id n66so7139935qkf.0
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 15:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f2hXt0zFQ/AlYkeWoQsjLhKS2iXk2GWktnyNrJKk7No=;
        b=Vy4mGvhxHVb0HKf1qKUW6eP7wkLpVWgNLYfxyTrTYBtqHW2dlg7FSD0a9W7o5fFQhb
         xak2T+9qNt9dUq/ZS2ZjHJQ9tumjz8hUES4AlyKDXcP5lLkpJr6SgUXnjOKztRmRywHb
         AIbosu8Y10ZPQL1SNsA9aj75inpWVyNiaH7pjfTguMO4cLBn1MvCe1oIl/qEh/YXFUDZ
         vrtTsJz28j2rZyzfBtw0nYH1KGN/Xh7FukrHNwLDFKw1XQtTNmewoGEy9fw++fRPLvgF
         O4EEdsayh27pR5AF8Gb7vCVEhRBzGOsZ7H+6jGu8NJLkhCTTbfBUW7+oJDiSR6BeKXZ6
         Zgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f2hXt0zFQ/AlYkeWoQsjLhKS2iXk2GWktnyNrJKk7No=;
        b=b3zc8hh9l4gH2MXtnUZPmrrk5zpS31ASwS+WpLYwxMSm0wrwcfET45vkUmyAKtN7oj
         4SW8crT1j1tYf8Js8tN64h/P7koAUfBUyVWQ3JdkX2n3a9WXw6/rmgosJZT612SYcMmq
         CNOXjUCanwB+FtrKVYRgZnUNS00hXybwy347jzSRmWBzgbb0T95bc1f6gdw+gsjnEuwf
         7a3HNcuBOJaHEqNDgGMufEGUbSwhqYeyHgqg43paYqq8JgQVYelE1ubYNQCrLKrFjuvw
         SsjLWWTmVH0jWJ7bX8xKS1VGnTbTbBk4QCRYdeZJoxX+xjG3RDuYtq+8RVEcG1mrNVPX
         fJqw==
X-Gm-Message-State: AA6/9RnRMVFL6FGW5EA93qqb/tGEZmRHyzoTvtP5QGTe6583Hm5IIM3z/0VORxX/EcbrJYDw
X-Received: by 10.55.125.68 with SMTP id y65mr9309012qkc.319.1475273892525;
        Fri, 30 Sep 2016 15:18:12 -0700 (PDT)
Received: from LykOS.localdomain (cpe-74-65-203-27.nyc.res.rr.com. [74.65.203.27])
        by smtp.gmail.com with ESMTPSA id x21sm11347615qkb.19.2016.09.30.15.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2016 15:18:12 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: [PATCH v3 1/5] gpg-interface, tag: add GPG_VERIFY_QUIET flag
Date:   Fri, 30 Sep 2016 18:18:02 -0400
Message-Id: <20160930221806.3398-2-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160930221806.3398-1-santiago@nyu.edu>
References: <20160930221806.3398-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas Puehringer <luk.puehringer@gmail.com>

Functions that print git object information may require that the
gpg-interface functions be silent. Add GPG_VERIFY_QUIET flag and prevent
print_signature_buffer from being called if flag is set.

Signed-off-by: Lukas Puehringer <luk.puehringer@gmail.com>
---
 gpg-interface.h | 1 +
 tag.c           | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/gpg-interface.h b/gpg-interface.h
index ea68885..85dc982 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -3,6 +3,7 @@
 
 #define GPG_VERIFY_VERBOSE	1
 #define GPG_VERIFY_RAW		2
+#define GPG_VERIFY_QUIET	4
 
 struct signature_check {
 	char *payload;
diff --git a/tag.c b/tag.c
index d1dcd18..291073f 100644
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
+	if (!(flags & GPG_VERIFY_QUIET))
+		print_signature_buffer(&sigc, flags);
 
 	signature_check_clear(&sigc);
 	return ret;
-- 
2.10.0

