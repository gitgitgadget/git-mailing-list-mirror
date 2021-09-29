Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D8EC433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 22:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988C361452
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 22:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346433AbhI2WzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 18:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344976AbhI2WzT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 18:55:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C0AC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 15:53:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z130-20020a256588000000b005b6b4594129so5500931ybb.15
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 15:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RqdiDy2+s6ju16K4wnrlsjBY04Hr2io3uQ7tkmInf6E=;
        b=Hp+A/pWUYCtDaJq9kHaU/f2yH33QisR09/qRz4UrUPmTyAPTYJQ5/1i+tSlsiYvqgu
         Vy7ftRpz+QUqg8MNTsFf+Ivlfp9Yo0gBG+sunIPrWHDTzA5cIlD+EpCuvplhmkJFPcc4
         Pe9HsDyktPlpn13PJNcqdPSakedL5S7kHUuG9DbLrMsAqWCvRwNdqNJO2vPbGW6tEuvy
         ZgY1L7cubQuDm+FNYuAQ212H1dWSkOrFB2H9hM7abJlr2C0rertKcNhonA2NIe4CbFed
         SzzfDmZs3GuEi5ryRlBGE/ogMmGSAjDDJlakhJGO1/LZ9Hf9050Z9gus8KovoqLMf+7f
         8QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RqdiDy2+s6ju16K4wnrlsjBY04Hr2io3uQ7tkmInf6E=;
        b=eSzr0haxb9jNGL0QwqFxSsT1NKjAqr8qSFpxeSmsrMJfRlljwRAlRxBK/IVGyILonn
         UzJoxJo77PAm56zOdxU6okYUk7RBjydhuAHrNik6fKN9jrTeLA6/yK7YLGz/GRycqopa
         mztEs9ZcG1PBdg9zC5i5nRnSdRqd6EcGkq4wxFHMZbruEgGWK7bMyxT2H70e7cPNjgf8
         SYnzKvKYBeFH1m+qlw0XsUY+meTYWgIdm6zQLWiPMmhU6f1e4j4DA+agJTKQMbiqLGXn
         ESsgfIA9ZdXa7n1jZJv2DSaGeM133xBFWIc3LwKAVPThMLlKRQPNE7QV3nwoibmwEWFP
         JYNQ==
X-Gm-Message-State: AOAM5318jvqAfIYbZnLAa3g/tiQGWV1RDfxG7c1zYiI2mtleqHDMSK2B
        D+Gf5flMYRoOff7Huq3KDTAHuT64I9d0KQ==
X-Google-Smtp-Source: ABdhPJzY9YXl/ec7LsyUu/SPfv8QU6FX69KkWk9ucGI/PL9UvjE6mDoSP09BZ7SE85dh24X6aTcqZM/OFAwMGA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:6557:: with SMTP id
 z84mr2705843ybb.471.1632956017377; Wed, 29 Sep 2021 15:53:37 -0700 (PDT)
Date:   Wed, 29 Sep 2021 15:53:28 -0700
In-Reply-To: <CAPig+cS7PF=F0XWO-EyVz_KuLnbnhQi3N01gyozSv99PmB_1RA@mail.gmail.com>
Message-Id: <kl6ltui3ouxj.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20210913181221.42635-1-chooglen@google.com> <20210917225459.68086-1-chooglen@google.com>
 <kl6lh7e53nnn.fsf@chooglen-macbookpro.roam.corp.google.com> <CAPig+cS7PF=F0XWO-EyVz_KuLnbnhQi3N01gyozSv99PmB_1RA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Use default values from settings instead of config
From:   Glen Choo <chooglen@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I re-read the entire thread and left a few comments on the v2 patches.
> One or two of the comments might be actionable (i.e. deserve a
> re-roll), but most are probably subjective.

Thanks so much again!

> Oh, I forgot to mention in my review of [3/3] that in:
>
>     In the case where core.multiPackIndex is not set in the config, the auto
>     condition would fail, causing the incremental-repack task to not be
>     run. Because we always want to consider the default values, we should
>     just always just use the_repository->settings.
>
> you can probably drop one or both "just"s.

Yes, this is definitely a typo from me.
