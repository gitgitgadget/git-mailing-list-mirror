Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC43C2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 20:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0A4206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 20:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ounSOO/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLZUtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 15:49:10 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40179 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZUtK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 15:49:10 -0500
Received: by mail-ed1-f68.google.com with SMTP id b8so23685940edx.7
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 12:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=p792pXrXfHCcmEWej8oH5oGjt/tYiOLHX1k0K/0gnn8=;
        b=ounSOO/v3953mnb6JV8o5nzXSBC3PFTgnSCYq5OfYXZDFS7idfJNEWCjRZ8I8n4EB+
         tk2refROtASLhLTvtP1vKzOVuv0TshkTvOCq2JGREHGaZiO0UxY5BpEYVZZlWs0XHMPW
         qpz8z8t920ubHZXz/YOD8AgQq+S+Ifxf3AdbR7glEZUt481qzJLMz0qfb0cHf/8nLPSK
         bkZUoGVFJhIQ3FE5Ir765svFdiPFVVigdGmkd9J6w/d/xgj45pL7tzxQnmi8XwsAorJc
         zL9AYAM27/455B2sIuwbaRsyn6XT/c0ZWVfI4zQJgZoYPZ5eg5bNcCWzshziDL1HmpV9
         Furg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p792pXrXfHCcmEWej8oH5oGjt/tYiOLHX1k0K/0gnn8=;
        b=BZvWA3dRdTPG2RWLVDdRnUwjWP6zZaKp29GYtxJRkYruK9UQui7+GyQrn/Jigg7w4f
         paZjrqCO42OWN6BNQ0BCyo5OLepZB7kNv7hDvnxvjGOifcbpZW3A3cg5ohfFIkzj8YVx
         4ofYLma+4SJ+p6HEvrw1ySAc1wATvo0DzXuCfhqa3+MDPCTwAx9YxhMITrC7s/D3/L7K
         iA6ZdpMK8wgCReNhuefy+G5XYfWc9repFlAuf+vbKHoqJYIac9mF5sGenUPvszCg7Ywu
         rzHZSOt+nKZMuvoeyyxo2H+9+TrhhoCwGODN4KLt5NL/ZfNqbt78/ptQ4DkW76hQEr1M
         tVTQ==
X-Gm-Message-State: APjAAAUCW6GH6ESjRx99dBdcFFUhDy9x4NZRzgMLeZyDNAV9ymtFyL8D
        UHGxd5vbikcX4DvEmdG9fYX7lyDL
X-Google-Smtp-Source: APXvYqwnrOsP5FcB12xvtHCrpn38eoOeB6NC6JVutuYADckprZHuqSIjxv+tat7Jr1XM/JZTvGk/hA==
X-Received: by 2002:a17:906:eb8b:: with SMTP id mh11mr49836194ejb.72.1577393348710;
        Thu, 26 Dec 2019 12:49:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p24sm3775184eds.17.2019.12.26.12.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Dec 2019 12:49:08 -0800 (PST)
Message-Id: <pull.500.git.1577393347.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Dec 2019 20:49:06 +0000
Subject: [PATCH 0/1] sparse-checkout: list directories in cone mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When in cone mode, "git sparse-checkout set" takes a list of folders and
constructs an ordered list of patterns for the sparse-checkout file. The
"git sparse-checkout list" subcommand outputs the contents of the
sparse-checkout file in a very basic way.

This patch changes the behavior of "git sparse-checkout list" when
core.sparseCheckoutCone=true. It will output the folders that were used in
"git sparse-checkout set" to create the patterns, instead of the patterns
themselves.

I believe this was requested in the initial review, but I cannot find that
message now.

I was going to include this as part of a longer follow-up series, but I
think this may be worth considering for the 2.25.0 release. Hence, it is
included by itself.

Thanks, -Stolee

Derrick Stolee (1):
  sparse-checkout: list folders in cone mode

 Documentation/git-sparse-checkout.txt | 11 ++++++++++-
 builtin/sparse-checkout.c             | 21 +++++++++++++++++++++
 t/t1091-sparse-checkout-builtin.sh    | 11 +++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)


base-commit: 761e3d26bbe44c51f83c4f1ad198461f57029ebd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-500%2Fderrickstolee%2Fsparse-checkout-list-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-500/derrickstolee/sparse-checkout-list-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/500
-- 
gitgitgadget
