Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54532C7EE25
	for <git@archiver.kernel.org>; Fri,  9 Jun 2023 23:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjFIXZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jun 2023 19:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjFIXZn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2023 19:25:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3ED30E5
        for <git@vger.kernel.org>; Fri,  9 Jun 2023 16:25:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565ba5667d5so29644087b3.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2023 16:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686353142; x=1688945142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=47DMwGMvnKtyqE/2oh07ZZ7BXOmgGL5Aa8F85fdgkDg=;
        b=PJRGa/3J9acqolkU1agDWoWkMxEIBA0wiFG2LknYenYI0tEtDhaHuAZmNn4huslQNZ
         3J1Uo7mubvG5LuCMXbeCxw3B81lWN8eKxzr8NdfUhbkiYG/xxFfldgwtw6BhHOJ5VYM+
         YiCSXt6doAWPlBQeFXGECnTgCGzRF00goYFdA1QNl5YqHO9ywXfCUWK3M1YeNTtWAOB0
         xTUuGCCmjeU+HARmOT3HJxkEMzqe3YCneh6GZrE+45Y5VwRy9YsTzFM4kuJPDB+CgjeA
         CgyFidI99FEq4QmdO0SZ4XjFGtT97VubmrgxcpIJp/jdxkvzxvh4q08RT0o8h0Eq2AQw
         dAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686353142; x=1688945142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DMwGMvnKtyqE/2oh07ZZ7BXOmgGL5Aa8F85fdgkDg=;
        b=UTmqC7wa8g6lXBFc9EaC4+HPRkoy9tu6hrdIQfHI9yOy2ufsN1hK3fJSYgrh6eDurA
         6eIferF1xw6X0A4it7vO+dWDj6geDmeVUg5C4+CZSfhbulE2zuzdBTw5r6FeNtXArRt2
         Ulkb3nfylzAV3Lv5F1dliDORG0HVDnPoe0FWPg8T2hdUPOhLWzgpNNeQTOiM4/HU3OAw
         piw1Ozd0t2L3wuvN2yEoamJNzpNpohqfIEOCH0EpqYHyTDlerlpSCvS+Hbtx9hDAPACm
         DOrOpng7RE3UCDtNx/G5/d4a3cbXQq3u6S0Cqdk3gxavOA6g9weRWeykqFLy00Fiz9lk
         WFSg==
X-Gm-Message-State: AC+VfDw9w4QNnhRLCWdOUHOFG0F5OxHQVETPryJIpFT3uJMoEQUou3j2
        ZIsNMN98ORpM17kmGfDsPO4iGCGGY/NifAADkVQ0z98aqci19ouyc1nxSiOCqFscIU07gWbPDdh
        abTMluFdD4JAxWUcttLlEbBtFIfHR6AEfYk/OeUDSaiwydq+Bm96IgqSew6Gymf4=
X-Google-Smtp-Source: ACHHUZ5DKvbgP6EuOU5qkmE1TUmiKsj2pm7qkR+tZoUH5tVuXKU/PtPAPhg7t6Xn3aiiYYBVT4jtejPYOJa+Iw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:202:a66f:7f98:2439:c197])
 (user=steadmon job=sendgmr) by 2002:a25:8c8b:0:b0:bc4:3e2f:7641 with SMTP id
 m11-20020a258c8b000000b00bc43e2f7641mr65359ybl.4.1686353141712; Fri, 09 Jun
 2023 16:25:41 -0700 (PDT)
Date:   Fri,  9 Jun 2023 16:25:29 -0700
In-Reply-To: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
Mime-Version: 1.0
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <c7729b66a42b77dfe9ef61ba7c81e78e00b4021d.1686352386.git.steadmon@google.com>
Subject: [RFC PATCH v3 0/1] Add a project document for adding unit tests
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     calvinwan@gmail.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        gitster@pobox.com, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In our current testing environment, we spend a significant amount of
effort crafting end-to-end tests for error conditions that could easily
be captured by unit tests (or we simply forgo some hard-to-setup and
rare error conditions). Unit tests additionally provide stability to the
codebase and can simplify debugging through isolation. Turning parts of
Git into libraries[1] gives us the ability to run unit tests on the
libraries and to write unit tests in C. Writing unit tests in pure C,
rather than with our current shell/test-tool helper setup, simplifies
test setup, simplifies passing data around (no shell-isms required), and
reduces testing runtime by not spawning a separate process for every
test invocation.

This patch adds a project document describing our goals for adding unit
tests, as well as a discussion of features needed from prospective test
frameworks or harnesses. It also includes a WIP comparison of various
proposed frameworks. Later iterations of this series will probably
include a sample unit test and Makefile integration once we've settled
on a framework.

In addition to reviewing the document itself, reviewers can help this
series progress by helping to fill in the framework comparison table.

[1] https://lore.kernel.org/git/CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com/# You can add trailers to the cover letter. Any email addresses found in

Changes in v3:
- Expand the doc with discussion of desired features and a WIP
  comparison.
- Drop all implementation patches until a framework is selected.
- Link to v2: https://lore.kernel.org/r/20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com

Josh Steadmon (1):
      unit tests: Add a project plan document

Documentation/Makefile                 |   1 +
 Documentation/technical/unit-tests.txt | 141 ++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+)


base-commit: 69c786637d7a7fe3b2b8f7d989af095f5f49c3a8
-- 
2.41.0.162.gfafddb0af9-goog

