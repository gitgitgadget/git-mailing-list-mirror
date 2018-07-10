Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01341F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389064AbeGJSdw (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:33:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42006 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388082AbeGJSdv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:33:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id p1-v6so15624804wrs.9
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RzGdzKJct1W7zvh1IcUu+WUkEeql30mVhJ8bow3yXug=;
        b=mqD1k58VMU2gF6a7kmV5M6GAy55h/qiH4kUdkPTCvJSb1qyk2aB3oLwu0aSfdLrSVr
         zIeWmtkJJhd10YD4Ybj9DQj+jvciEKmt+a7HLwKD2PLqO1mI6ddpquSsfNAYOmz8HcJL
         1N2R7mQGDrQbRIQLFesX7A9FbFqvySMv5hOw0zfa6SQQeepoG2daAsCprWt2yyRO4pMh
         qrFqz332R2liyX7Y1Q0UBpTwQyPJehCSdHOaYbFfBSbnsFcWPV+RX7VDw9FF6sZOabWT
         eQXtbnd0vX8kxVvecdZIea6YTewl1e7gNGXv6FCGyXlBRqddaIMGM9H4VnwA4Awcl7PP
         PY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RzGdzKJct1W7zvh1IcUu+WUkEeql30mVhJ8bow3yXug=;
        b=a/7JqWTQQDSi5L9BWMu+dNGKMbqiiPP3FSFM4SVsJcWOFr/MZ7GXMdGK42TM3M+qqe
         36RJKkJIsBsCqdIKVz0vjtjlcyTQpKyc871y0Bl9Z1WEm/afTJH4wwFKKh6YacF5CzX/
         aLobIt9ZAUMDken5JC+0Cdjs9JNZIFoVsTLBGi71Fxqw+6dNj0oGPvSoZ4+eeveBZ6BL
         pIHkJ93x1x4bdTeNj1aLYS/aIibKngzWTlo+Q+rTbqYyjlNJ+nCNuE6DuKwNYOK0GIwa
         W/jW1nC0fOtLIgG9aTw+l+4/+XcAJ7JuF0TSmEdesiA1bwwd9TH5zuO2gWfYHqR9hKG5
         x0SQ==
X-Gm-Message-State: APt69E2IWihCsD76Wse0MOkLvMha4mqd48kLElSs6APWBaWc6/EFc6HN
        nQT4imattWp7SDVTfm68n1EwU7p8
X-Google-Smtp-Source: AAOMgpfmFvPisJ3GzMb/ronl/i+754I1xRg6WWogwyNkmpOzU4MFB8C2U6AelzBV7lxUlHZMb9xvWA==
X-Received: by 2002:adf:e887:: with SMTP id d7-v6mr19504937wrm.43.1531244424035;
        Tue, 10 Jul 2018 10:40:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s12-v6sm22996032wrf.0.2018.07.10.10.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 10:40:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Henning Schild <henning.schild@siemens.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 8/9] gpg-interface: introduce new signature format "x509" using gpgsm
References: <cover.1531208187.git.henning.schild@siemens.com>
        <4a2cf83a63d25776cb1996490240ce3e5df8ada4.1531208187.git.henning.schild@siemens.com>
        <20180710170109.GG23624@sigill.intra.peff.net>
Date:   Tue, 10 Jul 2018 10:40:22 -0700
In-Reply-To: <20180710170109.GG23624@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 10 Jul 2018 13:01:10 -0400")
Message-ID: <xmqqbmbf7zw9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> @@ -16,13 +16,18 @@ struct gpg_format_data {
>>  
>>  #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
>>  #define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
>> +#define X509_SIGNATURE "-----BEGIN SIGNED MESSAGE-----"
>>  
>> -enum gpgformats { PGP_FMT };
>> +enum gpgformats { PGP_FMT, X509_FMT };
>>  struct gpg_format_data gpg_formats[] = {
>>  	{ .format = "openpgp", .program = "gpg",
>>  	  .extra_args_verify = { "--keyid-format=long" },
>>  	  .sigs = { PGP_SIGNATURE, PGP_MESSAGE }
>>  	},
>> +	{ .format = "x509", .program = "gpgsm",
>> +	  .extra_args_verify = { NULL },
>> +	  .sigs = { X509_SIGNATURE, NULL }
>> +	},
>
> Extremely minor nit, but if there are no other uses of PGP_SIGNATURE etc
> outside of this array (as I hope there wouldn't be after this series),
> would it make more sense to just include the literals inline in the
> array definition? That's one less layer of indirection when somebody is
> reading the code.

It is good design-sense to shoot for fewer levels of indirection,
but I suspect that "'const char **' instead of maximally-sized fixed
array of strings" would require a named array and constants like
this:

	static const char *gpg_verify_args[] = {
		"--verify",
		"--status-fd=1",
		"--keyid-format=long",
		NULL
	};
	static const char *gpg_sigs[] = {
		"-----BEGIN PGP SIGNATURE-----",
		"-----BEGIN PGP MESSAGE-----",
		NULL
	};

	struct gpg_format {
		const char *name;
		const char *program;
		const char * const *verify_args;
		const char * const *sigs;
	} gpg_format[] = {
		{
			.name = "openpgp",
			.program = "gpg',
			.verify_args = gpg_verify_args,
			.sigs = gpg_sigs,
		},
		{
			...
		},
	};

so we may end up having the same number of levels of indirection
anyway in the long-term final form.

As readers may be able to read from the above, I also have a
suspicion that it is a mistake to pretend that "--verify" etc.,
which merely happen to be common across the variants the series
covers, will stay forever to be common across _all_ variants and
that is why the field no longer is called "extra" args but is meant
to contain the full args.
