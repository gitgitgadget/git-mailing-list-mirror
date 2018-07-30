Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E4B61F597
	for <e@80x24.org>; Mon, 30 Jul 2018 22:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbeG3XtF (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 19:49:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45125 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeG3XtE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 19:49:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id f12-v6so4554015wrv.12
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 15:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LIUqYDMGRixoMWLwjASGiebpaNpFV/K9h0dhnwMw068=;
        b=E0xlYQBRPyhgqFPZ2cB+CT/GNOc48InYVzdYG2eEjwlNaCogYICYsYsmk+E8QMNlwD
         IpFlMrDhL7Q5hPxGCC+oHRIszZHUiwsn+EVN4J/RGBQbib0ekYZoToFHrt7lYo7z3wKG
         QnIoivRX02wBOa/kgtP3O1KV8XW+0CwHXXk5fxck3dsEiPTsaNMFQFdUNFMnJrf322PQ
         vlG9mkz9RGEf88NchFi2aa9qXx95QO4HzWll6AI++L3zQloM/CHwW6LoBZQ3vbFiLTuC
         Z8Gby84h4Ya6q9GWQ/gqZl3gP89gQDn39QHlFDIHJy313636KopmzWrvv1NwL0piRq+U
         eg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LIUqYDMGRixoMWLwjASGiebpaNpFV/K9h0dhnwMw068=;
        b=A58OfnvAYSwVckV05lr3WrQm8T1ub+u+gH7DFTIivpO3mAzkeRmJeFe28cgdBcdrxf
         Vdvj4g+GjqT1cpTP/dLgIOG/O+jdCfOSVecCEkJj2KuwJ04wcNTmwo37aeNvosrrHvfp
         AU19+keY7jIt1akACKtGP7BbvqTRDUDwcBlOq0ltc2MuJXxB4dGSsmJtyRiV+BqlGP+e
         Gbuh+QrbqLP4CHQdwiOYCkQp/NsqJSHMuX2gqgXvFW+68/1DH1wkgDMB//V1nKObqaMz
         VMB1Kh2MfTavKitO3Ph/46A+kRVg8HB6RwOuAkquGlaFPamAwAGfRw88buVgsKRMvD/u
         U7KQ==
X-Gm-Message-State: AOUpUlHLUdT3uE/hpTDuBwcqmLIek2/zcQvvp9tIdoFJzWY/huunt3R6
        elTHfDdRlx+tJN9Al4BSMqswxAY5
X-Google-Smtp-Source: AAOMgpeIfhtGYqSxIxTu9RKG+zUBOL22qbEG/BeoV3/VULA/YpcWBaNT1sNxS9IIrRWOjUROkzAr7A==
X-Received: by 2002:adf:c4a7:: with SMTP id m36-v6mr19270762wrf.103.1532988720976;
        Mon, 30 Jul 2018 15:12:00 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-67-118.w92-136.abo.wanadoo.fr. [92.136.29.118])
        by smtp.gmail.com with ESMTPSA id a11-v6sm14281100wrr.81.2018.07.30.15.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 15:11:59 -0700 (PDT)
Subject: Re: [GSoC][PATCH v4 15/20] rebase -i: rewrite write_basic_state() in
 C
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com
References: <20180710121557.6698-1-alban.gruin@gmail.com>
 <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180724163221.15201-16-alban.gruin@gmail.com>
 <20180730182516.32644-1-szeder.dev@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <615c2b9d-7a1b-7678-4173-7eb3db193296@gmail.com>
Date:   Tue, 31 Jul 2018 00:11:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180730182516.32644-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Le 30/07/2018 à 20:25, SZEDER Gábor a écrit :
>> diff --git a/sequencer.c b/sequencer.c
>> index 1c035ceec7..d257903db0 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
> 
>> +int write_basic_state(struct replay_opts *opts, const char *head_name,
>> +		      const char *onto, const char *orig_head)
>> +{
>> +	const char *quiet = getenv("GIT_QUIET");
>> +
>> +	if (head_name)
>> +		write_file(rebase_path_head_name(), "%s\n", head_name);
>> +	if (onto)
>> +		write_file(rebase_path_onto(), "%s\n", onto);
>> +	if (orig_head)
>> +		write_file(rebase_path_orig_head(), "%s\n", orig_head);
>> +
>> +	if (quiet)
>> +		write_file(rebase_path_quiet(), "%s\n", quiet);
>> +	else
>> +		write_file(rebase_path_quiet(), "");
> 
> This is not a faithful conversion of the original.  git-rebase.sh writes
> this 'quiet' file with:
> 
>   echo "$GIT_QUIET" > "$state_dir"/quiet
> 
> which means that a single newline character was written even when
> $GIT_QUIET was unset/empty.
> 
> I seem to recall a case in the past, when a shell-to-C conversion
> accidentally dropped a newline from a similar state-file, which then
> caused some issues later on.  But I don't remember the specifics and a
> quick search didn't turn up anything relevant either...
> 

I don’t think it’s a problem here, but we’re better safe than sorry.
I’ll send a fix soon.

Cheers,
Alban

