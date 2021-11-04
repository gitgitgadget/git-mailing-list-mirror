Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AC3C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 23:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D4561159
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 23:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhKDX5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 19:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKDX5s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 19:57:48 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09160C061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 16:55:10 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id q203so8750620iod.12
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 16:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=N0l7OT6D2d1Hty/dDzYwBUxacWpu1O5/OWePB8P7OeI=;
        b=fmnkq7km0a4QHvRwdhaMquXsJrTIiBEaBSeT3cevWc578RBrlAhjYYwBjT/49XJnDG
         gEBQTVimihvXiIud4KVYAq7NWn2Fj5qcLk1ulSZpVUhWkRqRsupoC2caAxC2/5LvlW+V
         97qzJL6eYqQQsnm0H0b4KA87SBYfokkjR+Gqa8b0oI7pT/O3EQljM7pDXwX7FK+V+2T7
         t2RjxjQ2ypebaT7EG2L67AN3IyAywkSV6cRjF2ex+gkE+liwOKrvleWNyZXBM4ZRtFgT
         mEhiPlcYqxpnYg4+nDmM4VQ+TmZ91UFfagjfoPJdKhZog0Ao2CNDSZCJxqwj56jz4Jf1
         rCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N0l7OT6D2d1Hty/dDzYwBUxacWpu1O5/OWePB8P7OeI=;
        b=Ey2bFFM67f36DuqCXnuNmMM+ZZLPB13X3hSDFzEng4NnTdSbxeOztYlIlrcIjyI/0M
         YAhp98Lz/wTJjn5wEn8IdiZWB2lZJK8K5C0puAqTlbqiFCLmD2E1XIClJ+jTmb9FNdnq
         T8oFnBLLxBCprsqfKAIAnpasM+Z6HYivYnAx2AGfnFGcaPDolfsOWFkhr/rzoe7O6nhN
         D4XKxGu42udh/AOxHk8/yeYmXZKMhmk/2wz9dMUjKfXvy7qF6mJDMafqVQ3Osjteaek4
         vTCLKtoplJk8ab38tKVeAhAU4SL6sVnSUx5RONDBpfebGJvoQrMqO//rO11mSOeVeekg
         cBHQ==
X-Gm-Message-State: AOAM531QqPeBTe7jWBp+bwLh8n8grbg/rk9hwi+nwJLWhkxtAPtCWphv
        +AhEWf9CNJHuyT0tqng/cls=
X-Google-Smtp-Source: ABdhPJyoq/V2GXA57Fs2d2z1NyqSiAItw6caiGYKAKdjMaaxXt4N/gfisqV8pJVuYMOLLIaZ35oBqQ==
X-Received: by 2002:a6b:f812:: with SMTP id o18mr8053861ioh.64.1636070109481;
        Thu, 04 Nov 2021 16:55:09 -0700 (PDT)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id q6sm3339444iow.1.2021.11.04.16.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 16:55:09 -0700 (PDT)
Message-ID: <1a269d05-49f6-6c49-860a-044070f14ffc@gmail.com>
Date:   Thu, 4 Nov 2021 16:55:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v3 1/2] diff: enable and test the sparse index
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1050.v2.git.1634332835.gitgitgadget@gmail.com>
 <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
 <991aaad37b41f71faa19fdef4373ccc115edcc40.1635802069.git.gitgitgadget@gmail.com>
 <xmqqcznh8913.fsf@gitster.g>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <xmqqcznh8913.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/3/21 10:05 AM, Junio C Hamano wrote:
> "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
>> 2000.34: git diff --staged (full-v3)      0.08    0.08 +0.0%
>> 2000.35: git diff --staged (full-v4)      0.08    0.08 +0.0%
>> 2000.36: git diff --staged (sparse-v3)    0.17    0.04 -76.5%
>> 2000.37: git diff --staged (sparse-v4)    0.16    0.04 -75.0%
> 
> Please do not add more use of the synonym to the test suite, other
> than the one that makes sure the synonym works the same way as the
> real option, which is "--cached".
>

Thank you, changed for v4.

>> diff --git a/builtin/diff.c b/builtin/diff.c
>> index dd8ce688ba7..cbf7b51c7c0 100644
>> --- a/builtin/diff.c
>> +++ b/builtin/diff.c
>> @@ -437,6 +437,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>>   
>>   	prefix = setup_git_directory_gently(&nongit);
>>   
>> +	prepare_repo_settings(the_repository);
>> +	the_repository->settings.command_requires_full_index = 0;
>> +
> 
> Doesn't the code need to be protected with
> 
> 	if (!nongit) {
> 		prepare_repo_settings(the_repository);
> 		the_repository->settings.command_requires_full_index = 0;
> 	}
> 
> at the very least?  It may be that the code is getting lucky because
> the_repository may be initialized with a random value (after all,
> when we are not in a repository, there is nowhere to read the
> on-disk settings from) and we may even be able to set a bit in the
> settings structure without crashing, but conceptually, doing the
> above when we _know_ we are not in any repository is simply wrong.
> 
> I wonder if prepare_repo_settings() needs be more strict.  For
> example, shouldn't it check if we have a repository to begin with
> and BUG() if it was called when there is not a repository?  After
> all, it tries to read from the repository configuration file, so any
> necessary set-up to discover where the gitdir is must have been done
> already before it can be called.
> 
> With such a safety feature to catch a programmer errors, perhaps the
> above could have been caught before the patch hit the list.
> 
> Thoughts?  Am I missing some chicken-and-egg situation where
> prepare_repo_settings() must be callable before we know where the
> repository is, or something, which justifies why the function is so
> loose in its sanity checks in the current form?
> 
> 

This seems like a good idea. I've added both the nongit check and the 
prepare_repo_settings() updates you've suggested for v4, pending review 
by my team.

Best,
Lessley
