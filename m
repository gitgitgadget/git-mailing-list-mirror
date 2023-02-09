Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018BEC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 16:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBIQx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 11:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBIQxz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 11:53:55 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1E063139
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 08:53:55 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id pv1-20020a17090b3c8100b0022c1ab71110so3243451pjb.7
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 08:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8j5uwWWs0pOaDgYH/7lG466Chz5/ocrVYuQWO2aKEWE=;
        b=e9H5e9uqNkxHf9WPCTYVseTSyuzJtcGTyITcvjojR4C7RsYDHVP6OQ0K00PLeyjzS/
         j6AE3IrlLmL0O/adgIB+417Aye+zLEbTvmioN5Zt3J2GPOPtbHy20gjcA1MRWLqtEaCa
         1aVAY86/t3rKZSQ1gutIvx7vTm7++PolInu9F8C60+M1TqFU4goEw3+Y5nk8NZHGGM0A
         v0/fIi9hpCFQy+ROFggFI34+lu+QLAKk6BinVhXnJyQAVPO154hIG3tl4iAj+bcP/gMg
         qHcp4iLYQEA+w/bfpqZpdl2K3Vn2/IHNK/2Lux73y6RUloP1AHne1IXNpiq767o8eIZH
         Q/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8j5uwWWs0pOaDgYH/7lG466Chz5/ocrVYuQWO2aKEWE=;
        b=f+oXqO5G0DhCoqz/YR4/SoiyBZ6dAu5EELNb3lzuR5TF7XidW18ftAaKv0xxS9vSmK
         6vMn5OmssKvnPmmzrVMjysV3ayHyOTaBiXsaAXoCaEiZGtGdllP9dnuKVh2z71vQpmu4
         MoHcMBLvG9WYAoCOooiYtDwXrcBCcu1+CJPMt68wR5VPacJIU47BZrttlkJypiy72Vwi
         QJ4OuvYJpTSsq9RPbieN1XXpB8QKndEfsIO4KhxT5QmnimSmROt7O+i51cg2NgWW6FHl
         kNt6RpnmFb1hxH9+PJBfD9esSmTV1bdfyWu+LLNia+WXzLFKXWS0bWhDWhFDZMXtUgF9
         u/NA==
X-Gm-Message-State: AO0yUKVGpnZP29GLlZQ+BfRt6f6GIdIJ6VFx0ujOjBBd6qUMVMO03PMr
        vJO7eMKCr5MVoyPkVm+zitA1TAELZGjBhg==
X-Google-Smtp-Source: AK7set9UgA4GG81XmNcGSJVoGpMBAHzrzyXd0w6sjt930xMikwKq51OWLfhpEq6Ymzbi/ArU35ct4U1EF1kMtw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a62:16ce:0:b0:57f:a5e6:20fd with SMTP id
 197-20020a6216ce000000b0057fa5e620fdmr2571500pfw.11.1675961634603; Thu, 09
 Feb 2023 08:53:54 -0800 (PST)
Date:   Fri, 10 Feb 2023 00:53:52 +0800
In-Reply-To: <230209.864jrvxfuy.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
 <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
 <patch-v5-03.10-4a73151abde-20230207T154000Z-avarab@gmail.com>
 <kl6lttzvw8k1.fsf@chooglen-macbookpro.roam.corp.google.com>
 <230209.86h6vvxhq8.gmgdl@evledraar.gmail.com> <230209.864jrvxfuy.gmgdl@evledraar.gmail.com>
Message-ID: <kl6lr0uybx0f.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v5 03/10] config API: add and use a "git_config_get()"
 family of functions
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?=" <szeder.dev@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Feb 09 2023, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Thu, Feb 09 2023, Glen Choo wrote:
>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>> [...]
>>>> In a subsequent commit we'll fix the other *_get_*() functions to so
>>>> that they'll ferry our underlying "ret" along, rather than normalizing
>>>> it to a "return 1". But as an intermediate step to that we'll need to
>>>> fix git_configset_get_value_multi() to return "int", and that change
>>>> itself is smaller because of this change to migrate some callers away
>>>> from the *_value_multi() API.
>>>
>>> I haven't read ahead, but on first impression this sounds like it might
>>> be too intrusive for a series whose goal is to clean up
>>> *_get_value_multi().
>>
>> Yeah, that was my inclination too :) But Glen seemed to have a strong
>> opinion on the end-state of the topic being inconsistent in its API
>> (which he's right about, some stuff returning -1 or 1, some only 1).
>
> Hrm, so clearly I lost track of who I was replying to there, sorry :)
>
> I thought this was a reply from Junio at the time.

Heh. Maybe I do a good Junio impression.

>> I wanted to just leave it for a follow-up topic I've got to fix various
>> warts in the API, but cherry-picked & included the new 06/10 here to
>> address that concern.
>>
>> I'm also confident that we can expose this to current API users, so
>> partly I'm playing reviewer flip-flop here and seeing what sticks. If
>> you feel it should be ejected I'm also happy to do that, and re-roll...

Reading ahead, I think that 06/10 should probably be ejected; the series
is doing too many things. You're probably right that 06/10 is a safe
change to make, but it's a big enough change to require some careful
review. I don't think it's worth holding up the original *_multi()
changes, especially since I think they're pretty much mergeable.

The change would probably make more sense in the follow up topic. I
wouldn't mind giving that topic a look.

And if we are sending this follow up topic, then perhaps we could be
consistent about *_get() only returning 0 or 1 in this series, and the
follow up series could make all the functions ferry up the return code.
This does introduce some churn, but the consistency will be a good
property to have, especially if, in the follow up topic, we decide to do
something else with the API.
