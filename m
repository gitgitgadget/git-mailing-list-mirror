Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36481C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiKHSmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiKHSmT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:42:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67633220F2
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:42:18 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l188-20020a2525c5000000b006cbcff0ab41so14747562ybl.4
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0zpDXb0/ox6Q5rBPOUs71co9wURYMpCOCX/9bFjzTs=;
        b=GlCL2PLqmbONfXjJricAgpBUi6qOe6tQs/sX4pRFT7+0vju2xcLMaeJRSBcRBnZ6ws
         Uh+NzLw0Ts9oj3fGCexQuJ5JUp/Xp8k9Z7lyyMAmpAkBbp1iRJ2Fq91aZHbdexQIj+VD
         5xAVL5lOIgkZLC4oZ9eK+61m39V/spOgkj+7nfJsUiEPeYJrmZC5kkcXbxbSslwSp3aS
         SrKgE4wxLi6sGdouuywGxXKoXJ9Etf3m03SLCJzZtTPf+f5utB6hVU71qKRpGUUTBL8I
         M4JfA8MB1CwINorhBYASUGnP+hpExwkYPJokbcqR5JiIIQ7bAYg/waLOMsf3a6mdzmFW
         Bo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0zpDXb0/ox6Q5rBPOUs71co9wURYMpCOCX/9bFjzTs=;
        b=YnUaIlw83HbhJ8PfR4jUUV1qUQDvhfMqd/LxM8nbDDDlNPmoj53qechRP+UhaQs4ao
         EDhUxbknhwZq5SiH20Z8D4F4VkZ3X0dRp1UYVK8WMsCsl0vx03l43UfJaqiwhnQWSdVX
         Rfo7nfBVIXYwgOvqeyDM0igIYcIB5QPNp9tSgXs9VCq7wI0Z8nATLSdK+vtdTAYhSU/t
         vn0J5BicB+1mHFGyat8C6jcbG4Gk9dvj+jc8Ja+jBoiIoGaspwnkbV4AiWMCzD3avgMg
         FZqkUZKCLurUJwzOGYtjIVHIIqKbfowaQYA/cZxaWFAO2uIWytYQGm8+/B06xYM1yKm1
         5xgw==
X-Gm-Message-State: ACrzQf2mK/6kv88bExTfH9RwJckNhiOdspbNofm2hO133P2HufV8ZMrk
        D3lN6/Jo+2oTkmus7XlPzPYIQNuYQJGyEBSF3iqezkAYNHwbL742SCifR9GO3vrFPUFgoGhqpK2
        KypgArTQlEz/dbFtjrYBxG98PXsF8+2FPYFHoehyUcLMv5ZaPkjYMA8VEYwsNSEHz1A==
X-Google-Smtp-Source: AMsMyM7jpMrY9er7UrFZQnR+SmD9Kp1fvpkwawWxjV5FHUjF7OZ50wVxxsU6tNbCurNLbn3NsiJcF+nWNq8kssI=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:848e:0:b0:36f:ce57:8543 with SMTP id
 u136-20020a81848e000000b0036fce578543mr51058356ywf.328.1667932937644; Tue, 08
 Nov 2022 10:42:17 -0800 (PST)
Date:   Tue,  8 Nov 2022 18:41:55 +0000
In-Reply-To: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221108184200.2813458-1-calvinwan@google.com>
Subject: [PATCH v4 0/5] submodule: parallelize diff
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, myriamanis@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original cover letter for context:
https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/

Changes since v3

Renamed pipe_output_fn to duplicate_output_fn and now passes an
additional "strbuf* out" parameter. Output is directly duplicated
to that function rather than held in a separate variable.
Slightly rewrote the tests to more accurately capture the expected
output of duplicate_output_fn.

Removed a patch that added an option to hide child process output.
Child process output is now reset in status_duplicate_output.

More style changes as suggested by Avar

Calvin Wan (5):
  run-command: add duplicate_output_fn to run_processes_parallel_opts
  submodule: strbuf variable rename
  submodule: move status parsing into function
  diff-lib: refactor match_stat_with_submodule
  diff-lib: parallelize run_diff_files for submodules

 Documentation/config/submodule.txt |  12 ++
 diff-lib.c                         | 103 +++++++++++--
 run-command.c                      |  13 +-
 run-command.h                      |  24 +++
 submodule.c                        | 229 +++++++++++++++++++++++++----
 submodule.h                        |   9 ++
 t/helper/test-run-command.c        |  21 +++
 t/t0061-run-command.sh             |  39 +++++
 t/t4027-diff-submodule.sh          |  19 +++
 t/t7506-status-submodule.sh        |  19 +++
 10 files changed, 441 insertions(+), 47 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

