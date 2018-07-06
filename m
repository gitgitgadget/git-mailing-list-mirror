Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B6A51F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 20:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933891AbeGFUe5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 16:34:57 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:34343 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932884AbeGFUe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 16:34:56 -0400
Received: by mail-wr1-f46.google.com with SMTP id c13-v6so5233578wrt.1
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HDYW5jYAYD6GaGY95ECe4RKoWecCJ5AOoOqoqLOn4j8=;
        b=tEeIKDmJSrPVRKNbyc/elnnSCrZcqOkLZ8ksIScXw4Nrq/SphVcO0n0RLvH9GGqdxP
         24d8b+MjZSipluxmLulHTJJAxeQi1u9I1uz2EQXWg+4MQMeRkeXqMyErzpByVHf+rwjx
         KRmX60sh7DSpYABdQfTeizkGk6Jyt63T4ESiqo8TlFEGRcm2Uqaez32rYtHQUwQFOydp
         ZYehK9g+0vhNLAN+HCEbxO8UWd/f+1qMRFDCP3ZQhe3Xrp8JYeKKcGMBK6bFE2OwRlgw
         sZSTF3ggIEON18R7BLRdET3dsqXbYyWvsjxh8P6Qf0yq3RCMhXDb8NRzH6s79LV6L+4e
         SqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HDYW5jYAYD6GaGY95ECe4RKoWecCJ5AOoOqoqLOn4j8=;
        b=TdhSgRFTR/5LLTtcY6afIg7S8ela+VPaeO5ibeh7po9nKdGmM98C7mPLT/1ek8+HsG
         Pu7FMapctNHf9xjtZ002oh5ej+LWIOP0i0LWSm3H8ZVZ5AyB1RkVWTvM8eRUkCmvHHcw
         3pG0qzTV2h54odz49sJlI5IokMz+Zb5W7YZEce2mdMJ/nyNGSBH0tBOmLAP9ySjp4Jng
         wPKjqffvK4hPOF2lKI820GeL+O9lJPI1x6hDZIYEt03AQYmfNo2n4S6tbuFOGytTLswj
         490s7yjlPtnf3/iH+iaQMqx0LxB1SWkMiiwtQ0iLkEh82aCafxi0TRY7bJcy2tbxPXT9
         mydg==
X-Gm-Message-State: APt69E0LtKQQjr97vDuGlORHAdiVjXB978eX1bpXHezeQ6fLZ1zxpepT
        ytW7vF+8mb5lSr/01RyGKGs=
X-Google-Smtp-Source: AAOMgpffvLX5SjN+py2ehjWfpC8wYkc+90NH3jbOISfmBLR6vPiCd4kzbJA5BOG6qbd08aYra1byBg==
X-Received: by 2002:adf:8877:: with SMTP id e52-v6mr9210576wre.30.1530909294630;
        Fri, 06 Jul 2018 13:34:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v15-v6sm7921432wrq.37.2018.07.06.13.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 13:34:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Ben Toews <mastahyeti@gmail.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 7/8] gpg-interface: introduce new signature format "X509" using gpgsm
References: <cover.1530616446.git.henning.schild@siemens.com>
        <cover.1530616446.git.henning.schild@siemens.com>
        <1f99ef66bc5e115ec06a3c456658ad54ce405ce3.1530616446.git.henning.schild@siemens.com>
Date:   Fri, 06 Jul 2018 13:34:53 -0700
In-Reply-To: <1f99ef66bc5e115ec06a3c456658ad54ce405ce3.1530616446.git.henning.schild@siemens.com>
        (Henning Schild's message of "Tue, 3 Jul 2018 14:38:19 +0200")
Message-ID: <xmqq7em8je6q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Schild <henning.schild@siemens.com> writes:

> -enum gpgformats { PGP_FMT };
> +enum gpgformats { PGP_FMT, X509_FMT };
>  struct gpg_format_data gpg_formats[] = {
>  	{ .format = "PGP", .program = "gpg",
>  	  .extra_args_verify = { "--keyid-format=long", },
>  	  .sigs = { PGP_SIGNATURE, PGP_MESSAGE, },
>  	},
> +	{ .format = "X509", .program = "gpgsm",
> +	  .extra_args_verify = { NULL },
> +	  .sigs = {X509_SIGNATURE, NULL, }

Missing SP between "{X" is a bit irritating.

Also the trailing comma (the issue is shared with the PGP side) when
the initializer is smashed on a single line feels pretty much
pointless.  If it were multi-line, then such a trailing comma would 
help future developers to add a new entry, i.e.

	 .sigs = { 
	 	PGP_SIGNATURE,
	 	PGP_MESSAGE,
	+	PGP_SOMETHING_NEW,
	 }

without touching the last existing entry.  But on a single line?

	-.sigs = { PGP_SIGNATURE, PGP_MESSAGE }
	+.sigs = { PGP_SIGNATURE, PGP_MESSAGE, PGP_SOMETHING_NEW }

is probably prettier without such a trailing comma.

> @@ -190,6 +195,9 @@ int git_gpg_config(const char *var, const char *value, void *cb)
>  	if (!strcmp(var, "gpg.program"))
>  		return git_config_string(&gpg_formats[PGP_FMT].program, var,
>  					 value);
> +	if (!strcmp(var, "gpg.programX509"))
> +		return git_config_string(&gpg_formats[X509_FMT].program, var,
> +					 value);

This is a git_config() callback, isn't it?  A two-level variable
name is given to a callback after downcasing, so nothing will match
"gpg.programX509", I suspect.  I see Brian already commented on the
name and the better organization being

 - gpg.format defines 'openpgp' or whatever other values;
 - gpg.<format>.program defines the actual program

where <format> is the value gpg.format would take
(e.g. "gpg.openpgp.program = gnupg").  And I agree with these
suggestions.



