Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A38AC433FE
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 14:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243182AbiBJOsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 09:48:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243170AbiBJOsY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 09:48:24 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ACBD82
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 06:48:25 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id s6-20020a0568301e0600b0059ea5472c98so3927952otr.11
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 06:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=agDQRWwKTV1r9m8TSso5V3HusrrnoOPeG6yb8nsB6WQ=;
        b=naBKow3f/UnjuhkIrutlHobW9nwRxvjj3RkNu2MQ8F1be7y5ByStjAphY9CDXHYQZS
         GgNywD4aX+b+lPgF3A5f1dEd45ETI18+v0jAY3K0GfUtsKA32QVaGlplTbGCP7dTl+Bn
         7uE9C3rskmxtiPRHU6X/DEjoFGGSPvgfg4MTnXhsRkexBZtxT7TH/yqqPrqgfXndVvDp
         6fhLPll2NsTFmkLqpyhbXvmW/cW1hur0lWeZ6kKK//E6FrT7d5OoElxKv72te2rEDsUd
         EEPi9PbBP1QOHKrU1s3N/LTkJfWnOw7+eBzgKGDZ57hx5jRnE4bwub4gKn8Pdm1dbPCw
         /g/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=agDQRWwKTV1r9m8TSso5V3HusrrnoOPeG6yb8nsB6WQ=;
        b=Ik07skF0VckwrMiRDjqXOuFK5ChM6lZMXnkL42jtc5/PDyt6dyz24dm0NdGE+KhMAg
         ILhc9U1A3lkohR1lDk2n8XYqii+uptgkOi6RVZj8thYGt0anNVSEQ/4J1lEb95szUqgd
         mPQChKTuxNPNxZqIECHRAxCN+NUZxM6FpsX/Zx3/K4k5+fobr52IOX1da3E4jCeAQN2i
         tK4WwqRG+YX2TlV+4lOFJYjZ2NUXgMSVy3fpNBDOatw6wyeZrb7aUvRiQF4dSJbiFCyf
         rvV+pNuuMh9qIH14P3q+agV/XgEkmwNVyzXvUAz4SN64o4PX4gZwDLSYDHLEUIs/essH
         YHTw==
X-Gm-Message-State: AOAM5315qMxo10QBKkWA+TZW45x5QYLHOJ4Hq5pBinZT7nY5EXcPBCnh
        Cu92mJpJ5tvS7yAMtK8JXg8=
X-Google-Smtp-Source: ABdhPJxDPAlMkzQiEbOxGxlVF4gpdU1/4RcdNxZg9D0PrfSGanXVAn7LGMHMRYGBd+kLrlCSq4SXgg==
X-Received: by 2002:a9d:6c13:: with SMTP id f19mr3021366otq.87.1644504504440;
        Thu, 10 Feb 2022 06:48:24 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:9556:7d7f:ddbf:443c? ([2600:1700:e72:80a0:9556:7d7f:ddbf:443c])
        by smtp.gmail.com with ESMTPSA id z20sm275055oap.17.2022.02.10.06.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 06:48:23 -0800 (PST)
Message-ID: <2b88fa25-ec40-6416-05c8-81789a415844@gmail.com>
Date:   Thu, 10 Feb 2022 09:48:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v6 3/6] config: add repo_config_set_worktree_gently()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sunshine@sunshineco.com,
        allred.sean@gmail.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>,
        derrickstolee@github.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
 <cf9e86fe3a403d0ceaff9fdf484a9bf6b07799ac.1644269583.git.gitgitgadget@gmail.com>
 <xmqqv8xpato3.fsf@gitster.g> <ab6021a8-cbb9-3261-8e08-bb4a83287473@gmail.com>
 <xmqqzgn07wwf.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqzgn07wwf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/9/2022 12:49 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 2/8/2022 5:18 PM, Junio C Hamano wrote:
>>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> ...
>>>> @@ -3181,14 +3196,28 @@ void git_config_set_multivar_in_file(const char *config_filename,
>>>>  int git_config_set_multivar_gently(const char *key, const char *value,
>>>>  				   const char *value_pattern, unsigned flags)
>>>>  {
>>>> -	return git_config_set_multivar_in_file_gently(NULL, key, value, value_pattern,
>>>> -						      flags);
>>>> +	return repo_config_set_multivar_gently(the_repository, key, value,
>>>> +					       value_pattern, flags);
>>>> +}
>>>
>>> Is this an unrelated "morally no-op" change?
>>
>> This one is to match the pattern of how "git_*" methods should
>> depend on their "repo_*" counterparts (with "the_repository" inserted
>> properly). So, it's part of the standard process for creating these
>> "repo_*" variants.
> 
> If only one of repo_config_set_multivar_gently() and
> git_config_set_multivar_gently() existed and we were completing the
> pair, then I would understand the explanation, but the title says
> that it is adding repo_config_set_worktree_gently(), which is not,
> and that is where the "unrelated" comes from.
> 
> It needs to be a separate preparatory step to add
> repo_config_set_multivar_gently() before we add
> repo_config_set_worktree_gently(), perhaps?

True, they could be split. The reason to create the _multivar_
version is for the case that worktree config is not specified,
so that is the only caller at the moment.

> A bit higher level question is if the public part of "config-set"
> API functions should gain an "easy" (in the sense of curl_easy_* set
> of API functions) API to allow the callers to say "I do not care to
> find out if per-worktree configuration is in use, or this particular
> variable is meant to be per-worktree, just set it to this value".
> 
> On this question, I am of two minds.  As certain variables (like
> core.sparseCheckout) should always be per-worktree just like certain
> refs (like HEAD) should always be per-worktree, I can understand the
> viewpoint that the callers _ought_ to know and explicitly say that
> they want to get/set in the per-worktree configuration file, but at
> the same time, I would think the callers should not have to care.
> So, I dunno.

This is an interesting idea. This would require creating a list
of "should be per-worktree" config keys that are checked within
the different *_config_set_* methods.

The biggest technical hurdle is that the multivar versions might
need to send a subset of the given config into the worktree
config and the rest to the common config.

Let's see how this progresses in the future, and whether we
have more config that we believe _must_ be stored on a per-
worktree basis. At that point, we can see whether the current
"distributed responsibility" model is too cumbersome.

Thanks,
-Stolee
