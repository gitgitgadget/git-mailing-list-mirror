Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C143020705
	for <e@80x24.org>; Thu,  8 Sep 2016 13:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756437AbcIHNrb (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 09:47:31 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34502 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756190AbcIHNra (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 09:47:30 -0400
Received: by mail-pf0-f195.google.com with SMTP id g202so2551874pfb.1
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+LPWba5t8CNf24K510COXsQvUMKoAh5+clFPNmWR8x4=;
        b=JZpgFYV3DYJz/aHD/ZQtIGne8bqeAFFsf1yVou1bsU28WFbkbgsYFE7/KIoOu4aeNO
         F/Hyasw+yY67QhQX2cxjdsOuwo2rx+5Ozi9EbKJEBUpoDVqXaSvr73Ck2/P/Bv0aXLm9
         2UTG3w7Un2UbFPmIM+0XAf4s19cpbcRENwnKnWHsRf6FfEy4G8pGCh1bHWZz8w4FONMQ
         UmZLQV55Su7AiryRQJb5DCuAwJxT/P0lxhzEwCZ2psIIUimm1df/x12G9jLJIneEovRh
         1Nq6P1bQi2wrsli8Z2prGwLHoXmYkVutwSMFcdgxElHyAab23TqgAT9LcBLhlcl/wrHK
         ulnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+LPWba5t8CNf24K510COXsQvUMKoAh5+clFPNmWR8x4=;
        b=ZgmnDl8NW8CgcKPJUSHpRnaFzsoVP0dahtzXa4gj6e+4OsVjoJmh3xacW/JyIrUO/Z
         T3gLbBortlB/kcdVjlJ4EXJYpV8KTUVV4nIS+9mgnVxz4FA2PWwGrlAVOFNMtgQHVc5H
         FqpT4Llu7SZeKiUymRsTQgkCpUsl/BNicOR5ncHeNUwD+PMi1ZVgHYllB06Jp0aGE0rq
         Ovf/VDbko8sSvdqnWX9+hwziQoOlCEDWc+n08Arz4/Hag8XubjocfRIYWZxJfJ6lw4nB
         4x+ZZ+hVovswkL1cYvq72I455y3UgsPEo8aFhT7h5YG8t7abSkGjJBLmR7/bspCy6wCA
         P4eA==
X-Gm-Message-State: AE9vXwMvhqMSi8hxnMsv6aZwH/NxO76QK2sNJ4Ev6QUVN3EODXXPO2c1h5SLBs8PE6WTMA==
X-Received: by 10.98.8.13 with SMTP id c13mr92769717pfd.166.1473342449792;
        Thu, 08 Sep 2016 06:47:29 -0700 (PDT)
Received: from ash ([27.77.242.225])
        by smtp.gmail.com with ESMTPSA id 3sm40549898pai.48.2016.09.08.06.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2016 06:47:28 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 08 Sep 2016 20:47:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     git@drmicha.warpmail.net, max.nordlund@sqore.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/3] Fix git-init in linked worktrees
Date:   Thu,  8 Sep 2016 20:47:16 +0700
Message-Id: <20160908134719.27955-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <CACsJy8CZf0O+uyQaeJ4gcx4XN8ivfFyni+3586WX_R2QM4XgVw@mail.gmail.com>
References: <CACsJy8CZf0O+uyQaeJ4gcx4XN8ivfFyni+3586WX_R2QM4XgVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My ASAP is not so ASAP. Sorry about that but I think I have fixed it.

Side note about 2/3. I've known this problem (in general) for years
(accidentally reading .git config file before .git is searched) and
could not do anything about it. And because test_expect_failure should
only be there if someone will eventually fix it, and I don't see
myself doing it, and I don't see it super important that other people
would bother, so I decided to simply sweep it under the rug. I could
make a test_expect_failure if people think otherwise.

Side note about 3/3. Yes there's a FIXME in there. It will take a lot
more time to remove that FIXME (because setup_git_directory is not as
simple). For now it should be ok to leave it there. When we find a use
for get_first_git_dir outside git-init, we can fix it then.

Nguyễn Thái Ngọc Duy (3):
  init: correct re-initialization from a linked worktree
  t0001: work around the bug that reads config file before repo setup
  init: do not set core.worktree more often than necessary

 builtin/init-db.c |  4 ++--
 cache.h           |  1 +
 environment.c     | 16 +++++++++++++++-
 t/t0001-init.sh   | 19 +++++++++++++++++++
 4 files changed, 37 insertions(+), 3 deletions(-)

-- 
2.8.2.524.g6ff3d78

