Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17319C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 20:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25C420672
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 20:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpHIUROk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfKWUux (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 15:50:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35429 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfKWUuv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 15:50:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id s5so12773714wrw.2
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 12:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f2VupkxvIeAw0pkgCZqcjjIlCsI+jfGBwxonk07gmw0=;
        b=ZpHIUROkJ7MIN4vLczVQFzzIKJIB6WdBRIbJfLAvkDcGchhaxggHqnq6xScuB3oci3
         Rq2QJmDVuJng7OM6acdTjG8VEw7tON4ZoktC8MO3ce9H2+ZoIbexC8ojTmj29oTcuDUY
         CoiM9KK/RJBoe4fa8xAFIiYM+hbM9cJez0uVXJmgxgQby492U/LzlHr7diRK14iAFsMZ
         erah6xpL7IwPbe91INXeD9G0NyeodBo4B2F0TEXPzoIM5Bk/OEyVgg/dNxgYUUqRy+OV
         fNgOCHMMOoWpSh/bjji0z3GuUxh32oekDGflFli/ahq+zNiNGhHKGWGMXGeH9iEFUw4L
         isEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f2VupkxvIeAw0pkgCZqcjjIlCsI+jfGBwxonk07gmw0=;
        b=ABYBiRh4PLy46VtpxmLjaR2unLCk4tSwMO2pqeM38fQxJe8I3WGsV0P0QltGk6FLRM
         8j3Jxo24y4GXHz2+D8/UjyI5FPqS8Mqi1aot7t45deLpj2ZHvjIK+1vVwog5txC/mgYk
         c2NgtOx+8G00vrRwd5IdKXW6mzPH6DBn521gS7n3npfIEcFe6fxdrvV+H9Wq1rKS94km
         19pOMu+1zVGPOOs1aS/IXJ9n0Cv9/Toe4MPIjpETQRWL/fg5rcB3A7BYPQr6HcDXTZUm
         9fwvTHAteIgIuxEI9a178KDEK1ciY8rwBSa7kIFrapjvZ48sjFySsrjNO46rB9hK3I/9
         4EqA==
X-Gm-Message-State: APjAAAXItP73BUyTVLsBhExD1Xaccl/ZblHaC4CbQeXaNuIVSxGvD/f+
        eIwxXuxOsDmc+q0ndoVkqakzbSEW
X-Google-Smtp-Source: APXvYqwIvQqyqzqk5YkFtKClttt3AjF7o0krEgJ9e0mEtDworakxn4V7FcYyy103wJwcgnUZijl4WQ==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr23116931wrl.190.1574542249982;
        Sat, 23 Nov 2019 12:50:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16sm3822295wrg.27.2019.11.23.12.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 12:50:49 -0800 (PST)
Message-Id: <45fee72059d04d7770deb22ef605d6e26bbe762d.1574542243.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.git.1574542242.gitgitgadget@gmail.com>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 20:50:42 +0000
Subject: [PATCH 8/8] remote: no longer claim that branch.*.rebase=preserve is
 a thing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/remote.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 3410ea19c7..afe9af09e9 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -309,8 +309,6 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 			int v = git_parse_maybe_bool(value);
 			if (v >= 0)
 				info->rebase = v;
-			else if (!strcmp(value, "preserve"))
-				info->rebase = NORMAL_REBASE;
 			else if (!strcmp(value, "merges"))
 				info->rebase = REBASE_MERGES;
 			else if (!strcmp(value, "interactive"))
-- 
gitgitgadget
