Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091F1C47080
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379887AbiDDVVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379472AbiDDRMM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 13:12:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E4D13D16
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 10:10:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j12so7908476wrb.5
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 10:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xB1aNX9H6yZ/Kx9Xkt47Kiit/K8vwf7w5ovXt5g6ryA=;
        b=IHP+k/6st4zqE6tLKX0qREx+O1b94dU4Faoaezd8pprINbwgfZzf+90wLVh9uBzV20
         LkLe03cufqX6dx//7NSG6T0iq4abX2UirAHgxClHl/dYHVU6hmFAOTzBTV17ul6FeslB
         frZc2aYyOrJRvr0Go4HqJsH5UPdkTwEFzjQgBtQxbLautO7V0pDxl3mR9Tw5J3e1F13k
         G8RqLR0fM+eNdmDwf3zwnFOXqFAcqQafCQE+JgpNLUp6NdwWtQlBSfMVCthPCbkrdSd/
         3eRahse/YBMyeGG+Oh9hGMEyO4fiGzCiYWxgOBeJa5+QSBQEAt7vsd3Z1KQcBYkYe+2t
         vbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xB1aNX9H6yZ/Kx9Xkt47Kiit/K8vwf7w5ovXt5g6ryA=;
        b=afQ0gmH6Js0sJzdJJaX2iNmtdjuwzjts+YiT1n+rUrWB8kk5MQxub7YsthlR6VJtJS
         GD3tdAL3MNMLkGKshWrkxcIuL4Mx7vgZTIR8LbBZzrcm5CDy/wHbst8M37Kr4y4O04n0
         hBE3Cn4fUymwWfF8oZIWoRwhUjs/XwQC+APW8dydLnv50pKA5sRSl4vc5AZxIY6uV9uU
         48yHfOq0zTxHumATQTRdctkDFuu5Qt4Xo1POCdyLDUvpEawTJdJZuHy3cUxAoG9KO8ah
         molUv5xsHbtpBcvwTwS1k3Z68dTXWUoLNuEKD18OooviHkG8zIECL+UVCpljGIbGIcTY
         hhvg==
X-Gm-Message-State: AOAM532VEwzhpnDPP6QT/TL/BNMKWIag2J1/VGtGcx8sdC9EVLiyjHrn
        n6JqpQBniqkF7/1rhCuDtexlZoPrlv4=
X-Google-Smtp-Source: ABdhPJwi7lX+AptXgouDsohgReifMwHAv5NSzoTbBx9jjanL0MUKPkhy48loRM43qvemOl+FMtdQeQ==
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id y1-20020adfd081000000b001ef9378b7ccmr538494wrh.407.1649092212931;
        Mon, 04 Apr 2022 10:10:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3-20020a1cf403000000b0037d1f4a2201sm82346wma.21.2022.04.04.10.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:10:12 -0700 (PDT)
Message-Id: <pull.1111.v2.git.1649092211419.gitgitgadget@gmail.com>
In-Reply-To: <pull.1111.git.1641410782015.gitgitgadget@gmail.com>
References: <pull.1111.git.1641410782015.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Apr 2022 17:10:11 +0000
Subject: [PATCH v2] submodule.h: use a named enum for RECURSE_SUBMODULES_*
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Using a named enum allows casting an integer to the enum type in both
GDB and LLDB:

    $ gdb -q -ex 'b wt-status.c:44' -ex r --args ./git status
    (gdb) p (enum color_wt_status) slot
    $1 = WT_STATUS_ONBRANCH

    $ lldb -o 'b wt-status.c:44' -o r -- ./git status
    (lldb) p (color_wt_status) slot
    (color_wt_status) $0 = WT_STATUS_ONBRANCH

In LLDB, it's also required to cast in the reversed direction, i.e.
cast an enum constant into its corresponding integer:

    (lldb) p (int) color_wt_status::WT_STATUS_ONBRANCH
    (int) $1 = 8

Name the enum listing the different RECURSE_SUBMODULES_* modes, to make
debugging easier. For example, when stepping through a part of the code
where an int is compared with a constant in this enum, it allows casting
the int to the enum type or vice-versa, after quickly checking where the
enum constant is declared and learning the enum name.

As to not make this patch a debug-only change, convert the
'fetch_recurse' member of 'struct submodule' to use the newly named
enum.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    submodule.h: use a named enum for RECURSE_SUBMODULES_*
    
    Changes since v1:
    
     * converted one user of the enum from an 'int' to the new enum type, so
       the patch is not debug-only, as suggested by Glen.
     * updated the commit message to use an 'int' as example of a local
       variable being compared with an enum constant, instead of using a
       struct member which is already of enum type, as pointed out by Junio
     * added a little bit more explanation in the commit message as to how
       this patch can help when debugging.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1111%2Fphil-blain%2Fsubmodule-recurse-enum-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1111/phil-blain/submodule-recurse-enum-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1111

Range-diff vs v1:

 1:  4c787d4054e ! 1:  e0b211b88f5 submodule.h: use a named enum for RECURSE_SUBMODULES_*
     @@ Commit message
          Using a named enum allows casting an integer to the enum type in both
          GDB and LLDB:
      
     -        (gdb) p (enum diff_submodule_format) options->submodule_format
     -        $1 = DIFF_SUBMODULE_LOG
     +        $ gdb -q -ex 'b wt-status.c:44' -ex r --args ./git status
     +        (gdb) p (enum color_wt_status) slot
     +        $1 = WT_STATUS_ONBRANCH
      
     -        (lldb) p (diff_submodule_format) options->submodule_format
     -        (diff_submodule_format) $1 = DIFF_SUBMODULE_LOG
     +        $ lldb -o 'b wt-status.c:44' -o r -- ./git status
     +        (lldb) p (color_wt_status) slot
     +        (color_wt_status) $0 = WT_STATUS_ONBRANCH
      
          In LLDB, it's also required to cast in the reversed direction, i.e.
          cast an enum constant into its corresponding integer:
      
     -        (lldb) p (int) diff_submodule_format::DIFF_SUBMODULE_SHORT
     -        (int) $0 = 0
     +        (lldb) p (int) color_wt_status::WT_STATUS_ONBRANCH
     +        (int) $1 = 8
      
          Name the enum listing the different RECURSE_SUBMODULES_* modes, to make
     -    debugging easier.
     +    debugging easier. For example, when stepping through a part of the code
     +    where an int is compared with a constant in this enum, it allows casting
     +    the int to the enum type or vice-versa, after quickly checking where the
     +    enum constant is declared and learning the enum name.
     +
     +    As to not make this patch a debug-only change, convert the
     +    'fetch_recurse' member of 'struct submodule' to use the newly named
     +    enum.
      
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
     + ## submodule-config.h ##
     +@@ submodule-config.h: struct submodule {
     + 	const char *path;
     + 	const char *name;
     + 	const char *url;
     +-	int fetch_recurse;
     ++	enum submodule_recurse_mode fetch_recurse;
     + 	const char *ignore;
     + 	const char *branch;
     + 	struct submodule_update_strategy update_strategy;
     +
       ## submodule.h ##
      @@ submodule.h: struct repository;
       struct string_list;


 submodule-config.h | 2 +-
 submodule.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/submodule-config.h b/submodule-config.h
index 65875b94ea5..55a4c3e0bd5 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -37,7 +37,7 @@ struct submodule {
 	const char *path;
 	const char *name;
 	const char *url;
-	int fetch_recurse;
+	enum submodule_recurse_mode fetch_recurse;
 	const char *ignore;
 	const char *branch;
 	struct submodule_update_strategy update_strategy;
diff --git a/submodule.h b/submodule.h
index 6bd2c99fd99..55cf6f01d0c 100644
--- a/submodule.h
+++ b/submodule.h
@@ -13,7 +13,7 @@ struct repository;
 struct string_list;
 struct strbuf;
 
-enum {
+enum submodule_recurse_mode {
 	RECURSE_SUBMODULES_ONLY = -5,
 	RECURSE_SUBMODULES_CHECK = -4,
 	RECURSE_SUBMODULES_ERROR = -3,

base-commit: 2ae0a9cb8298185a94e5998086f380a355dd8907
-- 
gitgitgadget
