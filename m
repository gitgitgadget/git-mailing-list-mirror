Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2CBF1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 19:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfAWTOh (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 14:14:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34225 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAWTOg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 14:14:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id f7so3858940wrp.1
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 11:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=toDssl2zJ2HhokZ5cXtT7toe5ei+RZvUVgsXQQXunE8=;
        b=Sa3EFbcIqJZnrWXfrObvj7nXs385npAKyCfWZoDsLFwTsovyCc3RxzkJlY2haUuxPn
         3OlyyJJ1wm5FoaGEQeMH1IZQTivjbTOz4pMTRVmHJGzEPh+QpXn0Dlf5nXjc5SGzjDCJ
         ObhMkWbLSYeSVwiwRfvdzgEdjK0r/408sRC6OvPDstN5YkwsnoXan55GqHIFI2TDJqBX
         NnqbBMDDS/mN/2QfVX+uhUJ4SQxBm69S7cUcfp/MRf2cZcj9eim9ByqijRoawj833gIS
         1pBH1AI4WCKr+P4/0SFcOEpmcT0ZbG15435Ya+q7YeQsvku3Bnblbt6KiM6eaNqmQ49O
         7Nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=toDssl2zJ2HhokZ5cXtT7toe5ei+RZvUVgsXQQXunE8=;
        b=pIX1xYmbWDdCfa+N/hS2DjQUmJzT4g4eo7FJONRJveXAvEILsup2upYfQib8IL5Wis
         fuTbq9yO5FGU8zZN1macrIg+ioPIA6XB6AkCqzQXCX/PfK4OYLpJwMRUj29uzzO2rXpI
         zs3cNRUyBYD7gbkkoSQL3wfiNVjDfV18ZdgQsVrCMmQJo06nMpDNRmGHOmAD28Ejpnba
         8sQiAmCBNdWsNrLmdk2x8MiPRM2eTucq7LlyHL2ujdbRdPN/Tji8y3RigOL2rpyrZTty
         8Q9RtuTcXNcNeCGJsePwPFgUUKLPFC52zM8M1HaNxXTZPRRcJCk7Z4oqRf9QpA8cuy+h
         M/Lw==
X-Gm-Message-State: AJcUukeMUJ/idoJaEON1viHj+MxvaK5vZL+/EE5mynYPQeMOgawvBv2v
        nN4/8hC0V4Ta9FjV5GsLebw=
X-Google-Smtp-Source: ALg8bN7GXJsXHCnYnbwYu6bodsWPZoIPiWXPzOmE+XRejboreghu17GJ9OlZdecMsNGmU9FT01JiYw==
X-Received: by 2002:adf:ee89:: with SMTP id b9mr4191901wro.246.1548270874402;
        Wed, 23 Jan 2019 11:14:34 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c21sm70654407wre.71.2019.01.23.11.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 11:14:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, asottile@umich.edu, benpeart@microsoft.com,
        pclouds@gmail.com
Subject: Re: [PATCH v2 0/2] Fix regression in checkout -b
References: <20190118185558.17688-1-peartben@gmail.com>
        <20190121195008.8700-1-peartben@gmail.com>
        <xmqq4la0h6am.fsf@gitster-ct.c.googlers.com>
        <2a3ac803-133c-98fb-45e9-43f6e4a018d1@gmail.com>
Date:   Wed, 23 Jan 2019 11:14:33 -0800
In-Reply-To: <2a3ac803-133c-98fb-45e9-43f6e4a018d1@gmail.com> (Ben Peart's
        message of "Tue, 22 Jan 2019 14:31:16 -0500")
Message-ID: <xmqqsgxjb2zq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

>> This is curious.  The location the new special case is added is
>> different, and the way the new special case is detected is also
>> different, between v1 and v2.  Are both of them significant?  IOW,
>> if we moved the check down but kept using is_cache_unborn(), would
>> it break?  Or if we did not move the check but switched to check the
>> index file on the filesystem instead of calling is_cache_unborn(),
>> would it break?
>>
>
> I had to change the check to not use is_cache_unborn() because at this
> point, the index has not been loaded so cache_nr and timestamp.sec are
> always zero (thus defeating the entire optimization).  Since part of
> the optimization was to avoid loading the index when it isn't
> necessary, the only replacement I could think of was to check for the
> existence of the index file as if it is missing entirely, it is
> clearly unborn.  This solved the behavior change for the --no-checkout
> sequence reported.

Ahh, chicken-and-egg.  Please do add an in-code comment on why this
is not "is_cache_unborn()" but must be "file_exists()" immediately
before that if() statement.

> The only reason I moved it lower in the function was a micro perf
> optimization.  Since file_exists() does file I/O, I thought I'd do all
> the in memory/flag checks first in case they drop out early and we can
> avoid the unnecessary file I/O.  As long as it is tested before the
> 'return 1;' call, it is logically correct.

I see, and it does make sense.  This explanation only matters to
those who read and compare v1 and v2 and much less to those who read
and consume only v2, so it probably would have made a difference if
it were described in the cover letter, but a passing mention in the
commit log message may be enough, if we wre to leave a record of the
decision somewhere, perhaps like "As the new test involves an
filesystem access, do it later in the sequence to give chance to
other cheaper tests to leave early" or something at the end.

Thanks.
