Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7038C433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 14:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbiBIOpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 09:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiBIOpo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 09:45:44 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561EDC0613CA
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 06:45:47 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 4so2636545oil.11
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 06:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U9QukNE90rQK2LF+kYeFjQFaVoZgT8gr5WUxcRBVtDM=;
        b=lhGbtusKHCjm+9SEcINbrVfr3m3zRfuavDPDyzqcR9gGDewcdx0kHpjqWOBZCMBeBm
         ChivM/u68qn+MgOhqkz5fuHtJCjEy2pJyKYIj6OMmP3jCB8HP5bgzYVKEsVgVuHnL0V3
         QVh69e+dZhyhmyOaVRof00qaMTxxF9APA/tX4uc2dAqoFSQ7/2/jZX2wLXg+NC9mNlpM
         9ARnDqvTdpa6T2LG8zo23cbeAk3H6Yv9nC0rG/UAWyPnBc1sQIr2Kwnk7RY7l1jL1Qt/
         iouliNv8u5H8x0mUXz7QRKN2b9ayGil95z7cqmkgjURWUmY+DBLncyng5m9euzFuVOxv
         bm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U9QukNE90rQK2LF+kYeFjQFaVoZgT8gr5WUxcRBVtDM=;
        b=bL1ngBFY6yffv0w5lZfd3bjANO6AxNGz2aFIMzvBjr5CoQgp8dSX2o4RY5Ufa7qM+y
         lssZht5LMh3vpBLZeyyEo/oLfzCDY+OKI2oo5V8slM5kSNeRBDdD0LLbwb/YAapPr9JO
         CusF8b2wi4A47Un/UmdhaowzQ7C3QpdAq6Vs841mdZyktZ/pzX7oT02sK97auaw5mfwu
         En1cPn8q0TlEfBe9bsvdn0tH5+H8lLYG63Bi8NI94Wo48249vb4ncinssnt0prsvO5rd
         wgpR1BvITc2muU0NwbBRUZ3V/iKj/uX6fhN2FfvXf/SS8QtJymom3Q416hOLFIJhMJ/9
         jP/Q==
X-Gm-Message-State: AOAM530zod7obc+4zfm8bLRNVfysY2kFm7ft42JCzUQVNt7zKSHk+QsY
        MVdG+uKtb106tjRBek0vwU0=
X-Google-Smtp-Source: ABdhPJz0hGVOElvQGiWpYlZDnKCHjdFVZNiSUySobcb1agmgE273h46tbFdrpRKxCCkaXtkfMHXapg==
X-Received: by 2002:a05:6808:16a0:: with SMTP id bb32mr1102771oib.160.1644417946579;
        Wed, 09 Feb 2022 06:45:46 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:2177:fee8:1597:ac9f? ([2600:1700:e72:80a0:2177:fee8:1597:ac9f])
        by smtp.gmail.com with ESMTPSA id q18sm1126778otf.54.2022.02.09.06.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 06:45:46 -0800 (PST)
Message-ID: <837ca526-9ecd-6dd8-92b2-b8d05dde2032@gmail.com>
Date:   Wed, 9 Feb 2022 09:45:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 5/5] worktree: copy sparse-checkout patterns and config
 on add
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>,
        git@vger.kernel.org,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     sunshine@sunshineco.com, allred.sean@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
 <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <85779dfaed39220e18129e823aff9c95ade5985b.1643641259.git.gitgitgadget@gmail.com>
 <2328375.k9UJiU4Qo1@cayenne> <7d1d3cb5-2bfc-4f82-5230-d4c8d5896649@gmail.com>
 <9656f568-f5a4-0810-90a2-2ae1ced0e74f@free.fr>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <9656f568-f5a4-0810-90a2-2ae1ced0e74f@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/9/2022 2:53 AM, Jean-Noël Avila wrote:
> Le 07/02/2022 à 15:10, Derrick Stolee a écrit :
>> On 2/6/2022 5:36 AM, Jean-Noël AVILA wrote:
>>> On Monday, 31 January 2022 16:00:59 CET Derrick Stolee via GitGitGadget wrote:
>>
>> Hi Jean-Noël. Thanks for your attention to the translatable messages
>> here:
>>
>>>> error(_("failed to copy '%s' to '%s'; sparse-checkout may not work correctly"),
>>>>        from_file, to_file);
>>
>>>> die(_("failed to copy worktree config from '%s' to '%s'"),
>>>>      from_file, to_file);
>>
>>>> error(_("failed to unset 'core.bare' in '%s'"), to_file);
>>
>>>> error(_("failed to unset 'core.worktree' in '%s'"), to_file);
>>
>>> In the first patch of this series, you use _("unable to set '%s' in'%s'). Does it make sense to reuse this string here?
>>
>> I would argue that "unable to set" is not appropriate for any of these
>> messages. Perhaps the "failed to copy" messages might be able to use
>> "unable to set", but the information that the config setting is coming
>> from settings the user controlled is valuable.
>>
>> The "failed to unset" means "we are trying to _remove_ this setting
>> from the config file", so "unable to set" does not seem to work here.
>>
>> I'm open to revisiting this if you disagree.
>>
>> Thanks,
>> -Stolee
>>
> 
> Hi Derrick,
> 
> Sorry for not being more precise. The first two errors were not the subject of this remark.
> 
> For the last two, this is quite surprising that the same function failing (git_config_set_in_file_gently) can lead to different error messages.
> 
> In any case, I would argue at least for  shifting to :
> 
>     error(_("failed to unset '%s' in '%s'"), 'core.bare", to_file);
> and
>     error(_("failed to unset '%s' in '%s'"), "core.worktree", to_file);
> 
> in order to factorize the message and get the option name out of the way.

Thank you for the clarification! This makes sense as a way to
reduce load on translators. Sorry for misunderstanding.

Thanks,
-Stolee
