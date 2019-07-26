Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C27C81F462
	for <e@80x24.org>; Fri, 26 Jul 2019 19:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfGZTkI (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 15:40:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33123 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfGZTkI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 15:40:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id i11so54208325edq.0
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 12:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=UxUgDqhUZAQs4FAJgb2WY39JxL+byK4Mh90Ev/TuhNE=;
        b=LFM/ShJqZ75Z0Y84++H/VzTs7TiWZbWGI6uzsREmes4lSMvMFsySBG2c3r1HnDM5uc
         K+LKVXqzpVVhWtdQABTR03EuuXzwR5hwNTkNcOu4XzOJVCK+RZqFE31Tyc5vJ8IB6+oX
         k6Qr6/3rrAoRploLNAaHowCL8fk6Ouh+ZpV7GYOghP2oG0XRKs1RnAGgOBQEyEpqmUde
         tw8NOAx+NkxToTiD57AXF5M6YKIZNoN+hhGNaIdMj7YmN6VJEl4wbMiNWcIlUg8bSVdm
         ppHJv2XjJ8yL7cZFKvp4KgDYEgietu/dmrZZIOJPRzL9R4H+hZKihwdAO2lXVvDSaUfV
         QxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=UxUgDqhUZAQs4FAJgb2WY39JxL+byK4Mh90Ev/TuhNE=;
        b=eKH+pXmQIgh2sKguxpjWs2fhpND6h6HfLvhhq2WggVhTxGQ/xHJNOdFSpCkHKz4g9p
         ADNNT+x6io2EhKWQcoVHj2eFA8wUpOCu48SfkAObLlAAHCzNxMAm0RwlGqpwIdN0H0N3
         /xDWhrNFMJTkvX7Ab+pt4VYWDeQQCFUGo98fnFsZaTMeSIehSkVNAt4dxRzE6IXmXxQg
         /u/yFSutNOCPhjRR97HGEi7a/cQUscEQtcW8Zg0prQFxVph9Tjt+h/OS7HBiDGokubw3
         1Pf5xu6qaYamYBaMFgz6pkP89WaOdtkzMvaN0gUXiaTeYtMgnJMouNuqmTNkwOss3J9w
         5AfQ==
X-Gm-Message-State: APjAAAUZrJKfzU9qaUA9z1cDe/tXoRtht0I+0VhjwJOkn7c3+Zu3uht5
        e+KzqWSrE9Og+ar/e+jE9v6vEntqgws=
X-Google-Smtp-Source: APXvYqwciyIDXz5KgoekoY0eNc5bH8n8eU8tbgH4Z7iYxz6mugfOqh0Hq+lhtTB9ZW5DZpsJSQS09A==
X-Received: by 2002:a17:906:b203:: with SMTP id p3mr74036453ejz.223.1564170005622;
        Fri, 26 Jul 2019 12:40:05 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id si13sm10302686ejb.82.2019.07.26.12.40.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 12:40:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: skip UTF8 checks explicitally
References: <20190721183115.14985-1-carenas@gmail.com> <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet> <87muh57t5r.fsf@evledraar.gmail.com> <CAPUEspg1nUoPApTk5J2r_-9psxTTSC7nRAPw_X9no+2sFVSxAA@mail.gmail.com> <nycvar.QRO.7.76.6.1907231444250.47@tvgsbejvaqbjf.bet> <CAPUEspgytjywYHywGT4yAwYpQbMUicN4bpHfoD+M_HMe8YdPtg@mail.gmail.com> <nycvar.QRO.7.76.6.1907241245540.21907@tvgsbejvaqbjf.bet> <87lfwn70nb.fsf@evledraar.gmail.com> <xmqqpnlzqh3d.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907251143430.21907@tvgsbejvaqbjf.bet> <xmqqlfwmqnb5.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907252021230.21907@tvgsbejvaqbjf.bet> <87ef2c7roy.fsf@evledraar.gmail.com> <xmqqy30kojj1.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqy30kojj1.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 26 Jul 2019 21:40:04 +0200
Message-ID: <87d0hw7ffv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 26 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> FWIW what I meant was not that we'd run around and iconv() things, it
>> wouldn't make much sense to e.g. iconv() some PNG data to be "UTF-8
>> valid", which presumably would be the end result of something like that.
>>
>> Rather that this model of assuming that a UTF-8 pattern means we can
>> consider everything in the repo UTF-8 in git-grep doesn't make sense. My
>> kwset patches *revealed* that problem in a painful way, but it was there
>> already.
>
> We already do assume that pathnames are UTF-8 (pathspecs on MacOS
> are converted and then they are matched assuming that property).
> Further, with the same mechanism, I think there is an assumption
> that anything that comes from the command line is UTF-8 (and if I
> recall correctly, doesn't the Windows port of Git force us to use
> the same assumption---I recall we needed tests tweak for that).
>
> In the very very longer term, I do not think we would want to keep
> the assumption that the text encoding of blobs is always UTF-8, and
> it would be nice to extend the system, so that blob data could be
> marked in some way to say "I'm in Big-5, and not in UTF-8, so please
> treat me as such" and magically the needle and the haystack can be
> made to agree, with iconv() either one of them.
>
> But I do not think the current topic to fix the immediate/imminent
> breakage should not be distracted by that.  Let's keep assuming that
> any blob, when it is text, is UTF-8.
>
> And from that point of view, I think the two pieces of idea in your
> earlier message does make sense.  We can try to match as binary most
> of the time, as UTF-8 would not let a valid UTF-8 needle match in
> the haystack starting in the middle of a character.

*nod*

> When the user is trying to match case-insensitively, we know the
> haystack in which the user is interested in finding the needle is
> text, even though there may be non-text blobs as well.
>
> For example, "git grep -i 'foo' t/" may find a few png files under
> the t/ directory.  We do not care if they happen to contain Foo and
> we do not mind if they appear or do not appear in the result.  The
> only two things we care about are (1) foo, Foo, FOO are found in the
> text files under t/ and (2) the command does not die in the middle,
> before processing all the files, only because a png file it found
> were not UTF-8 valid.

I think this part's a step too far, and not how e.g. GNU grep
works. Peeking into binary data in a text grep is what people expect,
e.g. because you might want to recursively grep mixed text/mp3s for an
author. The text part of the mp3s means that metadata will be grepped
for inside the binary files.

Getting that right is hard around the edges though...
