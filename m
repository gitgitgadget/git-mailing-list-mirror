Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E109920323
	for <e@80x24.org>; Thu, 23 Mar 2017 00:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbdCWAnh (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 20:43:37 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35788 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbdCWAng (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 20:43:36 -0400
Received: by mail-pg0-f54.google.com with SMTP id t143so48712095pgb.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 17:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=znzk8P8WJe6s4stLz4/1tTkJIIqbnvKBiC2RmVQqhCI=;
        b=KDbka5diGj/9PrTggrm+j4TDXkvuI+w2HeS1yezwdiXNFpYaNJ+Xse/fYtP6Dtje+3
         gBDBRKTFKl2unB74omPj7Ekvf0JPa0mJNOvrXLfqI9lkO13Bdkr1ccQOzaX0ykCwExd8
         rYm/4Ab3+dOWMx4w/qYQ5aLuTGmZJwlCwBofgk9WZhTpyWn9sE4dEOZfWj0zEIUbFyxw
         TxqTwvofO3oyFUfDYYlcOYVXI/aYJlPMVb9A/zk2URGP3otKKQ3V65SbXJiKnH2v8LCy
         8sx7A7Y71OZ7fwOkkMVhhZA//ntxbmyx4+tn9OXUrOJrIJ9zlY4D8kXolxYGdomXNNPn
         uALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=znzk8P8WJe6s4stLz4/1tTkJIIqbnvKBiC2RmVQqhCI=;
        b=Tl6FUmLMhLvmgyccVZcfS2OZvlqho3J4ymKkc2ptH42QUkNzZmoECVVrWTtSNhBLEJ
         a98tcZ4TxhO71VW6fIfKpTglqWAnuhMPUn/UjPcXWRvdMAkFkqTPF9YxA2WNUNjekrEH
         TVgma0jOMOlLOvjAgdUQg2bJ4SQpeMy+SD/HoFuSFWFGIY+yxIUIdQi1FenI6Ta66tgu
         KXHghnwXI+RSP0QNNKAfmI9J8qgtXiuln2f0wlASqJgOSpbbBuLEiyquptx7FeDH2y2p
         BcwAwyNQS3NPUcA3ftHaDP0mAFEbodez28hXdCETXaOSGRY2OBwekuDDjCBdHgW8Qb9m
         Amxw==
X-Gm-Message-State: AFeK/H1U4JsDygtKlNZJxYa/s+iCgEUCINwhrnzkcJqDTLgY6xxXsBab+jHUmVo4GA+kHm3S
X-Received: by 10.84.245.2 with SMTP id i2mr17586919pll.131.1490229814822;
        Wed, 22 Mar 2017 17:43:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1959:c634:6437:385])
        by smtp.gmail.com with ESMTPSA id r89sm6102628pfe.6.2017.03.22.17.43.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 17:43:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/3] short status: improve reporting for submodule changes
Date:   Wed, 22 Mar 2017 17:43:26 -0700
Message-Id: <20170323004329.15892-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.432.gfe308fe33c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This comes as a series; first I'd like to refactor is_submodule_modified
to take advantage of the new porcelain=2 plumbing switch to check for changes
in the submodule.

On top of the refactoring comes the actual change, which moved the
rewriting of the submodule change indicator letter to the collection part.

Thanks,
Stefan


Stefan Beller (3):
  submodule.c: port is_submodule_modified to use porcelain 2
  submodule.c, is_submodule_modified: stricter checking for submodules
  short status: improve reporting for submodule changes

 Documentation/git-status.txt |  9 +++++++
 submodule.c                  | 58 +++++++++++++++++++++-----------------------
 t/t3600-rm.sh                | 18 ++++++++++----
 t/t7506-status-submodule.sh  | 24 ++++++++++++++++++
 wt-status.c                  | 13 ++++++++--
 5 files changed, 84 insertions(+), 38 deletions(-)

-- 
2.12.1.432.gfe308fe33c.dirty

