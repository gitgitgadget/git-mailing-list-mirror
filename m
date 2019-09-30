Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A851A1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 16:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbfI3QgW (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 12:36:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45234 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731459AbfI3QgW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 12:36:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so5900408pfb.12
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 09:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Z1faWckin67l8s6BG31Ec7oycx54fk60oaZPa8Y79Y=;
        b=EpFj6gI7wrHP6Zhby/wL7O09Vw1vsKoJk34KB144y6Gcq9GDGvSlVvVPQosv47drb9
         R1deTn0bXvEDoTskkee95E+4qS6PuH6dvkcdYQnSkEHLwOL+zsHF8GOlC8i3VihOqIyy
         cQih2MI1yzQ9gms5djxSpSPwq3OLjHmrlx2St+fRSr84m25t4OioHs1BzcAhWzZgQYR5
         Qk2PbaSy4vB01vHrPJasKspVzdILEkXzJqZuHp1hHLfa15x4rfyEbepE84u/n/o5Ns9f
         yIumkutYsdiTK2895mJCPSaMsZPPC2XQ088y0eFnVJdcw2Y93BKSl2GXpvnbOO1CbE6I
         VE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Z1faWckin67l8s6BG31Ec7oycx54fk60oaZPa8Y79Y=;
        b=rY9naHYUOsa2uzuVbEMZBa4AqZGZkvKl7n1h72N7Xn/KiLFOFtuHFXzHA0AUuDW6hk
         gM4QXTmDNPOUh4hKHTILoKZH0WzoHL2EMLJxbjX2/5n/6TjTINq9RfsrPPdei40JRQwC
         ynZUTysAPBGJqq32HH3hIUYNJWl+b+7Pzn6lnmBp3uW4/cvfW5D/JqceScZ2Z7od1Gg8
         tgV+5Mk5bIIwwJmtC1x9hWG1A3sRWIVt/QSJmNFVjgcXgzCYvPe8XF6JegDArm3pGddW
         f1ge/cf03jlbfoVogrkOHIsiSQjEVFqGVVu5VHtXx3+LxVLDal2gVbRtudK0Tp5xIdek
         TAVA==
X-Gm-Message-State: APjAAAUa49u1qCdg57QnuWfFqO7NiUdtGhcEYCXdBpPyZ1Hta8n6Qgi3
        MFkYfYwHeK0B1HBYe9p3TFk=
X-Google-Smtp-Source: APXvYqzg9F87D0I1qcKkG9Jt+TJNP/lnCrMhx2iz7TYiO21pbHdisc/K2ZGSOcBTSYnxhEzd9FxN/Q==
X-Received: by 2002:a17:90a:77c7:: with SMTP id e7mr122148pjs.114.1569861381749;
        Mon, 30 Sep 2019 09:36:21 -0700 (PDT)
Received: from GVFSs-MBP.guest.corp.microsoft.com ([2001:4898:80e8:f:a896:71af:9e6e:a9c9])
        by smtp.gmail.com with ESMTPSA id m19sm25239pjl.28.2019.09.30.09.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 09:36:21 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] midx: add progress to write_midx_file Add progress
 to write_midx_file. Progress is displayed when the MIDX_PROGRESS flag is set.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
References: <pull.337.git.gitgitgadget@gmail.com>
 <pull.337.v2.git.gitgitgadget@gmail.com>
 <3bc8677ea7655a3706914f9753c0a3b79dbf7e1f.1568998427.git.gitgitgadget@gmail.com>
 <xmqqlfuiu3sv.fsf@gitster-ct.c.googlers.com>
 <373fc8e9-2ef3-d501-b6e0-b953e047ac78@gmail.com>
 <xmqqftkhkrl6.fsf@gitster-ct.c.googlers.com>
From:   William Baker <williamtbakeremail@gmail.com>
Message-ID: <07d054d2-c37e-5a8a-9550-c1d90bb80af7@gmail.com>
Date:   Mon, 30 Sep 2019 09:36:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <xmqqftkhkrl6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/27/19 8:49 PM, Junio C Hamano wrote:
>>>> diff --git a/midx.c b/midx.c
>>>> index b2673f52e8..54e4e93b2b 100644
>>>> --- a/midx.c
>>>> +++ b/midx.c
>>>> @@ -449,6 +449,8 @@ struct pack_list {
>>>>  	uint32_t nr;
>>>>  	uint32_t alloc;
>>>>  	struct multi_pack_index *m;
>>>> +	struct progress *progress;
>>>> +	uint32_t pack_paths_checked;
>>>>  };
>>
>> I went with u32 here to match the data type used to track how many
>> entries are in the pack_list ('nr' is a u32).
> 
> That kind of parallel is valid when you could compare nr with this
> new thing (or put it differently, the existing nr and this new thing
> counts the same).  Are they both about the number of packs?
> 

Both 'nr' and 'pack_paths_checked' are about the number of packs.  
'nr' tracks the number of packs in the multi-pack-index and it grows
as add_pack_to_midx() finds new packs to add.  'pack_paths_checked' is
the number of pack ".idx" files that have been checked by add_pack_to_midx().

>> I could switch to this to an unsigned but we would run the (extremely
>> unlikely) risk of having more than 65k packs on a system where
>> unsigned is 16 bits.
> 
> Why?  If an arch is small enough that the natural integer size is 16-bit,
> then limiting the total number of packs to 65k sound entirely
> sensible.> The only reason why you'd want fixed (across platforms and
> architectures) type is when you want to make sure that a file
> storing the literal values taken from these fields are portable and
> everybody is limited the same way.  If a platform's natural integer
> is 64-bit, by artificially limiting the size of this field to u32,
> you are making disservice to the platform users, and more
> importantly, you are wasting developers' time by forcing them to
> wonder if there is a reason behind the choice of u32 (does it really
> need to be able to store up to 4G, even on a smaller machines?  Is
> it necessary to refuse to store more than 4G?  What are the
> reasons?), like me wondering about these questions and writing them
> down here.
> 
> So, unless there is a reason why this must be of fixed type, I'd say
> just an unsigned would be the most reasonable choice.
> 

I agree that it's best to avoid using a fixed type here unless there's
a reason that it must be.  Do you think that both 'nr' and
'pack_paths_checked' being about the number of packs is a strong enough
reason to use u32 for 'pack_paths_checked'?  If not, I will update
'pack_paths_checked' in the next path series to be an unsigned int.

Thanks,
William



