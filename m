Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D16C83F01
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjH3S3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343754AbjH3Qo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 12:44:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827DB19A
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58d799aa369so80815517b3.0
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693413865; x=1694018665; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZhwDdbApNwGHpX7yhwEnVwUwJLYUxC1CUiIoORbjzE=;
        b=ej8rxz41keBDUcPaIccV6nxOmjT5ixp6Fbg6ipWa268q1l/hrs09wzCsu9zzIF5Oq2
         qrLZGcuYhd2L21UU/jHfZQn0yOfJXCszmUu6fKSG7IwOe3/YWMGxfPFaYgFjePj56Ueg
         CNkJLT1r5b3GHP/QZFJdYfv7C+bRqQtj+2nOqCo5eFtbn14k2nWVk7N/8xO3KXTmcapz
         P5dhAlbqgl2re9XpNGVaSAyknRa3OHGoW7wTRum0C9wm6xyWdSLD03YwPgQ84Jm7CDfT
         UlyxRJEi8jxHSfl9acMu9PYn7kA7pRL2wZRX5RC0+OlXJw4zW5jHcKFDX0Sk0pS+L5EF
         c+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413865; x=1694018665;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZhwDdbApNwGHpX7yhwEnVwUwJLYUxC1CUiIoORbjzE=;
        b=aSHorlXspp1VLPxEeNo30vdxqfYomW4xm5PiP1YaeylIELZ3gZesn7Vqk86mkfEC8+
         jIMZK8u1DFoa7qmlcD69pu5vwP0TcIPQBbY48Q+bV8SoUbdD59wVW+Q85obk7ikxB/Tz
         j4cHqVvRNjsWZIgP9vgdyl2ksulrxfiLEe6avIaQR0H9qlZNGJOkn5KVp8lwvxiiGJ+b
         2uu3W/i4ymfNs+PsIqS92pl4pQvttwHxh2slVNggOp7YXMmzJWUPsYCsbg/QqT7rU8iK
         o7JjZYCfiu6qgr+XjuiZOoiBv2X90TQWURny6KDHRTqEUCP5vzw57KR0MzrT/StjtoBw
         2vlA==
X-Gm-Message-State: AOJu0YwfJIEI9mXbM3T05e4VOn4+UqhyqxSh2N8qJvl09UBUZwn4Nur3
        UGueXEGCq4Or8NTpDpjVR+U8NkB3a1BbrsqXLquUUUTVfhpq89ES7WPHGj9fAUfQI0DS7bFvbfF
        YzeqDPLv6skekLu2DyxkXnlB2ekohzjFKwMYt4K7ciPZ6c6NvJMmZO97ANYxsLSINyN2WZ37WhC
        ii
X-Google-Smtp-Source: AGHT+IGZPxMUSaqRofR2vzyTueLkGLm1rO+VfNKOet+PsyXknczyQsfk0qXEScnVbYAduiaYK4FlfXE2uP1E1w9rt1t7
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:2899:32d6:b7e3:8e6e])
 (user=jonathantanmy job=sendgmr) by 2002:a25:c542:0:b0:d7b:9830:c172 with
 SMTP id v63-20020a25c542000000b00d7b9830c172mr79342ybe.0.1693413864781; Wed,
 30 Aug 2023 09:44:24 -0700 (PDT)
Date:   Wed, 30 Aug 2023 09:43:53 -0700
In-Reply-To: <cover.1693413637.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1692654233.git.me@ttaylorr.com> <cover.1693413637.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <a3b4e7ef599bea153b74ae9b7edcec3641797776.1693413637.git.jonathantanmy@google.com>
Subject: [PATCH v2 13/15] object.h: fix mis-aligned flag bits table
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "SZEDER =?utf-8?B?R8OhYm9y?=" <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Taylor Blau <me@ttaylorr.com>

Bit position 23 is one column too far to the left.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object.h b/object.h
index 114d45954d..db25714b4e 100644
--- a/object.h
+++ b/object.h
@@ -62,7 +62,7 @@ void object_array_init(struct object_array *array);
 
 /*
  * object flag allocation:
- * revision.h:               0---------10         15             23------27
+ * revision.h:               0---------10         15               23------27
  * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

