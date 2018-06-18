Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D749E1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 13:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933691AbeFRNTK (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 09:19:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40843 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933009AbeFRNTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 09:19:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id n5-v6so15509557wmc.5
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y9IR0i6uqIKUzKJV/HRngt6918LNfd3+tu0wTSdohFM=;
        b=QBzY7uGn3OADyhUphDaX2n4/fmJ3zOQ4IRvI3iaa08jCq2Do8YknwBaEF+9DuXbv0X
         z9h7OnYEZK19oiC5jJDYgzM/shaMKZzy/ts09CwouEO+T6LoZqxmGRkWIbnab52Jq9Qm
         cpfCOXSUI1oqCUxPhlGr9SsJKmxso/OFTKv4deMmTtwOF6AcyWszKWKjEB8AnPd6PXKL
         XpH+TRiLOs58JG7jzJHxypcAqqmvIi7mD7WuF7ERcU+1ct7UcEzRAU+NpKs6KfTfzddx
         +JESN8eJYEkoao+BHQL/6exhIZPaZQ6XFZxDoBiPRuo8pHYcnVQZEdlxgesaeKt2mg39
         mf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y9IR0i6uqIKUzKJV/HRngt6918LNfd3+tu0wTSdohFM=;
        b=kwHSzhy6VnUaWsZVOC0t1cMcT86KQWeft+yJuK5mPRA6g1O35Xj+uJZ6bywfwrQT62
         ZaLT5zUlskRdpakuW+xbvUgwM17B81h6tyW/qxtUecWwwDdDimQ/HOPAqPVjEb1XBVbr
         J+5QTEimTBfc0WGo5sQawojztcQ5Q1Km5P5CASxHPDJuNoxQtWq7R55Z7kj3WiNud5Fw
         Vc2W7iqoInaFzILkgKuARSRqivuFrP+zW08neGH1+vjZPvVJHR8ry23oKpJoLrjQ8yvI
         fDLM8kaCRFxKnkYvJs3z+dSLFMPbFJUczUkWhDogSZG+yxjNPsnQqnd4TfgXbCFJW8+I
         XPzQ==
X-Gm-Message-State: APt69E2qjaQkGFhqpfP0BYHOAqu3UgnxbyNEHbOq2HP3SSzenNV9ikSd
        jsyHK+aeshgANRsI0ApqJhHpe8B7
X-Google-Smtp-Source: ADUXVKJW+GvN8O2aOWdb2EyUZbXTKoogrXv2pZTnMKeIxUgo2QNrvjEm6PYcNKoOCH0UXXnZHAIUww==
X-Received: by 2002:a1c:8c55:: with SMTP id o82-v6mr8165874wmd.60.1529327947926;
        Mon, 18 Jun 2018 06:19:07 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-40-196.w86-221.abo.wanadoo.fr. [86.221.119.196])
        by smtp.googlemail.com with ESMTPSA id c10-v6sm14230575wrs.6.2018.06.18.06.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 06:19:06 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH 0/3] rebase -i: rewrite reflog operations in C
Date:   Mon, 18 Jun 2018 15:18:41 +0200
Message-Id: <20180618131844.13408-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series rewrites the reflog operations from shell to C.  This
is part of the effort to rewrite interactive rebase in C.

The first commit is dedicated to creating a function to silence a
command, as the sequencer will do in several places with these patches.

This branch is based on ag/rebase-i-rewrite-todo, and does not conflict
with pu (as of 2018-06-18).

Alban Gruin (3):
  sequencer: add a new function to silence a command, except if it
    fails.
  rebase -i: rewrite setup_reflog_action() in C
  rebase -i: rewrite checkout_onto() in C

 builtin/rebase--helper.c   |  14 +++++-
 git-rebase--interactive.sh |  39 +++--------------
 sequencer.c                | 103 +++++++++++++++++++++++++++++++++------------
 sequencer.h                |   6 +++
 4 files changed, 100 insertions(+), 62 deletions(-)

-- 
2.16.4

