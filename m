Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8695C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 21:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiKPVVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiKPVVH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 16:21:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52DB60691
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 13:21:05 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e8-20020a5b0cc8000000b006bca0fa3ab6so17127660ybr.0
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 13:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wObkFZD1lQu2SDB6Z++iF+qFOuKyY1EC2OP0guc8E4w=;
        b=Qf3+/1HSfQshRPnwRX8RuuIhXNT8Rpk9b818gHWyYhCaBPA8a5vBUHWSV0Z1ADJjHe
         oY87GMfS0FAyHjHRCOxyC3lKZJoaVvk3IjWinrDud2LL2jF6tee9tjt/xhrocKWAy3c+
         9aPZvQYyFU1yl42UNcbmZUhfA1z2SMqn1kuvG9XHlmTJeoEtHBkuXB9LGwSsIdpx3ytk
         B3IZXtItj/sKABxmJXo/O5inLtaMfwlYX0pSwGls3eptASy/+YyRoHM1iZrhGoMLTVRL
         uBH78mKmNPBDfmFlhhCZRJ6TE41Z7wgtnQDcN9c6KEacre3O3vOnwQ3en9XvdYq2QZuy
         5b3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wObkFZD1lQu2SDB6Z++iF+qFOuKyY1EC2OP0guc8E4w=;
        b=eBj9o7sCF9gbA4X2Qo3MzBToPLlcsva72lZyaE7+SC1IUsd4I8V1Ca1fSVkISxmpe4
         OTjunLqaYUbuBg9EoQP3YsZLmxme9zg1wdQK61C+017n547DUQLwpCU+fsA7KvtwE8DW
         08fktQjWrqW4UlH8LmEhAxcyMz3P1MFwSht09/hjJzYRnderBkVnX05NolnEgws9T9Ol
         Tbu0aVZsc3y8DvdG8QCXnHRyOJxZ4hmJpZ5qrISiWFvs1bNcRfDd5SJRUuWrt00c9kiY
         Z6YJx5Ed9Sx04/+0wRvoi+U+zD9ckixwLwPOPv9/3Byr6p3UOSubTm26EilUSJ1lWfPF
         b3qQ==
X-Gm-Message-State: ANoB5pkDM+r+rP741uDSUK33zwB/OTEOEg5aedu68NPrvkiBvRitlGe3
        VIsfyyl5NZSQdyiQZZ2/eliLixQ6rTnB/Q==
X-Google-Smtp-Source: AA0mqf7slJ5EIvkJ3Onyu4q0VQ67+LCmvKvjz5YixbO2in7c+w/ZLfyfePbNHtcM+t3q2XCSziXqP2HvwoSuKg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:690c:712:b0:38e:3478:2e32 with SMTP
 id bs18-20020a05690c071200b0038e34782e32mr0ywb.422.1668633664776; Wed, 16 Nov
 2022 13:21:04 -0800 (PST)
Date:   Wed, 16 Nov 2022 13:21:03 -0800
In-Reply-To: <20221115184702.169258-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20221115184702.169258-1-jonathantanmy@google.com>
Message-ID: <kl6lpmdmvbnk.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2] Doc: document push.recurseSubmodules=only
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> When we pass this magic, undocumented value, "git push" will warn about
>> about "only" and override it with "on-demand". We always pass it when we
>> recurse into submodules, and we assume that no user will pass it, thus
>> we get the warning iff we are recursing into submodules.
>> 
>> In that case, it sounds like "--recurse-submodules=only-is-on-demand" is
>> a synonym for "this is a submodule that is being recursed into". In that
>> case, wouldn't it be more self-documenting to have a hidden CLI flag
>> that expresses exactly that ? e.g. we could add a PARSE_OPT_HIDDEN flag
>> called "--is-recursing" and check that boolean value. This seems clearer
>> to me at least.
>
> Hmm...--recurse-submodules=only-is-on-demand is hidden too, right?

I suppose so, but as a matter of personal taste, when encountering a
hidden CLI option, I'd prefer to see the option's documentation when I
grep:

  OPT_HIDDEN_BOOL(0, "is-recursing", &is_recursing, "internal only,
    override recurseSubmodules = only")

than:

  if (!strcmp(arg, "only-is-on-demand")) {
    /* etc */
  }

>                                                                    One
> advantage of doing this instead of a separate arg is that neither the
> caller nor "git push" needs to think about what happens if both --recurse-
> submodules=something and --is-recursing are both specified.

That's true, and I suppose it prevents the temptation to reuse
--is-recursing for things it wasn't meant for. But in that case,
couldn't we say the same thing if we renamed "--is-recursing" to
"--recurse-only-is-on-demand"?

At any rate, do treat this as just a suggestion. I won't block this if
both you and Taylor find this clear enough :)
