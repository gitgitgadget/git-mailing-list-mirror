Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C71D01F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfBQKLS (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:11:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45652 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKLS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:11:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so6987415pgc.12
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2aDEOkbhIcatsxmBr0q9XBMcaZAAyajpHNEGKxEEQVA=;
        b=ExhkFo115zJq4dilgKvz37WIRPZrXV7XAV8G/luv+HwnglBbA92w+DjjOs9gpZSMUX
         AXsPqgHJWDXQWj0B9dtni4NB7giyPylq2IE4WVAEMaTQ1vHDYI2+T8HMG71mLqNGAm41
         YdMONabtcMuHkywoepjX1QGtomvuhKRJsFOVsU6jQaZ4p5gwARUfD3tSiYZtmqhSlUVw
         wkhIN2z/BUeQgkr+fWwUBC2INDC+Tkh0ocWgDQLAXik7I6ty7aDeR452Az+emYAvQCMw
         rRYTuwPuC/5SD5FRrJ8uWoqo5VPmaQdBY6yW8JEwND6R7Cu1X7lmxlkn72foEevxZu5N
         HpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2aDEOkbhIcatsxmBr0q9XBMcaZAAyajpHNEGKxEEQVA=;
        b=A+r+XpYZInMLikI7bzAyu97Lj0nz/4RytCNT+8PQ7tTsxZ665qVQS0x5gMWUBqrrri
         NzLrnh4sO4snDbZiBwn0200PVLq4JaxwflAys4bBOOYPl3isGExFYzSpGOTCyDu1iUvG
         uUJ8t98n2u0eK8FUOHgJHD2YWlePdBeZJDu2gaKGyMSlr9XY70DZf6ashgcRd9JHp0g8
         RQhgMYDUcI7Vtx6+vcCYaeQU7mL8mvSo2G4XQ9Mj0LhRaDNfGuhO8vkQXOMB0UnpopSE
         ngJGtjKqQ2KRfqQ8ga2L//DHWwOvOpvpPvnJEru7ooWoydoVZWNChU/+yu6JGvJFdWFs
         bcng==
X-Gm-Message-State: AHQUAubp2XcHJ+s9ocEg+LMw8JfTk4Des4BPk9TkW0jK4f7ekJQh7tKL
        h8miY1EPUyEf8aAPr84CuLywtNR8
X-Google-Smtp-Source: AHgI3IbrtcaS4cDnDw2jG8v1vZkgrCiuRDYPJOT8f2uZFzF6CmlNg7nov7rAOmwjcc4pw2sjIp0vRQ==
X-Received: by 2002:a65:4b83:: with SMTP id t3mr13602261pgq.417.1550398277501;
        Sun, 17 Feb 2019 02:11:17 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l5sm13003268pgl.51.2019.02.17.02.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:11:16 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:11:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 27/31] sha1-name.c: add repo_get_oid()
Date:   Sun, 17 Feb 2019 17:09:09 +0700
Message-Id: <20190217100913.4127-28-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h     | 3 ++-
 sha1-name.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 9ff5af0bef..942d9912a2 100644
--- a/cache.h
+++ b/cache.h
@@ -1354,7 +1354,8 @@ enum get_oid_result {
 		       */
 };
 
-extern int get_oid(const char *str, struct object_id *oid);
+int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
+#define get_oid(str, oid) repo_get_oid(the_repository, str, oid)
 extern int get_oid_commit(const char *str, struct object_id *oid);
 extern int get_oid_committish(const char *str, struct object_id *oid);
 extern int get_oid_tree(const char *str, struct object_id *oid);
diff --git a/sha1-name.c b/sha1-name.c
index 64a50d1291..953df0d692 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1573,10 +1573,10 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
  * This is like "get_oid_basic()", except it allows "object ID expressions",
  * notably "xyz^" for "parent of xyz"
  */
-int get_oid(const char *name, struct object_id *oid)
+int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository, name, 0, oid, &unused);
+	return get_oid_with_context(r, name, 0, oid, &unused);
 }
 
 
-- 
2.21.0.rc0.328.g0e39304f8d

