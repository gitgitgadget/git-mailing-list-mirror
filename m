Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA812C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 21:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjDRVAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 17:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDRVA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 17:00:28 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E0655AB
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 14:00:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a67d2601b3so19272835ad.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 14:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681851627; x=1684443627;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nglLCiysEYxgQ+/pRH14WiHlk9xApEEp7TrGJkmMBSk=;
        b=X5O7qYOb5se/0MnC/zjh0dkovxQoR0ihfbSxWBOvBbPAvIZq/vyaStarBEVu03a8ii
         WjHg2RTkAVgQy6OOE5poiSSevcbSdQt34P5NmhjBzTq55JJG+6oflEI0WfQQa9xFeIVD
         0uCmgdVHgIhFb79lKkyMWIOVo2THquTJeKeZRYzJXS+y2o/Sb+Sy6/V/sSs6KBa96s5t
         NWfnYTcpodf33SV0N8JrjBWK3btDQ9JA3JwkAykRCO5O/MegrBGqSNxMN6UlQBmpqIQZ
         IYyzly3nXD82sX9nl/xDho03TPKYRCLZCnTwrenw/9NlJhcU7hqBjc5hO/qvij9w9Jdg
         710g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681851627; x=1684443627;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nglLCiysEYxgQ+/pRH14WiHlk9xApEEp7TrGJkmMBSk=;
        b=MuzPnyygX5UL6trftLv0MsX3UhmueH9L0kwDY+D0JChm3qUQyPYxXVIjb1YGpPLT4V
         MV3AooIFu3Yii4sSC20qQbJVtVDoLIah/ou1oAJmOcnpqdJ2ukVLOpKWCDS67Ew/Rzjz
         8YFD74/UfpPBmLTGEoaVXT5iSzysCmL+Lfr1xCZLW7nKQKkj4dQMzBi8KKnqtYI6l3UJ
         TzM0ZzshM0WK4mBUuNe0tozsK4Vr4vHhoWD6Njco3HfcUTNOqdxggGnJMErwX/AE5XQc
         HR8IKEgC3U6WDEt9Z3Cq/BuLAC6YoKlEsKeaMpvglpmO0ctIGTBZhJoNdZfmFnOLk/tf
         QAbA==
X-Gm-Message-State: AAQBX9eACBlOjnVjWps82BwaKyy7z+Pjvi2sNANE9tWcMAXSPQMyQMrQ
        c1+Yefy9a01giVfU0TK+nf4=
X-Google-Smtp-Source: AKy350bgh9hrZZe6ceJuxYy5yfVu1rAuZbZmXu0KaTaw21kWKhI/qdgCAl/sKW6EzihT4NbnSl022w==
X-Received: by 2002:a17:903:2288:b0:1a5:2db2:2bb with SMTP id b8-20020a170903228800b001a52db202bbmr4315175plh.15.1681851627206;
        Tue, 18 Apr 2023 14:00:27 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902740100b001a67eace820sm10084825pll.3.2023.04.18.14.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:00:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH/RFD] fix connection via git protocol
References: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu>
        <20230416054735.3386065-1-newren@gmail.com>
        <xmqq5y9uo4kj.fsf@gitster.g>
        <CABPp-BEmzofRAmgoz7Wam-6btCYCTy4CiVnTOtr9aQdjS6TB7w@mail.gmail.com>
Date:   Tue, 18 Apr 2023 14:00:26 -0700
In-Reply-To: <CABPp-BEmzofRAmgoz7Wam-6btCYCTy4CiVnTOtr9aQdjS6TB7w@mail.gmail.com>
        (Elijah Newren's message of "Mon, 17 Apr 2023 18:55:07 -0700")
Message-ID: <xmqqwn28c3dh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I didn't know it was a fix for anything when I wrote it; it was in the
> 24-patch series just as a further refactoring.  Then I found out after
> this report and doing a little digging I found it might be considered
> a good fix for the issue so I included it here too.

Yup, let's queue it at the tip of (and as a part of) the base series
with a bit of explanation.  How does this look?

----- >8 --------- >8 --------- >8 --------- >8 -----
From: Elijah Newren <newren@gmail.com>
Date: Sun, 16 Apr 2023 03:03:05 +0000
Subject: [PATCH] protocol.h: move definition of DEFAULT_GIT_PORT from cache.h

Michael J Gruber noticed that connection via the git:// protocol no
longer worked after a recent header clean-up.  This was caused by
funny interaction of few gotchas.  First, a necessary definition

	#define DEFAULT_GIT_PORT 9418

was made invisible to a place where

	const char *port = STR(DEFAULT_GIT_PORT);

was expecting to turn the integer into "9418" with a clever STR()
macro, and ended up stringifying it to

	const char *port = "DEFAULT_GIT_PORT";

without giving any chance to compilers to notice such a mistake.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h    | 21 ---------------------
 daemon.c   |  1 +
 protocol.h | 21 +++++++++++++++++++++
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/cache.h b/cache.h
index 2f21704da9..71e2fe74c4 100644
--- a/cache.h
+++ b/cache.h
@@ -39,27 +39,6 @@
 #define S_DIFFTREE_IFXMIN_NEQ	0x80000000
 
 
-/*
- * Intensive research over the course of many years has shown that
- * port 9418 is totally unused by anything else. Or
- *
- *	Your search - "port 9418" - did not match any documents.
- *
- * as www.google.com puts it.
- *
- * This port has been properly assigned for git use by IANA:
- * git (Assigned-9418) [I06-050728-0001].
- *
- *	git  9418/tcp   git pack transfer service
- *	git  9418/udp   git pack transfer service
- *
- * with Linus Torvalds <torvalds@osdl.org> as the point of
- * contact. September 2005.
- *
- * See http://www.iana.org/assignments/port-numbers
- */
-#define DEFAULT_GIT_PORT 9418
-
 /*
  * Basic data structures for the directory cache
  */
diff --git a/daemon.c b/daemon.c
index db8a31a6ea..75c3c06457 100644
--- a/daemon.c
+++ b/daemon.c
@@ -4,6 +4,7 @@
 #include "config.h"
 #include "environment.h"
 #include "pkt-line.h"
+#include "protocol.h"
 #include "run-command.h"
 #include "setup.h"
 #include "strbuf.h"
diff --git a/protocol.h b/protocol.h
index cef1a4a01c..de66bf80f8 100644
--- a/protocol.h
+++ b/protocol.h
@@ -1,6 +1,27 @@
 #ifndef PROTOCOL_H
 #define PROTOCOL_H
 
+/*
+ * Intensive research over the course of many years has shown that
+ * port 9418 is totally unused by anything else. Or
+ *
+ *	Your search - "port 9418" - did not match any documents.
+ *
+ * as www.google.com puts it.
+ *
+ * This port has been properly assigned for git use by IANA:
+ * git (Assigned-9418) [I06-050728-0001].
+ *
+ *	git  9418/tcp   git pack transfer service
+ *	git  9418/udp   git pack transfer service
+ *
+ * with Linus Torvalds <torvalds@osdl.org> as the point of
+ * contact. September 2005.
+ *
+ * See http://www.iana.org/assignments/port-numbers
+ */
+#define DEFAULT_GIT_PORT 9418
+
 enum protocol_version {
 	protocol_unknown_version = -1,
 	protocol_v0 = 0,
-- 
2.40.0-352-g667fcf4e15



