Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A9F41F403
	for <e@80x24.org>; Wed,  6 Jun 2018 07:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932237AbeFFHjq (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 03:39:46 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39122 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932134AbeFFHjp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 03:39:45 -0400
Received: by mail-lf0-f67.google.com with SMTP id t134-v6so7555172lff.6
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 00:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3c6kztesS3HOjZay/k1nMWk205V7RoQ8Hx/+X/4ygs=;
        b=pNQR3mZb116qaLR79rridxocXj9phVxGN7c8n5s6hmKwplZuX/W1YnT8JO+tv4XpZe
         R87z9n+YeVQYHpDtpdSGS+X8+TA9X0VWyvFQqe2XP///UhZ2XEiin3F4ofy9TVhx3qr6
         FvWUzEPpvMcdU0l2h+dVJRjmjAUu/s1qGAWfbWpgm7cDHF+vgx6zhiswEM66+XUwIoX9
         UDcbRuCIJKeCEGJcOxV0//AA31ue2EI6wh0SmAZF27Q/B2SUfE1c3rcXXPANDE46hgHm
         V4Ggw9EfpOoEfy2hzwuNveTgqGxmzBbC3njoL0/BpDvw9OrC868S5bs66hzWNTFudTQ2
         /TZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3c6kztesS3HOjZay/k1nMWk205V7RoQ8Hx/+X/4ygs=;
        b=JkUepJkqHLQlsAqXmlKCj6HIMk8ORDxYdDOi6TjmkTG6n+sjwnsUzbAoydKgaXs1wO
         rlTTvwWXkTms5u4Ze3sFxa68A1ebVtI5abZsLiu6pLM8mGZ3a1DYIpCyzcsqS8rTwl/g
         phANF+C+jxfPSpIcupI6vxAf6vHKWtDsRnXKwscGCujYiEhb4nC5eAAIEMsSOdOv3Ic9
         Vm9XD8NRrdkIthFjmVYGX2d1LwlgnAI2zCXS6TfGD6IIRu9zXzL2gvGpVG/pCOiROOvb
         xPrylFHP6PvK7J+1CFpyCOBgQZ0UV8GHkukMV4Z4AyD/IciM0IKdsmYiBaGsX8MWhUsH
         TR7A==
X-Gm-Message-State: APt69E2+eM1adQVlCA+Vr3M62/sTfOc5qe1Vtfbt+g2jSev2kKkyllew
        k/bZ0DGZ1Qy9Bo1aUT5sPw0=
X-Google-Smtp-Source: ADUXVKIjrB9nCirdBkyTV43MqcEPeE8dF/f28ddWx1M9epm3/DafxmPmSnybTGFm3bmQ79p+C6OCEA==
X-Received: by 2002:a2e:21c7:: with SMTP id h68-v6mr1253291lji.108.1528270784250;
        Wed, 06 Jun 2018 00:39:44 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4189048lji.4.2018.06.06.00.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 00:39:43 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v3 00/20] Fix incorrect use of the_index
Date:   Wed,  6 Jun 2018 09:39:13 +0200
Message-Id: <20180606073933.14755-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606050207.13556-1-pclouds@gmail.com>
References: <20180606050207.13556-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 6, 2018 at 7:02 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> v2 fixes an incorrect patch splitting (I should have built one more
> time :P) between 3/5 and 4/5. v1's 6/6 is dropped. Brandon suggested a
> better way of doing it which may happen later.

I started looking into Brandon's suggestion, did some mindless
conversion, then found out a couple more incorrect uses of the_index
:( So here's the whole thing.

Nguyễn Thái Ngọc Duy (20):
  unpack-trees: remove 'extern' on function declaration
  unpack-trees: add a note about path invalidation
  unpack-trees: don't shadow global var the_index
  unpack-tress: convert clear_ce_flags* to avoid the_index
  unpack-trees: avoid the_index in verify_absent()
  attr.h: drop extern from function declaration
  attr: remove an implicit dependency on the_index
  convert.h: drop 'extern' from function declaration
  convert.c: remove an implicit dependency on the_index
  dir.c: remove an implicit dependency on the_index in pathspec code
  ls-files: correct index argument to get_convert_attr_ascii()
  pathspec.c: use the right index instead of the_index
  submodule.c: use the right index instead of the_index
  entry.c: use the right index instead of the_index
  attr: remove index from git_attr_set_direction()
  preload-index.c: use the right index instead of the_index
  cache.c: remove an implicit dependency on the_index
  resolve-undo.c: use the right index instead of the_index
  grep: use the right index instead of the_index
  cache.h: make the_index part of "compatibility macros"

 apply.c                     |  4 +--
 archive.c                   |  8 ++---
 attr.c                      | 52 ++++++++++++++++++-------------
 attr.h                      | 31 ++++++++++---------
 builtin/add.c               |  6 ++--
 builtin/cat-file.c          |  2 +-
 builtin/check-attr.c        |  6 ++--
 builtin/checkout-index.c    |  1 +
 builtin/checkout.c          |  4 +--
 builtin/clean.c             |  2 +-
 builtin/commit.c            |  2 +-
 builtin/difftool.c          |  4 +--
 builtin/grep.c              |  6 ++--
 builtin/ls-files.c          | 17 ++++++-----
 builtin/pack-objects.c      |  2 +-
 builtin/reset.c             |  2 +-
 builtin/rm.c                |  2 +-
 builtin/submodule--helper.c |  2 +-
 builtin/update-index.c      |  2 +-
 cache.h                     |  9 +++---
 convert.c                   | 41 ++++++++++++++-----------
 convert.h                   | 61 +++++++++++++++++++++----------------
 diff-lib.c                  |  4 +--
 diff.c                      |  2 +-
 dir.c                       | 27 +++++++++-------
 dir.h                       | 16 ++++++----
 entry.c                     | 10 +++---
 ll-merge.c                  |  4 +--
 merge-recursive.c           |  4 +--
 pathspec.c                  |  2 +-
 preload-index.c             |  3 +-
 read-cache.c                | 19 +++++++-----
 rerere.c                    |  2 +-
 resolve-undo.c              |  5 +--
 revision.c                  |  2 +-
 sha1-file.c                 |  4 +--
 submodule.c                 |  8 ++---
 unpack-trees.c              | 57 +++++++++++++++++++++-------------
 unpack-trees.h              |  4 +--
 userdiff.c                  |  2 +-
 ws.c                        |  2 +-
 wt-status.c                 |  6 ++--
 42 files changed, 255 insertions(+), 194 deletions(-)

-- 
2.18.0.rc0.333.g22e6ee6cdf

