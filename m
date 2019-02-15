Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A02D1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 17:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfBORuN (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 12:50:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35182 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbfBORuM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 12:50:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id t18so11267226wrx.2
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 09:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kUBTdZwtYTl1v+SLReuPYZN96Ko0qQvqsE252aeO1ro=;
        b=dAUZzTfmpMq1kquJXg1GbALYRkUGjzuGFcSIgrwTAJcT1lU47IZ2tN02fBF1pmIMd0
         SpGB1J5NGMDdHgnOvA/15dAM84M0KrSpLsKu4QQq30H/+Q2avi1ZkLjcS13fjhgIpSMD
         EPnGC2+C+iKqgvZqrXx2XV3HkU+FBR0SCAz2/atwbazEvte+rocLIsZbo+qUf3ClDQn4
         J3O+8e8sW4FWkALWTSPL4Mln1xu97nbchqftyCif32WZLyxHesKcH0o6wPNCHto0J1Rf
         VT8TPUIsOA/sJ3YRuYJNh0a6NtNg7mAeuKF9JMXhh7u4Dg/yv3kJNSNx4HkW1QnNVxt2
         mwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kUBTdZwtYTl1v+SLReuPYZN96Ko0qQvqsE252aeO1ro=;
        b=aY+HQNCYYu00g2gH1gIZfMj4jg8CMjkZBu8qupKY3ct9+0//kOKkShgUojOOmTo4IV
         wP6AzHoL7arPFTgCCJ01CgCjIxwJz0vyV+ruTijBctGd/Jq+b8w3Yrv1UGcIqFhjVBkq
         WP+d/BqiDt576I+XNJI6Em2jEjkdQT2m9GfW2PpEciy9BB7XsBywOjC7cBwAevFDzeqY
         c10qh01/rQarmUHOOqgbfiwopvStz6sjMhSuHe/glmt7neR3CEnEFFiuTfFq7xYZzBOL
         S2647iWI8/21aNv5so19n11Znqz1RzfJh7SeNTSefwTmP9lzyQGLeDg4uUVSrDiAKoFX
         abpQ==
X-Gm-Message-State: AHQUAubS+7s64dTIg2vjZQl+euIogCvaoZTSHNHIVtP/pkuUQYu0s9Fm
        D8alhx8r2aWT0pj0RJw9URk=
X-Google-Smtp-Source: AHgI3IZWxhHCUCHRkAKRS2/Z6NGZJs9K0fQM6fh1Z8dCfKIivnybF8+CkJvrbP8JHJG4oKxjkaBtVQ==
X-Received: by 2002:adf:9d14:: with SMTP id k20mr7343313wre.97.1550253010636;
        Fri, 15 Feb 2019 09:50:10 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i16sm3301196wru.16.2019.02.15.09.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 09:50:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        benpeart@microsoft.com, kewillf@microsoft.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH v2] read-cache: add post-indexchanged hook
References: <20190208195115.12156-1-peartben@gmail.com>
        <20190214144241.11240-1-peartben@gmail.com>
        <2f08ee3b-4511-2838-4c70-640d01fe1658@ramsayjones.plus.com>
        <xmqqa7iy860g.fsf@gitster-ct.c.googlers.com>
        <dc851640-ac3b-74a1-a753-7ff2a43a4a5b@gmail.com>
Date:   Fri, 15 Feb 2019 09:50:09 -0800
In-Reply-To: <dc851640-ac3b-74a1-a753-7ff2a43a4a5b@gmail.com> (Ben Peart's
        message of "Thu, 14 Feb 2019 19:14:37 -0500")
Message-ID: <xmqq1s496iwe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> On 2/14/2019 3:33 PM, Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>>
>>> On 14/02/2019 14:42, Ben Peart wrote:
>>>> From: Ben Peart <benpeart@microsoft.com>
>>>>
>>>> Add a post-indexchanged hook that is invoked after the index is written in
>>>
>>> s/post-indexchanged/post-index-changed/
>>
>> Good.  I wasn't paying close attention to the previous round, but is
>> that the only name-related bikeshedding?  I somehow feel that
>> without s/changed/change/ the name does not roll well on my tongue
>> and does not sit well together with existing ones like post-receive
>> (which is not post-received).  I dunno.
>>
>> Will queue.  Thanks.
>
> Would you like me to submit another version with the above spelling
> corrections in the commit message or is it easier to fix it up
> yourself?

I've already done s/indexchanged/index-changed/ before queuing
(there was only one IIRC in the log message), and also the
'optimize' typofix.

I didn't do anything about dropping 'd' at the end, as I haven't
heard any feedback on that from anybody yet.

>>>> do_write_locked_index().
>>>>
>>>> This hook is meant primarily for notification, and cannot affect
>>>> the outcome of git commands that trigger the index write.
>>>>
>>>> The hook is passed a flag to indicate whether the working directory was
>>>> updated or not and a flag indicating if a skip-worktree bit could have
>>>> changed.  These flags enable the hook to optmize its response to the
>>>
>>> s/optmize/optimize/
>>>
>>> ATB,
>>> Ramsay Jones
