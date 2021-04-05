Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B6DC433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 20:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E4D613C4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 20:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbhDEUy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 16:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbhDEUyx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 16:54:53 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0618C061756
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 13:54:46 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so12555760oty.12
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 13:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UYGF0Rv/iFsOfKKOtX7xaxcGJ/n7CJbXu3KysN/AHaQ=;
        b=t72YU12I9U4OxGan3nsZVhAhLz3cHJxemWbmUEhXNX+l9wWbQYSciGZxiRAsELRA/W
         ifLxEjEIp25XZzuqhriLTIbxAGJiDfXqi++ov/R1tZvC7kX14iYqqU+yWVmiHpWJk9+h
         2xNIR1OqmznroF6/+UuHeyiAxKhA9f0SBKSKJzF2zpJDRGAiUtkdGtX3RG++oLamKAeT
         BrSy77yuPgANd6okqGT94EV2kWKX9Km32UUpKVIVDXnbJc16x3U2boDB0h9wq08Rh4aj
         mHFz/C7t/qAskHy7mpsOFDBHXOj4YbDcBPQHQvf8edPNsi49QhgUDMu9uORzaXbT/Gow
         TQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UYGF0Rv/iFsOfKKOtX7xaxcGJ/n7CJbXu3KysN/AHaQ=;
        b=il0O+XeTo+RAp5jIoImEoZ5cFoOm1Oh1p/3Ts/HZ36Azht71F7832yHFS/oLWg2GJD
         2USE9LXoIaU2+Hy2hnz32n2w9AhswRqW21IZMkkSNPHrKyc00U9JjJQqTtnJM7rqgDDJ
         q5N7DtVEkl9VKJQ1zwJuhmb5LmDYeXXnCdbceF5usZLg6UiGDhWpSNcusL0MEdiDEHSB
         HcqRQpfNu2Bk9Z43u5wKMuLkN22rW7ulA/eCUukcEvb6CLmVAXu9tBafvHbbrjXvKM41
         CZgqZMEZd3/CfWz2GHI+IWoXI9vyCA6P/qn0Q+qVPhdezOOB3i075x4gWMRQS73dloJW
         i1uQ==
X-Gm-Message-State: AOAM530Q8CYnWasQlIJI3AACoqW/KYBEYbOODrZbZDg2HFMSNjK6ixDK
        yGcpJlb35JW77ug764+goI5By7Th45GBeQ==
X-Google-Smtp-Source: ABdhPJwUPr16slAZ2waf9uWCHdpSi5HTu8ChK+nS8j/X2jQ6PEYUItRu9B/b9hzmhjSp3j4pSZdIlg==
X-Received: by 2002:a05:6830:1b68:: with SMTP id d8mr23417937ote.235.1617656086092;
        Mon, 05 Apr 2021 13:54:46 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:91f9:c820:22ba:fec7? ([2600:1700:e72:80a0:91f9:c820:22ba:fec7])
        by smtp.gmail.com with ESMTPSA id c26sm4222941otm.51.2021.04.05.13.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 13:54:45 -0700 (PDT)
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
To:     Tom Saeger <tom.saeger@oracle.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
 <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com> <xmqq1rbs4c6t.fsf@gitster.g>
 <f113284b-a7fe-ba7f-ce1c-d214efd5d0c6@gmail.com> <xmqqft057ijc.fsf@gitster.g>
 <e75b1e72-6c9f-d466-ac52-24b324b44b3c@gmail.com> <xmqqr1jo5zzb.fsf@gitster.g>
 <20210405203832.x275fqoinfsw5gik@dhcp-10-154-153-195.vpn.oracle.com>
 <xmqq5z105uia.fsf@gitster.g> <5c432329-1e42-c29c-242d-a2955174296b@gmail.com>
 <20210405205056.czzkjdxr3guca3mf@dhcp-10-154-153-195.vpn.oracle.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c06a198a-2043-27a2-cab3-3471190754cc@gmail.com>
Date:   Mon, 5 Apr 2021 16:54:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210405205056.czzkjdxr3guca3mf@dhcp-10-154-153-195.vpn.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/5/2021 4:50 PM, Tom Saeger wrote:
> On Mon, Apr 05, 2021 at 04:49:29PM -0400, Derrick Stolee wrote:
>> On 4/5/2021 4:47 PM, Junio C Hamano wrote:
>>> Tom Saeger <tom.saeger@oracle.com> writes:
>>>
>>>> $ git config --local --get-regexp "pr-924"
>>>> remote.pr-924.url https://github.com/gitgitgadget/git
>>>> remote.pr-924.fetch +refs/tags/pr-924/derrickstolee/maintenance/refspec-v1
>>>>
>>>> Seems legal, fetch even works
>>>
>>> Yes.  For a ref that is one-shot use (like PR tags), this does not
>>> make much sense, but
>>>
>>>     [remote "submaintainer1"]
>>> 	url = ... repository of submaintainer #1 ...
>>> 	fetch = master
>>> 	tagopts = --no-tags
>>>
>>> is a reasonable thing to have for those who regularly work with
>>> submaintainer(s) of their project.  They'd do
>>>
>>> 	$ git pull submaintainer1
>>>
>>> to accept the work their submaintainers have done.
>>
>> Thanks for the extra testing! I'll be sure to fix this bug in v2.
>>
>> -Stolee
>>  
> 
> Hacked this:
>
> @@ -920,6 +927,10 @@ static int fetch_remote(struct remote *remote, void *cbdata)
>                 refspec_item_clear(&replace);
>         }
> 
> +       /* skip remote if no refspecs to fetch */
> +       if (child.args.nr <= nargs)
> +               return 0;
> +

This is a good approach, but we'll need to clean up the data in
'child' since run_command() no longer does it for us.

>         return !!run_command(&child);

Thanks,
-Stolee
