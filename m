Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7592CC4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 18:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A89206E5
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 18:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8Vh/fwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827180AbgJ0SV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 14:21:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38958 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753814AbgJ0OCY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 10:02:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id d3so1561733wma.4
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 07:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=/sjy/Rdnn2jCJbT/1EOnf25bRi9aP1+QMpgrW9BwypA=;
        b=M8Vh/fwVLvHyRULnfyFat+Mp5/aKoDDPp/fo1KVJ1UDa8ht7uh9hwSa4UmygHpKHfU
         vMyiA+wXFuA29HQUlLUk8KI+XwNyp04mIoekBFYp+T7YxVuhWTqNzt/0KkRJejobZpnw
         uqE/qnyFYucPXP200kBhraZq4iDOJzUt8IiAEiHqHECYhbe7/xYINi+lq//AzlU8gbxL
         h9QFrjPpCvdkXzXr0JS+veN2CLXpRxTv7nimXe9aSe3yEAL7xARa/UZZUMXzSxgJ3tDD
         TBmHVEYBxWJ2iW9FNPY6Ay1hSpFgoQ8ckaslMEzLf3NAbctBI5KPgo/I5Wm9KHhqRxRF
         K8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/sjy/Rdnn2jCJbT/1EOnf25bRi9aP1+QMpgrW9BwypA=;
        b=oyIMoMuFOKZeh18aCB7J/8+9uh3S99rMhmN9lysKW+HHflVlbm5RdUM9D9jY5TXqws
         vpN43HF2IwsnQ0C0sCt7rAyVKGJzKD0D/zBcKeBh9OLyFYZmdyJ/NKA//2I5NKHxHxiC
         Zch4MTx0iAJahXdhHJOWSNydTJJKYjxK2k3sOYcaSO38jLjC9uI3w2kXj2pSLe9mOyI2
         wJDSoioFMWiQX2N+0/A8MVhCPLoS2GglsVOoAfNvA9t6RGiCJMLlXZljBZB2uWQ3AiIw
         UrG4pi2KeSnPvR4zRcdxHDssnb6J7vYGvr/aRHgHR4cVs5tXFg5eN9h8+UW83d4qYvNI
         DOyQ==
X-Gm-Message-State: AOAM531BMq+h+kXrbxYa6M6reNKODUL7QzJ8MYO/+wWtSy5ligPu69OW
        5KNJlQHnMqwP+EipGIZT+HXolv6I4dA=
X-Google-Smtp-Source: ABdhPJxb5VVphz/9BZzeJxxANa6v5AJAHbHj244lNQkGw+dI7McBrRWpYT1jheASbbArtcWi8qXxdA==
X-Received: by 2002:a1c:de55:: with SMTP id v82mr2990134wmg.71.1603807339223;
        Tue, 27 Oct 2020 07:02:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7sm2234816wrn.81.2020.10.27.07.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 07:02:18 -0700 (PDT)
Message-Id: <pull.773.git.1603807337.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Oct 2020 14:02:13 +0000
Subject: [PATCH 0/4] rebase -i: fix ORIG_HEAD handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Caspar Duregger <herr.kaste@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The buffer containing the oid for ORIG_HEAD is overwritten before ORIG_HEAD
is created. This series fixes that bug and then converts the code to use
struct object_id rather than passing around strings.

Thanks to Caspar for reporting the bug and providing a reproducible example

Phillip Wood (4):
  rebase -i: stop overwriting ORIG_HEAD buffer
  rebase -i: use struct object_id rather than looking up commit
  rebase -i: use struct object_id when writing state
  rebase -i: simplify get_revision_ranges()

 builtin/rebase.c              | 20 ++++++++++----------
 sequencer.c                   | 15 ++++++---------
 sequencer.h                   |  7 ++++---
 t/t3404-rebase-interactive.sh | 11 +++++++++++
 4 files changed, 31 insertions(+), 22 deletions(-)


base-commit: 2e673356aefa8ed19be3c878f966ad6189ecb510
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-773%2Fphillipwood%2Fwip%2Frebase-fix-orig_head-handling-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-773/phillipwood/wip/rebase-fix-orig_head-handling-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/773
-- 
gitgitgadget
