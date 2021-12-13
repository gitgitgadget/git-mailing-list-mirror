Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A952BC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 23:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244221AbhLMXfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 18:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244191AbhLMXft (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 18:35:49 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E57C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 15:35:49 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id m16-20020a628c10000000b004a282d715b2so10934060pfd.11
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 15:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AwKGuVct9D/ZCCtITtHTLwe0dxTabWPgD7f6h/YA9yk=;
        b=TiCpqBDJkSFCYS/GZdqY9Ynb90UqoM/OVIcc1vBD0g58hcoIzU0+T5dt6E/5h1UMvK
         e65wEQAIbqgAR+PdQoDm0akjf8WeyeGylBH2Yrv8IIcfSzAz8LXpCmt9V2sx6i5dM0i5
         eXTDtZDjAfLo9rkhHkalMiVXZWA/sKrjzkVd6kDstAnZevSemIeZxn2Z5Vi3Ary/PlR4
         FDeQnyRfQJNf4cm8Hf4nhGUOvRLFJ7Cmk37vrgqimiaix6CvYNF/frP2JtroRpzc+RDU
         TlpkK9q5kY+kLBhS5ZqEDkCng/YplOwNEBBXe5Nwr8GhgDudgHwzcTmeDWd18L9KGWbX
         t3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AwKGuVct9D/ZCCtITtHTLwe0dxTabWPgD7f6h/YA9yk=;
        b=Rx41+ADGTQvXrw0XS6iNlIeFkQX8bnGsehyMKXbKtXep9DiKi9OEXk0NSGXIgpQ2xz
         z8el5FWCOgQuJs6+Oihz3i755jgIa8k+uJa094NmhEFGduI7es/Q8LkG1FwZRceFBs63
         JckbReZ8OHhRVAEHzIZleADKJmZEyPatbu8yoW4CW5j4fhfdQtCgOi467o41pxxpTl/+
         6O3UQ+fHgy2Nkthu4r2m9j+P/XtsUeexCKhNmUDOzOuabx2OwCthK9Ivijxw9dwXKOLC
         0JyWl3A7OwRmUo5jzgVTNzwc7lt5VW9Bu9I6eVBUBW4lk86JAuAvcMY/Uqcff0y8FbjM
         rpJg==
X-Gm-Message-State: AOAM531KeZxQGYVS+D6D63gPg7jdbkcfOj9Ywpfxo+fnCVbNEaGtsf6y
        uBlypwpNRyE05VCf2Ys5bclkQsB+IR8PImph3t+F
X-Google-Smtp-Source: ABdhPJwtmeIK2LiyMyk4G5b0X+ucAnceuM0AzuUomTjWWL6GE2vG8I7RxLIHLaxJKqsJ2GKP8BVFEjEvxWQob1DJMhxc
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:7883:b0:144:ccb8:674b with
 SMTP id q3-20020a170902788300b00144ccb8674bmr1361877pll.63.1639438549073;
 Mon, 13 Dec 2021 15:35:49 -0800 (PST)
Date:   Mon, 13 Dec 2021 15:35:46 -0800
In-Reply-To: <kl6l8rwt9ww2.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <20211213233546.773716-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <kl6l8rwt9ww2.fsf@chooglen-macbookpro.roam.corp.google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: Re: [PATCH v6 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> Yeah, I can't think of a concise-yet-clear way to convey this to users
> (if I had thought of one, I wouldn't have prefaced my original comment
> with "Wondering out loud").
> 
> Spitballing here...
> 
>   `hasconfig:remote.*.url:`::
>     The data that follows this keyword is taken to
>     be a pattern with standard globbing wildcards and two
>     additional ones, `**/` and `/**`, that can match multiple
>     components. The first time this keyword is seen, the rest of
>     the config files will be scanned for remote URLs (without
>     applying any values). If there exists at least one remote URL
>     that matches this pattern, the include condition is met.
> 
>   - Files included by this option (directly or indirectly) are not allowed
>   - to contain remote URLs.
>   + Because new remote URLs might affect the correctness of the include
>   + condition, files included by this option (directly or indirectly) are
>   + not allowed to contain remote URLs.

Junio suggested another approach [1] - I'll try that and see what I come
up with.

[1] https://lore.kernel.org/git/xmqqmtl8m8wj.fsf@gitster.g/

> Although, upon further reflection, I wonder if this approach of banning
> config variables really gives us the safety we want after all. Reworking
> your example, say we expand "hasconfig" to include
> "hasconfig:branch.*.merge" then we can have this in the main config:
> 
>    [remote a]
>      url = baz
>    [branch c]
>      merge = bar
> 
>    [includeif hasconfig:remote.*.url:foo]
>      path = foo
>    [includeif hasconfig:branch.*.merge:bar]
>      path = bar
> 
> and "bar" contains:
> 
>    [remote b]
>      url = foo
> 
> we end up with the exact same question of "Should "foo" be included?".
> This shows that the rule isn't actually "files included by
> hasconfig:remote.*.url cannot include remote.*.url", but the much more
> restrictive "files included by hasconfig:<anything> cannot include any
> config values that can appear in hasconfig". This sounds pretty unusable
> to me..

This was my original idea actually (using any config variable anywhere
bans you from that config variable in all "includeif hasconfig"). I
think it would still be usable - you just have to be careful in which
config variables you use. But we don't have plans to include other
variables now anyway.

> But I think that with the semantics you've defined, we don't really need
> to forbid config variables. This section describes:
> 
>   The first time this keyword is seen, the rest of the config files will
>   be scanned for remote URLs (without applying any values). If there
>   exists at least one remote URL that matches this pattern, the include
>   condition is met.
> 
> which, to me, gives us a pass to say "the first time we see a hasconfig,
> we will do an additional scan without applying values". That doesn't
> sound _too_ confusing to me, but I don't know how it looks to someone
> with fresh eyes.
> 
> Forgive me if this exact suggestion came up before on-list (I know we've
> discussed this exact approach off-list).

This "additional scan without applying values" is not very well-defined,
though. In the scenario I described in [2], should "foo" be included?
"Yes" because it is referenced (even though at that time, nobody has
ever head of the URL "foo") or "no" because at that point in time in the
scan, nobody has ever heard of the URL "foo"?

[2] https://lore.kernel.org/git/20211209223919.513113-1-jonathantanmy@google.com/
