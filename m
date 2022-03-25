Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83459C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 13:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358745AbiCYN5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 09:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358681AbiCYN45 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 09:56:57 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97B4D372A
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 06:55:23 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id v75so8245552oie.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9FW57SOkmOISUwfnpd+W4pW7DAV+9TtvIJHRJav4cUw=;
        b=aRWmsICgArAq33RqpqAbsd9/ngldvpYSvm+pYk1koTgyD+xxzgHt+waoi/qDaF/1Yc
         f18xoV8ka0v9e12YNnT0z+szJ/KP1J9V5ccq0oC5hDAp4CjzSU5E7fHbJE/WUtnmFo/b
         m4Q7Kw8NNn4ntnT9kB1AJHjMU9b4BrHLWVMpvVmz8DHD9j+E67XhpMRWIzd+1220fWJ/
         62wepFV9nVa3jitfFaPYT6gBouap2L7S29+1jiNxQftoV2e7CZ3d3aa0XYAFSRo3Pf6S
         EfrefFgxDm2QriG0ECsiqc5PPt4/LEaGyAzwHFD8ZmZgIUmkygXW/3XfY5Mnc8NXyDq2
         FoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9FW57SOkmOISUwfnpd+W4pW7DAV+9TtvIJHRJav4cUw=;
        b=XFD4arZEQcCcecRzN6JVWaR07Yx7uXa5WI3LJASwEyT2b1ikYwi7MYCPpBV3bEXfiP
         577YVFrpF7PTIZ4FoXAyT2+ESA9uq6Ivlu5SDrLyseTDUuebaLkOvaRhts1gi5hEaWhU
         0777W8oscDHD4gjo4iZoUerT/aIOsMtHn5lNHSBBsoX8pcPxN1VkN0veeYDgmHyzRoOi
         y11u7U10ahHtuAwq+uicqerEkhiP83ZYbLEH9DInbn9w3Hc3/inAUrkLh4MWdLopOy+P
         nRi3wanqxspsO5Omv7m1jhW+q1FHFv+D+gY7+DNDcrfTVoLGqim5DvhkbPkU57+8fTdv
         l6tg==
X-Gm-Message-State: AOAM533WdkQR7xLgBy2p+LC3EGdaOPNH86mmCT0ftBxEMNijv60Bju26
        po44hPTSJUxzlrsApyUIGii3
X-Google-Smtp-Source: ABdhPJxIDdqBwhZTzHPuzRc/dDOgR4rExt3UUZO2/kwM/1TPFpxPndbFFhVjYlJHYXRiweFNeJLQnw==
X-Received: by 2002:a05:6808:2384:b0:2ec:d134:1e8b with SMTP id bp4-20020a056808238400b002ecd1341e8bmr10020966oib.197.1648216522974;
        Fri, 25 Mar 2022 06:55:22 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t7-20020a9d5907000000b005afa4058a4csm2630969oth.1.2022.03.25.06.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 06:55:22 -0700 (PDT)
Message-ID: <7ea0f7e4-180d-307d-2e2e-d33c3343317c@github.com>
Date:   Fri, 25 Mar 2022 09:55:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] t7700: check post-condition in kept-pack test
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        chakrabortyabhradeep79@gmail.com
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
 <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
 <f2f8d12929bcbd630b2de3ce770a6763989ffcff.1648146897.git.gitgitgadget@gmail.com>
 <Yjy/UIydKw7v+4+7@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yjy/UIydKw7v+4+7@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/24/2022 2:58 PM, Taylor Blau wrote:
> On Thu, Mar 24, 2022 at 06:34:56PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>

>> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
>> index 770d1432046..73452e23896 100755
>> --- a/t/t7700-repack.sh
>> +++ b/t/t7700-repack.sh
>> @@ -369,10 +369,56 @@ test_expect_success '--write-midx with preferred bitmap tips' '
>>  	)
>>  '
>>
>> +get_sorted_objects_from_packs () {
>> +	git show-index <$(cat) >raw &&
> 
> It seems a little odd to me to pass the name of a single file as input
> to get_sorted_objects_from_packs over stdin. I probably would have
> expected something like `git show-index <"$1" >raw && ...` instead.

Based on the way we are creating a file whose contents is the name
of the .idx file, we would at least use '$(cat "$1")'. I kind of like
the symmetry of the input/output redirection when using the helper, but
I can easily change this.

> We may also want to s/packs/pack, since this function only will handle
> one index at a time.

Yes.

>> +	cut -d" " -f2 raw | sort
> 
> Having the sort in there is my fault, but after reading this more
> carefully it's definitely unnecessary, since show-index will give us
> the results in lexical order by object name already.

Cool. Will drop.

>> +}
>> +
>>  test_expect_success '--write-midx -b packs non-kept objects' '
>> -	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
>> -		git repack --write-midx -a -b &&
>> -	test_subcommand_inexact git pack-objects --honor-pack-keep <trace.txt
>> +	git init repo &&
>> +	test_when_finished "rm -fr repo" &&
>> +	(
>> +		cd repo &&
>> +
>> +		# Create a kept pack-file
>> +		test_commit base &&
>> +		git repack -ad &&
>> +		find $objdir/pack -name "*.idx" >before &&
> 
> I thought that here it might be easier to say:
> 
>     before="$(find $objdir/pack -name "*.idx")"
> 
>> +		>$objdir/pack/$(basename $(cat before) .idx).keep &&
> 
> ...and then replace "$(cat before)" with "$before", along with the
> other uses of the before file below. But it gets a little funny when
> you want to discover which is the new pack, where it is more natural to
> dump the output of comm into a file.

For this reason, I'll continue to store the .idx names in files.

>> +		# Get object list from the one non-kept pack-file
>> +		comm -13 before after >new-pack &&
> 
> You could write "new_pack=$(comm -13 before after)", but debugging this
> test would be difficult if the output of comm there contained more than
> one line.
>
>> +		get_sorted_objects_from_packs \
>> +			<new-pack \
> 
> Though we probably want to check that we only get one line anyway here,
> since get_sorted_objects_from_packs will barf if we had more than one
> line in file new-pack here, too.

Thanks. Easy to add a test_line_count before this check.

-Stolee
