Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C321FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 11:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752797AbcIDLkK (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 07:40:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34508 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbcIDLkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 07:40:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id v143so9135793wmv.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 04:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h+fWyzbHRdTHw47mKsF8F+4oMcLfNoVA4vbqajyDaYY=;
        b=ZNDoKMpx8PBM+cNqeIZk1FC49z0CFxKRVgNU2RIZ5VbLaABWUb5TK1eHNZYm420zfO
         bDd/WX6/8/H0iWEvd7jrjx48yM0SZIjITIjLTxe4G8J9JfwJKfCLkEgyfoInax8FJJLM
         /uV1pQNFfWqqkxwnJt0cu9T31oA/GN7dofcHMOLZ3o2t3igsNlEcZAMCMJu0Xc1aIlaL
         Ogvf9ErD0cKu8ia7Qa4TQxjgsInkzWJjSNDKrcjn4AT4g+LEn/UrSA75DqEp0UgUoSq4
         4PpZfH0/s3080MXip9RYQGYH0p0IZsTF85NNsWo4IEmYvmRFhlxZV2ilfroVL/uHZkXX
         e0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h+fWyzbHRdTHw47mKsF8F+4oMcLfNoVA4vbqajyDaYY=;
        b=k8lderramWY7eK0RnvK5qiX1+hB/3H70b7Rby7ycLLIXM2+lPM1OQePc2HNJqyrhZZ
         Ok2NxBgQVwNCV017B6uvN1K4EC7xPJJ4/Pt/TyhB3tz2kV9BaVaFHXetAXyblhngCQPm
         vpn43eLa4gNsaHLe8Nc2k0WyhJlde6dPk/y9UzmUEyeVRbyTV4TRGNhMN86JER6d8Q8J
         lBBzoquf6ahdMGd6QTctwr6AB9MAwymby86LJBJiAF4ytaO4kpuhaVTRkIg+Xcu0PrSQ
         ct6JomRHoSBtic81V2F/JpyOTi7ofu+Dt22tngkZuKqRVI+Afid8Gk1aSlCpR7cRtGX5
         vHAQ==
X-Gm-Message-State: AE9vXwPRoP0FBsGpSIZhWHTZi942qNsrKz8ibtPPmM2jX+GmujNE42yFiX52jYiQCUA+WA==
X-Received: by 10.28.2.84 with SMTP id 81mr10381446wmc.72.1472989207840;
        Sun, 04 Sep 2016 04:40:07 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id bc5sm14146077wjb.37.2016.09.04.04.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Sep 2016 04:40:06 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        git@vger.kernel.org,
        =?UTF-8?q?Ingo=20Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 0/4] git add --chmod: always change the file
Date:   Sun,  4 Sep 2016 12:39:50 +0100
Message-Id: <20160904113954.21697-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484
In-Reply-To: <xmqq4m5zutyc.fsf@gitster.mtv.corp.google.com>
References: <xmqq4m5zutyc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to Peff and Junio for your inputs on the best way to solve this
problem.

The patch series is made up as follows:

[1/4]: Documentation for the chmod option
[2,3/4]: Small refactoring to simplify the final step
[4/4]: The actual change that introduces the new behaviour.

Thomas Gummerer (4):
  add: document the chmod option
  update-index: use the same structure for chmod as add
  read-cache: introduce chmod_index_entry
  add: modify already added files when --chmod is given

 Documentation/git-add.txt |  7 +++++-
 builtin/add.c             | 36 +++++++++++++++++++++----------
 builtin/checkout.c        |  2 +-
 builtin/commit.c          |  2 +-
 builtin/update-index.c    | 55 ++++++++++++++++++-----------------------------
 cache.h                   | 12 ++++++-----
 read-cache.c              | 33 +++++++++++++++++++++-------
 t/t3700-add.sh            | 21 ++++++++++++++++++
 8 files changed, 107 insertions(+), 61 deletions(-)

-- 
2.10.0.304.gf2ff484

