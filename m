Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FADD20C31
	for <e@80x24.org>; Fri,  8 Dec 2017 17:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbdLHRkI (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 12:40:08 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41560 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752259AbdLHRkH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 12:40:07 -0500
Received: by mail-pg0-f67.google.com with SMTP id o2so7299623pgc.8
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 09:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7jJYlATx4SfQ9iY/dfsEFApb5vy53ZPeIScc72FRMU8=;
        b=efXWVv4mGyfweUllbpSqbtJeQDlGiXXIo0wgzuZMqCaG4fXb1kF1xKT96L39eFJ/rJ
         OkjTzZKrCdw4D3w1IDu1caPoEn12L3AEUvI1YQCxYIFoxhOLYO/eCBwialIu4Sl53lvT
         Rshpw2VUZetfq1K2MU4vOXT0eENtP5lBjFSun9pzTB42+p542PGgh+8uZxpla/tpukvK
         lTvY4ttbfHJv4muoewXv5iZXXa2YP+IcqGJ28dXEb/qNN3kb6RGBCixFnB5g1CPSJE9q
         ZpDJsZNdbV6MGHOivNfZWHjjtFAUSdMNZM+8LxZmG37hFfLQAoi7a2ajNROv1fVN9+rN
         blaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7jJYlATx4SfQ9iY/dfsEFApb5vy53ZPeIScc72FRMU8=;
        b=RGPap6ZuOAJkWdYgfWdkD+q53hsltTEj8+tB9jdeH3Uq9i5cqtHcQzhR6txBh187oK
         3cdqdZR4BaZ/q4C7DyMB7vmeSpy9XVKqOm5L+YKkPaOhqj/MOWllVZObQqY8228jARAe
         vF5EwrEc2vUwmUPi1LagdN5kUUsUn/jn8h1L2EP+lGi1RCGXyAZOOSJ6VOLmOyNUZUjB
         fZtoikFUQs+wtbpM5vSJ4rYZUrc2RgmhU0ylHYNI9p5jK7JElH4C006ZhntYC5kLUt6R
         7DzmICnBb4s2JBnwDEs8sF1v8jivcGxeFXqPIKykQhf4anpqwz1Gzd+jB1h+30dY3vx2
         8Qkw==
X-Gm-Message-State: AKGB3mIwi+HsCfb4Axpy7pmk+4ofzoQYBuYE9iZ6kZai37LMXcuSGGqZ
        aZb7neZWyL9l91e36WcrbMzMZ1Nc
X-Google-Smtp-Source: ACJfBos+S4P2d3249pz2maSTUT/uk5viYJZ4FsNddLU/9RunOvRxmw6fbCnJ6YWAl2jp4Z9nRzaipw==
X-Received: by 10.84.234.135 with SMTP id n7mr204073plk.298.1512754806633;
        Fri, 08 Dec 2017 09:40:06 -0800 (PST)
Received: from [192.168.206.100] ([117.251.226.118])
        by smtp.gmail.com with ESMTPSA id u90sm16838745pfg.106.2017.12.08.09.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Dec 2017 09:40:05 -0800 (PST)
Subject: Re: [PATCH v5 4/4] builtin/branch: strip refs/heads/ using
 skip_prefix
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git mailing list <git@vger.kernel.org>
References: <20171129034620.4719-1-kaartic.sivaraam@gmail.com>
 <20171201055933.19368-1-kaartic.sivaraam@gmail.com>
 <CAM0VKjmy8J5VnROyv_O=iVdwn2yELUjPv=XNu6JzJ+OePWbh4w@mail.gmail.com>
 <xmqqh8t2b0tw.fsf@gitster.mtv.corp.google.com>
 <xmqqd13qb079.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <b0d7a230-b03e-20a3-1e57-dc42b4cbdda7@gmail.com>
Date:   Fri, 8 Dec 2017 23:09:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqd13qb079.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday 08 December 2017 04:44 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>>
>> Somehow this fell underneath my radar horizon.  I see v4 and v5 of
>> 4/4 but do not seem to find 1-3/4.  Is this meant to be a standalone
>> patch, or am I expected to already have 1-3 that we already are
>> committed to take?
> 
> Ah, I am guessing that this would apply on top of 1-3/4 in the
> thread with <20171118172648.17918-1-kaartic.sivaraam@gmail.com>
> 

You guessed right; at the right time. I was about to ask why this got 
"out of your radar" in reply to your recent "What's cooking" email :-)


> The base of the series seems to predate 16169285 ("Merge branch
> 'jc/branch-name-sanity'", 2017-11-28), so let me see how it looks by
> applying those three plus this one on top of 'master' before that
> point.
> 

Let me know if this has terrible conflicts so that I can rebase the 
series on top of 'master'.


Thanks,
Kaartic
