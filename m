Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656BEC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B86660FC1
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhJ1UxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhJ1UxL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 16:53:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3074FC0613B9
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:50:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b12so7946078wrh.4
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yu1dICMBoWKbOVp013Ja9I8dWIsf9vmiXFjRDgFo3G4=;
        b=dsIE4nw5RUttDxaXiilZHO9rCtgpz+o6P+WZc8+BtpFePD9YgcUMNyNtAi0YbfGASH
         uZOpXIatv8aKoob8/9OufaQTvSqVbeHvVF0aemNw8bUUuNQ8LWRaFyCoHfYc496/8R9u
         l8Q/D84xLbUivCXQZSCFn67DZEBvkmS+jdcyqHk6NNAl5qbvVsGyX7jntIgKYzDJmmbs
         Yjfysmtn/2qtNRfC27K3kH1zQVy6LDvGxqAINO39mZvTqs0uckyj+TFydridOOTomT1T
         T6ecg6bgOqIOeKIZhNH+5jVzXlnp+2tbM7Y7ZIuCvdHM4JXrgXe139F0LgZ3x+Wtyn7G
         ITcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Yu1dICMBoWKbOVp013Ja9I8dWIsf9vmiXFjRDgFo3G4=;
        b=2xS2rg8z4qPyeH/jXD47/GmCQrXsMjdiyVxznj1cd+BK6S2xguJKeVdkO4DMvo2Iqv
         OEVjlOLXmMHXJqOrnuSR6FzNrIQuyy76/xSVsYK5WEE3uRRK1TTvvx3zfFZGw5dW8Y8O
         PDP0y5G0LS8NAan9Rp6wKUgcoiBEC/VWGcW6hTYJP1YuwiPZN5ncpBXdYsx74XqXqUmn
         s1ujUzdMquX0XI+J+BOGDBYGUeA8eJWhyWwObIIWaPhXPk0nc3ZDWthprIpPNUWK0uRR
         Ow8mBWxwDUWNAlMZEYQMEMYcnfeLrPE7CI2QhpZQExvCaMcw4xFcSOTf1hXI7XmG/cw6
         ZxTg==
X-Gm-Message-State: AOAM532qjzRF7I4WkTNtEhGnL/0SEvdcPGTPbYC8hyAs1e2l22cD93hp
        e4o2DN7Na0DpeXVM1iQTrzmvNMgR06M=
X-Google-Smtp-Source: ABdhPJxOfWoQPJ9NSTGd6kkOdtxjXE2X0qH63Dsg/OTWlWKQv2y2dUCeCKs2NOaF8W75jUotl/aKFQ==
X-Received: by 2002:a05:6000:18ae:: with SMTP id b14mr8625621wri.263.1635454241842;
        Thu, 28 Oct 2021 13:50:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o194sm8018157wme.40.2021.10.28.13.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 13:50:41 -0700 (PDT)
Message-Id: <32472ae3f98bbe0162b39a16109522ec18026404.1635454237.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
        <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 20:50:35 +0000
Subject: [PATCH v2 5/7] git-compat-util: introduce more size_t helpers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We will use them in the next commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-compat-util.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index a508dbe5a35..7977720655c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -113,6 +113,14 @@
 #define unsigned_mult_overflows(a, b) \
     ((a) && (b) > maximum_unsigned_value_of_type(a) / (a))
 
+/*
+ * Returns true if the left shift of "a" by "shift" bits will
+ * overflow. The types of "a" and "b" must be unsigned.
+ * Note that this macro evaluates "a" twice!
+ */
+#define unsigned_left_shift_overflows(a, shift) \
+    ((a) > maximum_unsigned_value_of_type(a) >> shift)
+
 #ifdef __GNUC__
 #define TYPEOF(x) (__typeof__(x))
 #else
@@ -859,6 +867,23 @@ static inline size_t st_sub(size_t a, size_t b)
 	return a - b;
 }
 
+static inline size_t st_left_shift(size_t a, unsigned shift)
+{
+	if (unsigned_left_shift_overflows(a, shift))
+		die("size_t overflow: %"PRIuMAX" << %u",
+		    (uintmax_t)a, shift);
+	return a << shift;
+}
+
+static inline unsigned long cast_size_t_to_ulong(size_t a)
+{
+	if (a != (unsigned long)a)
+		die("object too large to read on this platform: %"
+		    PRIuMAX" is cut off to %lu",
+		    (uintmax_t)a, (unsigned long)a);
+	return (unsigned long)a;
+}
+
 #ifdef HAVE_ALLOCA_H
 # include <alloca.h>
 # define xalloca(size)      (alloca(size))
-- 
gitgitgadget

