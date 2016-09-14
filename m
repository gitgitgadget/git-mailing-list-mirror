Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A26381FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 21:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762847AbcINVHf (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 17:07:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33366 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762115AbcINVHe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 17:07:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id b187so4241084wme.0
        for <git@vger.kernel.org>; Wed, 14 Sep 2016 14:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xbm6QqdSuyvbPXDqhN2fSSXk0JL/vXbfMXXAOT0b3Xs=;
        b=aalFjBBFGUGY/d43xADNhKQj2TMjGk7nETd0JAJsNJT5oXFr9ezWD8yBrul5gxmyrk
         nOxIPBlWEkBMxIvkf7GcTLRMNSWgmwmdMoLeZ6EKfb0KdNCTLIHaReAGXCpSqZEBcZbD
         HnyrYoH+PUhwm6DXB3yAqsR6zlpJAZ387fnF+cfhXboPA3EgXMXppGLETQxhO/rByxwa
         vWYooiKeuxmdlpRoRXTwtWd3PWXEht3jkwAZyPZDUxHlXsdGym8PUaEmXBLozX3o6BYN
         1TGKXUljvOkliAYIERfLXWV/P8Qh6E2QgXF9JFyJDcEcq/Cvg2cWD6tHtHogfmufL1J/
         q21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xbm6QqdSuyvbPXDqhN2fSSXk0JL/vXbfMXXAOT0b3Xs=;
        b=VbtSpmznb6USb8H4LXXQjxcD5jX0D68MjKhkkqdI/sUFJDoueUBNfzEnxBVFxJ1LY+
         6LY4EmCbL/lsn6hWydWZDS04136v2+MixgOm0NkVU+Fs8Gwo/6eKUvzGhr27IXp55vxa
         tzdtRdVTS4F+o2+CefLY+MGTBnDkZ2dbgNQoFKrzBrn7omNS+kI6OBzg1ClJv/nbap9k
         Q0zCqQHS0cDkEYmfV0jJh5LgE1+zRJamLKaVqH/IXx91nXUIJqJScECpZuF6scuNe/RJ
         5QDNN0kxur7s3+TrJcPMybWN4vMze5K8edd1FxnzyldgPWsTFq+GKu7pFWXW91SW5Js0
         09uQ==
X-Gm-Message-State: AE9vXwORBTZgqariK3HK9mChWJ5bJBbygK+WJ7clDXC5V2cG+6EQAu8OXNbFqCYdzU230w==
X-Received: by 10.194.200.198 with SMTP id ju6mr4496169wjc.184.1473887252725;
        Wed, 14 Sep 2016 14:07:32 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id lz5sm104259wjb.24.2016.09.14.14.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Sep 2016 14:07:31 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        =?UTF-8?q?Ingo=20Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 0/4] git add --chmod: always change the file
Date:   Wed, 14 Sep 2016 22:07:43 +0100
Message-Id: <20160914210747.15485-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484
In-Reply-To: <20160912210818.26282-1-t.gummerer@gmail.com>
References: <20160912210818.26282-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio for the review of my last round.

Changes since then:
[1/4]: patch unchanged
[2/4]: Only adds a test now, and corrects the type of the argument of
       chmod_path, but leaves the rest of the patch unchanged.
[3/4]: chmod_index_entry now takes a char as argument which can either
       be + or -, and changes the mode based on that, instead of using
       the 0777 or 0666 mode that was passed in from the outside.
[4/4]: Adapted to the different behaviour of chmod_index_entry and
       added tests as suggested by Junio.

Thomas Gummerer (4):
  add: document the chmod option
  update-index: add test for chmod flags
  read-cache: introduce chmod_index_entry
  add: modify already added files when --chmod is given

 Documentation/git-add.txt     |  7 +++++-
 builtin/add.c                 | 47 ++++++++++++++++++++++++----------------
 builtin/checkout.c            |  2 +-
 builtin/commit.c              |  2 +-
 builtin/update-index.c        | 18 +++-------------
 cache.h                       | 12 ++++++-----
 read-cache.c                  | 43 ++++++++++++++++++++++++++++++-------
 t/t2107-update-index-basic.sh | 13 +++++++++++
 t/t3700-add.sh                | 50 +++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 144 insertions(+), 50 deletions(-)

-- 
2.10.0.304.gf2ff484

