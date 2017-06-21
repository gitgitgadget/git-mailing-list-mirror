Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21A6620282
	for <e@80x24.org>; Wed, 21 Jun 2017 02:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbdFUCaK (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 22:30:10 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35287 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753055AbdFUCaI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 22:30:08 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so24911680pgc.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 19:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=twqWAfSwqmuBSmQDbEuv5prcuN1/mV9GumrmvzDaX/c=;
        b=frjEymH6wIAcW1DEHDeY2vTDeKlXTplvsV7NYDkPeL37d/GWAnyKJaXno7bzeY/erH
         fNClYJenL5clm/ptsF2d6ntXpYmecqxkuKJUO5G60MDehP+R3Z0s0n6+ICiysMDx3qfG
         VTlxHo7DqyBG24IvjCKd+od308ikZU11cynB6eF8WpXKA2V0PBX3ZvcghDPScUfkM8VQ
         ce67zamM+Z79jBfiJbGdGSFv+foIPDSv2f31Zup5Ljf+OrOfctbsoX48uXn+zfQVJrW+
         gXykStIxQF8FWw+pWQklrr0+qATchhj11vOhZM7oB3RXcGU18OPOMpA5t2o88tFaZrTx
         0Uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=twqWAfSwqmuBSmQDbEuv5prcuN1/mV9GumrmvzDaX/c=;
        b=tHBR9nZRX4iryEGBxd7M6IabOjeFmyCZtJ+IjStU43b/GSGmf5oUHyQpZpyZrr6CDY
         gol20NFFQ2BobOyraLrSc1UEF68fa8t01aMWyzNPmJqgMB+UG0K6IQHcr9nCQSFivtDb
         fMMas6fjVgd2AAlmM6JN8tgK5f9aa4dhCnb3K6p9yn/T2H2Rto9OA0Q77i9ZVoldcphw
         NvEwz+f//zmGjiyMxNgwoQH99zJeExEuDwrh6KhSKZaVTo38JkaxY/mVS4TiTsPD/HBN
         veOaAZTmCd+SHH3Q7epz0Y73AneU0p0967pjXbjGvvQEVmzUgNVFra0DJU0xPi0xUO0c
         fxQA==
X-Gm-Message-State: AKS2vOx8RaV8VpUZRtrv+B3k8WUeleNMPqOFdu2Hep7p50CW/XIA4TJz
        YWqe+NpIN8vjfQ==
X-Received: by 10.84.213.129 with SMTP id g1mr39249262pli.202.1498012207901;
        Tue, 20 Jun 2017 19:30:07 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:14d3:6dca:1831:2943])
        by smtp.gmail.com with ESMTPSA id 66sm29438788pfm.82.2017.06.20.19.30.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 19:30:06 -0700 (PDT)
Date:   Tue, 20 Jun 2017 19:30:04 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 11/20] path: construct correct path to a worktree's
 index
Message-ID: <20170621023004.GD60603@aiede.mtv.corp.google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
 <20170620191951.84791-12-bmwill@google.com>
 <20170621021024.GC60603@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170621021024.GC60603@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subject: worktree_git_path() should not use file relocation

git_path is a convenience function that usually produces a string
$GIT_DIR/<path>.  Since v2.5.0-rc0~143^2~35 (git_path(): be aware of
file relocation in $GIT_DIR, 2014-11-30), as a side benefit callers
get support for path relocation variables like $GIT_OBJECT_DIRECTORY:

- git_path("index") is $GIT_INDEX_FILE when set
- git_path("info/grafts") is $GIT_GRAFTS_FILE when set
- git_path("objects/<foo>") is $GIT_OBJECT_DIRECTORY/<foo> when set
- git_path("hooks/<foo>") is <foo> under core.hookspath when set
- git_path("refs/<foo>") etc (see path.c::common_list) is relative
  to $GIT_COMMON_DIR instead of $GIT_DIR

worktree_git_path, by comparison, is designed to resolve files in a
specific worktree's git dir.  Unfortunately, it shares code with
git_path and performs the same relocation.  The result is that paths
that are meant to be relative to the specified worktree's git dir end
up replaced by paths from environment variables within the current git
dir.

Luckily, no current callers pass such arguments.  The relocation was
noticed when testing the result of merging two patches under review,
one of which introduces a caller:

* The first patch made git prune check the index file in each
  worktree's git dir (using worktree_git_path(wt, "index")) for
  objects not to prune.  This would trigger the unwanted relocation
  when GIT_INDEX_FILE is set, causing objects reachable from the
  index to be pruned.

* The second patch simplified the relocation logic for index,
  info/grafts, objects, and hooks to happen unconditionally instead of
  based on whether environment or configuration variables are set.
  This caused the relocation to trigger even when GIT_INDEX_FILE is
  not set.

[jn: rewrote commit message; skipping all relocation instead of just
 GIT_INDEX_FILE]

Signed-off-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:

> How about the following?  I found it a little easier to understand.
>
> -- >8 --
> From: Brandon Williams <bmwill@google.com>
> Subject: worktree_git_path: do not let GIT_INDEX_FILE override path to index
[...]
> Change-Id: I2ba0a48a48b7e9a9c2e3ef97648cf53cb913bdd9

Gah, sorry about the stray Change-Id line.  While we're fixing that,
here's a version with a slightly clearer commit message.

 path.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/path.c b/path.c
index c1cb1cf62..4c3a27a8e 100644
--- a/path.c
+++ b/path.c
@@ -397,7 +397,8 @@ static void do_git_path(const struct worktree *wt, struct strbuf *buf,
 		strbuf_addch(buf, '/');
 	gitdir_len = buf->len;
 	strbuf_vaddf(buf, fmt, args);
-	adjust_git_path(buf, gitdir_len);
+	if (!wt)
+		adjust_git_path(buf, gitdir_len);
 	strbuf_cleanup_path(buf);
 }
 
-- 
2.13.1.611.g7e3b11ae1-goog

