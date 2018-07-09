Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 503481F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 08:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754388AbeGIIWC convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 9 Jul 2018 04:22:02 -0400
Received: from goliath.siemens.de ([192.35.17.28]:43637 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeGIIWB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 04:22:01 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id w698LeqU026428
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jul 2018 10:21:41 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w698Ledv022021;
        Mon, 9 Jul 2018 10:21:40 +0200
Date:   Mon, 9 Jul 2018 10:21:39 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/8] gpg-interface: introduce an abstraction for
 multiple gpg formats
Message-ID: <20180709102139.274f0560@md1pvb1c.ad001.siemens.net>
In-Reply-To: <xmqqa7r4mg45.fsf@gitster-ct.c.googlers.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
        <db46732d1cd09a71200e00c2d09605d5beaff364.1530616446.git.henning.schild@siemens.com>
        <CAN0heSrXpLCDRjnZC80QXBG27gd6m5reBn1hfNd_KXxnPVkA2g@mail.gmail.com>
        <xmqqa7r4mg45.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Fri, 6 Jul 2018 10:24:58 -0700
schrieb Junio C Hamano <gitster@pobox.com>:

> Martin Ågren <martin.agren@gmail.com> writes:
> 
> >> +enum gpgformats { PGP_FMT };
> >> +struct gpg_format_data gpg_formats[] = {
> >> +       { .format = "PGP", .program = "gpg",
> >> +         .extra_args_verify = { "--keyid-format=long", },
> >> +         .sigs = { PGP_SIGNATURE, PGP_MESSAGE, },
> >> +       },
> >> +};  
> >
> > I think those trailing commas are ok now, but I'm not sure...
> >
> > I had the same thought about designated initializers. Those should
> > be ok now, c.f. cbc0f81d96 (strbuf: use designated initializers in
> > STRBUF_INIT, 2017-07-10) and a73b3680c4 (Add and use generic
> > name->id mapping code for color slot parsing, 2018-05-26).  
> 
> As you said, we dipped our toes in designated initializers in both
> struct and array, i.e. { .field = init }, { [offset] = init } last
> summer and we haven't got complaints from minor platforms so far.
> 
> The "comma" thing you are wondering is something else.  The comma we
> see above is after the last element in an array's initializer (and
> the last element in a struct's initializer), which we have been
> happily using from very early days (and they are kosher ANSI C).
> 
> What we've been avoiding was the comma after the last element in the
> enum (in other words, if PGP_FMT had ',' after it in the above
> quoted addition, that would have been violation of that rule), as
> having such a trailing comma used to be ANSI C violation as well.  I
> do not recall offhand if we loosened that deliberately.
> 
> 4b05548f ("enums: omit trailing comma for portability", 2010-05-14),
> c9b6782a ("enums: omit trailing comma for portability", 2011-03-16)

I guess that means the style is acceptable and does not require
changes, please correct me if i am wrong.

Henning
