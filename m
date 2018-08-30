Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4EF11F404
	for <e@80x24.org>; Thu, 30 Aug 2018 13:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeH3RWL (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 13:22:11 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33590 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbeH3RWL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 13:22:11 -0400
Received: by mail-oi0-f53.google.com with SMTP id 8-v6so15363349oip.0
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 06:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mintlab-nl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=97T1QxUl/ce2q4s0FvkJCFBLKQTgc0LkY8PGg/uX1IY=;
        b=P1U8PPxze61wanre9jL6qL+QQv7dRiQA5FH0oC/Ka21TD2xUOQnqCBuC4hsXxzMmB1
         lIMur0QhM4TCrlNtArk6BVlaqCXICccjhymryv3dtHNlkrW6aH7PBYNXjN7mE6VKk/IF
         Cqp4pGySx8/Op4XMOOpakPdtbnkGKCynixixIDrthluKmmSPOxVpQN6unveUcfXIVRUM
         u3emB3Rq9C3zoERy8yH08bN9XNSJ8x5G8rRTTYdgZOw+EiOF6m6Hl9CkEQFIZyKewSZD
         nnzvJamjBzsLfg8LI41M+BFiGh7evTCsxzfangAis7Ghvt9NQUw+07pdEh5y9fOL3XZY
         rVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=97T1QxUl/ce2q4s0FvkJCFBLKQTgc0LkY8PGg/uX1IY=;
        b=ClW/2VZvYSI/zKrS4Br7cvoi/5dNmrRktjIElIwzgrivJy9IKNxM9XpA9Dpi2ouO2N
         brX6m7uU/p9p7Qf350O2D/Ep/GYcKhm7hfj8kgcpyhzfNeZpVM5R2p6JWM5HyGKrRxS/
         Oenm6j4VtYOtT1ewfeg/3w4Ut/XHXuwhe1b3RvlRxzDo/PQc1WSPPkNho8oURiF8uwOm
         1PMIiexbQ4TDH4TOindzP/vKV1ZCvhw7Iqi1YERqiuUVmhmIwXcPzVwuFi0+frF7J+ff
         ZP2YBpZ3o4Q4hbkD9DIGtHQ/ehU5hIP6Axo5SXk0g2t3tSosxU7OhnlCGC1pKOdIKM9m
         yrIQ==
X-Gm-Message-State: APzg51Blnz8j8C0eBiuPHhNAW7C0iRYYKKGwWSCy9zdiwe6GoGQ4gNDK
        EIMOMXeQ7XTYsu2S7dFrRQga3Tu1eqRlarBE1IXktV3i
X-Google-Smtp-Source: ANB0Vdbp7YVnt5Njw4oWFNnl6HcQeD6chzarpXor5n0cDwwW//38j3Iml/bI0RYrtW0YFpQyayQ1D8oW4MOuThDmpus=
X-Received: by 2002:aca:438a:: with SMTP id q132-v6mr2595277oia.331.1535635203632;
 Thu, 30 Aug 2018 06:20:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8c62:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 06:20:03
 -0700 (PDT)
From:   Wesley Schwengle <wesley@mintlab.nl>
Date:   Thu, 30 Aug 2018 15:20:03 +0200
Message-ID: <CAEpdsiYHri8FJ8VohnwxmPwDM4-0J4J9Zb9wTZjYYRnYqsb=nA@mail.gmail.com>
Subject: Feature request: hooks directory
To:     Git mailinglist <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I would like to ask if it is worth my time looking into the following
solution to a problem we have at work.

Problem:
We want to have some git-hooks and we want to provide them to the
user. In a most recent example we have a post-checkout hook that deals
with some Docker things. However, if we update that post-checkout hook
my local overrides in that post-checkout hook are going to be
overwritten.

Solution:
We discussed this at work and we thought about making a .d directory
for the hooks, eg.  $GIT_DIR/hooks/post-commit.d, where a user can put
the post-commit hooks in. This allows us to provide post commit hooks
and allows the user to add additional hooks him/herself. We could
implement this in our own code base. But we were wondering if this
approach could be shared with the git community and if this behavior
is wanted in git itself.


Cheers,
Wesley

-- 
Wesley Schwengle, Developer
Mintlab B.V., https://www.zaaksysteem.nl
E: wesley@mintlab.nl
T:  +31 20 737 00 05
