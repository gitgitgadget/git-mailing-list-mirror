Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B35AD2082E
	for <e@80x24.org>; Fri, 23 Jun 2017 19:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754775AbdFWTNN (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 15:13:13 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34319 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754327AbdFWTNM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 15:13:12 -0400
Received: by mail-pf0-f179.google.com with SMTP id s66so27375800pfs.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 12:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=INnykvMxPgwE18TxzVU990dCxlY3D+B1Yfe4sOlxaRU=;
        b=Iv31EnciABsiFwgzNI8XJ2go9J1dKy7osH1nHrZdY5ycJ9gHipAn3wroJdBHZhlAkP
         IBr+Wi3OhpZwme51LBeTMATKSFQwTqE6+dXqaVcVUeMR/piBuyKkhUjki7GSLOMQwtn3
         pbqEHboQVV2YDHyg0uf95/sOBoTtas5rmLhvBdXRtWnOaVv74WL8etXx+PjDA4PSPRX3
         d+Q7wGKq3AOp+9ojwlNMVCjcDGm3USm1YjqoKtMZHJv6OQa672IlwNSCTj5h13Yl+inF
         2P4TDbawiGNHwc9YWWwIdqqtfVIxSr2SL7htDA/Ru31hBzEN1vY8dfBYwPh1ka2Fu7Dg
         rF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=INnykvMxPgwE18TxzVU990dCxlY3D+B1Yfe4sOlxaRU=;
        b=DQTR12LAMwYT+lUBQIHmJGWDgXObQgkjoKJThqj8lvRcWxVrQDVCx+HiFAcSMf6PTj
         I1CR3HQpWeIbQG2q5a9AhMWp9vr2HSuLMAHKPjqIsRyDZXy1zV9O7zDtcj9UYMbkfJMi
         J+se+1yZlTnaepvNzNW/LyAHhrMKVxe3VU8LSi7P7oM87PQP//9jK+LiEU/fQIY1JwCf
         huhArBNz0NQhyvGFLz8eTiSHOcidQVp6QYCEMCZe5yKlvkv5XHRPyGNNU0EBbo/qvIf5
         OqUmXmnOyH33B2kBtVBirUtYIV0EBHCQXYWVQSGu+U1lvY/D+eSOvslxHGhPAv294ZYH
         hmrg==
X-Gm-Message-State: AKS2vOxd4dMa2DlUWM7xngwuvc18nRH5CkMlD5p14PQfoVcAfLGwaYGs
        +Ri6Ot3/ZYetcssUQXGHGQ==
X-Received: by 10.84.224.200 with SMTP id k8mr10632940pln.215.1498245192004;
        Fri, 23 Jun 2017 12:13:12 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1530:f035:a8be:c887])
        by smtp.gmail.com with ESMTPSA id l3sm11002663pfk.34.2017.06.23.12.13.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 12:13:11 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        philipoakley@iee.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/3] pull: optionally rebase submodules
Date:   Fri, 23 Jun 2017 12:12:59 -0700
Message-Id: <20170623191302.16053-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This supersedes the RFC in May by Brandon
https://public-inbox.org/git/20170511172437.96878-1-bmwill@google.com/

It adds more (enough?) error checking, as explained in the last
commit message.

Documentation and issues raised in the review
of that RFC have been addressed.

The first two patches are a little refactoring needed for the last patch
that adds the functionality.

Thanks,
Stefan

Stefan Beller (3):
  builtin/fetch: factor submodule recurse parsing out to submodule
    config
  builtin/fetch: parse recurse-submodules-default at default options
    parsing
  pull: optionally rebase submodules (remote submodule changes only)

 Documentation/git-pull.txt | 12 ++++----
 builtin/fetch.c            | 37 ++++++++---------------
 builtin/pull.c             | 73 +++++++++++++++++++++++++++++++++++++++-------
 submodule-config.c         | 22 ++++++++++++++
 submodule-config.h         |  3 ++
 submodule.c                | 26 +++++++++++++++++
 submodule.h                |  4 +++
 t/t5572-pull-submodule.sh  | 58 ++++++++++++++++++++++++++++++++++++
 8 files changed, 194 insertions(+), 41 deletions(-)

-- 
2.12.2.575.gb14f27f917

