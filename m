Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB59D1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 20:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbfFRUZ3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 16:25:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44799 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfFRUZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 16:25:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so23536902edr.11
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 13:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=CREzw0NbkmJM5g4MDWsJIhokFQf8nhOcUBPr1gxLU5w=;
        b=KxJMgfeLN570tOh5XkVadZYqeJngK6HaRsOFm0TAN6RJ4dkWrwsC631ILnkkaLFkGQ
         meQl3tFZTXrhEfrTUwWUc7uMoFGo9LJ9AtZrKA7Cw/TP16qKC6TUi7mpyc3f9KaNqOAz
         Yf2Tbab+iPSICmmb3JUNRYLEPLFfi0HJ4+Eyt20IMwWHbzLOcUZkP76WDodiyUkqclp0
         4MxbltquxK80bfFjK7MNumnnu7CH42EQReiIR0nChrEHzcDQ2kYYNYWHY8H30CzVYGhY
         bV7+hP9ABwBEahgDz6tBNdaZW8AAfhS5Luonze6AcHhBzyyLImrWy4jdx/Nn7XgT9Le4
         owuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CREzw0NbkmJM5g4MDWsJIhokFQf8nhOcUBPr1gxLU5w=;
        b=fnks0+q77X4p5+7SkYndMXQCY9ka6heb36C7LSkYJpCYSMviShD4yqOAGBA8GaP/Ti
         0lB66I4TgXKCO388u6nZa7HFbNYQV3HKOQd1VPRNi5HweGUVynyLsMVOetqbA+JJKTIc
         HpQ69yzvhEdsNCKiHspg6MjyDh4BDbbiaCl3SB49VznG/kEZrjmaCybY4eVFGTHl4gbr
         xK37rgI54ZoIw6/UorlGx7/ulQU575M0FUor9OXxTK1+0kSdrzEU62OMdJ8azWLcym9N
         FrKQP9Ot8jBXC5z/XpXT2LAp/Re/ddKZT36nMuiwRF+sxmLmu+WUsTz2DW9IvTHPmsKS
         AAyA==
X-Gm-Message-State: APjAAAUNJsPDlSBNiG7IQXPiUcWwygQMOG2cTOgfUjEQL7hkt8nFxG5i
        MkvjSkfAK5oRKumv6ce9+Pt9z7sz
X-Google-Smtp-Source: APXvYqwxLhQGTj4UqSl4SwLa8+lVtam8pBy2qu7rZ3p7eEv6bogNjDqba3VYdS011UMS4P8LJdHD2Q==
X-Received: by 2002:a50:9431:: with SMTP id p46mr109689579eda.38.1560889526015;
        Tue, 18 Jun 2019 13:25:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b49sm820565edc.51.2019.06.18.13.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 13:25:25 -0700 (PDT)
Date:   Tue, 18 Jun 2019 13:25:25 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 20:25:21 GMT
Message-Id: <pull.273.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] fetch: add --[no-]show-forced-updates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     git@jeffhostetler, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git fetch builtin includes a calculation to see if the ref values were
forced updates (i.e. if the old value is not in the history of the new
value). In a repo with many refs and a fast-moving history, this calculation
can be very slow.

This series adds a new --[no-]show-forced-updates option to 'git fetch' to
avoid this calculation when requested. Further:

 1. Add a new fetch.showForcedUpdates config setting that provides a default
    value for --[no-]show-forced-updates.
    
    
 2. Add a new advice.fetchShowForcedUpdates config setting associated with a
    warning that suggests fetch.showForcedUpdates when the calculation takes
    a long time, or warns about the lack of "(forced update)" messages.
    
    
 3. Add the command-line options to 'git pull'.
    
    

We have been running with these commits in microsoft/git for a while now and
no user has complained that the messages were removed (VFS for Git sets 
fetch.showForcedUpdates=false by default). Users have complained about the
warning messages always appearing, so this series includes the advice config
setting. Further, I added a test to demonstrate the behavior change between
the two options.

The fetch.showForcedUpdates config setting is a candidate to be added to the
proposed "large repo" meta-config setting previously discussed [1]. I'm
putting this out for independent review as it is much smaller compared to
the potential of that series.

Thanks, -Stolee

[1] https://public-inbox.org/git/pull.254.git.gitgitgadget@gmail.com/

Derrick Stolee (3):
  fetch: add --[no-]show-forced-updates argument
  fetch: warn about forced updates in branch listing
  pull: add --[no-]show-forced-updates passthrough

 Documentation/config/advice.txt |  4 ++++
 Documentation/config/fetch.txt  |  5 +++++
 Documentation/fetch-options.txt | 13 +++++++++++++
 advice.c                        |  2 ++
 advice.h                        |  1 +
 builtin/fetch.c                 | 34 ++++++++++++++++++++++++++++++++-
 builtin/pull.c                  |  7 +++++++
 t/t5510-fetch.sh                | 23 ++++++++++++++++++++++
 8 files changed, 88 insertions(+), 1 deletion(-)


base-commit: b697d92f56511e804b8ba20ccbe7bdc85dc66810
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-273%2Fderrickstolee%2Fshow-forced-updates-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-273/derrickstolee/show-forced-updates-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/273
-- 
gitgitgadget
