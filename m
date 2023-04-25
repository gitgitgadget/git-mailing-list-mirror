Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29830C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 13:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbjDYNff (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 09:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbjDYNfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 09:35:25 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D3714472
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 06:35:01 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63d4595d60fso35577726b3a.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682429700; x=1685021700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxfrPVhKhQIlZ611smztCd2CT7/Nt7vjpdSoqTlSgwI=;
        b=c0M2T9KjznvIlqWilJfKBJCm/PpXK5KW1OXQX9sRNAeiiYl9zC3UTnPmV8V/uWO13j
         ctcOobrqFSYqdW3OJ/cey504hoYYPpNKoUywXZC4sq8yv7Kx8vO6ZqbTXzzYZoItjMT/
         KqOeHOnvvf+7esjeKh96ePZZiK0PvTlNBLp2IMUgPnA/uhaYuC3qIXZgfjFaiwWz0+r3
         JAi4fLlNxpFP142FbJ1fZNYMCurzaDQRrM0fDIikO923BY/jRO0ZV98M8eHUprzCpbOS
         NyKPovg7dZwhBXP8+wIU4GPjdWkieD4q+G1fBXzeFmyzkjl3vQwL1PAYa5K+mUDZdSDE
         4BJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682429700; x=1685021700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxfrPVhKhQIlZ611smztCd2CT7/Nt7vjpdSoqTlSgwI=;
        b=TCHDmyimo8gXMvhEqw0uK4DByEEeyUVcxx89YLc4j7n/5GqD/zlMO8D3sX7c5JxHk9
         txU1MXzP9hjUThcaIRuNRhVg40HwPO7p+aBWIDtkna2CWaxEmvi65fG5aoBtlybOF7VY
         +ahCPgpxzho63ZOIQbuS5AcNLq9XY/5EEIn3LsGuGUR1tR6NiCJOCfmlitzAyEm3TLh3
         6NGONSJSlM4ykPUWBfmRPK8yaUmdwAZAREAvs2UMQ27E7Gz0A+Yj8wBXUrVbERQFM0SS
         ra1gkOQbH9q8Sn00vWu5IiyxvDMv+9IAmGFufMoLGo4yLd8kWsmcBBTMAKwWQa54Isne
         /Img==
X-Gm-Message-State: AAQBX9cpGDMSQI8XnFbylpslBah2oatPaNPkF9h2IJtGKkRho6r+WBb+
        +7tOGblfAVpa8dXoIlynmWw=
X-Google-Smtp-Source: AKy350Z7LWm+BWFhpXEcxbxqoHsRmMHMDWI5KIDPcghWk0B+DuSn5vONOUpB5jU0LcpZep6DSjY24w==
X-Received: by 2002:a05:6a21:6da2:b0:ee:3ddf:9737 with SMTP id wl34-20020a056a216da200b000ee3ddf9737mr18497265pzb.28.1682429699594;
        Tue, 25 Apr 2023 06:34:59 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id c192-20020a621cc9000000b0063d44634d8csm9243469pfc.71.2023.04.25.06.34.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2023 06:34:59 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v8 5/6] notes.c: append separator instead of insert by pos
Date:   Tue, 25 Apr 2023 21:34:40 +0800
Message-ID: <ef40e0efc34ce6b6ee5b9b67bdde3dae02652cec.1682429602.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.358.g931d6dc6
In-Reply-To: <cover.1682429602.git.dyroneteng@gmail.com>
References: <cover.1682429602.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

This commit rename "insert_separator" to "append_separator" and also
remove the "postion" argument, this serves two purpose:

The first is that when specifying more than one "-m" ( like "-F", etc)
to "git notes add" or "git notes append", the order of them matters,
which means we need to append the each separator and message in turn,
so we don't have to make the caller specify the position, the "append"
operation is enough and clear.

The second is that when we execute the "git notes append" subcommand
, we need to combine the "prev_note" and "current_note" to get the
final result. Before, we inserted a newline character at the beginning
of "current_note". Now, we will append a newline to the end of
"prev_note" instead, this will give the consisitent results.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/notes.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 6ae8b57b..84bc09ed 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -230,14 +230,14 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
 	}
 }
 
-static void insert_separator(struct strbuf *message, size_t pos)
+static void append_separator(struct strbuf *message)
 {
 	if (!separator)
-		strbuf_insertstr(message, pos, "\n");
+		strbuf_insertstr(message, message->len, "\n");
 	else if (separator[strlen(separator) - 1] == '\n')
-		strbuf_insertstr(message, pos, separator);
+		strbuf_insertstr(message, message->len, separator);
 	else
-		strbuf_insertf(message, pos, "%s%s", separator, "\n");
+		strbuf_insertf(message, message->len, "%s%s", separator, "\n");
 }
 
 static void concat_messages(struct note_data *d)
@@ -247,7 +247,7 @@ static void concat_messages(struct note_data *d)
 	size_t i;
 	for (i = 0; i < d->msg_nr ; i++) {
 		if (d->buf.len)
-			insert_separator(&d->buf, d->buf.len);
+			append_separator(&d->buf);
 		strbuf_add(&msg, d->messages[i]->buf.buf, d->messages[i]->buf.len);
 		strbuf_addbuf(&d->buf, &msg);
 		if (d->messages[i]->stripspace)
@@ -682,14 +682,17 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		/* Append buf to previous note contents */
 		unsigned long size;
 		enum object_type type;
-		char *prev_buf = repo_read_object_file(the_repository, note,
-						       &type, &size);
+		struct strbuf buf = STRBUF_INIT;
+		char *prev_buf = repo_read_object_file(the_repository, note, &type, &size);
 
-		if (d.buf.len && prev_buf && size)
-			insert_separator(&d.buf, 0);
 		if (prev_buf && size)
-			strbuf_insert(&d.buf, 0, prev_buf, size);
+			strbuf_add(&buf, prev_buf, size);
+		if (d.buf.len && prev_buf && size)
+			append_separator(&buf);
+		strbuf_insert(&d.buf, 0, buf.buf, buf.len);
+
 		free(prev_buf);
+		strbuf_release(&buf);
 	}
 
 	if (d.buf.len || allow_empty) {
-- 
2.40.0.358.g931d6dc6

