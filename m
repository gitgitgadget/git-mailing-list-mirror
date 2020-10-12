Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A34C43457
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 13:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9999A2076E
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 13:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAaApnks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388732AbgJLNPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 09:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388723AbgJLNPM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 09:15:12 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A91C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 06:15:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n15so19166983wrq.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K5kNtQ0J2ScSiAq6jiYgGnLeyCvwkTDJdtCmxYMubfM=;
        b=fAaApnksTJ8WVdVeTLpq5DTbt8oeE+tOMUy7GwWn/DyduXdXqu04MooSeWrxBi9LoG
         P8Ry4gHYAX22lflfg0a2nMTZmODTRusG9H+rkhsBvLU5vnHdzdGrTg+GYZioqv1dwXng
         3E6lZB9S9EWo6XlIHclQeoQlNKV0MwuEYfTIgtU1Q13j4R8mbaipfy+wID8i8rRXGuRG
         7aCRXQqwnEuCviNBxA+ioE2FlhTTU9+1Y2fENojiVCdW6hvun19E+4RXcaDf3v+tVNqh
         P6yojAPY7aMEzNBLaasuE/xBJu2l8DDlC5Mj5qjmTcB5gSnszIE+z5hpf5o/yd+WK940
         vfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K5kNtQ0J2ScSiAq6jiYgGnLeyCvwkTDJdtCmxYMubfM=;
        b=hTSKfRmqKHI14eMigXIrTnIXaAeKzu8tm1tYN4aXBUFIryZgp19jrLw3IDl9SIAA0G
         Imvv/MKmpZwll/xTa7MrrYXzoXCFH/FtSi0gUIUxWaLUKx7NSJQ2av+2WOvd5QNvvvoc
         0qhHddNiaN2UtVWTHAMa0IccYZ1722MqTX6OdWT2TNM5iB74/evXVHLJiZE5wOkAlU/Y
         w6P/PpwgITk0XggIo/ydNy+RzoFgp81+ubVMHfB5Mo/pBv1FcD9ak7nmVH7ZuxlpCX71
         hnoiW8fxEf4yErpOq5hAOuo4uot3o5PteT/9TU33v1da6C2gUT2I1BZH0cWXQlkMQPYC
         uBFA==
X-Gm-Message-State: AOAM531KSJHVVjR6WPr5IRRrm6P0/O8TWaXFUvwWwjOqD43NwmbmKIrM
        OBhxOSg9VAYqrE22mbt+zss=
X-Google-Smtp-Source: ABdhPJyrr7ZI2517015UR6jlYWsjAmKF8KDNtbBsPMRK6tahgGSBX9Cv3h7OdF8vLJCxcqg/j2tXGQ==
X-Received: by 2002:a5d:4c8d:: with SMTP id z13mr14002979wrs.412.1602508510606;
        Mon, 12 Oct 2020 06:15:10 -0700 (PDT)
Received: from [192.168.1.201] (39.16.7.51.dyn.plus.net. [51.7.16.39])
        by smtp.googlemail.com with ESMTPSA id n2sm24852511wrt.82.2020.10.12.06.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 06:15:10 -0700 (PDT)
Subject: Re: [PATCH] sequencer: fix gpg option passed to octopus merge
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?UTF-8?Q?Samuel_=c4=8cavoj?= <samuel@cavoj.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
References: <20201011224804.722607-1-samuel@cavoj.net>
 <20201011225850.GA490427@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2010121233590.50@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6f650960-6b32-4be5-b909-86685c6ad5ea@gmail.com>
Date:   Mon, 12 Oct 2020 14:15:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2010121233590.50@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the patch Samuel

On 12/10/2020 11:34, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 11 Oct 2020, brian m. carlson wrote:
> 
>> On 2020-10-11 at 22:48:04, Samuel Čavoj wrote:
>>> When performing octopus merges with interactive rebase with gpgsign
>>> enabled (either using rebase -S or config commit.gpgsign), the operation
>>> would fail on the merge. Instead of "-S%s" with the key id substituted,
>>> only the bare key id would get passed to the underlying merge command,
>>> which tried to interpret it as a ref.
>>>
>>> Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
>>> ---
>>> It is unclear to me whether I should have based this off of maint or
>>> master, master made more sense to me. I apologize if maint was the
>>> correct one, please tell and I will resubmit.
>>> ---
>>>   sequencer.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/sequencer.c b/sequencer.c
>>> index 00acb12496..88ccff4838 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -3677,7 +3677,7 @@ static int do_merge(struct repository *r,
>>>   		strvec_push(&cmd.args, "-F");
>>>   		strvec_push(&cmd.args, git_path_merge_msg(r));
>>>   		if (opts->gpg_sign)
>>> -			strvec_push(&cmd.args, opts->gpg_sign);
>>> +			strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>>
>> Yeah, this seems obviously correct, and it's very similar to what we do
>> elsewhere in the file.
In run_git_commit() we do

	if (opts->gpg_sign)
		strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
	else
		strvec_push(&cmd.args, "--no-gpg-sign");

I'm not immediately clear why we pass --no-gpg-sign when opts->gpg_sign 
isn't set but it makes me wonder if we should be doing that here as well

>  This will also handle the case where the option
>> is empty (because we want to do autodetection of the key to sign)
>> correctly as well.
> 
> ACK
> 
> It is unclear to me whether we want to bother introducing a test case for
> this; Octopus merges are somewhat rare...

This code path is used whenever the user specifies a merge strategy 
other than "recursive" or they pass merge strategy options to any merge 
strategy including "recursive" so while octopus merges may be rare the 
union of everything other than a plain recursive merge may not be.

Best Wishes

Phillip

> 
> Ciao,
> Dscho
> 

