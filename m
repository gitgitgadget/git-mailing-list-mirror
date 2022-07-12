Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E81C43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 22:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiGLWLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 18:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiGLWLh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 18:11:37 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F0FC48EF
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 15:11:36 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mm6-20020a17090b358600b001ef7bd409b0so4318242pjb.8
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 15:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QlaXpZpm//WA3Te/G11A/FfFb88g4gFUoT9FPkffM4Y=;
        b=bOPzYA3vNSZvu0smM1g4ZxkDW4ieGsS+TlbgPffMDYqYDsvgf+SFEyg/oaY9Rv5gVi
         0seBY0OBdT3g2kWr6QtpTMUlttQC+bkc3ijtHuKxl4OSjtiEkgiWtaPj61BdRlqk8n8l
         y0rRF6Luyqe6tjZKtNblkATmyNpV8u5TEUT7CjP+qqDwb2wgrOOwAfzDeBoGZNi4CFeI
         hfh6fcxI6PZmktkaTp7ptoIk86p0lyphp4HW8E6xmtAw4XZcLMLtfooe7chWNaGWWr3s
         nvZk0bFUzN2xn6vp3n2YX1IIafJXPqf6XjatoVVjr4wjyrJW656zyjiyrAxgZrdtP3CJ
         6MOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QlaXpZpm//WA3Te/G11A/FfFb88g4gFUoT9FPkffM4Y=;
        b=glElXrzWf91hoiYVAQ+by3XuTwkSO+Z7PVVQVThSYJgB4qnwsevdxZ3iLFWXSjyNXF
         CNLBoSoLNGaY2Lzd3ipe66zQLSRbi/Wl1mJGPAiiTyxFasbKm2oOikXF9AlYoC4AcOO0
         iwGrxTkgcMQONRxmawc4vp3HN1dAEVVyTopubvbTuvpxarKNzJBRvco1EknbzqJx6+kp
         0zA6ccfKw/dhmnXJQ2qPdXcHZIqXbzxT0kcaQAM52rsfxSPtMFoyx5goRLm/xzrG8/Fz
         rGYgumeVjSeVqXSVsKOelJ7xpXt57BsrGb8KUhT7m/vz/xmxe/57mQbSSO9D9bSxrRV1
         geDQ==
X-Gm-Message-State: AJIora8zNzOrtxWlVfAMO6fXgAYI5FHmYmTZ1ogqa9F41oxs1DggFcx5
        LQQOQbpJztF3qzF2WXNITO1iI3UcKuIrjg==
X-Google-Smtp-Source: AGRyM1sZsehWQYXZwObazVYzDljbV6tGyEbWgI8K+wEjpT9LLQdQ9egP0nG15NVRWpObhWE2J4izWuhFawOfQA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:b481:b0:16c:6826:7cab with SMTP
 id y1-20020a170902b48100b0016c68267cabmr365164plr.73.1657663895612; Tue, 12
 Jul 2022 15:11:35 -0700 (PDT)
Date:   Tue, 12 Jul 2022 15:11:27 -0700
In-Reply-To: <kl6l1quv737u.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lsfn656cw.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
 <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com> <xmqqtu7swgxd.fsf@gitster.g>
 <kl6l1quv737u.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v7 0/5] config: introduce discovery.bare and protected config
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> This version incorporates most of Taylor's comments and suggestions. Thanks
>>> especially for the wording suggestions, I struggled with those a lot :)
>>>
>>> (I believe) I've responded upthread with my intention for each comment. The
>>> only differences between that and the actual changes are:
>>>
>>>  * In Documentation/git-config.txt, I dropped a suggestion to mention that
>>>    "git config --local" is identical to the default behavior when writing
>>>    options because I found it too hard to fit in.
>>>
>>>  * In Documentation/config/discovery.txt, I took Taylor's suggestion, but
>>>    didn't mention "discovery" for the same reasons.
>>>
>>>  * I decided to leave out the protected config lookup functions. I made some
>>>    POC patches at:
>>
>> These patches overall looked ok.  I am not very happy to see the
>> proliferation of namespaces like safe.* and discovery.* that would
>> not likely to get the second variable, though.
>
> Fair. I think `discovery.bare` is similar enough to `safe.directory`
> that it could belong in the safe.* namespace if we find a good name for
> it.
>
> We rejected "safe.bareRepository" earlier because of the insinuation
> that bare repos are unsafe. Maybe:
>
> - safe.bareDiscovery
> - safe.bareRepositoryDiscovery
> - safe.unspecifiedBareRepository
> - safe.discoveredBareRepository
>
> "safe.unspecifiedBareRepository" is sounding pretty good to me
> actually.. Any thoughts?

(+CC Johannes Schindelin for thoughts on what should go into `safe.*`
and/or design considerations that went into it.)

Another thought is that `discovery.bare` and `safe.directory` should
both indeed live in the same namespace, but that namespace should be
named something other than `safe.*`, e.g. if we had
`allowedRepositories.otherOwner` instead of `safe.directory`, it would
have been a no-brainer for me to put this in the `allowedRepositories.*`
namespace.

So an alternative proposal would be:

- rename this to `allowedRepositories.discoveredBare`
- (possibly not in this series, but at some point) create a
  `safe.directory` alias in that namespace, e.g.
  `allowedRepositories.otherOwner`

*But* I don't see the former making sense without the latter (I really
think both should be in the same namespace), so if we think that's
unnecessary churn, I'll drop this idea entirely.
