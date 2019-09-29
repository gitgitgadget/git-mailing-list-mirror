Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A80401F463
	for <e@80x24.org>; Sun, 29 Sep 2019 20:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfI2UKr (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 16:10:47 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45140 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfI2UKr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 16:10:47 -0400
Received: by mail-lf1-f66.google.com with SMTP id r134so5412360lff.12
        for <git@vger.kernel.org>; Sun, 29 Sep 2019 13:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4SdIERZA+OnVBqptBnjRNah42jIah+k74ssVYRemZyU=;
        b=nEr6/cN8dHRBM07DmtcaVS/Xb5tsjWVSBBbTW32vD2bJVViTHwRYQMQ24JeP9Ev8b6
         0nabuADYHZg5pHMNY82yeFA62VRRrFRofqabhI29n3XxZfpQaZ07rHzx8sJnBoZXUaG4
         NZOOhND64ktzBBqQM+mfacM0qyYFC0efJhVHjhFhu1yQAmiQvnAhqUxaqUkgW5XVuM4X
         00FQa3qvbQLy89z1Z92qXV78pP/GlKklsPuqWrDlgvqP8UBlhf0vbk85Mmb0ifrFxb7H
         ve4l6i9SUxmfrhWUR47+ZKz089kdOiFXXaehTR+cSiMfzDKItSoSbm5VtcosbnuSMmWx
         LXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4SdIERZA+OnVBqptBnjRNah42jIah+k74ssVYRemZyU=;
        b=B7m+uALVVCrHiPqf3GeLO/ezVfNe5D56XDoqceJT56w4rojdoVflTPlmi4Qa4I1u+z
         7b0sYOIZq/c1mW1H2OG/y2WbRPv2rRJSCOLPVDIG2Nt+ZpUYPpHSbdWMTQXngV2FsfRY
         5um6h3xsO+0ZjBVmecQR8T1Y6lg6sSvHpMDANBYqu+GYftY2PjbUN2cXjYtCvMzTMkiC
         PTMjYNpfP30+GK/aASKRai/yi76jrz4Ay0UBhsFp9RZVB/7kn3xhQ5HeZpGNM7c2zy3k
         1xhws52d2D2NbjOWspLUwy0xJsE/KoUyJDagB4Q6i9Y3+edVcf3dwjxGtENtAiXAkjYP
         0RXw==
X-Gm-Message-State: APjAAAXSPO2AdAsZ7DZMY7ZoUc8BhsRJBUzFvzGWJPcpJNGGrMHnRlnF
        e1/vEddnMYGxF3dx4KBWQLWZDPdDVeVbbtT5W7M=
X-Google-Smtp-Source: APXvYqxkFc79NvGtNJGg22GbvW+Cpd2eTAvNeJlOJK9kGBZh7c2a4V4r1jeNdEyhLWtujG2U8h9inaphTTamq6Gptp0=
X-Received: by 2002:a19:2313:: with SMTP id j19mr7694114lfj.138.1569787845275;
 Sun, 29 Sep 2019 13:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190929005646.734046-1-alexhenrie24@gmail.com> <20190929093706.ylm5dsftwl2y2nnz@hashpling.org>
In-Reply-To: <20190929093706.ylm5dsftwl2y2nnz@hashpling.org>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 29 Sep 2019 14:10:33 -0600
Message-ID: <CAMMLpeQnVb1M_Wy_GDeH44YVweXvNQ2jpyJqtvJ4zS_fGfxKuw@mail.gmail.com>
Subject: Re: [PATCH v3] diffcore-break: use a goto instead of a redundant if statement
To:     CB Bailey <cb@hashpling.org>
Cc:     Git mailing list <git@vger.kernel.org>, dstolee@microsoft.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 29, 2019 at 3:37 AM CB Bailey <cb@hashpling.org> wrote:
>
> Previously, if the condition matched in the inner loop, the function
> would null out the entry in the queue that that inner loop had reached
> (q->queue[j] = NULL) and then break out of the inner loop. This meant
> that the outer loop would skip over this entry (if (!p)).
>
> The change introduced seems to break out of both loops as soon as we
> reach one match, whereas before other subsequent matches would be
> considered and merged. Not only this, but the outer 'else' case for all
> subsequent entries is skipped so the rest of the entries the original
> queue are missing from 'outq'.

> I spent a bit of time trying to see if this change was user visible
> which turned out to be unneeded as t4008-diff-break-rewrite.sh already
> fails with this change for me in my environment, initially with this
> test but also 3 other tests in this file.

Thank you for reviewing this. I should have run `make test` myself
before sending the patch; I do indeed see the same test failure that
you saw. I will send a v4 of this patch with the label in the right
place.

-Alex
