Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0458C1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 18:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbfFXSN2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 14:13:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36978 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfFXSN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 14:13:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so286803wme.2
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 11:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WbBLI2cC5Uemn+UxxJ3AQyk+qY/StQxvl0Reaiqvp74=;
        b=WTBCiMzIc4s65mQsJIAUViO7Ht/mMYYCEghBsThqhGo+NK72DUVJuhN9pQ0qii9hus
         aEnV4Gb4MvDjv7VFcwWNZi+SYOP3tEZ6Jkv/Ym4bYKZyyIZaZya2svY0zONVnpX6XkUl
         6q6bFCB4b/UoRCjIw/w7V3VzUQGCUJSFpx65zDaM1QDYeATALknb8cSgutOOg0gFnfII
         nU+1n8xqW770wULPWYm6nIi+o2pbEX1kDCbjNzg6ryDGUPmNCk2Q+/+9UKBLo/OYcNKR
         qAiz/Axjed9peLrqy20C36pY1anEypN+YMHFXXlHS+ldg+8atDym+J9i5p13zcoDh8IF
         Sa0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WbBLI2cC5Uemn+UxxJ3AQyk+qY/StQxvl0Reaiqvp74=;
        b=j6HKjnKPg6e1du7lVjaWqXTpt/uUEV2pxWiINjJc78nu0cHOFnlbsG1WM299MuB5ro
         1EqOwTUhdM6KZ9dN27Ark9VOTAVXzDAWnJXjshcID9kwrs5vSwvImfbc9BRE2QrN0qbq
         v5wbS+CXTEzGHkfAxrhw4E+054Vq16gbHoa4kWco28gkOxf9l9i9Rr4noHi8RYyEfdRM
         Q5abNptux/lygZr4iBDQI0NISNaiJWV0aJQRA3cFQFYYv8gLFZg/A/7JOIPizxvGxnd8
         skpvCFoBz2MvUDTvuNHTetUScIE9ZpJNdAysGO/QEH6oPadFToW4XBb6HSZQZ2WsmB0i
         GIkA==
X-Gm-Message-State: APjAAAWVZeMkcv4FO0YRdThk42CoGRnFZ/LkjQi9yxhp82MvCKYtPfkb
        3JdPGfrCQ9FvzXDr5pXnbVA=
X-Google-Smtp-Source: APXvYqzbn+4D4NI/LuEE0mtpL+GNmzSRWugEzmHGq9ntADNZ/BafiqqmSuXDO7UUNyv8eXfjd9G41A==
X-Received: by 2002:a1c:6c08:: with SMTP id h8mr17616131wmc.62.1561400004962;
        Mon, 24 Jun 2019 11:13:24 -0700 (PDT)
Received: from localhost.localdomain (x4db9a89d.dyn.telefonica.de. [77.185.168.157])
        by smtp.gmail.com with ESMTPSA id v65sm401349wme.31.2019.06.24.11.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jun 2019 11:13:24 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 0/5] rebase/progress: add and use term_clear_line()
Date:   Mon, 24 Jun 2019 20:13:13 +0200
Message-Id: <20190624181318.17388-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.589.g5bd7971b91
In-Reply-To: <20190611130320.18499-1-szeder.dev@gmail.com>
References: <20190611130320.18499-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes some garbled progress display in 'git rebase' and
simplifies clearing up the progress display in general.

Only slight updates since the previous version to remove one of the
"Yuck"s by making the offending test in t3404 more focused, making
the first patch of the previous version pointless.  There is also a 
a preparatory cleanup patch 't3404: modernize here doc style'.


v2: https://public-inbox.org/git/20190611130320.18499-1-szeder.dev@gmail.com/T/#u


SZEDER Gábor (5):
  t3404: modernize here doc style
  t3404: make the 'rebase.missingCommitsCheck=ignore' test more focused
  pager: add a helper function to clear the last line in the terminal
  rebase: fix garbled progress display with '-x'
  progress: use term_clear_line()

 cache.h                       |   1 +
 editor.c                      |   6 +-
 pager.c                       |  20 ++++++
 progress.c                    |  28 ++++----
 sequencer.c                   |  17 ++++-
 t/t3404-rebase-interactive.sh | 120 ++++++++++++++--------------------
 t/t3420-rebase-autostash.sh   |   4 +-
 t/t5541-http-push-smart.sh    |   6 +-
 8 files changed, 104 insertions(+), 98 deletions(-)

Range-diff:
1:  b392128604 < -:  ---------- t3404-rebase-interactive: use the 'q_to_cr' helper
-:  ---------- > 1:  4372a3cde4 t3404: modernize here doc style
-:  ---------- > 2:  5444f547c5 t3404: make the 'rebase.missingCommitsCheck=ignore' test more focused
2:  b48f49c114 = 3:  5ebf218cb9 pager: add a helper function to clear the last line in the terminal
3:  b25363c7c3 ! 4:  51cd5ccd46 rebase: fix garbled progress display with '-x'
    @@ -39,13 +39,13 @@
         "Stopped at <abbrev-oid>... <subject>" for the 'edit' or 'break'
         commands, or the "Successfully rebased and updated <full-ref>." at the
         very end.  These are so long that they practically always overwrite
    -    that "Rebasing (n/m)" progress line, but let's be prudent, and clear
    +    that "Rebasing (N/M)" progress line, but let's be prudent, and clear
         the last line before printing these, too.
     
    -    Three tests, one in 't3404-rebase-interactive.sh' and two in
    -    't3420-rebase-autostash.sh' check the full output of 'git rebase' and
    -    thus are affected by this change, so adjust their expectations to
    -    account for the new line clearing.
    +    In 't3420-rebase-autostash.sh' two helper functions prepare the
    +    expected output of four tests that check the full output of 'git
    +    rebase' and thus are affected by this change, so adjust their
    +    expectations to account for the new line clearing.
     
         Note that this patch doesn't completely eliminate the possibility of
         similar garbled outputs, e.g. some error messages from rebase or the
    @@ -116,19 +116,6 @@
      		strbuf_release(&buf);
      		strbuf_release(&head_ref);
     
    - diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
    - --- a/t/t3404-rebase-interactive.sh
    - +++ b/t/t3404-rebase-interactive.sh
    -@@
    - Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
    - The possible behaviours are: ignore, warn, error.
    - 
    --Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QSuccessfully rebased and updated refs/heads/missing-commit.
    -+Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QQ                                                                                QSuccessfully rebased and updated refs/heads/missing-commit.
    - EOF
    - 
    - test_expect_success 'rebase -i respects rebase.missingCommitsCheck = warn' '
    -
      diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
      --- a/t/t3420-rebase-autostash.sh
      +++ b/t/t3420-rebase-autostash.sh
4:  ec85b386fd = 5:  09642a458e progress: use term_clear_line()
-- 
2.22.0.589.g5bd7971b91

