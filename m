Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B306C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 00:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354669AbhLBArF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 19:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354957AbhLBApJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 19:45:09 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADE2C06175A
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 16:41:43 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id r26so52135858oiw.5
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 16:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=W/4pDFYAfRSIWoTbeclI1eoAsTEEynIJMJvzvVCQZPk=;
        b=XmXsI1enMIbcPQqG6oCPuqnrPFTdFRmfhGuL4REqxe6m5IuK+A3KsJi2TkRl/ukYLU
         OpffNsXp4YSS3DyXSM1OonOCMWg5wTzZeDgXScu7Bmv9/JqbfIUkziW7St3IDlwEGK9o
         iMWy/D7WzfW5jkNEbkvZCd/lK1yjrwxbTFYDMZJ4LoJq1QA2VRlJQMPkd8OEWDeAkHmb
         N34fuxfNcOlZmDaY2G6/auxSAkqD6/YxiKJyNmMC3A8Ugltx/VWvyMKgWvickJ0x05Hw
         N8ooUyNu34nHYAArt00KLWwKyoUDqDkb5hVD/+bB4Z0t0hYn+6uOp47a3vwsBmc6iBDF
         fiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W/4pDFYAfRSIWoTbeclI1eoAsTEEynIJMJvzvVCQZPk=;
        b=WkqCWXNWj0529zDHqQq2YmMkJuQwi/288QIc19FTTVEylWO4H7EK77czTgv4DPdciO
         We49BKx0MA9skkKtcHF4L5qcMQfWzrg6kNSbCTNe6UJW0Z9VWmcxGefs+oqU/LUaXSZM
         QXAQHFbvzj4D7wByyVvJOJD6XaaSroo0Vk+MMhe5ESQVljmgJ0rpJRDf0xvniZDfnV/V
         AA/OSTXHzwNl1Dlz6XqMAjTUtJ2KN7T/+prCEwnorFSFmGbSi2f68S6rXgZG7FdKA8KZ
         KX3mVv5iuSG2U69dCj/mDFSGGyl/aRs8usrc3cIXsDp/NwpzR1qYQ9aYEW+7KtPyFJHu
         Zd8g==
X-Gm-Message-State: AOAM531S88EG7vo6oJJWCbsWwsDS2YNAbvdVsS580C3LwgDwUWJrm4zn
        N+sUcr+++stjuMUKf7Vs3yY=
X-Google-Smtp-Source: ABdhPJwT8baQbxq87q1hR2asHSS6LrmiRrDXN6uTziGihmca7rcZgovL+ldqE/i4/rDevYZ7iA3YHA==
X-Received: by 2002:a05:6808:300b:: with SMTP id ay11mr1783439oib.120.1638405702555;
        Wed, 01 Dec 2021 16:41:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:ed3e:6f2c:4b0e:6260? ([2600:1700:e72:80a0:ed3e:6f2c:4b0e:6260])
        by smtp.gmail.com with ESMTPSA id v12sm529122ote.9.2021.12.01.16.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 16:41:42 -0800 (PST)
Message-ID: <d981adbf-7f6a-32f8-2d3e-8af5c36a6f8f@gmail.com>
Date:   Wed, 1 Dec 2021 19:41:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: 2.34 regression (and workaround): deleting untracked files both
 outside *and inside* desired sparsity cone
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CABPp-BE8TJ8QGAQWsSGT7S+9Xp-XmApcC9PSw3K=RQOP0rt+PQ@mail.gmail.com>
 <9c7afd37-9940-e6e7-da41-8a44840defb3@gmail.com>
 <CABPp-BHSPQMUw8a6E7Kz+7L6NuD8c9GrHdTMf_rBzQR+2VGs-Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BHSPQMUw8a6E7Kz+7L6NuD8c9GrHdTMf_rBzQR+2VGs-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/1/2021 6:40 PM, Elijah Newren wrote:
> On Wed, Dec 1, 2021 at 11:19 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> We would want to be careful now that
>> "--option" could be interpreted as a path to recommend using
>>
>>   git sparse-checkout set <options> -- <path1> ... <pathN>
> 
> Makes sense.  However, wasn't this already an issue when you added
> `--stdin` as an option for the `set` command?

You are right. This should already be handled in a sane way.
 
>> While you are here, I would be interested in making 'git clone
>> --sparse' default to cone mode. Or, should it be 'git clone
>> --sparse=cone' or something? Not making it default to cone mode
>> is a big regret of mine.
> 
> I agree it'd be much nicer to have it default to cone mode, and the
> big warning in git-sparse-checkout.txt might permit us to do so.  A
> few related questions:
> 
> * Should we document how to change from cone mode to non-cone mode?
> We have --sparse-index, --no-sparse-index, and --cone flags, but no
> --no-cone one.  Should we?  (Do these flags belong somewhere other
> than `init` since it's toggling some other flag while already using a
> sparse-checkout?)

--no-cone exists, it probably just isn't in the docs. Our 'init'
options are defined as follows:

	static struct option builtin_sparse_checkout_init_options[] = {
		OPT_BOOL(0, "cone", &init_opts.cone_mode,
			 N_("initialize the sparse-checkout in cone mode")),
		OPT_BOOL(0, "sparse-index", &init_opts.sparse_index,
			 N_("toggle the use of a sparse index")),
		OPT_END(),
	};


so --no-cone exists the same way --no-sparse-index does.

> * Should we clean up the wording in clone's --sparse option?  In particular:
> 
> --sparse::
> Initialize the sparse-checkout file so the working
> directory starts with only the files in the root
> of the repository. The sparse-checkout file can be
> modified to grow the working directory as needed.
> 
> This wording seems to suggest direct editing of
> .git/info/sparse-checkout, and might confuse users.  Perhaps the last
> sentence could change "sparse-checkout file can be modified" ->
> "sparse-checkout command can be used" or something like that?

This is probably just too old. It could use updates to link to
git-sparse-checkout.

Thanks,
-Stolee
