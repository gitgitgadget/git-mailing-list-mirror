Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2221F453
	for <e@80x24.org>; Thu, 25 Oct 2018 04:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeJYN1o (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 09:27:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40605 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeJYN1o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 09:27:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id b203-v6so73738wme.5
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 21:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HJYQGug7EwCASvIUEmag+2KcsFqrw369fGjOJmYe5aA=;
        b=gEmavFDeRNWwvTwrRsXmzRGvtzjYUF8zfk10EDO46Tj5twYl9MJQovMIj+Lk3UzpPR
         eYwMYO0JaOl1C3p6gpyShKew3MekFac6/nk8EzZ78X2Y8fayawz1Ov8aof4FsY811skX
         l0uXJ+JalzTK59BKwVLEuwV+3Q14whmNG7avDFM5DMp6r5gIaWgMbVWM2oS+bCfQeRw0
         UI/AEd4jblhyNV0NBX60aXTyH8sHlyjsTI60mhmyi3DZPu3qMsQFN2aYp9naZfUBL5/m
         Hah7YHuozeXHDGpE1AR+nEin3FsBC30W1MyQoJrWgiXrXu+4XSjpbMrBDKo4L83JS4cL
         61BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HJYQGug7EwCASvIUEmag+2KcsFqrw369fGjOJmYe5aA=;
        b=p6MJR/FupTI0nY5megk2cr/o5awvXHZNxHOoA1/DeGDnbETfUp9h2PoZ5hKwGBEDCp
         8ORth9pfuSDfCbAn+APzE8lOYLNoxfdny1JWLW0JZOmf4zRyAv9msSmoGtUihdZNqpeg
         R43MGNTtFaOW4nKwzgk3CAhk5xu8d/JdAt36zppBxOiniFP7EBeNta71aaES+DO0EhNj
         zDZ0M9P0zWQ4RJOxsJUhD4deFqFefJnIS2FKyvUBAP/eWGd57otIiC1/jp27f4HqUSRh
         7LFdcc4qgVzaJ2qZ4KIu5S0zh/DXmHZW6dcRNrPE/8nb2TQjoKYsisWNecwBNVeGB6ia
         NPjQ==
X-Gm-Message-State: AGRZ1gKrtSGkukpbcNL8n/ZYG52zKPjjikdp7TyxswE9UzmqrFc82jkZ
        9SSsAWqiwxetPiOM8xWLvvM=
X-Google-Smtp-Source: AJdET5dy4BxTpcy/BTZ5xSDHrNQxyb7lmY3QXVd6R8Gnpyct7ImH9PaP+cAe1fJjPQQDyqTHU6fjew==
X-Received: by 2002:a1c:7a0a:: with SMTP id v10-v6mr113802wmc.41.1540443401566;
        Wed, 24 Oct 2018 21:56:41 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 4-v6sm2414529wrk.52.2018.10.24.21.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 21:56:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        benpeart@microsoft.com, peff@peff.net, sunshine@sunshineco.com
Subject: Re: [PATCH v4 2/3] reset: add new reset.quiet config setting
References: <20181017164021.15204-1-peartben@gmail.com>
        <20181023190423.5772-1-peartben@gmail.com>
        <20181023190423.5772-3-peartben@gmail.com>
        <3c31d5c3-df46-69e3-c138-30a93d9b3ce4@ramsayjones.plus.com>
Date:   Thu, 25 Oct 2018 13:56:39 +0900
In-Reply-To: <3c31d5c3-df46-69e3-c138-30a93d9b3ce4@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 24 Oct 2018 01:39:32 +0100")
Message-ID: <xmqqpnvyk4jc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index f6f4c21a54..a2d1b8b116 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -2728,6 +2728,9 @@ rerere.enabled::
>>  	`$GIT_DIR`, e.g. if "rerere" was previously used in the
>>  	repository.
>>  
>> +reset.quiet::
>> +	When set to true, 'git reset' will default to the '--quiet' option.
>
> Mention that this 'Defaults to false'?

Perhaps.

>>  -q::
>>  --quiet::
>> -	Be quiet, only report errors.
>> +--no-quiet::
>> +	Be quiet, only report errors. The default behavior is set by the
>> +	`reset.quiet` config option. `--quiet` and `--no-quiet` will
>> +	override the default behavior.
>
> Better than last time, but how about something like:
>
>  -q::
>  --quiet::
>  --no-quiet::
>       Be quiet, only report errors. The default behaviour of the
>       command, which is to not be quiet, can be specified by the
>       `reset.quiet` configuration variable. The `--quiet` and
>       `--no-quiet` options can be used to override any configured
>       default.
>
> Hmm, I am not sure that is any better! :-D

To be honest, I find the second sentence in your rewrite even more
confusing.  It reads as if `reset.quiet` configuration variable 
can be used to restore the "show what is yet to be added"
behaviour, due to the parenthetical mention of the default behaviour
without any configuration.

	The command reports what is yet to be added to the index
	after `reset` by default.  It can be made to only report
	errors with the `--quiet` option, or setting `reset.quiet`
	configuration variable to `true` (the latter can be
	overriden with `--no-quiet`).

That may not be much better, though X-<.
