Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9ADC07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 17:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiIZRwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiIZRv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 13:51:59 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9FE1144B
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:25:54 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id q83so5799576iod.7
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=VjZq4jnVUdnBrCYLyfz0Z/qvTE9nOabjzp/cc4sU/VA=;
        b=d8p+/WgyVME03xDVBjMhVnyRdhWyi33DBNQASysBqGBdQYmeVBm3EEzvMmYvg4xJwY
         x2HIrQ6c6CANElMFS5JZo65vx5izPxQoL0lnVyi283gt2UXapSLHld5gyR2FQHBBf+/R
         oQ3D4KJlRr1yLWL/SfK1gXWIa5f5k4ZlJSbM6TxMZgUGl8AuQ/czhuf8TVL1c1xHe2Xj
         DMovXstOM+D5CavdeDaO9If/9uBBOz2yL7FBMH/ZRwq7lzdPeYQQKI4Ntenz6qIfImlh
         0SRWTJhwZKZ0CMlsKiPoDz3lSQG/Z6ikpdWINtITf3FRROmKgV5ZYUTVP4ZpuqDvrmHv
         Y6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VjZq4jnVUdnBrCYLyfz0Z/qvTE9nOabjzp/cc4sU/VA=;
        b=JtwvahDw9Ux8AiBb3ZMG1Js19YHAE8aJ4Z0AUtkwXKknuLBLP9OcXfTF+tTY5mbUZX
         4dEBoLxBZObxpG090o7loZRtlbUPGgf0HwFvAmxAzyQAH9w0lcymIY3NHxRvPSXujsSm
         zok5/IaxbCFpXSk5lPA2O0PQKJpfITCX4f706lJcnHeNCaZuqDobcJZ3QBsViHpvJh0C
         fu4W62G7kU3V4MP826JO22eRGCSiiu97eoua2Wwj/27SrpRGt6DqcWim+tXBl7mQghkF
         yXItdnh7/JyL3P/MDKm7TJ1HcmBMz5nRurjO6maKM2Uhx1Pb377iqw+sxmiDuzF/EVxB
         MHCw==
X-Gm-Message-State: ACrzQf3aejgznBlmSuCarXDNWSCfMxrZ2A7O5x9IJ2byNEFvhRchWT3G
        8rGUc+SudqGaeF4kLSK5uz3N
X-Google-Smtp-Source: AMsMyM5+VF9T85lf5QgV4Hnld4hv1AjZaEf6BxUbzVK0faAIqS6sloLC9vJOmI/EedzanhUQfUMAGw==
X-Received: by 2002:a05:6638:4987:b0:358:448d:ec40 with SMTP id cv7-20020a056638498700b00358448dec40mr12538761jab.288.1664213153919;
        Mon, 26 Sep 2022 10:25:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:4177:874e:9632:3b2a? ([2600:1700:e72:80a0:4177:874e:9632:3b2a])
        by smtp.gmail.com with ESMTPSA id f11-20020a92b50b000000b002e8ea827aafsm1375992ile.74.2022.09.26.10.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 10:25:53 -0700 (PDT)
Message-ID: <22a767da-5ae0-5a8f-d5f4-f2c5cc217be4@github.com>
Date:   Mon, 26 Sep 2022 13:25:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 1/2] maintenance: add 'unregister --force'
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, vdye@github.com
References: <pull.1358.git.1663635732095.gitgitgadget@gmail.com>
 <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
 <69c74f52eefd906c38494759a02e137e4d7c01d8.1663853837.git.gitgitgadget@gmail.com>
 <20220923130832.GA1761@szeder.dev>
 <fc6739c3-2f7c-5dab-e4a2-8243deafde50@github.com>
 <220926.86mtamyvo7.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220926.86mtamyvo7.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/26/2022 11:39 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Sep 26 2022, Derrick Stolee wrote:
> 
>> On 9/23/2022 9:08 AM, SZEDER Gábor wrote:
>>> On Thu, Sep 22, 2022 at 01:37:16PM +0000, Derrick Stolee via GitGitGadget wrote:
>>>>  static int maintenance_unregister(int argc, const char **argv, const char *prefix)
>>>>  {
>>>> +	int force = 0;
>>>>  	struct option options[] = {
>>>> +		OPT_BOOL(0, "force", &force,
>>>> +			 N_("return success even if repository was not registered")),
>>>
>>> This could be shortened a bit by using OPT__FORCE() instead of
>>> OPT_BOOL().  OTOH, please make it a bit longer, and declare the option
>>> with the PARSE_OPT_NOCOMPLETE flag to hide it from completion:
>>
>> Looks like I can do both like this:
>>
>> 		OPT__FORCE(&force,
>> 			   N_("return success even if repository was not registered"),
>> 			   PARSE_OPT_NOCOMPLETE),
> 
> I don't think PARSE_OPT_NOCOMPLETE is appropriate here. Yes we use it
> for most of --force, but in some non-destructive cases (e.g. "add") we
> don't.
> 
> This seems to be such a case, we'll destroy no data or do anything
> irrecoverable. It's really just a
> --do-not-be-so-anal-about-your-exit-code option.

I agree, so I wasn't completely sold on PARSE_OPT_NOCOMPLETE. I'll use
your vote to not add that option.

> I'm guessing that you wanted to be able to error check this more
> strictly in some cases. For "git remote" I post-hoc filled in this
> use-case by exiting with a code of 2 on missing remotes on e.g. "git
> remote remove", see: 9144ba4cf52 (remote: add meaningful exit code on
> missing/existing, 2020-10-27).

Generally, I'm not terribly interested in the exit code value other
than 0, 128, and <otherwise non-zero> being three categories. I definitely
don't want to create a strict list of exit code modes here.

> In this case we would return exit code 5 for this in most case before,
> as we wouldn't be able to find the key, wouldn't we? I.e. the return
> value from "git config".

We definitely inherited an exit code from 'git config' here, but
I should probably convert it into a die() message to make it clearer.

> This code now has a race condition it didn't before. Before we just did
> a "git config --unset" which would have locked the config file, so if we
> didn't have a key we'd return 5.
> 
>> +	if (found) {
> 
> But here we looked for the key *earlier*, so in that window we could
> have raced and had the key again, so ....
> 
>> +		config_unset.git_cmd = 1;
>> +		strvec_pushl(&config_unset.args, "config", "--global", "--unset",
>> +			     "--fixed-value", key, maintpath, NULL);
>> +
>> +		rc = run_command(&config_unset);
>> +	} else if (!force) {
> 
> ...found would not be true, and if you you didn't have --force...
> 
>> +		die(_("repository '%s' is not registered"), maintpath);
>> +	}
>>  
>> -	rc = run_command(&config_unset);
> 
> ...this removal would cause us to still have the key in the end, no? I.e.:
> 
>  1. We check if the key is there
>  2. Another process LOCKS config
>  3. Another process SETS the key
>  4. Another process UNLOCKS config>  5. We act with the assumption that the key isn't set

I think this list of events is fine, since we check the value and then
do not try to modify state if it isn't there.

Instead if we had this scenario:

 1. We check and see that it _is_there.
 2. Another process modifies config to remove the value.
 3. We try to remove the value and fail.

In this case, the --force option would still fail even though the end
result is the same. We could ignore a "not found" case during a --force
option to avoid failing due to such concurrency.
 
> Maybe it's not racy, or it doesn't matter.
Generally, I think in this case it doesn't matter, but we can be a bit
more careful about handling races.

Thanks,
-Stolee
