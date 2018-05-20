Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469821F42D
	for <e@80x24.org>; Sun, 20 May 2018 10:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbeETKSg (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 06:18:36 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43146 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbeETKSf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 06:18:35 -0400
Received: by mail-wr0-f195.google.com with SMTP id r13-v6so842672wrj.10
        for <git@vger.kernel.org>; Sun, 20 May 2018 03:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QLb9dVMeWr6E9lAol4ISMTp4ASCV8zRhoPeD1+6WG7o=;
        b=MWEv4o3xRtvmaQIrz3lvV0OEfjwLu0ShNTB2z0lQfXl6WpMoI7lu23ThNTr68bLVZD
         AjLDwuJnRZqcgr+7h2JgTU93m7QP7tqQgRmHgQUSEbQ7att7yiCn8AuitK1ntTVCv4rO
         OfbUJ4Tezcvg7iakLdYh9slsKSadXw7qIknBB4Ia8GiewbqgJOaL7/ZeLPZfiimeiB41
         Yb4t+/juvocCOGEuA8TD6Gecg/qgxS9Y8FYo3Sl3xIbh2uwaZO3/ecY+4l7mVylXrb5G
         FGLLv7zDfmxGMHKUNdUsVG21pzho+caf3lsfuxi/SXyegK6ZDk4FG9JBPjvmZMw/gTGf
         vjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QLb9dVMeWr6E9lAol4ISMTp4ASCV8zRhoPeD1+6WG7o=;
        b=jCdJ/gr0MPQrpQGWghOMkg9F+DDDdM0AgqrjkoE+VcprklHsNIIQAnjrUVxck142Mm
         dVMaMqGZ9Yn6BGrE+g6hYM+HD4GjGqjEwUfCO6s1av1vj2D8gJlCPGEdpP7JpnByEIBV
         TlLiWad2ZlWSspZ8dKBTZEPWLvYnlKSeok9Zy9z0HdXH7/rYdwL3ajyro0gKiBdXGNA0
         ZGrL+Zxr58L+QRvkPZmMPEEjCv/VxK7WD645bjW+huoo356yzQcAgyqmFM7G8XXl2jv+
         4QbvN/bOsEm27Ro0/Q+33zGtR49C6ueUkenBFs1IENEx/8KtJHenE4bnC85IbhwOa92d
         pCKA==
X-Gm-Message-State: ALKqPwfsYapRcJMAqT+Ji1SylUolCB/Su1aPj7NGLlufOKmaQsA4dumg
        akrw6nZIskKhijGVPVeZdkgcRI13qGo=
X-Google-Smtp-Source: AB8JxZrUURcqw+mC2MYMks6fJY8ffkGDTig0M4N/2yNKzVW4AR7LvM1RoaSx6e6MGcIqjxA9FDM3mg==
X-Received: by 2002:adf:8049:: with SMTP id 67-v6mr4119337wrk.51.1526811513476;
        Sun, 20 May 2018 03:18:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id t189-v6sm10210374wmf.22.2018.05.20.03.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 May 2018 03:18:32 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 3/4] string-list: provide `string_list_appendf()`
Date:   Sun, 20 May 2018 12:17:36 +0200
Message-Id: <77b025bb47869478e3eef1c3c34d379164f5d91c.1526810549.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.840.g5d83f92caf
In-Reply-To: <cover.1526810549.git.martin.agren@gmail.com>
References: <CAN0heSp7DqxOy-UeLgj8t_T_4f-fNthMpGNS8oUbcs7+NvS-zw@mail.gmail.com> <cover.1526810549.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function `string_list_appendf(list, fmt, ...)` to the string-list
API. The next commit will add a user.

This function naturally ignores the `strdup_strings`-setting and always
appends a freshly allocated string. Thus, using this function with
`strdup_strings = 0` risks making ownership unclear and leaking memory.
With `strdup_strings = 1` on the other hand, we can easily add formatted
strings without going through `string_list_append_nodup()` or playing
with `strdup_strings`.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 string-list.h |  9 +++++++++
 string-list.c | 13 +++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/string-list.h b/string-list.h
index ff8f6094a3..3a73b86ffa 100644
--- a/string-list.h
+++ b/string-list.h
@@ -208,6 +208,15 @@ void string_list_remove_duplicates(struct string_list *sorted_list, int free_uti
  */
 struct string_list_item *string_list_append(struct string_list *list, const char *string);
 
+/**
+ * Add formatted string to the end of `list`. This function ignores
+ * the value of `list->strdup_strings` and always appends a freshly
+ * allocated string, so you will probably not want to use it with
+ * `strdup_strings = 0`.
+ */
+struct string_list_item *string_list_appendf(struct string_list *list,
+					     const char *fmt, ...);
+
 /**
  * Like string_list_append(), except string is never copied.  When
  * list->strdup_strings is set, this function can be used to hand
diff --git a/string-list.c b/string-list.c
index a0cf0cfe88..b54d31c1cf 100644
--- a/string-list.c
+++ b/string-list.c
@@ -224,6 +224,19 @@ struct string_list_item *string_list_append(struct string_list *list,
 			list->strdup_strings ? xstrdup(string) : (char *)string);
 }
 
+struct string_list_item *string_list_appendf(struct string_list *list,
+					     const char *fmt, ...)
+{
+	struct string_list_item *retval;
+	va_list ap;
+
+	va_start(ap, fmt);
+	retval = string_list_append_nodup(list, xstrvfmt(fmt, ap));
+	va_end(ap);
+
+	return retval;
+}
+
 static int cmp_items(const void *a, const void *b, void *ctx)
 {
 	compare_strings_fn cmp = ctx;
-- 
2.17.0.840.g5d83f92caf

