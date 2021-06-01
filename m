Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62345C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 12:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2856128A
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 12:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhFAMOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 08:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhFAMOA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 08:14:00 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BCBC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 05:12:18 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id j75so15233136oih.10
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 05:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=RjoztT8yd5nHo9Df58ZhWOvrXKS6pnmLJJ1Cp6n9CFU=;
        b=Qj0b+PSnN4pv7LtxL30FFVnMRuO4tgeyLrMV49+Bo4w/x/mgq/zkUV2T8zFvXcRYbm
         IMi/xs2nlPwLI/BxN4qe/vL0DFJJ3JI0BxpMYPJBVQieTTlFnaTkhg+V8fmEtEF7ObRI
         ADmdK9fh81BRMfONqWJ9vB0Bt1eEyKsNOX1yIS88UsKrSYJtRmFO2decaNPzp4seWzG0
         vy5fkjVNncRNxGdUpWmPZuRH0UWNQJkudtLM4UEzPnDZ8vreVj7zfSeM22nPBWRemTCi
         UCjP3YfNk3n3P3vGzWXfwLeyqy9yWdbei7JQrz0aE81Z7iKCeGDehZJmwd4hYjlIYkem
         NBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=RjoztT8yd5nHo9Df58ZhWOvrXKS6pnmLJJ1Cp6n9CFU=;
        b=EioWuIWtzBzvyu3xtsuvmFFtY1Y4vXIIqfHJfLO1YRtvchktstzaqmvljZCwnKiJ41
         kbDPkAM7T3gZh95q0tpNW3Zv4xrWzpPHqDjv/l4LAz3C/oQ7xC67IwznavQN7rP6iTK+
         DZ6RjLr9c27CGFAMPJT2p6MzEEqePF94ohv3WyWBbp73mUA/ZBh1gqpPYCZ9yJK7fH1T
         lcKHvxpZYQSAVXeN/zaaLstQDaYiS3x0lAGdXe6o3sCLtoElx9dB/BYkNKnts0jjQgMO
         fesMtMQVFFbslhoBC2sxqqEg37UH5dWxt2g/vYH15ZjntK50PXxvG5kW6sZrhxBVsTK4
         J+ww==
X-Gm-Message-State: AOAM533StizvAvGrpr57g9qEODS/Oaq8aGiqXG70UU0duOWerZ/bmcOi
        9anfRZj1vHEpaiSDqUHyY7E=
X-Google-Smtp-Source: ABdhPJzwhestWX4hBUEdL7h0xVi5cl2ME8cBj49jPhf1/xerb1mXfxx4GAsgkTG/13bIFim7AtccQQ==
X-Received: by 2002:aca:4a55:: with SMTP id x82mr887923oia.130.1622549538174;
        Tue, 01 Jun 2021 05:12:18 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id u24sm3690659otg.73.2021.06.01.05.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 05:12:17 -0700 (PDT)
Date:   Tue, 01 Jun 2021 07:12:16 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>
Message-ID: <60b62420858c4_e409520828@natae.notmuch>
In-Reply-To: <xmqqfsy1udf0.fsf@gitster.g>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <20210529071115.1908310-7-felipe.contreras@gmail.com>
 <xmqqv96zwkl0.fsf@gitster.g>
 <60b49a3ae829b_24d28208fd@natae.notmuch>
 <xmqqfsy1udf0.fsf@gitster.g>
Subject: Re: [PATCH v2 6/6] doc: push: explain default=simple correctly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> I suspect it would be simpler to read and easier to understand to
> >> bring the parethesized part front, e.g.
> >> 
> >>     If you are pushing to the same repository you pull from (which
> >>     is typically `origin`), then you need to ...
> >> 
> >> as it would avoid "the project is not centralized, but I push to my
> >> own repository and pull from it---what should I do?" questions.
> >
> > The top of `push.default says:
> >
> >   Different values are well-suited for specific workflows; for instance,
> >   in a purely central workflow (i.e. the fetch source is equal to the
> >   push destination), `upstream` is probably what you want.
> >
> > We already brought up the central workflow, I think it's fine to reuse
> > the concept below.
> 
> Oh, thanks for finding another instance to be corrected.

In fact there's many:

  This mode only makes sense if you are pushing to the same repository
  you would normally pull from (i.e. central workflow).

> Even in that sentence, the more important point is that upstream would
> be appropriate if you push to the same place as you fetch from, and we
> do not have to say "purely central" at all.

Actually, I forgot the main reason I decided to rename centralized to
same_repo: they are not the same thing.

You can have a decentralized workflow where you have multiple
repositories configured, but every branch pulls and pushes to the same
repository (to them, not other branches):

  hotfix <-> dayjob/production
  cleanups <-> upstream/master
  experiment-1 <-> personal/experiment-1

So it's more like:

  centralized = ~decentralized
  triangular = ~two-way

A centralized workflow consists of a single repository where branches
are typically two-way, but not necessarily.

A decentralized workflow consists of multiple repositories where
branches are typically triangular, but not necessarily.

So the triangularity is per branch, not per repository, and same_repo
means a two-way branch, could be a centralized or decentralized
workflow.

Therefore your proposal:

  If you are pushing to the same repository you pull from (which is
  typically `origin`), then you need to ...

is actually better, I just had to remind myself that centralized and
same repo are not the same thing.


Of course it would help to have a place in Documentation/ where
trianguar and centralized are explained.

Cheers.

-- 
Felipe Contreras
