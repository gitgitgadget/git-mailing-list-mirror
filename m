Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F26431F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfAVVsO (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:48:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33609 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfAVVsO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:48:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so9541430wmh.0
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=K5usYEnFkZ4YPXG3ftquupS+TvmmMHdLU3UkIBgm7fk=;
        b=ghSUiP3m0y+LU/ILGukVfl5AtpZR7IAQA7SVm0w+683Ddg3NC0FPNGfhN2dyjKw+TI
         Yih+WDg4Brn1I9fAba8mvCsQbQy+rP7ZCVSqVuz42uWYevjEbmIV6s1Y5pWqP8uZqbd6
         3+67M+Xikj4YuxprA3aGwwC3PqYrJWFFRjxQdVCS38tAD/njEXw7RNEjDhrxWbuix++V
         22girXsYVQFQgXOIYcKHOa4Yhvk6GUyPMi3eJjmcWepKz7ysVrgRBDsttgpmAK7Cdcqm
         xl4o78x6WkGREHJ4JLIcjH7BSQyaYkAbJTZyYe446Qd/tBnOBSTg/h/Z8UxggDR3OFVS
         +/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=K5usYEnFkZ4YPXG3ftquupS+TvmmMHdLU3UkIBgm7fk=;
        b=MeBEpv9cO7zPQq7NeA6wwQWVYh9dVfayzXFgH5SZP0ESDElG+3xDBjM1CQGNQIbj/G
         z8am7EuANvY6QW84Nvno1nbXmxA2JlF/sdLVAR5VjL7DvYvKlZL6IA4Ot2zL3dn+QA8O
         B+J4q8J6VJamevoXZYdZPTQSqmhg/J/P9T9/3B066uBIhALyuK0h+tZbXF/eoIJ7OvKQ
         fp9pMDJDsyO5Mr/QptVUwGM8MTwEeIchoSh8U+6QQl2JzFxvjvdY/OZN1bthYLFGP/wS
         wYXvQnagEJOWWk8s10wwi9tilrrTcNjRuG70lXVFE2nu54mH26rJIpE/9ItLvjG18Rl6
         nuNg==
X-Gm-Message-State: AJcUukdxC5yD8JQI8oQjfHoCJ/uDcLWywc4PkLNXF9zttEWnPTCERwoE
        KOlspjwy2pkeMBYEAAHxRz0=
X-Google-Smtp-Source: ALg8bN5uz+0WkZzdLpxcE/nHMXnnZIPB9Xayp0rr4NtVBeSj53SiX1S6AfHHxvLtlArcUgEJXRv0tA==
X-Received: by 2002:a1c:1801:: with SMTP id 1mr168777wmy.153.1548193692043;
        Tue, 22 Jan 2019 13:48:12 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v6sm78309417wrd.88.2019.01.22.13.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 13:48:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?S=C3=A9rgio?= Peixoto <sergio.peixoto@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] attr: do not mark queried macros as unset
References: <CAK3b1G+88a=xfO=6wfRi1SMy3xtca2NcFyxuBLKwSifb_L9xwA@mail.gmail.com>
        <20190117160752.GA29375@sigill.intra.peff.net>
        <CAK3b1GJPZ5X3uEP1a-NF9PZkE0tTKVLda5hM32jExVz_OD2E=g@mail.gmail.com>
        <20190118165800.GA9956@sigill.intra.peff.net>
        <20190118213458.GB28808@sigill.intra.peff.net>
Date:   Tue, 22 Jan 2019 13:48:10 -0800
In-Reply-To: <20190118213458.GB28808@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 18 Jan 2019 16:34:58 -0500")
Message-ID: <xmqqlg3ce545.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jan 18, 2019 at 11:58:01AM -0500, Jeff King wrote:
>
>> Now, on to the actual bug. The simplest reproduction is:
>> 
>>   (echo "[attr]foo bar"; echo "* foo") >.gitattributes
>>   git check-attr foo file
>
> Actually, even simpler is to just "binary", which is pre-defined as a
> macro. :)
>
>> which should report "foo" as set. This bisects to 60a12722ac (attr:
>> remove maybe-real, maybe-macro from git_attr, 2017-01-27), and it seems
>> like an unintentional regression there. I haven't yet poked into that
>> commit to see what the fix will look like.
>
> So here's the fix I came up with. +cc Duy, as this is really tangled
> with his older 06a604e670.
>
> -- >8 --
> Subject: [PATCH] attr: do not mark queried macros as unset
>
> Since 60a12722ac (attr: remove maybe-real, maybe-macro from git_attr,
> 2017-01-27), we will always mark an attribute macro (e.g., "binary")
> that is specifically queried for as "unspecified", even though listing
> _all_ attributes would display it at set. E.g.:
>
>   $ echo "* binary" >.gitattributes
>
>   $ git check-attr -a file
>   file: binary: set
>   file: diff: unset
>   file: merge: unset
>   file: text: unset
>
>   $ git check-attr binary file
>   file: binary: unspecified
>
> The problem stems from an incorrect conversion of the optimization from
> 06a604e670 (attr: avoid heavy work when we know the specified attr is
> not defined, 2014-12-28). There we tried in collect_some_attrs() to
> avoid even looking at the attr_stack when the user has asked for "foo"
> and we know that "foo" did not ever appear in any .gitattributes file.
>
> It used a flag "maybe_real" in each attribute struct, where "real" meant
> that the attribute appeared in an actual file (we have to make this
> distinction because we also create an attribute struct for any names
> that are being queried). But as explained in that commit message, the
> meaning of "real" was tangled with some special cases around macros.
>
> When 06a604e670 later refactored the macro code, it dropped maybe_real

I think 60a12722ac is what you meant here.

> entirely. This missed the fact that "maybe_real" could be unset for two
> reasons: because of a macro, or because it was never found during
> parsing. This had two results:
>
>   - the optimization in collect_some_attrs() ceased doing anything
>     meaningful, since it no longer kept track of "was it found during
>     parsing"
>
>   - worse, it actually kicked in when the caller _did_ ask about a macro
>     by name, causing us to mark it as unspecified

