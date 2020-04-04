Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D67C2BA17
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4F720731
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iet989v/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgDDBMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:12 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:42848 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDDBMI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:08 -0400
Received: by mail-qt1-f178.google.com with SMTP id b10so2484038qtt.9
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tV4CttSRYi3W8kfZBwVbwBrlQdEf9yrZCMb+DKzbL7w=;
        b=iet989v/XYCCrzTdd4rzHfjynWPCWjl3ICtYgTb1BZgUNHbrT1ZKIAOXWLawuE0OCF
         fk8DgaPf0erxrU7GVqpYkW5yOahRNzCGsiYThFqdR/yM4EzmeXLDabMpi2kZdud1SWKz
         tRm1QbTwUPA6gAYKiOZBqnowcA1242CIIi3U7RT899KEYw9IibqhdDx8Q17ct2zhCId8
         qG0LvWDQmxo7WSmidcbFUVCC2ShrMuZf8HIHnZLB/yZMgb5VFUB1PzrmsY6i18xLyMm1
         NKOhDYX6+K7mvwAuUQiS10qrdCjOkvGJGQ0QZIEa0eGza8bhRw7UXBZlWaeZRJ203JQi
         H9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tV4CttSRYi3W8kfZBwVbwBrlQdEf9yrZCMb+DKzbL7w=;
        b=ky59rF5iEUI4h7Cjts/PWxiFDyNFJiyiQroOIWqJUktW1c43GTkQ+6NtpW3in53piX
         H6uLfq3dGO/IIb2SHjZxufXxyuVFcyP+u8X4Sln6sgts/1r7dZgSY+IwfsAhkFAgxVqY
         8+tRBwMb3sa7x/TwTHXejxqLjWmDHbPPzWWpnpKPVyK5Uz63c1QR7GCBhtcb8/vSMX4S
         bmsjedefH5bKbeK5IjUfqil5x3fX4lY57lA6vGw1fnw/KSF/HggOrhweks+LKfqB4W4v
         wV5iLzo9rHLFU0DVGTpn0KrCvJ8xK7YB/xsPC3TxpMEBtiaEieFKjOlxPMAuj4HnXrhA
         S4SQ==
X-Gm-Message-State: AGi0PuaI3Gtp7x1LUq3ZW7EQc4TNW3CYQy4Tyfs/ZY99Zb6Byjj++a3H
        evcssQJWFipW3jphITszewr6N0Qq
X-Google-Smtp-Source: APiQypJs/ak2LSXmZcGjZ3JXJ+RRl9xAZBWvI4ZCCzwSrY5EBOSR/El87HfjFif2Aea2ZUJL0/J+3Q==
X-Received: by 2002:aed:25a7:: with SMTP id x36mr10772824qtc.203.1585962727095;
        Fri, 03 Apr 2020 18:12:07 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:06 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 08/23] sequencer: make read_oneliner() extern
Date:   Fri,  3 Apr 2020 21:11:21 -0400
Message-Id: <6c3c37994babdf4749e3edfcaa9075e6ee94524b.1585962673.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function read_oneliner() is a generally useful util function.
Instead of hiding it as a static function within sequencer.c, extern it
so that it can be reused by others.

This patch is best viewed with --color-moved.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 14 +-------------
 sequencer.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b771e8f4ca..d1d59867ae 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -419,19 +419,7 @@ static int write_message(const void *buf, size_t len, const char *filename,
 	return 0;
 }
 
-#define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
-#define READ_ONELINER_WARN_MISSING (1 << 1)
-
-/*
- * Resets a strbuf then reads a file that was presumably written by a shell
- * script, i.e. with an end-of-line marker that needs to be stripped.
- *
- * Note that only the last end-of-line marker is stripped, consistent with the
- * behavior of "$(cat path)" in a shell script.
- *
- * Returns 1 if the file was read, 0 if it could not be read or does not exist.
- */
-static int read_oneliner(struct strbuf *buf,
+int read_oneliner(struct strbuf *buf,
 	const char *path, unsigned flags)
 {
 	strbuf_reset(buf);
diff --git a/sequencer.h b/sequencer.h
index 718a07426d..1f6eda70b6 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -198,6 +198,20 @@ void print_commit_summary(struct repository *repo,
 			  const struct object_id *oid,
 			  unsigned int flags);
 
+#define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
+#define READ_ONELINER_WARN_MISSING (1 << 1)
+
+/*
+ * Resets a strbuf then reads a file that was presumably written by a shell
+ * script, i.e. with an end-of-line marker that needs to be stripped.
+ *
+ * Note that only the last end-of-line marker is stripped, consistent with the
+ * behavior of "$(cat path)" in a shell script.
+ *
+ * Returns 1 if the file was read, 0 if it could not be read or does not exist.
+ */
+int read_oneliner(struct strbuf *buf,
+	const char *path, unsigned flags);
 int read_author_script(const char *path, char **name, char **email, char **date,
 		       int allow_missing);
 void parse_strategy_opts(struct replay_opts *opts, char *raw_opts);
-- 
2.26.0.159.g23e2136ad0

