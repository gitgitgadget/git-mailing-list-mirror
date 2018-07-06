Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9044D1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 17:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933531AbeGFRZC (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 13:25:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39038 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932834AbeGFRZB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 13:25:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so4891369wre.6
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 10:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=0n0zj0GK8m5e9ReIF5+F1tea8ZKfHXxlyrEnlFdex6o=;
        b=nz/S012Hfofo9JNoKhQYunIwHYkQhtYj3Pj6/70KsL5ctH0c0SldjdDQ/p6Au9XA2r
         d14P0SFJqaeGwK1BaOzdlv4UOXF2wtdTJwob8Q8aZHzXEXzTcHkbNnUPbZkYyNblTBQv
         +aRKdt1vIJk9nPHu1PgVFoslCTJTyLR+5Dby1ngaDdscP1vncuJo/dTrRlngSAhln2W2
         mt6RPeQ/uIVldjl7AUENVzPFxgIviSM/QQrLQ9Iu2eBoiK16gO02884agQZ4o+u/HEYh
         SXn3nHj8EClkdotLYIG6CxX6EumLbGzHsSjYh3Bj5CkIzdYLctqtXWid6V4H48LwRcG8
         PRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=0n0zj0GK8m5e9ReIF5+F1tea8ZKfHXxlyrEnlFdex6o=;
        b=n23RGicY8P/dMf7lfxKwhKW8K7I2yo5aCKtipm8MS9kvbsxTKvdiGM0Ikf354Hc6n0
         iU4te1ymNfhINxsU6EzNp6Gf1RiPAa8u1Mb89LaSna4F0zjomi495tb89sIQUaJvVFNH
         IIdQgS82NroyjTGqnLoBjJRZExiCJN9lH34f/GfaUq7ED2OI3Stg5H29r/dGoeZDpJBB
         iddeT4I0l1ShIejQsKrvmTmv5OzyNfMlGOiIpUskikh0lP2b92zVs5W/JNihCZLPgzQe
         ASsVpfKoXY3BE0SsJqJyFDNRd8PRC/8SIcG3+y7FBG9NiFN1mnn/XFxDJ9zX/gtWFIuh
         lVHg==
X-Gm-Message-State: APt69E0Bs+cNhWX0qnJh/12JMM3Ga29q0ZQkSgAp67q6fHBC+amo3xYQ
        YBCPAopwQdMecnc+xsNXWuQ=
X-Google-Smtp-Source: AAOMgpcy3dqPqqoaJcU9ECTq9xI775Do1CvyGO2X4KnBMWEn74JokgrLzDT+95INDl3LJFwhYeiRRw==
X-Received: by 2002:adf:e642:: with SMTP id b2-v6mr9180304wrn.254.1530897900175;
        Fri, 06 Jul 2018 10:25:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o8-v6sm15936619wro.68.2018.07.06.10.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 10:24:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Henning Schild <henning.schild@siemens.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/8] gpg-interface: introduce an abstraction for multiple gpg formats
References: <cover.1530616446.git.henning.schild@siemens.com>
        <db46732d1cd09a71200e00c2d09605d5beaff364.1530616446.git.henning.schild@siemens.com>
        <CAN0heSrXpLCDRjnZC80QXBG27gd6m5reBn1hfNd_KXxnPVkA2g@mail.gmail.com>
Date:   Fri, 06 Jul 2018 10:24:58 -0700
In-Reply-To: <CAN0heSrXpLCDRjnZC80QXBG27gd6m5reBn1hfNd_KXxnPVkA2g@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 4 Jul 2018 09:10:17
 +0200")
Message-ID: <xmqqa7r4mg45.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

>> +enum gpgformats { PGP_FMT };
>> +struct gpg_format_data gpg_formats[] = {
>> +       { .format = "PGP", .program = "gpg",
>> +         .extra_args_verify = { "--keyid-format=long", },
>> +         .sigs = { PGP_SIGNATURE, PGP_MESSAGE, },
>> +       },
>> +};
>
> I think those trailing commas are ok now, but I'm not sure...
>
> I had the same thought about designated initializers. Those should be ok
> now, c.f. cbc0f81d96 (strbuf: use designated initializers in STRBUF_INIT,
> 2017-07-10) and a73b3680c4 (Add and use generic name->id mapping code
> for color slot parsing, 2018-05-26).

As you said, we dipped our toes in designated initializers in both
struct and array, i.e. { .field = init }, { [offset] = init } last
summer and we haven't got complaints from minor platforms so far.

The "comma" thing you are wondering is something else.  The comma we
see above is after the last element in an array's initializer (and
the last element in a struct's initializer), which we have been
happily using from very early days (and they are kosher ANSI C).

What we've been avoiding was the comma after the last element in the
enum (in other words, if PGP_FMT had ',' after it in the above
quoted addition, that would have been violation of that rule), as
having such a trailing comma used to be ANSI C violation as well.  I
do not recall offhand if we loosened that deliberately.

4b05548f ("enums: omit trailing comma for portability", 2010-05-14),
c9b6782a ("enums: omit trailing comma for portability", 2011-03-16)
