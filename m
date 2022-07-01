Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927E2C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbiGAKnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbiGAKnL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:43:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C1B1108
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:43:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v9so2597990wrp.7
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0qj1JGp7ViTxI+aYfchl1PbZXK6XojtBtGahU+lNxM=;
        b=L6FDk8ghVgokCKW6kzzbMn0452Y/q8N4N9ZY6tAHPYZoQ49b4Pp2wRB18QUyE4HMRt
         /ukpLNRcEMyXOTG3Y1Bvyv/oQxTqmiOezLiZUvXSlklnV9uPYJxQWDbS4SjzfwA5Sf6q
         YnlYX7KM7qDQGrXSr2PPw0WcGzGchcJULEYYMjTfd4ru/6xfUKaTZ4YhYGmIBL1A/KPw
         IJ4/cwZMNNdSCKrdJ0rg1Bd24eWyqvpy3K2qehGV1Y/kyndHF0ZqX/FtMKIjHIOFBVmK
         p5cIDjtWFtM2bJohLp/+IzYlv+I2dH4l9humIXOlO94hBHL3k+zVqFSAMrdHrunLid0E
         3T9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0qj1JGp7ViTxI+aYfchl1PbZXK6XojtBtGahU+lNxM=;
        b=v3WLJ/euO7nBBjNTQT21IPjZZGpPuLqFHge9CnWysyjAiWa23g31moDN5nPuEhZVy1
         bBjJ7vOlzwFg30uDrHdAfY0IO6psybMLwEZHKKzm/3xQ57VmWPwO/qzjLqeUDDlxPkhw
         EC3t+mX0emTrWZzO4YGupPNKhPn5ZfoUwz3GyQ+91va9/dkygrusizYT8yG97dJFUFxc
         BabGw7sLo7GE7G6V27Y2YJMnFIUrz0jE9n+nhlYYz2qLBANjiYmoVQD5NDCHipIbU0rf
         /LOur0LvogijsVUgI+stlltT+MxuXbZhwt1soZdFjsUJ7pm6C1A0ef3o2ymonjqiliNm
         TkRA==
X-Gm-Message-State: AJIora/ULf4jDQG2YWq0jb6bMSyKFOaXNpEPMK+jnK/wOw9Pc8Za97yb
        AUdu+ClgygR/xjUngv4a073lQoda4EVOGQ==
X-Google-Smtp-Source: AGRyM1sb2ysKx3yoVI2y6+CBhVNAI7MTzTEX4NtrvLMrxCV70goV7teUeHOVe4CPfuUt7kURfcDERw==
X-Received: by 2002:a5d:53ca:0:b0:21b:940f:8e29 with SMTP id a10-20020a5d53ca000000b0021b940f8e29mr13126904wrw.490.1656672187636;
        Fri, 01 Jul 2022 03:43:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q63-20020a1c4342000000b003973c54bd69sm6257674wma.1.2022.07.01.03.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:43:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/11] cat-file: fix a memory leak in --batch-command mode
Date:   Fri,  1 Jul 2022 12:42:54 +0200
Message-Id: <patch-v2-05.11-692d6e0e3d8-20220701T104017Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak introduced in 440c705ea63 (cat-file: add
--batch-command mode, 2022-02-18). The free_cmds() function was only
called on "queued_nr" if we had a "flush" command. As the "without
flush for blob info" test added in the same commit shows we can't rely
on that, so let's call free_cmds() again at the end.

Since "nr" follows the usual pattern of being set to 0 if we've
free()'d the memory already it's OK to call it twice, even in cases
where we are doing a "flush".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 50cf38999d1..ac0459f96be 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -655,6 +655,7 @@ static void batch_objects_command(struct batch_options *opt,
 		free_cmds(queued_cmd, &nr);
 	}
 
+	free_cmds(queued_cmd, &nr);
 	free(queued_cmd);
 	strbuf_release(&input);
 }
-- 
2.37.0.900.g4d0de1cceb2

