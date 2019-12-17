Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD0FC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 09:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0476A20733
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 09:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmwMZ0S6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLQJR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 04:17:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36199 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLQJR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 04:17:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so2224609wma.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 01:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=uNvxphcomjW3F5kUnll2C36usil75+939RD6fdlRJ2o=;
        b=CmwMZ0S6mFjAEI5ULEoMMH9XW3ozeWewBrOxru+gcHzxXSNp/TAaOx0KJpm1gUuyaX
         5w6Jpz7YgQQzekQbJ9F3YLG2aZm5UMt7RjDXtTF2sJU/1V/k7jVF/6ux92TsaT3cwzS9
         iH3XUtsuHVqYfCR/ST4I/+9kk0zX1MtwpBX3ESXJ6RljbX1NrqYyQW+qejlHz6CWrgyX
         M0rbdKwE8NAOD4gPcI9DQChdR7134nfFAVdVOmZBifTz+7b54EEDJahOTN3skM7Otg0w
         ITixPH9xcbDcUe5e5q9tKtFuIc6KpkIIaDbTg+8t4+1OUHXe8TVpqKJN+1zlKbJobPs8
         XW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uNvxphcomjW3F5kUnll2C36usil75+939RD6fdlRJ2o=;
        b=t0gsnYvs0FVD1B/ldQ3icIN5Y1I0LM557ATrxZSejPxWuZVA5s9+VORYAzEoSUCjDv
         Zic/+q2ERW2EGcysMn2CVNMejb4m2g5GRJ8cYTFochSv+YQj4HsG7Kuxm3Oyxo2Ub/mI
         1hhLfNYpjkVDeAtfMSx8pQCY9cGCtXBsxz1GW40UvnLO2+f5MXd0X5HUAuTWz1lOJ66n
         8obFmqpw4f3bs1OAF+mMevnG/rwXVW/2Y+errc5NpAOiA8aTOfqWWYNLvugtXbWo+1d/
         ObIAi9irNglvAhjjgq4YDUbLYPCB/hvRh+lNYxmjOn1u7f8rWpOj4yljKfg2Cj2xkZgO
         nzYw==
X-Gm-Message-State: APjAAAURxO2/VStQiEdweaFs1Gd5FYP7fryvWFnZKNjQNSFPeRdVRf09
        7KI8YQUj0fbFqFM/GGGLuBR6KIMl
X-Google-Smtp-Source: APXvYqzsCW5fVgUhjMP5jtc/NkP4w90Jmgmg5CNw+Z9RwY1JRIKw6/i5vCZbygQXxYE2Qkfw21QslA==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr3851044wmc.145.1576574244133;
        Tue, 17 Dec 2019 01:17:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v14sm24888507wrm.28.2019.12.17.01.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 01:17:23 -0800 (PST)
Message-Id: <pull.495.git.1576574242.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 09:17:21 +0000
Subject: [PATCH 0/1] [Outreachy] commit: display advice hints when commit fails
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Display hints to the user when trying to commit without staging the modified
files first (when advice.statusHints is set to true). Change the output of
the unsuccessful commit from e.g:

[...]
=====

Changes not staged for commit:
==============================

modified: builtin/commit.c
==========================

 #

no changes added to commit
==========================

to:

[...]
=====

Changes not staged for commit:
==============================

(use "git add ..." to update what will be committed)
====================================================

(use "git checkout -- ..." to discard changes in working directory)
===================================================================

 #

modified: ../builtin/commit.c
=============================

 #

no changes added to commit (use "git add" and/or "git commit -a")
=================================================================

In ea9882bfc4 (commit: disable status hints when writing to COMMIT_EDITMSG,
2013-09-12) the intent was to disable status hints when writing to
COMMIT_EDITMSG, but in fact the implementation disabled status messages in
more locations, e.g in case the commit wasn't successful, status hints will
still be disabled and no hints will be displayed to the user although
advice.statusHints is set to true.

Signed-off-by: Heba Waly heba.waly@gmail.com [heba.waly@gmail.com]

Heba Waly (1):
  commit: display advice hints when commit fails

 builtin/commit.c                          | 1 +
 t/t7500-commit-template-squash-signoff.sh | 9 +++++++++
 2 files changed, 10 insertions(+)


base-commit: ad05a3d8e5a6a06443836b5e40434262d992889a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-495%2FHebaWaly%2Fhints-for-unsuccessful-commit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-495/HebaWaly/hints-for-unsuccessful-commit-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/495
-- 
gitgitgadget
