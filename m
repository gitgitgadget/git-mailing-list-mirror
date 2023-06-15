Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8FFEB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 02:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbjFOCyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 22:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbjFOCyD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 22:54:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102E926B1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:59 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f8d2bfed53so2040925e9.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686797637; x=1689389637;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1wHIMc14oKw4VoARADU2G/8t1T1JXAvLDNQoCO54L0=;
        b=IRX8UGzhrBDmuSb4WSxS+VNYe96+21zn0VWviUxYDxCPpvrQ5gcOk+9BysmeDHatRY
         LgyUNKdgKPyp2/0H+dLPpr9y40r+q0jUyWvOCY4I/2nSV3+3QEGJUTo0iASt6DpKDi8y
         98XAmhxfvR9MaWwgQQ+oB+zsqmnRhzK9wScyPNrnecg/INK7GujdKwvfMZaFQo5k6+vd
         q0ETK1ZiJfKD9n/jpHz9l96VxmQQ1sGfhgUB50xzxwni+VLzOmP5TYPJzStceGdT7crD
         9hsPewDFBOCw/XdHHgbsAQMo2PqwAPvt7Vq3I3XgLVO2HCtoegHrLRZSL/0gOKVODtT9
         FFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686797637; x=1689389637;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1wHIMc14oKw4VoARADU2G/8t1T1JXAvLDNQoCO54L0=;
        b=MA3bXodqPe1kMm95EpdfkJzMY7Svc5v4513w3EgoT2jxpLM1ZuLU1riyB7azJmwv4R
         3ioqN0UzSSAiezy3rynlELkjZrz6sdTDgeL67nX8WMSv4Imw3FbqxifviMaG5RziTPWq
         x4jIWBaUtzWBwKU/K1z3MOxNcJ9yL5sAMjJXaRJAscRVQEgiMKnq0arVWYkGgWH6Wj9Y
         Do+ArD+YlP2BWeFqGSt0Kpev2I7cqhZGOY0MfraxWwa91UEe/y99gK6U75+bVrE8fOAn
         uvO6xlL9VqzY4KiERm6eYWYcTYpiPVDaWdbg7jJCjj965L+eqtlRJ1jZ90T7oFskzMF1
         anKQ==
X-Gm-Message-State: AC+VfDwZrzuxzVEGUPjEfgqr4k8LVnbYyX/1h9pvXkowZA9nGPzIZ1mB
        KAG3BO48MajF/p3pUn7bdgHKXzYMBDs=
X-Google-Smtp-Source: ACHHUZ4VoJmda0RWXlpZjoZO8vuHPPT2FeJmhRQYHQDuylu5myo+cQ0/ocIdIJcKkExFJcv2lqY0dA==
X-Received: by 2002:a7b:ce09:0:b0:3f7:9b05:928e with SMTP id m9-20020a7bce09000000b003f79b05928emr2882735wmc.0.1686797637301;
        Wed, 14 Jun 2023 19:53:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c22ca00b003f427687ba7sm18906393wmg.41.2023.06.14.19.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 19:53:57 -0700 (PDT)
Message-Id: <604265c54dff9b2f16b8bf3b1964cae6280b756c.1686797630.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
References: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
        <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jun 2023 02:53:49 +0000
Subject: [PATCH v4 8/9] doc: trailer: mention 'key' in DESCRIPTION
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

The 'key' option is used frequently in the examples at the bottom but
there is no mention of it in the description.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 6016af5c203..7e77cbb1cad 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -49,7 +49,10 @@ token: value
 ------------------------------------------------
 
 This means that the trimmed <token> and <value> will be separated by
-`': '` (one colon followed by one space).
+`': '` (one colon followed by one space). For convenience, the <token> can be a
+shortened string key (e.g., "sign") instead of the full string which should
+appear before the separator on the output (e.g., "Signed-off-by"). This can be
+configured using the 'trailer.<token>.key' configuration variable.
 
 By default the new trailer will appear at the end of all the existing
 trailers. If there is no existing trailer, the new trailer will appear
-- 
gitgitgadget

