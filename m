Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009FEC54EBE
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 04:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjAMEm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 23:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjAMEmB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 23:42:01 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481C412AA1
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 20:42:00 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r2so19963384wrv.7
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 20:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8bjdcU3OKYufVc+pxKzrObPJZDPds89wtEi7dgoF/k=;
        b=HZS5XTwLsVXTY6Dz6hl9Nj/+D8r+8AYtjxsnau8F/LZZVo/MnVoaKhuf4eczUbX2go
         eAef7MF3ZWPH0p7qio+ALyop6ebDQtFrqUbNskcwZz7HGt3gymDC/ZCzJ4mzkB26vtvC
         7CRSLtTqNEhvhQEqGQvB6EvHMNWGC0dnspJOUUBM3bncyAMk0+2+Bjr9a7DXy/luoiN6
         zjNj1w5vRGvvkq9ZSb3ggCmROAicLMnCOj2I2hB0lAU/+I2mrVt7uWOdSAR6rkL1r3+y
         Yn8OxMgX3JlOE6Kcm6QqPieYdI/u78txCXcUEN7mYqXEMkknuvULIitRGUpFB6hFEuGO
         CCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8bjdcU3OKYufVc+pxKzrObPJZDPds89wtEi7dgoF/k=;
        b=7QbTwU7zJJ/TJALjqWx4LpEERx+SNdPUJ/1zkyx/mEEoIPfnYZ0vb1GdfOxDqG8JcI
         0kmarMw1ZDiZN20TubrpG2y05A4sVbcmQ5LoeSiFnFDKjKsMn3XPiwBDrXsvM0ZcPfkI
         r5xvwoFSdVUaLPybSmklLFcdKIK2oZZcF6/WYHXp3O2l/MN1ww+nZrjC3fT0WtMc+KN7
         8sIi7avYKYDrKHU8Mi4kWAb4xbDEVIUmWGd5W5qzyNMRSoZea3wBeVS77DK9q/krnGPA
         Q/rPQ4iCZ9ksQaufQ8VxXHEIMbCPwmmNMMmWV/qIu+mFYQr/V24EgIss1fhMwVwlpPDZ
         ekxA==
X-Gm-Message-State: AFqh2kpdCKmJZcd3JpHW/b5izqcj9Bxz8cQ00zjQqDGTpWy6n0FFSIK1
        /0IcS0Gg/G86D+jzMPc12EHv0+NE3f8=
X-Google-Smtp-Source: AMrXdXvkzKxutgZIPOGAgFJawILjz+keaxYQfYnhENzVdO/t2EJyz4FnkhqPhhJEIFdOlIeMNcoZZA==
X-Received: by 2002:adf:fe90:0:b0:2bb:a83c:efc4 with SMTP id l16-20020adffe90000000b002bba83cefc4mr15312936wrr.7.1673584918679;
        Thu, 12 Jan 2023 20:41:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k9-20020a5d6d49000000b002bc8130cca7sm9771933wri.23.2023.01.12.20.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:41:58 -0800 (PST)
Message-Id: <b144d55d111d09f8d54502cee8cc1dfb2401dc95.1673584914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.git.1673584914.gitgitgadget@gmail.com>
References: <pull.1463.git.1673584914.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Jan 2023 04:41:54 +0000
Subject: [PATCH 4/4] ls-files: guide folks to --exclude-standard over other
 --exclude* options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-ls-files.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 3886d58d178..1abdd3c21c5 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -119,7 +119,8 @@ OPTIONS
 
 --exclude-per-directory=<file>::
 	Read additional exclude patterns that apply only to the
-	directory and its subdirectories in <file>.
+	directory and its subdirectories in <file>.  Deprecated; use
+	--exclude-standard instead.
 
 --exclude-standard::
 	Add the standard Git exclusions: .git/info/exclude, .gitignore
@@ -291,7 +292,9 @@ traversing the directory tree and finding files to show when the
 flags --others or --ignored are specified.  linkgit:gitignore[5]
 specifies the format of exclude patterns.
 
-These exclude patterns come from these places, in order:
+Generally, you should just use --exclude-standard, but for historical
+reasons the exclude patterns can be specified from the following
+places, in order:
 
   1. The command-line flag --exclude=<pattern> specifies a
      single pattern.  Patterns are ordered in the same order
-- 
gitgitgadget
