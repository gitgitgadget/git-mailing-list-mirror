Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CAAC433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 19:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64342613BD
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 19:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhD2Tc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 15:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhD2Tc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 15:32:27 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC5DC06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 12:31:40 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id n61so4406107uan.2
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 12:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8It+9fQ5drWNvy3Slhfar6+ynC/n+GnOIFQYi044334=;
        b=nFJF+NtoENG8COQYh3z5zkkJS8+pF+SRgvAXfRGmzWYy1DuukM0wpxnW7q4kg3dQPO
         BRIEQGb/3XWvhYC0X/eJVHuJzsw8EuvSveXO4v8Cj5Qpgnue97nn2GMTDSZpDk8SlFgM
         9GTLdiN2ZDm2ho9ElYgFjOp9yHMZj2ec+LUyBNgU0iWFVf50rv+gBwcVlmKM4nkGRqOi
         4nOnBKCZWuGUlTsPzv1ejbpEhiNywdLE9sNEp4WrzcodClbTlHZx50duyfaptnyFytDz
         Rt4OghVfMFctZwQoDBxtJI1NH7ei0nhloVh/2M4AYVRv8ET/mDQMvynCun31DzqgwjFC
         bZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8It+9fQ5drWNvy3Slhfar6+ynC/n+GnOIFQYi044334=;
        b=fZwxW1pSxmBV6VKY2JIKNfdkjRHxebQYnPC9ELehh6JE2xnGx+iufnbBAkbvyzDcwV
         jnvrud6VDPHA66YZu6gvOp/84yvwxtYjsONeQW8XwgVCQRncO3vfeoQ/nkcqXT6du26i
         17ZDDVvE9qd/H8oHhDc2XdkwNe3nSpyYMjViTitk9ekdzetN7u0SALFxc1Amx1rYs3Vb
         6tyvvIGRAGuFIQ6WKA8amotiRFAUDdVsWRwbyGsODqYRfOvs4nTOI1UgoWkt5LcqX8HJ
         +KritSJJX2xasGvR2WyBoMIde6xziZN07WXC1nC54HRqeVK2rsQA/f0DG7RJtMuC2Ji1
         r2xQ==
X-Gm-Message-State: AOAM533sf/6Vx3ZHFSmS2DZOCBf1mmfIyBJ+utvmbMmMirJSqT7xGJET
        MRdNYgv0dtIwcP2gzcFmyaBD2SCLy/ql9EpVRuQ=
X-Google-Smtp-Source: ABdhPJzPxJ0p9tx5ezMRLm+rRjs9L2p0IudzJpPh2ek7JDcY18pk22TFq/s0x5aaQdJkmu7tGIptm8Ntqs3A+ATseT0=
X-Received: by 2002:a9f:3728:: with SMTP id z37mr1047749uad.89.1619724700000;
 Thu, 29 Apr 2021 12:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1013.git.git.1619640416533.gitgitgadget@gmail.com>
 <xmqq5z05akyf.fsf@gitster.g> <CAJGkkrQJFaLPfCBTVn6k1v9cCwF4wEUxr+ZyzebUBQJB8qLaWg@mail.gmail.com>
 <b0befcf3-8d8a-f99f-d4f0-78b2cfe22505@diamand.org> <xmqqwnslfq4l.fsf@gitster.g>
In-Reply-To: <xmqqwnslfq4l.fsf@gitster.g>
From:   Joachim Kuebart <joachim.kuebart@gmail.com>
Date:   Thu, 29 Apr 2021 21:31:03 +0200
Message-ID: <CAJGkkrTzThckEuFr7abV7WwZg4FUw=y5Xt4uu6TuQzuhWcrSQw@mail.gmail.com>
Subject: Re: [PATCH] git-p4: speed up search for branch parent
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Luke Diamand <luke@diamand.org>,
        Joachim Kuebart via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 29 Apr 2021 at 10:31, Junio C Hamano <gitster@pobox.com> wrote:
>
> Luke Diamand <luke@diamand.org> writes:
> >
> > Looks good otherwise.
>
> Thanks for a prompt review.

I addressed your comments and updated my PR at
https://github.com/git/git/pull/1013, but CI seems stuck and hasn't
kicked off yet. I'd like to see it pass especially since I modified a
test. Is there anything else I need to do?

Joachim
