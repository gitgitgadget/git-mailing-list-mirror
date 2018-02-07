Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5640B1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 18:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754002AbeBGSMZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 13:12:25 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37675 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753390AbeBGSMY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 13:12:24 -0500
Received: by mail-wm0-f66.google.com with SMTP id v71so5098974wmv.2
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 10:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pRFs24lqPlmPdE34XoDbpo/YJ2ty5XMcY/U6vQ7ERc8=;
        b=uFmcOPs0CnxhPDtv7L6OsPI4cTdQ1TcUliJlvOAtIQhBZ8bwAmGQwfZzSWO+BYYyq1
         xRt7/6+9toEFCqGaJJBYux/xpBV60lSYPuUE/gxBNWeEpzr/Pnsd5rX+vb3S/Sft/Mrr
         AjVrqcoQPUBChEG+NGUcoE4w7eZjFALQ6NVy6XL7QMP2TsD3ZbhWnUyo+Dv39WdKZi06
         5EhT/H0xXbbNaO6TWknvJxAq2pPLy+oRb6/wpaKkrW0Ey+jzagsmuvwUPuzAkk+hhJ1r
         IzV81VdQF2K3FATCLyC78JJ2eq8IavFnOXs2fWPX3k+Xxal5qb/7jPwByCO4o0Ap9W2j
         M+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=pRFs24lqPlmPdE34XoDbpo/YJ2ty5XMcY/U6vQ7ERc8=;
        b=TCBcyedIrjtFx0qNMWXFr+CHRwOsW0O8SR3gCWqf8gqG5m3sAoyJsnOJxHlxTyiXx2
         6BYQwySpBxxBdVVBIVOZCaG33S0wTIYpYvyP9us7XvDwaTlzt3WHug3G56ab8NKJcNES
         L8fjl7WdvqMndvX8spbHwatd90nm4HfnDw2o5ThDNoYXv2KyJrF3S+/0yJXTNXhQw3v5
         nQD0vE2v1iBgxlhhP4qa8dYzgrLoKU5xB0Tm4dcw2qouo/XnMd47kFvyJzPKHjAtInc1
         WmbbCaiOK3PeNE45JvZvsyBfIqtiTgKYtw+mqf82IvLn7bfdAutYt6pQmJL3czA+mx7k
         BJtA==
X-Gm-Message-State: APf1xPCNmBTgpi3rpjDiJHlp41Ite+Fj4ZEJ4UQ1UDIcgeZT8ocvMj0F
        SB4rV4AP+QG/xrc5zb0zY00=
X-Google-Smtp-Source: AH8x225Z8Odbe8mzTpm2RRGHq3Fmkf2O3SIITnVvvK+Pjrl4cFbefgfQh+bZrXwVvs9SGp5qgoXd9A==
X-Received: by 10.28.173.130 with SMTP id w124mr4988409wme.18.1518027142457;
        Wed, 07 Feb 2018 10:12:22 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w14sm1950738wmf.32.2018.02.07.10.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 10:12:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH/RFC v5 7/7] Careful with CRLF when using e.g. UTF-16 for working-tree-encoding
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
        <20180129201911.9484-1-tboegi@web.de>
        <55B6C3D5-4131-4636-AD0E-20759EDBE8CD@gmail.com>
        <20180130144002.GA30211@tor.lan>
        <10091BA4-1069-4A65-9057-CAAD87F9B55F@gmail.com>
        <20180131172837.GA32723@tor.lan>
        <xmqqtvuzcibz.fsf@gitster-ct.c.googlers.com>
        <20180207063147.GA22714@tor.lan>
Date:   Wed, 07 Feb 2018 10:12:20 -0800
In-Reply-To: <20180207063147.GA22714@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Wed, 7 Feb 2018 07:31:47 +0100")
Message-ID: <xmqq372c8y9n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

>> the user explicitly tells us it is in UTF-16, right?  Is there such a
>> thing as UTF-16 binary?
>
> I don't think so, by definiton UTF-16 is ment to be text.
> (this means that git ls-files --eol needs some update, I can have a look)
>
> Do we agree that UTF-16 is text ?
> If yes, could Git assume that the "text" attribute is set when
> working-tree-encoding is set ?

These are two different questions.  It seems that between the two of
us, we established that "UTF-16 binary" is a nonsense, and a path
that is given working-tree-encoding=UTF-16 must be treated as
holding a text file.  But that does not have direct relevance to the
other question you are asking: "is a question 'does this path have
text attribute set?' be answered with 'yes' if the path has wte
attribute set to UTF-16?"  I think the answer to that latter
question ought to be "no".

By the way, a related tangent is if it makes sense to give
working-tree-encoding to anything that is binary, regardless of the
value---I am inclined to say it is not, so the issue here is not "by
definition UTF-16 is text", but "any path that has wte set to some
enconding should be treated the same way as if the path also has
text attribute set as far as convert machinery is concerned.".

