Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1C8C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 19:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiDGTLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 15:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240073AbiDGTLM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 15:11:12 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112C823406A
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 12:09:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z1so9272427wrg.4
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 12:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqaOHFDZ4VYIRflA43gHn0GpkOQ3Mm24JtxBazEWlTY=;
        b=jeZeYUI2NbFA4RgGH91Vra4QUF/JjknRAEMeGwgbUBu7mkG6OLha5bbQC6bMnbfwPa
         FJ8xPR7xu+r+U4viZ8ve1cZd+HE4KS6SabEQdOT+h4BbPjH0Q5rtAWaOdxXxGLP0IaJs
         ALk97L+34FqVniiFR9cBhWQRlvSQrig65Hyi9e1SfkMuhalpE0C8OwgxwLx+g0GEpG1P
         AWmiFqRxwZVVaH3QCgyh/N6QEwmQZIjmf6giTIMBtu4sZuhpXZhIs9Ns4hyDp7+46EHA
         G3NtzQRwa5aFbKjSxEMPL30qFwTw2BJgbn9IOEX0daYDOKc2S/KS7M4tgBkMD4KUSF0V
         X5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqaOHFDZ4VYIRflA43gHn0GpkOQ3Mm24JtxBazEWlTY=;
        b=N1M+83Rnd9HtC9knlnMDwx/dshAEH3k2LYWOkhDSo9ptHoA7/MFSKRO2zelQhgolzu
         f2fPxrMDCbXCnkw5IQV0hQ+8WU4Em/e5mXMsjRk8tj3TsVnTSAXKa6eSuUBUODZQ5iLN
         McvZ7Jn0cnJdWNNtAiXBzqn72Nq1bK+9O5JPaTQCYkqZ/uFLDb011g/L0d5gX5iPQEAH
         HSSQMIKv2YzRls+jhEpAHZJaVX2Lt3E2QDKYtKJjqnJrjeGLZbh1NsOxb5evbR18e6F/
         djjbe8eitMnvWdZIO0O0LB2qByYrwVxZhGLiWEJoaSkkb9pH4RFYml27UsE1XLNiNOLn
         XFew==
X-Gm-Message-State: AOAM5306A4aX7R29abxYJlM5UBopoojIQKL3Fpk2akGGThebv+7PDtD6
        PHYvpI/9bVHffmFW+lj2pq2j3ihI/jgxRw==
X-Google-Smtp-Source: ABdhPJyNmsEjH3mB7wqU3ZgV8vNphuUTmwQF/eLOXUpw6w+vKfxyrx1mG3WUZWuPyjWgxjnL0KH4QQ==
X-Received: by 2002:adf:9111:0:b0:206:c9b:ce0d with SMTP id j17-20020adf9111000000b002060c9bce0dmr12010247wrj.418.1649358550334;
        Thu, 07 Apr 2022 12:09:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b8-20020a05600c4e0800b0038c6c37efc3sm8164101wmq.12.2022.04.07.12.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 12:09:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] doc txt & -h consistency: fix recent "cat-file" inconsistency
Date:   Thu,  7 Apr 2022 21:08:59 +0200
Message-Id: <patch-1.1-79404e05d73-20220407T185645Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc0.849.g2d5b5d9ab01
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The cat-file SYNOPSIS and help output were made consistent in
83dc443439c (cat-file: don't whitespace-pad "(...)" in SYNOPSIS and
usage output, 2022-01-10).

They then drifted apart again in 440c705ea63 (cat-file: add
--batch-command mode, 2022-02-18). Let's fix that and list the new
--batch-command option in the SYNOPSIS section.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-cat-file.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 70c5b4f12d1..24a811f0ef6 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git cat-file' <type> <object>
 'git cat-file' (-e | -p) <object>
 'git cat-file' (-t | -s) [--allow-unknown-type] <object>
-'git cat-file' (--batch | --batch-check) [--batch-all-objects]
+'git cat-file' (--batch | --batch-check | --batch-command) [--batch-all-objects]
 	     [--buffer] [--follow-symlinks] [--unordered]
 	     [--textconv | --filters]
 'git cat-file' (--textconv | --filters)
-- 
2.36.0.rc0.849.g2d5b5d9ab01

