Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FEFC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A6F60F23
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhJ2V3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhJ2V3p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:29:45 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C25C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:27:16 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h4so9812818qth.5
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1q4H75LlDNtQlaO76SMgKFXTjrL0DZKX/sPJ7Cu3nSg=;
        b=h434goAiW45EnKMXAoFxVSAmDn4meWY3pRcMfet/b5NuiyreZDav4Ki4NZtGL2fV9I
         5F2eghaHipRfX0VBstKOhXa95yRJvNSIa8biH9MuRI7RffZu1qcRqkddaHHerAy0SknQ
         bk5L2XE+ch7jdkOX09iHrqEoiLILwVkJGxmR+RdFvAWUaq4UY4SvDdf4BTh+T+mhJDrv
         aXDp5w3chArpeup71B86h/mfw5OArQi3KnvfP/6P0Wx3nBzfIGHpAdwQWaneOK2qZier
         HcjxDKJA0iG1qTGEH7zw3DE3J6ugVRoQkeV7v/zWm2RPgu2HljHsJ3O8F0H2fqYN5Len
         NXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1q4H75LlDNtQlaO76SMgKFXTjrL0DZKX/sPJ7Cu3nSg=;
        b=LQnR8tAUak7XZ0mfzXloi4gtiu33crcR5cPRt+qhnjQyYbzT80D4DLKkleXe+6aMTS
         06qIsi+J9cNelfnSzM1JATjZZL2I3/39XQMA2nOuJ7VPn79QaQ2CTWvtntzIWB/Ivam4
         vKJt2JgRO4qbaRoODGA7p8Kf2pqvG2gOhNpz8ysYSxuEkdOj7pCstSU2Mc11OYLDXqkg
         gW0P/vIQmDI1sSBhq8e7yq6UQ7ni13lCEwKv9RipETjmayfmUEhZ7lp2bsytYeMcIFNL
         1wSNnYkvF2TGLM4Q2TJ7gyTc2TEUespMtdlUEuiN8wFZWAgcFK5pLNjijNe+pwcC8Osv
         KG5g==
X-Gm-Message-State: AOAM530ZnHcDL6zGkR+F1cEr1D8bUXW48f56Ph8M57GTF+wf+OTzmc5z
        akIIDs9OAZmjuI+/rUwLM0bkhXTQ1bk=
X-Google-Smtp-Source: ABdhPJzXry03mxE4uYxDIjdr+vIyh/8RjgqXRhddmrTeGL5JiCqPVimOtAIGW3dc/0iEYsUlx4ra9A==
X-Received: by 2002:a05:622a:170c:: with SMTP id h12mr14473804qtk.6.1635542835256;
        Fri, 29 Oct 2021 14:27:15 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id g1sm4586378qkd.89.2021.10.29.14.27.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Oct 2021 14:27:15 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: [PATCH] wrapper: remove xunsetenv()
Date:   Fri, 29 Oct 2021 14:27:05 -0700
Message-Id: <20211029212705.31721-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.1.1200.g715dc68e71
In-Reply-To: <013a01d7cd092d91cb088b5610nexbridge.com>
References: <013a01d7cd092d91cb088b5610nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Platforms that are using the git compatibility layer for unsetenv
use void as a return value for unsetenv(), so any function that checks
for a return value will fail to build.

Remove the unused wrapper function.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 git-compat-util.h | 1 -
 wrapper.c         | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 141bb86351..d70ce14286 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -879,7 +879,6 @@ char *xstrndup(const char *str, size_t len);
 void *xrealloc(void *ptr, size_t size);
 void *xcalloc(size_t nmemb, size_t size);
 void xsetenv(const char *name, const char *value, int overwrite);
-void xunsetenv(const char *name);
 void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 const char *mmap_os_err(void);
 void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
diff --git a/wrapper.c b/wrapper.c
index 1460d4e27b..36e12119d7 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -151,12 +151,6 @@ void xsetenv(const char *name, const char *value, int overwrite)
 		die_errno(_("could not setenv '%s'"), name ? name : "(null)");
 }
 
-void xunsetenv(const char *name)
-{
-	if (!unsetenv(name))
-		die_errno(_("could not unsetenv '%s'"), name ? name : "(null)");
-}
-
 /*
  * Limit size of IO chunks, because huge chunks only cause pain.  OS X
  * 64-bit is buggy, returning EINVAL if len >= INT_MAX; and even in
-- 
2.33.1.1200.g715dc68e71

