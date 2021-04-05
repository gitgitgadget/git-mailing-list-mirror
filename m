Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D27FC433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 20:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5131561353
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 20:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbhDEUtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 16:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbhDEUth (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 16:49:37 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCC4C061756
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 13:49:31 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso12582942otq.3
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 13:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fNYpXeoJl2cHK5J7BZO/4W8ZIiXMWqaRmUJESO41wfI=;
        b=kJNJt/+WKRz9h+Gjcyd2YSeDXWU8aDwNBhysbT8qIJyOiajGYg/z57DzDSCygXJzmH
         IRW67t9aaxgxH+mETFNC7g7e38z9oQn9Vgp5Vrt7IHFyLDDxkWG3XOsWP7RHqhn4sgLi
         /V+MA/3r6kPEdCd5N7N/gHKUCMojAqTdG4aPj92Bd92fh5Pn71gbtZmJ/0suErqi3e3N
         aMezA2Jarg4UWWEhRXmRMoO0iRO9S3qITxcAY7S50Xub81G0r6XBTQ0WV5mtVnjfPdGF
         H3SjnNDwih9/v2AwA6SU0OcmwQmterdiyyIzUwTjhxr1Nncy7Zy2niu+SESKRH2MCEUe
         /jmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fNYpXeoJl2cHK5J7BZO/4W8ZIiXMWqaRmUJESO41wfI=;
        b=DSE45hSlHuxQWrF/WWAjwhMOym8qnvMraPR04woaD9L89hW2dOtuNuTwc1BZr2Lsra
         RUI3eJ6WIEijSNQk1+rGjN9w6feo8GXeSvVtNXsyZhwIDSMH4PjJDZXW8KjfoLd9rywC
         jCKk/0HIuyB9gZXjkFrErOgvllOdHO7UKEd1NDLn7rP1qEXMKN/8xsuwCZvxGwOxjqCU
         aVaBy5Xb0x6r23OgVqvBGpezNUEXSE/fw6ZHLzZZd414Xynylnzhc9unQvTBQCsqE13k
         ONuBUm3e6iXgB3o6gu9VwLCYxcTa8uFoc8qWLzHxEA2e8bmG1PCpCSkwUwBTPpYUc72P
         VArQ==
X-Gm-Message-State: AOAM532h1naMqo7RJpOLZ93q9+wL0RQr7c/GgDuzclLgy/SXtrhoEfYh
        wSPOGiQ2vFEieGhsJqk+BFdEmZSGfSB2xQ==
X-Google-Smtp-Source: ABdhPJzgyZPZu0bgWnnn0Wfqbh/G9wdTDnsyKywDSH78aoR3NmBK2+QURhfGtq2gAdt0IHdaLYdDlw==
X-Received: by 2002:a9d:2f45:: with SMTP id h63mr23210614otb.372.1617655770342;
        Mon, 05 Apr 2021 13:49:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:91f9:c820:22ba:fec7? ([2600:1700:e72:80a0:91f9:c820:22ba:fec7])
        by smtp.gmail.com with ESMTPSA id n6sm3654031oop.48.2021.04.05.13.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 13:49:30 -0700 (PDT)
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
To:     Junio C Hamano <gitster@pobox.com>,
        Tom Saeger <tom.saeger@oracle.com>
Cc:     git@vger.kernel.org
References: <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com>
 <xmqq8s613gqa.fsf@gitster.g> <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
 <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
 <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com> <xmqq1rbs4c6t.fsf@gitster.g>
 <f113284b-a7fe-ba7f-ce1c-d214efd5d0c6@gmail.com> <xmqqft057ijc.fsf@gitster.g>
 <e75b1e72-6c9f-d466-ac52-24b324b44b3c@gmail.com> <xmqqr1jo5zzb.fsf@gitster.g>
 <20210405203832.x275fqoinfsw5gik@dhcp-10-154-153-195.vpn.oracle.com>
 <xmqq5z105uia.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5c432329-1e42-c29c-242d-a2955174296b@gmail.com>
Date:   Mon, 5 Apr 2021 16:49:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <xmqq5z105uia.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/5/2021 4:47 PM, Junio C Hamano wrote:
> Tom Saeger <tom.saeger@oracle.com> writes:
> 
>> $ git config --local --get-regexp "pr-924"
>> remote.pr-924.url https://github.com/gitgitgadget/git
>> remote.pr-924.fetch +refs/tags/pr-924/derrickstolee/maintenance/refspec-v1
>>
>> Seems legal, fetch even works
> 
> Yes.  For a ref that is one-shot use (like PR tags), this does not
> make much sense, but
> 
>     [remote "submaintainer1"]
> 	url = ... repository of submaintainer #1 ...
> 	fetch = master
> 	tagopts = --no-tags
> 
> is a reasonable thing to have for those who regularly work with
> submaintainer(s) of their project.  They'd do
> 
> 	$ git pull submaintainer1
> 
> to accept the work their submaintainers have done.

Thanks for the extra testing! I'll be sure to fix this bug in v2.

-Stolee
 
