Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD07F1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 01:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeBBBrn (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 20:47:43 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52576 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeBBBrl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 20:47:41 -0500
Received: by mail-wm0-f68.google.com with SMTP id g1so9515161wmg.2
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 17:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GGsJW4uc7JoLCp3QgpblDSn4Tbt+0vyB7vdZXAWaxOY=;
        b=HjdgWg8rdmfppegALjJIOO4KosgrHoOFZvcF4uCMgENmyl7rEdSPCFg7H729dr02Ia
         InSi5hbgQn2sPmpQugb2Cjdd5OLn0v43mqfiCmxcDmcJpULnF2Xm+u0NYpdPN6eBhuWq
         DxlI7jaeE026pahBuZxurVe3oN7/gH/ehLM8XtjYZAgxWzAp7iSUrkeaDhPX4d+UUNvv
         VZfhV4u8Wdi0i3LAHmyoIZyA69BOtllDcCAA8cVVOnW9vZ6WwyZohcD8//oafTvb3SY+
         c2bsb6ypYCOG0GzzzFGHbKRY3EHl7dTb9BXKntz+bKeDlhj6sQMYLFXzFcI4FARS0nWU
         T73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GGsJW4uc7JoLCp3QgpblDSn4Tbt+0vyB7vdZXAWaxOY=;
        b=lHD52qaRXOgxFABweDRrE7wLQvR65zpMqr6H6lJVIzChHc4QRIht8ArJgcz4kr0O9o
         hseQfQGy5d37x8vV3/NJHaxZrorY+SDFEuyCRSCUjyJii9lAmFijDtMwZ8eF8QJLB9Zd
         em8+DvhTESG9WgVGTxVA3F9y8DIWJ7MK+pVBBh3NMjNQBZvM8M07hHNMVrY3TfTlcAU+
         sxeAmlQiG1Rd9Tq5oYD2kdP1X+KEyvLopkgkrtL0Q+Z8N7kvsgE1UiexwNViv8JKUhp9
         RIoQjnyz0YkNd7z1uXTwmJNBBa2SfW9lFq7gSdLN649XjfQCvvhsqDUUOovXJxkaayJD
         W5nQ==
X-Gm-Message-State: AKwxyteWCHI7PP/PwF/Z5DqIqbnNrh7r/OIlm73XNyeBREYw5Ui1FHkf
        b1ECrKIxSOwmiLJdUk3NnPo=
X-Google-Smtp-Source: AH8x227zsSYORKGgQq58vPxpUy1Sxe8rECZLI4yDNjcAdBE5p6d4sw2vAXnOTkjr9L4EXlVqSzbTeQ==
X-Received: by 10.28.29.81 with SMTP id d78mr30381920wmd.65.1517536060814;
        Thu, 01 Feb 2018 17:47:40 -0800 (PST)
Received: from localhost.localdomain (x4db049fc.dyn.telefonica.de. [77.176.73.252])
        by smtp.gmail.com with ESMTPSA id h16sm674199wre.43.2018.02.01.17.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 17:47:40 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH v2 05/14] commit-graph: implement git-commit-graph --write
Date:   Fri,  2 Feb 2018 02:47:28 +0100
Message-Id: <20180202014728.30907-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <1517348383-112294-6-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com> <1517348383-112294-6-git-send-email-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> new file mode 100755
> index 0000000000..6bcd1cc264
> --- /dev/null
> +++ b/t/t5318-commit-graph.sh
> @@ -0,0 +1,96 @@
> +#!/bin/sh
> +
> +test_description='commit graph'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup full repo' \
> +    'rm -rf .git &&
> +     mkdir full &&
> +     cd full &&
> +     git init &&
> +     git config core.commitgraph true &&

This config variable is unknown at this point.
I think the test shouldn't set it before it's introduced in patch 10.

> +     git config pack.threads 1 &&
> +     packdir=".git/objects/pack"'


> +test_expect_success 'setup bare repo' \
> +    'cd .. &&
> +     git clone --bare full bare &&
> +     cd bare &&
> +     git config core.graph true &&

Likewise, and its name should be updated as well.

> +     git config pack.threads 1 &&
> +     baredir="objects/pack"'
