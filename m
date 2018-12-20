Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC52C1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 23:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390286AbeLTXMX (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 18:12:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36685 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbeLTXMX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 18:12:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so3164813edb.3
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 15:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hg1Mtoj+Clv5OQ/lB0xdopZPk+x2wXbPGKb8lFefZiI=;
        b=oucNCNRBG1I7idHn+IHMV0Ad4usjZLgN+dIl1WvEIoBYl26mSDv/CfI45Cc7OeZWnB
         87DnKklE5JcRylSIobDrheQBp6HOhnIBlx9F7CSDMcyd7cOdR/qMKqSSVk7zxQTdvj+b
         vTK0/9DOM+zVnKD1Zh0bWUwhYFsoKu8Km72IkqcNu6t62Tn6812u/t7i/4c1WPs2BKkI
         zxcZtNWQdWAj73D2nQfnSeCWIMVFKzyetwZQbrYz5VUDa338iUTcwTbLjBjnisMOyYHP
         iGSElfa7+SxOuzEraVhTWOui7XIQesOoEVeDbb5NTzP7vK5XY4B5L4vZCcmzXvaqD95M
         tjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=hg1Mtoj+Clv5OQ/lB0xdopZPk+x2wXbPGKb8lFefZiI=;
        b=rb/2U/nTVJKBH6PHKNe9xv7jUeknuDKhfMz5urGbLmshdNgCbkxSqoS5LmO575qsXh
         wXcCnUIQRT6QCadHBZsTR+SMwHu94KMscRRwKxtnxOo+l892ykNNMcpBq9jkpas613qG
         kThdi6X+XV+0wtGdoViCRtz+QzXRskHGYOaysUsTCebo1yfPp3gQtQsOFsJp2buWAMt1
         I9S2+NWShyuWwV5LzRJLmLVBzhaG9qbAUWlx38+bSHVfiyUoFrx/U/F71buWiRQ2Ult3
         kuWf3J9dbNK9aCXwIMPhsF3q594mtT5xJcAfuKEqPaoxuedfxBSKkc6em6alJtk4GzCu
         sm5A==
X-Gm-Message-State: AA+aEWaCeTBf/bvtYzIny6BUyJ5p1Oaqh1/C06vKZM3wFH+Epi4jbF7H
        iPMOzO96PorxTf0fn85OSEcGBORaoe8=
X-Google-Smtp-Source: AFSGD/WqYt9g1aCubbR7krzY/2+1FeeeoctNpcS++yl01cPGq7WFepzlq/sWVuKLowg6Ch0+67BxHg==
X-Received: by 2002:a50:a5e2:: with SMTP id b31mr395967edc.5.1545347541823;
        Thu, 20 Dec 2018 15:12:21 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id n22-v6sm3378512ejk.75.2018.12.20.15.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 15:12:21 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/5] compat/obstack: fix -Wcast-function-type warnings
References: <20181220162452.17732-1-szeder.dev@gmail.com> <20181220162452.17732-2-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181220162452.17732-2-szeder.dev@gmail.com>
Date:   Fri, 21 Dec 2018 00:12:20 +0100
Message-ID: <87zhszeqsr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 20 2018, SZEDER Gábor wrote:

> When building Git with GCC 8.2.0 (at least from Homebrew on macOS,
> DEVELOPER flags enabled) one is greeted with a screenful of compiler
> errors:
>
>   compat/obstack.c: In function '_obstack_begin':
>   compat/obstack.c:162:17: error: cast between incompatible function types from 'void * (*)(long int)' to 'struct _obstack_chunk * (*)(void *, long int)' [-Werror=cast-function-type]
>      h->chunkfun = (struct _obstack_chunk * (*)(void *, long)) chunkfun;
>                    ^
>   compat/obstack.c:163:16: error: cast between incompatible function types from 'void (*)(void *)' to 'void (*)(void *, struct _obstack_chunk *)' [-Werror=cast-function-type]
>      h->freefun = (void (*) (void *, struct _obstack_chunk *)) freefun;
>                   ^
>   compat/obstack.c:116:8: error: cast between incompatible function types from 'struct _obstack_chunk * (*)(void *, long int)' to 'struct _obstack_chunk * (*)(long int)' [-Werror=cast-function-type]
>       : (*(struct _obstack_chunk *(*) (long)) (h)->chunkfun) ((size)))
>           ^
>   compat/obstack.c:168:22: note: in expansion of macro 'CALL_CHUNKFUN'
>      chunk = h->chunk = CALL_CHUNKFUN (h, h -> chunk_size);
>                         ^~~~~~~~~~~~~
>   <snip>

We originally got this from now-discontinued eglibc, but I notice that
glibc.git's malloc/obstack.[ch]'s diff also changes these lines. If you
backport those do does that fix this warning?

I.e. is this another case where we're blindly fixing bugs but should
just re-import upstream's code instead?
