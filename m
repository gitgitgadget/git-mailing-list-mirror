Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAE541F404
	for <e@80x24.org>; Fri,  7 Sep 2018 20:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeIHBMY (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 21:12:24 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36636 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeIHBMY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 21:12:24 -0400
Received: by mail-qk1-f196.google.com with SMTP id 93-v6so10487699qks.3
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 13:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=06Dl/SzqJl7mdmcQ1ZvSBkiO9s4mBmaVGM6MQ2izChA=;
        b=kVhvC3i73Hd9djZF25AaySFON8J7Ws89knD9jMEno/44XrjL1Bq6zmTKqqxaSSiAc4
         lNOav1ofoCHnRAcSmp3sOM85Fcz72fiJHlkCNB6BDf0oVTSC5IpYHD1z0bemMMhaJJuc
         6aUsbKM+1LPv5B4HV6Nad8IsSkT00WYbPPz5TaHYpXcN+c9xmjGqevUcLJYcoWHLbR/O
         jzZjHuw0mrCTee5Qog8eyURpOus47TUVY+X2bumtd6HcYhFH6JUlOlejVRMNWful0+Rp
         JL3NT/Xavvt1hKMRzNIWupTctLT0TBz/B/kvvqr1D4RfQ/e4IPhOo/Yylzjd5ibjeHYI
         nLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=06Dl/SzqJl7mdmcQ1ZvSBkiO9s4mBmaVGM6MQ2izChA=;
        b=FjFORcj9DzapApYsyvOSAttIshOQluWNMiM9hzv2CYLh73BzZPRuhejSSljx0dfxfP
         X/dYexbSndVxOpDr4li3xoKXzWFCu01AFXU2qnGwZcEmi+gLc9hz+ERExOjtf1OiKdJW
         58Iq//NmeoD+8mKvALhb8XNr6M8BB+VJ4oeD2DfqhXsBrmDWP514SaD8NsH7fVDASaT6
         xG98HZjOgtlUoCYmEAyVohBi13P4IlAn7xWQMrIBH24aF5tHlxHHsS7HjQzq9N2Ao9hN
         urdO5y3RALOh5VAaSjMPKTl7fC0EiZk91k1y2WU7NsCMSrZZsYwE9bAmb4yYdVEzznEL
         6kVA==
X-Gm-Message-State: APzg51DFDN3DtInao8F2A2A+dQMLgB9sscpeZrRf1yFEmVEaYMPpW8lW
        lya97dH7HKn3YI5LogrPxV8E4ULs
X-Google-Smtp-Source: ANB0Vdb6R5CGnDGwyK6aefN2NYZMho9ycxwXigytQ8YU8YrayMy73a5tiet4NHlBOSZw3GJRh3R3mg==
X-Received: by 2002:a37:ad0a:: with SMTP id f10-v6mr7247380qkm.186.1536352187942;
        Fri, 07 Sep 2018 13:29:47 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:343f:f4ad:2a71:7def? ([2001:4898:8010:0:1d75:f4ad:2a71:7def])
        by smtp.gmail.com with ESMTPSA id s8-v6sm6011720qtc.71.2018.09.07.13.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 13:29:46 -0700 (PDT)
Subject: Re: [PATCH] status: show progress bar if refreshing the index takes
 too long
To:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <20180907155133.27737-1-pclouds@gmail.com>
 <CAPig+cQVCUyt5NvcSCAO63b1aO8HSc5AobCRKP5mp9jT_LYuJQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <796edb6b-74ec-35dc-4bae-7a817f8fa9b5@gmail.com>
Date:   Fri, 7 Sep 2018 16:29:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQVCUyt5NvcSCAO63b1aO8HSc5AobCRKP5mp9jT_LYuJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 9/7/2018 1:38 PM, Eric Sunshine wrote:
> On Fri, Sep 7, 2018 at 11:51 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>> Refreshing the index is usually very fast, but it can still take a
>> long time sometimes. Cold cache is one, or something else silly (*).
>> In this case, it's good to show something to let the user know "git
>> status" is not hanging, it's just busy doing something.
>>
>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> ---
>> diff --git a/read-cache.c b/read-cache.c
>> @@ -1516,6 +1522,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>> +               if (progress)
>> +                       display_progress(progress, i);
>> @@ -1547,6 +1555,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>> +       if (progress)
>> +               stop_progress(&progress);
> Nit: Both display_progress() and stop_progress() behave sanely when
> 'progress' is NULL, so no need for the conditional.

Don't forget this one in preload-index.c:preload_index():

+	if (pd.progress)
+		stop_progress(&pd.progress);

I found this extra one by creating the following rules in a Coccinelle script:

@@
expression e;
@@
- if (e) { stop_progress(&e); }
+ stop_progress(&e);

@@
expression e;
expression i;
@@
- if (e) { display_progress(e, i); }
+ display_progress(e, i);


Not sure if we want to put these in a .cocci script or not.

Thanks,
-Stolee

