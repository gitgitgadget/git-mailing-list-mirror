Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB5BC7EE29
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 19:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbjFBT1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 15:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjFBT1H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 15:27:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABE3E44
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 12:27:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565ba5667d5so31167977b3.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 12:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685734022; x=1688326022;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/45rgaeWdA8wmxUwPjikAGcW5GGMK6jO+XZWoUFFDGA=;
        b=GByN+Y0NU/jVuiKnD2hlmXNzlFeU4NCUrpPoGmGo6tQPSi56QnXb4R12P4HZXGSi/n
         C9BYFNkGuIIeYRGLGwYZtsrHy5X1RdRft3J6SpFmekghshYtzJJhmwUy7VJM01u8fFqt
         huK+O9QpGK5ux2sTjJkSggV0s+eg1k21lFzYJR1jAQw091uSArdGEdazgSdd/TptyuD3
         yU8Jqk4vclikhOKpTzh1Bh/5Rmeu2oVjsUWcHJxg8WCucBfS6JCAeIO9RG6U2ownsugb
         Su2sE1N2cZmrX0TSiwWXmvsPeC6Mwg3traZAJFrSc3yMVb4E3as8sk1BjF/Zkf/xwhE2
         IbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685734022; x=1688326022;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/45rgaeWdA8wmxUwPjikAGcW5GGMK6jO+XZWoUFFDGA=;
        b=gAG4dIyBIFhSGo1UgU4F7mOWTnwtUIiX2kDApTrDZC1AH9s8r/+ZhdnzqsjzyP+IER
         0saH596bqpDQOn2/tbTACcWCeF7sS1F+F73XNtLHWY28paIUpyyaY+kvgOyDu57AqKNB
         a9qxp4/69wj9q11s5Ql5o5u47HUYcBnMMmW6bpmaPEUhPa/PuKusgF/B3dps7fbCO70g
         G2oJ6Bxo5xBB7fiRBTqbiXSrepytJxkMJYrCArwKvZq4DjXgQXmHZeVSBdKvgBVWtiBj
         caf+bWmhQppkyTcVU9g7AJrvfLpbkQN+dGaVh4iO0AZtLM/0YN7CNAWivqG5goVTsRE2
         RTmQ==
X-Gm-Message-State: AC+VfDygfsW3MAK9EaWG7ZWuMUqYnTiC7Yvt1BVQfu/hvXa6VVv4us9R
        zJ4FIYPMd/aO5WxxZGhL2A/y3jsdbhDn
X-Google-Smtp-Source: ACHHUZ5IJlD+VJjtyhvegXIk5ql0wyUKWCDduVHe8u2J+We8JlbBefU8d+atE65OHXPidcKe6wit8jQpl+6+
X-Received: from nayru.cam.corp.google.com ([2620:15c:93:4:46de:3427:10c3:915f])
 (user=asedeno job=sendgmr) by 2002:a81:4012:0:b0:565:ce25:2693 with SMTP id
 l18-20020a814012000000b00565ce252693mr430405ywn.3.1685734022672; Fri, 02 Jun
 2023 12:27:02 -0700 (PDT)
Date:   Fri,  2 Jun 2023 15:27:00 -0400
In-Reply-To: <CALVMLfLw4P=VnBOYA-WbHRNPZiAiO05h4k+cSvPJuaqkjgp5ew@mail.gmail.com>
Mime-Version: 1.0
References: <CALVMLfLw4P=VnBOYA-WbHRNPZiAiO05h4k+cSvPJuaqkjgp5ew@mail.gmail.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230602192700.1548636-1-asedeno@google.com>
Subject: [PATCH] statinfo.h: move DTYPE defines from dir.h
From:   "=?UTF-8?q?Alejandro=20R=20Sede=C3=B1o?=" <asedeno@google.com>
To:     asedeno@google.com
Cc:     asedeno@mit.edu, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>

These definitions are used in cache.h, which can't include dir.h
without causing name-hash.c to have two definitions of
`struct dir_entry`.

Both dir.h and cache.h include statinfo.h, and this seems a reasonable
place for these definitions.

This change fixes a broken build issue on old SunOS.

Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
Signed-off-by: Alejandro R Sede=C3=B1o <asedeno@google.com>
---
 dir.h      | 14 --------------
 statinfo.h | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/dir.h b/dir.h
index 79b85a01ee..d65a40126c 100644
--- a/dir.h
+++ b/dir.h
@@ -641,18 +641,4 @@ static inline int starts_with_dot_dot_slash_native(con=
st char *const path)
 	return path_match_flags(path, what | PATH_MATCH_NATIVE);
 }
=20
-#if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
-#define DTYPE(de)	((de)->d_type)
-#else
-#undef DT_UNKNOWN
-#undef DT_DIR
-#undef DT_REG
-#undef DT_LNK
-#define DT_UNKNOWN	0
-#define DT_DIR		1
-#define DT_REG		2
-#define DT_LNK		3
-#define DTYPE(de)	DT_UNKNOWN
-#endif
-
 #endif
diff --git a/statinfo.h b/statinfo.h
index e49e3054ea..fe8df633a4 100644
--- a/statinfo.h
+++ b/statinfo.h
@@ -21,4 +21,18 @@ struct stat_data {
 	unsigned int sd_size;
 };
=20
+#if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
+#define DTYPE(de)	((de)->d_type)
+#else
+#undef DT_UNKNOWN
+#undef DT_DIR
+#undef DT_REG
+#undef DT_LNK
+#define DT_UNKNOWN	0
+#define DT_DIR		1
+#define DT_REG		2
+#define DT_LNK		3
+#define DTYPE(de)	DT_UNKNOWN
+#endif
+
 #endif
--=20
2.41.0.rc2.161.g9c6817b8e7-goog

