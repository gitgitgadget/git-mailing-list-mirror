Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0999DC47092
	for <git@archiver.kernel.org>; Sun, 30 May 2021 19:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC2161206
	for <git@archiver.kernel.org>; Sun, 30 May 2021 19:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhE3TKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 15:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhE3TKo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 15:10:44 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52104C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 12:09:05 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id m15-20020a4ae3cf0000b029024598c3e273so267243oov.13
        for <git@vger.kernel.org>; Sun, 30 May 2021 12:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=SnEMDoQEw6K9ewrsVARZ024IM5q9E6bbeR1+6+bclgo=;
        b=cqcyDGqTwDKmIn7LdsOWcxLW4rp3jJFNP1kFisolg6GlucfF2FHkU07bRxwjbysU8Q
         AQ6p3NpynFjPO9AtOKHJjpRRFLPGt/8+fuTAfshyOAig7aMc3bbr8MmIL3pjaKpF+8q7
         m0bbZxQelPps6qGVhrtTT6NrtWYVl7RRyLXyLNII+T24xHXPXjPd6R55zJRw6NjQT5tu
         yHPCZHm+329lxrd112+h3sXuST3yjbarbgTmI4X7YNsP09yUucy7/bop4ONkGqvtyZiR
         yEUVr7x5m7q96PX+aVFmm2eZUyLUl+UOPjMqj41vs4W6jVvYrLQKkmqtP35wocCYsGjw
         eWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=SnEMDoQEw6K9ewrsVARZ024IM5q9E6bbeR1+6+bclgo=;
        b=jQVgk/sxe6N6nXP7xQWfp7GwdKMcYFxcyp8OasnYUVKFhFiteUCzp3BefojuLwXNwX
         CsJisDQIPuSiJ0Rs0XqwFgsbX/wiOWvbrssbJgfIvYsjX41SJnqJkfLGo9arAQiFteDk
         2T0mTLdMfFFUEDOWhCcMqoNV/lub+cfRMFT9xKICl2EDxIxP+5J2/0AMWFS3RVh3FquC
         DhZwXaMSduUfTC4Vd0+OuaXABhezv2PSpBbuGiCAeWFpxe1r5FrzFkY561nLA4XV9Sb0
         4AMuvt6MfNYjZGK9nDM5cqgSLI+G+IYmFSr2YtQaUxj4Qh1ZDTA2i2P6glIYT37zyvd0
         PcRA==
X-Gm-Message-State: AOAM5307X2HyszSb3Esvor5R+2h+mlFKKmmOKZPHxvdqjepz9fXrM1c9
        YkZKTFTRsIydmmaqZ9iabC8=
X-Google-Smtp-Source: ABdhPJxMKPOWxOeoSQO1Ww/TXDMBCimVXp6DicDU26WcwliEHr9yZug1zu+IBiaxN16deXtsxfq4Kw==
X-Received: by 2002:a4a:4950:: with SMTP id z77mr1846694ooa.29.1622401744549;
        Sun, 30 May 2021 12:09:04 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id q19sm1573964oov.18.2021.05.30.12.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 12:09:04 -0700 (PDT)
Date:   Sun, 30 May 2021 14:09:02 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Mathias Kunter <mathiaskunter@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60b3e2ceee840_ee4c20823@natae.notmuch>
In-Reply-To: <acfafe6e-b0f3-ba2e-71f0-9bcc09b9d612@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <20210529071115.1908310-7-felipe.contreras@gmail.com>
 <acfafe6e-b0f3-ba2e-71f0-9bcc09b9d612@gmail.com>
Subject: Re: [PATCH v2 6/6] doc: push: explain default=simple correctly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathias Kunter wrote:
> Am 29.05.21 um 09:11 schrieb Felipe Contreras:
> > Now that the code has been simplified and it's clear what it's
> > actually doing, update the documentation to reflect that.
> > 
> > Namely; the simple mode only barfs when working on a centralized
> > workflow, and there's no configured upstream branch with the same name.
> > 
> > [...]
> > 
> > +* `simple` - pushes the current branch with the same name on the remote.
> > +If you are working on a centralized workflow (pushing to the same repository you
> > +pull from, which is typically `origin`), then you need to configure an upstream
> > +branch with the same name.
> 
> I'd like to remark that I personally find the following description of 
> `push.default=simple`, taken from the git push man page [1], easier to 
> understand:
> 
> > The current branch is pushed to the corresponding upstream branch, but
> > as a safety measure, the push is aborted if the upstream branch does not
> > have the same name as the local one.

Except that isn't accurate.

  git clone $url
  git checkout -b fix-1
  # do commits
  git push

Does that push the current branch to the corresponding upstream branch?

-- 
Felipe Contreras
