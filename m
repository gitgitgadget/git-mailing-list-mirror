Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181C8C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 19:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AE4206CB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 19:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Keb2Rl9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfL3TPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:15:32 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46796 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfL3TPc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 14:15:32 -0500
Received: by mail-ed1-f66.google.com with SMTP id m8so33580745edi.13
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 11:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2PPJYFLSOFXyV8z5snwSG9Rw1Fs+otAUKysyXnqxUOY=;
        b=Keb2Rl9y73HbR9uwNKkEFKv5YDydnsfW/ZmOB51R09mPdCMBEiAXGoXUqm7gDjZdz6
         2X2x7j4QS0nVaKDmECfdBqq6+hJ+o5WB9IeyPutCqynBFe0iHgV9g4MUTSCHmHBhl4pb
         lrDrwzUfWD1+md1WeVcg5OBU8s9o4d6AqTF9NyKtRT92N6P/V1LDwHVpzQrME2kvIowQ
         LFOE5FyxW2WASbhTr5fAgpgCOd78fDTsE1uA3rab8s0y48g0hWvlOGMyKfjLG6to4izU
         5ExkEMINcZBGQQhfIbKZHtykCmVMNsxsSSXCc3igzAsR1e8qn670phq3PXkuyNq0QzGL
         1Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2PPJYFLSOFXyV8z5snwSG9Rw1Fs+otAUKysyXnqxUOY=;
        b=Untx9dCiR82yFgR8iDfAZlaVE8y/FkZB/l9Q8EuXu0I8rM1okxIkRVGqblQfneVNTz
         In3bnZf1U0w17u6X1TPdfyssRotzqputyDjrDN21gqaOlsL26cs2sDfrQhrOjLSDnf8e
         h2p2Vuat3N0WHrtBowopht0vaMNVpcEQA1rfWLSbjop56cWLpsbCn6KvC+v/9JlKk2gt
         c3MVHqESRrIxn2O7uJ0tn4jlUNwIDsFG8RJRfQTcGdkni2Pht0uBjikMaWAoHABwB92j
         5fd/1MTSOTtJM3KQE2Za9ndeKC5BAevTY/9vIInkVLlpJOzOllGMHbboYN4QJw8W5rQ/
         VyYA==
X-Gm-Message-State: APjAAAV+4aJ0QDl6WvA/9jZ/yhMwJMxJGvGgSHfSjUQtUsaxxnPSd0Ra
        K05vYXqw5jtMB5eJnQiii5tbPF5j
X-Google-Smtp-Source: APXvYqwGBpuOKO1HdHb0eoafcK+EGLTWhdgV67cWclgb5r31l60AldOmP1vYB4ZvHENeRLdUAnY2/w==
X-Received: by 2002:a17:906:2894:: with SMTP id o20mr72349473ejd.199.1577733330680;
        Mon, 30 Dec 2019 11:15:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id by2sm5693797ejb.45.2019.12.30.11.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 11:15:30 -0800 (PST)
Message-Id: <pull.503.v2.git.1577733329.gitgitgadget@gmail.com>
In-Reply-To: <pull.503.git.1577727747.gitgitgadget@gmail.com>
References: <pull.503.git.1577727747.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Dec 2019 19:15:25 +0000
Subject: [PATCH v2 0/3] t: rework tests for --pathspec-from-file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please refer to commit messages for rationale.

This branch is a follow-up for [1] where part of branch was merged into `master` via [2].

Previously in [3] there were some concerns on whether removing
copy&pasted tests is good. I still think that yes, it 's a good thing,
mostly because of high volume of potential 13*6=78 duplicate tests.

Still, I separated this change as last patch, so that the remaining
part of the branch can be taken without it.

[1] https://lore.kernel.org/git/pull.490.git.1576161385.gitgitgadget@gmail.com/
[2] https://public-inbox.org/git/pull.445.v4.git.1575381738.gitgitgadget@gmail.com/
[3] https://lore.kernel.org/git/xmqqwoatcn5u.fsf@gitster-ct.c.googlers.com/

Changes since V1
----------------
Small code formatting changes suggested in V1.

Alexandr Miloslavskiy (3):
  t: fix quotes tests for --pathspec-from-file
  t: directly test parse_pathspec_file()
  t: drop copy&pasted tests for --pathspec-from-file

 Makefile                            |   1 +
 t/helper/test-parse-pathspec-file.c |  33 +++++++++
 t/helper/test-tool.c                |   1 +
 t/helper/test-tool.h                |   1 +
 t/t0067-parse_pathspec_file.sh      | 104 ++++++++++++++++++++++++++++
 t/t2026-checkout-pathspec-file.sh   |  70 +------------------
 t/t2072-restore-pathspec-file.sh    |  70 +------------------
 t/t3704-add-pathspec-file.sh        |  70 +------------------
 t/t7107-reset-pathspec-file.sh      |  79 +++------------------
 t/t7526-commit-pathspec-file.sh     |  70 +------------------
 10 files changed, 156 insertions(+), 343 deletions(-)
 create mode 100644 t/helper/test-parse-pathspec-file.c
 create mode 100755 t/t0067-parse_pathspec_file.sh


base-commit: 0a76bd7381ec0dbb7c43776eb6d1ac906bca29e6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-503%2FSyntevoAlex%2F%230207(git)_2b_test_parse_directly-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-503/SyntevoAlex/#0207(git)_2b_test_parse_directly-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/503

Range-diff vs v1:

 1:  ab9519298d = 1:  6193dc7396 t: fix quotes tests for --pathspec-from-file
 2:  27383a5b08 ! 2:  ab449ac15a t: directly test parse_pathspec_file()
     @@ -55,9 +55,8 @@
      +	parse_pathspec_file(&pathspec, 0, 0, 0, pathspec_from_file,
      +			    pathspec_file_nul);
      +
     -+	for (i = 0; i < pathspec.nr; i++) {
     ++	for (i = 0; i < pathspec.nr; i++)
      +		printf("%s\n", pathspec.items[i].original);
     -+	}
      +
      +	clear_pathspec(&pathspec);
      +	return 0;
     @@ -99,84 +98,99 @@
      +. ./test-lib.sh
      +
      +test_expect_success 'one item from stdin' '
     -+	echo fileA.t | test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
     -+
      +	cat >expect <<-\EOF &&
      +	fileA.t
      +	EOF
     ++
     ++	echo fileA.t |
     ++	test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
     ++
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'one item from file' '
     -+	echo fileA.t >list &&
     -+	test-tool parse-pathspec-file --pathspec-from-file=list >actual &&
     -+
      +	cat >expect <<-\EOF &&
      +	fileA.t
      +	EOF
     ++
     ++	echo fileA.t >list &&
     ++	test-tool parse-pathspec-file --pathspec-from-file=list >actual &&
     ++
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'NUL delimiters' '
     -+	printf "fileA.t\0fileB.t\0" | test-tool parse-pathspec-file --pathspec-from-file=- --pathspec-file-nul >actual &&
     -+
      +	cat >expect <<-\EOF &&
      +	fileA.t
      +	fileB.t
      +	EOF
     ++
     ++	printf "fileA.t\0fileB.t\0" |
     ++	test-tool parse-pathspec-file --pathspec-from-file=- --pathspec-file-nul >actual &&
     ++
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'LF delimiters' '
     -+	printf "fileA.t\nfileB.t\n" | test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
     -+
      +	cat >expect <<-\EOF &&
      +	fileA.t
      +	fileB.t
      +	EOF
     ++
     ++	printf "fileA.t\nfileB.t\n" |
     ++	test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
     ++
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'no trailing delimiter' '
     -+	printf "fileA.t\nfileB.t" | test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
     -+
      +	cat >expect <<-\EOF &&
      +	fileA.t
      +	fileB.t
      +	EOF
     ++
     ++	printf "fileA.t\nfileB.t" |
     ++	test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
     ++
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'CRLF delimiters' '
     -+	printf "fileA.t\r\nfileB.t\r\n" | test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
     -+
      +	cat >expect <<-\EOF &&
      +	fileA.t
      +	fileB.t
      +	EOF
     ++
     ++	printf "fileA.t\r\nfileB.t\r\n" |
     ++	test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
     ++
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'quotes' '
     ++	cat >expect <<-\EOF &&
     ++	fileA.t
     ++	EOF
     ++
      +	# shell  takes \\\\101 and spits \\101
      +	# printf takes   \\101 and spits  \101
      +	# git    takes    \101 and spits     A
     -+	printf "\"file\\\\101.t\"" | test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
     ++	printf "\"file\\\\101.t\"" |
     ++	test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
      +
     -+	cat >expect <<-\EOF &&
     -+	fileA.t
     -+	EOF
      +	test_cmp expect actual
      +'
      +
      +test_expect_success '--pathspec-file-nul takes quotes literally' '
     -+	# shell  takes \\\\101 and spits \\101
     -+	# printf takes   \\101 and spits  \101
     -+	printf "\"file\\\\101.t\"" | test-tool parse-pathspec-file --pathspec-from-file=- --pathspec-file-nul >actual &&
     -+
      +	cat >expect <<-\EOF &&
      +	"file\101.t"
      +	EOF
     ++
     ++	# shell  takes \\\\101 and spits \\101
     ++	# printf takes   \\101 and spits  \101
     ++	printf "\"file\\\\101.t\"" |
     ++	test-tool parse-pathspec-file --pathspec-from-file=- --pathspec-file-nul >actual &&
     ++
      +	test_cmp expect actual
      +'
      +
 3:  daef256db3 = 3:  88086cebce t: drop copy&pasted tests for --pathspec-from-file

-- 
gitgitgadget
