Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB5C31F404
	for <e@80x24.org>; Wed, 15 Aug 2018 21:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbeHPAZH (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 20:25:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43585 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeHPAZG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 20:25:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so1022156pfi.10
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 14:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eDjdB5kYI0mA1lI1STAV79ARTamFHX5ORIsnhq+ufqk=;
        b=W8lp2S/TaRqtip5be+yzy3RLSKoinqpIknUWjon0qSkcraMY6ijiA0F/LcUsr1OUpW
         14I1QCzp2aVCtXMvRTCGoQXxZljPqKjC6Wr/Om/6z7VLDO0Xj6xQfZoSAYjx0uEA9nC/
         m0Q4e/oOTqiDcdm/65eJU9EYXXbdhzvhKse4wmlvF95kPCKhNF2GCyrtA2cd9cG2+Q3u
         mud9jXQ0+FBtYBr+wRiyLVQcZIgqpxk7auwRwROJfrjP0w1g4MckSFMNBwl0BfE2MgWc
         RuNlp7Mej1lzGpbwIRotLTKwPMlJVg6eplHz4cwRtlG8LknCydGXDH0MmcM/xPJkcZw/
         vf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eDjdB5kYI0mA1lI1STAV79ARTamFHX5ORIsnhq+ufqk=;
        b=Rt3E3JsMqKDalB8vq3KBtNyTV3+/yfOi6bmRa5KbUFl3Ib8ueYc6vWTjJQ+PBdZ7RS
         SGzutYKxWlrg+wDNkKKgEL4E+Nqj0mlCS9W2uhCnruOvGyYBkfDr+vCa+WlBaOA/A2dT
         7ZiCrfUdqrCKsZUap3oZVliBpIYmrjqrZE7qFl4MukRDZL1J+hk2HNHIRelpFyWA3Fr1
         a9ZICUDjjCY8VGDT5v61uVtD69qv6WZzDElgV5K3HqDeUoSIph1bMMdjqUMNYZVlE9K3
         bJ1pT6Q+qhyGPQs5xr/rdTQwYZ5m+AWMVxrcGeIXhw865Bus0A+HpPx6CVIgkwGsgWsD
         dWJw==
X-Gm-Message-State: AOUpUlF0SjK0cB7UjtjGydjKc0D0EWi7CCjvdxUr+VBnm94SHQoVmcBH
        qk4t8sLxo5c7wU0R5Iacp4s=
X-Google-Smtp-Source: AA+uWPy4YBgDR4g8mYQHNI2e4lfdo9U/fHjC+I2lNxbNet9BKlXJx0vtxLN9UgnzymjHD44ugQER+g==
X-Received: by 2002:a63:fe4d:: with SMTP id x13-v6mr26326184pgj.152.1534368670110;
        Wed, 15 Aug 2018 14:31:10 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e14-v6sm22967848pgv.48.2018.08.15.14.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 14:31:09 -0700 (PDT)
Date:   Wed, 15 Aug 2018 14:31:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] gpg-interface.c: detect and reject multiple signatures
 on commits
Message-ID: <20180815213108.GM181377@aiede.svl.corp.google.com>
References: <xmqqbmaa9t8k.fsf@gitster-ct.c.googlers.com>
 <20180814151142.13960-1-mgorny@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180814151142.13960-1-mgorny@gentoo.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michał Górny wrote:

> GnuPG supports creating signatures consisting of multiple signature
> packets.  If such a signature is verified, it outputs all the status
> messages for each signature separately.  However, git currently does not
> account for such scenario and gets terribly confused over getting
> multiple *SIG statuses.
>
> For example, if a malicious party alters a signed commit and appends
> a new untrusted signature, git is going to ignore the original bad
> signature and report untrusted commit instead.  However, %GK and %GS
> format strings may still expand to the data corresponding
> to the original signature, potentially tricking the scripts into
> trusting the malicious commit.
>
> Given that the use of multiple signatures is quite rare, git does not
> support creating them without jumping through a few hoops, and finally
> supporting them properly would require extensive API improvement, it
> seems reasonable to just reject them at the moment.
> ---

Thanks for the clear analysis and fix.

May we have your sign-off?  See
https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html#sign-off
(or the equivalent section of your local copy of
Documentation/SubmittingPatches) for what this means.

>  gpg-interface.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 09ddfbc26..4e03aec15 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -24,21 +24,23 @@ void signature_check_clear(struct signature_check *sigc)
>  static struct {
>  	char result;
>  	const char *check;
> +	int is_status;
>  } sigcheck_gpg_status[] = {
> -	{ 'G', "\n[GNUPG:] GOODSIG " },
> -	{ 'B', "\n[GNUPG:] BADSIG " },
> -	{ 'U', "\n[GNUPG:] TRUST_NEVER" },
> -	{ 'U', "\n[GNUPG:] TRUST_UNDEFINED" },
> -	{ 'E', "\n[GNUPG:] ERRSIG "},
> -	{ 'X', "\n[GNUPG:] EXPSIG "},
> -	{ 'Y', "\n[GNUPG:] EXPKEYSIG "},
> -	{ 'R', "\n[GNUPG:] REVKEYSIG "},
> +	{ 'G', "\n[GNUPG:] GOODSIG ", 1 },
> +	{ 'B', "\n[GNUPG:] BADSIG ", 1 },
> +	{ 'U', "\n[GNUPG:] TRUST_NEVER", 0 },
> +	{ 'U', "\n[GNUPG:] TRUST_UNDEFINED", 0 },
> +	{ 'E', "\n[GNUPG:] ERRSIG ", 1},
> +	{ 'X', "\n[GNUPG:] EXPSIG ", 1},
> +	{ 'Y', "\n[GNUPG:] EXPKEYSIG ", 1},
> +	{ 'R', "\n[GNUPG:] REVKEYSIG ", 1},
>  };

nit: I wonder if making is_status into a flag field (like 'option' in
git.c's cmd_struct) and having an explicit SIGNATURE_STATUS value to
put there would make this easier to read.

It's not clear to me that the name is_status or SIGNATURE_STATUS
captures what this field represents.  Aren't these all sigcheck
statuses?  Can you describe briefly what distinguishes the cases where
this should be 0 versus 1?

>  
>  static void parse_gpg_output(struct signature_check *sigc)
>  {
>  	const char *buf = sigc->gpg_status;
>  	int i;
> +	int had_status = 0;
>  
>  	/* Iterate over all search strings */
>  	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
> @@ -50,6 +52,10 @@ static void parse_gpg_output(struct signature_check *sigc)
>  				continue;
>  			found += strlen(sigcheck_gpg_status[i].check);
>  		}
> +
> +		if (sigcheck_gpg_status[i].is_status)
> +			had_status++;
> +
>  		sigc->result = sigcheck_gpg_status[i].result;
>  		/* The trust messages are not followed by key/signer information */
>  		if (sigc->result != 'U') {
> @@ -62,6 +68,22 @@ static void parse_gpg_output(struct signature_check *sigc)
>  			}
>  		}
>  	}
> +
> +	/*
> +	 * GOODSIG, BADSIG etc. can occur only once for each signature.
> +	 * Therefore, if we had more than one then we're dealing with multiple
> +	 * signatures.  We don't support them currently, and they're rather
> +	 * hard to create, so something is likely fishy and we should reject
> +	 * them altogether.
> +	 */
> +	if (had_status > 1) {
> +		sigc->result = 'E';
> +		/* Clear partial data to avoid confusion */
> +		if (sigc->signer)
> +			FREE_AND_NULL(sigc->signer);
> +		if (sigc->key)
> +			FREE_AND_NULL(sigc->key);
> +	}

Makes sense to me.

>  }
>  
>  int check_signature(const char *payload, size_t plen, const char *signature,
> -- 
> 2.18.0

Can we have a test to make sure this behavior doesn't regress?  See
t/README for an overview of the test framework and "git grep -e gpg t/"
for some examples.

The result looks good.  Thanks again for writing it.

Sincerely,
Jonathan
