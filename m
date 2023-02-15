Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E284BC636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 23:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBOXfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 18:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBOXfF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 18:35:05 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CACD4345F
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 15:35:03 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id v17so467296qto.3
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 15:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676504102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mT1y/mqFH6rGsi2zJHnFBGyUp2fEiiFQPjFKfrVJm+g=;
        b=Jo5HX6kM30dU0KtDYZWauYmN+ctQIrwNcCbFOclCcEm/plsc+YJwq8/1r9YoNBXf9q
         7h9lWrL7LUwfiLeamk4aLFLzd6sDDfhEenJ+2ogJDk4I1UGf6gmMlIctX6wFifXoj+nO
         pYlgLep2tMNjR/ZRwFgGMiBQbuOWubVB1LYjma4is4yJ3S55bojL8nWoMOXxqD3XvrFD
         dGW8Izgz9c0Uusb4cciRbcIRsVXOV9uu0tJj8137isTU5SCAOvFinucsW6BsUvLL5rk8
         rmcVY/PwtAtbuGsVSj2yzsegLlH1TbilhjHajofEfspqaiHyqKJwGVhyuzfpvbHwAHWz
         /JCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676504102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mT1y/mqFH6rGsi2zJHnFBGyUp2fEiiFQPjFKfrVJm+g=;
        b=qZ7xHQ3Gnwwgofjqo3pggW1iilhQu5smFcV0CHvo3hHJrOWp21UAPrj76pFWXAU/4y
         W7joFPSwRPAQhHYNi/9/fA9ABuykmFVPxx2PaaboXh4Rx+cJqnC1MGfFkXo1WqDuPDZE
         Kn7QBH5cNi2lhEsfxKysZtMLKBAkhBoD34jSR4zuAT43AQitI/qpY2LN4sjVHECsaMQ8
         2G+5/t3pKv7mjOcuJSY90lw41xipbvK3f2K/Z/AeXf98sKsMtZfuZIJGeeDXeboYwn1F
         pBivKCOFvpjGVZXeHjpjN1BMXBYVqG4rypccqgWrjVkHIdSzEAGqVcLp1bzvr/NjC+gs
         Cy/g==
X-Gm-Message-State: AO0yUKWUFRQ8dsNHoXaPwgG9HjoxQisNTdmMnf0s2NIcKmzFl7msrcrU
        FaX1D06nNvTgnb7t4BumRhY=
X-Google-Smtp-Source: AK7set94lq/NafnPNbXPzad5cw9d3bajLgYpr8urg3l53vQE7BavPz5K31kMOCOT/bi1jjhEAgyhAQ==
X-Received: by 2002:ac8:5951:0:b0:3bb:8f8e:ab72 with SMTP id 17-20020ac85951000000b003bb8f8eab72mr6752604qtz.0.1676504102550;
        Wed, 15 Feb 2023 15:35:02 -0800 (PST)
Received: from [192.168.1.211] ([2600:4041:4542:c100:adac:8edf:a685:50])
        by smtp.gmail.com with ESMTPSA id d64-20020a376843000000b0073b4d8cb4a5sm29557qkc.60.2023.02.15.15.35.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Feb 2023 15:35:01 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] diff: consolidate diff algorithm option parsing
Date:   Wed, 15 Feb 2023 18:34:59 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <AAC53EE0-91F5-4A74-AB26-5F3F8B680CDE@gmail.com>
In-Reply-To: <xmqqk00j3b6r.fsf@gitster.g>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
 <0c5e1fc6c2651e39bcefa27ee0976c9519671969.1676410819.git.gitgitgadget@gmail.com>
 <xmqqk00j3b6r.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 14 Feb 2023, at 21:38, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> The diff option parsing for --minimal, --patience, --histgoram can all=

>> be consolidated into one function. This is a preparatory step for the
>> subsequent commit which teaches diff to keep track of whether or not a=

>> diff algorithm has been set via the command line.
>
> Everybody other than patience used to be just a bit-op but now
> everybody is a callback?
>
>> diff --git a/diff.c b/diff.c
>> index 329eebf16a0..92a0eab942e 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -3437,6 +3437,22 @@ static int diff_filepair_is_phoney(struct diff_=
filespec *one,
>>  	return !DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two);
>>  }
>>
>> +static int set_diff_algorithm(struct diff_options *opts,
>> +			      const char *alg)
>> +{
>> +	long value =3D parse_algorithm_value(alg);
>> +
>> +	if (value < 0)
>> +		return 1;
>> +
>> +	/* clear out previous settings */
>> +	DIFF_XDL_CLR(opts, NEED_MINIMAL);
>> +	opts->xdl_opts &=3D ~XDF_DIFF_ALGORITHM_MASK;
>> +	opts->xdl_opts |=3D value;
>> +
>> +	return 0;
>> +}
>
> The above is a faithful copy of diff_opt_diff_algorithm(), except
> that it returns 1 (not -1) on failure, which is unexpected in this
> codebase, and should be corrected if this patch gets rerolled.
>
>>  static void builtin_diff(const char *name_a,
>>  			 const char *name_b,
>>  			 struct diff_filespec *one,
>> @@ -5107,17 +5123,40 @@ static int diff_opt_diff_algorithm(const struc=
t option *opt,
>>  				   const char *arg, int unset)
>>  {
>>  	struct diff_options *options =3D opt->value;
>> -	long value =3D parse_algorithm_value(arg);
>>
>>  	BUG_ON_OPT_NEG(unset);
>> -	if (value < 0)
>> +
>> +	if (set_diff_algorithm(options, arg))
>>  		return error(_("option diff-algorithm accepts \"myers\", "
>>  			       "\"minimal\", \"patience\" and \"histogram\""));
>>
>> -	/* clear out previous settings */
>> -	DIFF_XDL_CLR(options, NEED_MINIMAL);
>> -	options->xdl_opts &=3D ~XDF_DIFF_ALGORITHM_MASK;
>> -	options->xdl_opts |=3D value;
>> +	return 0;
>> +}
>
> This version of diff_opt_diff_algorithm() behaves identically from
> the version before this patch, which is excellent.
>
>> +static int diff_opt_diff_algorithm_no_arg(const struct option *opt,
>> +				   const char *arg, int unset)
>> +{
>> +	struct diff_options *options =3D opt->value;
>> +
>> +	BUG_ON_OPT_NEG(unset);
>> +	BUG_ON_OPT_ARG(arg);
>> +
>> +	if (!strcmp(opt->long_name, "patience")) {
>> +		size_t i;
>> +		/*
>> +		 * Both --patience and --anchored use PATIENCE_DIFF
>> +		 * internally, so remove any anchors previously
>> +		 * specified.
>> +		 */
>> +		for (i =3D 0; i < options->anchors_nr; i++)
>> +			free(options->anchors[i]);
>> +		options->anchors_nr =3D 0;
>> +	}
>> +
>> +	if (set_diff_algorithm(options, opt->long_name))
>> +		BUG("available diff algorithms include \"myers\", "
>> +			       "\"minimal\", \"patience\" and \"histogram\"");
>> +
>>  	return 0;
>>  }
>
> Calling this instead of diff_opt_patience() would make "--patience"
> parsed identically as before without this patch, which is excellent.
>
>> @@ -5562,9 +5581,10 @@ struct option *add_diff_options(const struct op=
tion *opts,
>>  			    N_("prevent rename/copy detection if the number of rename/copy=
 targets exceeds given limit")),
>>
>>  		OPT_GROUP(N_("Diff algorithm options")),
>> -		OPT_BIT(0, "minimal", &options->xdl_opts,
>> -			N_("produce the smallest possible diff"),
>> -			XDF_NEED_MINIMAL),
>> +		OPT_CALLBACK_F(0, "minimal", options, NULL,
>> +			       N_("produce the smallest possible diff"),
>> +			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
>> +			       diff_opt_diff_algorithm_no_arg),
>
> I offhand cannot say that these two are equivalent, even though they
> ought to be (otherwise this patch would break things).  The callback
> seems to do much more than just a simple "flip the NEED_MINIMAL bit
> on".
>
>> -		OPT_BITOP(0, "histogram", &options->xdl_opts,
>> -			  N_("generate diff using the \"histogram diff\" algorithm"),
>> -			  XDF_HISTOGRAM_DIFF, XDF_DIFF_ALGORITHM_MASK),
>> +			       diff_opt_diff_algorithm_no_arg),
>> +		OPT_CALLBACK_F(0, "histogram", options, NULL,
>> +			       N_("generate diff using the \"histogram diff\" algorithm"),=

>> +			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
>> +			       diff_opt_diff_algorithm_no_arg),
>
> Likewise.
>
> By nature, patience (and anchored) needs to do much more than
> everybody else, so it almost feels that it is OK (and preferable,
> even) to leave it a special case to make the distinction stand out.
> Consolidating everybody else who are much simpler to share the
> more complex callback does not look like a good change to me, at
> least at the first glance.

Yeah, it's not great to pull things out from a bit flip to a callback but=
 I
needed some way of setting the xdl_opts_command_line member in the next c=
ommit
when we know that the diff algorithm was set via options on the command l=
ine so
that we can honor the precedence. If there's a different way to do that o=
ther
than using callbacks for command options parsing, I'd agree that keeping =
these
as bit flips would be ideal.

>
> Thanks.

Thanks!
John
