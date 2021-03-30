Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F326DC433E0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 07:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 962FF61935
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 07:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhC3HWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhC3HWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 03:22:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAF7C061762
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 00:22:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ap14so10117967ejc.0
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 00:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmgL2GZx40WLYPwRb9rpQSPfkq2Saryd76YUQRfaDO0=;
        b=bjMWs4JOG4TDwULpOFL+lnaA5hIyv7aw1Gbwzm+CP58JOseserXM70Okh59etLJF8N
         to3I9Od8jVsHQ4IU0v/3PhsGshTC3Z74n8wixVsrzyZhiP3hNku0kBM12tqPm/IcSYti
         AEGEBwaRLntmO36QVaKdifgSuURYgLQhvvJQ6ku4T4/WnFnCYhaHtao+q3c3K+Oz6/gG
         8v+J2t6ngnxtMGXkT9yiUsaLEx+WvSXnIYEqk5aNVI0RJJH9UlxJUXZb33B5AfunLaE9
         7KKO0BFu5qUJfhYa2wzRlGlwUfgUhG1UJFnuV8qKfiOsxjX3N4TVSBX1GxujdZPm/pF/
         KSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmgL2GZx40WLYPwRb9rpQSPfkq2Saryd76YUQRfaDO0=;
        b=hyokT2Rp11G6O9tbtojhgmDJ3s1Ni7CJWImnLSTir5CYzjZ1ytBogJfBtDPzb3Qg1D
         yNebVOOhWqyFYcs6T06IVD5aiXQ/V7+FwRUuGBwOVSyENCG18+Bw2zMqxmLfKtvdn3kc
         E5QVjsO/GVkQBZg3soyzBzELByHr0A472NEAwqlD0eUS0EjLrl8o4f+wvNTB6mm9/2YY
         +MnFIei8YL/+3ZdHhfjZ0v5IO71SC9ne80qAtOgIBKMQnwe1iPXchnQy5wTYuWRnV2+V
         J8bjd9ZZY+Nqr+9cHSDXTPT73EbqRwJeNjA5B/Hk9TYFfesMyTDRrxlEVhM+UHDpFOCY
         msaw==
X-Gm-Message-State: AOAM532MjF3Q5EB77GDxJELn4GndCjIqq7XTxDUfaWKr/cp0C+Zb1K4B
        q+iOfETM5Nkt58MOxFep2yP11ZyM/Id1SEA5vOc=
X-Google-Smtp-Source: ABdhPJxjfDwoEqx45TCVQTb/qd+lIhSY5Y0D2O10I5GVp6X0yYy5JsrnpvbC9eIKSI0nOxCA7cQ5EYRjy7yDils9pVU=
X-Received: by 2002:a17:906:86c6:: with SMTP id j6mr30844635ejy.197.1617088927963;
 Tue, 30 Mar 2021 00:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <0e32b0af-cd05-39a9-51a9-4d983e7085cc@gmail.com>
 <CAP8UFD1TmckvQLVQ7eWMKakMKOF76J+Z+E25vUCGkWveXMWv1g@mail.gmail.com> <xmqqr1jxisee.fsf@gitster.g>
In-Reply-To: <xmqqr1jxisee.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 30 Mar 2021 09:21:56 +0200
Message-ID: <CAP8UFD220trs=ERcg2rTU1MCrF+2aw-Nnbyy1mqjkGqxeMfZxw@mail.gmail.com>
Subject: Re: Upstreaming Reviewed-by to git.git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 11:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > On Mon, Mar 29, 2021 at 1:03 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >
> >> I had reviewing patches here, but how can my reviews be credited with
> >> Reviewed-by tags to the applicable patches on git.git (Git SCM)
> >> repo (upstream)?
> >
> > When you have reviewed a patch or a patch series, you can tell the
> > reviewer you are ok with the patch or patch series, and that you are
> > ok with them adding your "Reviewed-by: yourname <youremail>" to it.
>
> I think you meant "you can tell the reviewEE", not reviewer.

Yeah, sorry and thanks for all your explanations.
