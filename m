Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D7951F597
	for <e@80x24.org>; Tue, 17 Jul 2018 20:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeGQVbK (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 17:31:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54470 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbeGQVbK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 17:31:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so662704wmb.4
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 13:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wjqIghARRFmAT95OmxB56dDrXMlk7ol20OzjWqbt6DE=;
        b=O6noHKcmSdkyPnaMFYOSjQJZizUFBzJZ9sjm5bVv3EE5bmnAzLedGnEY1212YwWSPI
         QV4FBlGZ0sdqzfqmE1rAx56ne9MVQuwaPaKCR9M5n2bzh1bbYPIz/nTx0hvkjHA2PMbD
         w6JFq4l8xrPTkc9YFo1s02omKze7IxMvmFg/pOV1oHjrjZLFyvSeHnoxw1f6JCEdhwIO
         DjyY5sHWj0peqhdLjkrsR+5iuItYdbkl2KLfrbISwFGLt6bZVarnotxbJyiivTX7x1Ax
         wH35hiRUwFm10+pccaCxQnj+jvwIxTFRWRK2WIatOeGFch7PEngZ0R0JMtDfgoA7OfyY
         c26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wjqIghARRFmAT95OmxB56dDrXMlk7ol20OzjWqbt6DE=;
        b=jf7eox0b3Kro9MYqQzv4kRliJv+MafEWOuk3mA7aQJJEbg3QG8eIqAc5EYnygDPAPH
         GWV8AI3GibT/4tvgrcPREo1Ai/NZ6AutreDAgvkgd9xgLI+uROklSlu1FYBnqkXg8tMS
         kCMMkMQr9gMQtqsgQAIXyBUiF+iE25loXsb1af9QI+j9J5WAD6op3tEctjxVbIxQ8dBM
         vaCJfLkR+lcv9ELWP+fxqDN9+I6EC02NetNt8qU3IAZTcZggTRSSqPwozdtlPT4YhyZg
         7TDZzXpmzdpxS9SoBBwKHx5tNusk69z9zKPdQUfqlsZrIG4kjrzSB3nH1xHm+PXgHdLj
         jt1g==
X-Gm-Message-State: AOUpUlH8SBf1Py+XBUeXVQ8bSQ7hJiOOB6gSWjeTkX6qlb0VdgtCqQvZ
        vsDKPtKNtVkQjj0EkIiOdh4=
X-Google-Smtp-Source: AAOMgpco7DIc12HPWEt/4JG9jLZ1s+Ub/hM6v2tN0Hb815+asc72vM3nUV4dLuHqMcapPcD4LE6Ezw==
X-Received: by 2002:a1c:b915:: with SMTP id j21-v6mr2402296wmf.104.1531861002767;
        Tue, 17 Jul 2018 13:56:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r125-v6sm986087wmb.27.2018.07.17.13.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 13:56:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 4/7] gpg-interface: do not hardcode the key string len anymore
References: <cover.1531831244.git.henning.schild@siemens.com>
        <cover.1531831244.git.henning.schild@siemens.com>
        <8330bd5b90aec511e20d21cd0c466752e4ada4b1.1531831244.git.henning.schild@siemens.com>
Date:   Tue, 17 Jul 2018 13:56:41 -0700
In-Reply-To: <8330bd5b90aec511e20d21cd0c466752e4ada4b1.1531831244.git.henning.schild@siemens.com>
        (Henning Schild's message of "Tue, 17 Jul 2018 14:50:10 +0200")
Message-ID: <xmqqwottmvhy.fsf@gitster-ct.c.googlers.com>
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
> Input that does not match the expected format will be ignored now,
> before we jumped to found+17 which might have been behind the end of an
> unexpected string.
>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  gpg-interface.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Again, really nice.

>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index a02db7658..51cad9081 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -95,10 +95,11 @@ static void parse_gpg_output(struct signature_check *sigc)
>  		sigc->result = sigcheck_gpg_status[i].result;
>  		/* The trust messages are not followed by key/signer information */
>  		if (sigc->result != 'U') {
> -			sigc->key = xmemdupz(found, 16);
> +			next = strchrnul(found, ' ');
> +			sigc->key = xmemdupz(found, next - found);
>  			/* The ERRSIG message is not followed by signer information */
> -			if (sigc-> result != 'E') {
> -				found += 17;
> +			if (*next && sigc-> result != 'E') {
> +				found = next + 1;
>  				next = strchrnul(found, '\n');
>  				sigc->signer = xmemdupz(found, next - found);
>  			}
