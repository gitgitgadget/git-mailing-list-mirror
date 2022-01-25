Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19933C433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 11:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380804AbiAYLKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 06:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380619AbiAYLIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 06:08:16 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF26C061777
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 03:08:00 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id r2-20020a1c2b02000000b0034f7b261169so1527525wmr.2
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 03:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UMbwt/ixFzdzCZ4RZBh1VZzzcIBD/L2SKhC2Hd6IHVY=;
        b=i5JfBWcTI8mRZtltad3RP399TZFakI53EPOAdbDmK+XS00HCXCIy/qoV8+Lzg1iLnK
         3hL1xb1VMigaCkWERGs5bvFjMQJfbAHH0sl7HKIntyPTUkImDNk7lzZBxo48EY1lsE0S
         n7NOr/M+wE9M1WJEp4OghppTBgMaI0fz8l3WXbpl17e2bI+RX7y3tt1mJLadvxRdVPnF
         7J5Q9bRJZfU2GkO+jY4Hoy61rcRnEsu62fSTGpiIcHKqr/+hJQoj1ivpsgdLgX7CGnQW
         OZsP3WNOcof/Ri7ejqAAGcoz/2VOTdm3iURjFvMaAxkKExLO0LAFnOYvEArcTRfhglYS
         OgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UMbwt/ixFzdzCZ4RZBh1VZzzcIBD/L2SKhC2Hd6IHVY=;
        b=EbRhManmpYH82dm8zI7BtpobIeCt3mSjhSD/6vWSPgXmiY7JJsTbPEcZSnWiLSyta4
         0oiLgI0Y1/CZx0DOfa9RntOOZ4f/Fndw6/g7LCR0AuCOsu9Knse+S1Th0HgrksgISsig
         ighWp6Bv6QFDn3AEAgvgCJWVFq9S3mHoxDfirRkqj00FsxJW58V+A958fEjsKzaJIeNn
         COEBXHJ8VNU2Vz38NjwmLqr5x2ar6GIi+jXvp+JzQKHlZn/jYYdnCLSVi29KuCjc//5H
         ue8k27y/jGicDarEy9XIHC4cryk8PQDGb+/HU2iC/2fXuisYX71qnzIh4IOQro2uXlyw
         2OUg==
X-Gm-Message-State: AOAM531C551fccLTpKtKjVZP2jcJrh7NfUo6VFVKmVpf6gxPzeSsT5/3
        khKEuRvUBe2Q3q69JvRWcw2PWfuOkvI=
X-Google-Smtp-Source: ABdhPJw0Iqp24IXVrnK+g7OtxjoswkXYHWyHrQ42sEa++3SOgBgYPFLnA7U421oaEpxRVMhuR97rwA==
X-Received: by 2002:a05:600c:4c88:: with SMTP id g8mr2457208wmp.105.1643108879312;
        Tue, 25 Jan 2022 03:07:59 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id l20sm54806wms.24.2022.01.25.03.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 03:07:58 -0800 (PST)
Message-ID: <74ef1b90-0d7a-fa28-9c5a-4c328674384e@gmail.com>
Date:   Tue, 25 Jan 2022 11:07:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 10/14] rebase: cleanup reset_head() calls
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
 <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
 <5ea636009e7858e50357f0f6f8d8fa42e056db60.1638975482.git.gitgitgadget@gmail.com>
 <xmqqczm5r34h.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqczm5r34h.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/12/2021 19:26, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> If ORIG_HEAD is not set by passing RESET_ORIG_HEAD then there is no
>> need to pass anything for reflog_orig_head. In addition to the callers
>> fixed in this commit move_to_original_branch() also passes
>> reflog_orig_head without setting ORIG_HEAD. That caller is mistakenly
>> passing the message it wants to put in the branch reflog which is not
>> currently possible so we delay fixing that caller until we can pass
>> the message as the branch reflog.
> 
> As I hinted elsewhere, these rules should be spelled out in a
> comment before "int reset_head(...)" either in reset.[ch].
> 
> For this particular one, I wonder if
> 
>   (A) we can lose RESET_ORIG_HEAD bit and use the presence of
>       reflog_orig_head to mean what that bit currently means, or
> 
>   (B) we keep the current code strucure, but make it a BUG() if
>       a non-NULL reflog_orig_head is given without RESET_ORIG_HEAD
>       bit set.

We do (B) later in the series, it cannot be done in this commit as we 
leave move_to_original_branch() unchanged here and that would BUG() out. 
I've added a comment it the commit message to explain this.

Best Wishes

Phillip

> 
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   builtin/rebase.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 3d78b5c8bef..fdd822c470f 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -675,7 +675,7 @@ static int run_am(struct rebase_options *opts)
>>   
>>   		reset_head(the_repository, &opts->orig_head,
>>   			   opts->head_name, 0,
>> -			   "HEAD", NULL, DEFAULT_REFLOG_ACTION);
>> +			   NULL, NULL, DEFAULT_REFLOG_ACTION);
>>   		error(_("\ngit encountered an error while preparing the "
>>   			"patches to replay\n"
>>   			"these revisions:\n"
>> @@ -1777,7 +1777,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>   			options.head_name ? options.head_name : "detached HEAD",
>>   			oid_to_hex(&options.onto->object.oid));
>>   		reset_head(the_repository, NULL, options.head_name,
>> -			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf, NULL);
>> +			   RESET_HEAD_REFS_ONLY, NULL, msg.buf, NULL);
>>   		strbuf_release(&msg);
>>   		ret = finish_rebase(&options);
>>   		goto cleanup;

