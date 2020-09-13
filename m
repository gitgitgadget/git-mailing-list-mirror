Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3782C43461
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 19:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B12F208C7
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 19:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtmxVeku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgIMTbz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 15:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgIMTby (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 15:31:54 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4E9C06174A
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 12:31:53 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id q63so14176019qkf.3
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 12:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L45XFV/AwRHfMqpUtUDWW4HRQvQwtj1s4HgBu6frjXc=;
        b=QtmxVekuc7MLiNdiDgEC6ORHBoa3biXtmG4XLF03f7kH0VjW8M4SB4LUsWab4nz3XG
         K6fyAraGSXcchbzdF+KsNnwRLi2TwtM9+tsNCfQ2l6ZmnArsJJddlh0WI0yARNNNw8Ub
         EARX6Q8yjfvB1a0vluxZZHj9dcncVKF2kl0EuQHF0xVWyWGgvVNW3pUgwAl9CqzNUGi3
         Lu66FyPn1VdLoMwEbZDytZK8OTIwqRJQaDRRtYpbms+nEvWn92DKI2y8SB2XJshVaFXx
         LMcMo21Z4dvmL+iY5ZbbEM+83W5AiuGz0iP6kfwTgmbbQwHvFTGRrAOoeuW6veEBo+Hd
         WRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L45XFV/AwRHfMqpUtUDWW4HRQvQwtj1s4HgBu6frjXc=;
        b=WH/b1tbgJYTBBnYxRWXJi4aTd8hsp3wsjh1dMUhupRL9Ni1RA8sv8IUbIai4wp+VFp
         N4PU40jR/vNDYZVB6KjjVAwi9blRJGyfK3OeCgiDjLIXzaMHiPHRk1M1OWnHeJOr7u+y
         4pkAgYWC57vlQIhYjunAvfNgrlmU6UqlRG2cL5Ij3fdhtWMvbBnSuYIUaQyYU7K4qiec
         i3Dbt5IbvB6rkC+Ym+/7cCAqts+aaCcEYAAiEcpaatEO1cq+LgQTPRl50jMO8nrGKXNb
         sYWD7ftZbS1lAr34xa+o9VTjCtO4AeZ5Me6r/fYYxS+tIAWceTtbttK3XP/TpPV0HuSL
         uKlg==
X-Gm-Message-State: AOAM530jQOWbyhKuGhBfqA1W9yaoTHl/uO7DK8dT6js88KDGttcb1Ugv
        N2bL8EoKkDmmUfIfXhoElkvhr2GkT2kwNCez
X-Google-Smtp-Source: ABdhPJwcp9zrFG7ieZsYCMbra3hV6bPw3oJPPYeitw0IIqsSwTPdxTbsvAzE4vMVP05MbmwZzynMxQ==
X-Received: by 2002:a37:2f42:: with SMTP id v63mr9382216qkh.261.1600025508139;
        Sun, 13 Sep 2020 12:31:48 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id e13sm11523924qtr.85.2020.09.13.12.31.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Sep 2020 12:31:47 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/3] git branch: allow combining merged and no-merged filters
Date:   Sun, 13 Sep 2020 15:31:37 -0400
Message-Id: <20200913193140.66906-1-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200911185754.64173-3-alipman88@gmail.com>
References: <20200911185754.64173-3-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It is a bit sad that this only removes from documentation without
> adding (the removal is because merged and no-merged are no longer
> mutually exclusive)...
>
> Perhaps --contains side can already be combined so they have
> description we can borrow here?  I didn't look too carefully.

Sounds good, I've added documentation covering both multiple contains/
no-contains and merged/no-merged filters to the notes sections of the
doc files for branch, for-each-ref & tag. (There was no existing
documentation for --contains, so I added that in commit 2/3.)

> We do not allow decl-after-statement.

Got it, fixed both locations.

> I would have expected, instead of placing the
> single object to the pending queue, the loop places all the filter
> objects in a queue, and then makes a limited revision walk just
> once.  In general, each time after the code makes a call to
> prepare_revision_walk() to perform a revision walk, before doing so
> again, the object flags used for the walking must be cleared.

Thanks for the explanation - updated accordingly. I'll plan on
studying that code as part of better familiarizing myself with
git's codebase.

Aaron Lipman (3):
  t3201: test multiple branch filter combinations
  Doc: cover multiple contains/no-contains filters
  ref-filter: allow merged and no-merged filters

 Documentation/git-branch.txt       | 17 +++++---
 Documentation/git-for-each-ref.txt | 20 ++++++---
 Documentation/git-tag.txt          | 17 ++++++--
 builtin/branch.c                   |  6 +--
 builtin/for-each-ref.c             |  2 +-
 builtin/tag.c                      |  8 ++--
 ref-filter.c                       | 64 ++++++++++++++-------------
 ref-filter.h                       |  9 +---
 t/t3200-branch.sh                  |  4 +-
 t/t3201-branch-contains.sh         | 69 ++++++++++++++++++++++++++++--
 t/t6302-for-each-ref-filter.sh     |  4 +-
 t/t7004-tag.sh                     |  2 +-
 12 files changed, 157 insertions(+), 65 deletions(-)

-- 
2.24.3 (Apple Git-128)

