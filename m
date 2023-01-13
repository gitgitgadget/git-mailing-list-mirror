Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4CDC3DA78
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 21:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjAMVGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 16:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjAMVGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 16:06:09 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B83941A7E
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 13:06:09 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o18so2440753pji.1
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 13:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uG/rkGuGJFakaaB5QQnY9zP0TueR02SAbY9yKjyhaY=;
        b=EltkhYBe65VnMwH3VDjR+4EqAUMcG0OcF3gmIZg+QkjYOc5icxj6Jh+4mF8ysuy+mS
         M4ZBHecDwh4kxjB3nqa4nfday2DU0UBB5g7RaEVDTTNar88idqZPiw/RFsFNrklouESn
         KR6hzaf3HN3viVYR+QRcLzeXKI3PCAsn0zTVLxemAn3hPTrCdmHiGyW1+pEQ4YaypVTS
         pQQL1QLETGEddAYu58MefdNiu3TimLSXe9L00RkBcBi/lHl29kfSMqWqbxDgkQqxvN9u
         kNEGiQixI8C5V+CIljEB6pXJ3OEAb8dEnZ43JbPv0ZVV5j48QKGufXom8Sq9dgrgDPs8
         I6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2uG/rkGuGJFakaaB5QQnY9zP0TueR02SAbY9yKjyhaY=;
        b=CzsJptT2J6Smq1IZv6XAyDa2Pgtr+q0JJWlJiHz0jn9AlOFcCv3IsktUsz0kOTJa2Y
         GIXu1aDVuEqVPjdwHtvbEkD2R7ccTyY2k0XZ+R9Lw29hd3O5CVvLKrwps9zywjjD8XG0
         dqSorZ96i+lnV7gDGSCDIxmdL4lHDFhh3XvV5sYG8bCZ6wfbzOBavy8bBKNfiRXPDqX1
         YClQbmlam9IBepSGkRCmNDg3XCilIsry0iu1QOrajBEp4PZTHtH9YnZKK03crBTUTcrL
         iAtQCmruoqZv/avuY0Vlql59eiZeMRzU9UvMYCbbRG8cc0Cz9Zhz9b/KOxNpQ8TOU/Bs
         jdJg==
X-Gm-Message-State: AFqh2kpeMKQZexui7MeHiJ35ZcsrEJYSckATNtaWPLVOhkJal8qzo1dA
        T7g0mearl4y8GJKtC8ERpjY=
X-Google-Smtp-Source: AMrXdXvLiCCoXndvxFkQuCS5vXiBYrYUwEh+TOc/rxjv1QjYKEja4UEN1/V6G5EZorpdcGHBmGhJVw==
X-Received: by 2002:a17:902:ee52:b0:194:7771:4eeb with SMTP id 18-20020a170902ee5200b0019477714eebmr1835913plo.40.1673643968449;
        Fri, 13 Jan 2023 13:06:08 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id jm23-20020a17090304d700b001944b1285ecsm6046340plb.208.2023.01.13.13.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 13:06:08 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>
Subject: Re: [PATCH v5 06/10] test-http-server: add simple authentication
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
        <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
        <c3c3d17a688963acc180e3bb7bbb4deb32a94304.1673475190.git.gitgitgadget@gmail.com>
        <2a0b5f3f-7ab2-bc9e-76ac-93a52b4d32d0@github.com>
Date:   Fri, 13 Jan 2023 13:06:07 -0800
In-Reply-To: <2a0b5f3f-7ab2-bc9e-76ac-93a52b4d32d0@github.com> (Victoria Dye's
        message of "Fri, 13 Jan 2023 10:10:03 -0800")
Message-ID: <xmqq8ri616ww.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

>> +static int split_auth_param(const char *str, char **scheme, char **val, int required_val)
>> +{
>> ...
>> +}
>
> There's nothing really *new* in these functions in this iteration, just code
> moved from the option parsing/handling in 'cmd_main()' into dedicated
> functions. Looks good!

> ...
>
> I completely missed the "fall-through" comment in my last review [1], as you
> kindly pointed out [2]. ;) Given that, this makes sense to me.

>> +		*wr = send_http_error(STDOUT_FILENO, 401, "Unauthorized", -1,
>> +				      &hdrs, *wr);
>
> The "extra_headers" configuration is new, and helps make the test server
> more flexible. 

This is not limited to this single review message, but it is good to
see "this part of the patch is good because ..." explicitly stated.
I wish more people did so, in addition to pointing out what needs to
be improved.

Thanks.
