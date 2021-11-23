Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085BDC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbhKWLtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbhKWLtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:40 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629B0C061758
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:27 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s13so38513112wrb.3
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N7peUV3h502g753BqcnwIVv10kL5TWPjblOYcrDNC7o=;
        b=eMYhbpfoblG2w70mzpd+iISzMy9cDZ2Fdg6jqC3S3O3+DWIqPUEc4ypK+PIuxUmHC+
         5sIX+e7HsXGwF6Uqibat++JyUIn/00Ef1pnvcDevxlay4VrhMiRRg4j9h5oXFp3bpKpk
         dat0rgto55B9etKWhd53etdDnxanmDZSD4GjcWTFgeH4t7xM18g9FLRRZ+NOov73ZdPp
         4dGseg0XEMX25mUSxkJREVAkClbBRnV/3hURcG6p7UBigSa2CC80i+pX/cOa/hKZSvM4
         WrlyYA8gF6SMiJqWrR8HvzNXQM0bEXiSbr9aGI5yv5CazrYYMPDeYCkJJWsVcaMazKGx
         JITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N7peUV3h502g753BqcnwIVv10kL5TWPjblOYcrDNC7o=;
        b=pYCqaqrpLnZXIkoHSl3oqbj7XlySXsrctqpU4F+JAgQDVZ6FpRiHHIzP+8UC7a1xHB
         hlV4uPUnb7FE/Vf7AJMt3E/myXL2ZDEl7yE0CuUNuVfsBEX3NdsCQisJRQXHY+0MAaCp
         Gc5Ljgc0d+UfWtgNT0gybu4K/VK/j+yshKzisT+bPb92ZUAr3VzApu99i0oHdCUkZ10d
         +TYUdo5jdrwBm2yIsHRHBKcVIJDiSE7+i7f/CdkRfPNBTksdtcasY7V8iZMNWfCR8hM3
         gcEOJFLVw6en6l6ozYfC9XNm4c+/Tn5KKzseqfNu5cg8hlatMJfJxzyoMgiCWs2wG2De
         2wZg==
X-Gm-Message-State: AOAM533dFRjwSt3lztf/E8ovmsK26knginbHv/n3cPRG58v+G9gphYaN
        y7zHmbp9mkgXzmmFbOLx5G7avPNxZdKoGA==
X-Google-Smtp-Source: ABdhPJwHwviJZyMCQr+stjvZUhj9Ju2VhhJe5P9Sf7g2gmQs9a065Co5PUkVEagpASpYes5f8GGleQ==
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr6332546wrn.318.1637667985758;
        Tue, 23 Nov 2021 03:46:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm1723145wmq.27.2021.11.23.03.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:46:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 06/17] rebase: convert pre-rebase to use hook.h
Date:   Tue, 23 Nov 2021 12:46:05 +0100
Message-Id: <patch-v5-06.17-d49a1444345-20211123T114206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the pre-rebase hook away from run-command.h to and over to the
new hook.h library.

Since this hook needs arguments introduce a run_hooksl() wrapper, like
run_hooks(), but it takes varargs.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 34b4744e5f3..ac4120013a0 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -28,6 +28,7 @@
 #include "sequencer.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "hook.h"
 
 #define DEFAULT_REFLOG_ACTION "rebase"
 
@@ -1712,7 +1713,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	/* If a hook exists, give it a chance to interrupt*/
 	if (!ok_to_skip_pre_rebase &&
-	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
+	    run_hooks_l("pre-rebase", options.upstream_arg,
 			argc ? argv[0] : NULL, NULL))
 		die(_("The pre-rebase hook refused to rebase."));
 
-- 
2.34.0.831.gd33babec0d1

