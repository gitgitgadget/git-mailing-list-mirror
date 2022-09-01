Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B402ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 16:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbiIAQPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 12:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbiIAQP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 12:15:28 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B321F2E5
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 09:15:06 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 73so8469284pga.1
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 09:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Nonb11LY3B/35PasIaPi0Upta3rNqODHcARisnZ8NZw=;
        b=E8MOz0a9r6pXxTxPIN6Nio3O5tPvkXgCIVQ2aWlK3P2CTdmBalkmVCXygEq+7WubOT
         1BQQ/a2m7jM3P/21oKX6vchNBRrpMM8r7hyiDKj9NNKOwJVmekUc4h3x9c+I2AGVrXqV
         e30Emf7TaIAlPuXrj7nCpS6vbcNelYBBSGTI858NE+kujFj1n6NVbpBVHd/0h45ib0SY
         lTsP/Itf6DeuBh+d2AZdTsFGHjR8VR+X3g+NQBLAcJ0IRH98mu/q22VaCezUiz6aRIvv
         /sg36e8EOhBfKtLvUepOU1wLqWubGezZnyfi326WdwHcZf49QrVO4QyJaewxsq5vmFWt
         eQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Nonb11LY3B/35PasIaPi0Upta3rNqODHcARisnZ8NZw=;
        b=AzgCPz2wJN84nk9qU0jQmAvvH0kmJqUs4kwHZXOgYjnwBHuaJSXvueBlW+ROCFFiiK
         ohtGljyOJ5Ze7bh/LF7+Qqr7tMdn0bJaQsDkJUVzO/bvLVz077w7GgFLeOlRlvko9Pkv
         tfCJEo9ztzs7F9xJ5NQ0CocnqarIK2LpY6CLONL8YkGHhmvm/1Ngw8ilCnW+7gWdlHRz
         i6eU6bb376QY1YcbLbd7GNtUv9WSY93T7lBEZkHcghtZFZPScw5FR/x9OLT/uOHnFhvj
         91AAfIL0OEIVJRhsRRVEfaVcckphZ18hXETbRgpotGJANPD0IdEVAF5F0vzmxzRTl1KK
         2w6A==
X-Gm-Message-State: ACgBeo3ZQ2KzIg2GUzpLzZX348d/6Fg95xb2wkeWGZa+zQmIdI4kVq0S
        4se4Hws6Tb6T0X4ft49f4d0D
X-Google-Smtp-Source: AA6agR6XlXvW+DcxAak/voSaZ6dl3j42M63eqzcoSIuQppGtq8uL/kjpOQ7lkgiFGEor9rJdSYPVNw==
X-Received: by 2002:a63:2c8b:0:b0:41c:5f9e:a1d6 with SMTP id s133-20020a632c8b000000b0041c5f9ea1d6mr26355504pgs.601.1662048905856;
        Thu, 01 Sep 2022 09:15:05 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id b4-20020a63e704000000b0040ced958e8fsm5486633pgi.80.2022.09.01.09.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:15:05 -0700 (PDT)
Message-ID: <586fc6ca-b699-14a9-c5a1-10323a1cde0c@github.com>
Date:   Thu, 1 Sep 2022 09:15:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 6/8] t/perf: add Scalar performance tests
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
 <42ab39f21212d3da1af3546d3425aa790637056f.1661961746.git.gitgitgadget@gmail.com>
 <59s7o8n8-5797-q2qo-4q0o-93qppnr92q52@tzk.qr>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <59s7o8n8-5797-q2qo-4q0o-93qppnr92q52@tzk.qr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> Hi Victoria,
> 
> On Wed, 31 Aug 2022, Victoria Dye via GitGitGadget wrote:
> 
>> [...]
>> +
>> +test_compare_perf () {
>> +	command="$@"
>> +	test_perf "$command (scalar)" "
>> +		(
>> +			cd scalar-clone/src &&
>> +			$command
>> +		)
>> +	"
>> +
>> +	test_perf "$command (non-scalar)" "
>> +		(
>> +			cd git-clone &&
>> +			$command
>> +		)
>> +	"
>> +}
>> +
>> +test_compare_perf git status
>> +test_compare_perf test_commit --append --no-tag A
> 
> Given the small numbers presented in the commit message, I suspect that
> even so much as running the command in a subshell might skew the timings
> at least on Windows, where subshells are very, very expensive.
> 
> Given that both `git` and `test_commit` understand the `-C <directory>`
> syntax, this variant would resolve my concern:
> 
> 	test_compare_perf () {
> 	     command=$1
>              shift
> 	     args="$*"
> 
> 	     test_perf "$command (scalar)" "
> 	             $command -C scalar-clone/src $args
> 	     "
> 
> 	     test_perf "$command (non-scalar)" "
> 	             $command -C git-clone $args
> 	     "
> 	}
> 
> What do you think?

Makes sense to me! Although, out of curiosity, is there a reason you prefer
"$1 -> shift -> $*" over '$1' and '$@'? 

> 
> Ciao,
> Dscho

