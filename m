Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71406C32792
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 19:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbiHXTIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 15:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiHXTIN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 15:08:13 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2152F474EF
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 12:08:12 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z72so14170201iof.12
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 12:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=yHDBiJrGU8MxWHdkxkeBKTbG891at/3nDvOeAMz+5B4=;
        b=CqFDDpl+8yuWlgc99Cg8E6fvzgYcvD67Tb0wA+po0CzqStAbrf+43owjxTZCTM3JFb
         Se4g17Faya3reyhFNhp5hFFQW/WzgPpydihEJsJ9887kIG3w1OmyDBApV48bsNnNYHX0
         VM+mbsidE4N6B4jh/po8GGUgd/hDqdGPj9j+zjivVZByhq4NcWyEupv41B470miX5eAz
         LX9iqC5OKNpxDbIstQaJ65yr4nvUFv69gyZ/lCQVPQ/SkfZqsWUHwAD5n0LhcYzpLuAD
         X7sntfv3gcNdbRjB2Pn06Ta3iU34bU8UR53siYuA7l0swd31kRcEh/KSZkfVjnE2+Xl0
         WQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=yHDBiJrGU8MxWHdkxkeBKTbG891at/3nDvOeAMz+5B4=;
        b=0vApz0Efk8NrOFroznQlY7NoodgXra/5AGlV9D/oeMbjs2N49ptA8e0WrI6Ry6Osn3
         hgx/RJ4xoW25IYMylqZlTxuVT1e9XFdsv8JmSAIC/PNlQSQOW989hJTOlzfU8JaH9QRJ
         3TkgABQafenr60kpv0X4oUaxtdL2xkGI+bwZ2RDplSlJYqIQI5ZYRDILtbP1kGuH+vg9
         RUCEj7YrKmy8orss3OWJboFLeRQhgkwWIqOPKsO2RnGZh34K94aELN97sw/kzUA8R/Lh
         FiGTF+Ggm7ihQUQSXEzo/o0dv+ZEHTx9TGUA8Q6m0yKhaLN70k2kFThyaWifwwAt40+P
         X2yQ==
X-Gm-Message-State: ACgBeo31nE3CMqVNcAv2FgvhUcYId8EmUXtL6nM31bXEWt8lOzKk3eRI
        tfHKLI2tYsJmma4K62/oRMdd
X-Google-Smtp-Source: AA6agR6EfN1zq/UT+Dd39N476zpSnPsf+V36GCYaQl9Qaj0D6M6SguR8T/GJP9shIEWEoPuuMG4rog==
X-Received: by 2002:a05:6602:2d09:b0:688:f387:aab5 with SMTP id c9-20020a0566022d0900b00688f387aab5mr181071iow.107.1661368091481;
        Wed, 24 Aug 2022 12:08:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:2955:515c:af53:c9f2? ([2600:1700:e72:80a0:2955:515c:af53:c9f2])
        by smtp.gmail.com with ESMTPSA id a20-20020a924454000000b002dcfbf36438sm1306346ilm.12.2022.08.24.12.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 12:08:10 -0700 (PDT)
Message-ID: <b70b2754-aaa9-e01a-a576-9d1c83b39736@github.com>
Date:   Wed, 24 Aug 2022 15:08:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 1/2] builtin/grep.c: add --sparse option
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220817075633.217934-2-shaoxuan.yuan02@gmail.com>
 <80f24382-1188-d450-d1e2-42f68c08e60b@github.com>
 <74ff1a97-fa98-7280-9d84-35dafaf3cb3d@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <74ff1a97-fa98-7280-9d84-35dafaf3cb3d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/24/2022 2:20 PM, Shaoxuan Yuan wrote:
> Hi reviewrs,
> 
> I came back from busying with relocation :)

Welcome back! I'm looking forward to overlapping our timezones a bit more.
 
> On 8/17/2022 10:12 PM, Derrick Stolee wrote:
>> On 8/17/2022 3:56 AM, Shaoxuan Yuan wrote:
>>> Add a --sparse option to `git-grep`. This option is mainly used to:

>> Or something like that. The documentation updates will also help clarify
>> what happens when '--cached' is not included. I assume '--sparse' is
>> ignored, but perhaps it _could_ allow looking at the cached files outside
>> the sparse-checkout definition, this could make the simpler invocation of
>> 'git grep --sparse <pattern>' be the way that users can search after their
>> attempt to search the worktree failed.
> 
> This simpler version was in my earlier local branch, but later I
> decided not to go with it. I found the difference between these two
> approaches, is that "--cached --sparse" is more correct in terms of
> how Git actually works (because sparsity is a concept in the index);
> and "--sparse" is more comfortable for the end user.
> 
> I found the former one better here, because it is more self-explanatory,
> and thus more info for the user, i.e. "you are now looking at the
> index, and Git will also consider files outside of sparse definition."
> 
> To be honest, I don't know which one is "better", but I think I'll
> keep the current implementation unless something more convincing shows
> up later.

I think it is fine for you to keep the "--sparse requires --cached"
approach that you have now, since we can always choose to extend
the options to allow --sparse without --cached later.

Thanks,
-Stolee
