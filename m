Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 634111F453
	for <e@80x24.org>; Tue, 16 Oct 2018 21:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeJQEzD (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 00:55:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40896 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQEzC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 00:55:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id g21-v6so5050429pfi.7
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 14:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=wxtyDV6t4uv+Mgr8MRPk9fGyoixiM87h1/o2nIWyM7o=;
        b=D3oaBiV1GKQg3G91rS+QnUriuflaP+tC/DFCb6LOSl7UBAdGzWornljprMurSkcPqs
         wyH2MdLjagW4wmv9Xq2NW6U9xZ0YPq6Bg2+hv0a4lJ35VffgsanmKrZ/hjJkeEexIxzm
         E9Yq8wBSQoF060YI/qG51cxUzlU7y3VlvlnqG0LETPYQk+5g03ZGY6fzP1FohvWmwzTy
         JyrOjYDdMRzJttwoYQyq0z0G4PGfm8dxYMfFOs7Z/7W1MwAcT3mXuJ0tV/+zLGLzcOE3
         w3c3ja+Ohd/XKs1pBdM6l7d2C5bF2uFGaPmoyrrhIQzYi1GNHmNH8iuFBIvMi+gkvTLi
         PZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wxtyDV6t4uv+Mgr8MRPk9fGyoixiM87h1/o2nIWyM7o=;
        b=K9Nm7E0cA0K75+C6cq6OejYx42PTyCkcvqo3JhqCK/dGqVqoHrl9dNdcCjeFyRCKqm
         ysGg/VQk945kZoIWR51dSfKPKMuR0mL3W1VusxInoMxR1g7+/ERzhF3PVYK/b+MGRil1
         wPcG/V+UYHTG0iyXccBpMkpOpUkRAC1iDhsRSQLF+WJ6XFKZtGL1JXi3xqY+53BV2Sal
         jzR5kFC6KGEgNGVJ6e8JDDnYEfVg5E3qDSOTrZxWzsu/86gCmOiDHO/gUXoATIgG9Sa7
         SbtURz/0ZGMBXG4QZBcZiG+JyQf4nT/XbmxB7MBxQd9gbihGwOEdfjd4jGEU0TOxro6N
         JBfw==
X-Gm-Message-State: ABuFfojkweMTLCWafqvDNgfLzhfEeE6+EcfG0M7wHRUoTWXYecDqqv2n
        zknPvADNRfJad6pUJbRmVr7zity/
X-Google-Smtp-Source: ACcGV620PywAXdijS6Vjh5vna2oL5R1niEGq5+3SCI+q/mVPd2zaGWwN8PUA+p0bRK1XODrRqcVN+A==
X-Received: by 2002:a63:5a0d:: with SMTP id o13-v6mr21770468pgb.267.1539723768765;
        Tue, 16 Oct 2018 14:02:48 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id x17-v6sm17103572pfn.59.2018.10.16.14.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 14:02:47 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:02:47 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Oct 2018 21:02:42 GMT
Message-Id: <pull.47.git.gitgitgadget@gmail.com>
From:   "Jameson Miller via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] Fix gc segfault
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 9ac3f0e (pack-objects: fix performance issues on packing large deltas,
2018-07-22), a mutex was introduced that is used to guard the call to set
the delta size. This commit added code to initialize it, but at an incorrect
spot: in init_threaded_search(), while the call to oe_set_delta_size() (and
hence to packing_data_lock()) can happen in the call chain check_object() <- 
get_object_details() <-prepare_pack() <- cmd_pack_objects(), which is long
before theprepare_pack() function calls ll_find_deltas() (which initializes
the threaded search).

Another tell-tale that the mutex was initialized in an incorrect spot is
that the function to initialize it lives in builtin/, while the code that
uses the mutex is defined in a libgit.a header file.

Let's use a more appropriate function: prepare_packing_data(), which not
only lives in libgit.a, but has to be called before thepacking_data struct
is used that contains that mutex.

Johannes Schindelin (3):
  Fix typo 'detla' -> 'delta'
  pack-objects (mingw): demonstrate a segmentation fault with large
    deltas
  pack-objects (mingw): initialize `packing_data` mutex in the correct
    spot

 builtin/pack-objects.c        |  1 -
 pack-objects.c                |  3 +++
 pack-objects.h                |  2 +-
 t/t5321-pack-large-objects.sh | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 2 deletions(-)
 create mode 100755 t/t5321-pack-large-objects.sh


base-commit: 5a0cc8aca797dbd7d2be3b67458ff880ed45cddf
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-47%2Fjamill%2Ffix-gc-segfault-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-47/jamill/fix-gc-segfault-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/47
-- 
gitgitgadget
