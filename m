Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A696B1F461
	for <e@80x24.org>; Mon, 20 May 2019 11:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbfETLzM (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 07:55:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40970 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731486AbfETLzM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 07:55:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id g190so8572379qkf.8
        for <git@vger.kernel.org>; Mon, 20 May 2019 04:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sBcdSJR/zr7fTF0HYeIUmY4k5t+A54l023rayJjXUP0=;
        b=kHvWQUOKCFukJeZGYpsuo10Zbc1Z9vq7CpMRTElbbMhBHLatmpQgehTNBkDUfRUayX
         5abZVfexOD2yPUBgkLJVjyj/8Rmwn3XqegwRNtQpGh9ycpVQgRR7dDNvC1k+225quuka
         97ncNGLLS7C4QoYeYHA82os5j3B6wCDzytzDcZpaTt/HRTITq00crsdrKbUl0dcfEoT4
         VlW30ruLB43vkgx9DhFkEN+2LCe+LH6p8OjMCwIo0ZFPydCVcDE9H0379mZkwkpHDqbe
         BzayL+YYfXYDGRCH7DKl1BFNyMW5cF7axeAIXJONXkuriNq2wFA+xFzTaR7zzZ3Lru9H
         eNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sBcdSJR/zr7fTF0HYeIUmY4k5t+A54l023rayJjXUP0=;
        b=s9DhWBvMETVsvQ2xp54cSg8vkHOtWz/69I+DFXjwRC7qCIidPwRkXt+E8V7aEG3HKD
         mXbuLFk8c0X9FRWCJCFUkM7p8MJD8BBgw63Rvp+tVO0I4ySAE465TKHsh+v9kU5RTHpf
         X6GV/SxFuGsdmFY5w4eKSQxOp8SVMdirRFYf3v0YzhEb2jDphdtPxELzz0wdKHMw6JuD
         NR9ygDoruNQzyu2yZLE9EurW4FjepCT+3lMlBFTgoo60n2TN8g5dEJN62oW8upAP1lau
         hCcEa/TYM1s4MqKcqLfXNEx0mlo0ZnlqgKlwuEbRm6dYtW752l+mhNBJOquo7OZgNl+u
         sKeA==
X-Gm-Message-State: APjAAAU8XCBZSn+8UCcfTbsoTHDq+UumGxEqHA7q/c6JE7d2QKW1roqP
        +zbkrFihMQZu+wpvy94TNDs=
X-Google-Smtp-Source: APXvYqxCULT3u61uRUs/U4+Fts9voy/tAOpqZkj17UqvFN26WMJjYshkEo4sLIM8/KIccmJAzWCkjw==
X-Received: by 2002:a37:34b:: with SMTP id 72mr57937342qkd.42.1558353311728;
        Mon, 20 May 2019 04:55:11 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8824:a533:8b:9681? ([2001:4898:a800:1012:3958:a533:8b:9681])
        by smtp.gmail.com with ESMTPSA id x127sm6870303qka.31.2019.05.20.04.55.10
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 04:55:10 -0700 (PDT)
Subject: Re: [PATCH 3/3] packfile: close_all_packs to close_object_store
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.208.git.gitgitgadget@gmail.com>
 <0e948f639fb5209f07f8e3eb356b5886c41ff2be.1558118506.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1905201141000.46@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0c13a91f-e45e-d177-758a-30e9517a664f@gmail.com>
Date:   Mon, 20 May 2019 07:55:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1905201141000.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/20/2019 6:01 AM, Johannes Schindelin wrote:
> Hi Stolee,
> 
> *really* minor nit: the commit subject probably wants to have a "rename"
> after the colon ;-)

I did put that there, but then the subject line was too long. I'm not
opposed to putting it back.
 
> The patch looks sensible to me. Since Junio asked for a sanity check
> whether all of the call sites of `close_all_packs()` actually want to
> close the MIDX and the commit graph, too, I'll do the "speak out loud"
> type of patch review here (spoiler: all of them check out):

Thanks for the detail here!

>> diff --git a/builtin/repack.c b/builtin/repack.c
>> index 67f8978043..4de8b6600c 100644
>> --- a/builtin/repack.c
>> +++ b/builtin/repack.c
>> @@ -419,7 +419,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>>  	if (!names.nr && !po_args.quiet)
>>  		printf_ln(_("Nothing new to pack."));
>>
>> -	close_all_packs(the_repository->objects);
>> +	close_object_store(the_repository->objects);
>>
>>  	/*
>>  	 * Ok we have prepared all new packfiles.
> 
> Ah, the joys of un-dynamic patch review. What you, dear reader, cannot see
> in this hunk is that the code comment at the end continues thusly:
> 
>          * First see if there are packs of the same name and if so
>          * if we can move them out of the way (this can happen if we
>          * repacked immediately after packing fully.
>          */
> 
> Meaning: we're about to rename some pack files. So the pack file handles
> need to be closed, all right, but what about the other object store
> handles? There is no mention of the commit graph (more on that below), but
> the loop following the code comment contains this:
> 
>                         if (!midx_cleared) {
>                                 clear_midx_file(the_repository);
>                                 midx_cleared = 1;
>                         }
> 
> So yes, I would give this a check.
> 
> It does puzzle me, I have to admit, that there is no (opt-in) code block
> to re-write the commit graph. After all, the commit graph references the
> pack files, right? So if they are repacked, it would at least be
> invalidated at this point...

The commit-graph does not directly reference the packs. The file will still be
valid, except if we GC'd some commits that it references. We have the ability
to rewrite the graph in 'git gc'.

The MIDX does reference packs by name, so it needs to be cleared before we delete
packs. This _could_ be done with more care: we only need to delete it if a pack
it references is queued for deletion. However, you can do that using the
'git multi-pack-index expire|repack' pattern currently cooking.

Thanks,
-Stolee

