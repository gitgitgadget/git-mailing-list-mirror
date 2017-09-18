Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DEF32047F
	for <e@80x24.org>; Mon, 18 Sep 2017 13:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753210AbdIRNH2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 09:07:28 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35864 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752586AbdIRNH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 09:07:27 -0400
Received: by mail-qk0-f194.google.com with SMTP id i14so276385qke.3
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 06:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/XZFtNn8LQyHinBwyn83GL7Im4Lka/fOJiQiIYKZRJo=;
        b=RioVjO9EJHQs1qDUzXzVLCoQJFrs1aTEN+A2uYZFBubX8wzIPqxG8xujTe2vVPYK4h
         dU7mnMFX2D7iAE/Lmeed2ulKIaeFzzd0ZTuw9S3fkIRKpu7wzOHhgK0EHoQGf3/SPj5S
         57YKCLOG4eO1g3NazfsT3WDtHeEnh3GqF4QgNMLzDtHr+Z1vrEM8mqKTRu5jWgirACSZ
         8wff5orTcS/JPJ9b0U8wXNAxFLLnaxnBk6W6814Xrd0vRID0JyzSeL+iZEtsh+nMAxwf
         dpwlPqQR5l/cnX5IN8Foao+2nfBI7Auzarfn/jg8lQ+TT9oSrxIOFZvtivR7zISQQ+0H
         ws7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/XZFtNn8LQyHinBwyn83GL7Im4Lka/fOJiQiIYKZRJo=;
        b=IQ4eBKqVfshM+CFh2/TbkPCP9ulqAwji7anyD7Vns1nMqgaPPeRRpJQUNbYupCwPOR
         nCx7VTVlu8b5RrB7nP1FihN0SbvjYpggvwim4UKAYYodpWa73gmZ8Mvqop5soWhHb/xl
         eiXyx7JQRGObL/ErP9Z4Bmv4T1YeIXYyKxMC51fdJSvcaWAGK8lqPZ7ojyt126I/3Bhf
         6NY9OUa+YLW5pgjn1oAlfRngR9/tcXTtkn+EHjTSaW6Px+XYxi1zje3HI0FialB1Tiax
         SM3kbqxq4y9YO7sQHiYZkfzFTlOkXqKTR8h58KfKQ4lOXmFaFhXZQ3oBjbSgmpxGHoNC
         Rg0Q==
X-Gm-Message-State: AHPjjUjKEY5msdfvDeJ5yDwZKb4BllMDjrLdE3HY8D+hXnfCU9ph4bTC
        ZLz7FpkyWxQm+A==
X-Google-Smtp-Source: AOwi7QDtJ/ZKqLKkevUSAeY+aFQVR/qxy6PzJNVNCDMwfY5pzAb5j9496l0piVNM+kT3E4w1f6aEzg==
X-Received: by 10.55.16.74 with SMTP id a71mr20767203qkh.170.1505740046527;
        Mon, 18 Sep 2017 06:07:26 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id h4sm323038qth.75.2017.09.18.06.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2017 06:07:25 -0700 (PDT)
Subject: Re: [PATCH v6 04/12] fsmonitor: teach git to optionally utilize a
 file system monitor to speed up detecting new or changed files.
To:     David Turner <David.Turner@twosigma.com>,
        'Ben Peart' <benpeart@microsoft.com>
Cc:     "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-5-benpeart@microsoft.com>
 <850c2ad20acc4c14be87a767af851b19@exmbdft7.ad.twosigma.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <3e0d003e-0643-0359-35fd-a5ecf9b751c3@gmail.com>
Date:   Mon, 18 Sep 2017 09:07:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <850c2ad20acc4c14be87a767af851b19@exmbdft7.ad.twosigma.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for taking the time to review/provide feedback!

On 9/15/2017 5:35 PM, David Turner wrote:
>> -----Original Message-----
>> From: Ben Peart [mailto:benpeart@microsoft.com]
>> Sent: Friday, September 15, 2017 3:21 PM
>> To: benpeart@microsoft.com
>> Cc: David Turner <David.Turner@twosigma.com>; avarab@gmail.com;
>> christian.couder@gmail.com; git@vger.kernel.org; gitster@pobox.com;
>> johannes.schindelin@gmx.de; pclouds@gmail.com; peff@peff.net
>> Subject: [PATCH v6 04/12] fsmonitor: teach git to optionally utilize a file system
>> monitor to speed up detecting new or changed files.
>   
>> +int git_config_get_fsmonitor(void)
>> +{
>> +	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
>> +		core_fsmonitor = getenv("GIT_FSMONITOR_TEST");
>> +
>> +	if (core_fsmonitor && !*core_fsmonitor)
>> +		core_fsmonitor = NULL;
>> +
>> +	if (core_fsmonitor)
>> +		return 1;
>> +
>> +	return 0;
>> +}
> 
> This functions return values are backwards relative to the rest of the git_config_* functions.

I'm confused.  If core.fsmonitor is configured, it returns 1. If it is 
not configured, it returns 0. I don't make use of the -1 /* default 
value */ option as I didn't see any use/value in this case. What is 
backwards?

> 
> [snip]
> 
> +>	/*
> +>	 * With fsmonitor, we can trust the untracked cache's valid field.
> +>	 */
> 

Did you intend to make a comment here?

> [snip]
> 
>> +int read_fsmonitor_extension(struct index_state *istate, const void *data,
>> +	unsigned long sz)
>> +{
> 
> If git_config_get_fsmonitor returns 0, fsmonitor_dirty will leak.
> 

Good catch!  Thank you.

> [snip]
> 
>> +	/* a fsmonitor process can return '*' to indicate all entries are invalid */
> 
> That's not documented in your documentation.  Also, I'm not sure I like it: what
> if I have a file whose name starts with '*'?  Yeah, that would be silly, but this indicates the need
> for the protocol to have some sort of signaling mechanism that's out-of-band  Maybe
> have some key\0value\0 pairs and then \0\0 and then the list of files?  Or, if you want to keep
> it really simple, allow an entry of '/' (which is an invalid filename) to mean 'all'.
> 

Yea, this was an optimization I added late in the game to get around an 
issue in Watchman where it returns the name of every file the first time 
you query it (rather than the set of files that have actually changed 
since the requested time).

I didn't realize the wild card '*' was a valid character for a filename. 
  I'll switch to '/' as you suggest as I don't want to complicate things 
unnecessarily to handle this relatively rare optimization.  I'll also 
get it documented properly.  Thanks!

>> +void add_fsmonitor(struct index_state *istate) {
>> +	int i;
>> +
>> +	if (!istate->fsmonitor_last_update) {
> [snip]
>> +		/* reset the untracked cache */
> 
> Is this really necessary?  Shouldn't the untracked cache be in a correct state already?
> 

When fsmonitor is not turned on, I'm not explicitly invalidating 
untracked cache directory entries as git makes changes to files. While I 
doubt the sequence happens of 1) git making changes to files, *then* 2) 
turning on fsmonitor - I thought it better safe than sorry to assume 
that pattern won't ever happen in the future.  Especially since turning 
on the extension is rare and the cost is low.

>> +/*
>> + * Clear the given cache entries CE_FSMONITOR_VALID bit and invalidate
> 
> Nit: "s/entries/entry's/".
>   
> 
