Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F2F1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 13:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbeIGRvo (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 13:51:44 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43978 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbeIGRvo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 13:51:44 -0400
Received: by mail-qt0-f193.google.com with SMTP id g53-v6so16085913qtg.10
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 06:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3LS+WxQfXZoBBHR609QHAl49AU25HI8iq3H/OcM0pec=;
        b=LauNyRRyGPBM4yMrtheSdHU6NKPMwMbDroQc4GhugTy/14Qx6/CGybEsNLD4g/LQnQ
         bCO/WUseHlQTleEwT+l7rIb6PAQTNz4zWKbfSmY2/ITMSX01zDTHMuBTZr1BTbdPwLeR
         W++pwL/YPKyyrDVgAGoZUIsSNmGHul0+FY1WL6gmEFXpZtdLIuHO8I7bUMqLDxRFIjvi
         yfMNsfDATDm6/1a9prYdd+mVPmFVc8fxebxDemVrBl/W8JmhjVf4+OGwnFexA35EwRp0
         Pkz1+hGB7O4RNEyYt78AGonwod71eOv0yJEzTEQHSqBF3HZh1jxUrUWjcbc45UnnM1Jf
         l4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3LS+WxQfXZoBBHR609QHAl49AU25HI8iq3H/OcM0pec=;
        b=En7D+3NpCqRkSsNfYraf1gSz3h+C10GbNnshEWTyXdcGrq7/5H8hJNJanxzpaO0fVv
         dHNm58MM9+edBA9bTtv2F8NxHRVtV+MHs47g2akGJR4UFtrijWLY0tO7rZONeX2b/ukN
         N/BICmY3GHy2pDgRJtylALaznyTHxynI1xHoXTWVrAJ8j+PDHzpt8RzF1Io4ZbByeNbt
         nJTBGgbS+RhgLBcOV//p8Ap+v9oijkGZobdKtrjMEQsms/S8qjxKQAOXFwYix3PF/0A4
         Ax+0MIR4Iyz1YddONW6O4mzBanm5wVpV6sn54yI1wJO2gnA2Ge0qKKgGIUp9WNhDBt2N
         r5JQ==
X-Gm-Message-State: APzg51AyZZnAgHN4hmQ1B/Ij4q1Nax3chF55EB/MGc7KR5uaMx9ryNAp
        pAmQWD3j/vtfBg0UQvT5SeR3rzec
X-Google-Smtp-Source: ANB0VdZg3TzuOe5TsrCVfJzHdzJ96fe4yhO6F2HBiwGGIazjWakgnSvp02KO34JVniekhIfM+aaf2g==
X-Received: by 2002:ac8:51cd:: with SMTP id d13-v6mr6131518qtn.80.1536325849522;
        Fri, 07 Sep 2018 06:10:49 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:941c:6325:aef0:7c76? ([2001:4898:8010:0:7d52:6325:aef0:7c76])
        by smtp.gmail.com with ESMTPSA id f184-v6sm4330897qkc.23.2018.09.07.06.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 06:10:48 -0700 (PDT)
Subject: Re: [PATCH 09/11] multi-pack-index: verify object offsets
To:     Eric Sunshine <sunshine@sunshineco.com>, gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.34.git.gitgitgadget@gmail.com>
 <e1498aea45eb46feb3664413f49b70bdf048d284.1536158789.git.gitgitgadget@gmail.com>
 <CAPig+cQKt4sq4bhRUoGJMV=GxHzx-AtD_5J7DNtfMngH-uJRFQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <13c86d01-7b7d-29c8-380f-379b57da9638@gmail.com>
Date:   Fri, 7 Sep 2018 09:10:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQKt4sq4bhRUoGJMV=GxHzx-AtD_5J7DNtfMngH-uJRFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/6/2018 8:34 PM, Eric Sunshine wrote:
> On Wed, Sep 5, 2018 at 10:46 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Replace the BUG() statement with a die() statement, now that we
>> may hit a bad pack-int-id during a 'verify' command on a corrupt
>> multi-pack-index, and it is covered by a test.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>> diff --git a/midx.c b/midx.c
>> @@ -197,7 +197,7 @@ int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id)
>>          if (pack_int_id >= m->num_packs)
>> -               BUG("bad pack-int-id");
>> +               die(_("bad pack-int-id"));
> For someone trying to diagnose this issue, would it be helpful to know
> (that is, print out) the values of pack_int_id and num_packs?
Can do! Thanks.
