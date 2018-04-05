Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9A881F404
	for <e@80x24.org>; Thu,  5 Apr 2018 02:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeDEC2X (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 22:28:23 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45639 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752692AbeDEC2W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 22:28:22 -0400
Received: by mail-pl0-f67.google.com with SMTP id v18-v6so15042799ply.12
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 19:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=hHrrGspn793553M8P3Gl8btH4wrrIdf//YuGeYtXscc=;
        b=1bpFCrS46K7s2KhNXqiOv/+eh5xFlK0fktopd81WjhUOupFCvnd0VDZX2lEQeulInB
         v/ZSCLvc1YON3We7G8Nzo40EpRqBAU2eNqnKT6uCya96p7T1teG3csJ/0GrztLnD7JmR
         NiwfwAxQtgVd0S2T9flHBhY453h8Bw2XjhMRAIwGXN1x7vkOQFqKWCPKr3H6NlLlIlVb
         YnrAh77Q3Syh94SE7MaQXwrYZUg6V/5vpt+jN641OwzlPekHivp2gYUM8XOdpD5HInjs
         e4LPXKPx4Nqk/KzmN2HcAjSHKEcgDn1yAdNjsTB4qx5LnmwXD4qLuXKrraXWZPLLNfhW
         ghdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hHrrGspn793553M8P3Gl8btH4wrrIdf//YuGeYtXscc=;
        b=LVj1H0jWo6FQk2VurRnm9DL9e3pi48oMskggaiVQ3CBJScCD5UGESe+vNleKz1bglk
         UJzPB9wigfecqHzQAo7WOrlD+f/JLmZxJgfhOxTVflNv7i012IV35nq3peBq37T/dAQq
         JGS5brbflYpGZ9RMOUvo/JnfZ21RJ7xrQRzVuEBFrsfUVdCCANY7dRC3gxYe/95En3jq
         vWc+Or587wHENbSQvhDjiQaRdTLahO91D9/g1/LTjT0BZc1jbEU8PUZjfEjkGoJQU/7B
         jqg/PXdsv88C363RuiEIUH3wfVSYpcIMShpBEeinZLyozbv9JhgWlu5GkRvWKY01wKqo
         Nqdg==
X-Gm-Message-State: AElRT7HoThN7SAiSBFo904/dYY//TbyDkF2J90wXJFalvrLN2KY1P+Lv
        zKWcE00Z2nGJnGIbWXDKYQlYzfI=
X-Google-Smtp-Source: AIpwx4+ib4nvW1i0I2dbw2u+g55czKSQOwMOlAnb73gqa0rW7ttin7c4GNBk5n+fpehpxi2092xGiQ==
X-Received: by 10.101.102.3 with SMTP id w3mr13189140pgv.200.1522895301310;
        Wed, 04 Apr 2018 19:28:21 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id 86sm14194093pfh.93.2018.04.04.19.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 19:28:20 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitster@pobox.com
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v5 0/5] Convert some stash functionality to a builtin
Date:   Wed,  4 Apr 2018 19:28:05 -0700
Message-Id: <20180405022810.15796-1-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been working on converting all of git stash to be a
builtin, however it's hard to get it all working at once with
limited time, so I've moved around half of it to a new
stash--helper builtin and called these functions from the shell
script. Once this is stabalized, it should be easier to convert
the rest of the commands one at a time without breaking
anything.

I've sent most of this code before, but that was targetting a
full replacement of stash. The code is overall the same, but
with some code review changes and updates for internal api
changes.

Since there seems to be interest from GSOC students who want to
work on converting builtins, I figured I should finish what I
have that works now so they could build on top of it.

The code is based on next as write_cache_as_tree was changed to
take an object ID. It can easily be rebase on master by changing
the two calls to write_cache_as_tree to use tha hash.

Previous threads:
v1: https://public-inbox.org/git/20180325173916.GE10909@hank/T/
v2: https://public-inbox.org/git/20180326011426.19159-1-joel@teichroeb.net/
v3: https://public-inbox.org/git/20180327054432.26419-1-joel@teichroeb.net/
v4: https://public-inbox.org/git/20180328222129.22192-1-joel@teichroeb.net/

Changes from v4:
 - Fixed a typo (Thanks Eric)
 - Redid my test again with input from Junio
 - Cleaned up usages of get_oid (Thanks Junio)
 - Slightly reduced calls to builtin functions (rerere, rev-parse)
 - Added comments clarifying why when forking/cmd_* is used

Joel Teichroeb (5):
  stash: improve option parsing test coverage
  stash: convert apply to builtin
  stash: convert drop and clear to builtin
  stash: convert branch to builtin
  stash: convert pop to builtin

 .gitignore              |   1 +
 Makefile                |   1 +
 builtin.h               |   1 +
 builtin/stash--helper.c | 630 ++++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 136 +----------
 git.c                   |   1 +
 t/t3903-stash.sh        |  35 +++
 7 files changed, 677 insertions(+), 128 deletions(-)
 create mode 100644 builtin/stash--helper.c

-- 
2.16.3

