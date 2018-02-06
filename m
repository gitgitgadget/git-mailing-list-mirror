Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8728A1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 13:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeBFNo4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 08:44:56 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36581 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeBFNoy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 08:44:54 -0500
Received: by mail-qt0-f170.google.com with SMTP id t25so2308452qtg.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 05:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=vm8zjsBI8bE+kXSkik0R0aPgAz3ZZouhUc909zT+lWI=;
        b=LDMU4TSl/I2Bx+Mp1bHRZ44f5+BD0QqIkQOyxomF6tzEXUY2QKHs3sOBPJ1HN8pPIq
         vR5VrKmefIhhy56k/h1UTziX+3lh6ttgH2eXDpQ1O3lqn2NAn3WfwUKxipjLO9xO8i0l
         I1lYHcn5pS3dpedXh2dngxXAJJBS06QbSZMkRUXjiEHRuCAEjhhvcb8Flu1798LJMQF6
         OwXDuS9L42CtFO2OIxXWZr8jwcVG3oJyzmzN4pwySV2R48Cl5itdwmgj5K2JO43m4Fbv
         bnnu4jMmIN8tXGcIn3EkdO1R9Hzl6FAc3AmzSJWiZd7bejO26lCKvnxaCV/QYVVL7clN
         hy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vm8zjsBI8bE+kXSkik0R0aPgAz3ZZouhUc909zT+lWI=;
        b=NTWJZJLLe1K26lrbjX4e7W3EN202me0M5EeZnwNMQKutrXRxiwPxRQ9MtaNfVi0ScX
         DsUw//+HG8VKEJAIabH77NoIoxXr6ZyT8XD4K5wRF31Dnxw93DwEDeDh1tuWJ66D3H/a
         /BWybUef6o/0ZtaHOc3OAbTcVUWKEd9+2SKdY5+dRuD77qetA3i1cF0hOJnG6GgIH38v
         +hH+PU0vw34tn6zdEh0Jw1Q/uC9xmt7rcoi2pfsWMBGILyM1KzDPn32YPHhrkrFg8eRO
         5JNpl38DJmwVnNpxu4FUG3PFIkWDi/2IgRdSV24d4/GUQykoTV0mBfAEYDpRf5IYL524
         Q+bw==
X-Gm-Message-State: APf1xPBeT/+rTZRIUd9zv5HdfZpOSG3KC852cVPxo52WgPVADMsJ7LDK
        xI33NoKZUgC6VDFLoNkI/Sk=
X-Google-Smtp-Source: AH8x227Wk0N7NW1fq/Yks24+ANE6uhg/4jxIpBpcxa616YDqmWkKL+IvNvttdtiyLoyT8QOyb1s2pQ==
X-Received: by 10.200.64.90 with SMTP id j26mr3711388qtl.29.1517924693530;
        Tue, 06 Feb 2018 05:44:53 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:88ad:1fb1:3dd7:9d03? ([2001:4898:8010:0:71e3:1fb1:3dd7:9d03])
        by smtp.gmail.com with ESMTPSA id g57sm3082563qtk.54.2018.02.06.05.44.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2018 05:44:52 -0800 (PST)
Subject: Re: [PATCH 025/194] object-store: allow prepare_alt_odb to handle
 arbitrary repositories
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-5-sbeller@google.com>
 <20180206011940.GD7904@genre.crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <38759fdc-64df-113b-9cc9-03e49b5b6cb2@gmail.com>
Date:   Tue, 6 Feb 2018 08:44:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180206011940.GD7904@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/5/2018 8:19 PM, brian m. carlson wrote:
> On Mon, Feb 05, 2018 at 03:54:46PM -0800, Stefan Beller wrote:
>> @@ -434,12 +433,12 @@ static int link_alt_odb_entry_the_repository(const char *entry,
>>   	ent = alloc_alt_odb(pathbuf.buf);
>>   
>>   	/* add the alternate entry */
>> -	*the_repository->objects.alt_odb_tail = ent;
>> -	the_repository->objects.alt_odb_tail = &(ent->next);
>> +	*r->objects.alt_odb_tail = ent;
>> +	r->objects.alt_odb_tail = &(ent->next);
>>   	ent->next = NULL;
> I'm sure I'm missing something obvious, but it's not clear to me that
> this transformation is correct.  Could you perhaps say a few words about
> why it is?

I believe the reason it is correct is due to this change, higher up:

+static void read_info_alternates(struct repository *r,
+				 const char *relative_base,
+				 int depth);

Now the method takes a 'struct repository' pointer (which at this moment will always be the_repository) but it allows callers to use a different repository, when they are ready.

Thanks,
-Stolee

