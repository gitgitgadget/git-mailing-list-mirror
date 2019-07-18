Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725AC1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 19:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391107AbfGRTGF (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 15:06:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42839 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbfGRTGE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 15:06:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so13031404pff.9
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 12:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9kYs2m36NE0lcFIiceG/cNx3oI2eQsdNyxpNcuzqgx4=;
        b=m0KTKiLd74fIgnW/AAtE5Kf1LUIKHHLeKRZmCjx8SYczWyZVqTQZVALMnVkkavDsq0
         GBaNP36JfeqSRMT9GeNsrQDz+5DvzCU8yRkocjdodxIOQbH043aOAf7SDaNd81004yX0
         3pWhk5QN5+nnPbmENwMHq7eCemPI2+9vUoyfSeBVxxek4h6/tQWj7d+7QOBi7VZ2BnJE
         d7H73dseko1zKOt4xxm0b1joILF6tHskgwWTX1xFUaYjaEAjuGVhMB6PxkiY+2X46D30
         3fF1+v8zdv4HEuXtg6Es5uV+zPmcHFSXTCZhb2cu85wE2lJtmOxIWSfLjmt6zC2Z6amh
         fRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9kYs2m36NE0lcFIiceG/cNx3oI2eQsdNyxpNcuzqgx4=;
        b=MjusGBk9oL5IWx7seGVW/llvwTAZ2kuTNPgwOX7hyjVh2ZRuCgKNwK+wowsWQzn8GB
         dq3gfnIodCTrHMJ1yZuzYrn2kRPz7DcdfftljAoX9KA0HXWaZIW9+GDcMlE4wBzjc7XU
         jwiGo+Y9Rw4Jl/yAS8qASeZbEUEJkBBflXgwy7o5Hvd11/NsXngVNtzfwoSYfx5rOiCq
         8GgL/yUYv9iPznbT7Y7nIkahTfjyRjT1dwugtZX/ynSQ7lgQRj5f9pepPyA/xzBmYFOr
         F/fVMqNBNe/+o8yw+61M61szV8Yxif4p/IFxOPqKv4DtM+ZP6JyA7/aRJR3liNLQFA4+
         9Hmw==
X-Gm-Message-State: APjAAAXpACeyjQG03Qo5FWdkLMsMHPmrTaSER6Ff+EG9j09fFrYmwhYr
        F7i5rnygFaAYqgC6dcL+QnX+gzTuJxQ=
X-Google-Smtp-Source: APXvYqwliM8BtExpNMyE1cphuOyR+m6IBexbSK/IZw7Z9HZAHD3bTDEh+dRy7tvSXS8sphn6SwX1aw==
X-Received: by 2002:a63:d448:: with SMTP id i8mr30178333pgj.173.1563476763714;
        Thu, 18 Jul 2019 12:06:03 -0700 (PDT)
Received: from ar135.iitr.local ([27.63.78.254])
        by smtp.gmail.com with ESMTPSA id f88sm28237555pjg.5.2019.07.18.12.05.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 12:06:02 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     Rohit <rohit.ashiwal265@gmail.com>
Cc:     Dscho <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio <gitster@pobox.com>, Martin <martin.agren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>
Subject: [GSoC][PATCH v2 0/2] rebase -i: support --committer-date-is-author-date
Date:   Fri, 19 Jul 2019 00:33:12 +0530
Message-Id: <20190718190314.20549-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190712185357.21211-1-rohit.ashiwal265@gmail.com>
References: <20190712185357.21211-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Another revision to keep this thread alive.

Rohit Ashiwal (2):
  sequencer: add NULL checks under read_author_script
  rebase -i: support --committer-date-is-author-date

 Documentation/git-rebase.txt            |  7 ++-
 builtin/rebase.c                        | 23 +++++++--
 sequencer.c                             | 62 +++++++++++++++++++++++--
 sequencer.h                             |  1 +
 t/t3422-rebase-incompatible-options.sh  |  1 -
 t/t3431-rebase-options-compatibility.sh | 21 +++++++++
 6 files changed, 103 insertions(+), 12 deletions(-)

Range-diff:
1:  6d2a5a382d ! 1:  a1bb91fe43 rebase -i: add --ignore-whitespace flag
    @@ -85,6 +85,15 @@
      		OPT_STRING(0, "strategy", &opts.strategy, N_("strategy"),
      			   N_("rebase strategy")),
      		OPT_STRING(0, "strategy-opts", &opts.strategy_opts, N_("strategy-opts"),
    +@@
    + 	argc = parse_options(argc, argv, NULL, options,
    + 			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
    + 
    ++	opts.strategy_opts = xstrdup_or_null(opts.strategy_opts);
    ++
    + 	if (!is_null_oid(&squash_onto))
    + 		opts.squash_onto = &squash_onto;
    + 
     @@
      	am.git_cmd = 1;
      	argv_array_push(&am.args, "am");
2:  3e6a67410c = 2:  597d282fa6 sequencer: add NULL checks under read_author_script
3:  3d5f2e2960 ! 3:  33cfc0f890 rebase -i: support --committer-date-is-author-date
    @@ -262,14 +262,20 @@
      	test_cmp expect file
      '
      
    -+test_expect_success '--committer-date-is-author-date works with interactive backend' '
    ++test_expect_success '--committer-date-is-author-date works with am backend' '

    It is implied that --force-rebase will change the committer date.
    We can add a test (somewhere else) that will check so, but that will
    be moot IMO.

     +	git rebase -f HEAD^ &&
    ++	git rebase --committer-date-is-author-date HEAD^ &&
     +	git cat-file commit HEAD | sed -e "/^\$/q" >head &&
     +	sed -ne "/^author /s/.*> //p" head >authortime &&
     +	sed -ne "/^committer /s/.*> //p" head >committertime &&
    -+	! test_cmp at ct &&
    ++	test_cmp authortime committertime
    ++'
    ++
    ++test_expect_success '--committer-date-is-author-date works with interactive backend' '
    ++	git rebase -f HEAD^ &&
     +	git rebase -i --committer-date-is-author-date HEAD^ &&
     +	git cat-file commit HEAD | sed -e "/^\$/q" >head &&
    ++	sed -ne "/^author /s/.*> //p" head >authortime &&
     +	sed -ne "/^committer /s/.*> //p" head >committertime &&
     +	test_cmp authortime committertime
     +'
-- 
2.21.0

