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
	by dcvr.yhbt.net (Postfix) with ESMTP id E0CEB1F97E
	for <e@80x24.org>; Fri, 26 Jul 2019 14:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbfGZOnL (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 10:43:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44030 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387471AbfGZOnK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 10:43:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id e3so53515234edr.10
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 07:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=k3jjyrngkjz2K5zbvnAY9c37hKgIExhmW75ABri0+sY=;
        b=sRvQTDlAx+TLiYivpW9a5miHG4+tmW1b9xlfzFh3iXTndHkD/RUPpL2AiNqjyv7uAf
         p4QIE4NjlkDOhdiEoPxPrSapT8z+6Bmt6wCmJh6qRNVUcoFSQQnbpgcb+Vpa/jnTXeyo
         cFtku9pyPGl4F85wdU7RQm7SHlRNjphTxFIpsw3k2XsLinM5PQLP6Doyyw5KG/nxRU8r
         6ry83WfR2k2FFlpsz3M2I3hP1wnkGu/kDqB5Nhs0UMs6mKv/5o/cs7Ulkx7UotNIDMlw
         vGRJv+h60qWUcAfgYB8pNceGWvU14QyjiIjxg/RzXaAdF1+VZQAb4aZvYFdiQ5AcQMh6
         6qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=k3jjyrngkjz2K5zbvnAY9c37hKgIExhmW75ABri0+sY=;
        b=r/xI7L+EJSQOX7TFOs2pgWmyEwYk7ubu7EpA2Xgsh9QRHvrYlF2yP7rluyE5qUWP6t
         1SIMQvrmz+fFcw4E4GMMfV+MNLmuunwLzATUucTnno7vYIHwbDuzFED2mbIJX4by9QRj
         rYl+xaARLcGvWTIjgfCuB9xEpKgfPqWGgvb84mXD7JMQtZwACN56rgCJbPZHYqi8m8Td
         cpSjYm7htKgyz838A1uuwQB8O03/pyxaWgCkTOurR85uxMJmejgfcUIv7MJTbmOnXU0L
         tbDOZkxj+T6JV5ZiIPQhfD+uDw7IAGJ2sjNaMAMuFjHV9zkuJVQK3n4TxbbAGKa/WlEd
         0Trw==
X-Gm-Message-State: APjAAAWE5YbN89x5ANsGa7C8WqgoeubgHeSc1zlnVvSQ2hTBJe4QY7i6
        w14V6H0DD5yyq6j0GDVxDDIXk5h4
X-Google-Smtp-Source: APXvYqxfeA3vHw1fDPSzV+bfoPxK6hvNEIB0rzLeb0EW4c5ixxi+uYaMuAJHg06xvOFzJmKXTAUPFg==
X-Received: by 2002:a17:906:3098:: with SMTP id 24mr74351331ejv.106.1564152188576;
        Fri, 26 Jul 2019 07:43:08 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id j25sm13675896edq.68.2019.07.26.07.43.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 07:43:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] grep: stop using a custom JIT stack with PCRE v1
References: <20190721194052.15440-1-carenas@gmail.com> <20190724151415.3698-4-avarab@gmail.com> <CAPUEspiCFup4wvNwOA+egiAjkUEPgU+YnU8x2DfKhdbqTdOV3w@mail.gmail.com> <87h8787vmt.fsf@evledraar.gmail.com> <CAPUEsphZJ_Uv9o1-yDpjNLA_q-f7gWXz9g1gCY2pYAYN8ri40g@mail.gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAPUEsphZJ_Uv9o1-yDpjNLA_q-f7gWXz9g1gCY2pYAYN8ri40g@mail.gmail.com>
Date:   Fri, 26 Jul 2019 16:43:07 +0200
Message-ID: <87ftms7t6s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 26 2019, Carlo Arenas wrote:

> On Fri, Jul 26, 2019 at 6:50 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Fri, Jul 26 2019, Carlo Arenas wrote:
>>
>> > since this moves PCRE1 out of the JIT fast path,
>>
>> I think you're mostly replying to the wrong thread. None of the patches
>> I've sent disable PCRE v1 JIT, as the performance numbers show. The JIT
>> stack is resized, and for v2 some dead code removed.
>
> I didn't mean JIT was disabled, but that we are calling now the regular
> PCRE1 function which does UTF-8 validation (unlike the one used before)
>
>> > introduces the regression where git grep will abort if there is binary
>> > data or non UTF-8 text in the repository/log and should be IMHO hold
>> > out until a fix for that can be merged.
>>
>> You're talking about the kwset series, not this cleanup series.
>
> a combination of both (as seen in pu) and that will also happen in next if
> this series get merged there.
>
> before this cleanup series, a git compiled against PCRE1 and not using
> NO_LIBPCRE1_JIT will use the jit fast path function and therefore would
> have no problems with binary or non UTF-8 content in the repository, but
> will regress after.

I see. Yes you're right, I misread pcrejit(3) about how the "fast path
API" worked (or more accurately, misremembered). Yes, this is now a new
caveat.

I have some patches on top of next I'm about to send that hopefully make
this whole thing less of a mess.
