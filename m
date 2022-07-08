Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF148C433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 20:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbiGHUfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 16:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240301AbiGHUfI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 16:35:08 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FADAA025C
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 13:35:04 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mi13-20020a17090b4b4d00b001ef9759d26aso1207483pjb.0
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 13:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b2/Eg7o7gkc0UUkygN7fMfoaIuejR+YQAWJWKtxYyFU=;
        b=lB+b7/eoO5nnc+FY/8LtUsQteGDQ048ku8FBhbuc77YBCEIfqIXL4JxU0Y/9dqAx+b
         px1oMH4MLAc+gE5yf2owJe/Jd/lOt7UWTeEf95W78Oh3dtvmDz5oPpIKJ47EQPTqlLmR
         iBdyKyL4L3o+0/h5ijllPlf2UcHdx15/Yn2ySDNCMGS8xB3JD5eJdAwxzu5FZEeXTC5I
         U2Y7Cf68pyDjE+Psv40Tpk1aK/xXpy36g9JGOG9qGxj9VylUkR7AwR8cwMs1KFKx07B2
         v8PVEng6h6jV9ZA2S2qrAirccHvmbsveeBfAGYFuN/EgsMWNOXduqZJCs33rHsp4/F1U
         cYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b2/Eg7o7gkc0UUkygN7fMfoaIuejR+YQAWJWKtxYyFU=;
        b=SXL2nIGbu3eoGDZC+VtVJFBqYHj8u1g0KAeousgdNKn1p7r51yO/QHFYGcy4RrS3MV
         jbQd5ytz3i1apxetGPQXYGcigo/RVpxHDXdhK+glUB7yvgi/lEcuZSPbekKmuYCI4FtA
         uHzhFrB1A8869qv+5XTg07IKAcpsQynj+MjAIK4m4cxsurZWB3IsdvZoSn1PVsm+AH0f
         kMwUyBvSHX8Udp8vk6ii0Gz5uDTpZOVsHBDDBIDC6CoS0MXi6RoZt2aOb59pU1r2TjJz
         PluJXPfD5W2U3uqKI391oPKPqNqEWsPbutxidKF/oekE/B9lZY9QS/Q59BSCAGUFLkew
         jFew==
X-Gm-Message-State: AJIora8aJ/ih03gQ+j+9WtjG+G7MyWCzQHfaUTV0XEETnmI56Xim+UX5
        zlWB4bDiH0Zrp31TklzwqiQSMqIBMtjEgg==
X-Google-Smtp-Source: AGRyM1uyM9kGOETpKyB/VOEN53Bo1Hy1NL1o7kVioiFo0UtTTe69PeZ9ejDPNDQanEBMUL9MEfq83IvGxBpzYg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:1613:0:b0:411:51f0:eaf8 with SMTP id
 w19-20020a631613000000b0041151f0eaf8mr4662145pgl.62.1657312503650; Fri, 08
 Jul 2022 13:35:03 -0700 (PDT)
Date:   Fri, 08 Jul 2022 13:35:01 -0700
In-Reply-To: <xmqqtu7swgxd.fsf@gitster.g>
Message-Id: <kl6l1quv737u.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
 <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com> <xmqqtu7swgxd.fsf@gitster.g>
Subject: Re: [PATCH v7 0/5] config: introduce discovery.bare and protected config
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> This version incorporates most of Taylor's comments and suggestions. Thanks
>> especially for the wording suggestions, I struggled with those a lot :)
>>
>> (I believe) I've responded upthread with my intention for each comment. The
>> only differences between that and the actual changes are:
>>
>>  * In Documentation/git-config.txt, I dropped a suggestion to mention that
>>    "git config --local" is identical to the default behavior when writing
>>    options because I found it too hard to fit in.
>>
>>  * In Documentation/config/discovery.txt, I took Taylor's suggestion, but
>>    didn't mention "discovery" for the same reasons.
>>
>>  * I decided to leave out the protected config lookup functions. I made some
>>    POC patches at:
>
> These patches overall looked ok.  I am not very happy to see the
> proliferation of namespaces like safe.* and discovery.* that would
> not likely to get the second variable, though.

Fair. I think `discovery.bare` is similar enough to `safe.directory`
that it could belong in the safe.* namespace if we find a good name for
it.

We rejected "safe.bareRepository" earlier because of the insinuation
that bare repos are unsafe. Maybe:

- safe.bareDiscovery
- safe.bareRepositoryDiscovery
- safe.unspecifiedBareRepository
- safe.discoveredBareRepository

"safe.unspecifiedBareRepository" is sounding pretty good to me
actually.. Any thoughts?
