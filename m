Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79BEC77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 01:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239697AbjELBJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 21:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjELBJG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 21:09:06 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43DA185
        for <git@vger.kernel.org>; Thu, 11 May 2023 18:09:05 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53017eb8b2eso5628925a12.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 18:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683853745; x=1686445745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UbxCbnK2nJAKH4NMWoZAd5DYP3gZlUHwXHe4AaSPlgg=;
        b=W1IIFe5iBZg+9ijTXSdSm03ny+bfbrB+4cLrUEbkIPxpxSvmP8lBrNHgdZqS1UbUdo
         /+rqEiVU1ZbRDfZ5Jm9Hl28p8AvQIWnYNsCvAxGkXQhJjYS5zfXUTpGxV+WpNtWYID35
         1ruuBJNowrfavAVHKKpfxHCwiahoqTPqLIeufr09+uYhUCGBUsOiJhroR/xPBpyk/Goc
         5/Wl2KTsQzLQiPQ3zvfJCkFrwJh4xdVtpXyJ3+qKTXvuNKjrUb7quHZUBMJsaTQWKlU0
         WpHlmGzdwwT2jvIw2iud5uARfgQGmOuGQ7YENBggDC3jsiGh8M0Bpd5Z2pHtlQAYwK/J
         4vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683853745; x=1686445745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UbxCbnK2nJAKH4NMWoZAd5DYP3gZlUHwXHe4AaSPlgg=;
        b=g+ZnIIkH7m/PjXshD+ZOl6eWyvzSWTQLWv05KHlJ+q9cp8z7ZXctVmJO7GN/HZAxPX
         S3PfLnAwZdL0vEMGXwBM4tpxyF9RUcrhgErXQ3YQXX4gExpeHzHkZ8rrPEwBpW6DY7/K
         RPg60l0yLqEIMdeuCJR7WE6YWEm1bF52nEAQIs5ZJ6POnIUh6n8pAij+WI5kSr+RgHYl
         4mYq+PvkyKWjofKOTtciVmdc6YMR1rCXW31s3rj1K41RsBd5U2QmnQ3xPbSx031TJyf1
         GEk07l1ieQ3VXZBmmOJUQ2b5YTgyLEIXNxkxdfnOT2D/YtlWcNiOJd1ncD3lrNckBR3X
         Miew==
X-Gm-Message-State: AC+VfDz9PU37gVMH36iaSqlDKhL0/cWnAIOvH1RBYBhS0ujrHnKywLtJ
        ZiM22Nk2UMYjIhaeSblXhbAQLWl31kOIYg==
X-Google-Smtp-Source: ACHHUZ4UvfBDM7YjMLhtG2zhvXdFUgPkuokIXUGySKeDOleXa2sV019dqHFEhGVVPoQrMDiUpgIcqLdvw1eq2g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:142:0:b0:530:3a7a:d8df with SMTP id
 63-20020a630142000000b005303a7ad8dfmr3238841pgb.0.1683853745365; Thu, 11 May
 2023 18:09:05 -0700 (PDT)
Date:   Thu, 11 May 2023 18:09:03 -0700
In-Reply-To: <cover.1683721293.git.ps@pks.im>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <cover.1683721293.git.ps@pks.im>
Message-ID: <kl6lcz36z780.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v5 0/9] fetch: introduce machine-parseable output
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Changes compared to v4:
>
>     - Patch 1/9: Simplified the test as proposed by Junio and Glen.
>
>     - Patch 3/9: Added a test to verify that `git fetch -c fetch.output`
>       without a value set fails as expected. Also dropped the tests that
>       checked whether stdout was empty.
>
>     - Patch 4/9: Reformulated the commit message to treat the missing
>       left-hand side of displayed references as an inconsistency instead
>       of a bug. I've also added a testcase to verify that direct OID
>       fetches continue to work as expected.
>
>     - Patch 5/9: New patch that makes calculation of the table width for
>       displayed reference updates self-contained in `refcol_width()`.
>       This is a preparatory refactoring that should make patch 6/9
>       easier to review.
>
>     - Patch 7/9: Refactored the code to parse the "fetch.output" config
>       variable inside of `git_fetch_config()` before we parse command
>       line options. Also fixed that the commit message was still
>       referring to `--output-format=porcelain` instead of the new
>       `--porcelain` switch.
>
>     - Patch 9/9: The `--porcelain` option is now a simple `OPT_BOOL()`
>       that can be negated. Added a test that `--no-porcelain` works as
>       expected.

I didn't spot any blocking issues in this version, and the various
improvements (especially 6-7/9) are really welcome. I also read through
Junio's comments, but I didn't spot anything that I thought should block
the series, so I'm happy to leave

  Reviewed-by: Glen Choo <chooglen@google.com>
