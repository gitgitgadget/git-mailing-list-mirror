Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DFAEB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 16:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGUQNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 12:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjGUQNB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 12:13:01 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6453C07
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 09:12:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583a4015791so4293137b3.1
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 09:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689955954; x=1690560754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BVyAhmOaTFPm7HjUffd3FGtBXSs+OXjRsjcy1HmT9fQ=;
        b=U3nL44F2d+7ph0fvLoGlRwWTAt8WhVGTmNmxFr+RGcUoTFqv8Ad/yK1tqRntNkfFTe
         3D3BcItCGmAjHaGq+0JbXAC1N81uziz/hgwF0UMFzB+CPQBHZNLp1sEIj+Bwo4m+xbd0
         ghQnqPZExJi4MQRSASfkZ1KSQv0fGcugrXWTGH6fn8uDwPO7zsvFyx+2G9SZGq8imVUQ
         nXZocC2Ns/OU4wltTgrr2QEqTCZxq9cwkEhZicVHGLKgdVRt32NJJxuM670IkOcXr4aZ
         L8NKbEamq6OxjYLfpDlKIIgfdWTIibXNwOIZwf/XxDO336H4hOgWUoIZeVeIiHcmUN9e
         g3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955954; x=1690560754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVyAhmOaTFPm7HjUffd3FGtBXSs+OXjRsjcy1HmT9fQ=;
        b=CNMSVZyP3AQZAFnetCrae8zhv8y6E1EcvqQ01wcg+R7UTBE4NoJC5Lqiyryoj8Nmxt
         GO5KmCPoPdGB82Sgr43a5O4MdwbIfXB3BRLC/V3nhYbC3+huC0TmZ4yTbxXxvOm7Rffv
         STQbJjYBsaLRc9T9not3UJ5OwYXUtlAU6Iq4HtQKARpedMk0pd7MIAoMIbbDeyZ2THjo
         JLoz0BBEl4I+0K3hj5gxdXt2UWCfJAP/3F2WStj7UD+FIZAEAoYVPBVwtDda2o1TO+QV
         /lE7YicdlwR6IfFJs0M4cYCoRZMq8OX04mI510DyBfEf0s5wYyHAzGIjdc81kKnqBT1v
         QK8w==
X-Gm-Message-State: ABy/qLZ3P7W9KhnPk5WCq7IaNMqlvLrN4uu/ykwtlbrcTyL+2VwmsXVv
        z4pZNK03MUrqVqb4XWM9kP7YeWx/DhYtFQ==
X-Google-Smtp-Source: APBJJlHLhhuLSMZQyEOxl0ynlBaxgUA5f+9KV5JabINCs8XE3edGLfwMTpJHsFnawNilIeRgLpUqded086ZX6Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:450e:0:b0:573:6b9c:6fa1 with SMTP id
 s14-20020a81450e000000b005736b9c6fa1mr4441ywa.1.1689955953852; Fri, 21 Jul
 2023 09:12:33 -0700 (PDT)
Date:   Fri, 21 Jul 2023 09:12:32 -0700
In-Reply-To: <xmqq4jlx28c6.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
 <99244816307b822bd8ffcbff8690ef449c797a23.1689891436.git.gitgitgadget@gmail.com>
 <xmqq4jlx28c6.fsf@gitster.g>
Message-ID: <kl6ltttxz1jj.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 1/2] config: return positive from git_config_parse_key()
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> From: Glen Choo <chooglen@google.com>
>>
>> git_config_parse_key() returns #define-d error codes, but negated. This
>> negation is merely a convenience to other parts of config.c that don't
>> bother inspecting the return value before passing it along. But:
>>
>> a) There's no good reason why those callers couldn't negate the value
>>    themselves.
>
> That is not a good reason to break from a widely adopted convention
> in UNIXy library functions to signal success with 0 and failure with
> negative values.  The callers if they want to have a positive values
> can flip the polarity themselves, by the way.

Oh, interesting. I was trying to follow the conventions of the
surrounding config.c code and many other parts of the codebase, which
returns positive values. Why do we choose to return postive values
throughout the codebase, by the way? Is it because they were really
intended for exit(3), and not to be used as a library.

>>
>> b) In other callers, this value eventually gets fed to exit(3), and
>>    those callers need to sanitize the negative value (and they sometimes
>>    do so lossily, by overriding the return value with
>>    CONFIG_INVALID_KEY).
>
> There is no reason to think that each and every minute difference
> the direct callers of a library function may want to notice by
> different error return values needs to be propagated to the calling
> process via its exit value.

Yes, I fully agree. I didn't intend to be a statement on how things
should be, but rather how they already are. The oddities in this case
are:

- No callers actually care about the sign of git_config_parse_key()
  since it can only return values of one sign. Only
  configset_find_element() benefits from the sign being negative (since
  it returns negative on config key errors), but instead of putting the
  burden on the function it depends on, it could just return the
  negative value itself. And this "burden" is real, in that other
  callers have to worry about the negative value.

- For better or worse, we've already wired git_config_parse_key()
  directly to the exit values, e.g. if one peeks into
  builtin/config.c:cmd_config(), we'll see "return
  git_config_set_multivar_in_file_gently()", which in turn may return
  the value from git_config_parse_key(). (And as a result, we also try
  hard to separate the error values returnable by git_config_parse_key()
  vs the others returnable by git_config_set_multivar_in_file_gently().)

  I would strongly prefer if builtin/config.c took more responsibility
  for noticing config.c errors and sanitizing them accordingly, but it
  seemed like too much churn for this series. If you think it is the
  right time for it, though (which I think it might be), I could try to
  make that change.

>> c) We want to move that into a separate library, and returning only
>>    negative values no longer makes as much sense.
>
> Quite the contrary, if it were a purely internal convention, we may
> not care too much, as we have only ourselves to confuse by picking
> an unusual convention, but if we are making more parts of our code
> available in a library-ish interface, I would expect they follow
> some convention, and that convention would be "0 for success,
> negative for failure".

Right. I do not care what the convention is, only that we pick one. I
chose the one that I saw in the surrounding code (positive), but I'm
happy to go with UNIXy (negative) if others think it is worth the churn.
