Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21B9C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 13:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347550AbiAGN1E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 08:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbiAGN1C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 08:27:02 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B922C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 05:27:02 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id bp39so5482642qtb.6
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 05:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mmxag0/8GtFg1R1HB8sC4bv2h1Qoh1lwhJYusjsdk2g=;
        b=TFJVKoaSApyKxgWrQWnQ6U9B1Twj2uvQwVvsbsplqFcRj4LfGvoVz+h6/vNOfA+lxh
         TJYCy+hrV6h7e1/4wrJgKVHsgADcwREoj08VfuY0qxSAMKzOYc6OEVQdbF+H1EgZmdVd
         4P6G9JmWDlXfORrGOu6Jd8s+pi+T/uLq/fofX31XeUiSFtCw4ViTSkyF5Tjnx+dLkAH/
         1dbGAaO9LyO1gDmsmS3I487P6xM2lXC3qkPW8NnXzs7UKHB4dKFrMhsIppFhci+PKnOg
         8icEJqvuUI+1BGqKR3+UT76EuPIjbUJFqxWywR/lESoibpCPdjRr6Tk/g8K0zTyECm2P
         ANOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mmxag0/8GtFg1R1HB8sC4bv2h1Qoh1lwhJYusjsdk2g=;
        b=1VcfL/hNC7wul0jv9q1mq0lkNhMtRYSgbLo8PzoJyi/66Ar0vOcUNvrk49Wu7e7rC3
         YbTtjCA7QcojtfO557fZrM9b8/3ir1vS1K3IEmnE6sMWQFG8HhMq4OlfpLiK3qHzgT0S
         Ju7DQgLXm/LwcI6UXL/p3JfIzPYrbsiFLvDdyiNd700pP+9NtNCNZZzPq5TX5PjnmyA3
         osMZy/NlK3ne06nPko7GYkQBOoUkLw64hqw2W8SZW9wA3qfTDMpaCfdsZkFD2bzishEU
         C+n/L2c7g7shBgpdcBDvulLR+p1i9MW/lKPuI1mCpMFsapFpWTwjIXHYN94GU2UwI/33
         vQIw==
X-Gm-Message-State: AOAM531MQ2B7ynFBGagCK7u8JJk9vrF0YcwxggPQR7/yNgMCBjQMMv1N
        KctCgQtIvp9dIn68gQYfVHqmDPF88kMnMw==
X-Google-Smtp-Source: ABdhPJzSbOwulrnkPOaB6ynJnazAPMWXM+ylZRzNlfc51T7TJYw5wNOLTe5vy1G28gBmM3j9EVMBlA==
X-Received: by 2002:a05:622a:1206:: with SMTP id y6mr56198389qtx.356.1641562021610;
        Fri, 07 Jan 2022 05:27:01 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id t18sm3724417qtw.64.2022.01.07.05.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 05:27:01 -0800 (PST)
Subject: Re: [PATCH] submodule.h: use a named enum for RECURSE_SUBMODULES_*
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
References: <pull.1111.git.1641410782015.gitgitgadget@gmail.com>
 <xmqq1r1lhobf.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <3160705c-d95c-c389-e929-f1f6bbcd80fc@gmail.com>
Date:   Fri, 7 Jan 2022 08:27:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq1r1lhobf.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-01-05 à 16:20, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> Using a named enum allows casting an integer to the enum type in both
>> GDB and LLDB:
>>
>>      (gdb) p (enum diff_submodule_format) options->submodule_format
>>      $1 = DIFF_SUBMODULE_LOG
> 
> Hmph, this was somewhat unexpected and quite disappointing.
> 
> Because that's not what those "Let's move away from #define'd
> constants and use more enums" said when they sold their "enum" to
> us.  In the diff_options struct, the .submodule_format member is of
> type enum already, so, if we trust what they told us when they sold
> their enums, "p options->submodule_format" should be enough to give
> us "DIFF_SUBMODULE_LOG", not "1", as its output.  Do you really need
> the cast in the above example?

Yes, you are right that my example does not reflect what I'm saying, since
options->submodule_format is not an int. I checked and indeed we do not
need any cast to get "DIFF_SUBMODULE_LOG". We do need it when dealing with int's,
which is not the case here. I'll try to find a better example.

> 
>> Name the enum listing the different RECURSE_SUBMODULES_* modes, to make
>> debugging easier.
> 
> Even though this patch may be a good single step in the right
> direction, until it is _used_ to declare a variable or a member of a
> struct of that enum type, it probably is not useful as much as it
> could be.  The user needs to know which enum is stored in that "int"
> variable or member the user is interested in to cast it to.

Yes, that's true. But when I came across that, I was in a place of the
code where some int was compared with a constant in this enum,
RECURSE_SUBMODULES_something. So it would have been easy to check where
the enum is declared, learn its name and use it to cast the int to the enum
type. That's the kind of situation I have in mind.

> 
> That is, many changes like this one.
> 
> diff --git i/builtin/pull.c w/builtin/pull.c
> index c8457619d8..f2fd4784df 100644
> --- i/builtin/pull.c
> +++ w/builtin/pull.c
> @@ -71,7 +71,7 @@ static const char * const pull_usage[] = {
>   /* Shared options */
>   static int opt_verbosity;
>   static char *opt_progress;
> -static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
> +static enum submodule_recurse_mode recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>   
>   /* Options passed to git-merge or git-rebase */
>   static enum rebase_type opt_rebase = -1;
> 

Yes, this is a parallel effort that could be done, I agree, but my patch
was meant to help in the mean time.

Thanks,

Philippe.
