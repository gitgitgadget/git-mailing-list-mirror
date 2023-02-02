Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D470C636D3
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 03:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjBBDvo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 22:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBBDvm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 22:51:42 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2BB7BE6E
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 19:51:41 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so2797208wma.1
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 19:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sdiw0KoeKYls4SN0B93nawEsjtT9XHHrrVAQbu6zMKg=;
        b=n6y0YKX7EUFKLNl+ksNTrMMMnoZbrnT376Fec3hHcCiVKIxvhKWlKK+41zXDNoDXrJ
         vvNRKp2CcLeGo/88tQZWGqukPpDaMRW3jI7vkCFa4Sqrnm1B6Thn61r2vBqJAhOio2RY
         j2t9YOwVumBl31GLq0JFrSRYkrzzQos34x6UaiqmmMekNEVJLCu8iLy3ECrw9eJ5vpBr
         cfFrWlTLxEbi+ZFNdl7mrh4y8y4gyhyudB8o9AVi5HB1ZpJAagFNsTjDsoFsrl2IBb9F
         +X+QSaOgxK8b3GSrDxNUT3NbEGUULow4WjViS7/CBdG2xLRfxUGFy+KX3yqtlwbr+pC2
         uK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sdiw0KoeKYls4SN0B93nawEsjtT9XHHrrVAQbu6zMKg=;
        b=07EuBUp2JQQsi4FD0xW+S6LZjMo4R33nF/LXPno+d7aNP93akpJmqSAu3VAMnUmFFN
         9+JM3pXKJCvWQudPohWQWE2sFzvBYjyXx4EYTx+8aGH/158Ol65IltUBkIOJOskTiyL7
         9F/JeaMuggrtEQ99LH6rltggDGV24iKnxmMhBEHQnQMihgiwatCfvrvOOQLJZtdwmbGk
         4wW4HyqTH7C2/s2M/vV5LEWKjk0MWCExxZ0e2Gmga+/8GPOc88WMX9EC2oBQVbyVwIWJ
         URmvM3ctvIJ+OJjMBqVQD5ss0Es36DnhQU6U+NNX5dPgED13/FHKlTFOCBdAGpDEv3qO
         Mzag==
X-Gm-Message-State: AO0yUKWo7fw2TJC+/foYFRHEmaFiy8GCcL9jMUyZpB/rv6py5pZ/Lz8O
        uSLjzT0kwFRFdxxF+rz1ruffi71wIrA=
X-Google-Smtp-Source: AK7set9oROO8BCzmADf3an9W2iL2g4ZFpgALIpmigyiukbfJuGQK6I4bXU4lIJxeZCA4Am1Z8ar8Kw==
X-Received: by 2002:a05:600c:3151:b0:3dc:5342:9f53 with SMTP id h17-20020a05600c315100b003dc53429f53mr4541560wmo.38.1675309900315;
        Wed, 01 Feb 2023 19:51:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q10-20020a05600c330a00b003cffd3c3d6csm3291145wmp.12.2023.02.01.19.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 19:51:39 -0800 (PST)
Message-Id: <bc79dfcc4d44e0f006dc64d75a2c7f8a11834229.1675309898.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1433.v2.git.1675309898.gitgitgadget@gmail.com>
References: <pull.1433.git.1670274213.gitgitgadget@gmail.com>
        <pull.1433.v2.git.1675309898.gitgitgadget@gmail.com>
From:   "Harshil-Jani via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Feb 2023 03:51:37 +0000
Subject: [PATCH v2 1/2] mingw: remove duplicate `USE_NED_ALLOCATOR` directive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Harshil Jani <harshiljani2002@gmail.com>,
        Harshil-Jani <harshiljani2002@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Harshil-Jani <harshiljani2002@gmail.com>

nedalloc was added to fix the slowness of memory allocator. Here
specifically for the MSys2 build there seems to be a duplication of
USE_NED_ALLOCATOR directive. So this patch intends to remove the
duplicate USE_NED_ALLOCATOR and keeping it only into the MSys2 config
section so it still uses the nedalloc.

Signed-off-by: Harshil-Jani <harshiljani2002@gmail.com>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index d63629fe807..377667c4bbc 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -652,7 +652,6 @@ ifeq ($(uname_S),MINGW)
 	USE_WIN32_IPC = YesPlease
 	USE_WIN32_MMAP = YesPlease
 	MMAP_PREVENTS_DELETE = UnfortunatelyYes
-	USE_NED_ALLOCATOR = YesPlease
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
-- 
gitgitgadget

