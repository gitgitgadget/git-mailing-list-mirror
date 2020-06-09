Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22383C433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 19:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EF02076A
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 19:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO2TTnbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgFITdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgFITdk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 15:33:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9903FC05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 12:33:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e12so17320200eds.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 12:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4g638HqqSaaOaq16OWBqJc/vpig+vIsgE0/h6pyQ8qo=;
        b=PO2TTnbGZGXrWPwLi6V3ZN0lgs6zjGMiZ+FAdGwdlMGhDXkhICoe4IxlQGPcDPp+db
         LP8tGfLapAy96A53zLLTx8liTSDkZ5wUCIxwumog08ZUamH863XVcQ1IoEyF6dvYqeC1
         KGcIRWoLsF66i4so9SmcNU6rZFynVxT3UagW+kjEEEOoBk3eYCdsfSZHSZrVTJ9m+6Io
         AtbZjWPrkvOjf8yM532vpdtyMQCsOvyxYuxBtULaN7VQWL0303P+7uMHQGvs3W9rnpok
         CqtHuqsWHQT8QMf1N5+fI/RQi5q4mC6ECxdDN4vkIjkTE+fASVdelj9UA8W4YoBGOC3I
         tUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4g638HqqSaaOaq16OWBqJc/vpig+vIsgE0/h6pyQ8qo=;
        b=clmr69y3b/3nOnXw5MG4rpTcXKiyu7/bGT7UlPZjww4FOeej/Rjw23WpMYG5n6+K3p
         kyHAY8+3K3WcP6D8YEft9mZ2y+0VvqAPo2+pu++BZbGhpOc5rvX5EUqQ685J/Kh0Jkvq
         YrMJKaxwVhbV9zMtE3wncXvIA3Mf3V9gcHFEeTaTQfptGw3QKN02rDjKwt0nRgUGfXcY
         y1pAIDDTSrKRCX3KwZwD8oxpKZ5zoXjjrYFBKNLAZWQl4nU/jdKOfgDA6tNAjeOAkcYw
         HHfQwxMLKuT9hxLfjmeqp5YhuhpDKQHc6lHTBD5t4BX0SaafAWxCuuVAjuHPxHEXjYJs
         ecjg==
X-Gm-Message-State: AOAM530kNXC+u/nJ/k/3o/u+nCYGVmAU4POSeAj4MxaRkPYJzGgeB0MM
        pdpq1UUkSqsJ7gcR3pLMYqqND0uU0+mcwmytcxdPoJxlSsM=
X-Google-Smtp-Source: ABdhPJyEoZqgFYe2fX9Dr+6gTxZEehRlO/cSQgKLjkH65XMA/ts9Wqa/YqqLcz8pCHZ1twhENlcePqKUmEqnj6fkt+c=
X-Received: by 2002:a50:951d:: with SMTP id u29mr29377850eda.333.1591731216353;
 Tue, 09 Jun 2020 12:33:36 -0700 (PDT)
MIME-Version: 1.0
From:   Brian Malehorn <bmalehorn@gmail.com>
Date:   Tue, 9 Jun 2020 12:33:00 -0700
Message-ID: <CAJB88a39G-GkGu1LuRE8na45Pav_cWb3cJLQFJM+FuW3BnromA@mail.gmail.com>
Subject: git stash --include-untracked walks ignored directories
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Not sure if this is the right place to send this, but I'm here to
report a performance regression with git stash --include-untracked.

Here's a quick way to reproduce:

1. make a directory with a lot of ignored files

$ find ignored -type f | wc -l
   50000

$ cat .gitignore
ignored

2. touch foo

3. time git stash --include-untracked

git version 2.26.0:
real    0m0.094s

git version 2.27.0.83.g0313f36c6e:
real    0m1.913s

This is a much bigger pain point on my work repo, which has 1.4
million ignored files(!). As you can imagine it takes a long time to
run git stash. While it might be valid to question why anyone would
need that many files for any purpose, the bottom line is that I told
git to ignore this directory, and it didn't ignore it.

In the meantime I've reverted to 2.26.0 which doesn't have this
performance regression. Let me know if you want any other information
related to this issue.

Thanks,
Brian
