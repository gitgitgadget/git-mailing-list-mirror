Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903A61F453
	for <e@80x24.org>; Mon,  5 Nov 2018 11:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeKEU6f (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 15:58:35 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37532 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeKEU6f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 15:58:35 -0500
Received: by mail-ed1-f66.google.com with SMTP id y10-v6so695761edr.4
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 03:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=O7M0gWx2k2fusqxHTQVa1tfl3sYjQFIuwIsS0XEizR4=;
        b=LJ8kdU6nEhQLINJNsK+m9kFoDee13muz3bazxki574fQk5Zg1jvcB7x5eUxO9g5dOE
         K5vOAqpevkTge7m0YxRaAzkg5T7duLB+7FsGkHzPRzCexz+i2ZxFKl+ElhLWzWgOw90y
         XLHO5s7XD1oW/ED4lLgrPjPYq2aNiS/XoZc1LarCpCqXSfxyvw9++2qascwqPS5SZHlt
         1NaBDKBFdDdCWYlTwKxEjLGDU4CIuK9LV7YPlRCfNXjS8tp7d9DjTVi5cA52VORdbeSB
         AkEqJuTsIFlzKmzkLiFzVCrjAq2Xp3KJ5gysG+GgLH0KOUV/dulr9WKhW4uS83TVe0ny
         nDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=O7M0gWx2k2fusqxHTQVa1tfl3sYjQFIuwIsS0XEizR4=;
        b=RSUIeGWk8HNO5+7k2YDudJbjifXxqiu+33Mtxwna3IWT4Lj/WdTO50DS93iXx/Ry9i
         eGTXdH8SaeKONrhr/m2lvglYSYV4yxMMKnd41vBP91PQ2rb9K1Y4opgGpw2CwsIy9GPN
         RCXYa4LJe4Xi095UR7wGeFz8ZWaEDxxoAzjse9K2osDP4+huInia0KnBLFz+spkAlBYC
         xNVgav9FALxVORg57ZJSfZO+F1JFCNTO+ZMsRdUT24INoMca4M11hCzERqUCYSDMISVo
         b3JTnYJsP3zah5kid++ogssZXP44oTemYqE5v5qJQyUikkrSBMC/B2XRzOqZho3f4R09
         006g==
X-Gm-Message-State: AGRZ1gLIBkFMK03EjZ1lic8zspY7Ck9WMgyJRUoSKzIyBOUBkg5B97Ac
        W73Rsg8k3wqvHIo/5MDpesMmROwK
X-Google-Smtp-Source: AJdET5cLOvr+pY58DQDJemxou+b1AteHMyyZDtyF7DX82mE4pXLWx9efqs17J3GDzEGr5WbyckNy3Q==
X-Received: by 2002:a50:f5f9:: with SMTP id x54-v6mr17324294edm.166.1541417956042;
        Mon, 05 Nov 2018 03:39:16 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id n12-v6sm671637ejl.13.2018.11.05.03.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 03:39:15 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 10/12] Add a base implementation of SHA-256 support
References: <20181025024005.154208-1-sandals@crustytoothpaste.net> <20181104234458.139223-1-sandals@crustytoothpaste.net> <20181104234458.139223-11-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181104234458.139223-11-sandals@crustytoothpaste.net>
Date:   Mon, 05 Nov 2018 12:39:14 +0100
Message-ID: <87h8gv7nz1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 04 2018, brian m. carlson wrote:

> SHA-1 is weak and we need to transition to a new hash function.  For
> some time, we have referred to this new function as NewHash.  Recently,
> we decided to pick SHA-256 as NewHash.  The reasons behind the choice of
> SHA-256 are outlined in the thread starting at [1] and in the commit
> history for the hash function transition document.

Nit: In some contradiction now to what's said in
hash-function-transition.txt, see 5988eb631a ("doc
hash-function-transition: clarify what SHAttered means", 2018-03-26).

> +	{
> +		"sha256",
> +		/* "s256", big-endian */

The existing entry/comment for sha1 is:

		"sha1",
		/* "sha1", big-endian */

So why the sha256/s256 difference in the code/comment? Wondering if I'm
missing something and we're using "s256" for something.

>  const char *empty_tree_oid_hex(void)
> diff --git a/sha256/block/sha256.c b/sha256/block/sha256.c
> [...]

I had a question before about whether we see ourselves perma-forking
this implementation based off libtomcrypt, as I recall you said yes.

Still, I think it would be better to introduce this in at least two-four
commits where the upstream code is added as-is, then trimmed down to
size, then adapted to our coding style, and finally we add our own
utility functions.

It'll make it easier to forward-port any future upstream changes.

> +	perl -E "for (1..100000) { print q{aaaaaaaaaa}; }" | \
> +		test-tool sha256 >actual &&
> +	grep cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0 actual &&
> +	perl -E "for (1..100000) { print q{abcdefghijklmnopqrstuvwxyz}; }" | \
> +		test-tool sha256 >actual &&

I've been wanting to make use depend on perl >= 5.10 (previous noises
about that on-list), but for now we claim to support >=5.8, which
doesn't have the -E switch.

But most importantly you aren't even using -E features here, and this
isn't very idoimatic Perl. Instead do, respectively:

    perl -e 'print q{aaaaaaaaaa} x 100000'
    perl -e "print q{abcdefghijklmnopqrstuvwxyz} x 100000"
