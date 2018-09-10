Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 328751F404
	for <e@80x24.org>; Mon, 10 Sep 2018 22:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeIKC4L (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 22:56:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50668 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbeIKC4L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 22:56:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so23065717wmc.0
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 15:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HKIrjaIfW2Fq8/77tWi8/qsK8VaiSX6lX3vhu4LW5Ys=;
        b=oRBXtTIdgkGmJpNAh2UnO6YOhnuOmG2VgYbB24slWQi/tXgSt7CPiIlp6nvum/s21S
         xyrl78OvHQ+Av/o/bms8Dq39H9aPF2EmVOvvPp7UIvnnORaVxwS3NZ709jnpC/t1DMUC
         rEAHYBsCh/VLDCv7J8yQcs6xAoSMRGE859JRRtE/iHFSkKFvrwrB2S6pnWlmwJGurmIp
         02Pw3LCtykfsdxrO65p29e74tLNkixLXNNnffPKr2CsCmDuHiJsxm22oKDyKKFBQgXwM
         Egfw9M1QdXkK+bImRecowlKoJ4gG71FI2IeNwhcx7OUfyn7dbJxS7H43DAH/IcCbvFm4
         TsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HKIrjaIfW2Fq8/77tWi8/qsK8VaiSX6lX3vhu4LW5Ys=;
        b=jo5mV798f31wgcrW+SX74qMy4Fzm1Qyfwbugiuas1lNBTwGdKKCEDFK91NYPd2M/J6
         5H5Sw1DMh4OJnHMhUoacTWtlwOLfljVkGKGXt68HzyAUooSAj9wRhPX2TFzdAbwMabI0
         b956/0YXAKdqjiFuP4Gxal8eAYrdOpeE2IX/Y6KX7RKARMT5HimpdjDo6q4Ln/vTzVH1
         Im5SyVnrDz9FxN3Hwd0c4+MAUOr+cV1XVlz5wn/7ercs4XyPOB5Rh0C8aC1vv+Yz/enc
         vA/7h5wW+CTM65Fc5K1p++7TX6qnN7YgePgg3m5MCxggdRbyd46OZMw7SxAnkKT2HPMV
         VkDA==
X-Gm-Message-State: APzg51CjR9JIFqlKNf6zusbE5wdg0Gx4lDNwA6HpCe0lQm8fsK4wD8MN
        +wahRCH8W2lvPN70tkJaeBo=
X-Google-Smtp-Source: ANB0VdZChF9jqMbQ+1uq9NAknIWPdRswr5eyr5XICPINqxXjrRLEW7W6kGx8Sf2Z8MrEqZZSjQ0brA==
X-Received: by 2002:a1c:e289:: with SMTP id z131-v6mr2121993wmg.32.1536616801991;
        Mon, 10 Sep 2018 15:00:01 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y128-v6sm18315081wmy.26.2018.09.10.15.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 15:00:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     jeffhost@microsoft.com,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mingw: fix mingw_open_append to work with named pipes
References: <pull.35.git.gitgitgadget@gmail.com>
        <pull.35.v2.git.gitgitgadget@gmail.com>
        <f0361dd306d19fa741c813885d240e041dc09a7a.1536599118.git.gitgitgadget@gmail.com>
        <a309396f-bb33-477d-5d92-a98699f5a856@kdbg.org>
Date:   Mon, 10 Sep 2018 15:00:00 -0700
In-Reply-To: <a309396f-bb33-477d-5d92-a98699f5a856@kdbg.org> (Johannes Sixt's
        message of "Mon, 10 Sep 2018 21:45:05 +0200")
Message-ID: <xmqqbm95rp27.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>>   +#define IS_SBS(ch) (((ch) == '/') || ((ch) == '\\'))

I think you already have mingw_is_dir_sep() and its shorter alias
is_dir_sep() available to you.

>> +/*
>> + * Does the pathname map to the local named pipe filesystem?
>> + * That is, does it have a "//./pipe/" prefix?
>> + */
>> +static int mingw_is_local_named_pipe_path(const char *filename)

There is no need to prefix mingw_ to this function that is file
local static.  Isn't is_local_named_pipe() descriptive and unique
enough?

>> +{
>> +	return (IS_SBS(filename[0]) &&
>> +		IS_SBS(filename[1]) &&
>> +		filename[2] == '.'  &&
>> +		IS_SBS(filename[3]) &&
>> +		!strncasecmp(filename+4, "pipe", 4) &&
>> +		IS_SBS(filename[8]) &&
>> +		filename[9]);
>> +}
>> +#undef IS_SBS

It is kind-of surprising that there hasn't been any existing need
for a helper function that would allow us to write this function
like so:

	static int is_local_named_pipe(const char *path)
	{
		return path_is_in_directory(path, "//./pipe/");
	}

Not a suggestion to add such a thing; as long as we know there is no
other codepath that would benefit from having one, a generalization
like that can and should wait.

>>   int mingw_open (const char *filename, int oflags, ...)
>>   {
>>   	typedef int (*open_fn_t)(wchar_t const *wfilename, int oflags, ...);
>> @@ -387,7 +419,7 @@ int mingw_open (const char *filename, int oflags, ...)
>>   	if (filename && !strcmp(filename, "/dev/null"))
>>   		filename = "nul";
>>   -	if (oflags & O_APPEND)
>> +	if ((oflags & O_APPEND) && !mingw_is_local_named_pipe_path(filename))
>>   		open_fn = mingw_open_append;
>>   	else
>>   		open_fn = _wopen;
>
> This looks reasonable.
>
> I wonder which part of the code uses local named pipes. Is it
> downstream in Git for Windows or one of the topics in flight?
>
> -- Hannes
