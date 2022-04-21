Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75F3C433FE
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 12:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384384AbiDUM2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 08:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384084AbiDUM2a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 08:28:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA6863BD
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:25:41 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m14so6466114wrb.6
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38RssPkIrj5YB0bPv9PhjVJagNCkbVqovDfOTMTNR08=;
        b=TuoDrIqqGeaRrpGfOpvdyIivVzCCGEDCpRSpiabcjoSIoqRonn0AP+nz0iHttBiiWI
         PtfZjMwMtTt+3XDetkjWx8Fun539CB+/0JlNsaJeUVIamsVaPiTYIpY/mfvwMr4bJRhb
         ZGit9kiDUb9JAMU5bxS7CTdzG9UPBME6w1SxqeRtC1Y/5RceBy0OvPeuuzRC+PdGbr1S
         EdJjmoObrz7y9yvDR4T9CArur80dlx+koSwaDe+cY6nZlxN1SyElNZEB14wX8Vezlgzv
         qvZjAwlp2g1vKntdT3z6YunZ9o15V0ajHsbxwi1zwvVQmPplJ/DNTwM2xZxUkmvCOwhd
         Xv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38RssPkIrj5YB0bPv9PhjVJagNCkbVqovDfOTMTNR08=;
        b=l3Gt6dun1DVMsHm0N/jb1FGXKtZxzX6qwgtn3SLKKAXpXv1Jdx2ZG/opERAeCCd5yG
         ggb+PyXj68LpdCi4ofIoBCaGyKTKSc4IwVV0f0jF/j60xCRORNc+eYLyzN0DuaqSHjCx
         rkMP7unYMUJGY+m37tRahfuSKPXCOAmRDsMoZEUBdXSww6k2DiUlVDGaa2fRWovzO2MW
         A1AdUhk78tdQ75XALvHhzX29L/6RFLEoIjlrpY12ZznMJHctzNe3or5sKzPoCZR6q0nC
         WHrrVgO/BuRgwRiMNocome83RyrwRvIeRVZ7JwCQUlICnkf3ZcAPNcIHUMpoPYGCUaRO
         cpBA==
X-Gm-Message-State: AOAM530DCkhaxWsaUfiaWH08IPRPcY4HcQODJrE3cNYg+AjwvN9RtEei
        RO9ZxMPQTESMQ+T5ZP9zCB4urR79EFA74w==
X-Google-Smtp-Source: ABdhPJzAICSZ7+CZ0es9ZE0JVEtRhgv69QU88IPrRSmyBWyb+wKERVFEdP44WGOCVHsSbZhs0qO+Kg==
X-Received: by 2002:a5d:6d8b:0:b0:20a:97c6:9a03 with SMTP id l11-20020a5d6d8b000000b0020a97c69a03mr15365322wrs.49.1650543939397;
        Thu, 21 Apr 2022 05:25:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c2c4700b0038eb7d8df69sm1920168wmg.11.2022.04.21.05.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 05:25:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] hook API: don't redundantly re-set "no_stdin" and "stdout_to_stderr"
Date:   Thu, 21 Apr 2022 14:25:30 +0200
Message-Id: <patch-5.6-98c26c9917b-20220421T122108Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.893.g80a51c675f6
In-Reply-To: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com> <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend code added in 96e7225b310 (hook: add 'run' subcommand,
2021-12-22) top stop setting these two flags. We use the
run_process_parallel() API added in c553c72eed6 (run-command: add an
asynchronous parallel child processor, 2015-12-15), which always sets
these in pp_start_one() (in addition to setting .err = -1).

Note that an assert() to check that these values are already what
we're setting them to here would fail. That's because in
pp_start_one() we'll set these after calling this "get_next_task"
callback (which we call pick_next_hook()). But the only case where we
weren't setting these just after returning from this function was if
we took the "return 0" path here, in which case we wouldn't have set
these.

So while this code wasn't wrong, it was entirely redundant. The
run_process_parallel() also can't work with a generic "struct
child_process", it needs one that's behaving in a way that it expects
when it comes to stderr/stdout. So we shouldn't be changing these
values, or in this case keeping around code that gives the impression
that doing in the general case is OK.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 hook.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hook.c b/hook.c
index eadb2d58a7b..68ee4030551 100644
--- a/hook.c
+++ b/hook.c
@@ -53,9 +53,7 @@ static int pick_next_hook(struct child_process *cp,
 	if (!hook_path)
 		return 0;
 
-	cp->no_stdin = 1;
 	strvec_pushv(&cp->env_array, hook_cb->options->env.v);
-	cp->stdout_to_stderr = 1;
 	cp->trace2_hook_name = hook_cb->hook_name;
 	cp->dir = hook_cb->options->dir;
 
-- 
2.36.0.893.g80a51c675f6

