Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240611F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 12:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388757AbfJ1MBA (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 08:01:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43408 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfJ1MA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 08:00:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1so2119774wra.10
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 05:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TZbJM9Yooqn18XKRHoer/Qbrki+3zG6k2eMjhkIwKUc=;
        b=nNB/cs/szo0UPTMQSBmLLMDFNy99PierAt3sks/4imJPRJsmbyGCeC3MSZ0DE0C0ME
         bVHWCKdyGVV277eI1wvZSUvLQQSFJzen+Y0CyqTEfWszPCaJ4GizYTt9+d74jKeROIYE
         jfq0uUe+/psr4SGZQYnH2uwqmOwH3vyXX1dobUkcthyajjG5BoJn3nF6xMvcSK9F27Br
         FtoR1a2BTzBFmmpCuT1LMYzesioPy0/CNp58iZGcXy3mWybpcy95zcYgP4ByTgaaMQGj
         z1cL+kwAIXW4+KmKd2jYhAQ2GCjubt9fX2hB7oYfG8ETObYPuChgfxSrea3ZkNIG21qU
         eX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TZbJM9Yooqn18XKRHoer/Qbrki+3zG6k2eMjhkIwKUc=;
        b=m4xwFocXlCTJVPOFCArlprVe+FqNZnA+bhyqZ3BA62T8n/9IhySJVfHb2Rqhv1Yk1D
         az9S3nFrBjBTLLikt6LdAn9z03kF8oQG2ykKvSkE985tlj2q1ifK+U/vi+tAeD35j3rL
         x0GDMQuiXXQvsBmDtS+NalqbkoZvTgyUChfaDnK1yhoTiEf7BaXI90RrWGJRAVFtIq3p
         eTp5bXXvh6XcZwuOylwTY/RUJhQSZ4OHk3iz7YZ/ntVL0d5U6kqfhTsIxpx2O63Qy5qb
         W5FCKrQfeFPhRi7Rrnv7ovnZA6XWj3oSgFaXVbZHg2X7kuM8oWw3gU3P33Z+n/RsjYc6
         rd9A==
X-Gm-Message-State: APjAAAVWEEyrNTbuaHZ0QExYIkuwAEJgseBNt+hHCVkuqaIONtRGehAB
        VBIj57Rw3pfFGqeputCgANg=
X-Google-Smtp-Source: APXvYqwqxU6ehosclM2YOmEC/zt9jxq/ck3hxwRc/FEv0iR0B2kU2g3RGb0eMMmC9t6i8Ip0+QjYSg==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr14535240wrm.83.1572264057792;
        Mon, 28 Oct 2019 05:00:57 -0700 (PDT)
Received: from szeder.dev (x4db30d31.dyn.telefonica.de. [77.179.13.49])
        by smtp.gmail.com with ESMTPSA id w22sm10373094wmi.7.2019.10.28.05.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 05:00:57 -0700 (PDT)
Date:   Mon, 28 Oct 2019 13:00:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 5/5] path.c: don't call the match function without value
 in trie_find()
Message-ID: <20191028120054.GS4348@szeder.dev>
References: <20191021160043.701-1-szeder.dev@gmail.com>
 <20191021160043.701-6-szeder.dev@gmail.com>
 <nycvar.QRO.7.76.6.1910281155220.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910281155220.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 28, 2019 at 11:57:10AM +0100, Johannes Schindelin wrote:
> >   - According to the comment describing trie_find(), it should only
> >     call the given match function 'fn' for a "/-or-\0-terminated
> >     prefix of the key for which the trie contains a value".  This is
> >     not true: there are three places where trie_find() calls the match
> >     function, but one of them is missing the check for value's
> >     existence.

> Thank you for this entire patch series. Just one nit:
> 
> 
> > diff --git a/path.c b/path.c
> > index cf57bd52dd..e21b00c4d4 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -299,9 +299,13 @@ static int trie_find(struct trie *root, const char *key, match_fn fn,
> >
> >  	/* Matched the entire compressed section */
> >  	key += i;
> > -	if (!*key)
> > +	if (!*key) {
> >  		/* End of key */
> > -		return fn(key, root->value, baton);
> > +		if (root->value)
> > +			return fn(key, root->value, baton);
> > +		else
> > +			return -1;
> 
> I would have preferred this:
> 
> +		if (!root->value)
> +			return -1;
> +		return fn(key, root->value, baton);
> 
> ... as it would more accurately reflect my mental model of an "early
> out".

The checks at the other two of those three callsites look like this,
and I just followed suit for the sake of consistency.

