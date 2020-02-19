Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF0BC34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F52A2465D
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtPPVT0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgBSQVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:21:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33025 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgBSQVz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 11:21:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id u6so1299348wrt.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 08:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=NMWkGf4NC88+kftEWocTg4hqKKsfV4fsTobPgXX7Gto=;
        b=EtPPVT0UqYYsLjYPRYmxTmhJGSAdUG2PKIi3sdGQkCKZNmMquIFXPcoLUEamZu/VMe
         mZ9xLM7KjdAK8GWnS3vDWpDnJjeEwRg9yOrnEQCtTzO4xviz42cmdbfbphipuKUUdmPi
         XR/M17u7aF9VQxXMXkRGZwmnfUaquUSVcSYmGTfLqr6eWJYszzAnuu9UumJXmTMIsr4+
         eAjV4j7o81u/L7IXBNpdgDnTuI996voeEe0t9k7nVFHxR+CWp34AZ8qrt9DZvKeH6Hgn
         eV5wFkjptzfF32S2uAH4tp+MVN9fmvyZp9Rwn7vMnAWZQ05d6S8Cr51GN2LAov1ZEdYB
         JsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NMWkGf4NC88+kftEWocTg4hqKKsfV4fsTobPgXX7Gto=;
        b=aNSP29+vfxUlm+Zavl9U6nD7wnnbcuzct3GXdZgK5IEBnSwVjDpt3UOx9esJSrR8ZL
         c7T4y2kLvMDE1wiWN5DNe4G9juhECgyLoQIjA+s/cN6MYizcUiHJcDn+DiFftPI8biZq
         DslzwmN+xBDbO8cNFGeUFhT2xZHEjL5Xy1kPHKLWz3RJhW+Ve6N7Z5dqu2GDHSUMgIvS
         6pnXp1C2KPR5JQrj69dMx0btSRYRN1hckquqdvSfcxucKtWBPYX4k5WOsDjxmuACFUM1
         i8IhizuBT/68oDsBPh1WHHvGfQS2z/+vpr7T8j6TCi1CCxvtDSpvPfBQpQOI385Qa0/A
         J87g==
X-Gm-Message-State: APjAAAUZnlcEuZ+eUGUzi6Y+bnGtTtSKIBnwyuWQ2U2MNAoVJAcWKoJC
        THgImNKXotCsi5NeNcwRUf2obhDg
X-Google-Smtp-Source: APXvYqwXuFRiKQ7gJkS9KXK4b1IZ1duKGaU0Kjl16OjFNuj1Evm6wqgIC4PTI6NsG2qUu3BLX1rq0g==
X-Received: by 2002:a5d:6390:: with SMTP id p16mr38265800wru.170.1582129313624;
        Wed, 19 Feb 2020 08:21:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18sm321767wru.50.2020.02.19.08.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 08:21:52 -0800 (PST)
Message-Id: <pull.556.git.1582129312.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Feb 2020 16:21:50 +0000
Subject: [PATCH 0/2] Document two partial clone bugs, fix one
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, jonathantanmy@google.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While playing with partial clone, I discovered a few bugs and document them
with tests in patch 1. One seems to be a server-side bug that happens in a
somewhat rare situation, but not terribly unlikely. The other is a
client-side bug that leads to quadratic amounts of data transfer; I fix this
bug in patch 2.

Thanks, -Stolee

Derrick Stolee (2):
  partial-clone: demonstrate bugs in partial fetch
  partial-clone: avoid fetching when looking for objects

 builtin/fetch.c          | 10 +++++-----
 t/t5616-partial-clone.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 5 deletions(-)


base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-556%2Fderrickstolee%2Fpartial-clone-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-556/derrickstolee/partial-clone-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/556
-- 
gitgitgadget
