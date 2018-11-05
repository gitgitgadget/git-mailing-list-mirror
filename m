Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 577991F453
	for <e@80x24.org>; Mon,  5 Nov 2018 02:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeKELx0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 06:53:26 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:40748 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeKELx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 06:53:26 -0500
Received: by mail-wm1-f42.google.com with SMTP id b203-v6so6511977wme.5
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 18:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wZpatgGJaRQ3YGkwy2gmHYs8bfpxNN/wfSI6Hv7yIVo=;
        b=sWzjfoytGlXCuChWjHLFJfhXNmI7JhRBY+IUxDc2rmwks57jp5DDduhJk3yCjef+dW
         gkNgShQNsvha6yMiXxNc1BT4T/npU2LGZnyh77JDqhO7LVnwG8zQp90YRMetwKbAOJF2
         UCanofjpwpeTYmN5KtY3bQ/RyTfHjEhsevthRPp5OzxWTDH+0qQhXgOX0DPgoe/xDdLw
         jLXUMRIRY1YlfY0xkDVLuPu2KvCzH8f3tJ1W22JIqkIbdhbrrgRpEhDjcw+rwv1hv8ct
         ho2ToRIDDakV/2vEFAKu7OifgAkRLcIIWh6J/9LMwWYlYc3w6x7s/HZVpliuj//SQiOn
         00Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wZpatgGJaRQ3YGkwy2gmHYs8bfpxNN/wfSI6Hv7yIVo=;
        b=GL3Md2+VlwXajiXFtycn7RkkIRQppwISpkHFUus5TMMyw/h76B15TkJgFWbag9vbYQ
         CJEsHS1ucTqPjdyBUklw0SL6084E267Uu9A99ZcAi2I5NkRt5QVEiEreMd7H8JtqV+XY
         f1NFlEl9V5GRybwfnUyT9WEGutsF/XaZn4/yS8I4XxraWP3aycqHAV/H6TOfjcsDeKav
         3RZGOxe56N3VJQZjg0vMZDMIK2qRWShOpR/aXZwG1aM3EQsVgfvJeMG/BX8yzreCO690
         gxsjEwB6vAh3eaEA2PJM02Hu7dzfJw1JREX8jC8Jfh6LuNf+UQaePkzbk0/NtMsijHo8
         gj6Q==
X-Gm-Message-State: AGRZ1gIkp6W6GgCKBq+jQmm9ClXDxTCN3VZ3cVQIHIMRCE9CYD1TKgdL
        i5fgR/Sg4GL4pmXeqiLOkprZSi/JfhU=
X-Google-Smtp-Source: AJdET5e1FWQyO+/DdlvL0lkVZRLEi0/zHPcOxXFdO4hx2FA3cPV2+Grk25Cggg58LRX7oi5lTp/KPA==
X-Received: by 2002:a1c:9947:: with SMTP id b68-v6mr4450465wme.22.1541385363992;
        Sun, 04 Nov 2018 18:36:03 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b8-v6sm18346243wrt.49.2018.11.04.18.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 18:36:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: Design of multiple hash support
References: <20181105010032.GN731755@genre.crustytoothpaste.net>
Date:   Mon, 05 Nov 2018 11:36:01 +0900
In-Reply-To: <20181105010032.GN731755@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 5 Nov 2018 01:00:33 +0000")
Message-ID: <xmqqlg68jlny.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I'm currently working on getting Git to support multiple hash algorithms
> in the same binary (SHA-1 and SHA-256).  In order to have a fully
> functional binary, we'll need to have some way of indicating to certain
> commands (such as init and show-index) that they should assume a certain
> hash algorithm.
>
> There are basically two approaches I can take.  The first is to provide
> each command that needs to learn about this with its own --hash
> argument.  So we'd have:
>
>   git init --hash=sha256
>   git show-index --hash=sha256 <some-file
>
> The other alternative is that we provide a global option to git, which
> is parsed by all programs, like so:
>
>   git --hash=sha256 init
>   git --hash=sha256 show-index <some-file

I am assuming that "show-index" above is a typo for something like
"hash-object"?

It is hard to answer the question without knowing what exactly does
"(to) support multiple hash algorithms" mean.  For example, inside
today's repository, what should this command do?

	git --hash=sha256 cat-file commit HEAD

It can work this way:

 - read HEAD, discover that I am on 'master' branch, read refs/heads/master
   to learn the object name in 40-hex, realize that it cannot be
   sha256 and report "corrupt ref".

Or it can work this way:

 - read repository format, realize it is a good old sha1 repository.

 - do the usual thing to get to read_object() to read the commit
   object data for the commit at HEAD, doing all of it in sha1.

 - in the commit object data, locate references to other objects
   that use sha1 name.

 - replace these sha1 references with their sha256 counterparts and
   show the result.

I am guessing that you are doing the former as a good first step, in
which case, as an option that changes/affects the behaviour of git
globally, I think "git --hash=sha256" would make sense, like other
global options like --literal-pathspecs and --no-replace-objects.

Thanks.
