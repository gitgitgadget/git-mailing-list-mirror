Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F8932090B
	for <e@80x24.org>; Tue, 19 Sep 2017 07:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbdISHPq (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 03:15:46 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37638 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdISHPp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 03:15:45 -0400
Received: by mail-pg0-f67.google.com with SMTP id v5so1583093pgn.4
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 00:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rHbwEVd/yuWXDuSVV3gxkE9RLi48S4HP1XT9uBuvIh4=;
        b=XQYoHurDt+u0T61CE+qY7wlHUIvXdkJyRc4aq4a8p6o5DSAG+XvatKVhwz3JfhsHVo
         /hXJJIj4U4X1Mj8DAsCQPUDeaAr97HZ9jBf2ubemdsLV1WzCyvlIN0d6JR6acU+G4w+l
         RcXQhe3A1FyEl5oP1h4nRU21FhhZQ5fLoavxjrlGKw3mboiNSVEFW3wxgLRBR/5vhjlj
         JHh5uqjKlJnv8IBNeoL4OHY+IGn4r+ZTXAel4K8U0FvOb4sDW9jpmncFDd30qdiDIGAS
         a8DDDILO1Fi2YsIOEq4cNDP7wvXbSqvBHkp0jrsiUfs+k0cgZU9Gr7WG/56CWh3+YGbB
         LEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rHbwEVd/yuWXDuSVV3gxkE9RLi48S4HP1XT9uBuvIh4=;
        b=gq5idDTKqZDt8o2zXutN8FHrtEhGOSdKZxB3srt8ncVbsJBe0DMpZFD0qClMBfsO0e
         Y3g0GlML73tqcToqwfP52idJS9PSGple3IN8vDEA2puEcXdBzkSt8DKYW/OH7xpG5eWH
         EiSDFkYWJ9UJ4SMyEkBAcsA9WPMiE9nAXdXUrfSGR9IwZmiXcPUKcWRDR9TFSXogElAQ
         jrIsuO2whxhUHZ6p/EfUkiwnc+s//jQcgNEzqxVSVZl0jT77X4alKJQQoFRujmprbMB/
         0rx+8Un4XJ1zOG6ynzuqNBq6Tcbr8I2aAmCuwkiQevkuOq++cyuVNm/kVbnG49ThGLRI
         ZsUQ==
X-Gm-Message-State: AHPjjUhgKtj9MtkAzv207RCBrJIlIohuhoJWvbWCoXRBn06J2aqfTdD/
        /o1Cerl+tSOqgEsPzznhxDni8gLdjgM=
X-Google-Smtp-Source: AOwi7QDRjUi7euM6BySF6kuWGOzNgHWzUXbrFmwkZjgxZ/Q0VEEZDUJesUzVU83Esx/9QG/YYDj8cg==
X-Received: by 10.84.201.6 with SMTP id u6mr426827pld.289.1505805344721;
        Tue, 19 Sep 2017 00:15:44 -0700 (PDT)
Received: from glitch-pc.sce.com ([117.209.170.72])
        by smtp.gmail.com with ESMTPSA id d126sm1927863pgc.85.2017.09.19.00.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 00:15:44 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [RFC PATCH 0/5] branch: improve error messages of branch renaming
Date:   Tue, 19 Sep 2017 12:45:20 +0530
Message-Id: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.930.g532ff9be2
In-Reply-To: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In builtin/branch, the error messages weren't handled directly by the branch
renaming function and was left to the other function. Though this avoids
redundancy this gave unclear error messages in some cases. So, make builtin/branch
give more useful error messages.

The first two patches are preparatory/cleanup patches.

The third patch refactors a function to make it more usable/understandable(?).
This results only in one functional change as noted there. I've tried my best not
to screw anything up as a consequence of that refactor[note 1]. In case I missed
something, let me know.

The fourth patch introduces part of the logic needed to improve error messages.
It's kept separate to keep things reviewable.

The fifth patch is the main one which does the improvement of error messages.

These patches apply on top of 'master' and be found in my fork[2].

Note:

[1]: The Travis CI build did succeed but I don't think we can rely on that a lot
because the test aren't exhaustive (I guess).
https://travis-ci.org/sivaraam/git/builds/277146416

[2]: https://github.com/sivaraam/git/tree/work/branch-move-revamp

Kaartic Sivaraam (5):
  builtin/checkout: avoid usage of  '!!' for expressions
  branch: document the usage of certain parameters
  branch: cleanup branch name validation
  branch: introduce dont_fail parameter for update validation
  builtin/branch: give more useful error messages when renaming

 branch.c           | 67 +++++++++++++++++++++++++++++++++++++++---------------
 branch.h           | 44 +++++++++++++++++++++++++----------
 builtin/branch.c   | 48 +++++++++++++++++++++++++++++++++-----
 builtin/checkout.c |  7 +++---
 t/t3200-branch.sh  |  4 ++++
 5 files changed, 130 insertions(+), 40 deletions(-)

-- 
2.14.1.868.g66c78774b

