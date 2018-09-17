Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 407A01F404
	for <e@80x24.org>; Mon, 17 Sep 2018 19:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeIRAys (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 20:54:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34745 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIRAys (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 20:54:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id j25-v6so5371291wmc.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 12:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zbOIL0XSwhhABJipVrrFfvvScbIjjv7BZqRtchvt/OA=;
        b=Lk7RqVMbfiZ/7fCiwiPUhHMkLoWd8HbwP4a51K6a7DdWN33MHYKF7PV0X2yiayER+R
         kTHj7uAAOJyvKzv9yR9xzRZddxVQ2zSoiWGFerPwb+iiUr17ugXyx5Jg2T8HJnh9jpu/
         j22YgllmMat2nTrdioMZ7uddV0S2pLmfOfsPOHHm6QvhTxjE1AO5Pe1UwTsS2wjmrKqe
         VJ8vJGaznUM6D7ui1uZpGfg1LZ9yqQvtRMYCyD5YHG33T64P2aJV9mUPiNQQEGMkAAI2
         GoGKzprO39ESrEKZ74uT2AmOU2jQib0Gea8Vx2500ch11Yo8WWXDfoy3HUo9YQrmwPeC
         w13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zbOIL0XSwhhABJipVrrFfvvScbIjjv7BZqRtchvt/OA=;
        b=b9El7SuP5Wr0iXIOHVTk8+82ABe2AS8AAssr3/eZofYhBBBFTpMWSKyhqG0j3RJwsD
         K2Dw2SAUBhKo9Cxq9wWWThbqnZJoyB2Mzw48Os94hwQgrn4NiHD1IO51czfYlfOwWfTM
         gdx/VsTMANPDFLD6hEAHCPX2eEpzkQpyx9+T1uwGX8ksQrH/+tzcqMNsso/dZ4/2TrUv
         cXkU8qUrVB5RIMQLalt9s++4OWFlTdrOeGcp6VnfAS7ouV6pHabGtljSu8ZGlax91jfU
         /lRiB9yWSSPwD3k8vrLIaeQZHZ4Xk8H1WMcjofb75qiwzS6HtHcS4VT0k9A/OvpI3CSb
         HV3w==
X-Gm-Message-State: APzg51Cshr1W5OzdLAJzfdQOsIftA5A/iV+eXhpJXcRfu4VIv971IJ/Y
        tCDxaXCHfQNIt0sWg6RXdyUSpDU7
X-Google-Smtp-Source: ANB0VdYhHp1bo7lvXv4R5vxQYEuy0fSYrdYETwlVPvCsDJOnanzzvfbOOMWFJ5AITtGzD1naCbNr5w==
X-Received: by 2002:a1c:c7c3:: with SMTP id x186-v6mr12645528wmf.109.1537212362449;
        Mon, 17 Sep 2018 12:26:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h73-v6sm148231wma.11.2018.09.17.12.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 12:26:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 0/1] Make 'git commit' not accidentally lose staged content
References: <20180820154120.19297-1-pclouds@gmail.com>
        <20180916063146.9850-1-pclouds@gmail.com>
        <xmqq1s9s82zx.fsf@gitster-ct.c.googlers.com>
        <CACsJy8C5QOLvg4pzy_pThQoyGh9ohdeVHXsuYwQHQypn3oBxkw@mail.gmail.com>
Date:   Mon, 17 Sep 2018 12:26:01 -0700
In-Reply-To: <CACsJy8C5QOLvg4pzy_pThQoyGh9ohdeVHXsuYwQHQypn3oBxkw@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 17 Sep 2018 19:29:26 +0200")
Message-ID: <xmqq7ejk6i46.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Sep 17, 2018 at 7:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>> On the other hand, if I am keeping some change that should never be
>> in a commit in the working tree file, and building the contents in
>> the index using "add -p" to incrementally, it would be the same
>> disaster as you are trying to prevent if I by mistake did a whole
>> path 'add', even if I catch myself doing so before running 'commit'
>> i.e.
>>
>>         edit X
>>         git add -p X
>>         git diff --cached X
>>         git diff X
>>         ... repeat the above number of times ...
>>         git add X ;# OOPS!
>>         git add . ;# OOPS! even worse!
>>
>> Even though this does not involve "git commit -a" or "git commit X",
>> an unrecoverable damage that requires redoing the manual work is
>> already done.
>
> I don't see a good way to get to recover this situation. I could go
> back to the "index log" idea,...

FWIW, I didn't mean to say that we should give users a way to
recover.  Your "commit -a" or "commit $path" protection just
prevents the situation from happening, and I think it is sufficient.

The sole point I wanted to raise by bringing up the above was that
we should have the same degree of protection against "add $path" or
"add -u".

Of course, "index log" is interesting and it may even turn out to be
useful (I was skeptical about "reference log" the same way, but it
turned out to be useful without burdening the system too heavily),
and it may even remove the need for the "do not accidentally lose
information by adding more to the index" protection.  But until that
happens, if we are to have such a protection, we would wnat to give
the same degree of protection to "commit" and "add".
