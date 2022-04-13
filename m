Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F496C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbiDMUEa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbiDMUEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE6D7B11A
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u3so4183786wrg.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GHRToQrz9QKAB4m2zIRGMfyIlWitgIA3L4bUAY0kmqk=;
        b=YJoOR2R+3b+B6Hh7Lj8KNeZofXbv3IO3r8Wk5UkI2qi2u4Cu1LwA5sz37c1SvfdBm+
         u2iQTlMtJ5mb+rOU8pDSy5I50mFOkwY4HUHOlvajZZDYk/9RuDKbVgvH6Su6HN+12cqx
         RiPUUzSVXQR7KWmNu0E5YKrXUEA4ZhzUcDG0dPsw4xB4ywBf8FJDuo/rono+dyWE8QyZ
         GrCWBWxq227Al4HfwLYa5PIl0bW5x2fLpub03bCBTrxTdpsgzUWbqMrGU42raQZITMFb
         QeNWhDgsRJsdiLF0TpmUh/BunIo/qQ0KI7O9Naefe43+h9XN7Dy51eDfw7p0Aw0CHTBE
         bDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GHRToQrz9QKAB4m2zIRGMfyIlWitgIA3L4bUAY0kmqk=;
        b=hSIJpS/dhuBRr/qyJ2SYGAhBteXSsi6AUzedzzb0+i5vu1D3JxI5gBxi4UrHksEfvv
         b6mWJjh1XrBU1/Vv9fgdpHhx6WTZbN09Z8tmrgh8jqemg9sVeQ1NWxJ2DTbV0pWoiBSd
         H9DP/LTWbK8Wjb1qLTDjB9sAOUk4IW2mUMZbtAPAOtJ/C4+ymkM6Ao9MteFJB5d+u8LZ
         QBtsDg1ZkUqMxC/9nz/HkEYZ5OwofYjaQT8WlNPhYEuXwp6UO8eCQdOEc5iANM6fX+zN
         se2qx2rUIHoWjVtfwRqKpTJ28Tuvmr94yPIlkof2tZBBtzEshE+YZ5mLseImu7pBfwhz
         SF1w==
X-Gm-Message-State: AOAM533WvM5SiufU+9LeRX/xJgPa5QV5yYPMLWbrg7g6YJss1W7ZqxTT
        qXwgIDcFxvaV/BW+GqlggtphtvRgaHDedg==
X-Google-Smtp-Source: ABdhPJzX76wbYgSKEsSdh0idFNFHwxNCT4XuIvGpJCBjxVTIh3mL0vF0gs9p5e9kyYis9Qk7VrYhBg==
X-Received: by 2002:a5d:5981:0:b0:204:1da7:93d7 with SMTP id n1-20020a5d5981000000b002041da793d7mr332129wri.621.1649880121335;
        Wed, 13 Apr 2022 13:02:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 01/27] t/helper/test-fast-rebase.c: don't leak "struct strbuf"
Date:   Wed, 13 Apr 2022 22:01:30 +0200
Message-Id: <patch-v6-01.27-1e904ad33b4-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us since f9500261e0a (fast-rebase:
write conflict state to working tree, index, and HEAD, 2021-05-20)
changed this code to move these strbuf_release() into an if/else
block.

We'll also add to "reflog_msg" in the "else" arm of the "if" block
being modified here, and we'll append to "branch_msg" in both
cases. But after f9500261e0a only the "if" block would free these two
"struct strbuf".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-fast-rebase.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index fc2d4609043..993b90eaedd 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -201,8 +201,6 @@ int cmd__fast_rebase(int argc, const char **argv)
 		}
 		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
 			die(_("unable to update HEAD"));
-		strbuf_release(&reflog_msg);
-		strbuf_release(&branch_name);
 
 		prime_cache_tree(the_repository, the_repository->index,
 				 result.tree);
@@ -221,5 +219,8 @@ int cmd__fast_rebase(int argc, const char **argv)
 	if (write_locked_index(&the_index, &lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("unable to write %s"), get_index_file());
+
+	strbuf_release(&reflog_msg);
+	strbuf_release(&branch_name);
 	return (result.clean == 0);
 }
-- 
2.36.0.rc2.843.g193535c2aa7

