Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87C401F453
	for <e@80x24.org>; Mon, 24 Sep 2018 11:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeIXRts (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 13:49:48 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:38747 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbeIXRtr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 13:49:47 -0400
Received: by mail-qt1-f179.google.com with SMTP id z13-v6so9002422qts.5
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 04:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qSUFNMc5J0AmSSNcJl6C/6bBcd7xReMqNLLPEIq8oGw=;
        b=nrTKs6QoJrq2npYPgBmyul8SHIlqtn7tR0prYGcG8t10+QpATowL6DJ882Ezg2WRHz
         84j9cn1a6bDnSk8ybMHB1fc3kTOPIEjKtgSEWeHVz0LLPS87cYBst2PskRaYBARZZayg
         /nee2YALxVlZZ7+b1LRVx07UGwU7wK6MqrLuVWt5NbTcVT9ZeJxGer1U/cPnPEx20o8U
         Fr9s9pEX3F/jLMOFLrJSAmv8TJet7Qbb//+BQPC9m8VYeVQq70WrzpUf+SJwFFPaQ/0S
         AEhjt7Bf5QgXGNv6Hkh/lQFQUQY2X6kCybm4E89HnFm5p1a0fDd69WMvbx8UGYwoiSZb
         BhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qSUFNMc5J0AmSSNcJl6C/6bBcd7xReMqNLLPEIq8oGw=;
        b=TWh1YyIm8jZs3LO+9HqgiwOSw+PQlJFmib3l5XQafaeHtuHxDcezDMOR6g0rlj1V02
         NpyozfaqyPVzaHebnUzJ/ncREXtecF1MMiShqlC6SOycrVq8LuF5miJew5vwohzt4dsh
         qv0LkXqbN8mE4eI62REleR3vHh//9m+qQC8W1DtIdVPW+qfuJAse7J+JDmNQIcvforhP
         uK3IBfaBAbtUZfrRfYeIRnB/DvfClymbdKlF4VqbXNjiaW+u1Y69/M3cyi9/mdwAJFSx
         iwS5mDhG1aWySO1vFGAMP9nkkIIlg7e7WZvKHadtNylY5MXBy4fQCTb5OAWHS69xXQlm
         A2Vw==
X-Gm-Message-State: ABuFfogfgXjw/5aVp0tAYJRv3gnepsL6Pp5PBnMg3ztHhgqJ3+2Hm91c
        ER+qiMV7awZGI9uUcBz2sJU=
X-Google-Smtp-Source: ACcGV62G8di8JmQpwUYSj4YPBh4hGnviogs/mh24LZ2n0pbM2htneN7JjY06ZQ/t3gC5kqS68Wus4A==
X-Received: by 2002:a0c:a444:: with SMTP id w62-v6mr4937455qvw.53.1537789685528;
        Mon, 24 Sep 2018 04:48:05 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c0ea:9fdb:fe08:b63a? ([2001:4898:8010:0:aa20:9fdb:fe08:b63a])
        by smtp.gmail.com with ESMTPSA id o2-v6sm1195070qkl.63.2018.09.24.04.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 04:48:04 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] commit-reach: properly peel tags
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.39.v2.git.gitgitgadget@gmail.com>
 <pull.39.v3.git.gitgitgadget@gmail.com>
 <0a1e661271660b1fab317aac3997589a94b7c98f.1537542323.git.gitgitgadget@gmail.com>
 <20180921235628.GA3437@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <217bc485-2872-30c4-3344-2b5d0e754ae8@gmail.com>
Date:   Mon, 24 Sep 2018 07:48:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180921235628.GA3437@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/2018 7:56 PM, Jeff King wrote:
> On Fri, Sep 21, 2018 at 08:05:26AM -0700, Derrick Stolee via GitGitGadget wrote:
> +		if (!from_one || from_one->type != OBJ_COMMIT) {
> +			/* no way to tell if this is reachable by
> +			 * looking at the ancestry chain alone, so
> +			 * leave a note to ourselves not to worry about
> +			 * this object anymore.
> +			 */
> A minor nit, but the original comment you restored here has a style
> violation. Might be worth fixing up (but certainly not worth a re-roll
> on its own).
>
>> @@ -600,7 +622,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
>>   	}
>>   
>>   cleanup:
>> -	for (i = 0; i < from->nr; i++) {
>> +	for (i = 0; i < nr_commits; i++) {
>>   		clear_commit_marks(list[i], RESULT);
>>   		clear_commit_marks(list[i], assign_flag);
> Also, a minor aside, but I think it would be slightly more efficient for
> those final two lines to do:
>
>    clear_commit_marks(list[i], RESULT | assign_flag);
>
> Of course, that's totally orthogonal to this patch, but it may make you
> feel better to offset the other round of clearing I'm suggesting. ;)

This is definitely a better thing to do, and I'll make the change in v4, 
along with the comment style cleanup above.

Thanks,

-Stolee


