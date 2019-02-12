Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDF761F453
	for <e@80x24.org>; Tue, 12 Feb 2019 11:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfBLLLQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 06:11:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44174 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfBLLLP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 06:11:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id v16so2170335wrn.11
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 03:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=f6ENflLxgzlAg6tmGwoBC3HNkoctLYUvhwbLQkXh41Q=;
        b=rwrQ1UfmVImLr6TeUTopHKuGVY6cAKaaotaOAowUYdK9ynaI4hWBfgqstFOQ/smztJ
         29NGqoyrSmIRHmwBjigIWTqZEzRoQ6lTbaJh4UISU5FDZt+wrFL6Vnu/pfeuerGzCezo
         BR79HGkjULetmRwTT0MetV5gamOlF9BezzCY6egkljbdEFLbncfvEbyI+5GORbHtugIn
         J0hw1h0qDWU929U6nJBvHQHq3PHGuU7wn0MevOVkDmD+KDUs4rohsgFerHgAxLtrSOSO
         JE60X62pjjY6uE1ydHQ+n/uayGBkG3KgrJSq7ZQUiykIs+wQdqfnkFKkIYNT3iKYMxpt
         krYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=f6ENflLxgzlAg6tmGwoBC3HNkoctLYUvhwbLQkXh41Q=;
        b=pXJhvB7oIedg8qSWfuiHD2yX8eak6q4PX0D8RyryqOYUI60q2XtuacWHUc3rqT/OnO
         WXar+7J2G01NxqH7pk6YQD5POcEETQ9ZvBsDKZGUKH5IrZa56vGt74bHQ+xW6nD+Jf2/
         sPB1f4uwwUsVFPuqBSlB4GgFFET7MvjPzUwMF/7kgXzlHgO3du8ThOpre0NWDKqZo+ON
         QfD6zDZI/zQhiwMEDyBGsU4X5HJN5Q9SvlZvHKqCxMxwrWvm0Y8P7hj0ooa2L0zlGLUg
         uIJGK6irn+Kxli+3qA492XrNT8ODTf22uokSHOG8PtwZHmNZm3Q16UYLiq3BKJeyzqMy
         /0Qw==
X-Gm-Message-State: AHQUAuZiD/Q7eGB//5wKhgObI1MFiKYSt4jMeeOisvveiu+OxNVkJkEB
        PIjN5WWen3EC4mTj6HQJhTM=
X-Google-Smtp-Source: AHgI3IaWF6ltXZdedv2Ln6phQO/thstA3NB8YEVNY5fFSXOtAry+2aPvkrOY2Rtr3EY9G6UFeY9qAQ==
X-Received: by 2002:adf:f60d:: with SMTP id t13mr2385954wrp.225.1549969873054;
        Tue, 12 Feb 2019 03:11:13 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id a4sm1852823wmm.22.2019.02.12.03.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 03:11:12 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 23/31] remote-curl: make hash size independent
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net> <20190212012256.1005924-24-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190212012256.1005924-24-sandals@crustytoothpaste.net>
Date:   Tue, 12 Feb 2019 12:11:12 +0100
Message-ID: <87wom5jm7j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 12 2019, brian m. carlson wrote:

> Change one hard-coded use of the constant 40 to a reference to
> the_hash_algo.  In addition, switch a use of get_oid_hex to
> parse_oid_hex to avoid the need to use a constant.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  remote-curl.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index bb7421023b..8395b71bbb 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -249,7 +249,7 @@ static struct ref *parse_info_refs(struct discovery *heads)
>  		if (data[i] == '\t')
>  			mid = &data[i];
>  		if (data[i] == '\n') {
> -			if (mid - start != 40)
> +			if (mid - start != the_hash_algo->hexsz)
>  				die("%sinfo/refs not valid: is this a git repository?",
>  				    url.buf);
>  			data[i] = 0;

Similar to my comment on 28/31 I may be missing something, but this is
the part where we're parsing the ref advertisement from a remote
repository, which may e.g. be SHA-1, and our local "the hash algo" may
be SHA-256, no?

So isn't this a point where we need to accept both, and parse it into
some structure where we mark it as either/or SHA-1 or SHA-256, and late
or consult SHA-1<->SHA-256 lookup tables etc.?
