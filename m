Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45873ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 13:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiH3NXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH3NXL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 09:23:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9E5BAD8E
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:23:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e20so14178131wri.13
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=aYqOEc2c03l6q35gPNRmBvBiKx8eqQAH1STMLvy+1ug=;
        b=N+NNsxmjnCx4glgDQOEgV9XW/DeIZXaLU5ziQLmYu3TyxaPIeXmZpk/EoqUGPjKx3s
         oTBhPEosP3goHQTERE1yQEqplgQUNcj2aCV73/4YNnbiCfSwGKrbrd1W14AzR5Kt4len
         8vNScLm56NtP7QpGVrMUzfZbR+pw/TsVSizCEE3P4kS0B2qWcEOIeN2ME8zHl9YzTOrY
         wW72L/LrN8LLv2zDf2fxZmQTcsP+djkLBESPIp5COgHVX3f1VqB4xd0Owv8elvyEgTDI
         ijwlryg0woRczaWqqZaNxGpacU608pcGqihizXVO431b1EnSbR58EchG2LIJksP3rHOM
         EHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=aYqOEc2c03l6q35gPNRmBvBiKx8eqQAH1STMLvy+1ug=;
        b=6qHHXWDNo6NHY+Hayc9ye/+EorGnYqUrq+oTfV5nAuI+rBBIFKeS9DU16GeCA+v+49
         EpBJTSIpQO/WvbQGcbqls+gFpmc1Y/jWNQq5NFIkxFkd/08EmwjWJQbGfTy3ZSvmFTsJ
         eq3k6GG42UmMxdRICkktQM05pyU/noI19ekngqrIF5ujC93L+Zhirry64dyHYcMjjatl
         dxk+lcpzto6AAumcWhf6Q4yz1StkvYAi1pl6waycUg0+fQ/DOrLFbL4SdI+qE6p7Vofq
         MCqxlzdX/kFMIw7AGaMDUgAd0tnjZMc6pgVqN2NrgjQSOSq6GL0sAFVyWIDb/X9dicZ6
         aOyQ==
X-Gm-Message-State: ACgBeo3yIPh3f5SnySWmz4b54/FWOgc+qRV/il875ahNQTvlU3XfwDjl
        njDtcEAyLk5AEMKSVHhc4KQ=
X-Google-Smtp-Source: AA6agR5gzsMmm+DMkLffe0hmoCb1G4ileoTD/HRP0KxNh0RO9WwcV9Dfc3JABKAGLK3NJPtGYvObMQ==
X-Received: by 2002:a05:6000:813:b0:226:da5a:84a9 with SMTP id bt19-20020a056000081300b00226da5a84a9mr5718244wrb.309.1661865788727;
        Tue, 30 Aug 2022 06:23:08 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b003a6a3595edasm13008267wmq.27.2022.08.30.06.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 06:23:08 -0700 (PDT)
Message-ID: <4960a9a9-3a48-f6ce-6412-0e6eb8997e1d@gmail.com>
Date:   Tue, 30 Aug 2022 14:23:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/5] add -p: handle `diff-so-fancy`'s hunk headers
 better
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
 <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
 <e3e3a178f98183032b3df8ad9c81a096fe4af556.1661785916.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <e3e3a178f98183032b3df8ad9c81a096fe4af556.1661785916.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 29/08/2022 16:11, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The `diff-so-fancy` diff colorizer produces hunk headers that look
> nothing like what the built-in `add -p` expects: there is no `@@ ... @@`
> line range, and therefore the parser cannot determine where any extra
> information starts (such as the function name that is often added to
> those hunk header lines).
> 
> However, we can do better than simply swallowing the unparseable hunk
> header. There is probably information the user wants to see, after all.
> In the `diff-so-fancy` case, it shows something like `@ file:1 @`.
> 
> If the line range could not be found in the colored hunk header, let's
> just show the complete hunk header.

Looking at the tests, I don't think we just show the complete hunk 
header, we show the offsets from the unfiltered diff as well. I think 
that is unfortunate as it kind of defeats the purpose of 
interactive.diffFilter which is to the the user see the diff how they 
want to (so long as it has the same number of lines)

Best Wishes

Phillip

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   add-patch.c                | 13 +++++++++++--
>   t/t3701-add-interactive.sh |  4 ++++
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/add-patch.c b/add-patch.c
> index 9d575d30ed0..0217cdd7c4a 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -363,8 +363,17 @@ static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
>   	if (p && (p = memmem(p + 4, eol - p - 4, " @@", 3)))
>   		header->colored_extra_start = p + 3 - s->colored.buf;
>   	else
> -		/* could not parse colored hunk header, showing nothing */
> -		header->colored_extra_start = hunk->colored_start;
> +		/*
> +		 * We tried to parse the line range out of the colored hunk
> +		 * header, so that we could show just the extra information
> +		 * after the line range.
> +		 *
> +		 * At this point, we did not find that line range, but the hunk
> +		 * header likely has information that the user might find
> +		 * interesting. Let's just show the entire hunk header instead
> +		 * in that case.
> +		 */
> +		header->colored_extra_start = line - s->colored.buf;
>   	header->colored_extra_end = hunk->colored_start;
>   
>   	return 0;
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 49200b7df68..39e68b6d066 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -775,10 +775,14 @@ test_expect_success 'handle iffy colored hunk headers' '
>   		add -p <n &&
>   	force_color git -c interactive.diffFilter="sed \"s/\(.*@@\).*/\1FN/\"" \
>   		add -p >output 2>&1 <n &&
> +	force_color git -c interactive.diffFilter="sed \"s/\(.*@@\).*/file/\"" \
> +		add -p >output-so-fancy 2>&1 <n &&
>   	if test_have_prereq ADD_I_USE_BUILTIN
>   	then
> +		grep "@ file\$" output-so-fancy &&
>   		grep "@ FN\$" output
>   	else
> +		grep "^file\$" output-so-fancy &&
>   		grep "@FN\$" output
>   	fi
>   '
