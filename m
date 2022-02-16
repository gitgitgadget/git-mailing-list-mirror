Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C432FC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 17:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbiBPRUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 12:20:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiBPRUX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 12:20:23 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65947C3368
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 09:20:11 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so2981977pjh.3
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 09:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tt6MEbp/PiMV1XqaEjwHDCqkSkoWuBDU9RW6RqmRT2A=;
        b=iMB5G2bNXj4EYT5ootFq/oQFHcm78p+tJ9X19OuKlrfOCoPMaTDEE8kILLWHrcTeFR
         bsafMH65CVXur/cotHIlh2Lqh8Z/TpLnil1TASS6C5ykBmmGN67CXw66ZIwZjuUp2Gk1
         VpYCwyAoW+01O8x+on8JMX0IlOJXZwELtcFbGwuB5biKQ77eEoDl/JSBSxjqZt1bcU+I
         Balt68uqnjiHaNkU3003Ug4QX/0HxGmjgZRkKnLbdLVrd0aBrKD+80RoOr9bQ3BT5hhG
         zNOyyWpImBAPUQvxqm6xIgG4n1eTZu0TwB3GP54bV/U8fT1dyiNzYXgIE+TTUEmH+6bp
         jm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tt6MEbp/PiMV1XqaEjwHDCqkSkoWuBDU9RW6RqmRT2A=;
        b=b6pmPDEobmbh5yzBKIF4Os6DR1OHQv1j6jbB8Qc/zMSCAKYpWeAbPY/Y50E8q3UV/q
         GMqRrYHpX2RVwweS7MKSptv1gtOPpxIo6coWfN/6d803ePAMkbawIes2LcKKeT4jP9qT
         W/QFYHHq8F80o9gVxGY6EnAKwwGahwmTB7lrmYNmOQfuz8swYLbCTTyT7HcSQoPgIekx
         EC/u0s31H8bRziV6j1+Nz0wjuupEbxx6Hl6GJfjotZinMBILWmHkiNlhp7thbjmyFdgf
         s2rZdunE6wU2/pAx9cqDS/0EXCPuj3LKO/MxETbjhQT1Qwy7K4HjKTNCDIfwXcegcRDf
         8H3w==
X-Gm-Message-State: AOAM530NDO/i27ymnVZIgHUPGmkB4WMNTi8E4y3Noe0K3AWEDBLBZJCg
        9Cotk8HCJNPGh88WAGIoQ5ov
X-Google-Smtp-Source: ABdhPJwxF7fQKPhdOtnraoIxsgtpQOoJIZnyqTz1qgfdjV2a7bXrHB7EDE8pdpvG0gZJGDWG8reo5A==
X-Received: by 2002:a17:90a:9bc9:b0:1bb:9945:d69b with SMTP id b9-20020a17090a9bc900b001bb9945d69bmr2109361pjw.144.1645032010918;
        Wed, 16 Feb 2022 09:20:10 -0800 (PST)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id u4sm7499872pfk.220.2022.02.16.09.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 09:20:10 -0800 (PST)
Message-ID: <af439020-8314-9171-4300-94a5102c8a38@github.com>
Date:   Wed, 16 Feb 2022 09:20:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v3 5/5] sparse-checkout: reject arguments in cone-mode
 that look like patterns
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
 <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
 <2008542d0c718bbe43388297307a791f94bc73e1.1644985283.git.gitgitgadget@gmail.com>
 <220216.8635kjuob0.gmgdl@evledraar.gmail.com>
 <CABPp-BEBX4tWwqkG=7+rcZa_EJzOC2+Rg214av_+-yymHTQGQw@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BEBX4tWwqkG=7+rcZa_EJzOC2+Rg214av_+-yymHTQGQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Wed, Feb 16, 2022 at 1:57 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Wed, Feb 16 2022, Elijah Newren via GitGitGadget wrote:
>>
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> In sparse-checkout add/set under cone mode, the arguments passed are
>>> supposed to be directories rather than gitignore-style patterns.
>>> However, given the amount of effort spent in the manual discussing
>>> patterns, it is easy for users to assume they need to pass patterns such
>>> as
>>>    /foo/*
>>> or
>>>    !/bar/*/
>>> or perhaps they really do ignore the directory rule and specify a
>>> random gitignore-style pattern like
>>>    *.c
>>>
>>> To help catch such mistakes, throw an error if any of the positional
>>> arguments:
>>>   * starts with any of '/!'
>>>   * contains any of '*\?[]'
>>
>> But not "\" itself, we're just escaping the "?" here?...
> 
> Nah, I just missed that one.  I should add it below.
> 
>>> +     if (core_sparse_checkout_cone) {
>>> +             for (i = 0; i < argc; i++) {
>>> +                     if (argv[i][0] == '/')
>>> +                             die(_("specify directories rather than patterns (no leading slash)"));
>>> +                     if (argv[i][0] == '!')
>>> +                             die(_("specify directories rather than patterns.  If your directory starts with a '!', pass --skip-checks"));
>>> +                     if (strchr(argv[i], '*') ||
>>> +                         strchr(argv[i], '?') ||
>>> +                         strchr(argv[i], '[') ||
>>> +                         strchr(argv[i], ']'))
>>> +                             die(_("specify directories rather than patterns.  If your directory really has any of '*?[]' in it, pass --skip-checks"));
>>
>> Isn't this nested || a reinvention of a simpler strtok() or strtok_r()
>> call? I.e. (untested):
>>
>>         const char *p;
>>         const char *wildcards = "*?[]";
>>         if (strtok_r(argv[i], wildcards, &p))
>>                 die(_("specify... has ony of '%s' in it...", wildcards));
>>
>> That would also allow parameterizing the set of characters for
>> translators.
> 
> I considered strtok, but strtok & strtok_r are documented as modifying
> their argument.  Perhaps they don't modify the argument if they don't
> find any of the listed tokens, but I didn't want to rely on that since
> I found no guarantees in the documentation.

Maybe `strpbrk` would work? Unless I'm misunderstanding, it should
consolidate the condition to one line without potentially modifying the
arguments. E.g.: 

	if (!strpbrk(argv[i], "*?[]"))
		die(_("specify directories rather than patterns.  If your directory really has any of '*?[]' in it, pass --skip-checks"));
