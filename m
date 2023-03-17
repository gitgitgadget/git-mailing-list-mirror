Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5A5C6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 23:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjCQXc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 19:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCQXc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 19:32:57 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E560F5C138
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 16:32:55 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id cp21-20020a17090afb9500b0023c061f2bd0so4712297pjb.5
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 16:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679095975;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d5+bDaiJhwQJNp5rjYnyM8alikPZ1D29V2wc5LMHFws=;
        b=OZmNWYPUBPVf5wPvpNWy8Sk7LPr+sl1ecT/Jcs04GmINQHblHoZnyvy/QXMzgd2q/H
         Y39rKhWKub3lmeyP5vha+Uc/mDTyyxkivBnX1plHqUiTq/p4TtXj97sle223zZWW9lJx
         xyotaHVzfJREdWcDDXfygcorIEZQyi4QTMD3JIHLHtZDde5mOgyoSxJ9TUWTxrbDaCkR
         g/rAY7/f+wZlxhVFWq8XOCn/BcG/BnRnAli/7leZGh58nKe7P13Vyev8623+TtBZ96XE
         YlzwLW5hkybqc9aQfO4ycjLwxQCkRqya+ZXF5GyX9d6pjeqwTARudzLSfVhK7gGsQSPk
         y89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679095975;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5+bDaiJhwQJNp5rjYnyM8alikPZ1D29V2wc5LMHFws=;
        b=8JtiJ1ZAhznCy5k9ASL+GzSiJxyUVps00tWhv5EWk4+aWXIZcqNwgo5GJJij1mEYpu
         FNKAGpOF/LitOj4JbDsFPDPFKKliiGW6ATOZ1RNwbdQWeJDmIaqg4O2Yo6MhCh2LF9+Q
         tYClCkDhzaLpnv77flYYY4MvwX+Xo4njNNF1DFN2nXpEsvmOFeurf5t9hGzmPcukBcUc
         vH7Fkns2lLXoZy+GP0kH86deU0j/+rr7A+DvmdaWA8U8IJ4EpKNd7kFIOsxZv+UlmZ5S
         rEWH9rA7CqtbxG3tJ0Rin2OKxauRrjT+Y8wHALc/HFVxYAd58l9IGURKC6EZmVVF54dF
         iSqQ==
X-Gm-Message-State: AO0yUKXEfGRxZZuQzcnFXbZTdlQGbniTUxrJWmZN2FXZwLRsfEFcxGJj
        uu0DalIjSubl7og7F9FTQMt4qDQ0bFoBzA==
X-Google-Smtp-Source: AK7set/SISmz2Vr6C/4b4chc7NuM41LhWCZ1/b+vRtmeStyBlB1Gi/YNCPMGpPvLrU9XFBGdWMhxoEE2PJCI9A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1410:b0:606:a4bd:8dde with SMTP
 id l16-20020a056a00141000b00606a4bd8ddemr3318814pfu.4.1679095975418; Fri, 17
 Mar 2023 16:32:55 -0700 (PDT)
Date:   Fri, 17 Mar 2023 16:32:53 -0700
In-Reply-To: <kl6la60buquj.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
 <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com> <kl6la60buquj.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <kl6ljzzfdkd6.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH 0/5] bypass config.c global state with configset
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>> This still leave the current_config_name() etc, which
>> e.g. builtin/config.c still uses. In your series you've needed to add
>> the new "reader" parameter for everything from do_config_from(), but
>> if we're doing that can't we instead just go straight to passing a
>> "struct key_value_info *" (perhaps with an added "name" field) all the
>> way down, replacing "cf->linenr" etc?
>
> In the end state, I also think we should be passing "struct
> key_value_info *" around instead of "cf", so I think we are seeing
> "the_reader" in the same way (as a transitional state).
>
> I considered the "repo_config_kvi() + config_fn_kvi_t" as well, but I
> rejected it (before discussion on the list, whoops) because I didn't
> want to add _yet another_ set of parallel config APIs, e.g. we already
> have repo_config(), git_config(), configset*(),
> git_config_from_file*(). Multiplying that by 2 to add *_kvi() seems like
> way too much, especially when it seems clear that our current definition
> of config_fn_t has some problems.
>
> Maybe we could deprecate the non-*_kvi(), and have both as a
> transitional state? It might work, but I think biting the bullet and
> changing config_fn_t would be easier actually.
>
> I'll try applying your series on top of my 1/8 (and maybe 7/8, see next
> reply) and extending it to cover "cf" (instead of just
> current_config_kvi()) to see whether the *_kvi() approach saves a lot of
> unnecessary plumbing. I'd still feel very strongly about getting rid of
> all of the non *_kvi() versions, though, but maybe that would happen in
> a cleanup topic.

As mentioned above, I think having both "config_fn_t" and
config_kvi_fn_t" would make sense if we found a good way to extend it to
the functions that use "cf" (parsing config syntax), not the ones that
use "current_config_kvi" (iterating a config set).

I think technical difficulty is not a barrier here:

- Constructing a "struct key_value_info" out of "cf" is trivial

- Supporting both "config_fn_t" and "config_kvi_fn_t" with one
  implementation is also doable in theory. One approach would be to use
  only *_kvi() internally, and then adapt the external "config_fn_t"
  like:

    struct adapt_nonkvi {
          config_fn_t fn;
          void *data;
    };

    static int adapt_nonkvi_fn(const char *key, const char *value,
                              struct key_value_info *kvi UNUSED, void *cb)
    {
          struct adapt_nonkvi *adapt = cb;
          return adapt->fn(key, value, adapt->data);
    }

The real cost is that there are so many functions we'd need to adapt (I
counted 12 functions that accept config_fn_t in config.h). I think I got
through about 30% of it before thinking that it was too much work to try
to avoid adjusting config_fn_t.

I still strongly believe that we shouldn't have both config_fn_t and
config_kvi_fn_t in the long run, and we should converge on one.
It's plausible that if we support both as an intermediate state, we'll
never do the actual cleanup, so I think the extra cost is not worth it.
