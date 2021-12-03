Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD658C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242229AbhLCNen (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241102AbhLCNen (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 08:34:43 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30172C06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:31:19 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o13so5696702wrs.12
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dFbP6O2gHXHlyueZ8X/OjhO0NUJOQ56OdjUkpAfmlgk=;
        b=BmttqeOByFrkoA5rmCxGdWFUi45UA5IhySvfGP8Fna7y5LL3reHUJTH2P8OsKfGRCA
         4grDMi9x07bcXVXxgyG4DMTq/pXQMkXgWOksemOlRTlm2qDRo4k6uiGxs49U4HavrXp8
         YxMWQzZ3d1GCSNLgca4tg1GmwEtrla8lAEB2uAkDSVPiIdjb9IdqCxgmR7i/HB4ZUkNz
         NSgXYMks1lRk56Xw4MwCxfwTng41Gwcq2qgF1xRjIZ9o9/cnV8iF0pVtLO2T9u2Ya9a4
         Af6/itDsG3treuxtw/mGXZeMrmr4ipeu3pQmEGcrxujgT86s7qFHKlVY69pNcpH1VtBF
         PwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dFbP6O2gHXHlyueZ8X/OjhO0NUJOQ56OdjUkpAfmlgk=;
        b=qmkvQgEHRMjhNSlMUqfwcV7b06VAa+hFaqIYaFozb6YQs8WIqfJq9V/wzi2VJa6Pxu
         V8kmPYMIYqXNOA8qLEvj3ODvGrYtFW3UU88AM07T2QCWAj41cV+HbgQC+r5vcZUfwO4q
         8quVraq9FFuf2AZ4t5v+pHaKphlrfJghI6gcsDlmDVPBGfe2Mo5q2RxFPbjTzzYfGrHj
         2U+EMw3P+YBtk52i6nMGE4NLHF7RciR3nFVIuva0r2AgPN5oshJOZCgWY2og6wxkuO7k
         H1J69n0IBjHj+GHk6ZMJt1+6iYdE9fgeYyVe8/c3SqnevzOq+ykCDiRe1uINyBeFl60z
         yqYQ==
X-Gm-Message-State: AOAM531vK3HvEybOHD95lAqTVgdGujNMu05yYTa8k52DlJXuLfKL/MoA
        VAkTcUN82Ibt6Fnga7INnwEOX2QbEUE=
X-Google-Smtp-Source: ABdhPJxLFDbiGY/WnfLWbEjwgPmu395RP2b4kSayrGOQ/YLjmoU8cSwqk6DHUXqF1cpHXslE4GFsoA==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr21498015wrr.370.1638538277633;
        Fri, 03 Dec 2021 05:31:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm2636333wme.39.2021.12.03.05.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:31:17 -0800 (PST)
Message-Id: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 13:31:16 +0000
Subject: [PATCH] gpg-interface: trim CR from ssh-keygen -Y find-principals
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        pedro martelletto <pedro@yubico.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: pedro martelletto <pedro@yubico.com>

We need to trim \r from the output of 'ssh-keygen -Y find-principals' on
Windows, or we end up calling 'ssh-keygen -Y verify' with a bogus signer
identity. ssh-keygen.c:2841 contains a call to puts(3), which confirms this
hypothesis. Signature verification passes with the fix.

Signed-off-by: pedro martelletto <pedro@yubico.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Allow for CR in the output of ssh-keygen
    
    This came in via https://github.com/git-for-windows/git/pull/3561. It
    affects current Windows versions of OpenSSH (but apparently not the
    MSYS2 version included in Git for Windows).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1090%2Fdscho%2Fallow-cr-from-ssh-keygen-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1090/dscho/allow-cr-from-ssh-keygen-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1090

 gpg-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 3e7255a2a91..85e26882782 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -497,7 +497,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 			if (!*line)
 				break;
 
-			trust_size = strcspn(line, "\n");
+			trust_size = strcspn(line, "\r\n");
 			principal = xmemdupz(line, trust_size);
 
 			child_process_init(&ssh_keygen);

base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
-- 
gitgitgadget
