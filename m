Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4763EB64DB
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 02:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242562AbjFOCx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 22:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbjFOCx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 22:53:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAABD26A9
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f642a24568so9802330e87.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686797632; x=1689389632;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO03rot0BlsDELtkzrAdxk7Lq+mlCn/cubaz0xOz1Uo=;
        b=SGrPOBdYtEGLtFJndUs7pdFlXEp9PnwqY9pBqBnxiyCbOtecuZo5RPMbKqBiIqVrhQ
         XIUqH7ZeqWF7VNLYT2s5lmi5qWv4SbCneZtlnr8lq68M3ywK5I7Fi3Ia834JqH93K6cx
         yBPXnQiRR2pCspQtGTIRM3uJ9mCRP5k6Q3hl2d2BrHsD7aoB3XPGSaY70To4Xm1j1i5O
         Pi+NqGmzwqn2jy5/yy970c8jas8xWEX42Vezqw3pfWrJzuo75SiDw9Fg+e6ZPhdxPeVI
         KuYtoXYhbsh4cmEzZenpyfcCT0kwau6zMTZTpu/caaXSvs/mserSO4lfMlUXkiJ/Y3ct
         ZQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686797632; x=1689389632;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vO03rot0BlsDELtkzrAdxk7Lq+mlCn/cubaz0xOz1Uo=;
        b=EHDsnxNrQfLzXuZDjmrhYgYFWtErvavqi2XTYzmBSdxMpfR5FQJPqJ1HVFf32+gouV
         Oigie5PyV2HAlja8UFDSlKuYlS7rueGJoERbG+fnJtVbrm2HeuUMCjpHriaQvoaG6jRZ
         wpmVqmCFGqvtXx++HZp5Nw708I5D1KUtDrD2UZVlQBMsefDA1L9V7Xh3FJJt63U9mjjg
         yEvUdqzIUdAE9d47jNDwCCVrZlawKzowQNqxB84TZ1gG0eIgyd7aJlGxLmuw3Qi4fBFt
         zeXyo7TVWyQSDI43BJH9IcUiKP1PpjjhX3SucAUVO5Achh62dkyZANTKLijqjovRgwjx
         lY1g==
X-Gm-Message-State: AC+VfDyNgKf/xRFCitOt0ts5yHeQJ85z5QApgUpO/Hg7c58wTV6tXAuq
        SAvlbRAVHbwjNT+zhlsnLzdmpAOJLC0=
X-Google-Smtp-Source: ACHHUZ5h0b3O7e8dVkDgqUpBwR/cGsJ0tohhTJ52jaDV+WT6tGPcyWZYRF9eJskND6rWqAiKQz7nsg==
X-Received: by 2002:a05:6512:606:b0:4f7:6b17:e1e8 with SMTP id b6-20020a056512060600b004f76b17e1e8mr1396871lfe.1.1686797631400;
        Wed, 14 Jun 2023 19:53:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c228b00b003f7361ca753sm18917044wmf.24.2023.06.14.19.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 19:53:50 -0700 (PDT)
Message-Id: <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
References: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jun 2023 02:53:41 +0000
Subject: [PATCH v4 0/9] docs: interpret-trailers: reword and add examples
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes some small improvements to the docs for
git-interpret-trailers. The intent is to make it easier to read for
beginners who have never used this command before.


Updates in v4
=============

 * vs Patch v3 3/9: Reworded a sentence to avoid ambiguity with the word
   "ignored".
 * vs Patch v3 4/9: Replaced "Lorem ipsum..." in favor of "body text" which
   is shorter and more obvious (and search-friendly).
 * vs Patch v3 8/9: Expanded the explanation about 'trailer..key' and its
   convenience, instead of only stating how to use this option.


Updates in v3
=============

 * Rebased on top of "master" at fe86abd751 (Git 2.41, 2023-06-01). The only
   conflict was in Patch v2 4/9
   (https://lore.kernel.org/git/783a0b1e00309e9bcf13494908d99317df72f0d6.1683839975.git.gitgitgadget@gmail.com/),
   because cbb83daeaf (doc: interpret-trailers: fix example, 2023-05-01)
   added the "subject/message" style for the examples that did not have any
   message text in them. These examples' additional message lines have been
   replaced with Lorem ipsum... like the others in Patch v2 4/9.


Updates in v2
=============

In order of significance:

 * The phrase "commit message part" has been removed.
 * The word "message" is always used as part of the bigger phrase "commit
   message".
 * Deprecation language for trailer.<token>.command has been updated to
   minimize whitespace churn, while also tweaking the 2nd paragraph to
   reduce duplication.
 * The phrase "Lorem ipsum..." is always only used to stand in for the body
   paragraph(s) of a commit message.
 * Grammar fixes have been squashed together (01+06 previously).

Linus Arver (9):
  doc: trailer: fix grammar
  doc: trailer: swap verb order
  doc: trailer: drop "commit message part" phrasing
  doc: trailer: examples: avoid the word "message" by itself
  doc: trailer: remove redundant phrasing
  doc: trailer: use angle brackets for <token> and <value>
  doc: trailer.<token>.command: emphasize deprecation
  doc: trailer: mention 'key' in DESCRIPTION
  doc: trailer: add more examples in DESCRIPTION

 Documentation/git-interpret-trailers.txt | 134 +++++++++++++----------
 1 file changed, 78 insertions(+), 56 deletions(-)


base-commit: fe86abd7511a9a6862d5706c6fa1d9b57a63ba09
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1506%2Flistx%2Fdoc-trailer-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1506/listx/doc-trailer-v4
Pull-Request: https://github.com/git/git/pull/1506

Range-diff vs v3:

  1:  7d504700b91 =  1:  7d504700b91 doc: trailer: fix grammar
  2:  65386432ca4 =  2:  65386432ca4 doc: trailer: swap verb order
  3:  e0a56c8e61d !  3:  3c85477d791 doc: trailer: drop "commit message part" phrasing
     @@ Documentation/git-interpret-trailers.txt: Add or parse 'trailer' lines that look
      +This command can also operate on the output of linkgit:git-format-patch[1],
      +which is more elaborate than a plain commit message. Namely, such output
      +includes a commit message (as above), a "---" divider line, and a patch part.
     -+For these inputs, the divider and patch parts are ignored, unless `--no-divider`
     -+is specified.
     ++For these inputs, the divider and patch parts are not modified by
     ++this command and are emitted as is on the output, unless
     ++`--no-divider` is specified.
       
       Some configuration variables control the way the `--trailer` arguments
      -are applied to each commit message and the way any existing trailer in
  4:  52f7d29f509 !  4:  6b4cb31b170 doc: trailer: examples: avoid the word "message" by itself
     @@ Documentation/git-interpret-trailers.txt: EXAMPLES
       subject
       
      -message
     -+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     ++body text
       $ git interpret-trailers --trailer 'sign: Alice <alice@example.com>' --trailer 'sign: Bob <bob@example.com>' <msg.txt
       subject
       
      -message
     -+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     ++body text
       
       Signed-off-by: Alice <alice@example.com>
       Signed-off-by: Bob <bob@example.com>
     @@ Documentation/git-interpret-trailers.txt: EXAMPLES
       subject
       
      -message
     -+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     ++body text
       
       Signed-off-by: Bob <bob@example.com>
       $ git interpret-trailers --trailer 'Acked-by: Alice <alice@example.com>' --in-place msg.txt
     @@ Documentation/git-interpret-trailers.txt: EXAMPLES
       subject
       
      -message
     -+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     ++body text
       
       Signed-off-by: Bob <bob@example.com>
       Acked-by: Alice <alice@example.com>
     @@ Documentation/git-interpret-trailers.txt: $ git interpret-trailers --trailer 'Cc
       subject
       
      -message
     -+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     ++body text
       $ git config trailer.sign.key "Signed-off-by: "
       $ git config trailer.sign.ifmissing add
       $ git config trailer.sign.ifexists doNothing
     @@ Documentation/git-interpret-trailers.txt: $ git config trailer.sign.cmd 'echo "$
       subject
       
      -message
     -+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     ++body text
       
       Signed-off-by: Bob <bob@example.com>
       $ cat msg2.txt
       subject
       
      -message
     -+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     ++body text
       
       Signed-off-by: Alice <alice@example.com>
       $ git interpret-trailers --trailer sign <msg2.txt
       subject
       
      -message
     -+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     ++body text
       
       Signed-off-by: Alice <alice@example.com>
       ------------
     @@ Documentation/git-interpret-trailers.txt: test -n "$1" && git log --author="$1"
       subject
       
      -message
     -+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     ++body text
       $ git config trailer.help.key "Helped-by: "
       $ git config trailer.help.ifExists "addIfDifferentNeighbor"
       $ git config trailer.help.cmd "~/bin/glog-find-author"
     @@ Documentation/git-interpret-trailers.txt: test -n "$1" && git log --author="$1"
       subject
       
      -message
     -+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     ++body text
       
       Helped-by: Junio C Hamano <gitster@pobox.com>
       Helped-by: Christian Couder <christian.couder@gmail.com>
     @@ Documentation/git-interpret-trailers.txt: test -n "$1" && git log --grep "$1" --
       subject
       
      -message
     -+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     ++body text
       $ git config trailer.ref.key "Reference-to: "
       $ git config trailer.ref.ifExists "replace"
       $ git config trailer.ref.cmd "~/bin/glog-grep"
     @@ Documentation/git-interpret-trailers.txt: test -n "$1" && git log --grep "$1" --
       subject
       
      -message
     -+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     ++body text
       
       Reference-to: 8bc9a0c769 (Add copyright notices., 2005-04-07)
       ------------
     @@ Documentation/git-interpret-trailers.txt: Reference-to: 8bc9a0c769 (Add copyrigh
       subject
       
      -message
     -+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     ++body text
       
       see: HEAD~2
       $ cat ~/bin/glog-ref
     @@ Documentation/git-interpret-trailers.txt: $ git config trailer.see.cmd "glog-ref
       subject
       
      -message
     -+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     ++body text
       
       See-also: fe3187489d69c4 (subject of related commit)
       ------------
  5:  4a2a0e41e4a =  5:  a4a2ed16dcc doc: trailer: remove redundant phrasing
  6:  f99545409dc =  6:  7a96d0705b9 doc: trailer: use angle brackets for <token> and <value>
  7:  6aba774489a =  7:  f67458a3660 doc: trailer.<token>.command: emphasize deprecation
  8:  b13bd73d248 !  8:  604265c54df doc: trailer: mention 'key' in DESCRIPTION
     @@ Documentation/git-interpret-trailers.txt: token: value
       
       This means that the trimmed <token> and <value> will be separated by
      -`': '` (one colon followed by one space).
     -+`': '` (one colon followed by one space). If the <token> should have a different
     -+string representation than itself, then the 'key' can be configured with
     -+'trailer.<token>.key'.
     ++`': '` (one colon followed by one space). For convenience, the <token> can be a
     ++shortened string key (e.g., "sign") instead of the full string which should
     ++appear before the separator on the output (e.g., "Signed-off-by"). This can be
     ++configured using the 'trailer.<token>.key' configuration variable.
       
       By default the new trailer will appear at the end of all the existing
       trailers. If there is no existing trailer, the new trailer will appear
  9:  ec43e192d6e =  9:  1a3755eacbe doc: trailer: add more examples in DESCRIPTION

-- 
gitgitgadget
