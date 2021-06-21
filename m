Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D78C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 18:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEFA0606A5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 18:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhFUSVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 14:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhFUSVh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 14:21:37 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3D7C008689
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 11:05:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r5so31708058lfr.5
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 11:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pNhxdxlge9TCcE82PBLkNa78P8DGxIXPm3NNJGhjvW8=;
        b=Z6F7Wm1JbF/PJBwuRKNthslQOfKAXtaqTKaz2SR4njSFk3NbX+QgnlQIWy/qEZuq84
         wof2Zg277hlxecf8XvzmHR3qj/iNNV7whda4zZDAVOrrj02KhkQKWs5NpYnHpsuCVzQG
         tpy2AhjCqbBJGT4v4wP4cM3nCcHy22phHMT29lGNLf685qQOAlYFYC9U3oty6JJ5j8tG
         NyV0Y+XPsp7EDidlCE96GltYzeXOadt6Er68nAQGgKmN75cHGNTmdq/6Wzu1OjxhSc3p
         mfg+0B+OmOA0HFfuuPbQfWo088QSkIDL6fZIt071gSyyrp8xPhy7d0WIDV9tpCNdabBR
         BDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNhxdxlge9TCcE82PBLkNa78P8DGxIXPm3NNJGhjvW8=;
        b=nPhDkvxMzHpMms7Es/Xy6dz2QXPsGw0dt1hUdZFAvq8qwTHVM7DSCd2DqSJ47BXskK
         AvJnREaecmvVaH+RrMvWjcBu5sCZApLOhBP3blgsQaoVwg1G9ebmgbwGBThGINjtCjEM
         xhJPP10AVLbBLLdiD7V7R2uRF0PfEIvXTuANgfKVeWUIT3IJlfWvSGRtA8Igu+64pKjQ
         XaOdYfYiAnAQlgQyE9VB7t8QM6FKaTU81ljS+rmWuzh2uLj3lLGGNcFQUlU1SWLYzx1t
         Cgeb3xlIhUqK3TJEa763X6onJpxQErkxGTXVH/0iQ3nzDuUgcH+3YNXKdqLXffBcKV9i
         SjOg==
X-Gm-Message-State: AOAM5309wOWWqVt60imtfX3srb8Txz/D9iOTc0ikCDelMEZ0hMszVO2Z
        T+8/oFe0l9Gsg1dU+GwWt6gpsFMaWUkBacfr0PU=
X-Google-Smtp-Source: ABdhPJwfRvUd6k3sh33zz8N0dfno7whKGtwjAi43uU16kyA8tJDLTHexwa6IEJFXVxT7Jc43P4NOIOEtg5fB91rEqoA=
X-Received: by 2002:a19:7414:: with SMTP id v20mr14065064lfe.203.1624298752419;
 Mon, 21 Jun 2021 11:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210621175234.1079004-1-felipe.contreras@gmail.com> <20210621175234.1079004-3-felipe.contreras@gmail.com>
In-Reply-To: <20210621175234.1079004-3-felipe.contreras@gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 21 Jun 2021 12:05:41 -0600
Message-ID: <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 11:52 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> +                "If unsure, run \"git pull --no-rebase\".\n"

I don't think the message should recommend merging over rebasing;
which strategy is the correct one depends entirely on the project's
workflow and the user's role within that workflow. The eventual goal
is to get rid of the default here and make the user make an educated
choice, which does imply some work on the user's part, but it avoids
the massive headaches created by users merging without understanding
what they're doing.

-Alex
