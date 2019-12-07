Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E33C43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34815217BA
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idW8kX2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLGRrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:47:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47073 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfLGRrw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 12:47:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so11228403wrl.13
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 09:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=czCk0DRp2OOPFajQ4NWb1LoJtE/xpLksVA/HZQ+botI=;
        b=idW8kX2yOQZBKQxyNbXBvUUHEq4+IIQCvOlGTDjvB7pBNRzMd9gceldcFUYcUA2Hht
         4PejE9P6vga4FTmrBEVMarzFlsXf8Uc8xZQzXfV0iI0xiMYTgGshEiJ8atR+kCaLLvxp
         8Ta/P7tPQRMluw3L4A0cSnfQfkd5wS/EFxBmpy5JIKw+ebNCUz9ewkLPrewWTZk5IWgN
         18IaboNbV6mq3JNe27BaHJA06CWdWEbOZP3A932WO2T9EJ4o+cBGLxSPCoki1aawIqHq
         MCBRy2rbQT8aJatbJOzVCEJKfoKKUzLrL6INC0aDjAP19Dm1+B3sH6z9HGo1VeIyc3pn
         azcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=czCk0DRp2OOPFajQ4NWb1LoJtE/xpLksVA/HZQ+botI=;
        b=nzu8D0uAfm0wmyEFnL0ce92vVzk2Jt+AMNvhtK1oGoYpCAxxreU08FxDLOOgjZ+kOJ
         GXyPNV/Uz3bDZjSbW5ReudLcRI0WOlAgWuiJZLJQKcWJeRya62B7N5VMY5fuaTH+7wlQ
         m1zcb3KP+Rzx+A7vfIA+DxD0dCT/rcDw4crybBj2AOITGzeSe1LSEEXRGyJSzah+ujQg
         lwFleH+aPlrwOE9iYYz41AZcDVOKQHCQQGQZHy86ZOXDp4R4BFaPfa4TprAD/ip57kzN
         ZQtEcdiT3eEJ+FmtnPPI5ipYKmJgjhxg28jaHsRlVE1P3XfQp9lGSyCdcwZypWB9gOpq
         zmxA==
X-Gm-Message-State: APjAAAXjdP2Vg26MYCF7kYjZZmjZ0G3V5phCc83fxzU+ozsLa1lJMNlI
        cAnyKJgVM29OlfT/nUXhDapyT4Dk
X-Google-Smtp-Source: APXvYqxtNIoLx/btKk/afBEzs2rOtjE3dpg6SE8cUsSXnbbgTK5KlOgw8dsupXmTmBV7m+QRvHhrlA==
X-Received: by 2002:a5d:6901:: with SMTP id t1mr20507910wru.94.1575740870349;
        Sat, 07 Dec 2019 09:47:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm3237066wmg.46.2019.12.07.09.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 09:47:49 -0800 (PST)
Message-Id: <bc7009541b3f03c3065a7be2b569cd4bf91f7c05.1575740863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Dec 2019 17:47:35 +0000
Subject: [PATCH v5 07/15] git-p4: add new support function gitConfigSet()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

Add a new method gitConfigSet(). This method will set a value in the git
configuration cache list.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index e7c24817ad..e020958083 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -860,6 +860,11 @@ def gitConfigList(key):
             _gitConfig[key] = []
     return _gitConfig[key]
 
+def gitConfigSet(key, value):
+    """ Set the git configuration key 'key' to 'value' for this session
+    """
+    _gitConfig[key] = value
+
 def p4BranchesInGit(branchesAreInRemotes=True):
     """Find all the branches whose names start with "p4/", looking
        in remotes or heads as specified by the argument.  Return
-- 
gitgitgadget

