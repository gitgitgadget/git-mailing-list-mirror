Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3924C432C3
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 19:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA8021774
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 19:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5ea4EZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfK1TcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 14:32:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42889 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1TcW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 14:32:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so32401707wrf.9
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 11:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Z5toBR16lzVnR5kaO0XkwtjB5wYpZvbNSrmEZ/fSfMw=;
        b=m5ea4EZWtafGLs6quIGRSLfumSxRpq0t8tTt/mlw798Qso+ckxu9joydmIurARc3p0
         zZI+kv5OL6aRx5NbVSzuDf749G5E6bAw75yXfts5rvV6dLnA5qXnHmLccqQfPnhexdPQ
         d+szJFUjEKAWhwxsnYTyO9KimV7Q+7MtY1pOFkr5Sym4OhhD/oub2x5LNIVFgNKSw1vR
         rH4pwSybjjHB6wPrJgAEXCK3386cciqYcEUC8nBe4UZpRSXQTUP1OUypy5tCn8Azcp0V
         qaXFfIi8/sE9jBIzJkZlw3kRtWDy3EL7KZESTUqksKJZCqROKZnGQSY0Pf4rsZqjLHc+
         fcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z5toBR16lzVnR5kaO0XkwtjB5wYpZvbNSrmEZ/fSfMw=;
        b=IIpFDcHQ6LhEf9c4N6m80pbBt4+VxiQEAKrXygQ41r2KTd5Oqmu54Mvx+2cOsgCCW1
         AFwQiH3rcuVo4IllCxwSE7tbrK1fyIiChqzMSztR3DCNZgJb9JtADTpaxzT9/SSOaJ9f
         rnXBHldKVXtrCBU2/MJ7MQhza9AnlvYqBh06gZe5/niETfD2A3dNo4VFlOl34W8VQ3Dg
         h02MMdppjVEk6R14V8bno3Gi8ZSWCUyHI05mFAuMQi/Dr0eh5LbMZBc2olb+k8fEwfns
         tY65o7mrOEI5bh0o00JBo4sBdgkZxnA8CGcOYDYVX8S9cmpccbhdO1mIUvZzFoEgMwzF
         NFYA==
X-Gm-Message-State: APjAAAW68YsQR3SKU9eBwNMYORBf/qr/dbOplJ4fp0HkEmUkLRTHhrBL
        PnBAERamt3fhXn1qKBX8AJBCJqvY
X-Google-Smtp-Source: APXvYqxFb5ndQyNa+MdOqb9H0OeGhlebIjFyfsD8HyzcllMJ7j8g9YHspvBJ1OQBTsBrNZyxqLshRg==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr52243245wrs.288.1574969539871;
        Thu, 28 Nov 2019 11:32:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm7460109wrx.63.2019.11.28.11.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 11:32:19 -0800 (PST)
Message-Id: <pull.479.git.1574969538.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Nov 2019 19:32:13 +0000
Subject: [PATCH 0/5] parse_branchname_arg(): make code easier to understand
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

My bigger goal is to complete my --pathspec-from-file series of patches.

For this, I needed to evaluate whether parse_branchname_arg() heuristics
needs any changes when pathspec is passed, but NOT in args.

I found it surprisingly hard to reason about the code in this function. This
mostly happens due to "obfuscated" variables, where they have a clear name
and a different actual meaning. Ultimately, it was hard to mentally expand
them to true meaning AND see all possible combinations of branches at once.

I have split this refactoring in 4 patches, so that diffs are not too big in
every single patch.

To my understanding, there should be no changes in git's behavior, except
for a couple better die() messages.

Alexandr Miloslavskiy (5):
  parse_branchname_arg(): fix dash_dash_pos, drop argcount
  parse_branchname_arg(): introduce expect_commit_only
  parse_branchname_arg(): update code comments
  parse_branchname_arg(): refactor the decision making
  t2024: cover more cases

 builtin/checkout.c       | 174 ++++++++++++++++-----------------------
 t/t2024-checkout-dwim.sh |  27 ++++++
 2 files changed, 97 insertions(+), 104 deletions(-)


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-479%2FSyntevoAlex%2F%230225(git)_refactor_parse_branchname_arg-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-479/SyntevoAlex/#0225(git)_refactor_parse_branchname_arg-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/479
-- 
gitgitgadget
