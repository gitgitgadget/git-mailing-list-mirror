Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAEFEB64DA
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 19:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjF3Tb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 15:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjF3TbX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 15:31:23 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F515B9
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 12:31:22 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b802df5298so17098185ad.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 12:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688153482; x=1690745482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQwu2tO5ZY5i4AQAH4dFR7heaxhrz7MEnAKWr5hqiA8=;
        b=JKaRztQ7nhKCCVxQeOSZOO0bJeEd0wZqVqTZQksG0dKb0hTe8h4sAhDSNrDWU5Xiw2
         CL3OKZ0BpKPmlEQ9ml5tmzZ3iFn4KKRMRjJCcZWteg7+XJ9mCHr5AgIrKOkZWTvKkaNP
         BfaY53p3OKq/aYJMwkWAGacoC5mtPEkgLsvtUl6NZeibD2XLmm5OaSUckwyGPBqtF62+
         zgWAmMQqse/imdKIDxrcyrdvZO+DMF++1IJFFVt0oIAtJtUYqnVtnpebVMujdMoXw/yk
         t+P1HBtYrZGzZPP4wgFaqQHvJVSM8aQNtDAgGUvNuUihoTGMUsjQWUf2E1LV9tgzBlHR
         FtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688153482; x=1690745482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQwu2tO5ZY5i4AQAH4dFR7heaxhrz7MEnAKWr5hqiA8=;
        b=V/QOY9h1rRLi15Fh/oORVH8jggWnikUCEJSCrT2WD55RqvSHeHR1561emB23uVG7m0
         EKPCvZc2LlknzjnXRE4cps7ySTBZYOL3jS8kPWeQgHjpxfmTd+MsJkpgPOM9EnZ2mPS5
         gTYthVZpkOpIXTe9M34o7i32Rw46H6s3lpAaBMZ+ejVh5oSn9QYgXumz3KqqP40VSM/8
         cv8KxMBTVcEPDoCL6/dxEwWYOVA9ljbsg4IWYDcYSRcHPoX4NnMiMOlpy4fxvS4V8LyF
         4CnJQC7qwvUqcfRd8SY/xn/X50Rywlv0nLlzwsiVEbVocYfKY48i5pIqIVh5QpzezSf4
         MHYg==
X-Gm-Message-State: ABy/qLaQm/HMo44puoOiEtCGOGxTYOP9NTURC5+qSGxPaDtZAsT4thWu
        tccbJgEQxuMWv+SNumgI8l7KpXtBBJ0=
X-Google-Smtp-Source: APBJJlG9Prv4HRbwsBz0Nw0/HaQ+n4VzpjPS2o7XHOThHCXgxN3LRvChurNWZnNjYKQSTBEsUg3M5fCsKig=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:903:41c9:b0:1b2:4b45:91ca with SMTP id
 u9-20020a17090341c900b001b24b4591camr2507719ple.2.1688153482062; Fri, 30 Jun
 2023 12:31:22 -0700 (PDT)
Date:   Fri, 30 Jun 2023 12:31:20 -0700
In-Reply-To: <ZJ3uGBEEvYmbPnoQ@google.com>
Mime-Version: 1.0
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
 <8afdb215d7e10ca16a2ce8226b4127b3d8a2d971.1686352386.git.steadmon@google.com>
 <owlybkgy837j.fsf@fine.c.googlers.com> <ZJ3uGBEEvYmbPnoQ@google.com>
Message-ID: <owlywmzk7nnb.fsf@fine.c.googlers.com>
Subject: Re: [RFC PATCH v3 1/1] unit tests: Add a project plan document
From:   Linus Arver <linusa@google.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, calvinwan@gmail.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        gitster@pobox.com, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> On 2023.06.29 12:42, Linus Arver wrote:
>> I can think of some other metrics to add to the comparison, namely:
>> 
>>     1. Age (how old is the framework)
>>     2. Size in KLOC (thousands of lines of code)
>>     3. Adoption rate (which notable C projects already use this framework?)
>>     4. Project health (how active are its developers?)
>> 
>> I think for 3 and 4, we could probably mine some data out of GitHub
>> itself.
>
> Interesting, I'll see about adding some of these.

Sorry, one more thing worth considering is the ability to add tests
inline with production code (where the test code can be removed in
production builds). There are a number of benefits to this and, I think
it is a useful feature to have. I saw this feature being advertised for
a C++ testing framework called doctest [1], but I assume it is also
possible in C. Could you include it as another (nice to have?) feature
under the "Developer experience" category? (Or, reject it if this
"inlined tests" style is not possible in C?)

[1] https://github.com/doctest/doctest
