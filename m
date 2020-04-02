Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB8FC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 19:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324EB206F8
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 19:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFNLkVcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389403AbgDBTT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:19:28 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:47213 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732006AbgDBTT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 15:19:28 -0400
Received: by mail-pl1-f201.google.com with SMTP id l1so3403079pld.14
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 12:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hP1nI4Cz+8ntRi1wc1nEgdKY9Pcqe2TAAa9bEvSF3ak=;
        b=PFNLkVcqJEmfqoaMCI7aTdVxPIzGpDjOSx2J0pTQ67em2dpA0ma/CO3WVZOSKTssZk
         9CxiSK489pSm3tv4VwJg2bvus/phzs+g2oLs7ZiR7I0lDtEswMl3hPyDArLGfOpxlQTO
         vzXaHHM9S3BtnHpEWghQ0x9j4ScbOqaphEmCZQAhC9U0NaFHYkG3Q3zd+faCKAqVDOWs
         NcxiQGc0DTCZqDsIFFULmD8vkgv+vrCbuCQ6/Y9zRZMVmNjThcVqHsreRJpsaNhNnEJD
         6gnJKVogLBO9hvua0GQ4PiZK62TzI2DhuaZv2NwkgRsiiLs/JLo+YrY7IFeydKBy2cLo
         Xv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hP1nI4Cz+8ntRi1wc1nEgdKY9Pcqe2TAAa9bEvSF3ak=;
        b=Ph1RW8d1kIiFaRFxEiRkl6IOBWLBnjERHTBhfGuEZm2bylmLp3uiJswy1laTSjtVjR
         xbpfz7Bfq6ES6kx/neB3dlNTWH+OyRDrJuyOCMxrYeCG7p/QVAPp79dPtu1HRfB4sKV5
         gnU47j4gYhCsvTZpH7fpWvd1B6ajTlUXX82EviQ2W4dGeaaxO3L45SzS1a4/oyg81+ph
         9+49WqlCaPIuwpT3mRxMOv9XluOf9cQWtfzav2RV94wjkW9OuMWn/Cdr1LOWBoggQ3MQ
         +GHHFyLNaora/PkKT25qgZlv2+RIgvRcB8OcHmrSkkuwet36bPnZItZUi9g1+trOS1Rp
         8HBQ==
X-Gm-Message-State: AGi0PuaHgQQqpCvy7ngQewnO7xlIuyJUjGkDBzrC9afTepvLR54p++wt
        rBxUY3IkhbjSLyjHqvPYgA6DXVJDI2xWqC4Wzm+Y7lDrXKIbcs6PIGDfqcU/HisROIDdoFkLfyQ
        QRniUdMqBVvwf30z8vV9ZWQk4CXkTQGaKI2tksXqoiIQGVG4ATfUnkpQeOX1h5xu6m8koh119hA
        qj
X-Google-Smtp-Source: APiQypJNMtsEEqdo/I2zlmQCgvNwAtVURgv6CpcZSvRxliqu7BBX8CcQNHsoOgP6lmRYPP2Smgbo7dZdUoeVCtEHgUid
X-Received: by 2002:a65:5647:: with SMTP id m7mr4567402pgs.371.1585855164807;
 Thu, 02 Apr 2020 12:19:24 -0700 (PDT)
Date:   Thu,  2 Apr 2020 12:19:15 -0700
In-Reply-To: <20200331020418.55640-1-jonathantanmy@google.com>
Message-Id: <cover.1585854639.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200331020418.55640-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v2 0/2] Restrict when prefetcing occurs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, everyone, for your review.

New in v2:
 - added restriction on fetching rename_src's blob, following Stolee's
   comment
 - folded oid_nr==0 check into promisor_remote_get_direct(), following
   Stolee's comment
 - used "mv server/b server/c", following Stolee's comment
 - made diff_add_if_missing() public function, following Junio's comment

I didn't change the "continue" part that Stolee suggested [1].

[1] https://lore.kernel.org/git/xmqqlfng75cl.fsf@gitster.c.googlers.com/

Jonathan Tan (2):
  promisor-remote: accept 0 as oid_nr in function
  diff: restrict when prefetching occurs

 builtin/index-pack.c          |  5 ++--
 diff.c                        | 49 +++++++++++++++++++++++------------
 diffcore-rename.c             | 37 +++++++++++++++++++++++++-
 diffcore.h                    | 10 ++++++-
 promisor-remote.c             |  3 +++
 promisor-remote.h             |  8 ++++++
 t/t4067-diff-partial-clone.sh | 48 ++++++++++++++++++++++++++++++++++
 unpack-trees.c                |  5 ++--
 8 files changed, 141 insertions(+), 24 deletions(-)

-- 
2.26.0.292.g33ef6b2f38-goog

