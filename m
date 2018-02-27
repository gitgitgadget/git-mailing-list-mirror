Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 176FA1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 06:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeB0GM7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 01:12:59 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:36282 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbeB0GM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 01:12:58 -0500
Received: by mail-io0-f194.google.com with SMTP id e30so9440723ioc.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 22:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jGH74LF1hyuu5txLe+VWJL6aF14ky3hLbCGJg7X/Nrk=;
        b=oMKbCQ1BVXOTLuDYXaANXuJ2LkkIQZe7Ux8AmOPUfLuCHX2DoYlgIDSlq/zRgdWrkb
         H8hh+uhG8ubgeuvI+mPN+us72E1YCeyZxT2/3ynnnynl8pTQi1eI6bSqR6clkgPcijCm
         MvgCEtAC3Z/b64qa9BRncZ8FypJ8sFUYxNnI/XoRq0plu77IJiMexTGNT0z9cOqEJgYO
         fO9eD1+96b93LmeArX0GrDramwMKtKgkHIfpgI4jju1NZh/nZ44w3GaeRw1q8HFbnt59
         fLbrYGQ1ARdwgKxradRR9CPxI3HSECQ01aBIexEDi2xkbAZG6PKfrFpfYmWv9DrarOH3
         3OUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jGH74LF1hyuu5txLe+VWJL6aF14ky3hLbCGJg7X/Nrk=;
        b=hGsq3OB7ID8bKhUAyp7lzjMW0N0J6hoZDpM3ftaVIuH72gCfTRnaPU89Jy3rS4AGNr
         nsrckML2jWgzdysGCKleAKml34gLXTDhiREWM4jlKKQeib01PMuS758LN16jFEHcQxU8
         f8ygFak+G85t+/pULN/m8xhfLydvtJVQEfIJGxsnDT+qDqFrHKd47pwWueRf16vKHhvu
         T17pqPU2JRGqwDAtYNXEbbaxPOcAqlISawScQna6/veFbxqbp8kW5GBmmd2jYDwb33Mq
         pipgtOSKWTDMn1eEP/XM1TnKgDnlV95wtn46itnmSTXJCzmM7Di9ACey+T7RD05tEwp3
         P1qA==
X-Gm-Message-State: APf1xPCsctolKSOBpxOv5EwGZjpafuhn6SaTnZu5+URlNwXiBOw3cKhY
        yt1gyaXx7hYHDHy8cLgLfoE=
X-Google-Smtp-Source: AG47ELsRiocC/a6AKNaoScTBAdx1kkj9AyHP07gnZTF4yRZV3OC6UiN5XIHjmlaD3EhCXlWABYK2UA==
X-Received: by 10.107.130.74 with SMTP id e71mr14595717iod.245.1519711977490;
        Mon, 26 Feb 2018 22:12:57 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id t7sm4574168itt.6.2018.02.26.22.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 22:12:56 -0800 (PST)
Date:   Mon, 26 Feb 2018 22:12:54 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 02/35] pkt-line: introduce struct packet_reader
Message-ID: <20180227061254.GE65699@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-3-bmwill@google.com>
 <20180227055746.GC65699@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227055746.GC65699@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Brandon Williams wrote:

>> Sometimes it is advantageous to be able to peek the next packet line
>> without consuming it (e.g. to be able to determine the protocol version
>> a server is speaking).  In order to do that introduce 'struct
>> packet_reader' which is an abstraction around the normal packet reading
>> logic.  This enables a caller to be able to peek a single line at a time
>> using 'packet_reader_peek()' and having a caller consume a line by
>> calling 'packet_reader_read()'.
>>
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>> ---
>>  pkt-line.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  pkt-line.h | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 117 insertions(+)
>
> I like it!
>
> The questions and nits from
> https://public-inbox.org/git/20180213004937.GB42272@aiede.svl.corp.google.com/
> still apply.  In particular, the ownership of the buffers inside the
> 'struct packet_reader' is still unclear; could the packet_reader create
> its own (strbuf) buffers so that the contract around them (who is allowed
> to write to them; who is responsible for freeing them) is more obvious?

Just to be clear: I sent that review after you sent this patch, so
there should not have been any reason for me to expect the q's and
nits to magically not apply. ;-)
