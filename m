Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B623620136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934161AbdBQOGG (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:06:06 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35345 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934043AbdBQOGD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:06:03 -0500
Received: by mail-pf0-f194.google.com with SMTP id 68so4190012pfx.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=foSDmp0OVDrVD431UCvHFlaRSbADtsx9saxgAL0HexA=;
        b=ccL/l+1km3x9GIPn3y+4oNJif9IqKMpOhhhEQTjDr+ZIqIK3xYEuGbsALA4HaQoeAu
         N7SBQYgnglL8wmwSET/GONTATih8I1XwYbztlKMDnoPOjTgaF1+wm/4o3tXeq+mbfxy+
         RXQXclf/ayAegRmrbq4fWUqWoeu7O8crabkjcN1/PJ42wsvefTVi6e6bQt9ysxH7suhT
         qRwki+WKv6Uo2tU1AwTnX1yXvLhQU22CEccGSj3NzKXl+hHjcMKtSejrMkNadgTdd0V8
         1mGEMb4eLFV3PqcAa4psK7QyuLgf8eTC304pbS8CPV9HCPbB0HJa4JeTNl3FWF+yqFuw
         s7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=foSDmp0OVDrVD431UCvHFlaRSbADtsx9saxgAL0HexA=;
        b=QM3eSVqQlCQYm8L8XhZZ0Ill+UEPoTVQRLM/ijko8aFJcrTW6CyzbKPJiSGzaHlqRU
         9FWPTHqEcLo1hWakb0X3TXZoPUl84REe5kMUd72QZmc1MSor7POUzAP9hHtNhLpAtqyA
         DtAA8qmiLcVqrLME7IYz9sAWEduMat9qM0lwJ/ZmNo3BCQ3oK3/XBA7DAPoDrm9KD9Ez
         5PHeFzqX2iwTIeKkh9ENdIQXoyF2n84+sqPF57U4hJQh3HElJlKPLkf/OWg1FguSuftn
         /eqL8hMqiunnMLwykLY2GLjmc7RZKjSMVqpWcBYt7GlzLKtAOGXepgPHXkRPudOXw7HR
         JxKQ==
X-Gm-Message-State: AMke39mNyFGnOvkbrHQ5RaidSZLRU5HznK7VFzsJWGqZEBLTLvPZGm7I+qD3ParhJIXKWg==
X-Received: by 10.84.143.165 with SMTP id 34mr11670655plz.2.1487340363123;
        Fri, 17 Feb 2017 06:06:03 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id b73sm282698pfl.132.2017.02.17.06.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:06:02 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:05:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 10/16] refs.c: flatten get_ref_store() a bit
Date:   Fri, 17 Feb 2017 21:04:30 +0700
Message-Id: <20170217140436.17336-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217140436.17336-1-pclouds@gmail.com>
References: <20170216114818.6080-1-pclouds@gmail.com>
 <20170217140436.17336-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This helps the future changes in this code. And because get_ref_store()
is destined to become get_submodule_ref_store(), the "get main store"
code path will be removed eventually. After this the patch to delete
that code will be cleaner.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index ea13a5b86..76a0e7b5a 100644
--- a/refs.c
+++ b/refs.c
@@ -1454,22 +1454,21 @@ static struct ref_store *get_main_ref_store(void)
 
 struct ref_store *get_ref_store(const char *submodule)
 {
+	struct strbuf submodule_sb = STRBUF_INIT;
 	struct ref_store *refs;
 
 	if (!submodule || !*submodule) {
 		return get_main_ref_store();
-	} else {
-		refs = lookup_submodule_ref_store(submodule);
+	}
 
-		if (!refs) {
-			struct strbuf submodule_sb = STRBUF_INIT;
+	refs = lookup_submodule_ref_store(submodule);
+	if (refs)
+		return refs;
 
-			strbuf_addstr(&submodule_sb, submodule);
-			if (is_nonbare_repository_dir(&submodule_sb))
-				refs = ref_store_init(submodule);
-			strbuf_release(&submodule_sb);
-		}
-	}
+	strbuf_addstr(&submodule_sb, submodule);
+	if (is_nonbare_repository_dir(&submodule_sb))
+		refs = ref_store_init(submodule);
+	strbuf_release(&submodule_sb);
 	return refs;
 }
 
-- 
2.11.0.157.gd943d85

