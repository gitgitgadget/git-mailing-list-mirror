Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1347F1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 20:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754107AbeGFUWp (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 16:22:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38743 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754036AbeGFUWp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 16:22:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id j33-v6so5250827wrj.5
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 13:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nPnEDPjlm3XtboeTlGDmyOivduMEUes6+SCLK0h2kts=;
        b=Iet4ahpRyKTS4pYpGzhjifQVnhoVS1PGNrQXeoEFPuTQoy1L0dSHLf87cLkLA0DRVZ
         mwsHOURbwZcrhnGGnRqR8vwrKBpe7x8Ll4CIVRvh0FVfLxjgbRt+aYJhFmlPYd/l3WUS
         EWiUeUrfAkyIowlrvPKpnFOBrleQPVCigq0aGkXiNfexe2I90Wqdiu8Jt8wnPSmL4x+o
         R++2OfwQCLYa28GihXgl3eC5bz9wYYw4QlJVsAqkG4LXGEY5VOOdjQmHOoRrPHRe1YKj
         +eg/OW3H1EQQ3ceIRh5whN6RLeQcYt7I8E1KyJ5XZeB1i/yMLWaAeeSJOEoJduK2Ahoc
         vAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nPnEDPjlm3XtboeTlGDmyOivduMEUes6+SCLK0h2kts=;
        b=B3N44LfjiB+WNrppISPyz7dlNf0X3GgTfgjyb+Gj5silpFZRElYftXewhUZ3mNeNUO
         2NLunj18zWSF+dcOzTYmpNeEfnEFOdcIdR8dNBb2TszMBTjJC9kwQGguzNPO9iUB+ILX
         vhz75kiD2Nmpn167Uri91wXxHMi0MRiNJtMn23ofYJN4lUWKEwFVP+S3BPuJAbwQtnQQ
         xKev6mOTSc97zxJTVYe+3/SY7gu4qNuFtfZoJyQIn9RMFCwP0XhhYGmqyPO58bQ1szPX
         J/ihzPZvVRR/RhhWpTjYaIyQYnQUBpXX0CRAUnEzn8gJH2umiBY/pt0FnlRr1jRJxlZA
         o7Zg==
X-Gm-Message-State: APt69E1WoT3LkZtf5pNm2Q/fI6Wy9wuyp9batLmROZHhEm1jMIWI/jul
        chCpcFbzIlEJ6/i+D1khafQ=
X-Google-Smtp-Source: AAOMgpdulq9MW8cNZ9JoHkyZjkQOiadmiAi8wpFO1/EN6phdfCT9+gm09dRTOeGceuiZhvFCMyy+aQ==
X-Received: by 2002:adf:a792:: with SMTP id j18-v6mr8960806wrc.187.1530908563796;
        Fri, 06 Jul 2018 13:22:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f2-v6sm9771755wre.16.2018.07.06.13.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 13:22:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Ben Toews <mastahyeti@gmail.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 6/8] gpg-interface: do not hardcode the key string len anymore
References: <cover.1530616446.git.henning.schild@siemens.com>
        <cover.1530616446.git.henning.schild@siemens.com>
        <0d83d4d5c1c90011db90947d767ea0191a7ecbd7.1530616446.git.henning.schild@siemens.com>
Date:   Fri, 06 Jul 2018 13:22:42 -0700
In-Reply-To: <0d83d4d5c1c90011db90947d767ea0191a7ecbd7.1530616446.git.henning.schild@siemens.com>
        (Henning Schild's message of "Tue, 3 Jul 2018 14:38:18 +0200")
Message-ID: <xmqqbmbkjer1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Schild <henning.schild@siemens.com> writes:

> gnupg does print the keyid followed by a space and the signer comes
> next. The same pattern is also used in gpgsm, but there the key length
> would be 40 instead of 16. Instead of hardcoding the expected length,
> find the first space and calculate it.
>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  gpg-interface.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>

Nicely explained and nicely implemented.

> diff --git a/gpg-interface.c b/gpg-interface.c
> index cd3b1b568..aa747278e 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -88,10 +88,11 @@ static void parse_gpg_output(struct signature_check *sigc)
>  		sigc->result = sigcheck_gpg_status[i].result;
>  		/* The trust messages are not followed by key/signer information */
>  		if (sigc->result != 'U') {
> -			sigc->key = xmemdupz(found, 16);
> +			next = strchrnul(found, ' ');
> +			sigc->key = xmemdupz(found, next - found);
>  			/* The ERRSIG message is not followed by signer information */
>  			if (sigc-> result != 'E') {
> -				found += 17;
> +				found = next + 1;
>  				next = strchrnul(found, '\n');
>  				sigc->signer = xmemdupz(found, next - found);
>  			}
