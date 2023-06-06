Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04CFC77B73
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 02:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjFFCIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 22:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjFFCIe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 22:08:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E312A
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 19:08:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so19941675e9.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 19:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686017311; x=1688609311;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qF9ZICbcyWdKLQ2q5HFZV8YkdUD9NJai6d7eys1IsDU=;
        b=oa4qR0hzpK8088Pq/EkeVQvzUgu4dfUzsL80bQrlNBA9lMq5ZqpYTPA41OO8Ula7MD
         sMH6QGjCUJWc9KUscjUWn/RRCOvIY/brMFP8YbYemZ2R2sjXgCcVT9VVfB8IxKjFeYGw
         aa6Q3bVrWZw1QaLlxitfNEYnye59A4XQ/k5xt0JbBLbL1QkLbTVf7KzAgDel/XYq64+W
         1gX3TwCAnppWAhf2qEgRK3RKe8KRoLR9vyevXPs8eDIThOfXJ8hPSTlQ+e/snJhP0hGl
         I5/mvBcElUUnAGrjQ5b5YHKdPpxqcbj0UQtip7TDjAQLz2CuUV5A++imgP8VOuJe5+0S
         h4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686017311; x=1688609311;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qF9ZICbcyWdKLQ2q5HFZV8YkdUD9NJai6d7eys1IsDU=;
        b=kM3a3SAHmSXCxLN+ufI/625msimixYIg97hF+UwJF1WFoE+1+WTlDqMx2aNhY+J8NW
         xpoKR7eNdOVXUHwWw1vnvMBRWSvq++tuOQk9yKWi62tqP9o8V+e3y2U56T1BmJnR/HqP
         3ijw4XJuTbtyfm6/LRrK+F5JsDX949+oQR5ocz3x5HFGe09vTwmEU0oq///Z4Ux8QaZ1
         NsJN9LLA6T8ldISnc9bo8U2xnNvkQ+NwRoI/R09euSagQSTYHZuArLSoGZvh5gHh5IAW
         9A5yH1dKgOnS5QHXQbHPhBrTjQ+TNqefJNxWRm6f9sUE4gIsrH9pjQaYlkRXbsBfJKhU
         jMcw==
X-Gm-Message-State: AC+VfDztF5Ldu/rfASiE4uKMRccaBy0R1B8w65NP8pwULzbLvuh4GlbH
        oO7eH82Qkx6rjClOTwJrI93Ek61BhoU=
X-Google-Smtp-Source: ACHHUZ7jP+X7O4s9bdAmH9yZhTQO1q2GrACK56hIQBruHS99Q8fhSFUx0lbWP3HgwGWmnoCroP+SGQ==
X-Received: by 2002:a5d:4488:0:b0:30e:3f54:f8c9 with SMTP id j8-20020a5d4488000000b0030e3f54f8c9mr492861wrq.10.1686017310991;
        Mon, 05 Jun 2023 19:08:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9-20020a5d5689000000b0030ae93bd196sm11194374wrv.21.2023.06.05.19.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 19:08:30 -0700 (PDT)
Message-Id: <ec43e192d6eae0daa70c8cbf3a35bcee2f4b38af.1686017304.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
        <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jun 2023 02:08:24 +0000
Subject: [PATCH v3 9/9] doc: trailer: add more examples in DESCRIPTION
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Be more up-front about what trailers are in practice with examples, to
give the reader a visual cue while they go on to read the rest of the
description.

Also add an example for multiline values.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 2e92640543c..2e999320ec6 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -16,7 +16,18 @@ DESCRIPTION
 -----------
 Add or parse 'trailer' lines that look similar to RFC 822 e-mail
 headers, at the end of the otherwise free-form part of a commit
-message.
+message. For example, in the following commit message
+
+------------------------------------------------
+subject
+
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
+
+Signed-off-by: Alice <alice@example.com>
+Signed-off-by: Bob <bob@example.com>
+------------------------------------------------
+
+the last two lines starting with "Signed-off-by" are trailers.
 
 This command reads commit messages from either the
 <file> arguments or the standard input if no <file> is specified.
@@ -71,7 +82,12 @@ When reading trailers, there can be no whitespace before or inside the
 between the <token> and the separator. There can be whitespaces before,
 inside or after the <value>. The <value> may be split over multiple lines
 with each subsequent line starting with at least one whitespace, like
-the "folding" in RFC 822.
+the "folding" in RFC 822. Example:
+
+------------------------------------------------
+token: This is a very long value, with spaces and
+  newlines in it.
+------------------------------------------------
 
 Note that trailers do not follow (nor are they intended to follow) many of the
 rules for RFC 822 headers. For example they do not follow the encoding rule.
-- 
gitgitgadget
