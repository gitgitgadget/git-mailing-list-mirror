Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B40CD202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 19:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932872AbdJ3Tqx (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 15:46:53 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:54615 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932597AbdJ3Tqw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 15:46:52 -0400
Received: by mail-io0-f195.google.com with SMTP id e89so29829984ioi.11
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 12:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X/siDRp3mt2O0JebahXVQC3YLtsz36wU36/HyNE9lXw=;
        b=uhGbKXdylYGJUBC1wgjY8Nn9NIB+SC8zlcSvKn44Fmf8ICShk+rjkVUz2kWG2MyL3X
         I+FuDbz9XEHPNCSf5edNoqboPqp6yMyaVfNocbiFf891UOrT7YWo+SOKwiLBq/tYwcNq
         zrZ85/rJP7sMT8MiYqmJLCyjgBeI9n4U2Gl5Rxus1s1iD1fs0GvzrYizLAxZqW5z51Eh
         14dkSHg/NT2ixld1uMl2Px+usRxoQonFHRx+enOjFJFGtPqeLp7i+1s5+iwDKhRSdOpv
         wS/cDo6lgpcwdUe5APpu5Jtx+q0ut16hMkZdLfEoCglxKF6uRKIAGaALmipphF2poke4
         ywLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X/siDRp3mt2O0JebahXVQC3YLtsz36wU36/HyNE9lXw=;
        b=pRTLkyZpDq1TvcfTk6Q1M+KGpACuJroVMrJh2nnL6oC0AXtpa1FxrPxgbzMgkRQbL0
         yapUplJx0SV1P736I04trZmqNGmwZH1UqphNhhFjLtQm4kSKtgYQWLHVxp7TNZLcvNhW
         HL+s4FVOkqC736+JQfrlyRC35kNMIJkFoY2nfXYllycA26EaQCghC1lB4Glnibfo3+nS
         zpetRX4ASgD2SX56aEfItR/eP6QaEJIMsxIlRLB1MvVnbNMTJ//hdoAHB/z6eSAz6JyX
         MQYQrMXT5eg1dn15KtX0puAqif5qWljisTow4ElpbIgy3tppk0vCvR4k/FPkoGipMkX3
         W21g==
X-Gm-Message-State: AMCzsaVdrk5I89MP9E7M6VZvMhmmx7PYT+gZ3LF01+TmPrdVFmZa56lt
        KR3UIW0ojf0HNnO5W14K/NTs+jkBrgw=
X-Google-Smtp-Source: ABhQp+RiS/HXOnCJtYnUVQa8Jkn0uIRgg9rIvzUYpHf70/Abh7o2mNWp9q+l5onMF0tcDFn5DvyOiQ==
X-Received: by 10.36.86.137 with SMTP id o131mr7656141itb.7.1509392811696;
        Mon, 30 Oct 2017 12:46:51 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g195sm2372805itc.14.2017.10.30.12.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 12:46:50 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 0/4] convert diff flags to be stored in a struct
Date:   Mon, 30 Oct 2017 12:46:42 -0700
Message-Id: <20171030194646.27473-1-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6-goog
In-Reply-To: <20171027222853.180981-1-bmwill@google.com>
References: <20171027222853.180981-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2:
 * removed the diff_flags_cleared singleton 
 * eliminated the 'touched' parallel flags
 * pass structs by reference instead of by value

Now that the 'touched' flags have been removed it may be valuable to go ahead
and remove the macros all together (including making the flags lower case).  If
that's what we want to do, I can go ahead and send those patches out as a
follow on to these.

Brandon Williams (4):
  add, reset: use DIFF_OPT_SET macro to set a diff flag
  diff: convert flags to be stored in bitfields
  diff: add flag to indicate textconv was set via cmdline
  diff: remove touched flags

 builtin/add.c    |  2 +-
 builtin/commit.c |  7 +++--
 builtin/log.c    |  3 +-
 builtin/reset.c  |  2 +-
 diff-lib.c       |  7 +++--
 diff.c           | 10 +++---
 diff.h           | 96 +++++++++++++++++++++++++++++++++-----------------------
 sequencer.c      |  5 +--
 8 files changed, 77 insertions(+), 55 deletions(-)

-- 
2.15.0.403.gc27cc4dac6-goog

