Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34B9C4363D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 07:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9120C2076B
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 07:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNlxvlwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgIWH2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 03:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgIWH2C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 03:28:02 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9484C061755
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 00:28:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id q9so5996188wmj.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 00:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yaGmCtB15IvX/qwGwzTH6cHvbxCgNXtDhQGTd05SyV0=;
        b=dNlxvlwZLdPXL8qIB+edgP+JafV325nY/JU6NOMFhmKy7wzb2eDLGfCt+BPbJClN+g
         yi21slXs8wnZBvM6XcofInTTsxlSj2wzxTwKwINkCixO7PN1sKuaW0HCB4PLOqPyI6cD
         LhqHA2B0NQ/XSRGJSILfSPn35446k7cPFZus7ZjZwHL1Tjq6m3yAnM54BK/GV4qKtYgg
         zxDIIysRclLsRVt/6QeaWYcXpF6W5O9Kkj5APg4lfPB+9/3/AWNOODo5c4d5mmDXjITL
         Q/DS9nBzt28r9zKFe27+xL9t91i1CoCTu5Ruh6lVmSwrJ0hw4qzE6q9pjlyL6Js2ovf4
         lNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yaGmCtB15IvX/qwGwzTH6cHvbxCgNXtDhQGTd05SyV0=;
        b=goHnsc7O5DEA75R26hHuVygsKBy9g+mIkh4vTpqwcCQtQowBv/k2ftG4MFUQ8t98vt
         NPUC+X/oFHkv9dgcQpjlbagQsyzcv466idS9hpncZg3LO2YReALOq7cXkHlX60vUBITK
         LBZwhHQyrMLIQWg68w8KxR++t3/N1rFSKmN1HlZVwwKUOr/zR9WjnMKAdY135O92VxaC
         ZAKhYaL+EaGjQ4aFodiXTzxrzjIHmPAW2g2NtiJt9u6MELLw8ddDqh7UOA1CgErRK+5I
         k85axDIABo5kax3ATLRko1uONVvn3RZaW7LoVznE79lJQX7haldFnRDw/zIhL4aworVR
         N3fg==
X-Gm-Message-State: AOAM532u5Y5b1Ep5x0Cab5e6j7b2/UOuYj14orrxvgbFmLKSUWsYtnNL
        qNeUtrajC84zLM+oAGF0P0whdoR23BY=
X-Google-Smtp-Source: ABdhPJzdTKTQBoZQVdyvAYVfzFbNpXYen70f67yKdvzm2ogJ2vncEvP6TU5D5Ee/B48fLu7T3VEWBQ==
X-Received: by 2002:a1c:f619:: with SMTP id w25mr4856916wmc.62.1600846080406;
        Wed, 23 Sep 2020 00:28:00 -0700 (PDT)
Received: from localhost.localdomain ([178.237.235.60])
        by smtp.gmail.com with ESMTPSA id j14sm30046838wrr.66.2020.09.23.00.27.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 00:27:59 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v8 0/6] Finish converting git bisect to C part 2 subset 1
Date:   Wed, 23 Sep 2020 09:27:34 +0200
Message-Id: <20200923072740.20772-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches correspond to a second part of patch series 
of Outreachy project "Finish converting `git bisect` from shell to C" 
started by Pranit Bauva and Tanushree Tumane
(https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
continued by me.

This patch series version is composed by the first six patches of the
previous version due to a bug discovered during the test stage, that 
affects the rest of the patches and that needs to be fixed before 
sending them.

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-work-part2-v8-subset1.

I would like to thank Johannes Schindelin for reviewing this patch series
and to Christian Couder for his advice and help.

General changes
---------------

* Rebased on 385c171a01, (Fifteenth batch, 2020-09-18) to update command
help messages.


Specific changes
----------------


[4/6] bisect--helper: reimplement `bisect_autostart` shell function in C

* Amend commit message.
* Change to `return -1` when we cannot autostart.
* Add `|| exit` to bisect-autostart call in shell script.

---


[6/6] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell
 functions in C
 
* Amend commit message.
* Amend new modes order in cmdmode enum.
* Add `|| exit` to bisect-auto-next call in shell script.

 
---

Miriam Rubio (4):
  bisect--helper: BUG() in cmd_*() on invalid subcommand
  bisect--helper: use '-res' in 'cmd_bisect__helper' return
  bisect--helper: introduce new `write_in_file()` function
  bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'

Pranit Bauva (2):
  bisect--helper: reimplement `bisect_autostart` shell function in C
  bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell
    functions in C

 bisect.c                 |  13 +-
 builtin/bisect--helper.c | 269 +++++++++++++++++++++++++++++++++++++--
 git-bisect.sh            |  70 +---------
 3 files changed, 274 insertions(+), 78 deletions(-)

-- 
2.25.0

