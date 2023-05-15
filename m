Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1F7C77B7D
	for <git@archiver.kernel.org>; Mon, 15 May 2023 12:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbjEOMNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 08:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjEOMNi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 08:13:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617F41BFD
        for <git@vger.kernel.org>; Mon, 15 May 2023 05:13:17 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f509ec3196so27305475e9.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 05:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684152795; x=1686744795;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NV2c52ix0VCHwc6+GRolfyQZ3N1gdd7GYK30TP+9nHM=;
        b=p103Zpy9YM6c6wRXHDpCmwH6Gu26fAmp/myABpWNheTqt5mG0FYqM8+Qrxkvg+DR6T
         yHY/gRvNDxVNlDxE83R0clYY8S85b298Th6i9WAivrw4X1yJW5CfHWvOOUJ7yyTR4DPm
         SCDVzyHzO1/e4AYsjmaE31j3PtC9BLg/ZvyDXDoFT+iI7RE+g0t6X88jK5RkSQhEEOny
         qYLXGTRmQUhQxUwqu2kszevnJA71HMMiLV+fwpq4BXbdjxN/eHuZoGebYuhXdGfJMgnN
         vR2PTx+Uk76drs9Vxi2GilOF3i8ipuVS6ya3AmqpZMk3AwJ8+iay7hvTlO6HJjbHQ513
         HZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684152795; x=1686744795;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NV2c52ix0VCHwc6+GRolfyQZ3N1gdd7GYK30TP+9nHM=;
        b=DRPcwbBrCMTVkYJVqLmvHPQewGEvVcl4XEQd/7MxoMh9FrAu/+jh8AeTmfxuIxFqB4
         D8buNi/Y5A5X7ZxI+dhe8gJp9GMtVSkoDjtWanXuCBOtNmrtvy4EQHy0TCNOKNAgCDai
         i2elLMb54j5hx1t6CzVDpH5ItFTvHn+1Ptxbna3vN2vnUvBOR2ZGMmJFFZtbu3qHdtSF
         0nUU8VhFYhBWNwqsQBoVlJ8L2Ua4rP/fTHz8mR+9SmKZwKO1he8grM+27ziiIheCN6kn
         pYXwQX7u+iHaNct4tRlz2GWlXPpLmGaJRi505JITyytsioNV/P+FMS82vM8lgTrNtpVT
         v/rw==
X-Gm-Message-State: AC+VfDzRuAC9WP4/wnIxgDJcJ448O3B0FCnJPD3/8BG1YpN0qUkmX/in
        QFJM86PfTaxKgv08/Mf0M1McbudEZ2M=
X-Google-Smtp-Source: ACHHUZ4DJ0rf2q7tybHskxYeAgUVUrFRA5URb1FtTN2fpqhjTocJxrm+T1aLVy0gGfS017fPcsozPA==
X-Received: by 2002:a1c:f202:0:b0:3f3:3cba:2f2d with SMTP id s2-20020a1cf202000000b003f33cba2f2dmr26056453wmc.7.1684152794784;
        Mon, 15 May 2023 05:13:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c020700b003f42e008c8dsm17320063wmi.44.2023.05.15.05.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:13:14 -0700 (PDT)
Message-Id: <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
In-Reply-To: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
References: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 May 2023 12:13:07 +0000
Subject: [PATCH v3 0/6] Document the output format of ls-remote
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This iteration incorporates the feedback from v2 with additional patches to
explain examples and remove redundant ones. These patches are of course
explained in the commit messages, but they're in response to actual
conversation [https://github.com/git/git/pull/1471#issuecomment-1547726140]
that I cannot seem to actually respond to for unknown technical reasons.

A bit off-topic: for the past few months, I have been having some serious
trouble interacting with this list via the usual means
[https://github.com/git/git/pull/1471#issuecomment-1547726140] and would
appreciate anyone may be able to diagnose the issue. I will be reaching out
to the site/list owners as a first step (having exhausted my own
investigation, of course). If you have any ideas, please feel free to email
me directly / off-list or leave a comment on GitHub if you are so inclined
-- I of course don't want this to become a support thread. I'd much rather
keep conversation here to the topic of getting these patches merged :-)

Junio C Hamano (1):
  show-branch doc: say <ref>, not <reference>

Sean Allred (5):
  show-ref doc: update for internal consistency
  ls-remote doc: remove redundant --tags example
  ls-remote doc: show peeled tags in examples
  ls-remote doc: explain what each example does
  ls-remote doc: document the output format

 Documentation/git-ls-remote.txt   | 46 +++++++++++++++++++++++--------
 Documentation/git-show-branch.txt | 16 +++++------
 Documentation/git-show-ref.txt    | 40 +++++++++++++++++----------
 3 files changed, 68 insertions(+), 34 deletions(-)


base-commit: 950264636c68591989456e3ba0a5442f93152c1a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1471%2Fvermiculus%2Fsa%2Fdoc-ls-remote-output-format-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1471/vermiculus/sa/doc-ls-remote-output-format-v3
Pull-Request: https://github.com/git/git/pull/1471

Range-diff vs v2:

 1:  4408b518810 ! 1:  fe442c2041b Update show-ref documentation for internal consistency
     @@ Metadata
      Author: Sean Allred <allred.sean@gmail.com>
      
       ## Commit message ##
     -    Update show-ref documentation for internal consistency
     +    show-ref doc: update for internal consistency
      
          - Use inline-code syntax for options where appropriate.
          - Use code blocks to clarify output format.
      
     -    This patch also swaps out 'SHA-1' language for the
     -    implementation-agnostic 'OID' term where appropriate in preparation for
     -    supporting different hashing algorithms.
     +    This patch also swaps out 'SHA-1' language for the implementation-
     +    agnostic 'OID' term where appropriate in preparation for supporting
     +    different hashing algorithms.
      
          Signed-off-by: Sean Allred <allred.sean@gmail.com>
      
     @@ Documentation/git-show-ref.txt: OPTIONS
      +The output is in the format:
      +
      +------------
     -+<OID> SP <reference name> LF
     ++<oid> SP <ref> LF
      +------------
      +
      +For example,
 -:  ----------- > 2:  cd51a70f3ff show-branch doc: say <ref>, not <reference>
 -:  ----------- > 3:  8b644fb1203 ls-remote doc: remove redundant --tags example
 -:  ----------- > 4:  dc0c5ba1751 ls-remote doc: show peeled tags in examples
 -:  ----------- > 5:  94380984533 ls-remote doc: explain what each example does
 2:  44e79f0d69c ! 6:  de57b8aa563 Document the output format of ls-remote
     @@ Metadata
      Author: Sean Allred <allred.sean@gmail.com>
      
       ## Commit message ##
     -    Document the output format of ls-remote
     +    ls-remote doc: document the output format
      
          While well-established, the output format of ls-remote was not actually
          documented. This patch adds an OUTPUT section to the documentation
          following the format of git-show-ref.txt (which has similar semantics).
      
     +    Add a basic example immediately after this to solidify the 'normal'
     +    output format.
     +
          Signed-off-by: Sean Allred <allred.sean@gmail.com>
      
       ## Documentation/git-ls-remote.txt ##
     @@ Documentation/git-ls-remote.txt: OPTIONS
      +The output is in the format:
      +
      +------------
     -+<OID> TAB <reference name> LF
     ++<oid> TAB <ref> LF
      +------------
      +
     -+For example,
     ++When `<ref>` is a tag, it may be followed by `^{}` to show its peeled
     ++representation.
      +
     + EXAMPLES
     + --------
     + 
     ++* List all references (including symbolics and pseudorefs), peeling
     ++  tags:
     +++
      +----
      +$ git ls-remote
     ++27d43aaaf50ef0ae014b88bba294f93658016a2e	HEAD
      +950264636c68591989456e3ba0a5442f93152c1a	refs/heads/main
     -+73876f4861cd3d187a4682290ab75c9dccadbc56	refs/heads/maint
      +d9ab777d41f92a8c1684c91cfb02053d7dd1046b	refs/heads/next
     -+74a0ffe000da036ce4ca843d991a7c6b8c246a08	refs/heads/seen
     -+860bc4360c4fcba0fe2df942984d87f8467af3df	refs/heads/todo
      +d4ca2e3147b409459955613c152220f4db848ee1	refs/tags/v2.40.0
     -+8810a79228a149a9773bf9c75f381fca27a6a80e	refs/tags/v2.40.0-rc0
     -+f899c182d0bffb6e915da7c8db9be202b144c098	refs/tags/v2.40.0-rc1
     -+6bed3304b2b2f1cf440ca3050b57a7cf3a3fe687	refs/tags/v2.40.0-rc2
     ++73876f4861cd3d187a4682290ab75c9dccadbc56	refs/tags/v2.40.0^{}
      +----
      +
     - EXAMPLES
     - --------
     - 
     + * List all references matching given patterns:
     + +
     + ----

-- 
gitgitgadget
