Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7431C10F25
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 02:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CFA20637
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 02:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ot87ufC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCJCY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 22:24:57 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:36907 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgCJCY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 22:24:57 -0400
Received: by mail-wr1-f53.google.com with SMTP id 6so13850958wre.4
        for <git@vger.kernel.org>; Mon, 09 Mar 2020 19:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cj/I/zieWiRGQYDmc4ohbHUHiDfbPpQxGww5xvdWJr0=;
        b=ot87ufC16ssPK9O13bQ0y/KN/hMqxSUFwsyDVZMA2WcfIqkH2sjLb6Ibqp60kkSlu8
         XsIWbG9yuJcCOmCgyi4733oadoeH/wyeZf4GctsarU8JjXEoG/zsHI7oSkjLAjtFFoS2
         LQh+cw5h5MR0o9zeDO0CAY8ZLKKB9VPlSnDh/M1t67cS0CBr1CXkSVCo+EefIHFf3ZGs
         6xsODex5mBgN+Jwxl23PDPM4HwL8Mq24LzG0bRtICudcruJBoUXW31sz5PzgTOeI7ZLP
         lXVAhSju+pcFqgq6XkG5gF+Fl2cTUNfno62n3Y6HknJZgYiJZZPrjLiX10qPqybB7X/D
         a8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cj/I/zieWiRGQYDmc4ohbHUHiDfbPpQxGww5xvdWJr0=;
        b=fnnxEPHYqJ829NOIL1C7w3WbZoznu4r2Tmgmukj5ajqsOfm6tfI6RP20h5RpUbvS3i
         mjTyD4122eU/kEY41UaDehKS1VaFA3kaDx7cpIPK2tjWZJfG/wOaFXENPDuyTXEbCRyu
         RjRzNrAN0eS+3SOcGTnYrjl2hlHYk9/LczfkNjmNUxek3aF/vNHhMhYcPwsHI0P2IrP3
         7M5MuEjqRVOziVl75XAVjUxdvkc3JTm7k53RUNcYHlXUEiVwxWPvPezHhiCcn76u7S7Z
         SbDZO5qvbFMGqWFvJoeR/LywveJ4/NL0elUlZUv0ls0Jh5PvIucl//mKAIwu0odjKh76
         LzXQ==
X-Gm-Message-State: ANhLgQ1qrMI868hPYQSSXsoPkbmR+et/AN+ALflqn9IzvW9vg7Kzh8N5
        6yUHru8JEWBtQs76xJGVdb17UE8r
X-Google-Smtp-Source: ADFU+vv87jBs2VxZFZvji3IivSPH8t/wjvG3ZZg6TYlndgYkJhuN3jtEOeVUsdqu4RReGHk9TRMfiw==
X-Received: by 2002:adf:f584:: with SMTP id f4mr25417941wro.77.1583807094615;
        Mon, 09 Mar 2020 19:24:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8sm61956941wrw.2.2020.03.09.19.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 19:24:54 -0700 (PDT)
Message-Id: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com>
In-Reply-To: <pull.576.git.1583692184.gitgitgadget@gmail.com>
References: <pull.576.git.1583692184.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Mar 2020 02:24:50 +0000
Subject: [PATCH v2 0/3] Teach ref-filter API to correctly handle CRLF in messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ref-filter API does not correctly handle commit or tag messages that use
CRLF as the line terminator. Such messages can be created with the--verbatim 
option of git commit and git tag, or by using git commit-tree directly.

This impacts the output git branch, git tag and git for-each-refwhen used
with a --format argument containing the atoms%(contents:subject) or 
%(contents:body), as well as the output ofgit branch --verbose, which uses 
%(contents:subject) internally.

The function find_subpos in ref-filter.c looks for two consecutive '\n' to
find the end of the subject line, a sequence which is absent in messages
using CRLF. This results in the whole message being parsed as the subject
line (%(contents:subject)), and the body of the message (%(contents:body))
being empty.

Moreover, in copy_subject, '\n' is replaced by space, but '\r' is untouched,
resulting in the escape sequence '^M' being output verbatim in most terminal
emulators:

$ git branch --verbose
* crlf    2113b0e Subject first line^M ^M Body first line^M Body second line

This bug is a regression for git branch --verbose, which bisects down to
949af06 (branch: use ref-filter printing APIs, 2017-01-10).

The first patch in this series adds a new test library, 
t/lib-crlf-messages.sh, that contains functions to test this behaviour for
commands using either the ref-filter or the pretty API to display messages. 

The second patch fixes the bug in ref-filter.c and adds corresponding tests.

Finally, the third patch adds a test that checks the behaviour of git log in
the presence of CRLF in messages, to prevent futur regressions.

changes since v1:

 * improved the cover letter and the commit message of the 2nd patch to
   actually describe the bug this series is fixing


----------------------------------------------------------------------------

v1:

The ref-filter API does not correctly handle commit or tag messages that use
CRLF as the line terminator. Such messages can be created with the--verbatim 
option of git commit and git tag, or by using git commit-tree directly.

This impacts the output of git branch -v, and git branch, git tag and git
for-each-ref when used with a --format argument containing the atoms 
%(contents:subject) or %(contents:body).

The first patch in this series adds a new test library, 
t/lib-crlf-messages.sh, that contains functions to test this behaviour for
commands using either the ref-filter or the pretty API to display messages. 

The second patch fixes the bug in ref-filter.c and adds corresponding tests.

Finally, the third patch adds a test that checks the behaviour of git log in
the presence of CRLF in messages, to prevent futur regressions.

Philippe Blain (3):
  t: add lib-crlf-messages.sh for messages containing CRLF
  ref-filter: fix the API to correctly handle CRLF
  log: add tests for messages containing CRLF to t4202

 ref-filter.c             | 19 +++++++++--
 t/lib-crlf-messages.sh   | 73 ++++++++++++++++++++++++++++++++++++++++
 t/t3203-branch-output.sh | 26 +++++++++++---
 t/t4202-log.sh           | 24 +++++++++++++
 t/t6300-for-each-ref.sh  |  5 +++
 t/t7004-tag.sh           |  7 ++++
 6 files changed, 147 insertions(+), 7 deletions(-)
 create mode 100644 t/lib-crlf-messages.sh


base-commit: 076cbdcd739aeb33c1be87b73aebae5e43d7bcc5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-576%2Fphil-blain%2Ffix-branch-verbose-crlf-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-576/phil-blain/fix-branch-verbose-crlf-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/576

Range-diff vs v1:

 1:  b2521138035 = 1:  b2521138035 t: add lib-crlf-messages.sh for messages containing CRLF
 2:  c68bc2b3788 ! 2:  aab1f45ba97 ref-filter: teach the API to correctly handle CRLF
     @@ -1,26 +1,49 @@
      Author: Philippe Blain <levraiphilippeblain@gmail.com>
      
     -    ref-filter: teach the API to correctly handle CRLF
     +    ref-filter: fix the API to correctly handle CRLF
      
          The ref-filter API does not correctly handle commit or tag messages that
          use CRLF as the line terminator. Such messages can be created with the
          `--verbatim` option of `git commit` and `git tag`, or by using `git
          commit-tree` directly.
      
     -    This impacts the output of `git branch -v`, and `git branch`, `git
     -    tag` and `git for-each-ref` when used with a `--format` argument
     -    containing the atoms `%(contents:subject)` or `%(contents:body)`.
     +    This impacts the output `git branch`, `git tag` and `git for-each-ref`
     +    when used with a `--format` argument containing the atoms
     +    `%(contents:subject)` or `%(contents:body)`, as well as the output of
     +    `git branch --verbose`, which uses `%(contents:subject)` internally.
      
     -    Fix this bug in ref-filter by improving the logic in `copy_subject` and
     -    `find_subpos`.
     +    The function find_subpos in ref-filter.c looks for two consecutive '\n'
     +    to find the end of the subject line, a sequence which is absent in
     +    messages using CRLF. This results in the whole message being parsed as
     +    the subject line (`%(contents:subject)`), and the body of the message
     +    (`%(contents:body)`)  being empty.
     +
     +    Moreover, in copy_subject, '\n' is replaced by space, but '\r' is
     +    untouched, resulting in the escape sequence '^M' being output verbatim
     +    in most terminal emulators:
     +
     +        $ git branch --verbose
     +        * crlf    2113b0e Subject first line^M ^M Body first line^M Body second line
     +
     +    This bug is a regression for `git branch --verbose`, which
     +    bisects down to 949af0684c (branch: use ref-filter printing APIs,
     +    2017-01-10).
     +
     +    Fix this bug in ref-filter by hardening the logic in `copy_subject` and
     +    `find_subpos` to correctly parse messages containing CRFL.
      
          Add tests for `branch`, `tag` and `for-each-ref` using
     -    lib-crlf-messages.sh. The 'make commits' test at the beginning of
     -    t3203-branch-output.sh needs to be modified since it did not use
     -    `test_tick` and thus the commit hashes were not reproducible. For
     -    simplicity, use `test_commit` as the content and name of the files
     -    created in this setup test are irrelevant to the rest of the test
     -    script.
     +    lib-crlf-messages.sh.
     +
     +    The 'make commits' test at the beginning of t3203-branch-output.sh needs
     +    to be modified since it did not use `test_tick` and thus the commit
     +    hashes were not reproducible. For simplicity, use `test_commit` as the
     +    content and name of the files created in this setup test are irrelevant
     +    to the rest of the test script.
     +
     +    `test_cleanup_crlf_refs` is used in t3203-branch-output.sh and
     +    t7004-tag.sh to avoid having to modify the expected output in later
     +    tests.
      
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
 3:  3e5b8ace7b8 = 3:  c84092e457c log: add tests for messages containing CRLF to t4202

-- 
gitgitgadget
