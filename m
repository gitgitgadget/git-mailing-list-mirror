Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A909F20986
	for <e@80x24.org>; Fri,  7 Oct 2016 21:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756258AbcJGVIP (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 17:08:15 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36136 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752532AbcJGVIL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 17:08:11 -0400
Received: by mail-qk0-f196.google.com with SMTP id z190so3229613qkc.3
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 14:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=iPtqgvHWO8j74+K9F71lWCG4ANk2vy3b4iiR0vB1eLo=;
        b=d3z/Y4xd6cD5cUBs5umJbBxuYFJV63ph1ijOdtAAdE34uT92MbVKGbKvvZp7j6s6/c
         30mkehIC1jfeCmkwnS5bV8ureK7DHQGtP0IsYGHTG3ueYmS+7xwUf2djsrA8hgjCib1a
         pLmjg8/YasCYsT2Xn6foMDLF+UHaNQRh9UQawxg7Q65+iFVf560yQnQy1r3NvGbSJq0z
         2SsZMrf7DAFhH6+geLHrETlA6AuFxN7AEbCpAfdbFxyc6X7t1KL5FOVEuMLvtjSy7OmG
         pZySMCfuuv2YqABOGAxSp4CT2DZ7SlhInM+onR9CzbuTlxMfunCsuL+udZhevE4Pwqft
         duwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iPtqgvHWO8j74+K9F71lWCG4ANk2vy3b4iiR0vB1eLo=;
        b=Spi9wS50w6dghKwmECdstWmnXlUr4GjMiqle8nK/DpMJTaStJMqxOG9pCgFoj1RYDV
         yqxnYYZc5cL/VVNyUjrCfZYdywxCdTAVMYJeYr3Fwm/wZQkzeDggSlQba+1ryLqiOBYW
         w6pp7xdlyUo0Ai3we/vEwV52O5KW2LTG8HfergaTxRusQkNq5H0NkK97Bz3YzpU1AHBB
         3aIZczcTrYRfg+HzDSL0wY2weP6+ERwuvnTMxNCVqi0l0OP44PJXrfG9bae9lCi/P7ZT
         F3SO28nXxvXs1uwBWc7QmY/QzUiGgw5oUpAxA+KcgIjx3bBrMcQyAjV1zoEpF3g1zDPY
         JBhg==
X-Gm-Message-State: AA6/9Rn0CToFDbDioEhn8foiH1x7YR1DV1A+nIMrhxuQDou3zWHXLiaevGO0NaM9dA66y5yB
X-Received: by 10.55.97.198 with SMTP id v189mr21188647qkb.51.1475874447062;
        Fri, 07 Oct 2016 14:07:27 -0700 (PDT)
Received: from LykOS.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-05.NATPOOL.NYU.EDU. [216.165.95.76])
        by smtp.gmail.com with ESMTPSA id a192sm7544808qkc.26.2016.10.07.14.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2016 14:07:26 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH v4 0/7] Add --format to tag verification
Date:   Fri,  7 Oct 2016 17:07:14 -0400
Message-Id: <20161007210721.20437-1-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

This is the fourth iteration of the series in [1][2][3], which comes as a
result of the discussion in [4]. The main goal of this patch series is to bring
--format to git tag verification so that upper-layer tools can inspect the
content of a tag and make decisions based on those contents.

In this re-woll we:

* Fixed the author fields and signed off by's throughout the patch
  series

* Added two more patches with unit tests to ensure the format specifier
  behaves as expected

* Fixed a missing initialization for the format specifier in verify-tag which
  caused a crash.

* Fixed an outdated git commit message that had the previous name of a
  function definition.

Thanks,
-Santiago

[1] http://public-inbox.org/git/20160930221806.3398-1-santiago@nyu.edu/
[2] http://public-inbox.org/git/20160922185317.349-1-santiago@nyu.edu/
[3] http://public-inbox.org/git/20160926224233.32702-1-santiago@nyu.edu/
[4] http://public-inbox.org/git/20160607195608.16643-1-santiago@nyu.edu/


Lukas Puehringer (4):
  tag: add format specifier to gpg_verify_tag
  gpg-interface, tag: add GPG_VERIFY_QUIET flag
  ref-filter: add function to print single ref_array_item
  builtin/tag: add --format argument for tag -v

Santiago Torres (3):
  builtin/verify-tag: add --format to verify-tag
  t/t7030-verify-tag: Add --format specifier tests
  t/t7004-tag: Add --format specifier tests

 Documentation/git-tag.txt        |  2 +-
 Documentation/git-verify-tag.txt |  2 +-
 builtin/tag.c                    | 34 +++++++++++++++++++++++-----------
 builtin/verify-tag.c             | 13 +++++++++++--
 gpg-interface.h                  |  1 +
 ref-filter.c                     | 10 ++++++++++
 ref-filter.h                     |  3 +++
 t/t7004-tag.sh                   | 16 ++++++++++++++++
 t/t7030-verify-tag.sh            | 16 ++++++++++++++++
 tag.c                            | 22 +++++++++++++++-------
 tag.h                            |  4 ++--
 11 files changed, 99 insertions(+), 24 deletions(-)

-- 
2.10.0

