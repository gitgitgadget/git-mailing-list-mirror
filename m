Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607C7C7EE2E
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 14:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjB1OCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 09:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjB1OCq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 09:02:46 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AA52D154
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 06:02:41 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-17227cba608so11004314fac.3
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 06:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BTeKwecsraFf6Fp4l/X1eqZAMgk09SKedl6NM5mnsEs=;
        b=kWyVScwxMZDTljgqFuaXOJxBD/lLB6W6/4eX+CvTLLi3WuC6AeLCUZT3d4oeYqryoN
         gSBxo32a3hcLHwirj+4AWiH/top49mJrPwRe1Embyy7UIk7WiyGdOeR5qaPa3ODID0e8
         oAxqyyyqQ3SxP0XMD6zFOa64hqJIZu0vNLgf4Trvm2T/0xOsthqdgnJUAkLi6qE/8A9c
         RY6zHDAuutGfCQBrZROVyNyDxTFkCyYf4JyMNa5j4nqqD38E2fh6jWaGmNXdtGuuFgoh
         vxua4My4KlZkyXvF5yy5gAC2rIbeUrJ9bqxWfJ3Lp9k0c4e1qE7SWKUTQ1vcQxQyV506
         UbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTeKwecsraFf6Fp4l/X1eqZAMgk09SKedl6NM5mnsEs=;
        b=fdKUbLuM0kG8+tHpLoQppKiv39QjFJWPOxNJ7uNZoQCCgcY5s+Tm6Azny0X7JcJ8G8
         lJDXuBZ4zdlXD3aWqhnX1w7WgNAVWhHZh3coRutCuG+OZYsgA2RYFDOeyY4N1UZRJxGi
         II0kPPus9tGq3XT1uE+/FZX6bakMCTvFCrYB+IvvTnmZH0L6Pu0L85iQmpXspQx+YQA4
         SVd4djtrGD3I0uRUbHYv4CjblQ2hyYtOtfDBOb0uunWr3HoLr/zOzxFGUOH8gSEN2/JG
         Ill6nzHMYkABZV6SwKrlpmY5wBKpsA4vjQx33YyfvsKiY8MimCCo8yd2Iipri18TK6gz
         pBkQ==
X-Gm-Message-State: AO0yUKV/PuCtU/axdrzMe8Q20Kk26oxJJKgQChHbaKwQB9RunAIkQ8lH
        IzGv2IoCxMSkmIZ8O2P/4ICuH2KnyaM=
X-Google-Smtp-Source: AK7set+QvIV8UK1raIDu8woqpEmzuQZvXaJW0FqnNd86c6Aeov/GSL6EVHrIDmQFTolv1wHl0aWTfA==
X-Received: by 2002:a05:6871:69e:b0:172:36ac:f715 with SMTP id l30-20020a056871069e00b0017236acf715mr1588404oao.11.1677592957778;
        Tue, 28 Feb 2023 06:02:37 -0800 (PST)
Received: from localhost ([2806:2f0:4060:3465:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id f9-20020a4a6709000000b0051ffe0fe11bsm3776564ooc.6.2023.02.28.06.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 06:02:37 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Sergey Organov <sorganov@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 0/2] Example of pull.mode
Date:   Tue, 28 Feb 2023 08:02:34 -0600
Message-Id: <20230228140236.4175835-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The discussions about the default mode of pull never end, since there's
yet another discussion [1] about the relationship with
pull.rebase=merges I'm sending a condensed version of my git update
patches [2] which were not properly considered, but they solve the
issue.

The two configurations in particular that are currently broken are:

    git config pull.mode merge
    git config pull.rebase merges
    git pull --rebase # same as --rebase=merges

And:

    git config pull.rebase true
    git pull --no-ff # no mode specified

These patches are *not* meant to be merged, they are just meant as
reference for the new discussion.

I have the patches properly split and with tests, which I avoided here
for the sake of simplicity.

[1] https://lore.kernel.org/git/pull.1474.git.1675614276549.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/20210705123209.1808663-1-felipe.contreras@gmail.com/

Felipe Contreras (2):
  Add pull.mode
  pull: improve --rebase and pull.rebase interaction

 Documentation/config/branch.txt |   5 +
 Documentation/config/pull.txt   |   6 ++
 Documentation/git-pull.txt      |  15 +--
 builtin/pull.c                  | 157 ++++++++++++++++++++++----------
 rebase.c                        |  12 +++
 rebase.h                        |  13 ++-
 t/t7601-merge-pull-config.sh    |  30 +++---
 7 files changed, 166 insertions(+), 72 deletions(-)

-- 
2.39.2

