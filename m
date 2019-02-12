Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C4FA211B5
	for <e@80x24.org>; Tue, 12 Feb 2019 00:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfBLAbD (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 19:31:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34187 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfBLAbD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 19:31:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id f14so802868wrg.1
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 16:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jGB1Re149S5VeA8nPlncm6zTNOjDnTlj9PFP+8ylEGk=;
        b=nCA4PQp/afItK23yBS71Bvy9qs6l+ihpXhJCJF8GJ+jzS4JZRFoJxYrl7y+VFQKE8G
         0B5OkmXodloCu9DJTtIESMpqKWsvZNZ2Zf3230kC4RrGIY0iQp6g5ge3YSn9RH/Ofw8i
         Y9trqAQgD9pevMsbYDAsCjhwPgCMWcxuT48jkIGPtwJ+OmsYuo+as4hhUoPUYNprO+EG
         OpMwQrmW5VxkIz84NnmnvBfXVP6QukT3KbYbax2YDFCtuD0Z7GgOg4xxtz5MM66Vmpsx
         l3OEtf0J/YEaquP+7CpgOr4kpLLUkmjZoxLZtiJEzLFtUb3GfeW9b2aJHgEf2KrlHqwY
         WYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jGB1Re149S5VeA8nPlncm6zTNOjDnTlj9PFP+8ylEGk=;
        b=JUNIumQBUW5JE/9CbEIHswTXtlhLDCLLxretoZI/4NJmks5vBcaxRHJ50hZML3NWom
         /LKVLIBYkxDnQY7srunJbKGRlQblFzmS0U1HE2tSGKRHQUeSGfNNzIm+1av/eyJiZIg8
         8GZweBoU4ZZSyKo4uiMVeGDBHs2qR05PRo2aFfdGBxfkP3YScOY0jiI50WuwDkTevatQ
         Q3BIq3UiYaV3KguMX4WKQVoeF4t6Hw25r6oPEmHbA0YRDHoNiJoKKQUubVIejWnQPHpI
         w85VSp/30zRi9IymJSR2I8oOR6sEBD8/1dzPxppun6ivdbInzvK4spdE32Orl4yOZ/Mk
         kqfQ==
X-Gm-Message-State: AHQUAuZ99J07BcNsX/F2JKvwc+8dI0dIU55vj7ar8xZdgg+w7ndeXfqf
        f7w0TceI9iP7Faft8RyqC/s=
X-Google-Smtp-Source: AHgI3IbNQe/YaY8FFeBGz02c/RYwb3ou8z83AFYzpq/tcY8XBts5KiiV3cabaq8tDw3TATEj2xCpeQ==
X-Received: by 2002:adf:ed11:: with SMTP id a17mr607976wro.283.1549931461685;
        Mon, 11 Feb 2019 16:31:01 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t12sm1515029wmi.11.2019.02.11.16.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 16:31:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v3] utf8: handle systems that don't write BOM for UTF-16
References: <20190209200802.277139-1-sandals@crustytoothpaste.net>
        <20190211012639.579489-1-sandals@crustytoothpaste.net>
        <20190211214306.GB14229@alpha>
        <20190211235835.GB684736@genre.crustytoothpaste.net>
Date:   Mon, 11 Feb 2019 16:31:00 -0800
In-Reply-To: <20190211235835.GB684736@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 11 Feb 2019 23:58:36 +0000")
Message-ID: <xmqqtvh9g857.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> -       cat lf.utf8.raw | iconv -f UTF-8 -t UTF-${i} >lf.utf${i}.raw &&
>> -       cat crlf.utf8.raw | iconv -f UTF-8 -t UTF-${i} >crlf.utf${i}.raw &&
>> +       cat lf.utf8.raw | eval "write_utf${i}" >lf.utf${i}.raw &&
>> +       cat crlf.utf8.raw | eval "write_utf${i}" >crlf.utf${i}.raw &&
>>         cp crlf.utf${i}.raw eol.utf${i} &&
>> 
>>         cat >expectIndexLF <<-EOF &&
>
> I'll squash in this fix, thanks.

Thanks, all.  In the meantime, what I've pushed out has this
applied immediately on top.  Unless there is anything else, I could
squash it in in my next pushout I plan to do tonight, before getting
ready to tag -rc1 tomorrow.

