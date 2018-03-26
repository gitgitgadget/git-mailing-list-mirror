Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DC8D1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 22:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeCZWSX (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 18:18:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54202 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbeCZWSW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 18:18:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id p9so5682392wmc.3
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jBTXk/SWGaFrkmICnmZL2iFSZtS203CHsRhAAZCzgiY=;
        b=Kss8lswAn1d2a2F9R1UyAHhcLap0Mw5B5NWCkl9IpnlEBogQVVW9Iy8LsdskRzam/J
         jwk8qEb0uyEw45DGt92NYGLRFP5QeUVPbP/gyxd0xTwg55nhdr/gduzB1gQfOZx2uibz
         iOZe92EIhR6O7/57ALrd/srqW03gwBILdnHGrHnkFDmOS8T45nNZdM5l8m2zgw680Tz/
         +J0+6999uMZMwLd1yj8e/qV0heGvyouYn+Sws5F3WsSse9IYWRn1pvTW3MQWY0z+0MmT
         H9jTvtvSLsVD7HWAl1Mu8O/e1nZm86kAgHArbvAXRYEgCtggvxzH3qS2N4sx7Rueubd6
         Q/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jBTXk/SWGaFrkmICnmZL2iFSZtS203CHsRhAAZCzgiY=;
        b=RRBs+Kc+x5Uz1psMPjUFlXuAqo5vnu/Oxgm/dhhwd/O/kkeHZUbLeFl9O4nYiJWpo0
         a4CnHsyugkIrlw+if7NXDZynDK4GSADTeWeM8D3iYqe9bz5OfIAyNUVL8yHsa5j+dGPj
         9d8LtDOs49QbBX8OvXkcwPXIKA44uCmPkWZG8ePZjjieAQuuewwNqApxanabscGtTyJC
         kQ9m4O2oGhvIAX0LzWngOkRtZl4N75DDon2yRg97yGS6DKRQhJqD9FTefVoQRDAJ4X3R
         GlQAKabFjkhIqbz8h02qJ6miGLvdDjHLrtQ7YzuSvsUxwJ6O7IVYW23ol87HnTiXoT/3
         ATTg==
X-Gm-Message-State: AElRT7EkZw5qxF76ia6Z451P/deYYOl1+AzjiGgLYs5ZLijfBvURNCUN
        noxswd9c2Scv3jCG7k53MGQ=
X-Google-Smtp-Source: AG47ELtm8k/7BSbYY0ciWiO4rKgGzOC0bGKLIw2WDUgjQsm49OKXVwWLXM6K4Fl7s60ncJ3SCIDOfw==
X-Received: by 10.28.101.6 with SMTP id z6mr15184617wmb.110.1522102701289;
        Mon, 26 Mar 2018 15:18:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 140sm17950wmy.38.2018.03.26.15.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 15:18:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 04/10] t1405: sort reflog entries in a hash-independent way
References: <20180325192055.841459-1-sandals@crustytoothpaste.net>
        <20180325192055.841459-5-sandals@crustytoothpaste.net>
Date:   Mon, 26 Mar 2018 15:18:20 -0700
In-Reply-To: <20180325192055.841459-5-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 25 Mar 2018 19:20:49 +0000")
Message-ID: <xmqqefk6bhw3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The test enumerates reflog entries in an arbitrary order and then sorts
> them.  For SHA-1, this produces results that happen to sort in
> alphabetical order, but for other hash algorithms they sort differently.
> Ensure we sort the reflog entries in a hash-independent way by sorting
> on the ref name instead of the object ID.

Makes sense.

> Remove an assumption about the length of a hash by using cut with
> the delimiter and field options instead of the character range
> option.

I thought you used your truncated blake hash to develop and verify
these changes, but I'd imagine that the "42" thing were hard to
spot.

Thanks.


> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t1405-main-ref-store.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
> index e8115df5ba..a1e243a05c 100755
> --- a/t/t1405-main-ref-store.sh
> +++ b/t/t1405-main-ref-store.sh
> @@ -45,7 +45,7 @@ test_expect_success 'rename_refs(master, new-master)' '
>  '
>  
>  test_expect_success 'for_each_ref(refs/heads/)' '
> -	$RUN for-each-ref refs/heads/ | cut -c 42- >actual &&
> +	$RUN for-each-ref refs/heads/ | cut -d" " -f 2- >actual &&
>  	cat >expected <<-\EOF &&
>  	master 0x0
>  	new-master 0x0
> @@ -71,7 +71,7 @@ test_expect_success 'verify_ref(new-master)' '
>  '
>  
>  test_expect_success 'for_each_reflog()' '
> -	$RUN for-each-reflog | sort | cut -c 42- >actual &&
> +	$RUN for-each-reflog | sort -k2 | cut -c 42- >actual &&
>  	cat >expected <<-\EOF &&
>  	HEAD 0x1
>  	refs/heads/master 0x0
