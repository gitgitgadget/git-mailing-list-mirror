Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 259B720281
	for <e@80x24.org>; Sun,  5 Nov 2017 20:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751041AbdKEU0v (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 15:26:51 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:52474 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbdKEU0u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 15:26:50 -0500
Received: by mail-wr0-f194.google.com with SMTP id j23so2591496wra.9
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 12:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KdWil0Mw5jNbof/JQSgIuuFkPZpBKIOt8//xKlQ7b6o=;
        b=PEf6Dom3zfObgfVDtFr4UsRKVKp1eSs53+gP/32GJQVmlIr7pw7Be4cRBDsPeeJXml
         SwAVrHOVc8hQrP1knaPgKOtixO9kxfdTe/6e2hl1qaBwlmoBI2+7q9GZCzlNhDweY1jD
         u+PfWtIj7Udmhu+DuShT5jUXNEePZhEENokobIGc9cuP4ZnX7PIiGmnvf9ttTsXeszDt
         QAFlSkdlTPbzUmXe8D+2LftctZx0vKNZrP50vTlmEHBzHX2tYjzhuSmj0mwRyc+sANbg
         /PQt7WCIVtbF1/CFwVfbubGu4l+o4/OwU9qR3UVZBtDL/l6dfk+HDCxJzdUxGMRDGF9P
         rfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KdWil0Mw5jNbof/JQSgIuuFkPZpBKIOt8//xKlQ7b6o=;
        b=kzsqWLoi+OU657fFTIdO1ydg4aTUDzWF6UmEOVKI4L6itXgaG33N7dWpwMpNR7oz2p
         doEPn3YyJZdvuUqDkWvKYz2jlSuG/DBMazMi/4wozQQi0L5uq8ZWJ9QawyQrjPWRJi3Y
         qVvEnpsDkFXP2AwzlH0AIzGWe5vZLGtt8ZWDQrlje8z3w5LXo3gQ9rbgSTHWPhFXol/Z
         6d4aAx/+dtC4TU8FNyxx2C+5zrKdVrCsg+3eKoYSG/QFu3vfetDoEEckPiOMDBypfkdF
         CGQmGiLx0BF1fANZCXsljnG1JY56TRFzfU0YbkgHJcojqUWGwYvbetvP0yyBso4coBwM
         mmrg==
X-Gm-Message-State: AMCzsaV1RzBVxhW6CX76SKgQvB5LQIas5Zmv758MEV5lhA2Oha+XtFiL
        fAGdIjol6SfeWPaJVnU8BLFaVuRw
X-Google-Smtp-Source: ABhQp+S0MdjVkNyRXeSGM0+v8fFA6I7oicx9xqlWxa4vUIC4MBiAbQtl3UOBFpEgd23C3KKx0QVV9g==
X-Received: by 10.223.133.174 with SMTP id 43mr11313763wrt.17.1509913608985;
        Sun, 05 Nov 2017 12:26:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id u138sm11573033wmd.17.2017.11.05.12.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 12:26:48 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] Re: reduce_heads: fix memory leaks
Date:   Sun,  5 Nov 2017 21:26:29 +0100
Message-Id: <cover.1509908607.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <CAN0heSpgUBy4a6iok4MoDqJ__hZtrXvfApcxjHuS0vOBKSuShg@mail.gmail.com>
References: <CAN0heSpgUBy4a6iok4MoDqJ__hZtrXvfApcxjHuS0vOBKSuShg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v1 [1], I've added a preparatory patch to UNLEAK some variables.
That sets the stage slightly better for patch 2.

Junio, you placed v1 on maint. Because UNLEAK is not in maint, this is
based on master and maint misses out on this v2. If you have any advice
for how I should (not) do series with UNLEAK in them, I'm all ears.

Martin

[1] https://public-inbox.org/git/20171101090326.8091-1-martin.agren@gmail.com/

Martin Ågren (2):
  builtin/merge-base: UNLEAK commit lists
  reduce_heads: fix memory leaks

 commit.h                | 18 +++++++++++++++++-
 builtin/commit.c        |  2 +-
 builtin/fmt-merge-msg.c |  2 +-
 builtin/merge-base.c    | 40 +++++++++++++++++++++-------------------
 builtin/merge.c         |  1 +
 builtin/pull.c          |  5 ++++-
 commit.c                |  7 +++++++
 7 files changed, 52 insertions(+), 23 deletions(-)

-- 
2.15.0.415.gac1375d7e

