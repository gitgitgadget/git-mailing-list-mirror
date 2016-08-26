Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F5BF1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 17:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbcHZRCy (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 13:02:54 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35706 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbcHZRCx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 13:02:53 -0400
Received: by mail-it0-f43.google.com with SMTP id x131so1410098ite.0
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 10:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dUHaFkXZ8cQLIzIPyX5ntoQ6BDp9Tl95RS9tGvskNco=;
        b=ag85MJbp9i9eqltrocfA7hYbnjtnjPKw4lIqMe8Stm6NjL0hqTREYjKP7MOdHsXl8Q
         AdrX8rw2L3kTO+nLYExri+kxRy/sBsWA7H979xoFoL67kalhtdacHil6cXi2T7RXJcSt
         V8NwwPDUMqf7Efxjm4wLeRvhrVG32Y0dZrvsJ04KxivD/0t+Gc8x4ESV8DE/ZmxcNyLY
         6EUW5G5FaHfZcdIYzbe3JgxSwnse69UKYT73inapAzO4BbtO+lt2Yt+mJ1MyUsLHzFRS
         PegVtASZEdDlG7GO/2E48uxTvppuwO1K/6hxPKUeruDITJXJNjDyZ7qSe2p6zaPB1wMx
         YkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dUHaFkXZ8cQLIzIPyX5ntoQ6BDp9Tl95RS9tGvskNco=;
        b=Vh0B+bSaMaTjovuxVP8mp5f4MWKfNo7aDSI1VvHzjwoDWFOaC5Ptxs669+01bHMy13
         aW9AA21yGz6LOfdyZCA+jPBEotAbFPyQ80I2CfBG/iAfO5HUDlHWicmd5OVo/TStkYCT
         //uLIGPPlqQ8tlVcjj75zo5+L3hir0THQ2bX2yxhr/7/eEkbiO8AWlvnlfw4h7U/TAhE
         Msd10cJFwDPx6tIGhxAS44kgG2hQRBSHt8R8C+rj8nWbgNelZZ6HbYLUgabMyMyM9+3J
         +WIxiudz6wiZjMk2fFm0kSqYp15NJczjFhsodWWEgDxwZgPb59DuIljt/evc8VqxIaKG
         D2YQ==
X-Gm-Message-State: AE9vXwN33rIuJlPSJlDchTTwyvVQqbqjJEC4nDHS7CfSiO9GfsYVErLvR2aRmVA52eP1J7pxiVObIFweukwAwdlX
X-Received: by 10.107.178.129 with SMTP id b123mr5391285iof.83.1472230972883;
 Fri, 26 Aug 2016 10:02:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 26 Aug 2016 10:02:52 -0700 (PDT)
In-Reply-To: <CA+P7+xrYM_r+Q_27hWM2FwbreV90AqPgoiH-qPZN0hoPiHpKhQ@mail.gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
 <20160825110752.31581-7-larsxschneider@gmail.com> <CAGZ79kaVg40H-LeDtFfDYqDFDDbr+um3ZYj8oAaqGu+q6k5e+A@mail.gmail.com>
 <xmqqvayojx9e.fsf@gitster.mtv.corp.google.com> <CA+P7+xrYM_r+Q_27hWM2FwbreV90AqPgoiH-qPZN0hoPiHpKhQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 Aug 2016 10:02:52 -0700
Message-ID: <CAGZ79kYD7KSzdhe-60fs5iUKmYcMd6+V3fSN513+sr15q+g39Q@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] pkt-line: add functions to read/write flush
 terminated packet streams
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2016 at 5:55 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Thu, Aug 25, 2016 at 3:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> What is wrong about that?  4*80k = 320kB overhead for length fields
>> to transfer 5GB worth of data?  I do not think it is worth worrying
>> about it.
>>
>> But I am more surprised by seeing that "why not a single huge
>> packet" suggestion immediately after you talked about "without the
>> possibility to intervene".  They do not seem to be remotely related;
>> in fact, they are going into opposite directions.
>>
>> Puzzled.
>
> Stefan's argument to me is thus "If we're already going to ignore
> sideband packets here, why not go all the way and make variable length
> packets and send a single packet of a maximum length? Doing thus will
> solve some set of future problems nicely and makes this code easier."
>
> I'm not sure I agree myself, but that's the logic as I understand it.

Yeah. To me it seems this design explicitly makes it hard for side bands.
As we do not need sidebands for local transfers, this is fine for sure.

(If we wanted to make it sideband friendly, I'd expect you could register
callbacks for either all packets or for a given sideband until the next
flush comes.)

So as hinted by this design, we want a protocol that
* doesn't care about sidebands
* cares about large data (hence maybe throughput)
* has easy/clean interface

And one large packet would suffice for these three points as well
and additionally has benefits for the network stuff.

The 320kB additional transmission are negligible overhead, so I was not
concerned about the size, but rather the code being bloated, i.e. we need
one layer of additional code to cope with the repetitive packets.

---
My background is mostly submodule related, and whenever I come up
with a shiny novel idea that would help submodules tremendously, someone
(mostly Peff) comes along and suggests a broader more generic thing, that
works just as well for submodules but is applicable to all of Git.

So I picked up that way of thinking: If we write code here, that helps with a
very special niche of things, can we make so, that the rest also benefits?

I may not understand all the requirements in this case, but to me it looks like
the "one packet" approach covers all requirements, but has the huge potential
to make other parts better in the long run.
-- 

Thanks,
Stefan
