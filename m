Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D54C38A30
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 12:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE77214D8
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 12:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbwK4U05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgDSMc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgDSMc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 08:32:56 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC40C061A0C
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 05:32:56 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 131so5555448lfh.11
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 05:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TAqG+sVxGy+U9oDNxlIW2JQMI1m4Rts+GOsT6gbOdC4=;
        b=WbwK4U05Ba3DS+2enHz4tsKFrtV708ulH7uhZpRfaAobd0A5i/1zmrXuE1/HQb+0+o
         ALBkXET/QEJKbSDDl2HYCUbcjj1W0eQWBTE4HeJYSb3mtlymf0CnWGaEQUchSZ9fvRBf
         4uPjlUkDlgvtBFOVUsuqeO2gvf22CKTkMYhIF115q9m0tj4s/B45H/KYbBr3OF3Z2LJf
         ugzOsAvOBarLWw9YBB9BBYU96Mlw7YHIXEXThXSyWMcJPxN3z2clsFgtf8rs4jISp0ZY
         lx6eNfPDvpalmCW1bZALZIAwxK3nR4ZHRF08xmUofrGRBXqRoa9D6OnqNDrExMRzlcHG
         52VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TAqG+sVxGy+U9oDNxlIW2JQMI1m4Rts+GOsT6gbOdC4=;
        b=EHgCuIG+WvS0o6vUkYWUSFRA992Fth5Q1avNh7TQQhKX4FZgbOPhI3dC0odSXo3+Vu
         v3flQKCDITkk5jrIAMHW9LVdUrcLQE/jnI6WCTFr4c9vQoZGgB5jl0BxX0/fm8pJvzJF
         yJlkKubJRPQkWFJ2tOjuYitFpLmRRf2TgNYT85ZM+DKFdJODEhw/lifp6QLn0D+dkGpV
         x+RG8Ah4HoxpeX6vEMzt6XG0VC+xldRJUWM7bBeuA2Um0HDQUV+0uUS5bEIrfW5v2fS8
         JvXU2kOeDgjR3FMArkBxHktxBitMqEZRBUOWlzTdYjIbELiDhfEfTcZ2tG9yA6m3zZZI
         b95A==
X-Gm-Message-State: AGi0PuZxuib1D3i51Gf3Yax7UBuKjYgOcNrom7VDsyCUAveql3FZWw20
        Ed21Uw2c5lRjlBDNz4iCCc78W9sM
X-Google-Smtp-Source: APiQypLAaW8WirpahBsBoMzmZChALdnJZ7pW3TULL80kOKxf0Qfi/BHwI7mX0s1eXeXsgS3Gp/Ywag==
X-Received: by 2002:ac2:5c45:: with SMTP id s5mr7516248lfp.28.1587299574594;
        Sun, 19 Apr 2020 05:32:54 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id 73sm1843547ljj.72.2020.04.19.05.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 05:32:54 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 4/4] strbuf_attach: prefer `strbuf_attachstr_len()`
Date:   Sun, 19 Apr 2020 14:32:30 +0200
Message-Id: <80a7f7570540e847ec986c5f3f8a6f4845866f8b.1587297254.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587297254.git.martin.agren@gmail.com>
References: <cover.1587240635.git.martin.agren@gmail.com> <cover.1587297254.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the last few commits, we don't have many users of
`strbuf_attach()`.

Convert the sites in builtin/am.c, strbuf.c and mailinfo.c. They pass in
the same length twice for `len` and `mem` and will eventually hit
`realloc(3)`, which will be a no-op. The string in am.c has been
constructed using the strbuf machinery in `read_commit_msg()`. In
strbuf.c, we've used `reencode_string_iconv()`.  In mailinfo.c, we used
`reencode_string_len()`. So in all cases, we really do have an extra
byte at the end with a NUL.

As explained in the previous commit, it's not just that we avoid calling
`realloc()` to make room for a single NUL byte that we already have, we
avoid asking it for 16 more bytes and another 50% on top of that.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin/am.c  | 2 +-
 fast-import.c | 2 +-
 mailinfo.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index e3dfd93c25..d777855c98 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1101,7 +1101,7 @@ static void am_append_signoff(struct am_state *state)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	strbuf_attach(&sb, state->msg, state->msg_len, state->msg_len);
+	strbuf_attachstr_len(&sb, state->msg, state->msg_len);
 	append_signoff(&sb, 0, 0);
 	state->msg = strbuf_detach(&sb, &state->msg_len);
 }
diff --git a/fast-import.c b/fast-import.c
index 202dda11a6..28fbc4792b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2946,7 +2946,7 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
 	cat_blob_write("\n", 1);
 	if (oe && oe->pack_id == pack_id) {
 		last_blob.offset = oe->idx.offset;
-		strbuf_attach(&last_blob.data, buf, size, size);
+		strbuf_attachstr_len(&last_blob.data, buf, size);
 		last_blob.depth = oe->depth;
 	} else
 		free(buf);
diff --git a/mailinfo.c b/mailinfo.c
index c31991e621..942c363bfd 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -461,7 +461,7 @@ static int convert_to_utf8(struct mailinfo *mi,
 		return error("cannot convert from %s to %s",
 			     charset, mi->metainfo_charset);
 	}
-	strbuf_attach(line, out, out_len, out_len);
+	strbuf_attachstr_len(line, out, out_len);
 	return 0;
 }
 
-- 
2.26.1

