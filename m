Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8DA3201A7
	for <e@80x24.org>; Mon, 15 May 2017 18:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935057AbdEOSIL (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 14:08:11 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:34946 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932721AbdEOSIK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 14:08:10 -0400
Received: by mail-it0-f43.google.com with SMTP id c15so48138926ith.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 11:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4jxFvltrdNrUU9Zn/RMb/lY+42qRaosnIOYmQVRt3VA=;
        b=P0PHwUGpWtw+PLdW2jqQHYM4pTxT1C7D0azhu8L2QejFm+Y9dvMsak/nhacQV6RcbS
         leH32xo/uUmQCua7unU1StAVZgOed3LeKXjU6cOzLKTYfx7FU0aGVltjrktq8Nv8ojmf
         qGgKxSXkNDs+GGmWJGSG85ounARPHaYAxugXBS2h0qagGfEhy3rSXkHAiDDmQyGVeB1L
         xP2ncK+IsEmDdEfvF7Ef8Fw0uFwKLBpxBXyf0miQfpmSWUXDj2uyQXLh8graPnO3B78m
         4CTb1Ws1ceHLzlzWoIdJD7q/GCAFXjs6tJv+eOCcBHtLRXaU6NYTBU5Okjg5+utdD72d
         mCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4jxFvltrdNrUU9Zn/RMb/lY+42qRaosnIOYmQVRt3VA=;
        b=fgLMb2uHUgKZeOUUdSsjBNyfX+7WRiZNqBHA0VryZFFwxHtI5xDfB1YmA9XH/Wgm70
         XCGwovlTZ6VPQK2tW5fK9amU2BJvdcrdcZH3sd2BgBhMGUQy9/nWidQQj8ow191vpW+n
         xrSKFT7Ir89ccrUt8Zv5v3o8g8sqlfAqjgqbDvJ27QuFX0+CiDYydg4u32P1RBdR1U3S
         /6yFD4v4QkinN02WaLGPOlnFIcPyjrhShnuZK8E3cqGNu+gsOP9d70Q0AtHstoHoeTWW
         NCsT41NJ+tuswjfXN3xm8UkdeordTYHXAT4I1mNRBH3CJHAkV3eRPQXnKfarIGxLrXkr
         0RUw==
X-Gm-Message-State: AODbwcAiVThhZ/oPaZKLxECDIwIW9JmVrQwIG6JEoZ0trb6z8klTr2zT
        GWbmCKK9cveEEQxkHZyJzcfRNcUUJg==
X-Received: by 10.36.166.4 with SMTP id q4mr6739683ite.66.1494871689691; Mon,
 15 May 2017 11:08:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 15 May 2017 11:07:49 -0700 (PDT)
In-Reply-To: <xmqqo9uuvdra.fsf@gitster.mtv.corp.google.com>
References: <20170513231509.7834-1-avarab@gmail.com> <20170513231509.7834-22-avarab@gmail.com>
 <xmqqo9uuvdra.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 15 May 2017 20:07:49 +0200
Message-ID: <CACBZZX7DbZh0jYG5SAFvFiOHvowyG=_bdbPbQj7Cr+zw-jOXJg@mail.gmail.com>
Subject: Re: [PATCH v2 21/29] grep: factor test for \0 in grep patterns into a function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 8:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Factor the test for \0 in grep patterns into a function. Since commit
>> 9eceddeec6 ("Use kwset in grep", 2011-08-21) any pattern containing a
>> \0 is considered fixed as regcomp() can't handle it.
>>
>> This limitation was never documented, and other some regular
>> expression engines are capable of compiling a pattern containing a
>> \0. Factoring this out makes a subsequent change which does that
>> smaller.
>
> The latter half of the first sentence of this paragraph does not
> parse well, around "and other some".  "never documented" makes
> readers expect "... so let's document it", but I think you are
> driving in a different direction, something like...

I'll try to reword it.

>         Since some other regular expression engines are capable of a
>         pattern to match a string with NUL in it, it would be nice
>         if we can use such an engine and match against NUL; as this
>         "patterns with NUL always use --fixed match" is not documented,
>         let's hope that nobody depend on that current behaviour.
>         This step does not yet change the behaviour yet, but it
>         makes it easier to do so in later steps.
>
> perhaps?  I tend to agree that it is OK to break users who depended
> on that "patterns with NULL match with --fixed" (partly because it
> is so unintuitive and not useful behaviour, and partly because it is
> easy for them to explicitly say -F), but let's make sure we clearly
> say that we will be knowingly breaking them.

I think there's a few different things going on here, which I'll
address accordingly.

 * Yes, if someone is relying on the undocumented behavior of a \0
pattern implying -F if and when I change that their stuff will break.
I'm going to actually just drop this whole discussion from this
commit, we can have an explanation for that when and if I actually
change it in a later series.

* I'm making things more confusing by saying "engines" here, but it's
important to note that git has never in its docs promised to use the C
library implementation of POSIX regexes, it's just advertised that it
uses POSIX regular *expressions*, which are a different thing.
Implementation !=3D syntax.

E.g. GNU grep uses POSIX regex syntax, but its engine does not have
the same limitation as ours:

    $ (command cd /tmp && printf "=C3=A6\0=C3=B0\n" >a && printf "=C3=A6\n"=
 >> a;
printf "=C3=A6\0[=C3=B6=C3=B0]" >f; grep -a -f f a; echo $?)
    =C3=A6=C3=B0
    0

I went down this particular rabbit hole because I was genuinely
surprised that this didn't work with git-grep, until I realized that
of course the implementation detail of using C strings for this under
the hood was bleeding through.
