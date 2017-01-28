Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6FB51F437
	for <e@80x24.org>; Sat, 28 Jan 2017 02:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750864AbdA1CC3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:02:29 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34568 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbdA1CC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:02:28 -0500
Received: by mail-pg0-f46.google.com with SMTP id 14so85551743pgg.1
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4FB1mB1ier2za3hHKxQZsij1C5/D2Ir4/+mgF1A6JNY=;
        b=csBGNPXcHQ/edr2Z48ru6urio87W1GIwau2gsEAAz8GmqT3FifL7RSO42etWbRWCBJ
         fb4u8WlsatYZApsOoE9hDetuVfv+ZS5dcsmESyKMyB7GN4dipR7OB7lqYg5ZAmBnZzIk
         sshRkMTSTQ1PklyMhmwfocns8BOBuZ3USv1HcwZVL9XF/iDdg9UqDyaR3Gvy9fCNq1Hw
         eAIUDQLREjh28qlt/I+jXoCBmKE5iGtZynEbq3vXPzyuA1x5GmR4JBj4t71xCH5H+hWN
         kq8uzF8a/FoSrooRe4c4vNqKwEDbK2teLSJY0Tupb/0zludRb4KmdT/SA0o+Hv8jaOPz
         2RCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4FB1mB1ier2za3hHKxQZsij1C5/D2Ir4/+mgF1A6JNY=;
        b=LTT0b+FAKodGzOJ+GImXfZys31YWNBKT+Fe9Uh9yLHnIhwYl26qYMZtG5JhuE5oZzW
         ze8QaFcLYpLdk+XqiHacoc9vjlRr7No5eeKW3HEnBHegVPxdVt0yMhtRLmi0Y0U+lTow
         WWXmyAqQ8Em+iKUysFFeRK5lSCO33ERkt8AbSyFkNsnVj0tuiZbiQFl5Xc5WN88DkCF7
         IhW7lVz7iiB7fBjGuSRmMN4vh6rEkOc/qri4eUySysJghKb3dkfNlIkxUIWRVJNMF6b1
         BodWS5h8yHHfIjhQ54sxe9wQpWNyet3MOvI1ThOM202T5bM1aPAQxIznImDvvn43XMXz
         SfmQ==
X-Gm-Message-State: AIkVDXKfi3xAyM3tRLpx/6X48GrPrGv+dyqSjAgTAT3ND+5BTP0gQISLn8uuNWA6ojLXFbn5
X-Received: by 10.84.238.1 with SMTP id u1mr16746854plk.174.1485568947315;
        Fri, 27 Jan 2017 18:02:27 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:25 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH v3 00/27] Revamp the attribute system; another round
Date:   Fri, 27 Jan 2017 18:01:40 -0800
Message-Id: <20170128020207.179015-1-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per some of the discussion online and off I locally broke up up the question
and answer and I wasn't very thrilled with the outcome for a number of reasons.

1. The API is more complex.  Callers needs to have two structures allocated
instead of one, one can be shared read-only while the other can't.  While this
many not be that big of a deal, it was more confusing to me.

2. Performance hit.  The allocation churn with creating/freeing a
scoreboard and the results struct adds up.  It even looks like the
cost of looking up a stack frame in a hashmap isn't very cheap.

  Here are some very rough performance measurements I made on my machine
  on linux.git by: `perf stat -r 50 git grep "asdfghjkl"`

  master: 0.302176063 seconds
  v1:     0.324243806 seconds
  v2:     0.304339636 seconds
  split:  0.349892023 seconds (hashtable of stacks, all_attr scoreboard
                               allocated per git_attr_check() call, split
                               question/answer)

After looking at this, I'm of the opinion that the API in v2 is the best route
to take.  Its a step-up from what it is currently (at master) and there isn't a
performance degradation (ok there's a small bit but it seems within the margin
of error).  It also allows for easier adaptation of the API if we wanted to do
a change in the future since the primary functionality remains intact, or to do
optimizations like stack pruning (if we decided to go down that route).

Given the above, v3 is a reroll of the same design as in v2.  This is a good
milestone in improving the attribute system as it achieves the goal of making
the attribute subsystem thread-safe (ie multiple callers can be executing
inside the attribute system at the same time) and will enable a future series
to allow pathspec code to call into the attribute system.

Most of the changes in this revision are cosmetic (variable renames, code
movement, etc) but there was a memory leak that was also fixed.

Brandon Williams (8):
  attr: pass struct attr_check to collect_some_attrs
  attr: use hashmap for attribute dictionary
  attr: eliminate global check_all_attr array
  attr: remove maybe-real, maybe-macro from git_attr
  attr: tighten const correctness with git_attr and match_attr
  attr: store attribute stack in attr_check structure
  attr: push the bare repo check into read_attr()
  attr: reformat git_attr_set_direction() function

Junio C Hamano (17):
  commit.c: use strchrnul() to scan for one line
  attr.c: use strchrnul() to scan for one line
  attr.c: update a stale comment on "struct match_attr"
  attr.c: explain the lack of attr-name syntax check in parse_attr()
  attr.c: complete a sentence in a comment
  attr.c: mark where #if DEBUG ends more clearly
  attr.c: simplify macroexpand_one()
  attr.c: tighten constness around "git_attr" structure
  attr.c: plug small leak in parse_attr_line()
  attr.c: add push_stack() helper
  attr.c: outline the future plans by heavily commenting
  attr: rename function and struct related to checking attributes
  attr: (re)introduce git_check_attr() and struct attr_check
  attr: convert git_all_attrs() to use "struct attr_check"
  attr: convert git_check_attrs() callers to use the new API
  attr: retire git_check_attrs() API
  attr: change validity check for attribute names to use positive logic

Nguyễn Thái Ngọc Duy (1):
  attr: support quoting pathname patterns in C style

Stefan Beller (1):
  Documentation: fix a typo

 Documentation/gitattributes.txt               |  10 +-
 Documentation/technical/api-gitattributes.txt |  86 ++-
 archive.c                                     |  24 +-
 attr.c                                        | 878 ++++++++++++++++++--------
 attr.h                                        |  49 +-
 builtin/check-attr.c                          |  66 +-
 builtin/pack-objects.c                        |  19 +-
 commit.c                                      |   3 +-
 common-main.c                                 |   3 +
 convert.c                                     |  25 +-
 ll-merge.c                                    |  33 +-
 t/t0003-attributes.sh                         |  26 +
 userdiff.c                                    |  19 +-
 ws.c                                          |  19 +-
 14 files changed, 816 insertions(+), 444 deletions(-)

-- 
2.11.0.483.g087da7b7c-goog

