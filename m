Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238111F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161962AbeBNSYJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:24:09 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44302 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161820AbeBNSYG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:24:06 -0500
Received: by mail-wr0-f195.google.com with SMTP id v65so898037wrc.11
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 10:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=T9c3EeQPwCVfsApJm+qB8W310XwBipuNIkWZDh9wy2U=;
        b=o0ydD07stWNa9DQmrjT+oSr+BqjxWMEe5lpNhDgOMdVxTV0gkFldw0eFbSW76gDm/L
         R40twQMmSmU9nw7Z/+sWkClgq2kAqWLehwgwPSPrW68Z9Ig13O+rsA/lEs7z4IsIsqnt
         f00Ik1C6i64nIGSJE3FTeX346ZyLahL1HdAeXD9e1wTZ5ePB/hbX//M98iekPiZsVENC
         7J8iHHtmRiaRo1klfgAWDssyHaEEABFd0ULs3QXO4QkOEcJ8gnm+E7TuTMqMFXKB48Tt
         llkqbsddMg0n5rMpOYjdriGvN0LgeFB3UCh7njUtvbpzQbHsTnwofMDhBXyXZrPext1M
         zDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=T9c3EeQPwCVfsApJm+qB8W310XwBipuNIkWZDh9wy2U=;
        b=Qbg0zGF+t6f2risgN/wYGeDUyEeqMDGFoE43fvxb4aHt3CTxpFK/ODsJ9ZQJN2sZQF
         I5ZHvNJKdzSLYj9v9ITXbgfkgV3SYrcJ2EEsmDJtPNF9KqjyY9zzdTdxRvFlFsjyQCz0
         BRzZg+Nx3W31wAtvIdtgq8Sf/NjpiDGS1ruO/mKHfoepQB50H8khYP51EqrWs7sqK0hA
         BYjcBe27stwBfQZcmOZ4aosat3DnfMoo4YUra8flhjpVBmJii9AwOby6f/R0G06b5slZ
         ntkMmb6IGTpUWc+/PzUMLcoV3Uil0E7QRVqzmUoityiNuuOS3h6E6122tyQgoxB5ZHAd
         OFXw==
X-Gm-Message-State: APf1xPCTiAuMhyf/4bgeFuMMK6SzQkDhYDK8M1KcM7Li4weFuq6WUYbA
        P6BQ7hV1WMZ920vl2TpNs77nTg9YAZ0=
X-Google-Smtp-Source: AH8x224FbpNiG8R2p7SbJkt06OTx6Q1nsMdoafzpauK6e8r5ukFnO1tvRPjAyQDLHpiLifvplFyiNQ==
X-Received: by 10.223.153.215 with SMTP id y81mr123156wrb.144.1518632644094;
        Wed, 14 Feb 2018 10:24:04 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x190sm12828286wme.27.2018.02.14.10.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 10:24:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, doron.behar@gmail.com
Subject: Re: [PATCH 1/2] parse-options: expand $HOME on filename options
References: <20180214101019.gaenosifgq3wx2nm@NUC.localdomain>
        <20180214105149.28896-1-pclouds@gmail.com>
        <20180214140557.GA27850@sigill.intra.peff.net>
Date:   Wed, 14 Feb 2018 10:24:02 -0800
In-Reply-To: <20180214140557.GA27850@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 14 Feb 2018 09:05:58 -0500")
Message-ID: <xmqqbmgro2f1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Support $HOME expansion for all filename options. There are about seven
>> of them.
>
> I think this probably makes sense.
>
>>  parse-options.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> Should this be mentioned in the comment documenting OPT_FILENAME()?

Perhaps.  I think all mention of "$HOME expansion" should be
replaced with "tilde expansion", though.  I first thought we are
expanding any environment variable and $HOME is merely an example of
it when I read the title and the log message, before seeing that the
patch just adds a call to expand_user_path().

Other than that, looks good.  Thanks for a quick enhancement and a
review.

>> diff --git a/parse-options.c b/parse-options.c
>> index d265a756b5..c33f14c74e 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -38,10 +38,13 @@ static int get_arg(struct parse_opt_ctx_t *p, const struct option *opt,
>>  
>>  static void fix_filename(const char *prefix, const char **file)
>>  {
>> -	if (!file || !*file || !prefix || is_absolute_path(*file)
>> -	    || !strcmp("-", *file))
>> +	if (!file || !*file || is_absolute_path(*file) ||
>> +	    !strcmp("-", *file))
>>  		return;
>> -	*file = prefix_filename(prefix, *file);
>> +	if (**file == '~')
>> +		*file = expand_user_path(*file, 0);
>> +	else if (prefix)
>> +		*file = prefix_filename(prefix, *file);
>>  }
>
> I thought at first this needed a final "else" clause, because we don't
> assign to *file if we have neither a prefix nor a user-path. But that's
> what the callers expect (and we are similarly a noop if we hit the first
> conditional). So this looks right.
>
> -Peff
