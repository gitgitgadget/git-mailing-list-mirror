Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E215620248
	for <e@80x24.org>; Mon, 18 Mar 2019 01:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfCRBua (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 21:50:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39547 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfCRBua (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 21:50:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so1040348wrn.6
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 18:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=s5r4HdJRJ9vX1iZY0iTeaWKpSTfyIJM2PAGQdj+5aAE=;
        b=SQUO2pNE92iGwOUzX0VGkacY0QKU7VC1dvDnkAyLRKFWrzqeJGnJqrzBRLnGfV6q2r
         VpQgrBQCh1pEwKmGmksZdfKB2dYCWcKbduBxA3r4KPQV6Yu3pISerUpJBOUo0y02cjpi
         i1Vlf5MKx1gfS01fjorLh6eqX2umxf65mE3M0Jcddg3scit8twfUs67lCoIsLIIcYuFE
         d52mUUfUoLpQ5LSPUnXlEnMHGgo/ty2ozS6/0vVfR8TUVHEVDd61Ay2W9m432syKSUqZ
         RrxA+36d+CN6L1qNCGeYFusoLi+ZDry4RAvTRbcXD6KKfoK3bWx+Gko08EqrCgP5Wue0
         a6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=s5r4HdJRJ9vX1iZY0iTeaWKpSTfyIJM2PAGQdj+5aAE=;
        b=NYp28EpFexr8Ir8T7X5X9nRHTw6Hi1vVAhen5HLr32t6RUaNY6PB51lvoYkKkndwEa
         XD6djro2l832QKk51YWUs1crmDhI+P/cXe/AcrtVhkUtvmW0XbQc5t01MMZJynsHa9fO
         t1G2aayllCze3E6X+f4xeN6ItqJQKpx5OMyJjjnxxWkBa64MArn4GfuWqB3iSsmUfaIo
         xQV7P3u2KqGET/gYlD/hV6pWZqXTDSahI2uYzS1VfTGpQ6SPV42q8dycufJaHCHOVP7Y
         MbelpJHc40zaOWL3my5qikAY4sg208NWN0ohDDvdxJTUOy9EkLotfXTAhTLNZB/qwYpP
         B0Iw==
X-Gm-Message-State: APjAAAXqIzA8hlLQ0dlGrB+dNoimEqQFA5K+u/uVt0Ba6Kz2g5BZ/xGl
        GutoS7xbm6ZIenYjNueKSOc=
X-Google-Smtp-Source: APXvYqyDaJRj+EUeyctSPkpLF6ytqHQlG5jL60WOfRzvhsy3chsJEqzCH5dC14VAQcaoqNNQDhLmEw==
X-Received: by 2002:adf:f3ce:: with SMTP id g14mr1457161wrp.129.1552873828533;
        Sun, 17 Mar 2019 18:50:28 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id h131sm3704315wmh.1.2019.03.17.18.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 18:50:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 03/11] test-lib: introduce 'test_atexit'
References: <20190313122419.2210-1-szeder.dev@gmail.com>
        <20190313122419.2210-4-szeder.dev@gmail.com>
        <xmqqh8c6b0pv.fsf@gitster-ct.c.googlers.com>
        <20190314174024.GH28939@szeder.dev>
Date:   Mon, 18 Mar 2019 10:50:27 +0900
In-Reply-To: <20190314174024.GH28939@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Thu, 14 Mar 2019 18:40:24 +0100")
Message-ID: <xmqqwokx6jdo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> but it even skips when there is no point doing the
>> test_eval_ of the "accumulated" scriptlet when it is empty.
>
> But this is not, because $test_cleanup is initialized to this special
> value and it can never be empty, and indeed 'test_eval_' uses this
> condition:
>
>   if test -z "$immediate" || test $eval_ret = 0 ||
>      test -n "$expecting_failure" && test "$test_cleanup" != ":"
>
> and it never checks $test_cleanup's emptiness.

Yeah, I used "empty" not in the literal sense; I know why the "empty
in spirit" setting is a single colon for $test_cleanup.

I just did not realize that this new variable was using that exact
pattern and using ":" as the empty in spirit, and that was where my
fuzzy wordibng came from.

So in short, I misread the code, and part of that is because I was
misled by the comment:

> +	# This condition and resetting 'test_atexit_cleanup' below makes
> +	# sure that the registered cleanup commands are run only once.
> +	test : != "$test_atexit_cleanup" || return 0

It over-stresses the "run only once", but the true value of this is
that it avoids running an "empty in spirit" clean-up sequence.  

The avoidance of double execution merely takes advantage of this
implementation detail by "resetting" the variable is better
explained where the "resetting" happens (i.e. "we reset the variable
to the 'no-command' state, as we've run all of them here, but just
before the process finally exits, the helper will be called and we
do not want to run these commands again when it happens").

Thanks.
