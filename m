Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D504020248
	for <e@80x24.org>; Thu, 21 Mar 2019 04:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfCUEV6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 00:21:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39761 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfCUEV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 00:21:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so5070252wrn.6
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 21:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rKP02sDPmQhP1UiDRiz6Vbg4VI8wU6+4wCtS30VHRrY=;
        b=cnqUX9zjsBmMNj0IyYPE6aAiRca18coUGEl63QEquvnw0D1IEnHU6EK6jmE0rY74e8
         0QrVWXYbByamUjlnA9ZwH9CRS9A/q6bmt4HmtIZeGrZyg7Wr+JszZPF5LJKVJomKqChU
         t6dyL7DA6ZkY63Sydix0oyiEtRv6qrMizY9tFQiCAHZtTXMBIpgaCZbHSEGUs7IO/RZz
         dkeNnX1Kq+KnvF1SCAQT4zUwzJ6s5sOqOOHMYOMkBfIqB/V5IvaX1ReQIjm5o8iGx1ZD
         yD8s/48y4udncEf6AvpVE//n6Np996w3mS8CPGIXLqqrcYxrDkp5AyIX30avUBlLzJ+A
         x6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rKP02sDPmQhP1UiDRiz6Vbg4VI8wU6+4wCtS30VHRrY=;
        b=JDmzo5mHEli7XZ/zOKkM551jtqEQfInPf7/+DwLmYgdJGmANm+lQS7Vs1xklXgLirl
         OT2k2F5dEizFFLfVNcWDatOCRgTRgcvrwOx8JUwgn9iBUK+PLTEl+gtwdVZUj7ey+GJc
         +ms5z8P1CBHj7dfPdB4bZx4XEH//TatRiWWbdjORUHfzaPVHuo+3rh1iEMYC6nj2O3I/
         NqEoCJ4UEORJPd6aRU/2RdCwKQvikORxSwV5E6j4yO0fyGyNYBy2/wa8XwdP2VOeClLP
         SA1xnJSLLJ47zoHh0/vfNMs8RMvWhzO9HAX+MVFC9JLi9R8UMYYZc1jZBO7dazwsgMm6
         dZSQ==
X-Gm-Message-State: APjAAAVhStk51JZmbdRqb2t6u/JHTyMCetfpMd6mtwCOdNbRa4i6YxLW
        P58lAZc8leUSuYjdu4aoqlk=
X-Google-Smtp-Source: APXvYqxIpgUJs31lU8EPIDGnXNB7/aHN0GO96Pq9be6KmSghWFN3UfEguRsquBdcf102xiLlmySYvw==
X-Received: by 2002:adf:e288:: with SMTP id v8mr922929wri.7.1553142116665;
        Wed, 20 Mar 2019 21:21:56 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a9sm4718750wrt.29.2019.03.20.21.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 21:21:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 08/11] rebase -i: use struct rebase_options to parse args
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
        <20190319190317.6632-9-phillip.wood123@gmail.com>
Date:   Thu, 21 Mar 2019 13:21:53 +0900
In-Reply-To: <20190319190317.6632-9-phillip.wood123@gmail.com> (Phillip Wood's
        message of "Tue, 19 Mar 2019 19:03:14 +0000")
Message-ID: <xmqqwokssvq6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> +static struct replay_opts get_replay_opts(const struct rebase_options *opts)
> +{
> +	struct replay_opts replay = REPLAY_OPTS_INIT;
> +
> +	sequencer_init_config(&replay);
> +
> +	replay.action = REPLAY_INTERACTIVE_REBASE;
> +	replay.signoff = opts->signoff;
> +	replay.allow_ff = !(opts->flags & REBASE_FORCE);
> +	if (opts->allow_rerere_autoupdate)
> +		replay.allow_rerere_auto = opts->allow_rerere_autoupdate;
> +	replay.allow_empty = 1;
> +	replay.allow_empty_message = opts->allow_empty_message;
> +	replay.verbose = opts->flags & REBASE_VERBOSE;
> +	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
> +	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
> +	replay.strategy = opts->strategy;
> +
> +	return replay;
> +}

This calls init_config() and then sets .action; does it revert to
what dl/merge-cleanup-scissors-fix wants to do, which flipped the
order to fix some bug?  It is a bit hard to tell.

Unfortunately because of the earlier huge code movement the changes
to _this_ file does not conflict and cleanly merges, but because the
other file is removed by this series while a topic in flight updates
it, the semantic conflict like this luckily gets discovered.

Especially since this is still an RFC, I'd preferred to see it
without moving around the code too much (instead, exporting some
symbols that need to be visible with each other after renaming them
to more appropriate names that are fit in the global namespace).
