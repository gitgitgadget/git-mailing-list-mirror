Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA881C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348258AbiBDXsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbiBDXsp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:48:45 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5B1E0090B1
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 15:48:42 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id f17so14082509wrx.1
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 15:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7tSCnKlilEMtmbvfnJOSly7qrkNkrxedFOl38ZcdJlw=;
        b=jOcVKWV4aImq0NSh71alax2k5UyAcNLtz/H8tqu/Jw9c++jUmICXQgUjyA+0yGkFJa
         XjTi/cGZR7HI7cnmKx4Awpf2sCJdyEhDFr5XYoN2VTZt6JGybLOZDPUjV+Upcd06NyWB
         ONF4CuyKM+NJlakFS0YlEGdaYMhp4kOFa8gng8ZWvHrLoydBgPf336WWALMmroR8WA+v
         l68oRnTE37HFP4NuCZESVg1BxLXQhIzA8mKSJQXqcbqkDxWo6bbg0jv8jE62m9uQJ/8T
         hwc4JaYXE7IXK9+yBy7ooThH7KDhWpYaQiaOHJcRD9qMuez6JyVrhaulZ+9Qu4UDeJ3y
         csgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7tSCnKlilEMtmbvfnJOSly7qrkNkrxedFOl38ZcdJlw=;
        b=VyxhN65wAeJ0ij+KFo6kWnKK1aDCVzZp1NaCUgu1FwodG6n2+NgxPNnUZlo+kE9av2
         I5gEw2ti3GFD73qorMV3tu2fmPL/MSOKgmxirwfGvvzXG3JLdexkVSGd4CbYQF0XwFAb
         aYlbuArfAD+mL7Hnw+GiNAITH4otd8WitHvp0Lo8YkHulCq4BYlXTzpy8hmvVms07w0Q
         JWUzF08fHpS0xCZjzYw3vanFlxTkiYvgb9clm4FcqjdZhXN/GVe5x8FbJr/r9/5ojFOg
         X9p0bJUF6FTSBYaSnEmyZspWFHKWWwbbyHl/XzLrIXohvb8FHn6zsXoBXXhONigpy63O
         7f4Q==
X-Gm-Message-State: AOAM5324aC8JTHCpsShjTkqZ1FaUGeR3q2G1wb/OEFnCF9fowM7ZakKp
        7Pww+i0gFysu/4gwaLGCThEMhA+C5nbGSA==
X-Google-Smtp-Source: ABdhPJwL1ghAPZJalO7q2/frofLQwsH3u85YhPKO8c7eGAz0paTVdhRPjsiC2GeAGPPnda0zOe6EZg==
X-Received: by 2002:a5d:6dc5:: with SMTP id d5mr970034wrz.23.1644018521071;
        Fri, 04 Feb 2022 15:48:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16sm2724042wmq.21.2022.02.04.15.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:48:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/12] object-file.c: split up declaration of unrelated variables
Date:   Sat,  5 Feb 2022 00:48:23 +0100
Message-Id: <patch-v3-01.12-53334bc970a-20220204T234435Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the declaration of the "ret" and "re_allocated"
variables. It's not our usual style to group variable declarations
simply because they share a type, we'd only prefer to do so when the
two are closely related (e.g. "int i, j"). This change makes a
subsequent and meaningful change's diff smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 8be57f48de7..ecc77973292 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2118,7 +2118,8 @@ static int index_mem(struct index_state *istate,
 		     enum object_type type,
 		     const char *path, unsigned flags)
 {
-	int ret, re_allocated = 0;
+	int ret;
+	int re_allocated = 0;
 	int write_object = flags & HASH_WRITE_OBJECT;
 
 	if (!type)
-- 
2.35.1.940.ge7a5b4b05f2

