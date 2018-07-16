Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8EC1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 20:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbeGPUnh (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 16:43:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36317 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbeGPUnh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 16:43:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id s14-v6so17122637wmc.1
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 13:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VJt0mRXVKgaOiJ0CLKE6A2v3rVkvpmotc6+9tWRRTeU=;
        b=GjzNd1N49as/cvQ8bq5nw5TWV6N56etHen9Tz/+gyrwmNfTtE7Iowo3ldo0qm9BCek
         v4f2PPp6y/7rsavOSY8caKlDBnr6neMmj8TWiPLqyb8Uj/Vp2tYwpHILPP2iPBTiNEtK
         3ZZL6woSUHuAAjI0qe/Z5gwQCu/FJaJ1JE8V2vG9EzPw25y7HyYUANKtkuXj2dVBA8kZ
         7DTukWpUJET1f11y3V/iH8ku9HIawfmVA8bbN5fB8yxupC6WyhlrKXsaku4hWKvhZZVO
         VN7OZV0vOoV1Ch2azwfzfjl5aEN7jLhCUAmwS9ATJH4325KYKl0OTZ73Zuq7jh/oLPNR
         olrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VJt0mRXVKgaOiJ0CLKE6A2v3rVkvpmotc6+9tWRRTeU=;
        b=UwgBuD7m7dBF7IXJFavcCLxfgNJ969SDYod6t4jYwWu5WiAqKFta+3q7HJyktEFQrd
         jcdiZS3NTYnkKmqMTvEE+N7i+mDuFELTfMnHYHHfdbbvhYWyZd1CYWWVhGQuvL+MPw47
         ka1aRFR9+aR8OVoNzJHQRdyAyBbD62dSM+La1/OzCan0E4VMgrQXUFfrAXfw/cIgA0Y/
         4alBwBRaAwbZqkyywNSThxumTSyiI0RlWZCkI8N6+IBLnJs8fL3pn7hbmMhm0rsbM838
         BMEoLAx81jUjlgw9ez5YuYp4I+ac/In+EowMp1SymDi0N0jAG8WryxFNg8GsUcXiQcQf
         Mt1Q==
X-Gm-Message-State: AOUpUlGvnyt9gSLZpbnAPh0e8Ae+UKWHpzpXvLgafcVKmMOoMdFg7T1x
        tcEOwmSm0rIq9BfZ+0ZfBeo=
X-Google-Smtp-Source: AAOMgpex/BbEXJoM87T+O/O3be2vorLsa9PNr7RNxD79fH/647ht8anDMI4tOBrA0qFphPK9/pK0Rg==
X-Received: by 2002:a1c:f906:: with SMTP id x6-v6mr10689051wmh.63.1531772075761;
        Mon, 16 Jul 2018 13:14:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w9-v6sm13328395wrk.28.2018.07.16.13.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 13:14:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 1/7] gpg-interface: add new config to select how to sign a commit
References: <cover.1531470729.git.henning.schild@siemens.com>
        <cover.1531470729.git.henning.schild@siemens.com>
        <5e88da5eac1e1aea8a946960d455ba321e3e42b1.1531470729.git.henning.schild@siemens.com>
Date:   Mon, 16 Jul 2018 13:14:34 -0700
In-Reply-To: <5e88da5eac1e1aea8a946960d455ba321e3e42b1.1531470729.git.henning.schild@siemens.com>
        (Henning Schild's message of "Fri, 13 Jul 2018 10:41:23 +0200")
Message-ID: <xmqqh8kzszth.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Schild <henning.schild@siemens.com> writes:

> Add "gpg.format" where the user can specify which type of signature to
> use for commits. At the moment only "openpgp" is supported and the value is
> not even used. This commit prepares for a new types of signatures.
>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  Documentation/config.txt | 4 ++++
>  gpg-interface.c          | 7 +++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1cc18a828..ac373e3f4 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1828,6 +1828,10 @@ gpg.program::
>  	signed, and the program is expected to send the result to its
>  	standard output.
>  
> +gpg.format::
> +	Specifies which key format to use when signing with `--gpg-sign`.
> +	Default is "openpgp", that is also the only supported value.
> +
>  gui.commitMsgWidth::
>  	Defines how wide the commit message window is in the
>  	linkgit:git-gui[1]. "75" is the default.
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 09ddfbc26..960c40086 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -7,6 +7,7 @@
>  #include "tempfile.h"
>  
>  static char *configured_signing_key;
> +static const char *gpg_format = "openpgp";
>  static const char *gpg_program = "gpg";
>  
>  #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
> @@ -138,6 +139,12 @@ int git_gpg_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "gpg.format")) {
> +		if (value && strcasecmp(value, "openpgp"))
> +			return error("malformed value for %s: %s", var, value);
> +		return git_config_string(&gpg_format, var, value);

I may be mistaken (sorry, I read so many topics X-<) but I think the
consensus was to accept only "openpgp" so that we can ensure that

	[gpg "openpgp"] program = foo

etc. can be parsed more naturally without having to manually special
case the subsection name to be case insensitive.  In other words,
strcasecmp() should just be strcmp().  Otherwise, people would get a
wrong expectation that

	[gpg] format = OpenPGP
	[gpg "openpgp"] program = foo

should refer to the same and single OpenPGP, but that would violate
the usual configuration syntax rules.

The structure of checking the error looks quite suboptimal even when
we initially support the single "openpgp" at this step.  I would
have expected you to be writing the above like so:

	if (!value)
		return config_error_nonbool(var);
	if (strcmp(value, "openpgp"))
		return error("unsupported value for %s: %s", var, value);
	return git_config_string(...);

That would make it more clear that the variable is "nonbool", which
does not change across additional support for new formats in later
steps.

> +	}
> +
>  	if (!strcmp(var, "gpg.program")) {
>  		if (!value)
>  			return config_error_nonbool(var);
