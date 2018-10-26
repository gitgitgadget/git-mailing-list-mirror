Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1E9B1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 01:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeJZKB0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 06:01:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35303 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeJZKB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 06:01:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id w5-v6so11162286wrt.2
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 18:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=H1+UHSodjUDN3OXi7JK86TAtQ3QFS5U2VPoxZrqxWeo=;
        b=TH/gJLbM68GETbqLRNbYSjBnz4CRVzdpWFJWBteUalcDzbJK2RRmuEp9RPc7KJ5ALH
         2SCjcqu1qvHgNzApEviKsvwvOV55AFDv8utW5nFXxVn97CiBXugmyV7MjkZl6hoddl9u
         FLNghorfTdlTQONad2yoNrAVvxQY/iwrdzo7N08XMDaOkwVP4PPdqK4/MmxPFQD+ItJi
         cpNYKdWhhwfmALa5h5/LhJKS7/GRWOyCPIGL3SKXmWzTKBM1rzbsgzXrlrQjT1l2v10P
         Oj5zkeqJhnMwct2l/YleU14i3XOXqG/bXqcFswNIlLknCy3TtiTP4uDi+ORU3khNsIYV
         7UVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=H1+UHSodjUDN3OXi7JK86TAtQ3QFS5U2VPoxZrqxWeo=;
        b=BKPB7Gpq4Y85ukaLddZgwwIy3ZcWsffhXFROIQfJ2a8g/YcNEpD/+KuoUjLZsVCKu3
         gq56aG5KgTQWRETlZBFTzKTRWJXalPd4Yip1unPuhYmqCgbaVFURmAhKjFK5XGZeU3qK
         iKolXnTQDeRUbq0LZbUX+pZ9nzK9Yb7IgEJyvwduc02RDhFfVGOnCQIp1QEAXwQ/t86B
         xvRk8KCZEkvnQL0GCCifm2vq4cJwk40+yPiT4qqqJvsOKq/wMGWZh0DBCdrdGga/G0i9
         ZZBUA48KpAnBksX1tnEW0q4TD7u38uVmcjgdC0yYIhvDhnRqGrv25Y0vUVG+eQ/c7TBV
         CjYw==
X-Gm-Message-State: AGRZ1gJc1NT700eMgr4TFQpDH5nIU+BNMNA64Wt94GLpKd/KYQg5T0GD
        mcLUE3QhK2QQ8gW1980H7Oub/3Aa8qU=
X-Google-Smtp-Source: AJdET5dVM8428DV4iH0Kcctt2z5tLZJYHzCdd7oNIiAI0WPFyL8ImSbnGuOLWmmdSaaNohznFpQ6oQ==
X-Received: by 2002:adf:db0f:: with SMTP id s15-v6mr3721204wri.129.1540517187373;
        Thu, 25 Oct 2018 18:26:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e12-v6sm3361535wrw.82.2018.10.25.18.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 18:26:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH 3/2] rebase -i: recognize short commands without arguments
References: <pull.43.v2.git.gitgitgadget@gmail.com>
        <pull.43.v3.git.gitgitgadget@gmail.com>
        <fff6fec5-88c9-4125-bf51-5e96e34bf1f6@kdbg.org>
Date:   Fri, 26 Oct 2018 10:26:25 +0900
In-Reply-To: <fff6fec5-88c9-4125-bf51-5e96e34bf1f6@kdbg.org> (Johannes Sixt's
        message of "Thu, 25 Oct 2018 22:47:45 +0200")
Message-ID: <xmqq1s8dfqgu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> The sequencer instruction 'b', short for 'break', is rejected:
>
>   error: invalid line 2: b
>
> The reason is that the parser expects all short commands to have
> an argument. Permit short commands without arguments.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  I'll send a another patch in a moment that tests all short
>  sequencer commands, but it is independent from this topic.
>
>  sequencer.c                | 3 ++-
>  t/lib-rebase.sh            | 2 +-
>  t/t3418-rebase-continue.sh | 4 +++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index ee3961ec63..3107f59ea7 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1954,7 +1954,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>  		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
>  			item->command = i;
>  			break;
> -		} else if (bol[1] == ' ' && *bol == todo_command_info[i].c) {
> +		} else if ((bol + 1 == eol || bol[1] == ' ') &&
> +			   *bol == todo_command_info[i].c) {
>  			bol++;
>  			item->command = i;
>  			break;
> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index 584604ee63..86572438ec 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -49,7 +49,7 @@ set_fake_editor () {
>  		case $line in
>  		squash|fixup|edit|reword|drop)
>  			action="$line";;
> -		exec*|break)
> +		exec*|break|b)
>  			echo "$line" | sed 's/_/ /g' >> "$1";;
>  		"#")
>  			echo '# comment' >> "$1";;
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index 185a491089..b282505aac 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -243,7 +243,9 @@ unset GIT_SEQUENCE_EDITOR
>  
>  test_expect_success 'the todo command "break" works' '
>  	rm -f execed &&
> -	FAKE_LINES="break exec_>execed" git rebase -i HEAD &&
> +	FAKE_LINES="break b exec_>execed" git rebase -i HEAD &&
> +	test_path_is_missing execed &&

When first 'break' hits, "git rebase -i" shouldn't have exited with
non-zero, and we get to see if execed is there (it shouldn't exist
yet).

> +	git rebase --continue &&

And then we continue, to hit the next 'b', which shouldn't barf,
either, and then

>  	test_path_is_missing execed &&

we make sure execed is not yet there, before continuing out of that
that 'b'roken state

>  	git rebase --continue &&

and then we'll hit the exec to create that file.

>  	test_path_is_file execed

Makes sense.  Thanks.
