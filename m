Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DFA5203C1
	for <e@80x24.org>; Tue, 13 Dec 2016 01:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932495AbcLMBlE (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 20:41:04 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33043 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752884AbcLMBlA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 20:41:00 -0500
Received: by mail-pg0-f45.google.com with SMTP id 3so41577571pgd.0
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 17:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=WU9E/i2Iu6QmHbR+jqwUdTSKi2HbM+OFyVPK8b50KLc=;
        b=RHAY7M6JzJh9BcoRCX/fqj4IQu9DVjF1I3+hjTs7GHa0gPAgl/+R0aUCJ0DCeyW/+z
         ocbOEXEKu7wwiWsxq3cto9P9llyIWc+1ML0bBKv3cyXYalYxue4jtFFfzq6DnVOB3/o+
         uDh9dKz8AlG5E0yTSty3CVB5dH7cy+C27H+E55Yg/6iqawyVd2cjXalstqaQjxlt2bEh
         nbjZPuQ0X8S6EWmb4Xn6W7JX4Y0R8AJnsOS3v5ld6tj2Q9NGAbdRxMcVjahRJbv2DOHB
         FqBQWgEw4YLnfJD30gS6lI6WbTpR4zEooEEKf4h/ejdhJAy3cQ5CDJWWTq14aZyyJBVC
         /oIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WU9E/i2Iu6QmHbR+jqwUdTSKi2HbM+OFyVPK8b50KLc=;
        b=NAQSR19brGK3R3Cm7TCwoAOHbwSNLxLzgwGnzLQwItilOwqgopJOLjicaDGbIH6VKe
         F2wtDh7vNIowxlQf1UjwueCfCxXOMa9g8oPaiCQbx/LgVJekpHBQIASmBjL7OwYWM4Kx
         J1o3SMR6yWbIOwlNg9tQz21X7f1w/uQfr6hrXBaQ78HhQoSGMWy98bf+/+8Z4S8YvwLA
         4HZj00BvM33+MBfpHQHxH+C6nZ/BPz2AmedbioMwInS06kTXykuM7qMq2JAAkqjHAbd1
         rl/WOzHpFXtn6mvvxOWxBwb47W/3AfZK7XiiERTbRdaz5uQgi+66fxKeMdoNW7mHJ25/
         MxBA==
X-Gm-Message-State: AKaTC00CyboDqfj4WeWMMZHsLkRanNBGQYHXAg2nZjP9r9gZhQPt7FLQbEGvikvp6PjXJ/Qi
X-Received: by 10.84.142.1 with SMTP id 1mr187989776plw.87.1481593259338;
        Mon, 12 Dec 2016 17:40:59 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:642c:37a4:3709:a2b3])
        by smtp.gmail.com with ESMTPSA id y20sm78250317pfj.26.2016.12.12.17.40.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 17:40:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/6] git-rm absorbs submodule git directory before deletion
Date:   Mon, 12 Dec 2016 17:40:49 -0800
Message-Id: <20161213014055.14268-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.35.g26e18c9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "checkout --recurse-submodules" series got too large to comfortably send
it out for review, so I had to break it up into smaller series'; this is the
first subseries, but it makes sense on its own.

This series teaches git-rm to absorb the git directory of a submodule instead
of failing and complaining about the git directory preventing deletion.
 
It applies on origin/sb/submodule-embed-gitdir.

Any feedback welcome!

Thanks,
Stefan

Stefan Beller (6):
  submodule.h: add extern keyword to functions
  submodule: modernize ok_to_remove_submodule to use argv_array
  submodule: add flags to ok_to_remove_submodule
  ok_to_remove_submodule: absorb the submodule git dir
  t3600: slightly modernize style
  rm: add absorb a submodules git dir before deletion

 builtin/rm.c  |  21 +++-----
 cache.h       |   2 +
 entry.c       |   5 ++
 submodule.c   |  77 +++++++++++++++++++++++-----
 submodule.h   |  64 ++++++++++++++---------
 t/t3600-rm.sh | 159 +++++++++++++++++++++++----------------------------------
 6 files changed, 182 insertions(+), 146 deletions(-)

-- 
2.11.0.rc2.35.g7af3268

