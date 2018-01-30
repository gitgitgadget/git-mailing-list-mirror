Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D58E91F404
	for <e@80x24.org>; Tue, 30 Jan 2018 20:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeA3Ut7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 15:49:59 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:45755 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752502AbeA3Ut6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 15:49:58 -0500
Received: by mail-wr0-f172.google.com with SMTP id 16so12642714wry.12
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 12:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FqXTm5vXqRw3S8A3G54edzmfcGdFs8gCjHDLNLIA+OU=;
        b=tWUZqjydTFajZ/seyJd+BQPTkg4Bxs3QIwS4hooAZJOSoekShVk+IHWbqYwEcsF5Qr
         g76YhA/hRgL/bMhKANbAKQ/TqOOiYw8es/z0ihxqHBO9G6FAhUPVOVGWYCreJJx6y6Un
         VHcOK646ALmKVhjx4YMJgoCgZYc0ppTOyElIo4c8xpJDBolzcCUyWoUzL6fDoz5jxKql
         u7bIcx83yRC5Md4enTmFItxr/SbvPqx4/bLOQGLWZgaks2eM/a0xMLg8agNF0iD68euL
         ofcRrFutP9bsAw+J9Z92Y8YByZrwl8bZ2MC1VQo8ymsDoHhfYox1ItOP4AH3AEeAzS0Y
         KEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FqXTm5vXqRw3S8A3G54edzmfcGdFs8gCjHDLNLIA+OU=;
        b=JPQEkYcEkxIVaNztc0tdvkESc1+5+/y49Ssr/IfQ2vbJ3RIIO+PebTuLoDqrPQXOUr
         1ns03qwWMZPtOhtd3z1N/9uS5fQqGiG/iBK0i8s9QMk4EYQxCG1q3hKxONaoDpcEUEWM
         3GcZnMk4Cm1FzJpummprun1ke99kbykaMsOorNoDhlgHnWsVMCsTWJu2wMJw8SJODWbu
         C/muLR8SHG4OSZZVCMJSwJChOu5sqnSpoFqCsz1YJEmMnNrWY4P0+YkSo6tQeqstyhlv
         +QEoHiN2AjGHLmCygV+H3eT3d7StY2uP1HByA7idVfLSmU053KVSehYYyo3GihBu4Y25
         IWpA==
X-Gm-Message-State: AKwxytfRoPUq2qM68TXQ9VR4drlcIAX7x3sX1CrFeadr5mrGTncS9X1W
        WAaDa0bWZX/n4KhbLB6BrLM=
X-Google-Smtp-Source: AH8x225eSNG2fGPZbraMkL3ZBA2NnnSgRyLx+JuJGh42S0fbGPBtu7tJNtBvbW4TEUrhtZIns8nLiQ==
X-Received: by 10.223.186.129 with SMTP id p1mr24145427wrg.183.1517345397120;
        Tue, 30 Jan 2018 12:49:57 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a139sm12231771wme.1.2018.01.30.12.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jan 2018 12:49:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH RFC 01/24] ref-filter: get rid of goto
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
        <xmqqfu6s74pf.fsf@gitster.mtv.corp.google.com>
        <CAL21BmkOGE6UZQJTFQjq3qnmywwBJQOUXE7jSwP1_Vn6PZ8ezA@mail.gmail.com>
Date:   Tue, 30 Jan 2018 12:49:55 -0800
In-Reply-To: <CAL21BmkOGE6UZQJTFQjq3qnmywwBJQOUXE7jSwP1_Vn6PZ8ezA@mail.gmail.com>
        (=?utf-8?B?ItCe0LvRjyDQotC10LvQtdC20L3QsNGPIidz?= message of "Mon, 29 Jan
 2018 10:13:45
        +0300")
Message-ID: <xmqqd11rt6ks.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Оля Тележная  <olyatelezhnaya@gmail.com> writes:

>> one place improves readability.  If better readability is the
>> purpose, I would even say
>>
>>          for (i = 0; i < used_atom_cnt; i++) {
>>                 if (...)
>> -                       goto need_obj;
>> +                       break;
>>         }
>> -       return;
>> +       if (used_atom_cnt <= i)
>>                 return;
>>
>> -need_obj:
>>
>> would make the result easier to follow with a much less impact.
>
> It's hard for me to read the code with goto, and as I know, it's not
> only my problem,...

That sounds as if you are complaining "I wanted to get rid of goto
and you tell me not to do so???", but read what I showed above again
and notice that it is also getting rid of "goto".

The main difference from your version is that the original function
is still kept as a single unit of work, instead of two.
