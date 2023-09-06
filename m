Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6DDEE14A8
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 15:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242516AbjIFPXC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 11:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjIFPXC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 11:23:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DB0172E
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 08:22:57 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5009969be25so5924435e87.3
        for <git@vger.kernel.org>; Wed, 06 Sep 2023 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694013775; x=1694618575; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/exoRSTbEckkziY9jJHRpEMg/fq0sxdmzJvLwkGaFk=;
        b=aX3wypMB0N3f/lJBjEowdOU0rAPlEhvoxX3Ic1h42b6E52AuLRe0Zl/XeMSK8v5wLq
         kiY4XTfvcgjJ54ZB5epGXhkU50xzt5G6YLj8RRyrEb8TOzc/Fr4BFgliu9UWJcSIISXs
         shZGKv70YygN3lRS/85kFmCzlH06Devzw7eWtt9iv+4OiSc4A5rF8Y/vLrarw7gElYmP
         GcKpQVSa+UEmh873IpHR78tWPyKbCkoSk4gEQG40BSuRYVDeEz1wyGYwvpHTGhlMeaw6
         QdLfZx30CdouK0BcIQDviNV28FfiviqMMDVn+cE10ntyDcmalh1QFappvsLW6VhBLeOL
         4fDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694013775; x=1694618575;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/exoRSTbEckkziY9jJHRpEMg/fq0sxdmzJvLwkGaFk=;
        b=fukwagivRWa117RTFh+uyefdxgH/91m6SMbMmekq0ii9jPHLp3rCfmQ8VuR/e8+ZLp
         f3L/wzewx7fNteMRwtfbWDkZPtKu+ChAxyAwc3Ve3cbwSQtrJOSKIS3/6UEWQ6DhqFGS
         7dJ+8HcVmjd4YJ+s9BHxH7JUsz9bLlHyQpeiKu67WQ5gpUnha+g4umlMq87jWcUN6meh
         2zZyG2CWdyBnFGz4f7x5z38V/xBTtGbBb0s2ELBV642aUUCje9uh/MyHBmfAnR0peO41
         j+vjQ9CRZZYaKaALjWQLiWArWmy0+xE7X2ysLhrRN9BUOyR2VMuDyI4CW5AZoqgZ0Uxf
         8f0w==
X-Gm-Message-State: AOJu0Yw5TCXT1u7eXnONBDWy6qqrXkE8y7CZ84hDmXQ9ymjKb6/6MdSC
        ZDWi0C3QJ8FSH4Q4wI71NZiQu3rSqTk=
X-Google-Smtp-Source: AGHT+IE4sq9jzmAXITn45cazkHVV2ybFNJL4ouXxzw8uw5r/3+E6GV27jsk/vFUTpuL+oHhaY+aPxg==
X-Received: by 2002:a05:6512:3d26:b0:500:9b26:9760 with SMTP id d38-20020a0565123d2600b005009b269760mr3256787lfv.13.1694013775194;
        Wed, 06 Sep 2023 08:22:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g10-20020a7bc4ca000000b003fe1a092925sm20036419wmk.19.2023.09.06.08.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 08:22:54 -0700 (PDT)
Message-ID: <ae4f873b3d02ae125835ea585e5cf2ad623409d6.1694013772.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v4.git.1694013771.gitgitgadget@gmail.com>
References: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
        <pull.1492.v4.git.1694013771.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Sep 2023 15:22:45 +0000
Subject: [PATCH v4 1/7] rebase -i: move unlink() calls
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

At the start of each iteration the loop that picks commits removes the
state files from the previous pick. However some of these files are only
written if there are conflicts in which case we exit the loop before the
end of the loop body. Therefore they only need to be removed when the
rebase continues, not at the start of each iteration.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cc9821ece2c..de66bda9d5b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4656,6 +4656,10 @@ static int pick_commits(struct repository *r,
 	if (read_and_refresh_cache(r, opts))
 		return -1;
 
+	unlink(rebase_path_message());
+	unlink(rebase_path_stopped_sha());
+	unlink(rebase_path_amend());
+
 	while (todo_list->current < todo_list->nr) {
 		struct todo_item *item = todo_list->items + todo_list->current;
 		const char *arg = todo_item_get_arg(todo_list, item);
@@ -4679,10 +4683,7 @@ static int pick_commits(struct repository *r,
 						todo_list->total_nr,
 						opts->verbose ? "\n" : "\r");
 			}
-			unlink(rebase_path_message());
 			unlink(rebase_path_author_script());
-			unlink(rebase_path_stopped_sha());
-			unlink(rebase_path_amend());
 			unlink(git_path_merge_head(r));
 			unlink(git_path_auto_merge(r));
 			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
-- 
gitgitgadget

