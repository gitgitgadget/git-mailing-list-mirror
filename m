Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F004C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 00:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD416121E
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 00:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhKEAHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 20:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbhKEAHa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 20:07:30 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B885DC061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 17:04:51 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n128so8898470iod.9
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 17:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4dgpA+kyIgyRHjz8AE2ecJ3NQUSJduJhBhXUYe1+uwc=;
        b=W4A37i2HqifcZ5H19ICm0WMw1UYmJsDFAd462HdvXmUqGf9ul1YF7Zb30V8BqetFXH
         YIkiifeB6+8z0ihedHVcNzTQuNmR/vnCzfrhfHiSQ8V3OSuft6aAiqJ+UtnYfHGAkK2+
         CtsmEDx2jsrU7WKqOF7ovpKscSlRxI6wXtGprhhMx1zUIlSrrDB8X6whYH27R/atZ1Iu
         r5FXW2mvu9GFbIHXIVHplMwweG9PgHXRucpzkKBDulUccswU9abnzQN/6hncWYBVH7lH
         I3I1qMJ7qgAr7yOCnFp9Dr6DUx65Yze6eDIOkTIld94nLyeHMnfxqddTrgcmrNGFszSr
         cX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4dgpA+kyIgyRHjz8AE2ecJ3NQUSJduJhBhXUYe1+uwc=;
        b=uANPvb7JMPjfmp7rLXfvj0mQrXoDgaGj4cJ7C1GolJ3qTTOoewEqCmBAS+YHBLPcLD
         /rVMSKYbiKjeFjwkcM6tKaSot2oOnvnYN3L6/FGTEsd+QDZlCADX6pAAH7rERgWNDTEZ
         2KiZ07wTODg+ZB+uxwqD7S1+1mERaZv8NGm+QxOsPgRCmZqV35L7ELV1O+avJtkBVPBU
         kAXwMWtttWLBEYK/ZGOzMreZ5DHCVje9zRcuAtVClblMlParUL1iQWvhEpVFGiUWenxq
         tNdAk5rYFm+pAdO71Ke8g1kSIP/E/9zQfBg+3tcI/dYT9P4TKkBQeZtXjB4JFeEzAH4S
         FPwg==
X-Gm-Message-State: AOAM530gDZ+VGVcuvGx5JPDczZsxVMM/U1nRB757hT61saLKdc+ksQwC
        dj/SeEWTpmuHhdBk9NYtJkwJPV2Zwec=
X-Google-Smtp-Source: ABdhPJykmLP8MLaTXAykKWpaIJmZ1sIrO4zOVIxUOlvOEsTKHp6FvmxCj2P8FgTErmDsLlwQrsxfAQ==
X-Received: by 2002:a05:6638:268c:: with SMTP id o12mr6377466jat.93.1636070691160;
        Thu, 04 Nov 2021 17:04:51 -0700 (PDT)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id s12sm3197630iol.30.2021.11.04.17.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 17:04:50 -0700 (PDT)
Message-ID: <49ada9fe-3cd5-622d-fdc7-92f95b040b47@gmail.com>
Date:   Thu, 4 Nov 2021 17:04:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v3 2/2] blame: enable and test the sparse index
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1050.v2.git.1634332835.gitgitgadget@gmail.com>
 <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
 <cfdd33129ec6860cbec0cb20302598429db1115e.1635802069.git.gitgitgadget@gmail.com>
 <xmqqh7ct89us.fsf@gitster.g>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <xmqqh7ct89us.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/3/21 9:47 AM, Junio C Hamano wrote:
> "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
>> We do not include paths outside the sparse checkout cone because blame
>> currently does not support blaming files outside of the sparse definition.
>> Attempting to do so fails with the following error:
>>
>>    fatal: no such path '<path outside sparse definition>' in HEAD
> 
> Does this indicate that we need to update how the command line
> safety in verify_working_tree_path() works in a sparsely checked out
> working tree?  If foo/bar is outside the sparse definition,
> 
>      git blame HEAD foo/bar
> 
> may get such a message, but shouldn't
> 
>      git blame HEAD -- foo/bar
> 
> make it work?
> 
This is something we could consider for the future, and I've updated the 
comment you called out below to better reflect that in the next version. 
However, I don't know that this change belongs in this series, which 
aims to enable the sparse index. Perhaps even updating the 'blame with 
pathspec outside sparse definition' test was a bit too far outside the 
target scope of this change - I can remove my updates if that is the case.

>> -# TODO: blame currently does not support blaming files outside of the
>> -# sparse definition. It complains that the file doesn't exist locally.
>> -test_expect_failure 'blame with pathspec outside sparse definition' '
>> +# Blame does not support blaming files outside of the sparse
>> +# definition, so we verify this scenario.
> 
> IOW, why is it a good idea to drop the "TODO" and "currently" and pretend
> as if the current behaviour is the desirable one?
> 
Thank you, updated for v4.

>> +test_expect_success 'blame with pathspec outside sparse definition' '
>>   	init_repos &&
>> +	test_sparse_match git sparse-checkout set &&
>>   
>> -	test_all_match git blame folder1/a &&
>> -	test_all_match git blame folder2/a &&
>> -	test_all_match git blame deep/deeper2/a &&
>> -	test_all_match git blame deep/deeper2/deepest/a
>> +	for file in a \
>> +			deep/a \
>> +			deep/deeper1/a \
>> +			deep/deeper1/deepest/a
>> +	do
>> +		test_sparse_match test_must_fail git blame $file &&
>> +		cat >expect <<-EOF &&
>> +		fatal: Cannot lstat '"'"'$file'"'"': No such file or directory
>> +		EOF
>> +		# We compare sparse-checkout-err and sparse-index-err in
>> +		# `test_sparse_match`. Given we know they are the same, we
>> +		# only check the content of sparse-index-err here.
>> +		test_cmp expect sparse-index-err
>> +	done
>>   '
>>   
>>   test_expect_success 'checkout and reset (mixed)' '
>> @@ -878,6 +892,18 @@ test_expect_success 'sparse index is not expanded: diff' '
>>   	ensure_not_expanded diff --staged
>>   '
>>   
>> +test_expect_success 'sparse index is not expanded: blame' '
>> +	init_repos &&
>> +
>> +	for file in a \
>> +			deep/a \
>> +			deep/deeper1/a \
>> +			deep/deeper1/deepest/a
>> +	do
>> +		ensure_not_expanded blame $file
>> +	done
>> +'
>> +
>>   # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
>>   # in this scenario, but it shouldn't.
>>   test_expect_success 'reset mixed and checkout orphan' '

Best,

Lessley
