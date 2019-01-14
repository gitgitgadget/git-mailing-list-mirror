Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F20A5211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 18:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfANSfG (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 13:35:06 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:43543 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfANSfG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 13:35:06 -0500
Received: by mail-lj1-f181.google.com with SMTP id q2-v6so19938732lji.10
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 10:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ThZ2xf4Jvn5mRNLtoPGAbGqtffF15xQkMM+sZ1afJAE=;
        b=lkkVAwrYBBq/kLacyZQL0jocLNXw8F60rpsVVAz/l0hPRgJPgjmj6iYfIyGPdrRrNB
         y/grbXkOvC74UQQxo8Z4cvgXS6j3XPSt1wduE74snZWTU5SDAXAYrO5L717ilEqpZVNJ
         xbdMAM8NuTYlqUFmUy2T3++BIR6kuJlvcJJkIbDn6qNLxYbmVy4Pdr2c8OWQcAt7doUf
         yJ4i/Bu4OG0dmohqVvG1d+Ehlml+S87Tcofc2vNgMGNJU/hliYleQJ7zAXEtH1RUd1SQ
         hCNCv66jZuQcljK+yUcYljKOAJsn8sM92WmxMQ5ndFKzQWXUlpJVDubu/v7d+fMXUvuL
         Kvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThZ2xf4Jvn5mRNLtoPGAbGqtffF15xQkMM+sZ1afJAE=;
        b=VlWT0uOk1RcBKW3sTr5bmDRRe4UwMtEgNy//iWaOYHyqokVvNVpYcH9yZHp25ccxMX
         00+1MXBn6Es7nXUPCeiUcC56RNPCLAhueTsyNUxz3bCUA0CsL3bZI58aRmEJ+IEN8XPK
         oM9rl+jyHjUBwgYT6zusGep7prw5m+JBloYUTomYUcEp1ntiWq/vEhudd6bGiChLvpMh
         kgjSOi+5PIHAk73NeUvYJk5x1an26rKLlEo0HYz3CIcGGo4QhSbLntOt3bdLKYZ9J+0C
         0IKD5lyEKIrTWh1vfEU6St6udX9Xb1QJJg9WA21F83UXhVIIv6pFyyj+w3INFBF+IoVF
         XdFQ==
X-Gm-Message-State: AJcUukcJ4HP6RnyuyTObO9B6/ortgzDHMcp4/GTWCf8DI7PxrK8eiOVo
        TNIzZ1SxKX4kajEqOaGOorm4dTe9
X-Google-Smtp-Source: ALg8bN4p6HyGWYiGBAQla3iz5g/P8+WebmVgmA+kXHH2qUsOskTokDw4jjq+k+Gbmup0iue7pu1NWg==
X-Received: by 2002:a2e:8045:: with SMTP id p5-v6mr14982061ljg.87.1547490904421;
        Mon, 14 Jan 2019 10:35:04 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id x24-v6sm224492ljc.54.2019.01.14.10.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 10:35:03 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 0/3] setup: add `clear_repository_format()`
Date:   Mon, 14 Jan 2019 19:34:54 +0100
Message-Id: <cover.1547488709.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218072528.3870492-1-martin.agren@gmail.com>
References: <20181218072528.3870492-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series addresses memory leaks related to `struct
repository_format`. Compared to v1 [1], this v2 has dropped the first
patch ("setup: drop return value from `read_repository_format()`") and
added another patch 1/3 (which solves a different problem).

Patch 2/3 is unchanged. Patch 3/3 now calls `clear_...()` not only in
the error paths, but in all paths, as suggested in the review of v1.

Thanks to Peff and brian for reviewing v1.

There's a minor textual conflict with ed/simplify-setup-git-dir. A merge
of these two topics still passes the test suite (and these leaks remain
plugged).

[1] https://public-inbox.org/git/20181218072528.3870492-1-martin.agren@gmail.com/#t

Martin Ågren (3):
  setup: free old value before setting `work_tree`
  setup: do not use invalid `repository_format`
  setup: add `clear_repository_format()`

 cache.h           | 12 ++++++++++++
 builtin/init-db.c |  3 ++-
 repository.c      |  3 ++-
 setup.c           | 33 ++++++++++++++++++++++++---------
 worktree.c        |  4 +++-
 5 files changed, 43 insertions(+), 12 deletions(-)

-- 
2.20.1

