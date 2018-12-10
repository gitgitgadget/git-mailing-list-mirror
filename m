Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 496A420A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 23:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbeLJXks (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 18:40:48 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:52953 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeLJXks (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 18:40:48 -0500
Received: by mail-it1-f202.google.com with SMTP id o205so460055itc.2
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 15:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zVtG1yFSdDHBJ7DHv30T4l8aBTpCZCXPZi+z3oAaaxg=;
        b=q0urgERvll0abbEp8aNl3vcZR3wjIFL2S3yUHjznsG2DxI4lx6Hr2Xk8r1kRkdPq3d
         FTVv0z6tAlBP2ekM5LHD8KqQzZlVyU2u2k1jyKN5cIKOzC8+vMYN+2n22jdL143VYquH
         uNf3CNxsqbaV9zfDXJ6FYf4aq05zjUwEphD/GPz0aXM5+zZbWaTDNWlNeHsPLCP3638Z
         r16fmgw39VjhDJZ1iS3n3wsRhjwmbXc+JrFjHRf0JZQ/6nj8fzVBuIIlQajY4BdXTd4M
         Qv+KwD46aS4wFt+bGYjMl/zWuHHPMy8oGKRMQn55M/LFloIjF4581zdhTYTMaEitxVE1
         BJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zVtG1yFSdDHBJ7DHv30T4l8aBTpCZCXPZi+z3oAaaxg=;
        b=fR/RmM+3wwJ3UJaeQghtwLngAl3SnNbP9jBnYrOWQj6zt4bSli+d6P8fpmg0B6ZKyM
         w2iLx3mhUH3W1UdY0/q2IWsqAwgUILzv6U+qNQKV5qmAtN9Cb9IMOUrEVDb5AWWX+dLK
         8Af5O1Ij+oIfYDYA2fwdegOh19QcHXPUijWTQZeMggpjTU8D6vWm/lsBaJX8VkjecpNw
         F7oZzT/ludCsJLE+3ab39exm0V8t+8oy1+ClOiv/7GnkgmS7ISE9A6dqqMXhHLZZWFEo
         YRuT1Knfr5rfi2oweJc546XRcQYlXo+2KHpzdIcPUahBRiRyr+g7smF3AKT1IVHeJdgw
         Qqhw==
X-Gm-Message-State: AA+aEWbZraUY2GEnXReMNqxZh7YbwWRjY90ZJDn6ICCwJCL/Q1grhyqa
        hhMGHmmdWEZbOCuhv/F2r97LacExDDSTn6qHBPo50vbIuh3Z9S5fbxbMBxwvgOxqiRzsDZ2tdoA
        UM+Saq1GhNDCTmUzigWtWfclbFrgMWGRC8EeCMJzfjqLLHi1h4xU50PEl+Po=
X-Google-Smtp-Source: AFSGD/WMsqkjysF+hmamk2EJLw33o51pWHyYDpncTBt80gq7USA+AYPXZ0raEHhVdLAIIEkKVKcicXhcl2xG
X-Received: by 2002:a24:15:: with SMTP id 21mr305751ita.27.1544485247369; Mon,
 10 Dec 2018 15:40:47 -0800 (PST)
Date:   Mon, 10 Dec 2018 15:40:28 -0800
Message-Id: <20181210234030.176178-1-matvore@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH v2 0/2] support for filtering trees and blobs based on depth
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up to the original patchset at
https://public-inbox.org/git/cover.1539298957.git.matvore@google.com/ -
the purpose of that patchset and this one is to support positive integers for
tree:<depth>. Some of the prior patchset's patches were either already queued
(tree traversal optimization) or abandoned (documentation edit). This rendition
of the patchset adds a commit which optimizes away tree traversal when
collecting omits when iterating over a tree a second time.

Thanks,

Matthew DeVore (2):
  list-objects-filter: teach tree:# how to handle >0
  tree:<depth>: skip some trees even when collecting omits

 Documentation/rev-list-options.txt  |   9 ++-
 list-objects-filter-options.c       |   7 +-
 list-objects-filter-options.h       |   3 +-
 list-objects-filter.c               | 120 +++++++++++++++++++++++-----
 t/t6112-rev-list-filters-objects.sh | 115 +++++++++++++++++++++++++-
 5 files changed, 225 insertions(+), 29 deletions(-)

-- 
2.20.0.rc2.403.gdbc3b29805-goog

