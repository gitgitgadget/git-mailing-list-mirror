Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BED6420357
	for <e@80x24.org>; Mon, 17 Jul 2017 20:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbdGQULX (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 16:11:23 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33689 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdGQULW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 16:11:22 -0400
Received: by mail-lf0-f66.google.com with SMTP id t72so26263lff.0
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 13:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QAk8WnaTfXD/T0rtRXJ6D9wvRAQ3g1Pfw6wQBn+Ci1k=;
        b=kmiRFnKnYVqqZT01BvueBFmOVRXIZQwXxjCByaKB3F+zc0awwM3AOfd79zSZDE1rn1
         k9BWMecpTpzy2xSatB1HAvYKuydIu47eyUJHaDIqWFACjU5pLfEXyUcmJiZDYdmGq1u4
         zC80vMpo6+iY0nVS15RaUH+0MUMd0ApTFuSnmX5EGeHtIlSZImYCatoeBVf7qi8unOOT
         XSu1F/H4ig8FeWdfrXUlT7MV4U5aWdcxf6fpfPxcnzuaoWIHDKwLCmkuIL8Q2t6r7ExX
         IwYVo1+yInIbssAfQ9ZnVZAbIh5uPcXFvokxKngm4MD5qpY/BwlLnK36/TaVQ3mA3dEX
         4H3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QAk8WnaTfXD/T0rtRXJ6D9wvRAQ3g1Pfw6wQBn+Ci1k=;
        b=N8f8/mokuh//Sv9Zm1zi2zWZbWjBz0tpBoEY5OCqugGbr/Qq5jzuG0WvallQECoCuf
         KwneRWKt0k5Mjz/koGUAAna8+TayYbtRFruT/7PrE42WAnASIe/qbEH61Xoah5EsBgox
         xOMpT+nJBzWWMcgYrekpCdfQFddtPRVqcY9rvc6u3Yz97LldKSImh/Sbis41L6r0Un5d
         vQN6cmoOZN1fXInRmBxcfK+bVQAgSQeP/+b2aVBY98FauhJ2tdSPv8QDIivtMSqwedEd
         uuOzNSCtWxoJlJNYTzvRq0DRHqfiVlpD4U0d0pZMDgkN1zO1cnEbtBWcaT38IusQDYjY
         7POg==
X-Gm-Message-State: AIVw113/mYKEkE770BNwyE8xvhRuh0JwNkCrpilaT2SzioR0TRMggowT
        7I9Sb0DPHKq8HYai
X-Received: by 10.25.77.213 with SMTP id a204mr7830676lfb.121.1500322280884;
        Mon, 17 Jul 2017 13:11:20 -0700 (PDT)
Received: from localhost.localdomain (c83-248-253-33.bredband.comhem.se. [83.248.253.33])
        by smtp.gmail.com with ESMTPSA id l12sm30752ljb.39.2017.07.17.13.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 13:11:19 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 00/10] tag: only respect `pager.tag` in list-mode
Date:   Mon, 17 Jul 2017 22:10:42 +0200
Message-Id: <cover.1500321657.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc0
In-Reply-To: <cover.1499723297.git.martin.agren@gmail.com>
References: <cover.1499723297.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second version of "[PATCH 0/7] tag: more fine-grained
pager-configuration" [1]. That series introduced `pager.tag.list` to
address the fact that `pager.tag` can be useful with `git tag -l` but
actively hostile with `git tag -a`. Thanks to Junio, Peff and Brandon
for helpful feedback.

After that feedback, v2 drops `pager.tag.list` and instead teaches
`git tag` to only consider `pager.tag` in list-mode, as suggested by
Peff.

Patches 1-3/10 replace patch 1/7. They move Documentation/technical/
api-builtin.txt into builtin.h, tweak the formatting and bring it up to
date. I may have gone overboard making this 3 patches...

Patches 4-7/10 correspond to patches 2-5/7. `setup_auto_pager()' is now
much simpler since we do not need to handle "tag.list" with a clever
fallback strategy. IGNORE_PAGER_CONFIG is now called DELAY_PAGER_CONFIG.
I now check with pager_in_use() and I moved the handling of `pager.tag`
a bit further down.

Patches 8-9/10 teach `git tag` to only respect `pager.tag` in list-mode
and flip the default value for that config to "on".

Patch 10/10 is somewhat similar to a hunk in patch 2/7, but is now a
bug-fix instead of a feature. It teaches `execv_dashed_external()` not
to check `pager.foo` when launching `git-foo` where foo is a builtin.
I waffled about where to put this patch. Putting it earlier in the
series as a preparatory step, I couldn't come up with a way of writing a
test. So patch 8/10 introduces a `test_expect_failure` which this patch
then fixes.

Martin

[1] https://public-inbox.org/git/cover.1499723297.git.martin.agren@gmail.com/T/

Martin Ågren (10):
  builtin.h: take over documentation from api-builtin.txt
  builtin.h: format documentation-comment properly
  builtin.h: document SUPPORT_SUPER_PREFIX
  git.c: let builtins opt for handling `pager.foo` themselves
  git.c: provide setup_auto_pager()
  t7006: add tests for how git tag paginates
  tag: handle `pager.tag`-configuration within the builtin
  tag: respect `pager.tag` in list-mode only
  tag: change default of `pager.tag` to "on"
  git.c: ignore pager.* when launching builtin as dashed external

 Documentation/git-tag.txt               |  3 +
 Documentation/technical/api-builtin.txt | 73 -------------------------
 t/t7006-pager.sh                        | 85 +++++++++++++++++++++++++++++
 builtin.h                               | 97 +++++++++++++++++++++++++++++++++
 builtin/tag.c                           |  3 +
 git.c                                   | 18 +++++-
 6 files changed, 203 insertions(+), 76 deletions(-)
 delete mode 100644 Documentation/technical/api-builtin.txt

-- 
2.14.0.rc0

