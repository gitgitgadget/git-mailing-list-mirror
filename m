Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEBFC43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 18:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiGFSRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 14:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbiGFSRG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 14:17:06 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADC6C61
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 11:17:05 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id g2-20020a17090a128200b001ef7dea7928so6863097pja.1
        for <git@vger.kernel.org>; Wed, 06 Jul 2022 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=6ekkc4zYQsXNWQH6JVItBxgBucbdArqekRA0vrl+Rfc=;
        b=WcTAzdYwj7OF7WA18ZybdmVFNha69JCUOdPDSt+/pY9aR1qMrGeY1Tnt6jve2OEYfT
         4LQ4TN95XQzuC2oWzhQxgM4lZPXezUnadZnyFao0KBugxTuOF1jbHSaJQ6QoHE0kV1lT
         SvpIkjGYbUzJb2aajfyL6YUsmbslY3q58b2cCIfE3163HmxTG9hvm7ySaBdJ1xDRPHYQ
         f9euGR3M0JY6+xqSbcIZLryj7CzxjDwYj1POuDdwGMUw9iEUWA0H2dz+eStdRJcP0Ozu
         mjcd4HWSZOUGl6oWrAnepDFPSO9voQRchTo/Gz/BtD1r2NAWEL3GcmYZ4x0BIB4tgCi9
         y+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=6ekkc4zYQsXNWQH6JVItBxgBucbdArqekRA0vrl+Rfc=;
        b=Mf3Ok/TG5ShzBFR9N/QAE1iqwKXfUrF5VgjHFX1afnG+8tXp1ytRiL0jmQUCq9GgTp
         DVAeaQQvoC0ucNFRmTmEpBY0hSqRKecReUQgIZdoCyEMxJAqI31biQqsmQIwzlu3NnN/
         zA+Hruks6uyuwcq7+WMlYYxgg4DWzKEx7wSeE3P+cH3iodYifmHxVAcPphjnoCyEu8yH
         wSCTR1GL/ylffrfpZHqHUwUwmT9B+CrFE7AdNrKFslDe8m3HGZK7pULub+XgfMJZBDp9
         yF17JBN0dQDxqdAmC2VFh8l6pUdshuK9OZMq7D6GOT6PymmlKdWgfiZowewE4JNPhWAe
         PIfg==
X-Gm-Message-State: AJIora/mW6+7hRVWpwTeGZaY6vfWiY6TxktYEYnYBWEJKJNtc1NUVQng
        1SVISQ8RM3oRokjeyyyFP64WteETk5OxCf7AQCLh
X-Google-Smtp-Source: AGRyM1vIRRR1W+2mddceRQy45fIkokqJUE9xHJxKyED6eNft2N14xKkIsmFpT58iidDrOPmfv8DCvT2MHzWAjKknQ2XL
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with
 SMTP id t9-20020a17090a024900b001e0a8a33c6cmr119pje.0.1657131424453; Wed, 06
 Jul 2022 11:17:04 -0700 (PDT)
Date:   Wed,  6 Jul 2022 11:17:00 -0700
In-Reply-To: <YsVAfudoUA5YkQWH@coredump.intra.peff.net>
Message-Id: <20220706181701.277193-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: Re: [PATCH 0/3] cloning unborn HEAD when other branches are present
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:
> +cc Jonathan Tan. Definitely not your bug, as the behavior has been this
> way forever. But this is very adjacent to your empty-repo unborn head
> work from 4f37d45706 (clone: respect remote unborn HEAD, 2021-02-05),
> and I think harmonizing a related case.

Thanks for the patch. Indeed, this is a similar problem, and worth
fixing in the same way.

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
