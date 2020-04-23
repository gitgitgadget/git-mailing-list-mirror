Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1766C55186
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A372077D
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKDU2pKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgDWNsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728339AbgDWNsI (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 09:48:08 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAE2C08E934
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:48:08 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so1744030pfv.8
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6zDL6Rv0DnD2NZ1626U0EgnwYOqorHsi3rL2txzD9pc=;
        b=TKDU2pKww2xP9WuWYovbVtpIR7MrbKxOi8xYaJgrv9Gf+KzeTnwIM5CoqZZLr/JD4w
         JJ6ctBDEwOHIKPaYAjDChW7J4ZdPe5vgJLgXn1q4Pf8KZShEFfM9Z5+JiqemPCBmxjFw
         LyBC0a0ck2w82RMvfdxpK36GiqCidiNppekBo/uXf9OaxkCZA4m9cbDDx3MsQ+H1Anj6
         iv7p4Pl9539qsBsGxRqZkV2lCu2zWjAWIz9bgk8MsJrKXTEKqwkQUqIkWmQUeG/PTxwQ
         H8sM6382XV11kW35CYJ6YVnC4//R8ifCIoKhGjMhDQ6c2DdNlcmkSLLPbrr7fE2aBD6d
         L7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6zDL6Rv0DnD2NZ1626U0EgnwYOqorHsi3rL2txzD9pc=;
        b=Ri3zWuwXwLR4QflQukvzBk/3k2GYkWdwndEDtJ5cYR3dapDWiGhwmwbl9P00veVfpY
         zqaJcM/YhBV4cWU+z6oW1IzKOgZaLqSG82oeU7arSIR7bwD3rcUpvaPqY5QFFN/qoAF+
         KYkPEzDmvnNjwSda5rnCh+CGYcYVowb9/F13k/O/t2HERzYoLxkmBa1V+EC/z3ya0CDz
         s2B9ZFPVp5HrhKFUThyiBrJlkLmVk0yQnoTLmXmZ217EwRTY0KTY9TZCpfQrplUXLoGj
         ocp3t7KMPVwez/ifpGuu93HpOQpajmQMz4iXWh8UeFWdV5dba+96k/Dc+C14L6dsO41E
         FXYg==
X-Gm-Message-State: AGi0PubfpkZD+QcqsUoup1umV7V5dgY2pZEUzcPsyt28A5ADNTMa+QJq
        ThRQOYBlWmjZLiKe+sgOy3wpx2fJ
X-Google-Smtp-Source: APiQypIhV0LCfFlEKP5BxWIcvJk59AXrHq8LbZALcfuWa1S2bi/KlbGt19qUz6LRv41OAFU7h8wd5A==
X-Received: by 2002:a63:4f65:: with SMTP id p37mr4220716pgl.60.1587649687568;
        Thu, 23 Apr 2020 06:48:07 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id z23sm2635958pfr.136.2020.04.23.06.48.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 06:48:07 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 2/4] compat/regex: silence `make sparse` warning
Date:   Thu, 23 Apr 2020 20:47:54 +0700
Message-Id: <25f595f56f7f895ab31bf7269aabad9142c0590c.1587648870.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.384.g435bf60bd5
In-Reply-To: <cover.1587648870.git.congdanhqx@gmail.com>
References: <cover.1587648870.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* alloca: somewhere later in the code, we indirectly include alloca.h
which will define alloca again, include it prior to define alloca in
order to not define it against.

* Copy all attributes from the header to source file, and move the
  attributes prior to function name. cgcc is very picky on the position
  of attribute.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 compat/regex/regex.c          | 1 +
 compat/regex/regex_internal.c | 2 +-
 compat/regex/regex_internal.h | 5 ++---
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index f3e03a9eab..4bef75a716 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -62,6 +62,7 @@
 #include <stdint.h>
 
 #ifdef GAWK
+#include <alloca.h>
 #undef alloca
 #define alloca alloca_is_bad_you_should_never_use_it
 #endif
diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
index ec51cf3446..58504f795b 100644
--- a/compat/regex/regex_internal.c
+++ b/compat/regex/regex_internal.c
@@ -921,7 +921,7 @@ re_string_destruct (re_string_t *pstr)
 /* Return the context at IDX in INPUT.  */
 
 static unsigned int
-internal_function
+internal_function __attribute ((pure))
 re_string_context_at (const re_string_t *input, int idx, int eflags)
 {
   int c;
diff --git a/compat/regex/regex_internal.h b/compat/regex/regex_internal.h
index 3ee8aae59d..c61a1e4971 100644
--- a/compat/regex/regex_internal.h
+++ b/compat/regex/regex_internal.h
@@ -430,9 +430,8 @@ static reg_errcode_t build_wcs_upper_buffer (re_string_t *pstr)
 # endif /* RE_ENABLE_I18N */
 static void build_upper_buffer (re_string_t *pstr) internal_function;
 static void re_string_translate_buffer (re_string_t *pstr) internal_function;
-static unsigned int re_string_context_at (const re_string_t *input, int idx,
-					  int eflags)
-     internal_function __attribute ((pure));
+static internal_function __attribute ((pure))
+unsigned int re_string_context_at (const re_string_t *input, int idx, int eflags);
 #endif
 #define re_string_peek_byte(pstr, offset) \
   ((pstr)->mbs[(pstr)->cur_idx + offset])
-- 
2.26.2.384.g435bf60bd5

