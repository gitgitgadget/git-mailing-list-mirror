Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE5DC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 15:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbiA0POc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 10:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiA0POb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 10:14:31 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69234C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 07:14:31 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id w15-20020a4a9d0f000000b002c5cfa80e84so751970ooj.5
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 07:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oFOUPCBfJVqCtu0/xdeXSKZznad0wkc2KWWQMFodcGE=;
        b=DGLTzgtsj6AQtToT3B0RTOBh2DACht+A6zg19cYZOAYGyd5ePea7Lk27JtShrqMMhA
         iGKlztN5Fji7tUqX8LL6Ey5iRPWtjQWLSi33nLZduSR5SZUrUk6UEu1ShOoanuAOLVld
         mJCmV/7yDSx65m0uzUnEbngGxfy9WaLl4YPGEfO+LRz/9vmiXILSGMDuHO8NrKMamUUR
         dxoTSFTwyotD0hzN9V775f874wCCEVNc2fWPY1sHPam3wKireLXh89qDTMzJA7mZT9GD
         etc/uOdFXW4+dSDvHkvLxWHQpdWIuExRgpR0jSrjI65W/K7wThRoh+B9qeJX6HZliTbd
         Z40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oFOUPCBfJVqCtu0/xdeXSKZznad0wkc2KWWQMFodcGE=;
        b=LgJ/R/FcIxrR87TaBiJCBc8VEn1vwbc/a88AinIHbQoQe3hmkkTZVQ75QHmhFBZDjP
         AXRAYusCDfDsVzSMrgaZzl/+DtM98x/d51I7gdqPBQVamUecBWQA7T6q191pQiClIZya
         bfSHU4xY2QB8RvSF4U7v0PN6n7avW9KJ6jgg37/2ThxOsTary61xARiwivr18iq213Ml
         NVrjQ/Vd+yYrBTvXgGNYngEOQar7Wu3Nss1dffvfxqNhnARsRAj1CfYeX7CQlublk3NX
         Fns8jLUDdWPUfUsX5o1eKMMMYJ6MYH7VZ4+IMcvTAkVwu3faysOlim9yJIFftjoWAAGE
         QAgg==
X-Gm-Message-State: AOAM530dqpViYFDRMGpy6+/7EpRUCKEK1r4SQIyIqhVB4pVelYeNx56l
        aYoWyUrPqTL00OThhiSG4iq3CQQk5Uk=
X-Google-Smtp-Source: ABdhPJyq+oXlVIzr1cawTV5KBxegi8xVWIHhHaXR3eoy+IwWzaEAohkq/Un/MNYDqQBuE7hRP31c7Q==
X-Received: by 2002:a4a:a58f:: with SMTP id d15mr2114445oom.40.1643296470720;
        Thu, 27 Jan 2022 07:14:30 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d9cb:250e:9ea6:f8? ([2600:1700:e72:80a0:d9cb:250e:9ea6:f8])
        by smtp.gmail.com with ESMTPSA id 124sm10145971oif.7.2022.01.27.07.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 07:14:30 -0800 (PST)
Message-ID: <0a52155c-4605-d96f-965a-104a399ae86e@gmail.com>
Date:   Thu, 27 Jan 2022 10:14:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/5] scalar: teach `diagnose` to gather packfile info
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
 <330b36de799f82425c22bec50e6e42f0e495cab8.1643186507.git.gitgitgadget@gmail.com>
 <YfHOo8Mf3RP4j0Y6@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YfHOo8Mf3RP4j0Y6@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/26/2022 5:43 PM, Taylor Blau wrote:
> On Wed, Jan 26, 2022 at 08:41:45AM +0000, Matthew John Cheetham via GitGitGadget wrote:
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>>
>> Teach the `scalar diagnose` command to gather file size information
>> about pack files.
>>
>> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
>> ---
>>  contrib/scalar/scalar.c          | 39 ++++++++++++++++++++++++++++++++
>>  contrib/scalar/t/t9099-scalar.sh |  2 ++
>>  2 files changed, 41 insertions(+)
>>
>> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
>> index e26fb2fc018..690933ffdf3 100644
>> --- a/contrib/scalar/scalar.c
>> +++ b/contrib/scalar/scalar.c
>> @@ -653,6 +653,39 @@ cleanup:
>>  	return res;
>>  }
>>
>> +static void dir_file_stats(struct strbuf *buf, const char *path)
>> +{
>> +	DIR *dir = opendir(path);
>> +	struct dirent *e;
>> +	struct stat e_stat;
>> +	struct strbuf file_path = STRBUF_INIT;
>> +	size_t base_path_len;
>> +
>> +	if (!dir)
>> +		return;
>> +
>> +	strbuf_addstr(buf, "Contents of ");
>> +	strbuf_add_absolute_path(buf, path);
>> +	strbuf_addstr(buf, ":\n");
>> +
>> +	strbuf_add_absolute_path(&file_path, path);
>> +	strbuf_addch(&file_path, '/');
>> +	base_path_len = file_path.len;
>> +
>> +	while ((e = readdir(dir)) != NULL)
> 
> Hmm. Is there a reason that this couldn't use
> for_each_file_in_pack_dir() with a callback that just does the stat()
> and buffer manipulation?
> 
> I don't think it's critical either way, but it would eliminate some of
> the boilerplate that is shared between this implementation and the one
> that already exists in for_each_file_in_pack_dir().

It's helpful to see if there are other crud files in the pack
directory. This method is also extended in microsoft/git to
scan the alternates directory (which we expect to exist as the
"shared objects cache).

We might want to modify the implementation in this series to
run dir_file_stats() on each odb in the_repository. This would
give us the data for the shared object cache for free while
being more general to other Git repos. (It would require us to
do some reaction work in microsoft/git and be a change of
behavior, but we are the only ones who have looked at these
diagnose files before, so that change will be easy to manage.)

Thanks,
-Stolee
