Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C14B207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 22:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752929AbcIZWrH (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 18:47:07 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36238 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbcIZWrF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 18:47:05 -0400
Received: by mail-pf0-f176.google.com with SMTP id q2so70137434pfj.3
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 15:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2GBoN8GfbmuX7pDyj4Kn3oJ5qdU1dpgxGiGQTDpuwuI=;
        b=BVfyzVA+vSyk9lR09t6pJMBAzdhwA3gbUdd/LuAO/l1yneBAAZlAewx5ysl0nq6T+G
         X9q9lEnro5DztvT7c3xDUufYnmoCMdgqaQZXg6KZnqv0rvoUlv2z84+WcurdS9Ex8qKT
         v+mS3RkFOIy37TZIeuTRJwh6o0L4n72OAji5BtaKbuXfyKwuk3prMNafMSsAIulztHyD
         kPVzCshd8KO3c+AeY4bEem+0Oh6a/O6omQkv5fY7bFwPS8iLTaib1DY4X8+9qu22MvX4
         IGiLpHwWRJyhMjg6WSBn4O/yYzcSZ7m8XOUJ+2igAHq3hVr3enIryR/gL9T4HEhgDjdO
         bBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2GBoN8GfbmuX7pDyj4Kn3oJ5qdU1dpgxGiGQTDpuwuI=;
        b=XjVWC70PwcGtzOOuk+/du8SRKmwaieWzPLpT3OiOwzuTJbHSvkqCwWH9h7atncynz2
         7F9CYDTz5Br8s/WtLBXraQx4pvp7YQ9ezT/0rQZkMqFrhCVndhYvAD7P7CvJ1LaPSuoj
         xu/QfmYRlfpCmr9FxGOm3UfF2Qs03apfM0Rxs3xlttRnU9sU8CaxUCpuw+BarvD/xxnO
         pJQ9Wp9wA+visj5RD82cSLxq/TU4K/hhwq5Q3YvEnzkb9JgQLSx6u5i0TExQb4AdxO8Z
         2YwjsESF5gXr9EarsDPDezjIaPvCzVbArlshFZo+Km2BCBMUp6rNRu/TWZTTe7AViLYy
         74DQ==
X-Gm-Message-State: AE9vXwO8le2C8ztpFVDYsibLqEfq5MJVEYiX6IkzWh6kY7fqLc2uC5KCBlRksJxIQDeVax8O
X-Received: by 10.98.131.193 with SMTP id h184mr42182745pfe.92.1474930024896;
        Mon, 26 Sep 2016 15:47:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:9046:8098:b971:afcc])
        by smtp.gmail.com with ESMTPSA id y1sm33306775pfd.90.2016.09.26.15.47.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Sep 2016 15:47:03 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 0/4 v4] recursive support for ls-files
Date:   Mon, 26 Sep 2016 15:46:39 -0700
Message-Id: <1474930003-83750-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1474676014-134568-1-git-send-email-bmwill@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple things have changed in v4:

- Restructured the patch series to prevent a breakage mid-way.
- Added an additional patch in the middle to pass through safe options.  This
  way the series is structured in a more coherent manor.
- Added --submodule-prefix to top-level git.c

Hopefully this series addresses some of issues brought up in v3

Brandon Williams (4):
  submodules: make submodule-prefix option
  ls-files: optionally recurse into submodules
  ls-files: pass through safe options for --recurse-submodules
  ls-files: add pathspec matching for submodules

 Documentation/git-ls-files.txt         |   7 +-
 Documentation/git.txt                  |   5 +
 builtin/ls-files.c                     | 187 ++++++++++++++++++++++-------
 cache.h                                |   1 +
 dir.c                                  |  46 +++++++-
 dir.h                                  |   4 +
 environment.c                          |   1 +
 git.c                                  |  21 +++-
 t/t3007-ls-files-recurse-submodules.sh | 209 +++++++++++++++++++++++++++++++++
 9 files changed, 437 insertions(+), 44 deletions(-)
 create mode 100755 t/t3007-ls-files-recurse-submodules.sh

-- 
2.8.0.rc3.226.g39d4020

