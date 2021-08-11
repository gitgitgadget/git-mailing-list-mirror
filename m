Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2EBC432BE
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 10:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A35ED601FF
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 10:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbhHKK0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 06:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbhHKK0M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 06:26:12 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F3EC0613D3
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 03:25:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g12-20020a17090a7d0cb0290178f80de3d8so3866059pjl.2
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 03:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=LsN3L28F2HCe822QCChAUyi/FYKYWWszPADakJYDMQc=;
        b=PYcL/FYdOgWJorauNqn3alipQUC6NGpfnkRS7qoXEnnRM2yXV0AP+NGFsCxquSWvLS
         kUK51nOP+a+j+uWBcNm4awgxfz+Hj5+THiO6N17sY2SCJl5uUgBhnZXZ+gW4maZp3eaL
         8/qGkUAEyc6yh+t495e0+cWS9kKGHmicMxxqJ0N6Og5HNeF6RH4COJ+1k35V+jQhOr9v
         HLdj/zZxC9y67+lsg0LtUytsoYrEDgWa3diMeWoDiOWRXHk3G21P3UurMbSD14wzDZZf
         384FqYT6gTDeBoq7YlsyW+F0T37hzp6HD+i3vzpoJkiej6BXr2wXaOZ7IfXTXQYcriSU
         q30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=LsN3L28F2HCe822QCChAUyi/FYKYWWszPADakJYDMQc=;
        b=XTe/zH6z02Mk3rM2X8sDUN0yAtMlgACNNu7dsjrO+FleYuBqXlBixDBYFhmtcEEdmN
         LjHRIkhh0NA5RM2fUQJmXc/VLny1vB+22G4gThU76SRC+Tqo0pfp1OB6f+9JpcxrGEZk
         2S1RO6hH/siqE99ri1VAgKJuT3q5y1ONgB1GaD6qg37IJC49xYVRbd38MYPC6+dCNrI9
         LxM0o/X4r55nhltM4xecp3pabaCcddwKydAJnIqMqOeRmIRooDoQOSN9sdp1GqUULXuA
         Sm1kjNdGErPoKLawb9u4rcXZ23ukRUYKw5ymuOxq0qTDMTZrtq9P3oy0ZHGAB6VdEuN+
         FSIQ==
X-Gm-Message-State: AOAM530X8xxbinr7hNVjxVqLOCFW+SLCqdFzeZo+4sY5114cpkczLpla
        g8LD6fj4I14Wo4WTXDd9z9dbnDc5F84x7g==
X-Google-Smtp-Source: ABdhPJx5T38KXEsxYK7Jw+fndGhAJwhCF5KkrFK0eePdvFykf1EuVAoFHqjyZOyiH3qwlng057EJVQ==
X-Received: by 2002:a17:90b:147:: with SMTP id em7mr36636966pjb.154.1628677548707;
        Wed, 11 Aug 2021 03:25:48 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b18sm26810836pfi.199.2021.08.11.03.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 03:25:48 -0700 (PDT)
References: <20210806120147.73349-1-raykar.ath@gmail.com>
 <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210807071613.99610-5-raykar.ath@gmail.com>
 <1b731c17-7284-746d-331b-d0edd5823318@gmail.com>
 <m21r73avvx.fsf@gmail.com>
 <68bb457b-9575-c2a1-6d51-fc7cd85a50b7@gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, pc44800@gmail.com, periperidip@gmail.com,
        rafaeloliveira.cs@gmail.com, sunshine@sunshineco.com
Subject: Re: [GSoC] [PATCH v4 4/8] dir: libify and export helper functions
 from clone.c
In-reply-to: <68bb457b-9575-c2a1-6d51-fc7cd85a50b7@gmail.com>
Message-ID: <m2sfzg9t22.fsf@gmail.com>
Date:   Wed, 11 Aug 2021 15:55:41 +0530
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> On 09/08/21 1:32 pm, Atharva Raykar wrote:
>> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
>>
>>> On 07/08/21 12:46 pm, Atharva Raykar wrote:
>>>>> [ ... ]
>> Yikes! I meant 'host.xz:foo/.git'. That should give us 'foo'. Thanks for
>> the correction.
>>
>
> Interesting. I've usually seen host.xz:foo like syntax in HTTP URLs. For instance,
>
>     http://host.xz:4000/bar.baz.git
>
> `git_url_basename` returns `bar.baz` for the above.
>
> I wonder what real-world URL has a syntax like 'host.xz:foo/.git' for which
> 'foo' would be an appropriate basename to return. Does a real-world URL of
> this form exist? Or is this just cooked up to demonstrate the basename that
> would be returned for a hypothetical URL like this?

Junio already answered all of your questions, I'll just add that I
lifted that example from the git-clone documentation [1] that uses the
exact same basename extraction function.

[1] https://git-scm.com/docs/git-clone#Documentation/git-clone.txt-ltdirectorygt
