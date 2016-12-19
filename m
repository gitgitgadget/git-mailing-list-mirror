Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B11501FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 18:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934233AbcLSS4Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 13:56:16 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:32811 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933595AbcLSS4P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 13:56:15 -0500
Received: by mail-qk0-f173.google.com with SMTP id t184so24409447qkd.0
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 10:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KYzQb24eB9l5bCuXMCts/GDQHUwquGMFbzkgfjIWaLg=;
        b=WKUZCHGAglgsiyvQyvL86ov08Ojx3UUQJXo7GlL6C566gqe7gjX0tT2/0iAJ7wU78v
         BwDSe/czbXG9f7Ojp9Ia9qRbJNzT9wzMgVM8jfla3qPNIG8WZ5vKJRiXlK4gyy3mY3Jh
         MH3gzXRgm51OhFtQCOPwD4bZALYiIopx99gO2u4CyCqValJi9B7y9Tu1npffB5Km5AIK
         KrKzO4ej3XK78lIMjEVnZ7SYrpb8r8CAti0VgOTG/b2r8A2icvsl6q8BooJ9tyu1dx/o
         wk5Lv2zh6ugvpLUSS90ZT4RBPNpODZZ3usj+FAlEA0GXAFiZdBYyuSzKdS6pL/kOFB7C
         llOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KYzQb24eB9l5bCuXMCts/GDQHUwquGMFbzkgfjIWaLg=;
        b=gn65WAZnkZKjBgTJewTevNwELuqPZvf1oazR+ipnhq30ACDWzGmMdplY3w5UchUjDy
         hj11fe7nzwpD8dNgG0lcmHrjX6By+AJAE/m5NAUse3UulH7U1ivWdaO6UKn3LjQ/4UCB
         TIkUAeAWy/dDTChObhLSWkmNEshv2hHnCRIPAExPlGte/TDGp942GtksKLOt3bFQl+gS
         sVD7RPA2aUXqziicVKBWdJFif9r5LbN0hm+yvpfQ/d2aemXR9uR7F3m0zWrKek/zu6e1
         nKVF8DO47v3haFr3tFkoSFxEOR7/EJzWGLhrv+q20mMwsxNWNOGRUpfoJF7N7HnrmcB4
         TztA==
X-Gm-Message-State: AIkVDXKIPCQ4M82xtY1pOedjGUTr/2ZfP8k2PgFNphCT90VGzhjuNPf2/wo9l5KazGpd90JVyiZjwGIrY7lNcPl7
X-Received: by 10.233.216.7 with SMTP id u7mr886897qkf.220.1482173774669; Mon,
 19 Dec 2016 10:56:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 19 Dec 2016 10:56:14 -0800 (PST)
In-Reply-To: <1482171933-180601-4-git-send-email-bmwill@google.com>
References: <1482171933-180601-1-git-send-email-bmwill@google.com> <1482171933-180601-4-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Dec 2016 10:56:14 -0800
Message-ID: <CAGZ79kbc_o-B4nX8T1WN4z2PrpSHmrFBskeRA1rbdkzdnv2okw@mail.gmail.com>
Subject: Re: [PATCH 3/3] push: add option to push only submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 10:25 AM, Brandon Williams <bmwill@google.com> wrote:
> Teach push the --recurse-submodules=only option.  This enables push to
> recursively push all unpushed submodules while leaving the superproject
> unpushed.
>
> This is a desirable feature in a scenario where updates to the
> superproject are handled automatically by some other means, perhaps a

e.g. Gerrit. (No need to be shy about our code review tool)

>
> code review tool.  In this scenario a developer could make a change
> which spans multiple submodules and then push their commits for code
> review.  Upon completion of the code review, their commits can be
> accepted and applied to their respective submodules while the code
> review tool can then automatically update the superproject to the most
> recent SHA1 of each submodule.  This would eliminate the merge conflicts
> in the superproject that could occur if multiple people are contributing
> to the same submodule.

Code and tests look good to me, I think the commit message
is good enough, but let's hear Junio on this one.

Thanks,
Stefan
