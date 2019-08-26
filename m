Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FFB51F4B9
	for <e@80x24.org>; Mon, 26 Aug 2019 23:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfHZXwd (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 19:52:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46982 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfHZXwd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 19:52:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so10816295plz.13
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 16:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kd3hLdVEUR4VulP4NYipLt3M4cvqJFyl8+MVerPhRG4=;
        b=swmJ9qvR4KUeXaSABFMBd8Bka99nC/tBp+wc3BlbQOIZihc3Rl7L83ZMRaUdhwHJ6I
         Fr2MGS573HPon5UshKGWiiTuCl0wPq7K4ZolsSStSjgS7tLTRim3T9xf4iJr4A1frZ/w
         ZBVY8Ds7DFxF7CT0WSOpcHbzUERLUKW8KRBF59Bfxo09CaJJv/xqg7QJq0TcaMSfRxhX
         RUde6Te3iXIlJ6gSdSZF1sN+UYEixVzrSzD569yvsV8RSvlq1xv6CSTArBoKEi9ndBvx
         i7EHr3zqrbvOcakBGSALwNOnbGjOgn/Lnf7YjhX+3qIN/Pbk9/hkt2iNf75lheKQsBSf
         NVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kd3hLdVEUR4VulP4NYipLt3M4cvqJFyl8+MVerPhRG4=;
        b=Wqoe1h8c8gUPn7FHfbdxTUzeX/WuLbDhK0IzmpCPTN8eIIBn1Wysx3b3Z5g4N8ax0v
         TFLzOHf1uxcjwT7uU9oEXxjsgcBSsgbE2yBc1q+S67xoaX8Vx/zQfDy97LzcIHxLRSE3
         mGOvyL+SQitTZsfcrtQ1AuOB3BNGz8xsr7WChDijd6S+MAY8GrICKFT3jdpLYtBgXHQZ
         odfmZefBP/uvlhrTd3F0uiNGO7m11/40fsQRdM7zSeeP+n9mOiYIBzA4CbsjKrf6Tf0T
         r6jfEN+8CwolXiSRhwwLbJxM9mi0vZSqK+3ln/8kOSSpT3IY/JSThkTsOnJ/ef+SPlw4
         q+sg==
X-Gm-Message-State: APjAAAWUQBfgBYUGsUH66H15gFlSe3nQFoC1XFutkhS7wUJWHo0paqhu
        1fo2TqxFMXrzMPKqfyzjX4T+8FXH
X-Google-Smtp-Source: APXvYqzQcn7NBcXzT++CVZVVrSI3E05daxYH/udGQWaOmsHQ2OcU2f70YEzM3VSmW0oVqjnVRgAu4A==
X-Received: by 2002:a17:902:a58c:: with SMTP id az12mr9510772plb.129.1566863552484;
        Mon, 26 Aug 2019 16:52:32 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id 21sm5939047pfb.96.2019.08.26.16.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Aug 2019 16:52:31 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 0/5] Remove git-filter-branch from git.git; host it elsewhere
Date:   Mon, 26 Aug 2019 16:52:21 -0700
Message-Id: <20190826235226.15386-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.5.g775ebaa2a0
In-Reply-To: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com>
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following up on the suggestion to make git.git smaller and shed non-core
tools, here's an RFC series to do so with git-filter-branch.  This
series first removes dependencies on git-filter-branch (of which there
were very few), and then deletes git-filter-branch itself in the final
commit.

I'm more than happy to consider alternate places for the filter-branch
history (I had considered just merging it in with git-filter-repo), but
for now I just made it available here:
        https://github.com/newren/git-filter-branch

The rewrite above contains the history of the files deleted in Patch 5,
plus a one-time copy of relevant build files (Makefiles, test-lib.sh,
etc. -- I didn't want the whole history of these), and then touchups to
streamline the build files and make them all work in this standalone
repo.


Some highlevel notes on the patches:

  * Patches 1&2: are good cleanups & performance wins regardless of
    whether the rest of the series is taken
    
  * Patch 3: an attempt to improve i18n situation for external scripts,
    but discovered to not be necessary/useful for git-filter-branch
    specifically

  * Patch 4:
    * If we are good with deleting git-filter-branch now and just noting
      it in the release notes, then patch 4 could be simplified; there's
      no need to update git-filter-branch.txt in that case.
    * If, however, we want to do some external messaging for an
      additional release cycle or two before moving git-filter-branch
      out of git.git, this patch will help us until then to at least
      avoid recommending a tool which will likely mangle user's data in
      unexpected ways.  But it'd be really helpful if folks could review
      and opine on the BFG stuff if so.

  * Patch 5: actually deletes git-filter-branch, its tests, and
    documentation.


Elijah Newren (5):
  t6006: simplify and optimize empty message test
  t3427: accelerate this test by using fast-export and fast-import
  git-sh-i18n: work with external scripts
  Recommend git-filter-repo instead of git-filter-branch in
    documentation
  Remove git-filter-branch, it is now external to git.git

 .gitignore                          |   1 -
 Documentation/git-fast-export.txt   |   6 +-
 Documentation/git-filter-branch.txt | 481 --------------------
 Documentation/git-gc.txt            |  17 +-
 Documentation/git-rebase.txt        |   2 +-
 Documentation/git-replace.txt       |  10 +-
 Documentation/git-svn.txt           |   4 +-
 Documentation/githooks.txt          |   7 +-
 Makefile                            |   1 -
 command-list.txt                    |   1 -
 contrib/svn-fe/svn-fe.txt           |   4 +-
 git-filter-branch.sh                | 662 ----------------------------
 git-sh-i18n.sh                      |   7 +-
 t/perf/p7000-filter-branch.sh       |  24 -
 t/t3427-rebase-subtree.sh           |  32 +-
 t/t6006-rev-list-format.sh          |   5 +-
 t/t7003-filter-branch.sh            | 505 ---------------------
 t/t7009-filter-branch-null-sha1.sh  |  55 ---
 t/t9902-completion.sh               |  12 +-
 19 files changed, 63 insertions(+), 1773 deletions(-)
 delete mode 100644 Documentation/git-filter-branch.txt
 delete mode 100755 git-filter-branch.sh
 delete mode 100755 t/perf/p7000-filter-branch.sh
 delete mode 100755 t/t7003-filter-branch.sh
 delete mode 100755 t/t7009-filter-branch-null-sha1.sh

-- 
2.23.0.5.g775ebaa2a0

