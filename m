Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1140B1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 18:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbeI3Axu (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 20:53:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37349 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeI3Axu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 20:53:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id y26-v6so5031025wma.2
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 11:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=plVyqJkFLnrhmU40FmAFsQxL4B56PMBUjkCigW1sj9o=;
        b=ImI6ca+uRTKKs0Hi+L0JyIzCO4J3F1vsysBFJMeRPKSLuNCPzT4KmqWMoyT06KpMz2
         yWAXVOb+BNVLFWdtYHzhEO7CFB5QBERKvXSNFsenX29mJsR8L5HBmVulqhPIqbRdsYnL
         SJHQQXOnLpfY0OmQaOA5SZ747mB5RUInsG39UFp8JgnVmJI1kTjd7SWu7f6ko7kK66ty
         ngkQuS51n402hWrlegBCCc4MNPn5D19AivfbG5+pcM+I6Vtq00jQx4s1914+320JLKjt
         rnG9dFEBIhHO8MjOZdoztbULm5FzBtu/Aha8nQ3tLaeU0iKP3RuPjd1KZfcwXsBT5oZk
         4q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=plVyqJkFLnrhmU40FmAFsQxL4B56PMBUjkCigW1sj9o=;
        b=ldF+Fl9VKkkfJMcXtqUQt8MN6NDEqToortL+cNjLiGXEyuAMS3pONeOw/nO8erVvWk
         QsmWfNtP4APtvrzPYDcVrOrxSj7TD3asVdz3SEasFGiYdyPndzSVhcRGtvlQyINQ+YEs
         YR51yyp2LxVVVpywxRlg2PDWPrWP+F0lJ7LkW6WPxaa8RqnLN/JHLVLpGu+nlqPGE2Uq
         QdfHGMP4KNWaY298XHrCSX/1kaFmFa4kXRo58S/qQzTUjTdkGGZXL5736YrUefzPMwZ6
         bSB0GnTQ22YHtZB3s9EBlILO3GZnM9K1uS04mMeSwQyq0VHwhr/7X9xePSDLIF6EULZx
         mJ/w==
X-Gm-Message-State: ABuFfoicEBvVg1vs4fMSt2miqbzKQ9H1MOg6SnWYxAPVwferbHpnNc7a
        LvKwej7KpeZ2ZYpYpeWcEkDEMXwi
X-Google-Smtp-Source: ACcGV60XV14kSb8sjrMsPURoVshcIFjzghJziMPRZbrZgf762NLURsP1DHRWeD7nhiemcf5e+9XcwQ==
X-Received: by 2002:a1c:5d54:: with SMTP id r81-v6mr4628171wmb.88.1538245463249;
        Sat, 29 Sep 2018 11:24:23 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a105-v6sm20726330wrc.23.2018.09.29.11.24.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 11:24:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v6 3/7] eoie: add End of Index Entry (EOIE) extension
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20180926195442.1380-1-benpeart@microsoft.com>
        <20180926195442.1380-4-benpeart@microsoft.com>
        <20180929054520.GA21901@duynguyen.home>
Date:   Sat, 29 Sep 2018 11:24:20 -0700
In-Reply-To: <20180929054520.GA21901@duynguyen.home> (Duy Nguyen's message of
        "Sat, 29 Sep 2018 07:45:20 +0200")
Message-ID: <xmqqzhw088mj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Sep 26, 2018 at 03:54:38PM -0400, Ben Peart wrote:
>> +
>> +#define EOIE_SIZE (4 + GIT_SHA1_RAWSZ) /* <4-byte offset> + <20-byte hash> */
>> +#define EOIE_SIZE_WITH_HEADER (4 + 4 + EOIE_SIZE) /* <4-byte signature> + <4-byte length> + EOIE_SIZE */
>
> If you make these variables instead of macros, you can use
> the_hash_algo, which makes this code sha256-friendlier and probably
> can explain less, e.g. ...
>
>> +
>> +static size_t read_eoie_extension(const char *mmap, size_t mmap_size)
>> +{
>> +	/*
>> +	 * The end of index entries (EOIE) extension is guaranteed to be last
>> +	 * so that it can be found by scanning backwards from the EOF.
>> +	 *
>> +	 * "EOIE"
>> +	 * <4-byte length>
>> +	 * <4-byte offset>
>> +	 * <20-byte hash>

20? ;-)

>> +	 */
>
> 	uint32_t EOIE_SIZE = 4 + the_hash_algo->rawsz;
> 	uint32_t EOIE_SIZE_WITH_HEADER = 4 + 4 + EOIE_SIZE;
>
>> +	const char *index, *eoie;
>> +	uint32_t extsize;
>> +	size_t offset, src_offset;
>> +	unsigned char hash[GIT_MAX_RAWSZ];
>> +	git_hash_ctx c;
> --
> Duy
