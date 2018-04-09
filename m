Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 768171F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeDIWG7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:06:59 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38786 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDIWG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:06:58 -0400
Received: by mail-wm0-f51.google.com with SMTP id i3so19503318wmf.3
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=LaehdqQ+1JXQ2da/ES/nye1poxXih47j/rUAZmN4Mgo=;
        b=pwGipYmgwxAG6WLZ5EGh7svTM9ri5Lh+UtWdcmvai0WAAHifZvY/ng6Ris/5lJkiJV
         t6pWa1hx3tT/YY6hKUNjKzZqj0kj0TJl5g3BTs7ZspYCarz63RnvNYq22n51Uq7vslRx
         1uN6iggkLnRV/l5CX25gj0zL7tmxfYz/FTmMII9tv/iCah54k/0e4ASvXGU19eIvQ8u1
         pZyYNthZzIq2dOmJNdqIseS+8Gg8m+212sNXyp5QztzKyuen7LBYejflR4/Cy605uEEP
         mmESxuYNfRpZUEg7+fgYQGu+0QWKr8BDfSThJkK0QipZnYuupaJG4y2DQKDH5q4I0ask
         NImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=LaehdqQ+1JXQ2da/ES/nye1poxXih47j/rUAZmN4Mgo=;
        b=i8paZPiQ6h46JkiiWtkgtkjsLv/IeDkK5Dv2TUh7FvOM3np4yMKWHy5m71Z48K3NwL
         pd7wAbtA+WcLJ4uQ63/vr3PPV0a+shUEauuhricyQmr9q9eX9jNgcVaSTI9weSdDXXpK
         qOmXYsW8UjX5QvnJuJ4lhROLAZoKOqPzMRH1ka6Ik7S53YJ/pHnRf7xQ4w/UY7LaAw/z
         EW6M1n1VwVAAIKQgOxAl/2zfHfa3hJjnhvBlLPlLq6gnZuXxKHoxYwcqTtINJ3okms3E
         8BupeI16pSItatE7RY9ONksIWHEyNuixeC+ku3wLW4HMzU56YJmQLaQ5cqCaOgTcactK
         034g==
X-Gm-Message-State: ALQs6tCc5/d96KlaNqQ3jhy1m2JfIzG2Kfnl58T7FfyYtS2FueygosCR
        zwKr20HemRCmeQjO5yuCkbs=
X-Google-Smtp-Source: AIpwx48LeHEDTiu/KY/kWDNZnFQdK5XEhaY9AKK5fFygciHOSd58ccdtyATd3gm2b3cJw5wK0RllGg==
X-Received: by 10.28.5.10 with SMTP id 10mr1028719wmf.47.1523311617124;
        Mon, 09 Apr 2018 15:06:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i141sm517684wmd.6.2018.04.09.15.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 15:06:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Florian =?utf-8?Q?Gamb=C3=B6ck?= <mail@floga.de>
Cc:     git@vger.kernel.org,
        Szeder =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [RFC PATCH 1/1] completion: load completion file for external subcommand
References: <20180409133627.GA25078@arbeitsviech>
Date:   Tue, 10 Apr 2018 07:06:56 +0900
In-Reply-To: <20180409133627.GA25078@arbeitsviech> ("Florian =?utf-8?Q?Gam?=
 =?utf-8?Q?b=C3=B6ck=22's?=
        message of "Mon, 9 Apr 2018 15:36:27 +0200")
Message-ID: <xmqq8t9w591b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Florian Gamböck <mail@floga.de> writes:

> On 2018-04-09 18:36, Junio C Hamano wrote:
>> Florian Gamböck <mail@floga.de> writes:
>>
>> > Good point. I could go even further and ditch the if-construct:
>> >
>> >    ! declare -f $completion_func && declare -f __load_completion &&
>> >        __load_completion "git-$command"
>>
>> I personally find that a lot harder to read than if/then/fi.
> ...
> Does my reasoning make sense?

Not at all.  But ...

> I mean, the result will be exactly the same, we are clearly only
> talking about readability here.

... I agree, and I also think the "readability" is not absolute
anyway.

FWIW, personally I'd find "if $completion_func does not yet exist
and a way to dynload stuff exists, then use that way to load it from
an external file" the most natural way to express what you are
doing.

