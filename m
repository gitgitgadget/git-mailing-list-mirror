Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A6501F597
	for <e@80x24.org>; Sun,  5 Aug 2018 01:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725729AbeHEEB6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 00:01:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43100 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725721AbeHEEB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 00:01:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id d17-v6so4589493pgv.10
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 18:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j9mVjZH/9LT/LvEExjg0HIX9Sdx54FWye/yyHeUV/4A=;
        b=m9ymM+lt5FfJrP9eWsSJUAxLJAmNhHpk9PhbICXEuILl8vfhl6e4OYBzf6300HqNLN
         3j7xvD0CJsWzCi9WquKlNejh4BwZabsuNJxUZMCRJLehroGiziFng/yJdvnuVc17kaYK
         Fcr1K84wraGlWQ7tP4NwN7pqM7FpsFMj1BiyiXfiv1qnIKXZdDmBHU/EvODjcR3PcwMd
         B/CGpE0Jp8gm/FiT5vfY5HT2NUSQODfvQ3E0PUINdlV/oMJhc/jeOJqzg/rH/t+BzWB3
         W+b4/WYdbN5gwFXwDyKe3+ys65Xvqw1U9QZd3MG2SX8K2d1I+iiMKrG1oaRAHIdb5qKP
         P2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j9mVjZH/9LT/LvEExjg0HIX9Sdx54FWye/yyHeUV/4A=;
        b=CcfNIrgw3mx6tXZVT1YvJwiTi6uw7b06XroCKlSs4QulwFqN8RwIVSOgU27y3XIOb6
         RCb99WjhhrfpR2c//gqgHpGzjMuY12hp+ph2flwrHtn3L4Y6VZVl6S46Kk2N9Qw/ujiY
         RygT413n1grggp0mC8wYUPpS57BdEXrzrdKZYXpNTntP9YErET2whwYphPQ1sacEkZym
         UU04nLgekoDSP/emKcKyhyrb/LJZukHntKZxK9pyma9VwC7PmSR6C85WU3HNxZqAfHTS
         8/ADUBNum3ayYz7g/KAtVTTgNH7eoNWP2jJo1AzNpxeI+YaSlZs1MLfESZOAKACl9G03
         d7Rw==
X-Gm-Message-State: AOUpUlE9XXmLfCPRfSPPz5q/OSk8Z1o4sBqk0ZFhsCfjnVHRe7MdEJ54
        Rslxfz+5lyU2UcVxK9Yw90295v4k
X-Google-Smtp-Source: AAOMgpckHuevQ7DHD2SX2Pif23Sp96Hx+NoDCUylCE1JpYCw3AB1vMkME8u0ZQAOjoks9bzd388+Sg==
X-Received: by 2002:a63:1f4d:: with SMTP id q13-v6mr9406411pgm.241.1533434350638;
        Sat, 04 Aug 2018 18:59:10 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j22-v6sm10824506pfh.45.2018.08.04.18.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 18:59:10 -0700 (PDT)
Date:   Sat, 4 Aug 2018 18:59:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] line-log: demonstrate a bug with nearly-overlapping
 ranges
Message-ID: <20180805015908.GE258270@aiede.svl.corp.google.com>
References: <pull.15.git.gitgitgadget@gmail.com>
 <cab7bb36eb85dbe38ad95ee02b083f11f0820e24.1533421100.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cab7bb36eb85dbe38ad95ee02b083f11f0820e24.1533421100.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:

> Currently, this test case throws an assertion:
>
> 	Assertion failed!
>
> 	Program: git.exe
> 	File: line-log.c, Line 71
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t4211-line-log.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Thanks for finding and demonstrating it.  Can you say more about what
is going on in the test case?  Alternatively, could it be squashed in
with the patch that fixes it?

The below will be more nitpicky:

[...]
> --- a/t/t4211-line-log.sh
> +++ b/t/t4211-line-log.sh
> @@ -115,4 +115,21 @@ test_expect_success 'range_set_union' '
>  	git log $(for x in $(test_seq 200); do echo -L $((2*x)),+1:c.c; done)
>  '
>  
> +q_to_lf () {
> +	tr Q '\012'
> +}
> +
> +test_expect_failure 'close to overlapping ranges' '
> +	test_seq 5 >a1.c &&
> +	git add a1.c &&
> +	git commit -m "5 lines" a1.c &&

It would be nice to use test_tick or test_commit for a more realistic
history (with time marching forward).

> +	sed s/3/3QaQb/ <a1.c | q_to_lf >tmp &&
> +	mv tmp a1.c &&
> +	git commit -m "2 more lines" a1.c &&

It's probably just me, but the bit with Q makes it hard for me to
follow.  Maybe there's a simpler way?

"sed -e '3aa' -e '3ab'" works here, but I don't know how portable it
is. I'd be more tempted to do

	test_write_lines 1 2 3 4 5 >a1.c &&
	...

	test_write_lines 1 2 3 a b 4 5 >a1.c &&
	...

	test_write_lines 1 2 3 a b c 4 5 >a1.c &&
	...

which is concise and has obvious behavior.

Thanks and hope that helps,
Jonathan
