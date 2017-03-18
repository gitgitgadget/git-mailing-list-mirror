Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B31A20323
	for <e@80x24.org>; Sat, 18 Mar 2017 11:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbdCRLdx (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 07:33:53 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37710 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbdCRLdw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 07:33:52 -0400
Received: by mail-wm0-f41.google.com with SMTP id n11so33112858wma.0
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 04:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXo3JXHIeqb1wfDDQz2FBujdi8K5oRCEmwxwIwESDwQ=;
        b=Ob+c/kuVHQ3aSTbCN18ALbfNQdbLoLANA/8A13rldJL5vBbW+Ih37EIqNpr9LfRrHK
         ybDs6iv/8GT1mfkhH1eBW3m65gP0XQF7wP/pAPsUBweYtI2yWk8kc0YudfzzdZ7T3L4L
         +GPD8+WMVFGMwn+1aUlALB3CYcqh5uzKK6EtZJEV3PfJpSBSGc9PwVRQ+8ZrjlCWcq/s
         rE5EgCIhZS9aNHc5nWxnThTPXpupMi3Jgml6FXv0xMLRx5EQPpMmsbAOKi3BpzaL0/CG
         x4OW4ifiDrttpxj9ulhenGuaafpW23ANniaiQetW+1h7T7B09Ik4G2Vv8aFQT/G+OrDN
         1WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXo3JXHIeqb1wfDDQz2FBujdi8K5oRCEmwxwIwESDwQ=;
        b=h0rlGBFXZP1do+e5O7pVe+kR+Q1G751AQS2noJF6JWyYfuu0tdlNv0ZL9+AfGPrByR
         iEAlUx0K2xo/CyYk+N6myJxs3fNzoVM10b5H/pJR9BCz33upASxidm4+wvfI9ifVTxcZ
         ywVqVxEPgoKx5tBdxGLWXh1pqa0/ufJWGD2E3YYjgUb+n5pqfYyu2gk4K+8KID/7kvSH
         15gESUz3gH08Ze3cEEiBLk24m58Ahf9SrSsiZ3mtSx9K4H543zSfovhhRoE0e3fAyoaR
         dV84TThJxQjZuyZb7vEmL4zRyLH5+Y9wXy02A3wnle8b8kI0ndWaloLu5ZA2M7qcQp62
         61Ug==
X-Gm-Message-State: AFeK/H2BPSilrOS44D9sX4viZtzAB4q/zWZZ2vcyvAvH6r5waSGVFlq4s/GHlBikgP1gFw==
X-Received: by 10.28.51.140 with SMTP id z134mr2286291wmz.55.1489833190133;
        Sat, 18 Mar 2017 03:33:10 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j34sm13007928wre.7.2017.03.18.03.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Mar 2017 03:33:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/8] Various changes to the "tag" command
Date:   Sat, 18 Mar 2017 10:32:48 +0000
Message-Id: <20170318103256.27141-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series incorporates and replaces all the "tag" patches I have
floating around the list, and adds a lot in the mix which discovered
while working on the initial two patches, but which made sense as
separate patches.

It's based no top of Jeff's gitster/jk/ref-filter-flags-cleanup.

I'm bundling this all together because a lot of these patches touch
the exact same code, and in other cases subsequent patches make use of
test suite improvements I made earlier in the series. So although some
could be split out entirely (e.g. the --point-at patch), I'd like to
just present them all for review together & split out any if there's
strong objections to basing them on top of each other.

I think this series changes addresses all the points brought up by
Junio/Jeff about my previous patches, except there's no extensive
discussion of how the filtering mechanism works in general as pointed
out by Junio in <xmqqwpbvumrk.fsf@gitster.mtv.corp.google.com>.

I think it makes sense to have that, but in the interest of getting
something out the door I'm not working on that for now.

Ævar Arnfjörð Bjarmason (8):
  tag: Remove a TODO item from the test suite
  tag: Refactor the options handling code to be less bizarro
  tag: Change  misleading --list <pattern> documentation
  tag: Implicitly supply --list given another list-like option
  tag: Implicitly supply --list given the -n option
  ref-filter: Add --no-contains option to tag/branch/for-each-ref
  tag: Add tests for --with and --without
  tag: Change --point-at to default to HEAD

 Documentation/git-branch.txt           |  15 ++-
 Documentation/git-for-each-ref.txt     |   6 +-
 Documentation/git-tag.txt              |  44 ++++---
 builtin/branch.c                       |   4 +-
 builtin/for-each-ref.c                 |   3 +-
 builtin/tag.c                          |  36 ++++--
 contrib/completion/git-completion.bash |   4 +-
 parse-options.h                        |   4 +-
 ref-filter.c                           |  19 ++-
 ref-filter.h                           |   1 +
 t/t3201-branch-contains.sh             |  51 +++++++-
 t/t6302-for-each-ref-filter.sh         |  16 +++
 t/t7004-tag.sh                         | 226 +++++++++++++++++++++++++++++++--
 13 files changed, 371 insertions(+), 58 deletions(-)

-- 
2.11.0

