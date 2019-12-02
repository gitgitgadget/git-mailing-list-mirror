Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFB1C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57923206E4
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rwCj0DSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfLBT56 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:57:58 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:33903 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfLBT56 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 14:57:58 -0500
Received: by mail-pj1-f73.google.com with SMTP id n4so558511pjb.1
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 11:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D/ocwIUUI7LgYVSlv+JA3Yuw118tv4nf6LuV3ohHQ+I=;
        b=rwCj0DSPOCu4ZcPq6wgLzxPUOzzwuWoyTg78nbcweS3JwFn8Fw6t3tLjH8qWuUk4NA
         TA80ByGqsuR5Re8fzvB46Sz/TVzErzAU289ph/AFrocWPrMkP3VsmpQOFbxjY6LYVi2S
         op6zyXLyFC+0pUKZ8p01oD/GAF2mTyYi0hJL8jiUgo3J5+WBRyJLb+KDZoPV7hZX4Ta9
         I2YzeL/9UNYcveGxgvs1yGtF9eh8CZfOcgIOGMCXfXk7JbZyq/x5ovsBclHCeFo0Xtxs
         SGTOGVUsmuNHv0vqAZKV0w+PEKKQADQdyQ4dnWIoWoSPHkSPioX83fox5Q+wtfmLtGsd
         A8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D/ocwIUUI7LgYVSlv+JA3Yuw118tv4nf6LuV3ohHQ+I=;
        b=RINQiNq+dQ2GvEzrzgouwehBiG0JfajewSap6YXEoC7bVW8cmYCbZV7cG4X0ZCm1s9
         SLX79Fu5MWPEoeR1XTZg9KsodbUcxycAZLJNtLaIZ9GN+NTElcrq0oudp+xGYXXvP++O
         zaCBj401HnvyHULooyi/USAi5OPEdoIi1F8denkqCX0kh9QjSc6geKivskDGHK+YcggE
         ROLMtRapodKQNkn5B8NFpHvmRYWS1pMukFUfoDHhKbWGMV6wS/fPXXYZ78dAvHMXZQr4
         j1g0hYNs1VYb6jmwxyMRsEQc3Q1ZtEnfc7mGbOx1IvaNZU3KI9afQ3pwbWOUMtxhRfBi
         ftMw==
X-Gm-Message-State: APjAAAVu90Y/MnJNGuICOtoG2xNeiIMDHXN+Z2VOKzSCVGcD6B64+Brd
        rROfRvefqd1XTZDH8sojrayLub6J3hw4NXU51Imaqn4M/zFaQKoWjBgpLkN852XiAqS28hJniYp
        oWWkr+k99yZFOHmuA3nKoi+26WBVn3H4XKihN09ThEhFezykMhBeKEP5Xn8em95zRQH2APKo2Vh
        dF
X-Google-Smtp-Source: APXvYqwDkwgjojgOevcfPsc8nPsU3FJ25XtxARoGZTEdaVeLRBjurdoChqJD8c/+cE6l5Vyriep0LAoXId06BFwR4mm1
X-Received: by 2002:a65:4345:: with SMTP id k5mr907205pgq.252.1575316677394;
 Mon, 02 Dec 2019 11:57:57 -0800 (PST)
Date:   Mon,  2 Dec 2019 11:57:50 -0800
In-Reply-To: <cover.1574731649.git.jonathantanmy@google.com>
Message-Id: <cover.1575316490.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1574731649.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v2 0/2] Advice upon clone --recurse-submodules --reference
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone! Here's an updated v2 following Peff's suggestions on
how to write the advice part.

Making submodule.alternateErrorStrategy default to 'info' is reasonable,
but I don't know how much it matters in practice - here,
submodule.alternateLocation was set because of "clone
--recurse-submodules --reference", which also sets
submodule.alternateErrorStrategy. I don't know when
submodule.alternateLocation would ever be set alone, but then again, I'm
not very familiar with this part. I've left that alone for now.

Jonathan Tan (2):
  Doc: explain submodule.alternateErrorStrategy
  submodule--helper: advise on fatal alternate error

 Documentation/config/advice.txt    |  3 +++
 Documentation/config/submodule.txt |  4 +++-
 advice.c                           |  2 ++
 advice.h                           |  1 +
 builtin/submodule--helper.c        | 10 ++++++++++
 5 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.24.0.393.g34dc348eaf-goog

