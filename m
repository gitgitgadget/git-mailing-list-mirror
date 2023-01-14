Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0727C46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 14:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjANOci (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 09:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjANOcg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 09:32:36 -0500
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 Jan 2023 06:32:33 PST
Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF69A7ABA
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 06:32:33 -0800 (PST)
Received: from [10.0.2.15] ([147.147.167.102])
        by smtp with ESMTPA
        id GhXDpgWpGAajaGhXFpiSj8; Sat, 14 Jan 2023 14:29:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1673706570; bh=DRaIIpB491flpNx2MLgsyGbyuUJYKhgeu4YMoLebrCc=;
        h=Date:Subject:To:References:From:Cc:In-Reply-To;
        b=Te0rPCDXqGeSwF1sFI8awXoH9B4GbWZ/xjhsEHLAgfuEMBncvjvPv0Ippqg71Er0a
         5XFNA+bztieF4NQXwd0w/cL9vFXP7yjgh9q6GHFT/gPX9JHq3gblKB5Mii+u6vC0ld
         DWiocuG++b9QgkFDSozAKnfD74ENVOIREtNG0aqQE0GHnSDFF87i9bmiSIm9qcV/G1
         KJEJ/36452ttfdxWUwYDWGkGakTBzAejUpGsfveTFJQ4e/M9nloSc/WYYa1x8bIZvp
         F5TIZdMvawvT0PURZBaN+NT0Zi7GdHnVes04y0D1oV9IsR/pbjoCQfxZ6ehUn2jU6H
         uoEXnIeiF1l6Q==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=eI8AMVl1 c=1 sm=1 tr=0 ts=63c2bc4a
 a=O4HnXJxpn4bBnFCb4s/IkQ==:117 a=O4HnXJxpn4bBnFCb4s/IkQ==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=ugkhXdxtAAAA:8 a=ybZZDoGAAAAA:8
 a=LQDpmIiWPjPu_Gdqv8oA:9 a=QEXdDO2ut3YA:10 a=Ogqv0zbYr5UA:10
 a=UBqW8vr-10gA:10 a=ZG-MjRxWnTTVGrJRUvVH:22 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Message-ID: <11dccdea-0e33-6669-9554-19f064df6010@ramsayjones.plus.com>
Date:   Sat, 14 Jan 2023 14:29:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ci: do not die on deprecated-declarations warning
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqv8l9n5fj.fsf@gitster.g>
Content-Language: en-GB
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
In-Reply-To: <xmqqv8l9n5fj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLuXWtK1OxAsnDAKM7WvKR3Q2JaaRhCZUoOdRLjy6t8E5VAD5V1nLEgxr8mkLdrTKbXQZR3MulnMHuf/dwV6n6SIVg2SqoSxV9DMej85yEsw4owi0cVM
 NlEwUMiJpEm3IuwcJQ6qci8HRfLgXnCbAn96uENvdXd/UwcF1Hca5RuY+BK5t+OCQ5hAyp29GAqGzvqRhCctdPJLHuXemn+u3Y4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 14/01/2023 03:47, Junio C Hamano wrote:
> Like a recent GitHub CI run on linux-musl [1] shows, we seem to be
> getting a bunch of errors of the form:
> 
>   Error: http.c:1002:9: 'CURLOPT_REDIR_PROTOCOLS' is deprecated:
>   since 7.85.0. Use CURLOPT_REDIR_PROTOCOLS_STR
>   [-Werror=deprecated-declarations]

Yes, on 30-Dec-2022 I updated my cygwin installation, which updated
the curl package(s) from v7.86.0 to v7.87.0, and caused my build
to fail. I had a quick look at the new 'curl.h' header file and
disabled the deprecation warnings to fix my build. I used vim to
add the following to my config.mak:

    CFLAGS += -DCURL_DISABLE_DEPRECATION

.. and then promptly forgot about it for a couple of weeks! :)

As it happens, just last night I started to look at fixing the code
to avoid the deprecated 'options'. However, if you are not interested
in doing that, I can stop looking into that. ;)

[I was probably doing it wrong anyway - I was just #ifdef-ing code
based on the curl version number, rather than setting something up
in the git-curl-compat.h header file; I haven't grokked that yet.]

> 
> For some of them, it may be reasonable to follow the deprecation
> notice and update the code, but some symbols like the above is not.
> 
> According to the release table [2], 7.85.0 that deprecates
> CURLOPT_REDIR_PROTOCOLS was released on 2022-08-31, less than a year
> ago, and according to the symbols-in-versions table [3],
> CURLOPT_REDIR_PROTOCOLS_STR was introduced in 7.85.0, so it will
> make us incompatible with anything older than a year if we rewrote
> the call as the message suggests.
> 
> Make sure that we won't break the build when -Wdeprecated-declarations
> triggers.
> 
> [1] https://github.com/git/git/actions/runs/3915509922/jobs/6693756050
> [2] https://curl.se/docs/releases.html
> [3] https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-versions
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  config.mak.dev | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/config.mak.dev b/config.mak.dev
> index 981304727c..afcffa6a04 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -69,6 +69,15 @@ DEVELOPER_CFLAGS += -Wno-missing-braces
>  endif
>  endif
>  
> +# Libraries deprecate symbols while retaining them for a long time to
> +# keep software working with both older and newer versions of them.
> +# Getting warnings does help the developers' awareness, but we cannot
> +# afford to update too aggressively.  E.g. CURLOPT_REDIR_PROTOCOLS_STR
> +# is only available in 7.85.0 that deprecates CURLOPT_REDIR_PROTOCOLS
> +# but we cannot rewrite the uses of the latter with the former until
> +# 7.85.0, which was released in August 2022, becomes ubiquitous.
> +DEVELOPER_CFLAGS += -Wno-error=deprecated-declarations
> +
>  # Old versions of clang complain about initializaing a
>  # struct-within-a-struct using just "{0}" rather than "{{0}}".  This
>  # error is considered a false-positive and not worth fixing, because

Rather than suppressing 'deprecated-declarations' globally, we could
just add '-DCURL_DISABLE_DEPRECATION' to the compilation of http.c,
http-push.c and remote-curl.c; similar to how we use target specific
rules to pass '-DCURL_DISABLE_TYPECHECK' to sparse (only) to a similar
set of files.

I haven't tried that yet (so famous last words...).

Sorry for not looking into this (and notifying the list) sooner.

ATB,
Ramsay Jones



