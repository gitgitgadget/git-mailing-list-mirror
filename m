Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8BDC433F5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 15:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C823861AFE
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 15:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhJBPjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 11:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbhJBPjC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 11:39:02 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA651C0613EC
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 08:37:16 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id e66-20020a9d2ac8000000b0054da8bdf2aeso13327963otb.12
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/JvX+8t+AgOJ07MRcKAF9UWXQ6SNweuiJhcfiFtF/wY=;
        b=TqktmzOPNn65naKTSmamEg6gi+aTT38kKlX/OwcRtV6n6R3Nlcm1EMvrlQsYXEVr4M
         c3YdQRrSkge6djf56FTxM4AV1xbOD+lKLBdQmqj1YsUofpN6zWEvoF6+283ODPAvjpPS
         iptpVcWNJ3IyO/fVSiemYR9vkJpPf6Tx1jn74k9DBw7CP+Wg5K8s8nFq3EE+dnRZmOls
         1pVo7+BKjIbSidQKN480SsIscn96A/waTKLK7Luxh7RXH7Uj4gHnjme3HNMVgoVOkJ7v
         9sGGJvpWrqAYKrN3P5tpA5VkZIMRdqbygjTa40pOZAwjTRBQXeFTB0WOS1flJ8oW5LG8
         9N5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/JvX+8t+AgOJ07MRcKAF9UWXQ6SNweuiJhcfiFtF/wY=;
        b=DxEjvhaYTWXJrFl9CSMkB/LvaSKOMuuNEZUEw9Ox651wHkhClvTHXJbxD2LGidI3Q0
         2GwFk97xnMexuUxHoRB2I5+Ao2WCQggdHjvs8je4REhIex0R9GJ/ooXVpq1IpefYVw35
         7H7Oo8ZngPfMvWIVfcnV6zgWgCRAoZnUicZROiKHXF5dsatJuOEh8z9yH8SLcxIyk/3Z
         C9DWOO3GdVhpGHj3LE3rvYGyq/OWFiri/1YTmRcWgvfjpxGZTMPq8ompaeC/PmOcw2P1
         mEz0ZyAedxQp+3P4sF6s4WTz4DVkO9aKkEDlu87tP5YhtIUHTLwXmErOcRCFcVk0HaYn
         7LEg==
X-Gm-Message-State: AOAM532aMzLQaI5PIOdEgMgn1iQdGxgLGVJL66UfDxZwxS2pg04jMXfM
        tN3bXrHFl2ASspa4h8BreVL9vXSgKbU5zA==
X-Google-Smtp-Source: ABdhPJzxfzCcpxnTX7OfZ+E3Fyz15VGv8Imfj3ppo/yN4/oEvJz6nzS3wjg04pOyJ/z21F6U0zzVcw==
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr3137930oto.112.1633189036073;
        Sat, 02 Oct 2021 08:37:16 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id r188sm1719987oie.7.2021.10.02.08.37.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Oct 2021 08:37:15 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH 2/2] editor: save and reset terminal after calling EDITOR
Date:   Sat,  2 Oct 2021 08:36:54 -0700
Message-Id: <20211002153654.52443-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20211002153654.52443-1-carenas@gmail.com>
References: <20211002153654.52443-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When EDITOR is invoked to modify a commit message, it will likely
change the terminal settings, and if it misbehaves will leave the
terminal output as shown in microsoft/terminal#9359.

Instead use the recently added {push,pop}_term() functions to save
the terminal configuration and recover safely.

[1] https://github.com/microsoft/terminal/issues/9359

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 editor.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/editor.c b/editor.c
index 6303ae0ab0..9095841642 100644
--- a/editor.c
+++ b/editor.c
@@ -3,6 +3,7 @@
 #include "strbuf.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "compat/terminal.h"
 
 #ifndef DEFAULT_EDITOR
 #define DEFAULT_EDITOR "vi"
@@ -83,7 +84,9 @@ static int launch_specified_editor(const char *editor, const char *path,
 		p.env = env;
 		p.use_shell = 1;
 		p.trace2_child_class = "editor";
+		push_term(1);
 		if (start_command(&p) < 0) {
+			pop_term();
 			strbuf_release(&realpath);
 			return error("unable to start editor '%s'", editor);
 		}
@@ -91,6 +94,7 @@ static int launch_specified_editor(const char *editor, const char *path,
 		sigchain_push(SIGINT, SIG_IGN);
 		sigchain_push(SIGQUIT, SIG_IGN);
 		ret = finish_command(&p);
+		pop_term();
 		strbuf_release(&realpath);
 		sig = ret - 128;
 		sigchain_pop(SIGINT);
-- 
2.33.0.955.gee03ddbf0e

