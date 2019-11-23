Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B117AC43215
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 05:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AC920672
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 05:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDO7bGDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfKWFyd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 00:54:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33299 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfKWFyd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 00:54:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id w9so11207775wrr.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 21:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0fyqbwsp0SS5RALG95l55thhfOCbB32D5R7dQ0tLaac=;
        b=IDO7bGDGzW1p4a1HtHOw+UbAmNhxr7rbXIzo/8qY/BIkSJdCTzOR3PnmFwnmjZsEel
         3YktlMfj1v5hGs1+VWPh3fc2+y+kwSiHrUZJb3zxLxpivxxTcXY1P6t7vlueBzARsOr8
         WD2Lj7bBZP5Eor8Zpmc7QI54dZUp7gf1PYv+yjPOfBqpIJxskPoX8PyEXzflxD1/0hGv
         QuIjvubAsI6bizTB/B6XkBX6Py+l7FQv3FGBKdm2SxP5S/pwc8nMCBXuISp4jKQClzCd
         U7lYwlhKhuNJDP1KuZp8KjFwLnfiyqXKoigJn+eNBA19oZON45fTMo+P1QJ9gf66Sv+R
         tsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0fyqbwsp0SS5RALG95l55thhfOCbB32D5R7dQ0tLaac=;
        b=OydxcT4Flbfkhy+cuqfodlJs/PC5nZv5R/4lKN6Zolcwo/Mjgz/5UffvmD0MHNf8Kw
         x36bKwXxpLOXqR8/xcn+A3aekoA8Ya+k1iYCMGUwJsUXpZa+PRI/JBtW7Ab9gqXLthdS
         rFOTvIwHrZ2F4aFfTEr1cQlpted47QO851u62Zksi9qh1z5RGU3ZKjmiWbVXYRw2dps2
         v/A8Vfc3iL9wikJSAps42PhEE8EamoCUJJwsY8ZLaDwOKyFjuqwoG6n7ydauOXXolPA9
         zg5oBLoUOIm8i4FfEwn06Bc5arkbHtH90mA3SoZqehIRyRixFD3r4PHUR2XVoc7RWlzs
         KeWw==
X-Gm-Message-State: APjAAAX6s9Ze/7JIksAZnmhyJi8D/SrbknFSi/4E4p9qlpDxz8FZ6Ls0
        c3AS4VoJ6RBENw55lKtd4Cnhaq3G
X-Google-Smtp-Source: APXvYqyWZflCKLmNGbjgOnXNoClFphalzil+MrVIhd4g9Fu9ImLld1jPDyP7YWEmp3LLix99msj+fw==
X-Received: by 2002:adf:f18e:: with SMTP id h14mr21913820wro.348.1574488469997;
        Fri, 22 Nov 2019 21:54:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o133sm728145wmb.4.2019.11.22.21.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 21:54:29 -0800 (PST)
Message-Id: <3168924c3c6f12a293b25a00f333a55d4b8fa3a9.1574488468.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.470.v2.git.1574488468.gitgitgadget@gmail.com>
References: <pull.470.git.1574464285.gitgitgadget@gmail.com>
        <pull.470.v2.git.1574488468.gitgitgadget@gmail.com>
From:   "Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 05:54:28 +0000
Subject: [PATCH v2 1/1] doc: Document 'git submodule status --cached'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Manish Goregaokar <manishsmail@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Manish Goregaokar <manishsmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Manish Goregaokar <manishsmail@gmail.com>

'git submodule status --cached' reports the SHAs expected by the parent project,
instead of the SHAs that are actually checked out in the submodule.

Signed-off-by: Manish Goregaokar <manishsmail@gmail.com>
---
 Documentation/git-submodule.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 0ed5c24dc1..f05c2b92fb 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -80,6 +80,9 @@ status [--cached] [--recursive] [--] [<path>...]::
 	does not match the SHA-1 found in the index of the containing
 	repository and `U` if the submodule has merge conflicts.
 +
+If `--cached` is specified, this command will instead print the SHA-1
+recorded in the superproject for each submodule.
++
 If `--recursive` is specified, this command will recurse into nested
 submodules, and show their status as well.
 +
-- 
gitgitgadget
