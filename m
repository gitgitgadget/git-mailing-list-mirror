Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4641FC433EC
	for <git@archiver.kernel.org>; Fri, 22 May 2020 13:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28716206D5
	for <git@archiver.kernel.org>; Fri, 22 May 2020 13:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfVigJSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgEVNeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 09:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgEVNeC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 09:34:02 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDE6C061A0E
        for <git@vger.kernel.org>; Fri, 22 May 2020 06:34:01 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id s1so10647033qkf.9
        for <git@vger.kernel.org>; Fri, 22 May 2020 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H58wDxSvvk/NVXHikzrRsxlA3p99a4yu7QYLXpYI8fo=;
        b=nfVigJSQCle/UtjFfI8GZfxxzB2LJzab6Rvjai1KqJ/7RBnD0QtkVg0+vzJTP1QNq4
         U7KVUHCJ1p0m3MaHrywA3BZ84ekBY5979WZWAY+SBQGiGGIhVsTYxsoYLNGX10BPGqDs
         eKDSL8HUvWOf8Ee7CnYYbTeB4oNYOQ9URuS0Pb6ATRLJeO4g63tgn9i1Vc1g8mfc0aw0
         7Pb1bMS4IAvB2peQ0whI9WwVthbuYBmd71C5xMSWMlKuO+BP3cmiuKoh4Wqr8GGtNV7B
         hEpkwHeQlInX4+m0NubG1m6M6KmjkJNnoTGzfIYo0BCoUECeOgCTtTEItA1w9wXlTXNy
         b6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H58wDxSvvk/NVXHikzrRsxlA3p99a4yu7QYLXpYI8fo=;
        b=Mdk0ktUQxcA6ykiu2sr55xZ0n01gMWAqksXVrrYTRHQ1oOI5qINWg7L29tcBRokmP8
         cJz4Sm847S54ONpX9AVhInV6u0jhFw6pSMifpesgUaYH30HxqHELR2XgWNaeHalbWN2L
         vnZx0V5+B/Cb5QFKYD3mkdKwu+1+nyp7K6OY9yLzyk9dyQJfpK4fD/jMjJz9Jl0+8/gQ
         g1sdxJo1A/iq7zxRV8vsYaiZntl/g8IgFg+A+aKkoaLYTksHbnlf/FdoN3K83fXGvB6r
         SlzwBxdmmjK1Pma/Rnmk/y9eActkQ7BijiLLF02cnRrUkalmB2HCV7ogOWbylOgzaBzx
         rHYw==
X-Gm-Message-State: AOAM533yYdubMM8OzkJ5/exJGIAxaVkgEV4sR88x9rR57XdONdr6IAUE
        eZRlfW4OaI8G5QM7FhpTLVaOkq9T
X-Google-Smtp-Source: ABdhPJyZ8Xn7lhZatXO43Ka5dhMZ93VtaMlG1hf0ugQ9L4RpvBgdwHdYx81qCK67PWvjojM4cSQR+w==
X-Received: by 2002:a37:6384:: with SMTP id x126mr15236329qkb.355.1590154440888;
        Fri, 22 May 2020 06:34:00 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id g3sm7314462qtu.90.2020.05.22.06.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 06:33:59 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 9/9] fixup! remote-curl: error on incomplete packet
Date:   Fri, 22 May 2020 09:33:47 -0400
Message-Id: <4364b38bd027c219d41282bad3f8476daec936f9.1590154401.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.69.g3229fa6e15
In-Reply-To: <cover.1589885479.git.liu.denton@gmail.com>
References: <cover.1589885479.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the CGI scripts which emulate a connection being prematurely
terminated, it doesn't make sense for there to be a trailing newline
after the simulated connection cut. Remove these newlines.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-httpd/incomplete-body-upload-pack-v2-http.sh   | 2 +-
 t/lib-httpd/incomplete-length-upload-pack-v2-http.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-httpd/incomplete-body-upload-pack-v2-http.sh b/t/lib-httpd/incomplete-body-upload-pack-v2-http.sh
index 2f5ed9fcf6..90e73ef8d5 100644
--- a/t/lib-httpd/incomplete-body-upload-pack-v2-http.sh
+++ b/t/lib-httpd/incomplete-body-upload-pack-v2-http.sh
@@ -1,3 +1,3 @@
 printf "Content-Type: text/%s\n" "application/x-git-upload-pack-result"
 echo
-printf "%s%s\n" "0079" "45"
+printf "%s%s" "0079" "45"
diff --git a/t/lib-httpd/incomplete-length-upload-pack-v2-http.sh b/t/lib-httpd/incomplete-length-upload-pack-v2-http.sh
index 86c6e648c9..dce552e348 100644
--- a/t/lib-httpd/incomplete-length-upload-pack-v2-http.sh
+++ b/t/lib-httpd/incomplete-length-upload-pack-v2-http.sh
@@ -1,3 +1,3 @@
 printf "Content-Type: text/%s\n" "application/x-git-upload-pack-result"
 echo
-printf "%s\n" "00"
+printf "%s" "00"
-- 
2.27.0.rc1.69.g3229fa6e15

