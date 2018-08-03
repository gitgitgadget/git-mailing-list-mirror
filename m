Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC74E1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 20:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbeHCWYD (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 18:24:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46445 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbeHCWYC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 18:24:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id h14-v6so6451160wrw.13
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 13:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=St7oje6p7ZZhfsZI4iJ4sg+cLKAZamwrsUMxJ4m+bcg=;
        b=Eahq6EimXcUkLt/DssXlNy/aPr0FzwmO3V7whNr5Afj0fh2w3736vFvLZClxsJjYcX
         xHcnI5uXWeg0SPCr96mmekLYx+k/TtNlN1hlEzfuAILxY6UXrnuZq16yHiH0KHllnAFM
         hcCJ/nCdUINHq88wOn1/HwT0bccIMmhyPd635uqmqh6eIKNNEIX4SXfnpn3lLnNoYH4E
         ITjRp/nvMmHPeYJuFnv/ADxlGckJ760ODgWiOYFhaRi7ciOZUj+0yuQbD0WE9zAQneU9
         PwKffxKpHxBQsLWAzJ4pkVdcM+CpCFLC6PHDsPVf6vf9jwFvjxSTq1tWqUPH1frp6Fb9
         jPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=St7oje6p7ZZhfsZI4iJ4sg+cLKAZamwrsUMxJ4m+bcg=;
        b=DNcj1EoD4UeryE1SdWaYL1cM3M3ypJuvLpsM3zF0hVq1gk7HlXq+2VxAF/7wXBJggR
         zH/G39HgL3Toj/X7tuOUgSIu/UkLnVsjLBwJAj01oZNzn1acHwD0mvdTSLnkR9kNQ8LV
         7nEFtDWye8nMxjjuWGV7MBQa8ojjW/gqM7p5WhqxWm+ohLnBuC7/FRE8SZQO9bbwehew
         TsG2pe1bRS0Q37TPTgFVbNftifDcWPWEwYlJBTJA98am7D0PRk6UpXETDTSALCjQAVuC
         4HCcmFi2YRtynRd2vWMwD68gGJliCDObFicjC8D/XdZtR2NPbiVKSzp7uYYXyLMuSI0c
         za0Q==
X-Gm-Message-State: AOUpUlGL9MtMdylIO/4gCux3wdKvnCDfNVmnfa//QSltI8NJOJJGD0Df
        Mb1mDH0XUfhR3/EcUYIuywxxo0IC
X-Google-Smtp-Source: AAOMgpc+x8WW+X4QNFyuQNkiu1qqkADD8iUYOu+eLYS/pqyCYXVyMaY1KGToMgO1yG2KjkxX0YRXtA==
X-Received: by 2002:adf:9e84:: with SMTP id a4-v6mr3474304wrf.70.1533327971341;
        Fri, 03 Aug 2018 13:26:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h7-v6sm4161920wrs.8.2018.08.03.13.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 13:26:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] rebase --exec: make it work with --rebase-merges
References: <pull.13.git.gitgitgadget@gmail.com>
        <b29c4d979f147f38bc0a4765a953a748eec0cd6d.1533318123.git.gitgitgadget@gmail.com>
Date:   Fri, 03 Aug 2018 13:26:09 -0700
In-Reply-To: <b29c4d979f147f38bc0a4765a953a748eec0cd6d.1533318123.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 03 Aug 2018
        10:42:08 -0700 (PDT)")
Message-ID: <xmqqa7q3w61q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +	/*
> +	 * Insert <commands> after every pick. Here, fixup/squash chains
> +	 * are considered part of the pick, so we insert the commands *after*
> +	 * those chains if there are any.
> +	 */
> +	insert_final_commands = 1;
> +	for (i = 0; i < todo_list.nr; ) {
> +		enum todo_command command = todo_list.items[i].command;
> +		int j = 0;
> + ...
> +		/* skip fixup/squash chain, if any */
> +		for (i++; i < todo_list.nr; i++, j = 0) {

Does 'j' need to be reset to 0 in each iteration?  Nobody looks at
'j' after exiting this inner loop, and every referernce to 'j'
inside this inner loop happens _after_ it gets assigned "i+1" at the
beginning of "skip comment" loop.

For that matter, I wonder if 'j' can be a variable local to this
inner loop, not the outer loop that iterates over todo_list.items[].

> +			command = todo_list.items[i].command;
> +
> +			if (is_fixup(command))
> +				continue;
> +
> +			if (command != TODO_COMMENT)
> +				break;
> +
> +			/* skip comment if followed by any fixup/squash */
> +			for (j = i + 1; j < todo_list.nr; j++)
> +				if (todo_list.items[j].command != TODO_COMMENT)
> +					break;
> +			if (j < todo_list.nr &&
> +			    is_fixup(todo_list.items[j].command)) {
> +				i = j;
> +				continue;
> +			}
> +			break;
>  		}
