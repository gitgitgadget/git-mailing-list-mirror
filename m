Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB5A1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 19:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932274AbeASTZb (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 14:25:31 -0500
Received: from mail-yw0-f180.google.com ([209.85.161.180]:37606 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756141AbeASTZa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 14:25:30 -0500
Received: by mail-yw0-f180.google.com with SMTP id v139so1026397ywg.4
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 11:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OWxX+YoUXsu2/1GtvJ6H6G9yil2YKvSRzLFI7XZ5f78=;
        b=GpPv5vHG7JmBvWx+D/qjFCwV+jnIktcQFz4BY0kCKTtJVDiKO+Zixn1jgt1z6IVF/3
         UQdUlvggp6FZ6m0Nq0r8uomwA7MjlAUU/NY2Fj+mlnvNF5ZBCu98+7bCbofD1Ud4hVS1
         ZIyCl6BEaa/DK1zS13Vy1Q5CJW0kmfwezoREOm6H6sGJNxW1CHhS50oV0nQZ2b6gS1Xk
         CiDRKN8qfJ9L5zI33JbL1jsoKPSQ8NJbDi81uMss/Fp4mBEV6WP4v1AO1fxnBvyKVyoI
         Ck4L6uSn32XY9biu13/QJ1i4s5k6vcgxTL/X8MYRsSQo6fwvlGV1tuolSNnBNSqXnLUK
         2VcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OWxX+YoUXsu2/1GtvJ6H6G9yil2YKvSRzLFI7XZ5f78=;
        b=U+fhbVEnRaI19h0VlL45I5vYma8IplLDNGa+VHaatENfO0he5dR9sovW5ar0mVSdgJ
         bz7tp5vPC6Lnsd12x3MiKwSqFOWJPxto9TdGwHyT4YtSM6To7o+2Yh+MIWzMgBjIUi2b
         OWV+ChNthE0kWVEgl6AlvfXYWLOtvGIoc+TUAG/hyKKPy7Hiv9fFBXXWZVYkOQL4ELHD
         Ls3Y7W9snEqmO6+F1Ct/TJfQRU2UosgY6hBJLgTZ76yM8+WlYUzBAd+9V80jSnN5Jjrq
         eqTzttaB/KnqNerlH7brHA23245zBExr1G57gFvFtkdj2h8wboQ7xZ3Kb7OUS8vmD9mv
         5zjA==
X-Gm-Message-State: AKwxytcDLIoc1ojGvNSZRjFqlMoPG0VpM1FBJMcBhWPF2zoGPpI3ost4
        qCyY09ogbO3ambIJEjlrgW+J4e89maJE25yqjyiBgQVRCDs=
X-Google-Smtp-Source: ACJfBotND84eKiJ0E8AccjtnA3IxHgwiZk49yTNueV0qdlJosIBUX8ilRS8DkZMqj1v9beX2T9A7WjI2J25iibHqAvs=
X-Received: by 10.129.122.73 with SMTP id v70mr10383266ywc.156.1516389929493;
 Fri, 19 Jan 2018 11:25:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.210.209 with HTTP; Fri, 19 Jan 2018 11:25:28 -0800 (PST)
In-Reply-To: <20180119173406.13324-3-randall.s.becker@rogers.com>
References: <20180119173406.13324-1-randall.s.becker@rogers.com> <20180119173406.13324-3-randall.s.becker@rogers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 19 Jan 2018 11:25:28 -0800
Message-ID: <CAGZ79kY4HzL8ed23RmoCU0izjsRKsZ0Mkzcmpm3+ugu7qZtcLA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] Bypass GCC attributes on NonStop platform where used.
To:     randall.s.becker@rogers.com
Cc:     git <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 9:34 AM,  <randall.s.becker@rogers.com> wrote:
> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> * remote.c: force ignoring of GCC __attribute construct not supported
>   by c99 by defining it as an empty CPP macro.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>

I do not know about the __TANDEM symbol, but some research[1]
indicates it is a macro specifically for case of cross platform support:

    You can use the __TANDEM symbol to increase the portability
    of your programs. Enclose system-dependent source text in an
    if section that uses #ifdef or #ifndef to test for the existence of the
    __TANDEM symbol.

It seems to not be used outside of the NonStop port[2], so the code seems
ok. (I would have used #ifdef, as I thought this is more prevalent in our
code base and for consistency we'd rather want to use one thing only, bug
"git grep '#if defined'" proves me wrong)

However the commit message is hard to understand (say for somebody who
will find this commit in 2 years using git-blame).

Maybe:

    In NonStop HPE (version X, all versions?) there is no support for the
    __attribute macro. By redefining the __attribute to an empty macro, the
    code compiles on NonStop HPE. Use the system specific __TANDEM
    macro to guard it for just this platform.

as that will help those people in the future not having to do the research?


[1] http://h20628.www2.hp.com/km-ext/kmcsdirect/emr_na-c02121175-1.pdf
[2] https://sourceforge.net/p/predef/wiki/OperatingSystems/?version=44

Thanks,
Stefan


> ---
>  remote.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/remote.c b/remote.c
> index 4e93753e1..c18f9de7f 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -11,6 +11,10 @@
>  #include "mergesort.h"
>  #include "argv-array.h"
>
> +#if defined (__TANDEM)
> +#define __attribute(a)
> +#endif
> +
>  enum map_direction { FROM_SRC, FROM_DST };
>
>  static struct refspec s_tag_refspec = {
> --
> 2.16.0.31.gf1a482c
>
