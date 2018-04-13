Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84AF11F424
	for <e@80x24.org>; Fri, 13 Apr 2018 11:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbeDMLxa (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 07:53:30 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33214 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753831AbeDMLx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 07:53:29 -0400
Received: by mail-qt0-f175.google.com with SMTP id p9so5372391qtn.0
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 04:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dEkO+HuXTCrr6oelo8OhUuprkGbMb32Zu5jMPW+0DUg=;
        b=MWfUa+MvLTqpOeGu78L2g5mjmKsoicVFWyBmzXWpW6SSXRjVLsRmqOCw8pFipnPvL2
         uC2W3dtoqhtboGhELS4EPQC/DFeX9ChdpNRDVUU8DSl/gU4yKJ5ot35TQlwJY5GM7e+R
         v/3l5/YFXNBFLnqeQoVe7ntBLJnOaXF/vT5tOjWwVBR033LePKzYFKOPMNIWrrOrH7Xd
         GBGEN6Ygsgqs7/jGCDeK7yE7yyqa4r47yHDpNnqLXzaY6xpjNVVP4rjM6s6x72ZHScHs
         M4EuFkVdAnrfoN5PSRVPRp8SeGdsjN6H3+Yyc4tznllMSU9sizhRgDAB2EYQiEXOPQjf
         LrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dEkO+HuXTCrr6oelo8OhUuprkGbMb32Zu5jMPW+0DUg=;
        b=Kj4LAQNWEpKcD8I97GVnqugaEgNYMqfUx7TpWOOkPBVIWb7Pe58cPjtQlBjZ5y5uOu
         i9p8ERPjCIEo2MSiOBVyuUZ+Ud48Zuw3Hk/PjEDb+2lNp4PpFi2n4mDJpfq/WK2lAXxx
         yx3h4uYbEW5iKNXj0yFp+eE1DqEIbZk4FFD8LadvKiNQMVOcDNmWVsagfnfV93/AaIR0
         iN/K8ERAxq81O1N39Fd9hT/msIH9LTSlUov/j1mSEZLYHZFZZkAmPLCDOqAkOTKXvXJr
         53ft6Ijv7iOWNXT2vfocqeACahdJVEdXCZTfbHkX4BhFTWLkX+G8123sQSpXdMbrO/F8
         BdMg==
X-Gm-Message-State: ALQs6tAeuI1NH4ch8W9DbU5CmHBXsst70lwts8p7NCkixqFtws/X35xj
        gzN2O9d06MnXbnoGna60scI=
X-Google-Smtp-Source: AIpwx4+Rad2f/qDhsrCMJ5524APq+hFGQ+WIltGIA56TwIF3Iwpl/Alddcr0sceY/fiB0PYT0f/0MA==
X-Received: by 10.200.54.243 with SMTP id b48mr1449337qtc.334.1523620408320;
        Fri, 13 Apr 2018 04:53:28 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id z19sm4561018qka.39.2018.04.13.04.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Apr 2018 04:53:27 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] fsexcludes: add a programmatic way to exclude
 files from git's working directory traversal logic
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "alexmv@dropbox.com" <alexmv@dropbox.com>,
        "blees@dcon.de" <blees@dcon.de>,
        "bmwill@google.com" <bmwill@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "martin.agren@gmail.com" <martin.agren@gmail.com>
References: <20180410210408.13788-1-benpeart@microsoft.com>
 <20180411200007.8612-1-benpeart@microsoft.com>
 <20180411200007.8612-2-benpeart@microsoft.com>
 <xmqqsh812td0.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <0dc3c045-8851-cbed-6756-8dfda5e25868@gmail.com>
Date:   Fri, 13 Apr 2018 07:53:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqsh812td0.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/11/2018 7:52 PM, Junio C Hamano wrote:
>> @@ -2011,6 +2028,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>>   		/* add the path to the appropriate result list */
>>   		switch (state) {
>>   		case path_excluded:
>> +			if (fsexcludes_is_excluded_from(istate, path.buf, path.len, DTYPE(cdir.de)) > 0)
>> +				break;
> 
> Then the use of DTYPE() looks a bit odd here.  On
> NO_D_TYPE_IN_DIRENT platforms, we would get DT_UNKNOWN out of it and
> then end up passing DT_UNKNOWN to the function.
> 

Good catch.  I was trying to optimize this path and didn't realize the 
platform implications of using DTYPE().  I'll update it to match the others.
