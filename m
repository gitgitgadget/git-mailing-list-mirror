Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE509207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755468AbcIKKa2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:30:28 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35723 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755383AbcIKKa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:30:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id a6so9372578wmc.2
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 03:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P73vk8LnP6xvxNw3dm/wVWEGScJGGNp1VKld98XL8Fw=;
        b=rt7i7EJPnvktmHnCaGWw1GuzZ4iwy452/9a5x2Iz6RMyXYZlL97lAotA4rc90hxI8d
         6vfveowNXNE0uQBzYh9SYcq3JYSrfSj/qPuPniaM9C/wFrWOaKoAn/C7qiC/0oqE0jRj
         qDAJLTVnhAnLhrpDwG011ELwWzJ4Awh5vkbwmZgA1m/wIFLyKuF7W3z5wmE1KAD0D+nJ
         vxo++O2oT/XI0A/e5ePoejp5vgpODY1diXfJ8JmXBHH0oID2Q1sj6yzPuqOxz/eBXCtA
         EfLmMTqx5IgYvC+y5C02HSdP/6oXd8r02CkYXUhu02ZtTLj5K169BIIA/OcR3s0zDN4S
         016w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P73vk8LnP6xvxNw3dm/wVWEGScJGGNp1VKld98XL8Fw=;
        b=U/h2CH5SRZUTjzEgLEzGjhO6rP2OU01Cl+IVwHsznd2cvWJPdBl7wHzzBSZRVs8+Wo
         QMD8VQldq+91A5DA5wGNK7rxZYGRJvF/c0zAxN7OgahGjs+GvHeE8KiiPn3IczsuQbko
         /H/ula5ppQUZQnbhJ+GX/ShYWqYZ1kpsMERhRLTMWaHS+VaaZE98/P5MV9rw3Genb7ev
         5AS1PlVpAoMPv2arhvd9MkLUeGPCkcA9shN16A1SVd3DhPkmax/3Kq/MjNYht5fgZmJZ
         BQnHf/jA68Z0ziF8LCt1bn5rg7U7cr6vfxUQQK2/F0jcF2rIhKNmQiq3MvsVjIJv697B
         BuzA==
X-Gm-Message-State: AE9vXwPtmkFTWwH1vC2impKw4xDDjjHBS7EfszQZtj3cM0RxIcPPyAvVbqzZ6I5DeHUJTQ==
X-Received: by 10.194.44.69 with SMTP id c5mr10390158wjm.80.1473589826002;
        Sun, 11 Sep 2016 03:30:26 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id kq2sm12291916wjc.41.2016.09.11.03.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Sep 2016 03:30:24 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        =?UTF-8?q?Ingo=20Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 0/4] git add --chmod: always change the file
Date:   Sun, 11 Sep 2016 11:30:24 +0100
Message-Id: <20160911103028.5492-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484
In-Reply-To: <20160904113954.21697-1-t.gummerer@gmail.com>
References: <20160904113954.21697-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:
Added missing x in the documentation.

The changes since v1 are only minor, but as it's been a week, this is
as much a ping as a fixup of my error :)

Thomas Gummerer (4):
  add: document the chmod option
  update-index: use the same structure for chmod as add
  read-cache: introduce chmod_index_entry
  add: modify already added files when --chmod is given

 Documentation/git-add.txt |  7 +++++-
 builtin/add.c             | 36 +++++++++++++++++++++----------
 builtin/checkout.c        |  2 +-
 builtin/commit.c          |  2 +-
 builtin/update-index.c    | 55 ++++++++++++++++++-----------------------------
 cache.h                   | 12 ++++++-----
 read-cache.c              | 33 +++++++++++++++++++++-------
 t/t3700-add.sh            | 21 ++++++++++++++++++
 8 files changed, 107 insertions(+), 61 deletions(-)

-- 
2.10.0.304.gf2ff484

