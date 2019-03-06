Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F226720248
	for <e@80x24.org>; Wed,  6 Mar 2019 05:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfCFF2E (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 00:28:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35203 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfCFF2E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 00:28:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id t18so11896444wrx.2
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 21:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uHx66kxYB8yPYjkKOD/U1gYEaTF9D+9CTpFjsFiOSi4=;
        b=S7rbgESf/vrhcorBE2PTgIap9d6mTTrgK/Zy/a0+nUV7TWEs3yudKxYTx4zkUsGbbv
         d4L5g4LJOenxZPbaNGta2/OfHNq0+Nt/yThYlr6QatXMYHJokhffYDF754pbo9xLv28k
         2cJGyFG0rHDUIAVS9+Y14NgOSuQBC1AERwlXcJydtm5cH3R3azE4Bp+9hZSULqraYlKZ
         DL7pyw26X2ky/S1za0RNzr3VbCYDJF78eoCyeETaxE8TMCuCY1q3+bPFGPi1ORI2cbLe
         +CAfdDy2nasn1Lv8QnMdci54rg5adJjVTPEQlsNOnP8vbczSxAxmfBgj6RKP7EAB6Lr8
         wiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uHx66kxYB8yPYjkKOD/U1gYEaTF9D+9CTpFjsFiOSi4=;
        b=RRshcIgHdaKlg6whHlwNj0yocMAclIsNB1UMuhzmniwWJDJk7dqkZQc0zzseX5rnxx
         u/dU1jPHMSpGPUA1FeSAK7ERUjNM+QIW5Gt2hU4OatI55n6pvsMx02MRrOh5KGNpx5Hz
         6qHK2m4KPJPkAD0xk5IJLBD0LNIFukba2tnfqPYePZtaTlLf3W6oc/SLkcRAwbxD1EEB
         K9L3FO2b0Hj/BTHgqdg5orN+3htU+/5vE3Ol8XwNE2Ka6QZfxuid04JpCErP3k8nfI4I
         s1dZJS+iQXvbnDH4Z1Jd4BLsu2To3w6aS+r+iZRNZkADvAKUmUK/mRoUdgxOldpFloyz
         pAtg==
X-Gm-Message-State: APjAAAUZrIT3NE0HywODATvJC567TlA1YBSjq36DkcoOK7spWeaTfluZ
        lcnDtrB2V0yBmmAYWl0A33w=
X-Google-Smtp-Source: APXvYqzA5Ig/9G6IVSffahfWd+jObRZzgO5BZ717QWhqa8m59O3GManpxsRPn1qNKpCZpd3QrGtFiQ==
X-Received: by 2002:a5d:628a:: with SMTP id k10mr1372224wru.108.1551850082067;
        Tue, 05 Mar 2019 21:28:02 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h137sm2140367wmg.41.2019.03.05.21.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 21:28:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files, if possible
References: <pull.130.git.gitgitgadget@gmail.com>
        <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com>
        <20190301213619.GA1518@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1903022058230.45@tvgsbejvaqbjf.bet>
        <20190303171951.GD23811@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1903041206300.45@tvgsbejvaqbjf.bet>
        <20190304214155.GB3347@sigill.intra.peff.net>
        <xmqqzhq9vpik.fsf@gitster-ct.c.googlers.com>
        <20190305230723.GB22901@sigill.intra.peff.net>
        <42d125d4-76bf-afc3-8f12-a9fa1296c85c@ramsayjones.plus.com>
        <20190306044006.GA6664@sigill.intra.peff.net>
Date:   Wed, 06 Mar 2019 14:28:01 +0900
In-Reply-To: <20190306044006.GA6664@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 5 Mar 2019 23:40:06 -0500")
Message-ID: <xmqqd0n4r2qm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Mar 06, 2019 at 12:23:20AM +0000, Ramsay Jones wrote:
>
>> > Yeah, that's what I was hinting at earlier in the thread. Here it is
>> > sketched out to an actual working patch. The sub-make bits could
>> > actually be a shell script instead of a Makefile; the only point in
>> > using make is to use the parent "-j" for parallelism.
>> 
>> sigh. :(
>> 
>> I wish my patch removing this target had been picked up now!
>> 
>> Earlier this evening I spent an hour or so writing an email which
>> tried to discourage spending any time on this, because of the
>> potential for this to be a huge time-suck. An unrewarding one at
>> that! :-D
>
> Heh. I am OK with removing it, too.

FWIW, I am fine with that plan as well.

> My thinking earlier in the thread was that it should go in our bag of
> linting tools that people should generally run. But actually, it is kind
> of expensive to run, and it does not actually help anything immediately
> in practice. I.e., what we really care about is that the C source files
> compile, and running "make" does that (and especially running it on
> various platforms). This is just checking for a _potential_ problem if
> somebody were to include a particular header file at the start of
> another C file.
>
> So it's really about 2 steps removed from stopping an actual problem.

Yeah, exactly.

> diff --git a/compat/bswap.h b/compat/bswap.h
> index 5078ce5ecc..e4e25735ce 100644
> --- a/compat/bswap.h
> +++ b/compat/bswap.h
> @@ -1,3 +1,6 @@
> +#ifndef COMPAT_BSWAP_H
> +#define COMPAT_BSWAP_H
> +
>  /*
>   * Let's make sure we always have a sane definition for ntohl()/htonl().
>   * Some libraries define those as a function call, just to perform byte
> @@ -210,3 +213,5 @@ static inline void put_be64(void *ptr, uint64_t value)
>  }
>  
>  #endif
> +
> +#endif /* COMPAT_BSWAP_H */

This probably is worth having as an independent clean-up.
