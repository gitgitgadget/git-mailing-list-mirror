Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8AC71F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 15:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932947AbeGIPrM (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 11:47:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34930 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932688AbeGIPrL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 11:47:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id v3-v6so17667851wmh.0
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=HGR4O7BKEzotBYUuenYI7k5zsWOfuurde+7VK+pvDR4=;
        b=G2TzCxq/1IabEZyDgZvRmw1AXtaPN+F2JOHsykgeXDikU2R+GQdp0dqbRD8c9edDXr
         LOvmjD+sPc6FeVTns3kZbZc76QxHDMNCCOzvii5F9kouYEtwoKFYmU+4/nXlkAtjgpTH
         AR0j7yzkl6hkqBTLzM7iAMys5UENOCvsdAR0iBOsWLSS2URFe10FH4z8qfjUs1G1LSva
         5ACJKFPbZ+8sauwmfrslzpu1WnHOTSBM0k846Ghv/swEdcEOE7BKeixI/Q0mVrlV7AoW
         uKdXoBPgLrsrs4DVkkxXJ1vF1pbkA8BCgEKm1uQLmF1dmzI5W5p7QNoB5gTSghVe2ou7
         /dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=HGR4O7BKEzotBYUuenYI7k5zsWOfuurde+7VK+pvDR4=;
        b=fzZX7aPPCgeCPjzX6mdbtHb8iWsqL7DZahDrx+havXfnaizhsyBmmmTXKsKNbB9Wkq
         DcCgDn1mTeDpBaK9yRWHCRuGWff7rag+AilJEoqWDs+dVnmOZGqZxlNbhrnD7tHZ2wTR
         4pUlj+Ja87xLybV4X7pcsv8v6Oy2+fBaCMuo36IUpuOkaoSihlskNj3OdEUCPuPP1JjC
         KYnFL4IzpPiflwcxDPKRxriWjcgt8FThbritvQlI20zeVues+yp1poqRh20dQNQUrb8Y
         FRYPDwnX4RV6ZLxM+WKqP4V5draFjoDewbOSC0EbTUUMtLDGTaZTyllU5C5Pir9pJjAI
         7AHQ==
X-Gm-Message-State: APt69E1tgjTbelEl9Fib276pEsNNjXPJGkkRVgjUJiqfpFMwfEtsXmdL
        OHIgI4M5b8A0P8Jknvj+HHY=
X-Google-Smtp-Source: AAOMgpe7dlyQnfAevwzSEg8YaZFMSiykNlyZHOuA2LWal2hLLhoZ6lyYdrVLdfPzei2HpUSE9WiZZA==
X-Received: by 2002:a1c:790b:: with SMTP id l11-v6mr9071644wme.66.1531151229932;
        Mon, 09 Jul 2018 08:47:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g17-v6sm625980wmd.25.2018.07.09.08.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:47:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     henning.schild@siemens.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git List <git@vger.kernel.org>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 4/8] gpg-interface: introduce an abstraction for multiple gpg formats
References: <cover.1530616446.git.henning.schild@siemens.com>
        <db46732d1cd09a71200e00c2d09605d5beaff364.1530616446.git.henning.schild@siemens.com>
        <CAN0heSrXpLCDRjnZC80QXBG27gd6m5reBn1hfNd_KXxnPVkA2g@mail.gmail.com>
        <xmqqa7r4mg45.fsf@gitster-ct.c.googlers.com>
        <20180709102139.274f0560@md1pvb1c.ad001.siemens.net>
        <CAPig+cQyXC2o4fUARL_kqPn5+6adBpr+WUfAWWgu2QLjDn1eoQ@mail.gmail.com>
Date:   Mon, 09 Jul 2018 08:47:08 -0700
In-Reply-To: <CAPig+cQyXC2o4fUARL_kqPn5+6adBpr+WUfAWWgu2QLjDn1eoQ@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 9 Jul 2018 04:44:01 -0400")
Message-ID: <xmqqy3ekfm2r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Jul 9, 2018 at 4:22 AM Henning Schild
> <henning.schild@siemens.com> wrote:
>> Am Fri, 6 Jul 2018 10:24:58 -0700
>> schrieb Junio C Hamano <gitster@pobox.com>:
>> > Martin Ågren <martin.agren@gmail.com> writes:
>> > >> +struct gpg_format_data gpg_formats[] = {
>> > >> +       { .format = "PGP", .program = "gpg",
>> > >> +         .extra_args_verify = { "--keyid-format=long", },
>> > >> +         .sigs = { PGP_SIGNATURE, PGP_MESSAGE, },
>> > >> +       },
>> > >> +};
>> > >
>> > > I think those trailing commas are ok now, but I'm not sure...
>> >
>> > What we've been avoiding was the comma after the last element in the
>> > enum (in other words, if PGP_FMT had ',' after it in the above
>> > quoted addition, that would have been violation of that rule), as
>> > having such a trailing comma used to be ANSI C violation as well.
>>
>> I guess that means the style is acceptable and does not require
>> changes, please correct me if i am wrong.
>
> The trailing comma in the 'sigs' initializer is bothersome because
> 'sigs' is declared as a 2-element array, and this initializer already
> has two elements. Therefore, the comma is misleading to anyone reading
> the code, making it appears as if additional items can be added. For
> that reason, alone, it would be nice to see the unnecessary comma
> removed.
>
> Ditto with regard to the trailing comma in the 'extra_args_verify'
> initializer since 'extra_args_verify' is declared as a 1-element
> array.

I am not sure I agree with that reasoning.  The primary benefit we
gain from the convention to allow trailing comma in struct/array
initializers like these is that we can add a new field with a patch
like this:

	 struct {
	 	char *foo;
	 	char *bar;
	+	char *baz;
	 } xyzzy = {
	 	"foo",
	 	"bar",
	+	"baz",
	 };

without having to touch the initialization of the field that used to
be at the end, i.e. .bar="bar", and just can add the new stuff at
the end.  But that is only possible as long as we allow the trailing
comma after the last element.  The same argument applies to an array
initialization (i.e. when we need to allow more elements to the
.extra_args_to_verify[] array).

All of the above is somewhat moot for the other reason I already
stated in the thread, though.  And that may be a good reason why we
would want to lose these trailing commas from the last elements
(i.e.  if it does not prepare the current code to avoid having to
touch the last line when we add a new element at the end, then
trailing comma is a visual hiccup that does not serve any useful
purpose).



