Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA8F41F51C
	for <e@80x24.org>; Mon, 21 May 2018 00:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeEUA6H (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 20:58:07 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40580 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeEUA6G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 20:58:06 -0400
Received: by mail-wr0-f195.google.com with SMTP id v60-v6so14338601wrc.7
        for <git@vger.kernel.org>; Sun, 20 May 2018 17:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/OWbWFz8DHPJQNZQE3FAfc8b41bQeFbjQ3DjKqLafio=;
        b=mlVwlI5SwP00mymlliQqrxSmCZPeFiyLdhm5+HDpkb2TL4/vcikNfImrdhbiKyMQQ8
         QOoycCCihtpVR8nnjZ2hyWzRa4kR26zoyPfd+qpX6JpEg3CGP9M+8cWNa7Wk8DN1ilxO
         3mYdTmfAIH8/YEt4pY0tBYq8oWlVNU68tW9IoGHD7GFujZWqGKOoPbtHM7W3Ac+/hzd5
         FVR07UW2VqmWfc2RGGgpiyuhLtYad6cj5HXzPt9Lj+8PZIeNNP7P+68xDr8fICcFzC4h
         7wNoZH5UVsgdKqi1u8rdSKTQyvKI3iF8tZK3qu8XJaPBkUaO4DeApkUIjNs8FOR0i5Mb
         a6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/OWbWFz8DHPJQNZQE3FAfc8b41bQeFbjQ3DjKqLafio=;
        b=ahdmuFh2zfkg6McMelQl6jaSiIatBxxyx8KgG57XYVBBsFKS90iHIFFTz51dxA/XY7
         ZEKtTnqF6fB0HGOaWhsmlgPVI9e7yf1ouSJydxt1+K7MNOYFTXXdcmKldiD1jgll+t5G
         k0KQsBWkYEt8kfmcUO+j0j7Zxe/A9RclHcacTaY7BICmvQJR6gkS9i+Ojddq0s+9k38x
         qBV+NSnOfN3BrcH2/ugv+Uu/4u/bpEwwUxEWxJb+iU1HGJKXSTu5NnEeXGrx8+XIUhL5
         c1ZKOfuLrHgTRyvzLYYZdhDnM3VP2XlovfGzlltHdj9oy0gMsnxyW0jk8hoE2caXLR5i
         F6gw==
X-Gm-Message-State: ALKqPwdC63Zr4XsCj2DhJw3I/iZaL8CO25WLFtCGsRH3CsA5j4zvk7uV
        MepHNBs6f1P+kVb/FtZFAPo=
X-Google-Smtp-Source: AB8JxZojTbbkK6vgHD06uARiqrYdrlUyj2HZb5p0X1eMYlZHCmu6Ocs6fHhuqlTB8M9rnCrtIM/fhw==
X-Received: by 2002:adf:9c01:: with SMTP id f1-v6mr13355741wrc.171.1526864285413;
        Sun, 20 May 2018 17:58:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r3-v6sm16859169wmg.5.2018.05.20.17.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 17:58:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH 3/5] query_fsmonitor: use xsnprintf for formatting integers
References: <20180519015444.GA12080@sigill.intra.peff.net>
        <20180519015758.GC32492@sigill.intra.peff.net>
        <cd6dba3c-19bb-e6c7-0c1f-5cea0c8f9d81@web.de>
Date:   Mon, 21 May 2018 09:58:04 +0900
In-Reply-To: <cd6dba3c-19bb-e6c7-0c1f-5cea0c8f9d81@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 19 May 2018 10:27:46 +0200")
Message-ID: <xmqqmuwt3jvn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> How about this instead?
>
> -- >8 --
> Subject: [PATCH] fsmonitor: use internal argv_array of struct child_process
>
> Avoid magic array sizes and indexes by constructing the fsmonitor
> command line using the embedded argv_array of the child_process.  The
> resulting code is shorter and easier to extend.
>
> Getting rid of the snprintf() calls is a bonus -- even though the
> buffers were big enough here to avoid truncation -- as it makes auditing
> the remaining callers easier.
> ...
> -	if (!(argv[0] = core_fsmonitor))
> +	if (!core_fsmonitor)
>  		return -1;
>  
> -	snprintf(ver, sizeof(ver), "%d", version);

I really like this change, as this exact line used to take
sizeof(version) instead of sizeof(ver), which has been corrected
recently.

> -	snprintf(date, sizeof(date), "%" PRIuMAX, (uintmax_t)last_update);
> -	argv[1] = ver;
> -	argv[2] = date;
> -	argv[3] = NULL;
> -	cp.argv = argv;
> +	argv_array_push(&cp.args, core_fsmonitor);
> +	argv_array_pushf(&cp.args, "%d", version);

If it were written like this from the beginning, such a bug would
never have happened ;-)

> +	argv_array_pushf(&cp.args, "%" PRIuMAX, (uintmax_t)last_update);
>  	cp.use_shell = 1;
>  	cp.dir = get_git_work_tree();
