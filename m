Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B037C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 17:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbjDZRyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 13:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbjDZRyt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 13:54:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5E24EF5
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 10:54:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b92309d84c1so226335276.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 10:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682531687; x=1685123687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5RCq9E112mLUmJW0R6xIkm56n9QqeBf+6yTdweGfiXM=;
        b=Uxw6zoz6iwZPqtP6aci3egVUvbwE/QGlkeN8+7DmtaqvxcZczac7OzIQRpsf8Axsov
         JkAxerQG9BmigbJtGGBwsAE4ZEfqzxwp9e70CYUWodNp/CJFG89IB0NvA50hy7Fjy2KT
         K/ChvaWlObzaGIWy8+LnNnyN2CywYVA0lrFmfaiaoXTdF2j8xvyHgSfDY0QfSIwTU6VD
         RlE2Nd7LqPaAx5ILUMpLq70zVHYzBklUtu7y93EKBIwUea27s2QMpnynwHMnOY2fyPJF
         2iJW7KgTqrltDcPeINrh1QN96Bk3FDs+1X4fsEADHRVKOYRjBf1RSJRn2xnMTKr8fTVJ
         l7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682531687; x=1685123687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5RCq9E112mLUmJW0R6xIkm56n9QqeBf+6yTdweGfiXM=;
        b=hI3g2CpqIdUa3jZtKaEL02P5TTrUphilLvHyGodKi5XSZ1pdGqYzdlbPkjUnRGKBbR
         wypy7tis0TEfJdX74EPlnmXjHxZOzQat9cDZ1INFFDKTUcftxJ6ypfvWOkK1w0zOBStB
         /t8xmft4vt6uo1EfLMu9SIckyjZW4GCtvwQo/Vf1yjvkY7iDTI0194X2BpwgWpk+668e
         +FZZ84f/P7kCb54VVj2TyObT1POreAfrcV8DEg4sGxXNqR6y2Adkhi4vC4fil+WXRLWm
         GyI619zizKsibIef78mltHJ7UTKMM+AxaW9ertyzc4vRfIGtIWGk67z3n9pxusaxbDDY
         +Rvw==
X-Gm-Message-State: AC+VfDx7OK114pefCix0YphrPZYpUisAB4C3nSPW+Jox/8bwLrfZI67Z
        d65UCVDzu8kBjLQYQep98O5PYUh+qwyTgA==
X-Google-Smtp-Source: ACHHUZ4esILjNozCHBpw6SSgzR4XfnJF+mODxrJXgw65luZRjg8rVFqK3ATHvYEnQa8ivGwyrcn7I3gCGculEQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a5b:ac5:0:b0:b8f:5b11:6d6c with SMTP id
 a5-20020a5b0ac5000000b00b8f5b116d6cmr2064045ybr.1.1682531687407; Wed, 26 Apr
 2023 10:54:47 -0700 (PDT)
Date:   Wed, 26 Apr 2023 10:54:45 -0700
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com> <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
Message-ID: <kl6lbkjao7fe.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 00/22] Header cleanups (more splitting of cache.h and
 simplifying a few other deps)
From:   Glen Choo <chooglen@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series continues to focus on splitting declarations from cache.h to
> separate headers. This series also untangles some dependencies between
> hash.h and repository.h, and between read-cache.c and tree.[ch], and cleans
> up a few other headers. At the end of this series the number of cache.h
> includes drops from 189 down to 149.

I looked over all of the patches briefly and didn't spot any issues,
though not deeply enough for a Reviewed-by.

FWIW I am quite happy with the direction of this series. I find the
result much easier to understand compared to the cache.h status quo.
