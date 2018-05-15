Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A6161F406
	for <e@80x24.org>; Tue, 15 May 2018 20:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeEOUAh (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 16:00:37 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41559 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752645AbeEOUAf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 16:00:35 -0400
Received: by mail-pl0-f65.google.com with SMTP id az12-v6so657075plb.8
        for <git@vger.kernel.org>; Tue, 15 May 2018 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JXHo2LHjbRkI1svHJa6SUqBWsAocg5E9LewcHAnpQhY=;
        b=HBkjrauKh7xRPMhcWFR7/Hou1/joet4NrT/PtgVV1P8NULYQKDNrgOVxoZRKp0iOSJ
         KOfWwyRlEujj8zZ+A/Z2jJPgy8Z9gtAIiD/Az83FGLfaJ02+30/vsEPYNymh81Lx4yPc
         BYQjV1Xx5eya72ICsbeJYm2OUgsI752BXpmCEvAL41jQzIxLI1zuoAypnyPuVtoTCU46
         G7fnAaF00xW5AiBkS8Q2nzNccv8Dyx+NAvAcNij85qlj6h9nZaxVMFr76AsNJEDXVDm4
         nNlmZp2L/jB+700xGm/GqdwYj5XaSnOAwumu9DLdO8mFowekdX7UPzqCylxdP0qHqDiN
         oo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JXHo2LHjbRkI1svHJa6SUqBWsAocg5E9LewcHAnpQhY=;
        b=Xodc14EUbHtsBNVWugzevpu06PTqySprhQyvmvjA7gopEB7sAqo0kBhO/2ryxatqjQ
         rN7mhQBd3OkqPe01yGc033Jw0KA2V690AHk+qR4Wyrc0icWgysrJoq5wsAntYrtg5vpV
         0h3yUtZI+TtTtYNlivKQWVx7uXcwp+HDaKzkq2mU8PR4fI/hrlGCI+0UlWGVSkZ8Nx+4
         PMIiipyJSkUAOT8KXgPQNetGeyJxzwlmvnhfC+c5BNtlabR/PErrByXpgR3SQWLq39bN
         DBe9c9P4FgboB5RxVpW/WrMMgvO+bKFf0EBg9NThkYLsdxPskQs8YaZICCJh4pSVz0qp
         Y/zA==
X-Gm-Message-State: ALKqPwfSQbUXeOGxftfH+bvj31+CEfoBY1w1gGTH7hvsLbC/sihAj2Fq
        SQ3UMbagd7RI1iih79ioIZVXKMPymJ0=
X-Google-Smtp-Source: AB8JxZp++21DJge7BumDwxW3Ca1Jbo1fs63hBX0OXAJOJpSQG/DcCS+d5cRjZripCQOKIB9f1/Lg3w==
X-Received: by 2002:a17:902:7601:: with SMTP id k1-v6mr15705210pll.200.1526414434050;
        Tue, 15 May 2018 13:00:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id u75-v6sm1096809pfd.92.2018.05.15.13.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 13:00:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, leif.middelschulte@gmail.com
Cc:     gitster@pobox.com, newren@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/3] Reroll of sb/submodule-merge-in-merge-recursive
Date:   Tue, 15 May 2018 13:00:25 -0700
Message-Id: <20180515200030.88731-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rerolls the two commits found at [1] with the feedback of Eliah
and puts Leifs patch[2] on top, that I edited according to Eliahs feedback,
but kept Leifs ownership. 

This has addressed all of Eliahs feedback AFAICT.
You'll find a branch-diff below[3], which lacks
the new patch of Leif in that series, but is part of the reroll?

Leif, what do you think?

Thanks,
Stefan

[1] https://public-inbox.org/git/20180510211917.138518-1-sbeller@google.com/
[2] https://public-inbox.org/git/20180514205737.21313-2-leif.middelschulte@gmail.com/
[3] git branch-diff origin/master..origin/sb/submodule-merge-in-merge-recursive origin/master..HEAD  >>0000-cover-letter.patch

Leif Middelschulte (1):
  Inform about fast-forwarding of submodules during merge

Stefan Beller (2):
  submodule.c: move submodule merging to merge-recursive.c
  merge-recursive: i18n submodule merge output and respect verbosity

 merge-recursive.c | 185 +++++++++++++++++++++++++++++++++++++++++++++-
 submodule.c       | 168 +----------------------------------------
 submodule.h       |   6 +-
 3 files changed, 186 insertions(+), 173 deletions(-)

-- 
2.17.0.582.gccdcbd54c44.dirty



1:  e022c7976ae ! 1:  3b638ccac64 submodule.c: move submodule merging to merge-recursive.c
    @@ -20,7 +20,6 @@
         This commit is best viewed with --color-moved.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/merge-recursive.c b/merge-recursive.c
     --- a/merge-recursive.c
2:  2c02ece7e01 ! 2:  eb43110df9d merge-recursive: i18n submodule merge output and respect verbosity
    @@ -7,7 +7,6 @@
         internationalisation as well as the verbosity setting.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/merge-recursive.c b/merge-recursive.c
     --- a/merge-recursive.c
    @@ -73,10 +72,10 @@
     -		fprintf(stderr, "Found a possible merge resolution "
     -				"for the submodule:\n");
     +		output(o, 1, _("Failed to merge submodule %s (not fast-forward)"), path);
    -+		output(o, 1, _("Found a possible merge resolution for the submodule:\n"));
    ++		output(o, 2, _("Found a possible merge resolution for the submodule:\n"));
      		print_commit((struct commit *) merges.objects[0].item);
     -		fprintf(stderr,
    -+		output(o, 1, _(
    ++		output(o, 2, _(
      			"If this is correct simply add it to the index "
      			"for example\n"
      			"by using:\n\n"
-:  ----------- > 3:  4a3bc435023 Inform about fast-forwarding of submodules during merge
