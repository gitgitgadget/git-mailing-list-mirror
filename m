Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 053B12021E
	for <e@80x24.org>; Mon, 31 Oct 2016 22:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S945607AbcJaWip (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 18:38:45 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34357 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S945572AbcJaWip (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 18:38:45 -0400
Received: by mail-pf0-f169.google.com with SMTP id n85so83406298pfi.1
        for <git@vger.kernel.org>; Mon, 31 Oct 2016 15:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AGhGZMqGQlg0slMdmcQP5fjOIYTRebbJFrlu5E6gA7M=;
        b=JaNqixjCaeHGHM7IuLz7RRNozj5tDwzIPSoxJxf4/mgGNdYxvrarlf0rzLApb4P6Db
         yJqFgutu4KxksGDQNtvrzezut4EDzw/+WDWEizyYElDj4PhQojnqp0VSggYJmRt0UN6n
         9laGnvkxI3w2fr24TacB70m6CV0EzoEFF6+uYU1GsJ4KgunCNiG0XmDA/VO2hcppuz8s
         oG9Oa6Y8SZn45ZugQGyAzfve+Z2W3+E4UxQAK1d8egAlvgg3Rq13mQ3XjYRukAPyJa1q
         lMudHH9tPruR78FFLdMB0clMj3A/rzrXLnV437r63PkiMkBuKsPSZqHBs0mtr+Ut1i0R
         uK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AGhGZMqGQlg0slMdmcQP5fjOIYTRebbJFrlu5E6gA7M=;
        b=cBsYHyLsoHuH0pQnwZMi1dYK20KVj0b1pelfJcT+z97FVT2hqouawvNM+0Jo25eEFO
         5Wl8ydOAZsAWiHu5Glri5wE3y6su8EKTXKfXqjGjc0NU0XKBg9j2kcY/L0n7qI41YXgA
         DmZSoVV6BngITUh8Lk5tU6S1cAYF7ul6ZmWpkCulMlO3y+VqYdnSTzbn2IYOcHCesKiG
         VgFzBq/DBFbw9fKUr/RwIwq952QGzrlm35NfuXJVBBUUfkLOICIT9XjQx4+IAxAjQqQJ
         XlppzDlUYkEZTecMoMFlT8m1quvrlayi2zbTk25hW8LRPzxwEVCrrOYtmhS8IBVw0RQA
         ir5Q==
X-Gm-Message-State: ABUngvddy/weWFHGM1MUV1kuXYWtZy0XlYq7dthpV5Kh0dMRvoKwHtVk2ZXryPAV9X3X/bB/
X-Received: by 10.98.153.204 with SMTP id t73mr52991197pfk.144.1477953524156;
        Mon, 31 Oct 2016 15:38:44 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id uh10sm37847280pab.5.2016.10.31.15.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Oct 2016 15:38:43 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, sbeller@google.com
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 0/6] recursively grep across submodules
Date:   Mon, 31 Oct 2016 15:38:10 -0700
Message-Id: <1477953496-103596-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <20161027223834.35312-1-bmwill@google.com>
References: <20161027223834.35312-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few minor style issues have been taken care of from v1 of this series.  I
also added an additional patch to enable grep to function on history where the
submodule has been moved.

I also changed how tree grep performs pathspec checking against submodule
entries in order to fix a test that was breaking with v1 of the series.

Brandon Williams (6):
  submodules: add helper functions to determine presence of submodules
  submodules: load gitmodules file from commit sha1
  grep: add submodules as a grep source type
  grep: optionally recurse into submodules
  grep: enable recurse-submodules to work on <tree> objects
  grep: search history of moved submodules

 Documentation/git-grep.txt         |  14 ++
 builtin/grep.c                     | 387 ++++++++++++++++++++++++++++++++++---
 cache.h                            |   2 +
 config.c                           |   8 +-
 git.c                              |   2 +-
 grep.c                             |  16 +-
 grep.h                             |   1 +
 submodule-config.c                 |   6 +-
 submodule-config.h                 |   3 +
 submodule.c                        |  51 +++++
 submodule.h                        |   3 +
 t/t7814-grep-recurse-submodules.sh | 182 +++++++++++++++++
 12 files changed, 643 insertions(+), 32 deletions(-)
 create mode 100755 t/t7814-grep-recurse-submodules.sh

-- 
2.8.0.rc3.226.g39d4020

