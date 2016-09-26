Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55DF4207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 22:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754005AbcIZWmu (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 18:42:50 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36219 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbcIZWms (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 18:42:48 -0400
Received: by mail-qk0-f194.google.com with SMTP id m184so4646465qkb.3
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 15:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=fr0HVPwY8jUwiEeJ4w5mcAfMs/3+v/nTPHuznQ+UyLM=;
        b=hGQ937EXfpZnKMvtCbaMk6HO9Le/PzgL/YIRksltgdh1AGLqCNyX5nhbMdjv7Bm3/H
         Wgp12p5pnz9IWxPGi7U1s/7tUpQVyyaAhA2XNIhiIzUoUm4jbPK1gtuRZSQMX+b2h4+N
         gUS6m36FyeAIgs65yG+WY7XzTQ+eE7vYqd6nyXv90UFroWuDUqmLmSaDrRP/6s6uSH8s
         5XLQ2Hvp4uSa2fR9YkexvnJfnkNZBxk4O7WJZXR1UDIYo1/h/ws6ciMiMItXGO/1uVWM
         rfosJ29xHFhW0Z1arN3//Y+88Aop1G+6t35sc7kH0drO5kmbXPp6saH/jem/dWTPIVbH
         SiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fr0HVPwY8jUwiEeJ4w5mcAfMs/3+v/nTPHuznQ+UyLM=;
        b=ZzzgFwJWHzsXwFsGMwa+MEhQdeBZLaWA5t1o0VKW3XScJElqPqZg6bKtb+P1BNvMsG
         e2xBZJhPH4zrwyIWaJtLgoAxVx0/pKqYzD4k55CQOay4lvl6V6hgFXdX2+bqDg7ziWPi
         YWIeTxyGWt0Qv3dLSPgc4B2bFZJzcxtywrC1jW1gh7/nBUfg/sXUR6ltonwJAp3xm1GR
         K1S0ggP2KKRhuQUe00Y89WXZ/56aV7eIs3OLfC8EfljAx3bEbjTz12GNF4kHfTc9u42L
         +YncEZEdl/Av3oWzDHHP2DagaQ91ZzXRhRGAKy7F2Calo/l0T13eGQq1jeh8EoLQxVjM
         /jpA==
X-Gm-Message-State: AA6/9Rka6P42OeZWNfOYQuTFGVB6fZQ0LLDbsvUy9gdGfxzAddgf3yysKFQ6Fhw+jJcMt5DK
X-Received: by 10.55.214.27 with SMTP id t27mr2306469qki.272.1474929767727;
        Mon, 26 Sep 2016 15:42:47 -0700 (PDT)
Received: from LykOS.localdomain (cpe-74-65-203-27.nyc.res.rr.com. [74.65.203.27])
        by smtp.gmail.com with ESMTPSA id 62sm12840092qtg.14.2016.09.26.15.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Sep 2016 15:42:46 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH v2 0/5] Add --format to tag verification
Date:   Mon, 26 Sep 2016 18:42:28 -0400
Message-Id: <20160926224233.32702-1-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

This is the second iteration of [1], and as a result of the discussion
in [2].

In this re-roll we:

* Dropped the commit to move the format string parameter to a global
  variable on builtin/tag. We had to change the signature of
  for_each_name_fn to do this.

* Fixed the signed-off-by lines to match the author/committer

[0001]
* Moved the GPG_VERIFY_QUIET flag check into tag.c instead of
  gpg_interface

[0002] 
* Changed the exported function to "format_ref". This way, we can print
  a single formatted ref element. This also made the patch
  cleaner/easier to read.

[0003] 
* We fixed style/formatting errors that we had introduced

This patch applies to 2.10.0 and master.

[1] http://public-inbox.org/git/20160922185317.349-1-santiago@nyu.edu/
[2] http://public-inbox.org/git/20160607195608.16643-1-santiago@nyu.edu/

Lukas P (4):
  gpg-interface, tag: add GPG_VERIFY_QUIET flag
  ref-filter: add function to print single ref_array_item
  tag: add format specifier to gpg_verify_tag
  builtin/tag: add --format argument for tag -v

Santiago Torres (1):
  builtin/verify-tag: add --format to verify-tag

 builtin/tag.c        | 30 ++++++++++++++++++++----------
 builtin/verify-tag.c | 16 ++++++++++++++--
 gpg-interface.h      |  1 +
 ref-filter.c         | 10 ++++++++++
 ref-filter.h         |  4 ++++
 tag.c                | 22 +++++++++++++++-------
 tag.h                |  4 ++--
 7 files changed, 66 insertions(+), 21 deletions(-)

-- 
2.10.0

