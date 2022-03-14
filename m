Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1254C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 16:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242969AbiCNQZ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 12:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242978AbiCNQZy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 12:25:54 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05693AE72
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:24:44 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id p10-20020a056820044a00b00320d7d4af22so3015625oou.4
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yURCk+609AgA1ES+x9/eaUKy7mX+7W216LBzbg+Oblo=;
        b=WFBvv4Pr6NVfXtzKhBaTcyrjOsCR4Uoy9OmfQpfQmpNdkXoEmNWNO1UrmTp6LlszV/
         7G2JxtM5JxBItd9JO7CL3SiAK7+0D9HIKMnaNpNg18DbZpVWgS5H7yyDevdKUtzY0i6i
         ELSczXdZIOaqL4P5/cyoDfr27i4PbbGa+eNmcdUhHriZLeet3M++OD4IRsnQANWNioH5
         WnvdpRqiL137eUCrEJZBL7H6j2PJ3fnLklMW7W9XVzZl0eJUAzuRsXtDUI8IcQK4lUm0
         w4uWBe2y2QcUpqJ5MUpo06VBJ4PAHRhJZxA03VtgA0nMbd2u6h01vqbkLhYI51TX/SI8
         tprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yURCk+609AgA1ES+x9/eaUKy7mX+7W216LBzbg+Oblo=;
        b=vbt5BKPbbRYZCH8q8Bnv9hzrndjSfMP91qzHgDX0xTsxo0T8GtNX8w394O3PxjSkd8
         CDk7GOc2OdaTKjZYCTEzrYmKTbV5t/B2EoFcPaHa54tFbDtQ113Iq3KemNBdryUb//jM
         b8mEjReaTggKIQ0ajUa27lz2wjWvmgCM4UqS5DFc6jAa3vOvmlSnfl3ir5liS0hAGNns
         M3ynisM1gxNHP1fByJy84OOHkMPRN4HZERKaHVUIhSvjW4eFVj7DmRdojB3D9iHCDpuu
         rSn6CSdvz+x1mG5mPfwVx0C/Rea7dORedeSPXafdM/zE5BIA82bGgvRR3pPQReud0CZO
         9ZnQ==
X-Gm-Message-State: AOAM532aU5D4+EkqfmAo2QC2ceG/q7ykQzF3EGYdYWtxWCAy/SXWjvl8
        q7jqw6uW3+nxCn+nrMcHKfmM
X-Google-Smtp-Source: ABdhPJx8D/fEYdc/kQtwDn4mOC3/fCIHq5bLzLsJ2JwcweiBCcoLKMwk9SHuxtFhEmAVgM1qA7281w==
X-Received: by 2002:a05:6870:1613:b0:da:b3f:3222 with SMTP id b19-20020a056870161300b000da0b3f3222mr15717oae.210.1647275082931;
        Mon, 14 Mar 2022 09:24:42 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id c37-20020a9d27a8000000b005b23cf22e23sm7894103otb.42.2022.03.14.09.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 09:24:42 -0700 (PDT)
Message-ID: <1a383ecf-b350-9085-890f-d4b225cfa48a@github.com>
Date:   Mon, 14 Mar 2022 12:24:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] partial-clone: add a partial-clone test case
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1175.git.1647193162570.gitgitgadget@gmail.com>
 <xmqq4k41vdwe.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq4k41vdwe.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/13/2022 3:41 PM, Junio C Hamano wrote:
> "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
> writes:

>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>> index 0f439c99d61..07a2b60c103 100644
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -1811,7 +1811,7 @@ test_subcommand_inexact () {
>>  		shift
>>  	fi
>>  
>> -	local expr=$(printf '"%s".*' "$@")
>> +	local expr=$(printf '.*"%s".*' "$@")
> 
> The original wanted to make sure that the arguments to the helper
> are initial items of a comma separated list, and an existing caller,
> for example, i.e.
> 
>   test_subcommand_inexact git pack-objects --honor-pack-keep <trace
> 
> is relying on the behaviour to make sure 'git', 'pack-objects', ...
> appear at the beginning of "[...]" enclosed list.  This change
> breaks its ability to notice that an insertion of unrelated token
> before 'git' as an error.
> 
> In other words, it looks like an uncalled-for selfish change.

This change was my recommendation, but I see that it is probably
not ideal.
 
> Why can't you specify what should NOT come before "fetch" in your
> use of this helper?
> 
>>  	expr="${expr%,}"
> 
> The preimage already has this problem, but the stripping of trailing
> comma here is a result of mistaken copy-and-paste from the exact
> variant, I think.  test_subcommand uses
> 
> 	local expr=$(printf '"%s",' "$@")
> 
> to concatenate "$@" into a single comma-separated string, so it
> perfectly makes sense to drop the last one here, but with or without
> your change here, neither is adding a comma that need to be
> stripped.
> 
> 
> It is not _your_ theme, but I think this helper is poorly designed,
> especially compared to the original "exact" variant.
> 
>         test_subcommand_inexact () {
>                 local negate=
>                 if test "$1" = "!"
>                 then
>                         negate=t
>                         shift
>                 fi
> 
>                 local expr=$(printf '"%s".*' "$@")
>                 expr="${expr%,}"
> 
>                 if test -n "$negate"
>                 then
>                         ! grep "\"event\":\"child_start\".*\[$expr\]"
>                 else
>                         grep "\"event\":\"child_start\".*\[$expr\]"
>                 fi
>         }
> 
> 
> I've already touched that "${expr%,}" there is a totally useful
> statement that will always be a no-op.
> 
> When "test_subcommand_inexact git pack-objects" is run, the printf
> assigns to $expr:
> 
> 		expr='"git".*"pack-objects".*'
> 
> and the actual grep command invoked becomes
> 
> 	grep '"event":"child_start".*\["git".*"pack-objects".*\]'
> 
> I am not sure if that is what we really want.

Ah, yes this certainly seems to not be the expected plan. It does
allow for more flexibility than intended: the intention was to
add flexibility at the end of the command, but instead adds
flexibility throughout, only caring that a certain list of options
is present as a subsequence (except that the first item is the
first item, namely "git" in most cases).

That unintended flexibility would allow the current needs to use

	test_subcommand_inexact ! git fetch

as desired, but there is the additional worries about whether it
is too flexible for the existing uses.

> I wonder if it was more like this that the original wanted to grep for:
> 
> 	grep '"event":"child_start".*\["git","pack-objects",.*\]'
> 
> in which case the two lines there should be more like
> 
> 	local expr=$(printf '"%s",' "$@")
> 	expr="${expr%,}.*"
> 
> I would think.  This comes from Derrick's e4d0c11c (repack: respect
> kept objects with '--write-midx -b', 2021-12-20).

Yep, that was definitely the intention, but I wrote it wrong.

I'm torn between "let's fix it to work as intended and do something
different for this test case" and "this flexibility is unexpected,
but still gives us enough information to trust the tests."

If you think that we should fix the helper to work differently, then
I can work on a patch to do so, so Abhradeep doesn't get too
sidetracked on that.

Thanks,
-Stolee
