Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AAB6202BB
	for <e@80x24.org>; Thu,  4 Apr 2019 09:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfDDJlY (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 05:41:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36363 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730405AbfDDJlX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 05:41:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so2556239wml.1
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 02:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xrVo8VodvYdYTgyimnAKO4yyd6JdHgNo73M6qibMu4Y=;
        b=VzMS3Kz7hntO1t+/J/hiJFxMb3w3NpHWd2gOVPGFH4nQz2ki2xhanwmjKx+hzuupW0
         JBci2zMLG49tPiqHyxIXecORKL1FjZnT5YepHHFiyj94NQrqqPBy9QAGUCMQC+OdeYHu
         /731jwlGnEoL+HS6c0BeuZVJPMjh8bMicvUXtvM9z/gNvwvUQAld+u0BG5tLrnsZSrXm
         c6GPykvZphtLuMZ6LagKHGXiCy+WN7xNHyPBBI5wRJEOvcNe3TUz9Rk3EehFa3YEo81V
         zUqjdhFucjb8YMO9aBao2lVSCuOE4mOId1GOBeDqwu8CZ+pxM4ffdy03XWtaRUjeHFJA
         wPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xrVo8VodvYdYTgyimnAKO4yyd6JdHgNo73M6qibMu4Y=;
        b=clIPRTmp1cfgRUw80bj33LqdP302ya/iPoXtDyOQH0CLvfW551VgCS1SZDupoz8BtV
         HbHu8ZuFhEB5OObuqHeFujgsbRk+PiSYh3ZBNs8Zz8oNrT3b5Iacxy9nQfR9WLQC70ln
         tWjE49+2YZ813/uS/oJo39cXJoPZXwP7I3WpIatHFd28/SDo1dya3ojW7ciS70E9c4EL
         Y+WiNm7GUjeP0KaNGcgbyWup0QJKRGQcvLvHMjksqVQaph8i4ej5CB9IZzp5Tg9/bT8s
         GZwskiihl9WZLORcSbTbCZFSBi2qBLp+rYoZ/1kOdze1BsXGzWjGNOC50fqq91obIl2g
         /Muw==
X-Gm-Message-State: APjAAAU9xdeS9ljoqbx47QRR3hv8aWG0GKCL0mEU3j5KWCfnBnWknqnF
        wbzBZ5stRHOwsYJ/JAuIeJE=
X-Google-Smtp-Source: APXvYqxmTdc6eTsE7RoAkMzRK/qxKipp2DhrbLsXqRzQ485I2OqHmMxNoLyf1/1BSzERy3sNpUPDzQ==
X-Received: by 2002:a05:600c:219:: with SMTP id 25mr3416012wmi.7.1554370881271;
        Thu, 04 Apr 2019 02:41:21 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id k9sm25500071wru.55.2019.04.04.02.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 02:41:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Joe Perches <joe@perches.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org
Subject: Re: [PATCH] send-email: don't cc *-by lines with '-' prefix
References: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il>
        <bc20070b-437a-9875-efd0-b4cad1413233@rasmusvillemoes.dk>
        <604795fe60991f22273cbb652eeeedc17985bc65.camel@perches.com>
        <xmqqh8c03dcz.fsf@gitster-ct.c.googlers.com> <874l7ekynt.fsf@tarshish>
        <xmqqk1gaf7oe.fsf@gitster-ct.c.googlers.com> <87zhp6jf2o.fsf@tarshish>
Date:   Thu, 04 Apr 2019 18:41:20 +0900
In-Reply-To: <87zhp6jf2o.fsf@tarshish> (Baruch Siach's message of "Thu, 04 Apr
        2019 12:27:11 +0300")
Message-ID: <xmqq7ecaf6pr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Baruch Siach <baruch@tkos.co.il> writes:

> Hi Junio,
>
> On Thu, Apr 04 2019, Junio C. Hamano wrote:
>> Baruch Siach <baruch@tkos.co.il> writes:
>>
>>>> Independently, I think it makes sense to do something like
>>>>
>>>> 	/^([a-z][a-z-]*-by|Cc): (.*)/i
>>>>
>>>> to tighten the match to exclude a non-trailer; that would have been
>>>> sufficient for the original case that triggered this thread.
>>>
>>> Is there anything I need to do more to get this fix applied for the next
>>> git release?
>>
>> Get "this" fix applied?  I think we should tighten the regexp to
>> exclude a non-trailer, which would have been sufficient for the
>> original case without anything else in "this" fix.  So in short, I
>> do not think "this" fix won't be applied without further tweaking
>> ;-)
>
> This is exactly what "this" patch (referenced in the title of "this"
> thread) is doing:
>
>   https://public-inbox.org/git/eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il/
>
> Am I missing something?

That is totally outside of the in-reply-to/references trail of your
ping message, and what I saw in the message you were quoting in your
'ping' was

>>  		$message .=  $_;
>> -		if (/^([a-z-]*-by|Cc): (.*)/i) {
>> +		if (!$in_patch && /^([a-z-]*-by|Cc): (.*)/i) {
>>  			chomp;

which is a lot looser than the suggested "the beginning must be
alpha" pattern.

