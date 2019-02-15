Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62A1B1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 18:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389621AbfBOSZ2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 13:25:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34175 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388405AbfBOSZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 13:25:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id f14so11392703wrg.1
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 10:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ogHg3pkB0Clyqmbz0JtS58kA+UwXK/SDb7hFb6uB/7I=;
        b=HDe+Mdxwst+h8cY0gHvXXnTqhZ6yiaW0VkeqMfd2OYaTeJOke5f7DFVB3dVbjV1vfw
         LYyKu2oKdPSeT3MwKSfh14BQnUloqcw9VXL99SIRJZvXI9FNNxEICMoN0QxjT/1vvs70
         lgtJglKEcRLX6aoySfl1AJDkhjs98he8CzTaaYdCCH1wF8g2bJUMhQxc86VPKnk0QY4R
         HcQvl5u/B8vU9ubij4LxALd2VNCo01MlPvRXiNMLqYbfwHOE/NmXAQaXXQWbUEbkScK4
         nf36IEAQ7i42f4niieks7XUWNpTcYWgZ18/neB6WqD9nk1Al5whIzFB4D1j/z1v+0HKB
         Cc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ogHg3pkB0Clyqmbz0JtS58kA+UwXK/SDb7hFb6uB/7I=;
        b=McrAioeSTYtykjZgUSCRA1705Et1s4ntN2T+5qi46cDQmYnIrUCAhNK24tSzp8j5YH
         MCxwiQbSAh1s/4fhh+kitNkbGgXe+/dlfNqsc+TxZAH/uhjR0jVkyJfTKigNHy8ajXZp
         9eZuoGcRYQvz/0+yicvlTg5pnftpBqusOAghsArg4LqZDSJUUXcFpwSEMKEMDKTIXBey
         BOkd3OwduvkJfVRCo5T7Zu5fP8u2K/2O4O1Sv8gl7Qxe5qj1VUogtqbIFP6aB+C5ETcN
         T2oJmhga2lUcNikf+imKFTURMpxqMprJhCWg1vNIkEUXSzeQtet1uNisuS0kMLFOspn3
         AElw==
X-Gm-Message-State: AHQUAuaILk6/u3tfhobNY/h3zZN1IDtGCZA9/wtEixEkns8IJROWDNKi
        ojV5UucmDSCOGJ0Yeg3/Wrg=
X-Google-Smtp-Source: AHgI3IZafIwTrzZj+vQXbhFdY84Rx2w4XBBVy/U6rpmJg8pJgW7fdcLKY1phgt5jjRKJpVfEUojP5A==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr7650525wru.21.1550255125327;
        Fri, 15 Feb 2019 10:25:25 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v132sm9958242wme.20.2019.02.15.10.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 10:25:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] mingw: safe-guard a bit more against getenv() problems
References: <pull.127.git.gitgitgadget@gmail.com>
        <53e3d159c8c80924188f57c44efd2170612f2ee5.1550243863.git.gitgitgadget@gmail.com>
        <96793350-0991-6e8f-6ab2-15777e2071be@jeffhostetler.com>
Date:   Fri, 15 Feb 2019 10:25:24 -0800
In-Reply-To: <96793350-0991-6e8f-6ab2-15777e2071be@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 15 Feb 2019 11:14:01 -0500")
Message-ID: <xmqqh8d46h9n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>> diff --git a/compat/mingw.c b/compat/mingw.c
>> index 4276297595..8141f77189 100644
>> --- a/compat/mingw.c
>> +++ b/compat/mingw.c
>> @@ -1632,7 +1632,7 @@ int mingw_kill(pid_t pid, int sig)
>>    */
>>   char *mingw_getenv(const char *name)
>>   {
>> -#define GETENV_MAX_RETAIN 30
>> +#define GETENV_MAX_RETAIN 64
>>   	static char *values[GETENV_MAX_RETAIN];
>>   	static int value_counter;
>>   	int len_key, len_value;
>>
>
> Why not use a mem_pool for this?  We have that code isolated
> and re-usable now.  Have mingw_getenv() copy the string into
> the pool always return the pointer from within the pool.  The
> pool automatically handles allocating new blocks as necessary.
> And (if we care) we can bulk free the pool before existing.

Probably a good idea in the longer term.  The patch as posted would
do for the upcoming release, though.

Thanks, both.

