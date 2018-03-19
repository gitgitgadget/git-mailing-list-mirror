Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A0461F404
	for <e@80x24.org>; Mon, 19 Mar 2018 18:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970186AbeCSS7W (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 14:59:22 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:52995 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966836AbeCSS3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 14:29:16 -0400
Received: by mail-wm0-f48.google.com with SMTP id l9so7877898wmh.2
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 11:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0itMetr58E1gsFAH7gHE1Dd8rDrA/6uc8UyZ6NWOCAs=;
        b=Fs2HCuyWX3MwHyFsFFqz7F4BRpTAFYErkXBjG9MNo8EzBEUi5Btk6uGF2xCPpjnGfw
         arQgVw+jgcdEfyl/tTnabff/Nj8JfV6lWkl1bR1hNhFpeJUEzn3Ym6EuiJEstRqYPzVu
         Ys3tIb5s+41rZJKYMjg0BF+p4A1lVqvPLz7VzsnCKWKtwIAV2NLo/VagU30uOhqg728u
         MMpRQkINnbpQ4heAkx3FTJO6YAahPPsxvET9S3Bm9Yxr2atixIFpl00kgD9zQmexfKKQ
         cSkuZWBV2u5Sx2qIFgy/8/A0HS4wEfybbGG/T8UPEYPT9o3FUG74ZGmAKlEhK5ohuSj4
         3/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0itMetr58E1gsFAH7gHE1Dd8rDrA/6uc8UyZ6NWOCAs=;
        b=ipJuqiNIFh2t2AUZTJMta/7nEH3VWJ3LdE7fMsmLh6gKbOyytmimx7quviSciN3NqI
         upJ2YqBeFx5m2UUpN2sUc6dYjR0EgvvYfLCY3nj2zP33HtFu/flzU1F371fx6kjwvEAr
         08zzgDlh0C+pauBpppOEl2Gxu9ajOALZoojZKmPvRqMQ/qlhHbelCdxU+pNwM1+z+h7X
         T6JSwXV3Q8zJ2qKTB30hNpsmseO1V83Hh+HFs2cbryTSGGX7rC6aCwWPSuzBlqpLY/h9
         yvkzxvw3YFxp+fLSQXHv/K+n0pg8C0WDRD7X1yhZ70/mh5BqqjpEVG7kGJh+3Tu/XOP2
         LxRQ==
X-Gm-Message-State: AElRT7F5DAcLGTo+m8Yug/pW04gKj1yoG6ROBHkWaTz6aX7WSvPX8Z5L
        neWJXYEgHPq6OHKL+YkpK+U=
X-Google-Smtp-Source: AG47ELv7e1VygscwJIimQ5h58/QtP7+jnz6s4cMNL/n6DjSf8xEHGih/hOVJF+sOpbQ7yH3MVw/Ixg==
X-Received: by 10.28.93.137 with SMTP id r131mr6149811wmb.73.1521484155064;
        Mon, 19 Mar 2018 11:29:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p78sm16591wmg.47.2018.03.19.11.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 11:29:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 09/11] pack-objects: shrink size field in struct object_entry
References: <20180317141033.21545-1-pclouds@gmail.com>
        <20180318142526.9378-1-pclouds@gmail.com>
        <20180318142526.9378-10-pclouds@gmail.com>
        <xmqqsh8wvwwn.fsf@gitster-ct.c.googlers.com>
        <CACsJy8AkJJQ4XNszxBsESN_WGOSZ+ExWdcCtn6NA+gW9+-mAqQ@mail.gmail.com>
Date:   Mon, 19 Mar 2018 11:29:12 -0700
In-Reply-To: <CACsJy8AkJJQ4XNszxBsESN_WGOSZ+ExWdcCtn6NA+gW9+-mAqQ@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 19 Mar 2018 17:54:48 +0100")
Message-ID: <xmqqlgenvs07.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> This is why I do "size_valid = size_ == size". In my private build, I
> reduced size_ to less than 32 bits and change the "fits_in_32bits"
> function to do something like
>
> int fits_in_32bits(unsigned long size)
> {
> struct object_entry e;
> e.size_ = size;
> return e.size_ == size.
> }
>
> which makes sure it always works. This spreads the use of "valid = xx
> == yy"  in more places though. I think if we just limit the use of
> this expression in a couple access wrappers than it's not so bad.

Yes, but then we should name the helper so that it is clear that it
is not about 32-bit but is about the width of e.size_ field.
>
>>> +     if (!e->size_valid) {
>>> +             unsigned long real_size;
>>> +
>>> +             if (sha1_object_info(e->idx.oid.hash, &real_size) < 0 ||
>>> +                 size != real_size)
>>> +                     die("BUG: 'size' is supposed to be the object size!");
>>> +     }
>>
>> If an object that is smaller than 4GB is fed to this function with
>> an incorrect size, we happily record it in e->size_ and declare it
>> is valid.  Wouldn't that be equally grave error as we are catching
>> in this block?
>
> That adds an extra sha1_object_info() to all objects and it's
> expensive (I think it's one of the reasons we cache values in
> object_entry in the first place). I think there are also a few
> occasions we reuse even bad in-pack objects (there are even tests for
> that) so it's not always safe to die() here.

So what?  My point is that I do not see the point in checking if the
size is correct on only one side (i.e. size is too big to fit in
e->size_) and not the other.  If it is worth checking (perhaps under
"#ifndef NDEBUG" or some other debug option?) then I'd think we
should spend cycles for all objects and check.

