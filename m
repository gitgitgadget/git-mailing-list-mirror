Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E0121F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 18:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfKMSzb (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 13:55:31 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41378 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfKMSzb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 13:55:31 -0500
Received: by mail-lf1-f67.google.com with SMTP id j14so2825165lfb.8
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 10:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UAZYN8hUUhxxK3NgmCD7WYU1OzrmPV8BmuD6VBlYx/U=;
        b=UPIxdirVkncoXWIpVWBBGp+B3jM/DdaMVR4O4VtJSDVV6BH0ueIWE2jubqVHKVoE/0
         YdNlUnMK/X71g9ImF2Bz7vKexML894RoWjU6sowkgyf3DIu6EXDZ+5kIhdUK34Mz+dK1
         yxG1v8eB85tvDF7FL7g3hEIBZQGiOCJJJmEp+Y5R3rzG2hZi8ghg2qLXC8HYZgN6d1Mf
         kJQ7Jr4JHtOj1oUFIQPMAaOXb4jjb+7Pf7IB5XMfMWRxaOfgyyK72KJadRuV9TSOWslY
         h9DGQg5XrNVUMgOLGnBMAYS44+yrWg0q7xLO9GdinqJ4xKcA5nRNdm55cw/9zdiRvuol
         s4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UAZYN8hUUhxxK3NgmCD7WYU1OzrmPV8BmuD6VBlYx/U=;
        b=clmlUkPfGVzFjeLcV4i/KdhNQyF/S7T1GG8wQI3Jy+XRWeoxIqKZas5Pe4peDujyuo
         jrseKep4Gg6uX6MvvrAPtuhl43hGXPr2hFuuZzUyrHcSMJVqovUU+OllLefdu+8CngiY
         e0JKHs/+YYuZnZCa2CCpqg5Dk1nWEJtzJHccuMumhIAYChbQ1HTbgM7OtaFn8chUR30k
         OG96IDZqOhY8fFuRxBzErsyFwJbMD2/FSlMYV77YplOcpdV+qkVm54Ys7UOPAO0HMXOM
         owtUOx2wWz3v8M70NUwfcKbqG5ask3QRxVZrv1S7h1xDp6tfor+zY+2PdAay7jb81EyG
         x/Jg==
X-Gm-Message-State: APjAAAXt3CvsZK/dtvfn/fde6SYCuTeoGrId+VxoWbEFYdGtgv6Ozv1Y
        5c6E8TURwZ2rnyxy1vu7T21D21Wv
X-Google-Smtp-Source: APXvYqyD7aZDtADJv0hXGqbmYwhngPrKONPbqPPH+dr6K8KC7ZucKBzp8C2C5/vSnJH1ye2B690Rhw==
X-Received: by 2002:a19:5010:: with SMTP id e16mr4025888lfb.49.1573671328655;
        Wed, 13 Nov 2019 10:55:28 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id c24sm1422765lfm.20.2019.11.13.10.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:55:27 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/8] builtin/config: canonicalize "value_regex" with `--type=bool[-or-int]`
Date:   Wed, 13 Nov 2019 19:54:59 +0100
Message-Id: <cover.1573670565.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To find all config items "foo.*" that are configured as the Boolean
value "true", you can try executing

  git config --type=bool --name-only --get-regexp '^foo\.' true

... and hope that you didn't spell "true" as "on", "True" or "1" back
when you populated your config. This shortcoming has been mentioned as a
left-over bit [1] [2].

This patch series teaches `git config` to canonicalize the incoming
"value_regex" ("true" in the example above), then canonicalize candidate
values as we go through the config. Or if you will, `git config` learns
a brand new type of regex, corresponding to the different ways there are
of spelling "true" and "false", respectively.

`--type=bool-or-int` gets the same treatment, except we need to to be
able to handle the ints and regexes matching particular ints that we
must expect. That said, even with `--type=bool` we can't move too
aggressively towards *requiring* that the incoming "value_regex"
canonializes as a Boolean value. The penultimate patch starts to warn on
non-canonicalizing values; the final patch makes us bail out entirely.

The last patch is not meant for immediate inclusion, but I post it
anyway. I can re-submit it at an appropriate time, or maybe it could
slumber on pu until the time is ripe for completing the switch.

[1] https://git-blame.blogspot.com/p/leftover-bits.html
[2] https://public-inbox.org/git/xmqq7frsh4tw.fsf@gitster.dls.corp.google.com/

Martin Ågren (8):
  config: make `git_parse_maybe_bool_text()` public
  t1300: modernize part of script
  builtin/config: extract `handle_value_regex()` from `get_value()`
  builtin/config: collect "value_regexp" data in a struct
  builtin/config: canonicalize "value_regex" with `--type=bool`
  builtin/config: canonicalize "value_regex" with `--type=bool-or-int`
  builtin/config: warn if "value_regex" doesn't canonicalize as boolean
  builtin/config: die if "value_regex" doesn't canonicalize as boolean

 Documentation/git-config.txt |   5 +
 builtin/config.c             |  84 +++++++++++----
 config.c                     |   2 +-
 config.h                     |   7 ++
 t/t1300-config.sh            | 199 ++++++++++++++++++++++-------------
 5 files changed, 203 insertions(+), 94 deletions(-)

-- 
2.24.0

