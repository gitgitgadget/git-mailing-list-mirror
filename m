Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2266C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 20:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbiHLUKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 16:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiHLUK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 16:10:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18F66170
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h13so2251547wrf.6
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=327gbsyYeccEL0tlq4IQ1Y7CXUns6oBUTnyfqIVz7cI=;
        b=EDUWwtWwPM2IFRoc5LOML/V1i7NTbGAVl2dcyNuJtjHA7FW0shjnL97x/YKkO1f5r4
         JvKgvGbITYNS7c6YcMP+aaBBtXBcR1vRtj1XAF8yv0ksCb/3NmtZ0RUoc8o9IOhJ+dAe
         YTPWmTsINj7IxwUCKZZRtcpBEoMuO91gHJpMNWvYx141ZneDtFAmBKixnlIZeGhqkttQ
         uJqLlsUhxAm/81sLI61jNnhd2KEzsnCacNoBhDHU84Ajx5Rgs9R2jICvuKCY5/xQTpyd
         MOmE1DZvyFQU7+ZHXOaiKpZ+7Cd8jYOyE0aeuFuLEwUly4KXXtYvfgWeEEFro+No4jOC
         2Vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=327gbsyYeccEL0tlq4IQ1Y7CXUns6oBUTnyfqIVz7cI=;
        b=ynga/nVwzBay+ZJczURob5z0ZZqHe1HPC7NHmueQjFfGAHkuuvmtILSbyKnhT4RyBq
         SMKGjS2bKHopu2bRaZz2ORjf2imZdblkhme94/n3i0O6uLTA33qpX4+c29irLhWy4WPO
         3btSWPma+Z88LqPZ6cjl9RbHf3w519Wqw6BPUoY7A7vKaswm+R1ldAsrqtkbYQ0CI+SU
         g9y/4WcvWK0snYHEX8q5lzX1Gr/lGnW7BuZKHYo/NW2kL2IhU8uZiVCB0L9gA2si0NwL
         eYX1CiEEArtIoM5YzR70CIpFjCe83vcGWRimFz0U0SMITmFkx+o6m9khZT3/SLIR3czK
         L2KA==
X-Gm-Message-State: ACgBeo2Bt/lfA77m9apkTghblRsaTU0XkJn2nbOS6PcmurOcu1uo+XiP
        0aKu87QfrgKfwtEDiFA337mstSG5qkc=
X-Google-Smtp-Source: AA6agR59Y9siVAGb8ojnUkMfU3imTZSo8E2kcqLNpjvpuyT1Nj9nEOgsiTLVE4eOGKDcld+QWzlSFQ==
X-Received: by 2002:a05:6000:15c7:b0:222:ce5a:4b01 with SMTP id y7-20020a05600015c700b00222ce5a4b01mr2914648wry.206.1660335024361;
        Fri, 12 Aug 2022 13:10:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c2cd700b003a502c23f2asm574585wmc.16.2022.08.12.13.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 13:10:23 -0700 (PDT)
Message-Id: <22ee8ea5a1e04a42ad359be4eb5ebc96bd5e5fa2.1660335019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
References: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
        <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Aug 2022 20:10:11 +0000
Subject: [PATCH v4 03/11] scalar-diagnose: add directory to archiver more
 gently
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

If a directory added to the 'scalar diagnose' archiver does not exist, warn
and return 0 from 'add_directory_to_archiver()' rather than failing with a
fatal error. This handles a failure edge case where the '.git/logs' has not
yet been created when running 'scalar diagnose', but extends to any
situation where a directory may be missing in the '.git' dir.

Now, when a directory is missing a warning is captured in the diagnostic
logs. This provides a user with more complete information than if 'scalar
diagnose' simply failed with an error.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 04046452284..b9092f0b612 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -266,14 +266,20 @@ static int add_directory_to_archiver(struct strvec *archiver_args,
 					  const char *path, int recurse)
 {
 	int at_root = !*path;
-	DIR *dir = opendir(at_root ? "." : path);
+	DIR *dir;
 	struct dirent *e;
 	struct strbuf buf = STRBUF_INIT;
 	size_t len;
 	int res = 0;
 
-	if (!dir)
+	dir = opendir(at_root ? "." : path);
+	if (!dir) {
+		if (errno == ENOENT) {
+			warning(_("could not archive missing directory '%s'"), path);
+			return 0;
+		}
 		return error_errno(_("could not open directory '%s'"), path);
+	}
 
 	if (!at_root)
 		strbuf_addf(&buf, "%s/", path);
-- 
gitgitgadget

